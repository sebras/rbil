Interrupt List, part 2 of 5
This compilation is Copyright (c) 1989,1990,1991 Ralf Brown
----------1500-------------------------------
INT 15 - CASSETTE - TURN ON TAPE DRIVE'S MOTOR (PC and PCjr only)
	AH = 00h
Return: CF set on error
	    AH = 86h no cassette present
	CF clear if successful
SeeAlso: AH=01h"CASSETTE"
----------1500-------------------------------
INT 15 - Amstrad PC1512 - GET AND RESET MOUSE COUNTS
	AH = 00h
Return: CX = signed X count
	DX = signed Y count
----------1500-------------------------------
INT 15 - VMiX v2+ - INSTALLATION CHECK???
	AH = 00h
Return: DX = 0798h???
----------1500-------------------------------
INT 15 - MultiDOS Plus - GIVE UP TIME SLICE
	AH = 00h
Note:	if issued by the highest-priority task while MultiDOS is using
	  priority-based rather than round-robin scheduling, control will be
	  returned to the caller immediately
SeeAlso: AH=03h"MultiDOS",AX=1000h
----------1501-------------------------------
INT 15 - CASSETTE - TURN OFF TAPE DRIVE'S MOTOR (PC and PCjr only)
	AH = 01h
Return: CF set on error
	    AH = 86h no cassette present
	CF clear if successful
SeeAlso: AH=00h"CASSETTE"
----------1501-------------------------------
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
		    6-4: time base speed, default 010 = 32768 Hz
		    3-0: interrupt rate selection, default 0110 = 1024 Hz
 0Bh	BYTE	RTC status register B
		bit 7: clear if normal update, set if abort update
		    6: periodic interrupt enable
		    5: alarm interrupt enable
		    4: update end interrupt enable
		    3: square wave enable
		    2: date mode (clear = BCD, set = binary)
		    1: 24-hour format
		    0: daylight saving time enable
 0Ch	BYTE	RTC status register C (read-only)
		bit 7: IRQF flag
		    6: PF flag
		    5: AF flag
		    4: UF flag
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
----------1501-------------------------------
INT 15 - VMiX - I/O CHANNEL OBJECT MANAGER
	AH = 01h
	STACK: WORD  object ID of requestor
	       DWORD pointer to name of requested method
	       WORD  arg1
	       WORD  arg2
	       WORD  arg3
	       WORD  arg4
Return: DX:AX??? -> IRP structure or 0000h:0000h 
----------1501-------------------------------
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
----------1502-------------------------------
INT 15 - CASSETTE - READ DATA
	AH = 02h
	CX = number of bytes to read
	ES:BX -> buffer
Return:	CF clear if successful
	    DX = number of bytes read
	    ES:BX -> byte following last byte read
	CF set on error
	AH = status
	    00h successful
	    01h CRC error
	    02h bad tape signals
	    04h no data
	    80h invalid command
	    86h no cassette present
SeeAlso: AH=00h"CASSETTE",AH=03h"CASSETTE"
----------1502-------------------------------
INT 15 - Amstrad PC1512 - READ DATA FROM NON-VOLATILE RAM
	AH = 02h
	AL = NVRAM location (00h to 3Fh)
Return: AH = return code
	    00h OK
	    01h address bad
	    02h checksum error
	AL = NVRAM data value
SeeAlso: AH=01h"Amstrad"
----------1502-------------------------------
INT 15 - VMiX - MEMORY OBJECT MANAGER
	AH = 02h
	STACK:	WORD	object ID of requestor
		DWORD	pointer to name of requested method
		WORD	arg1
		WORD	arg2
		WORD	arg3
		WORD	arg4
		WORD	arg5
Return: DX:AX??? = pointer to memory block
----------1502-------------------------------
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
----------1503-------------------------------
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
----------1503-------------------------------
INT 15 - Amstrad PC1512 - WRITE VDU COLOR PLANE WRITE REGISTER
	AH = 03h
	AL = value (I,R,G,B bits)
SeeAlso: AH=04h"Amstrad"
----------1503-------------------------------
INT 15 - VMiX - PROMPTED CONSOLE INPUT
	AH = 03h
	STACK:	DWORD	pointer to ASCII prompt
		WORD	field outline character
		WORD	length of input field
		DWORD	address of pointer to input buffer
		WORD	number of characters input
Return: AX = length of input (input buffer is padded with blanks)
----------1503-------------------------------
INT 15 - MultiDOS Plus - SUSPEND TASK FOR INTERVAL
	AH = 03h
	DX = number of time slices to remain suspended
Return: after specified interval has elapsed
Note:	when priority-based scheduling is in use, high-priority tasks should
	  use this function to yield the processor
SeeAlso: AH=00h"MultiDOS",AH=0Ah"MultiDOS"
----------1504-------------------------------
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
----------1504-------------------------------
INT 15 - Amstrad PC1512 - WRITE VDU COLOR PLANE READ REGISTER
	AH = 04h
	AL = value (RDSEL1 and RDSEL0)
SeeAlso: AH=03h"Amstrad",05h"Amstrad"
----------1504-------------------------------
INT 15 - VMiX - VPRINTF
	AH = 04h
	STACK:	DWORD	control string
		DWORD	array of arguments
----------1504-------------------------------
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
----------1505-------------------------------
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
----------1505-------------------------------
INT 15 - Amstrad PC1512 - WRITE VDU GRAPHICS BORDER REGISTER
	AH = 05h
	AL = value (I,R,G,B bits)
SeeAlso: AH=04h"Amstrad"
----------1505-------------------------------
INT 15 - VMiX - GET PROCESS ID OF CURRENT PROCESS
	AH = 05h
Return: AX = process ID
SeeAlso: AH=06h"VMiX",AH=0Bh"VMiX"
----------1505-------------------------------
INT 15 - MultiDOS Plus - CHECK MAILBOX
	AH = 05h
	AL = mailbox number (00h-3Fh)
Return: AH = status
	    00h successful
	        DX = length of first message in queue, 0000h if no message
	    02h invalid mailbox number
SeeAlso: AH=04h"MultiDOS",AH=06h"MultiDOS"
----------1506-------------------------------
INT 15 - Amstrad PC1512 - GET ROS VERSION NUMBER
	AH = 06h
Return: BX = version number
----------1506-------------------------------
INT 15 - VMiX - GET POINTER TO PROCESS CONTROL BLOCK
	AH = 06h
	STACK:	WORD	process ID
Return: DX:AX??? -> process control block
SeeAlso: AH=07h"VMiX",AH=08h"VMiX"
----------1506-------------------------------
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
----------1507-------------------------------
INT 15 - VMiX - GET POINTER TO OBJECT CONTROL BLOCK
	AH = 07h
	STACK:	WORD	object type
Return: DX:AX??? -> object control block
SeeAlso: AH=06h"VMiX",AH=08h"VMiX"
----------1507-------------------------------
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
----------1508-------------------------------
INT 15 - VMiX - GET CHANNEL CONTROL BLOCK
	AH = 08h
	STACK:	WORD	channel ID
Return: DX:AX??? -> channel control block
SeeAlso: AH=06h"VMiX",AH=07h"VMiX"
----------1508-------------------------------
INT 15 - MultiDOS Plus - TERMINATE INTERNAL TASK (KILL THREAD)
	AH = 08h
Return: calling task terminated, so execution never returns to caller
Notes:	an internal task must be terminated with this function rather than a
	  DOS termination function
	task's stack space is returned to parent task's memory pool
SeeAlso: AH=07h"MultiDOS"
----------1509-------------------------------
INT 15 - VMiX - GET ID OF QUEUED ELEMENT
	AH = 09h
	STACK:	WORD	queue ID (0 = process queue, 1 = object, 3 = type)
		WORD	subqueue ID
Return: AX = ID
SeeAlso: AH=0Ah"VMiX"
----------1509-------------------------------
INT 15 - MultiDOS Plus - CHANGE TASK'S PRIORITY
	AH = 09h
	AL = new priority
Note:	the priority has different meanings depending on whether priority-
	  based or round-robin scheduling is used
SeeAlso: AH=07h"MultiDOS"
----------150A-------------------------------
INT 15 - VMiX - GET ID OF NEXT QUEUED ELEMENT
	AH = 0Ah
	STACK:	WORD	queue ID (0 = process queue, 1 = object, 3 = type)
		WORD	ID of current element in queue chain
Return: AX = ID of next element
SeeAlso: AH=09h"VMiX",AH=0Fh"VMiX"
----------150A-------------------------------
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
----------150B-------------------------------
INT 15 - VMiX - GET TOTAL NUMBER OF ACTIVE PROCESSES
	AH = 0Bh
Return: AX = number of active processes
SeeAlso: AH=05h"VMiX",AH=0Eh"VMiX"
----------150B-------------------------------
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
----------150C-------------------------------
INT 15 - VMiX - GET POINTER TO PROCESS TSS STACK
	AH = 0Ch
	STACK:	WORD	process ID
Return: DX:AX??? -> TSS stack store
----------150C-------------------------------
INT 15 - MultiDOS Plus - RESTORE OLD VIDEO DISPLAY MEMORY
	AH = 0Ch
Note:	restores task's screen pointer saved by AH=0Bh; must not be called
	  unless AH=0Bh has been called first
SeeAlso: AH=0Bh"MultiDOS"
----------150D-------------------------------
INT 15 - VMiX - START A CHILD PROCESS JOB SHELL
	AH = 0Dh
	STACK:	DWORD	ASCIZ string starting with requested I/O channel and
			followed by standard VMiX shell command string
Return: AX = status
SeeAlso: AH=0Eh"VMIX"
----------150D-------------------------------
INT 15 - MultiDOS Plus - DISABLE MULTITASKING
	AH = 0Dh
Note:	calling task receives all time slices until AH=0Eh is called; this
	  allows time-critical events or nonreentrant code to be processed
SeeAlso: AH=0Eh"MultiDOS",AH=10h"MultiDOS",AX=101Bh,AH=20h"MultiDOS"
----------150E-------------------------------
INT 15 - VMiX - TERMINATE PROCESS
	AH = 0Eh
	STACK:	WORD	process ID
Return: AX = status
SeeAlso: AH=0Bh"VMiX",AH=0Dh"VMIX"
----------150E-------------------------------
INT 15 - MultiDOS Plus - ENABLE MULTITASKING
	AH = 0Eh
SeeAlso: AH=0Dh"MultiDOS",AX=101Ch,AH=20h"MultiDOS"
----------150F-------------------------------
INT 15 - SYSTEM - FORMAT UNIT PERIODIC INTERRUPT (PS ESDI drives only)
	AH = 0Fh
	AL = phase code
	    00h reserved
	    01h surface analysis
	    02h formatting
Return: CF clear if formatting should continue, set if it should terminate
Note:	called during ESDI drive formatting after each cylinder is completed
SeeAlso: INT 13/AH=1Ah
----------150F-------------------------------
INT 15 - VMiX - GET KEY FIELD OF QUEUED ELEMENT
	AH = 0Fh
	STACK:	WORD	queue ID (0 = process queue, 1 = object q, 3 = type q)
		WORD	ID of element in queue chain
Return: AX = key
SeeAlso: AH=0Ah"VMiX"
----------150F-------------------------------
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
----------1510-------------------------------
INT 15 - VMiX - EXECUTE FUNCTION IN PROTECTED MODE
	AH = 10h
	STACK:	DWORD	pointer to function
	      N	WORDs	function args
Return: ???
----------1510-------------------------------
INT 15 - MultiDOS Plus - TEST RESOURCE SEMAPHORE
	AH = 10h
	AL = semaphore number (00h-3Fh)
Return: AH = status
	    00h semaphore not in use
	    01h semaphore owned by another task
	    02h invalid semaphore number
	    03h semaphore owned by caller
SeeAlso: AH=02h"MultiDOS",AH=0Dh"MultiDOS",AH=1Dh"MultiDOS"
----------151000-----------------------------
INT 15 - TopView - "PAUSE" - GIVE UP CPU TIME
	AX = 1000h
Return: after other processes run
Note:	under DESQview, if the process issuing this call has hooked INT 08h,
	  the current time-slice is set to expire at the next clock tick rather
	  than immediately
SeeAlso: AH=00h"MultiDOS",INT 21/AH=EEh"DoubleDOS",INT 2F/AX=1680h
SeeAlso: INT 7F/AH=E8h
----------151001-----------------------------
INT 15 - TopView - "GETMEM" - ALLOCATE "SYSTEM" MEMORY
	AX = 1001h
	BX = number of bytes to allocate
Return: ES:DI -> block of memory or 0000h:0000h (DV 2.26+)
Note:	use SETERROR (AX=DE15h) to avoid a user prompt if there is insufficient
	  common memory
SeeAlso: AX=1002h,AX=DE0Ch,AX=DE15h
----------151002-----------------------------
INT 15 - TopView - "PUTMEM" - DEALLOCATE "SYSTEM" MEMORY
	AX = 1002h
	ES:DI -> previously allocated block
Return: block freed
SeeAlso: AX=1001h,AX=DE0Dh
----------151003-----------------------------
INT 15 - TopView - "PRINTC" - DISPLAY CHARACTER/ATTRIBUTE ON SCREEN
	AX = 1003h
	BH = attribute
	BL = character
	DX = segment of object handle for window
Note:	BX=0 does not display anything, it only positions the hardware cursor
----------1510-------------------------------
INT 15 - TopView - UNIMPLEMENTED IN DV 2.x
	AH = 10h
	AL = 04h thru 12h
Return: pops up "Programming error" window in DV 2.x
----------151013-----------------------------
INT 15 - TopView - "GETBIT" - DEFINE A 2ND-LEVEL INTERRUPT HANDLER
	AX = 1013h
	ES:DI -> FAR service routine
Return: BX = bit mask indicating which bit was allocated
	     0000h if no more bits available
SeeAlso: AX=1014h,AX=1015h
Note:	only a few TopView/DESQview API calls are allowed during a hardware
	  interrupt; if other calls need to be made, the interrupt handler
	  must schedule a 2nd-level interrupt with "SETBIT" (AX=1015h)
----------151014-----------------------------
INT 15 - TopView - "FREEBIT" - UNDEFINE A 2ND-LEVEL INTERRUPT HANDLER
	AX = 1014h
	BX = bit mask from INT 15/AX=1013h
SeeAlso: AX=1013h,AX=1015h
----------151015-----------------------------
INT 15 - TopView - "SETBIT" - SCHEDULE ONE OR MORE 2ND-LEVEL INTERRUPTS
	AX = 1015h
	BX = bit mask for interrupts to post
Return: indicated routines will be called: (DV 2.0x) at next task switch
					   (DV 2.2x) immediately
SeeAlso: AX=1013h,AX=1014h
Notes:	this is one of the few TopView calls which are allowed from a hardware
	  interrupt handler
	the handler will be called with ES containing the segment of the handle
	  of the next task to be executed; on return, ES must be the segment of
	  a task handle
----------151016-----------------------------
INT 15 - TopView - "ISOBJ" - VERIFY OBJECT HANDLE
	AX = 1016h
	ES:DI = possible object handle
Return: BX = FFFFh if ES:DI is a valid object handle
	     0000h if ES:DI is not
SeeAlso: AX=DE14h
----------151017-----------------------------
INT 15 - TopView - UNIMPLEMENTED IN DV 2.x
	AX = 1017h
Return: pops up "Programming error" window in DV 2.x
----------151018-----------------------------
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
----------151019-----------------------------
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
SeeAlso: INT 16/AH=73h
----------15101A-----------------------------
INT 15 - TopView - "OSTACK" - SWITCH TO TASK'S INTERNAL STACK
	AX = 101Ah
Return: stack switched
Notes:	this call may not be nested; a second call must be preceded by a call
	  to "USTACK" (AX=1025h)
	while TopView requires many API calls to be executed while on the
	  task's internal stack, DESQview allows those calls to be executed
	  regardless of the current stack
SeeAlso: AX=1025h
----------15101B-----------------------------
INT 15 - TopView - "BEGINC" - BEGIN CRITICAL REGION
	AX = 101Bh
Return: task-switching temporarily disabled
Notes:	will not task-switch until "ENDC" (AX = 101Ch) called unless task
	  voluntarily releases the CPU (upon regaining the CPU, task-switching
	  will again be disabled)
	suspends the caller until DOS is free
SeeAlso: AH=0Dh"MultiDOS",AX=101Ch,AX=DE13h,AX=DE1Ch,INT 2F/AX=1681h
----------15101C-----------------------------
INT 15 - TopView - "ENDC" - END CRITICAL REGION
	AX = 101Ch
Return: task-switching enabled
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=101Bh,AX=DE13h,AX=DE1Bh,INT 2F/AX=1682h
----------15101D-----------------------------
INT 15 - TopView - "STOP" - STOP TASK
	AX = 101Dh
	ES = segment of object handle for task to be stopped
	     (== handle of main window for that task)
Return: indicated task will not get any CPU time until restarted with AX=101Eh
Note:	once a task has been stopped, additional "STOP"s are ignored
BUG:	in DV 2.00, this function is ignored unless the indicated task is the
	  current task
SeeAlso: AX=101Eh,AX=102Bh,AH=12h"VMiX"
----------15101E-----------------------------
INT 15 - TopView - "START" - START TASK
	AX = 101Eh
	ES = segment of object handle for task to be started
	     (== handle of main window for that task)
Return: indicated task is started up again
Note:	once a task has been started, additional "START"s are ignored
SeeAlso: AX=101Dh,AX=102Bh
----------15101F-----------------------------
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
	DS:DI -> text of message
	CH = width of error window (0 = default)
	CL = height of error window (0 = default)
	DX = segment of object handle
Return: BX = status: 1 = left button, 2 = right, 27 = ESC pressed
Note:	window remains on-screen until ESC or indicated mouse button is pressed
----------151020-----------------------------
INT 15 - TopView - UNIMPLEMENTED IN DV 2.0x
	AX = 1020h
Return: pops up "Programming error" window in DV 2.0x
----------151021-----------------------------
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
----------151022-----------------------------
INT 15 - TopView - "GETVER" - GET VERSION
	AX = 1022h
	BX = 0
Return: BX nonzero, TopView or compatible loaded
	(BL = major version, BH = minor version)
Notes:	TaskView returns BX = 0001h, DESQview 2.0 returns BX = 0A01h
----------151023-----------------------------
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
----------151024-----------------------------
INT 15 - TopView - "GETBUF" - GET VIRTUAL SCREEN INFO
	AX = 1024h
	BX = segment of object handle for window
	      (0 = use default)
Return: ES:DI -> virtual screen
	CX = size of virtual screen in bytes
	DL = 00h text screen
	     01h graphics screen
SeeAlso: INT 10/AH=FEh,INT 21/AH=2Bh/CX=4445h
----------151025-----------------------------
INT 15 - TopView - "USTACK" - SWITCH BACK TO USER'S STACK
	AX = 1025h
Return: stack switched back
Notes:	call only after having switched to internal stack with AX=101Ah
	while TopView requires many API calls to be executed while on the
	  task's private stack, DESQview allows those calls to be executed
	  regardless of the current stack
SeeAlso: AX=101Ah
----------1510-------------------------------
INT 15 - DESQview (TopView???) - UNIMPLEMENTED IN DV 2.x
	AH = 10h
	AL = 26h thru 2Ah
Return: pops up "Programming error" window in DV 2.x
----------15102B-----------------------------
INT 15 - DESQview 2.0 (TopView???) - "POSTTASK" - AWAKEN TASK
	AX = 102Bh
	BX = segment of object handle for task
Return: nothing
Note:	forces a task which is waiting on its objectq to continue by placing
	  the handle for the task on the objectq
SeeAlso: AX=101Dh,AX=101Eh
----------15102C-----------------------------
INT 15 - DESQview 2.0 (TopView???) - START NEW APPLICATION IN NEW PROCESS
	AX = 102Ch
	ES:DI -> contents of .PIF/.DVP file (see below)
	BX = size of .PIF/.DVP info
Return: BX = segment of object handle for new task
	     0000h on error

Format of .PIF/.DVP file:
Offset	Size	Description
 00h	WORD	reserved (0)
 02h 30 BYTEs	blank-padded program title
 20h	WORD	maximum memory to allocate to partition in K
 22h	WORD	minimum memory required in K
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
 EDh	WORD	system memory in K
 EFh 64 BYTEs	ASCIZ shared program name
12Fh 64 BYTEs	ASCIZ shared program data file
16Fh	BYTE	flags1
		bit 7: writes text directly to screen
		bit 6: runs in foreground only
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
179h  3 BYTEs	reserved (0)
17Ch	BYTE	nonzero to automatically close on exit
17Dh	BYTE	nonzero if copy-protect floppy is required
---information unique to DESQview 2.0+---
17Eh	BYTE	.DVP version number
		00h DESQview 1.2+
		01h DESQview 2.0+
		02h DESQview 2.2+
17Fh	BYTE	reserved (0)
180h	BYTE	initial number of rows in physical window
181h	BYTE	initial number of columns in physical window
182h	WORD	maximum expanded memory to allow, in K
184h	BYTE	flags3
		bit 7: automatically assign window position
		bit 5: maximum memory value has been specified
		bit 4: disallow "Close" command
		bit 3: foreground-only when doing graphics
		bit 2: don't virtualize
		bit 1: ??? set by DV 2.31 when "Runs in Background" = "D"
185h	BYTE	keyboard conflict level (0-4 for DV<2.26, 00h-0Fh for DV2.26+)
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
			specified
		bit 6: swappable if not using serial ports
		bit 5: start program with window hidden (v2.26+)
		bit 4: start program in background (v2.26+)
		bit 3: virtualize text
		bit 2: virtualize graphics
		bit 1: share CPU when foreground
		bit 0: share EGA when foreground and zoomed
18Ch	BYTE	protection level for 386 machines
18Dh 19 BYTEs	reserved (0)
----------15102D-----------------------------
INT 15 - DESQview 2.0 - KEYBOARD MOUSE CONTROL
	AX = 102Dh
	BL = subfunction
	     00h determine whether using keyboard mouse
		Return: BL = 00h using real mouse
			     01h using keyboard mouse
	     01h turn keyboard mouse on
	     02h turn keyboard mouse off
----------1511-------------------------------
INT 15 - TopView commands
	AH = 11h
	AL = various (except 17h)
Note:	in DESQview 2.x, these function calls are identical to AH=DEh, so
	  see those below
SeeAlso: AH=DEh
----------1511-------------------------------
INT 15 - VMiX - EXECUTE SHELL SYSTEM COMMANDS
	AH = 11h
	STACK:	DWORD	pointer to ASCIZ string containing a VMiX shell
			request (max len = 127)
Return: AX = status
----------1511-------------------------------
INT 15 - MultiDOS Plus - TURN OFF AltZ TOGGLE
	AH = 11h
Note:	disables the Alt-Z MultiDOS command/program-selection hotkey
SeeAlso: AH=12h"MultiDOS"
----------151117BX0000-----------------------
INT 15 - DESQview 2.2+ - "ASSERTMAP" - GET/SET MAPPING CONTEXT
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
----------1511DE-----------------------------
INT 15 - DESQview - XDV.COM - INSTALLATION CHECK
	AX = 11DEh
Return: CF clear if installed
	    AX = segment at which XDV is located
----------1512-------------------------------
INT 15 - VMiX - PUT PROCESS TO SLEEP
	AH = 12h
	STACK:	WORD	process ID
Return: AX = status
SeeAlso: AH=03h"MultiDOS",AX=101Dh,AH=13h"VMiX"
----------1512-------------------------------
INT 15 - MultiDOS Plus - TURN ON AltZ TOGGLE
	AH = 12h
Note:	enables the Alt-Z MultiDOS command/program-selection hotkey
SeeAlso: AH=11h"MultiDOS"
----------1512--BH00-------------------------
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
----------1512--BH01-------------------------
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
SeeAlso: AH=12h/BH=02h
----------1512--BH02-------------------------
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
SeeAlso: AH=12h/BH=01h,AH=12h/BH=0Dh
----------1512--BH03-------------------------
INT 15 - TopView - SEND MESSAGE - "ADDR" - GET HANDLE OF MESSAGE SENDER
	AH = 12h
	BH = 03h
	BL = object
	    00h mailbox handle in DWORD on top of stack
	    02h sender of last msg read from mailbox (task's handle on stack)
	    03h sender of last msg read from current task's mailbox
Return: DWORD on stack is task handle of message sender
SeeAlso: AH=12h/BH=00h
----------1512--BH03-------------------------
INT 15 - DESQview 2.26+ - "CONNECT" - CONNECT TWO WINDOWS
	AH = 12h
	BH = 03h
	BL = window to be connected
	    00h handle of window to be attached in DWORD on top of stack
	    01h attach current task's main window
	STACK: DWORD handle of window to attach to or 00000000h to detach
Return: ???
Notes:	when two windows are connected, both will move if the user moves either
	multiple windows may be attached to a single window, but each window
	  may only be attached to one window at a time
----------1512--BX0300-----------------------
INT 15 - TopView - SEND MESSAGE - "DIR" - GET PANEL FILE DIRECTORY
	AH = 12h
	BX = 0300h
	STACK: DWORD handle of panel object
Return: STACK: DWORD length of directory (always multiple of 14 bytes)
	       DWORD address of directory
Note:	a null string is returned if the object is not open

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
----------1512--BH04-------------------------
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
SeeAlso: AH=12h/BH=05h"WINDOW",AH=12h/BH=12h
----------1512--BH04-------------------------
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
SeeAlso: AH=12h/BH=05h"OBJECT"

Format of pointer message:
Offset	Size	Description
 00h	WORD	row
 02h	WORD	column
 04h	BYTE	status
		bit 6: set when press/release mode active and button released
		bits 7-2: number of clicks-1 if multiple-click mode active
		bits 1,0: button pressed (00=none,01=button1,10=button2)
 05h	BYTE	field number or zero (APILEVEL >= 2.00 only)
----------1512--BX0400-----------------------
INT 15 - TopView - SEND MESSAGE - "READ" - WAIT FOR TIMER TO EXPIRE
	AH = 12h
	BX = 0400h
	STACK: DWORD timer's handle
Return: after timer expires
	STACK: DWORD time in 1/100 sec after midnight when timer expired
----------1512--BX0400-----------------------
INT 15 - TopView - SEND MESSAGE - "APPLY" - WRITE PANEL TO WINDOW
	AH = 12h
	BX = 0400h
	STACK: DWORD handle of panel object
	       DWORD window's handle (or 0 for current task's window)
	       DWORD length of panel name
	       DWORD pointer to panel name
Return: STACK: DWORD handle of keyboard or 0
	       DWORD handle of window which was used
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
----------1512--BH05------------------------
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
SeeAlso: AH=12h/BH=04h
----------1512--BH05-------------------------
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
	     20h BYTES characters to display
	61h-7Fh display next OPCODE-60h characters
	     N BYTES characters to display
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
	     N BYTES string to display
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
		bit 5  set if left mouse button may terminate entry
		bit 4  set if right mouse button may terminate entry
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
				 of modified field (API level 2.02+)
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
----------1512--BH06-------------------------
INT 15 - DESQview 2.2+ - SEND MESSAGE - "SETPRI" - SET PRIORITY WITHIN OBJECTQ
	AH = 12h
	BH = 06h
	BL = object
	    00h object handle in DWORD on top of stack
		mailbox, keyboard, pointer, or timer
	    04h given task's keyboard (task's handle on top of stack)
	    05h current task's default keyboard
	STACK: DWORD new priority of object in task's OBJECTQ 
Notes:	initially all objects have the same default value.  Should only make 
	  relative adjustments to this default value.
	when changing priorities, all objects already on the objectq are
	  reordered
SeeAlso: AH=12h/BH=07h
----------1512--BH07-------------------------
INT 15 - DESQview 2.2+ - SEND MESSAGE - "GETPRI" - GET PRIORITY WITHIN OBJECTQ
	AH = 12h
	BH = 07h
	BL = object
	    00h object handle in DWORD on top of stack
		mailbox, keyboard, pointer, or timer
	    04h given task's keyboard (task's handle on top of stack)
	    05h current task's default keyboard
Return: STACK: DWORD object priority
Note:	initially all objects have the same default value.  Should only make 
	  relative adjustments to this default value.
SeeAlso: AH=12h/BH=06h
----------1512--BH08-------------------------
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
----------1512--BH09-------------------------
INT 15 - TopView - SEND MESSAGE - "LEN" - GET OBJECT LENGTH
	AH = 12h
	BH = 09h
	BL = object
	    00h handle in DWORD on top of stack
		window: get chars/line
		timer: get 1/100 seconds remaining before timer expires
	    01h get number of chars/line in current task's default window
	    0Ch (DV 2.26+) get chars/line in window owning handle on top of stk
	    0Dh (DV 2.26+) get chars/line in parent task's window
Return: DWORD on top of stack is length
SeeAlso: AH=12h/BH=08h
----------1512--BH0A-------------------------
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
----------1512--BH0A-------------------------
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
----------1512--BH0A-------------------------
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
	       DV-specific, and INT 15h/AX=DE0Fh must have been called first
----------1512--BH0B-------------------------
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
----------1512--BH0B-------------------------
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
----------1512--BH0B-------------------------
INT 15 - TopView - SEND MESSAGE - "SUBFROM" - REMOVE OBJECT FROM OBJECTQ
	AH = 12h
	BH = 0Bh
	BL = OBJECTQ from which to remove all copies of a particular object
	    06h OBJECTQ of task whose handle is on top of stack
	    07h task's default OBJECTQ
	STACK:	DWORD	handle of object to remove
Note:	should be sent whenever an object is erased or closed
----------1512--BH0B-------------------------
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
----------1512--BH0C-------------------------
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
----------1512--BH0D-------------------------
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
	    06h close givent task's OBJECTQ (task's handle on top of stack)
	    07h close current task's OBJECTQ
Notes:	when an OBJECTQ is closed, each object in the OBJECTQ is sent an
	  ERASE message (AH=12h/BH=0Eh)
	when a panel object is closed, the panel file and any panels currently
	  in use are freed; window and keyboard objects created by APPLY are
	  not affected, but field mode input ceases
	open but idle timer objects consume a small amount of CPU time
SeeAlso: AH=12h/BH=0Ch,AH=12h/BH=0Eh,AH=12h/BH=14h"LOCK"
----------1512--BH0E-------------------------
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
----------1512--BH0F-------------------------
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
	    04h get status of last msg from task's KEYBOARD (task handle on stk)
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
	  character code (scan code) of teh last keystroke
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
----------1512--BH10-------------------------
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
----------1512--BH11-------------------------
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
----------1512--BH11-------------------------
INT 15 - TopView - SEND MESSAGE - "SETNAME" - ASSIGN NAME TO MAILBOX
	AH = 12h
	BH = 11h
	BL = mailbox to name
	    00h DWORD on top of stack is mailbox handle
	    02h use given task's mailbox (task's handle on top of stack)
	    03h use current task's default mailbox
	STACK: DWORD length of name
	       DWORD address of name
SeeAlso: AX=DE0Eh
----------1512--BX1100-----------------------
INT 15 - TopView - SEND MESSAGE - "SETSCALE" - SET POINTER SCALE FACTOR
	AH = 12h
	BX = 1100h
	STACK: DWORD object handle for pointer object
	       DWORD number of colums to scale pointer position to
	       DWORD number of rows to scale pointer position to
SeeAlso: AH=12h/BX=1200h
----------1512--BH12-------------------------
INT 15 - TopView - SEND MESSAGE - "READN" - GET NEXT N OBJECT BYTES
	AH = 12h
	BH = 12h
	BL = window to read from
	    00h handle is DWORD on top of stack
	    01h read next N chars or attributes on task's default window
	    0Ch (DV 2.26+) read window of task owning handle on top of stack
	    0Dh (DV 2.26+) read default window of parent of current task
	STACK: DWORD count
Return: STACK: DWORD width of screen line
	       DWORD address
	       DWORD count actually read
Notes:	reading starts at the current logical cursor position; the cursor is
	  updated to point at the character following the last one read
	any translucent blanks (FFh) which are visible on screen are changed
	  to the character which is seen through them
	the string produced by the read is placed in an input buffer which may
	  be reused by the next READ or READN of a window
	window stream opcodes D8h and D9h determine whether the read returns
	  characters or attributes
SeeAlso: AH=12h/BH=04h"WINDOW",AH=12h/BH=05h"WINDOW"
----------1512--BX1200-----------------------
INT 15 - TopView - SEND MESSAGE - "GETSCALE" - GET POINTER SCALE FACTOR
	AH = 12h
	BX = 1200h
	STACK: DWORD object handle for pointer
Return: STACK: DWORD pointer pos scaled as if window were this many colums wide
	       DWORD pointer pos scaled as if window were this many rows high
SeeAlso: AH=12h/BX=1100h
----------1512--BH13-------------------------
INT 15 - TopView - SEND MESSAGE - "REDRAW" - REDRAW WINDOW
	AH = 12h
	BH = 13h
	BL = window object
	    00h DWORD on top of stack is handle for window to redraw
	    01h redraw task's default window
	    0Ch (DV 2.26+) redraw window of task owning handle on top of stack
	    0Dh (DV 2.26+) redraw default window of parent of current task
SeeAlso: AH=12h/BH=0Eh
----------1512--BX1300-----------------------
INT 15 - TopView - SEND MESSAGE - "SETICON" - SPECIFY POINTER ICON
	AH = 12h
	BX = 1300h
	STACK: DWORD object handle for pointer
	       DWORD character to use for pointer
----------1512--BH14-------------------------
INT 15 - TopView - SEND MESSAGE - "SETESC" - SET ESCAPE ROUTINE ADDRESS
	AH = 12h
	BH = 14h
	BL = message modifier
	    00h handle is DWORD on top of stack
	    01h define user stream
	    04h intercept keystrokes from KEYBOARD to a window (handle on stack)
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
----------1512--BH14-------------------------
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
----------1512--BH15-------------------------
INT 15 - DESQview 2.2+ - SEND MESSAGE - "SETFLAGS" - SET OBJECT FLAGS
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
		if keyboard:
			bit 5: exclusive input when keyboard in use for input
Return: nothing
Notes:	only available if the API level has been set to at least 2.20
	equivalent to performing SUBFROM and ADDTO calls on the object
SeeAlso: AH=12h/BH=0Ah,AH=12h/BH=0Bh,AH=12h/BH=16h
----------1512--BH16-------------------------
INT 15 - DESQview 2.2+ - SEND MESSAGE - "GETFLAGS" - GET OBJECT FLAGS
	AH = 12h 
	BH = 16h
	BL = object
	    00h DWORD on top of stack
		mailbox, keyboard, or pointer only
	    02h mailbox for task whose handle is on top of stack
	    03h mailbox for current task
	    04h keyboard for task whose handle is on top of stack
	    05h keyboard for current task
Return: STACK: DWORD current control flags
Note:	only available if the API level has been set to at least 2.20
SeeAlso: AH=12h/BH=0Ah,AH=12h/BH=0Bh,AH=12h/BH=15h
----------1513-------------------------------
INT 15 - VMiX - WAKE PROCESS
	AH = 13h
	STACK:	WORD	process ID
Return: AX = status
SeeAlso: AH=12h"VMiX"
----------1513-------------------------------
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
----------1514-------------------------------
INT 15 - VMiX - CLEAR WINDOW
	AH = 14h
	STACK:	WORD	top left corner of window
		WORD	bottom right corner of window
Return: AX = status
SeeAlso: AH=15h"VMiX"
----------1514-------------------------------
INT 15 - MultiDOS Plus - CHECK IF MultiDOS FOREGROUND OR BACKGROUND
	AH = 14h
Return: AX = current state
	    0000h MultiDOS Plus command prompt is background task
	    0001h command prompt is foreground task
SeeAlso: AH=0Bh"MultiDOS"
----------1515-------------------------------
INT 15 - VMiX - SET BANNER WINDOW MESSAGE
	AH = 15h
	STACK:	DWORD	pointer to ASCIZ banner	message
Return: AX = status
SeeAlso: AH=14h"VMiX"
----------1515-------------------------------
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
----------1516-------------------------------
INT 15 - VMiX - SET ROOT WINDOW SIZE AND HOME CURSOR
	AH = 16h
	STACK:	DWORD	pointer to I/O Request Packet
		WORD	top left corner of window
		WORD	bottom right corner of window
Return: AX = status
SeeAlso: AH=17h"VMiX"
----------1516-------------------------------
INT 15 - MultiDOS Plus - INITIALIZATION
	AH = 16h
Note:	used internally during initialization; any other calls will cause
	  unpredicatable results
----------1517-------------------------------
INT 15 - VMiX - GET CONSOLE WINDOW COLORS
	AH = 17h
Return: AH = foreground color
	AL = background color
SeeAlso: AH=16h"VMiX",AH=18h"VMiX"
----------1517-------------------------------
INT 15 - MultiDOS Plus - MAP IRQ
	AH = 17h
	AL = IRQ to map (01h-0Fh)
	BX = offset of task control block (see AH=13h) to associate with IRQ
Return: AX = status
	    0000h successful
	    other invalid IRQ
Note:	the EMS map of the specified TCB is associated with the given interrupt
SeeAlso: AH=18h"MultiDOS",AH=19h"MultiDOS"
----------1518-------------------------------
INT 15 - VMiX - SET CONSOLE COLORS
	AH = 18h
	STACK:	WORD	new background/foreground colors
Return: AX = color
SeeAlso: AH=17h"VMiX"
----------1518-------------------------------
INT 15 - MultiDOS Plus - UNMAP IRQ
	AH = 18h
	AL = IRQ to unmap (01h-0Fh)
Return: AX = status
	    0000h successful
	    0001h invalid IRQ
Note:	results are unpredictable if the IRQ has not been mapped
SeeAlso: AH=17h"MultiDOS",AH=19h"MultiDOS"
----------1519-------------------------------
INT 15 - VMiX v2+ - ???
	AH = 19h
	STACK: WORD ???
Return: ???
----------1519-------------------------------
INT 15 - MultiDOS Plus - UNMAP ALL IRQs
	AH = 19h
Return: AX destroyed
Note:	for MultiDOS internal use only
SeeAlso: AH=17h"MultiDOS",AH=18h"MultiDOS"
----------151A-------------------------------
INT 15 - VMiX v2+ - ???
	AH = 1Ah
	STACK: 3 WORDs ???
Return: ???
----------151A-------------------------------
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
----------151B-------------------------------
INT 15 - VMiX v2+ - ???
	AH = 1Bh
	STACK: 5 WORDs ???
Return: ???
----------151B-------------------------------
INT 15 - MultiDOS Plus - REQUEST RESOURCE SEMAPHORE BY NAME
	AH = 1Bh
	DS:SI -> 8-byte name
Return: AH = status
	    00h successful
	    02h invalid semaphore number
	    03h caller already owns semaphore
	    04h out of string space
Notes:	(see notes for AH=01h"MultiDOS")
	equivalent to AH=1Ah followed by AH=01h
SeeAlso: AH=01h"MultiDOS",AH=1Ah"MultiDOS",AH=1Ch"MultiDOS",AH=1Dh"MultiDOS"
----------151C-------------------------------
INT 15 - VMiX v2+ - ???
	AH = 1Ch
	STACK: 5 WORDs ???
Return: ???
----------151C-------------------------------
INT 15 - MultiDOS Plus - RELEASE RESOURCE SEMAPHORE BY NAME
	AH = 1Ch
	DS:SI -> 8-byte name
Return: AH = status
	    00h successful
	    01h not semaphore owner
	    02h invalid semaphore number
	    04h out of string space
Notes:	(see notes for AH=02h"MultiDOS")
	equivalent to AH=1Ah followed by AH=02h
SeeAlso: AH=02h"MultiDOS",AH=1Ah"MultiDOS",AH=1Bh"MultiDOS",AH=1Dh"MultiDOS"
----------151D-------------------------------
INT 15 - VMiX v2+ - ???
	AH = 1Dh
	???
Return: ???
----------151D-------------------------------
INT 15 - MultiDOS Plus - TEST RESOURCE SEMAPHORE BY NAME
	AH = 1Dh
	DS:SI -> 8-byte name
Return; AH = status
	    00h semaphore not in use
	    01h semaphore owned by another task
	    02h invalid semaphore number
	    03h caller owns semaphore
	    04h out of string space
Notes:	(see notes for AH=10h"MultiDOS")
	equivalent to AH=1Ah followed by AH=10h
SeeAlso: AH=10h"MultiDOS",AH=1Ah"MultiDOS",AH=1Bh"MultiDOS",AH=1Ch"MultiDOS"
----------151E-------------------------------
INT 15 - VMiX v2+ - ???
	AH = 1Eh
	STACK: WORD ???
Return: ???
----------151E00-----------------------------
INT 15 - MultiDOS Plus - CLEAR EVENT COUNTER
	AX = 1E00h
	DX = event/trigger number (00h-3Fh)
Return: AH = status
	    00h successful
SeeAlso: AX=1E01h,AX=1E02h
----------151E01-----------------------------
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
----------151E02-----------------------------
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
----------151F-------------------------------
INT 15 - MultiDOS Plus 4.01 - GET MEMORY PARAMETERS
	AH = 1Fh
Return: BX = first segment of conventional memory
	DX = first segment of EMS swap frame into which MultiDOS will load
		programs
----------1520-------------------------------
INT 15 - MultiDOS Plus 4.01 - CHECK IF MULTITASKING ENABLED
	AH = 20h
Return: AX = current state
	    0000h multitasking enabled
	    other TCB of task that disabled multitasking
SeeAlso: AH=0Dh"MultiDOS",AH=13h"MultiDOS"
----------152000-----------------------------
INT 15 - DOS 3+ PRINT.COM - DISABLE CRITICAL REGION FLAG
	AX = 2000h
SeeAlso: AX=2001h
----------152001-----------------------------
INT 15 - DOS 3+ PRINT.COM - SET CRITICAL REGION FLAG
	AX = 2001h
	ES:BX -> byte which is to be incremented while in a DOS call
SeeAlso: AX=2000h
----------152010-----------------------------
INT 15 - OS HOOK - SETUP SYSREQ ROUTINE (AT,XT286,PS50+)
	AX = 2010h
	???
Return: ???
SeeAlso: AX=2011h
----------152011-----------------------------
INT 15 - OS HOOK - COMPLETION OF SYSREQ FUNCTION (AT,XT286,PS50+)
	AX = 2011h
	???
Return: ???
SeeAlso: AX=2010h
----------1521-------------------------------
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
----------1540-------------------------------
INT 15 - SYSTEM - READ/MODIFY PROFILES (CONVERTIBLE)
	AH = 40h
	AL = subfunction
	    00h get system profile in CX and BX
	    01h set system profile from CX and BX
	    02h get internal modem profile in BX
	    03h set internal modem profile from BX
----------154000-----------------------------
INT 15 - Compaq SLT/286 or Portable 386 - READ LCD/PLASMA TIMEOUT
	AX = 4000h
Return: AX = 4000h
	CL = 00h timeout disabled
	   else timeout in minutes
SeeAlso: AX=4001h,AX=4600h
----------154001CL00-------------------------
INT 15 - Compaq SLT/286 or Portable 386 - SET LCD/PLASMA TIMEOUT
	AX = 4001h
	CL = 00h timeout disabled
	   else	 timeout in minutes
Return: AL = 00h timeout modified
	     01h timeout cannot be modified
	     40h timeout cannot be modified
	CL = 00h timeout disabled
	   else timeout in minutes
SeeAlso: AX=4000h,AX=4601h
----------1541-------------------------------
INT 15 - SYSTEM - WAIT ON EXTERNAL EVENT (CONVERTIBLE)
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
----------1542-------------------------------
INT 15 - SYSTEM - REQUEST POWER OFF (CONVERTIBLE)
	AH = 42h
	AL = 00h to use system profile
	     01h to force suspend regardless of system profile
SeeAlso: AH=44h
----------154280-----------------------------
INT 15 - Compaq SLT/286 - ENTER STANDBY
	AX = 4280h
Return: AH = 42h
	CF clear if successful
	CF set if unable to enter standby
SeeAlso: AX=4600h
----------1543-------------------------------
INT 15 - SYSTEM - READ SYSTEM STATUS (CONVERTIBLE)
	AH = 43h
Return: AL = status bits
	    bit 0: LCD detached
	    bit 1: reserved
	    bit 2: RS232/parallel adapter powered on
	    bit 3: internal modem powered on
	    bit 4: power activated by alarm
	    bit 5: standby power lost
	    bit 6: external power in use
	    bit 7: power low
----------1544-------------------------------
INT 15 - SYSTEM - (DE)ACTIVATE INTERNAL MODEM POWER (CONVERTIBLE)
	AH = 44h
	AL = 00h to power off
	     01h to power on
SeeAlso: AH=42h
----------154600-----------------------------
INT 15 - Compaq SLT/286 - READ POWER CONSERVATION/MODEM CONFIGURATION
	AX = 4600h
Return: AH = modem configuration information
	    bit 0 powerup state
		    0 off
		    1 on
		1 modem installed
		2 IRQ line assignment
		    0 IRQ 4
		    1 IRQ 3
		3 COM port assignment
		    0 = COM 2
		    1 = COM 1
		4 modem state
		    0 not assigned
		    1 assigned
		5 modem is on
	AL = power conservation status information
	    bit 0  power source (0 internal, 1 external)
	       1-2 low battery state
		    00 no low battery condition
		    01 low battery 1
		    10 reserved
		    11 low battery 2
	       3-4 power conservation mode
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
----------154601-----------------------------
INT 15 - Compaq SLT/286 - Modify Power Conservation/Modem Configuration
	AX = 4601h
	BL = system inactivity timeout (1-21 minutes)
	   = FFh do not change
	CL = video display inactivity timeout (1-63 minutes)	    
	   = FFh do not change
	DL = current fixed disk drive inactivity timeout (1-21 minutes)
	   = FFh do not change
	DH = 00h turn modem OFF
	   = 01h turn modem ON
	   = FFh do not change modem state
Return: CF clear if successful
	    AH = 00h
	    BL = current system inactivity timeout (1-21 minutes)
	    CL = current video display inactivity timeout (1-63 minutes)	
	    DL = current fixed disk drive inactivity timeout (1-21 minutes)
	    DH = FFh modem state unchanged
	       = 00h modem turned OFF
	       = 01h modem turned ON
	CF set on error
	    AH = 01h input is out of range
	       = 02h - No modem present
SeeAlso: AX=4600h,INT 77
----------154F-------------------------------
INT 15 - OS HOOK - KEYBOARD INTERCEPT (AT model 3x9,XT2,XT286,CONV,PS)
	AH = 4Fh
	AL = scan code
	CF set
Return: CF set
	   AL = scan code
	CF clear
	   scan code should be ignored
Note:	called by INT 9 handler to translate scan codes
SeeAlso: INT 09
----------155400-----------------------------
INT 15 - Omniview Multitasker - INSTALLATION NOTIFICATION
	AX = 5400h
	ES:BX -> device information tables
	DI:DX -> dispatcher entry point
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5407h
----------155401-----------------------------
INT 15 - Omniview Multitasker - PROCESS CREATION
	AX = 5401h
	ES:BX = process handle
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5402h
----------155402-----------------------------
INT 15 - Omniview Multitasker - PROCESS DESTRUCTION
	AX = 5402h
	ES:DX = process handle
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5401h
----------155403-----------------------------
INT 15 - Omniview Multitasker - SAVE
	AX = 5403h
	ES:DX = process swapping out
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5404h
----------155404-----------------------------
INT 15 - Omniview Multitasker - RESTORE
	AX = 5404h
	ES:DX = process swapping in
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5403h
----------155405-----------------------------
INT 15 - Omniview Multitasker - SWITCHING TO BACKGROUND
	AX = 5405h
	ES:DX = process swapping in
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5406h
----------155406-----------------------------
INT 15 - Omniview Multitasker - SWITCHING TO FOREGROUND
	AX = 5406h
	ES:DX = process swapping in
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5405h
----------155407-----------------------------
INT 15 - Omniview Multitasker - EXIT NOTIFICATION
	AX = 5407h
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5400h
----------1580-------------------------------
INT 15 - OS HOOK - DEVICE OPEN (AT,XT286,PS)
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
----------1581-------------------------------
INT 15 - OS HOOK - DEVICE CLOSE
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
----------1582-------------------------------
INT 15 - OS HOOK - PROGRAM TERMINATION
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
----------1583-------------------------------
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
Note:	the resolution of the wait period is 977 microseconds on most systems
	  because most BIOSes use the 1/1024 second fast interrupt from the AT
	  real-time clock chip which is available on INT 70
SeeAlso: AH=86h,INT 70
----------1584-------------------------------
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
----------1585-------------------------------
INT 15 - OS HOOK - SysRq KEY ACTIVITY (AT,PS)
	AH = 85h
	AL = 00h SysRq key pressed
	   = 01h SysRq key released
	CF clear
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (see AH=84h)
Notes:	called by keyboard decode routine
	the default handler simply returns successfully; programs which wish
	  to monitor the SysRq key must hook this call
SeeAlso: INT 09
----------1586-------------------------------
INT 15 - BIOS - WAIT (AT,PS)
	AH = 86h
	CX:DX = interval in microseconds
Return: CF clear if successful (wait interval elapsed)
	CF set on error or AH=83h wait already in progress
	    AH = status (see AH=84h)
Note:	the resolution of the wait period is 977 microseconds on most systems
	  because most BIOSes use the 1/1024 second fast interrupt from the AT
	  real-time clock chip which is available on INT 70
SeeAlso: AH=83h,INT 70
----------1587-------------------------------
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
Notes:	copy is done in protected mode with interrupts disabled
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
----------1588-------------------------------
INT 15 - SYSTEM - GET EXTENDED MEMORY SIZE (286+)
	AH = 88h
Return: CF clear if successful
	    AX = number of contiguous KB starting at absolute address 100000h
	CF set on error
	    AH = status
		80h invalid command (PC,PCjr)
		86h unsupported function (XT,PS30)
Note:	TSRs which wish to allocate extended memory to themselves often hook
	  this call, and return a reduced memory size.	They are then free to
	  use the memory between the new and old sizes at will.
SeeAlso: AH=87h
----------1589-------------------------------
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
	CX = offset into protected-mode CS to jump to
Return: CF set on error
	   AH = FFh  error enabling address line 20
	CF clear if successful
	   AH = 00h
	   in protected mode at specified address
Note:	BL and BH must be multiples of 8
SeeAlso: AH=87h,AH=88h,INT 67/AX=DE0Ch
----------1590-------------------------------
INT 15 - OS HOOK - DEVICE BUSY (AT,PS)
	AH = 90h
	AL = device type
	    00h disk
	    01h diskette
	    02h keyboard
	    03h PS/2 pointing device
	    21h waiting for keyboard input (Phoenix BIOS)
	    80h network
	    FCh disk reset (PS)
	    FDh diskette motor start
	    FEh printer
	ES:BX -> request block for type codes 80h through BFh
	CF clear
Return: CF set if wait time satisfied
	CF clear if driver must perform wait
	    AH = 00h
Notes:	type codes are allocated as follows:
	  00-7F non-reentrant devices; OS must arbitrate access
	  80-BF reentrant devices; ES:BX points to a unique control block
	  C0-FF wait-only calls, no complementary INT 15/AH=91h call
	this function should be hooked by a multitasker to allow other tasks
	  to execute while the BIOS is waiting for I/O completion; the default
	  handler merely returns with AH=00h and CF clear
SeeAlso: AH=91h
----------1591-------------------------------
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
----------15BC-------------------------------
INT 15 - Phoenix 386 BIOS - DETERMINE CPU SPEED
	AH = BCh
Return: CF clear
	BYTE 0040h:00B0h set to ??? (43 on my 386/33)
Note:	reads system timer channel 0 twice, then does calculations on returned
	  values
----------15BF02DX0000-----------------------
INT 15 - Rational Systems DOS/16M - INSTALLATION CHECK
	AX = BF02h
	DX = 0000h
Return: DX = nonzero if installed
	    DX:SI -> XBRK structure
SeeAlso: INT 2F/AH=A1h,INT 2F/AX=F100h,INT 2F/AX=FBA1h
----------15C0-------------------------------
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

Format of ROM configuration table:
Offset	Size	Description
 00h	WORD	number of bytes following
 02h	BYTE	model (see below)
 03h	BYTE	submodel (see below)
 04h	BYTE	BIOS revision: 0 for first release, 1 for 2nd, etc.
 05h	BYTE	features:
		bit 7 = DMA channel 3 used by hard disk BIOS
		bit 6 = 2nd 8259 installed
		bit 5 = Real-Time Clock installed
		bit 4 = INT 15h/AH=4Fh called upon INT 9h
		bit 3 = wait for external event supported
		bit 2 = extended BIOS area allocated (usually at top of RAM)
		bit 1 = bus is Micro Channel instead of ISA
		bit 0 reserved
 06h	WORD	reserved (0)
 08h	WORD	reserved (0)
 0Ah		AWARD copyright notice here

Values for model/submodel/revision:
Model  Submdl  Rev	BIOS date	System
 FFh	*	*	04/24/81	PC (original)
 FFh	*	*	10/19/81	PC (some bugfixes)
 FFh	*	*	10/27/82	PC (HD, 640K, EGA support)
 FFh	46h	***	  ???		Olivetti M15
 FEh	*	*	08/16/82	PC XT
 FEh	*	*	11/08/82	PC XT and Portable
 FEh	43h	***	  ???		Olivetti M240
 FDh	*	*	06/01/83	PCjr
 FCh	*	*	01/10/84	AT models 068,099 6 MHz 20MB
 FCh	00h	01h	06/10/85	AT model  239	  6 MHz 30MB
 FCh	00h	<> 01h	  ???		7531/2 Industrial AT
 FCh	01h	00h	11/15/85	AT models 319,339 8 MHz, Enh Keyb, 3.5"
 FCh	01h	00h	01/15&88	Toshiba T5200/100
 FCh	01h	00h	12/26*89	Toshiba T1200/XE
			(Those date characters are not typos)
 FCh	01h	???	  ???		Compaq 286/386
 FCh	02h	00h	04/21/86	PC XT-286
 FCh	04h	00h	02/13/87     ** PS/2 Model 50
 FCh	04h	03h	04/18/88	PS/2 Model 50Z
 FCh	05h	00h	02/13/87     ** PS/2 Model 60
 FCh	06h	???	  ???		7552 "Gearbox"
 FCh	09h	02h	06/28/89	PS/2 Model 30-286
 FCh	0Bh	00h	02/16/90	PS/1
 FCh	42h	***	  ???		Olivetti M280
 FCh	45h	***	  ???		Olivetti M380 (XP 1, XP3, XP 5)
 FCh	48h	***	  ???		Olivetti M290
 FCh	4Fh	***	  ???		Olivetti M250
 FCh	50h	***	  ???		Olivetti M380 (XP 7)
 FCh	51h	***	  ???		Olivetti PCS286
 FCh	52h	***	  ???		Olivetti M300
 FCh	81h	00h	01/15/88	Phoenix 386 BIOS v1.10 10a
 FBh	00h	01h	01/10/86	PC XT, Enh Keyb, 3.5" support
 FBh	00h	02h	05/09/86	PC XT
 FBh	4Ch	***	  ???		Olivetti M200
 FAh	00h	00h	09/02/86	PS/2 Model 30
 FAh	00h	01h	12/12/86	PS/2 Model 30
 FAh	01h	00h	  ???		PS/2 Model 25
 FAh	4Eh	***	  ???		Olivetti M111
 F9h	00h	00h	09/13/85	PC Convertible
 F8h	00h	00h	03/30/87     ** PS/2 Model 80 16MHz
 F8h	01h	00h	10/07/87	PS/2 Model 80 20MHz
 F8h	04h	02h	04/11/88	PS/2 Model 70 20MHz, type 2 system brd
 F8h	04h	03h	03/17/89	PS/2 Model 70 20MHz, type 2 system brd
 F8h	09h	???	  ???		PS/2 Model 70 16MHz, type 1 system brd
 F8h	09h	02h	04/11/88	PS/2 Model 70 some models
 F8h	09h	03h	03/17/89	PS/2 Model 70 some models
 F8h	0Bh	00h	01/18/89	PS/2 Model P70 (8573-121) typ 2 sys brd
 F8h	0Bh	02h	12/16/89	PS/2 Model P70 ??
 F8h	0Ch	00h	11/02/88	PS/2 Model 55SX
 F8h	0Dh	???	  ???		PS/2 Model 70 25MHz, type 3 system brd
 F8h	11h	00h	10/01/90	PS/2 Model ??
 F8h	13h	00h	10/01/90	PS/2 Model ??
 F8h	14h	00h	10/01/90	PS/2 Model 90-AK9
 F8h	16h	00h	10/01/90	PS/2 Model 90-AKD
 F8h	1Bh	00h	10/02/89	PS/2 Model 70-486
 F8h	1Ch	00h	02/08/90	PS/2 Model 65-121
 F8h	1Eh	00h	02/08/90	PS/2 Model ??
 F8h	50h	00h	  ???		PS/2 Model P70 (8573) 16 MHz
 F8h	50h	01h	12/16/89	PS/2 Model P70 (8570-031)
 F8h	61h	***	  ???		Olivetti P500
 F8h	62h	***	  ???		Olivetti P800
 F8h	80h	01h	11/21/89	PS/2 Model 80-A21
 9Ah	*	*	  ???		Compaq XT/Compaq Plus
 30h	???	???	  ???		Sperry PC
 2Dh	*	*	  ???		Compaq PC/Compaq Deskpro

    * This BIOS call is not implemented in these early versions.
      Read Model byte at F000h:FFFEh and BIOS date at F000h:FFF5h.
   ** These BIOS versions require the DASDDRVR.SYS patches.
  *** These Olivetti machines store the submodel in the byte at F000h:FFFDh.
----------15C1-------------------------------
INT 15 - SYSTEM - RETURN EXTENDED-BIOS DATA-AREA SEGMENT ADDRESS (PS)
	AH = C1h
Return: CF set on error
	CF clear if successful
	    ES = segment of data area
SeeAlso: AH=04h"ABIOS"
----------15C200BH00-------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - ENABLE/DISABLE
	AX = C200h
	BH = 00h disable
	     01h enable
Return: CF set on error
	AH = status
	    00h successful
	    01h invalid function
	    02h invalid input
	    03h interface error
	    04h need to resend
	    05h no device handler installed
----------15C201-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - RESET
	AX = C201h
Return: CF set on error
	    AH = status (see AX=C200h)
	CF clear if successful
	    BH = device ID
SeeAlso: INT 33/AX=0000h
----------15C202-----------------------------
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
----------15C203-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - SET RESOLUTION
	AX = C203h
	BH = resolution
	    00h one count per mm
	    01h two counts per mm
	    02h four counts per mm
	    03h eight counts per mm
Return: CF set on error
	    AH = status (see AX=C200h)
----------15C204-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - GET TYPE
	AX = C204h
Return: CF set on error
	    AH = status (see AX=C200h)
	CF clear if successful
	    BH = device ID
----------15C205-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - INITIALIZE
	AX = C205h
	BH = data package size (1 - 8 bytes)
Return: CF set on error
	    AH = status (see AX=C200h)
SeeAlso: AX=C201h
----------15C206-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - GET/SET SCALING FACTOR
	AX = C206h
	BH = subfunction
	    00h return device status
		Return: BL = status
			   bit 0: right button pressed
			   bit 1: reserved
			   bit 2: left button pressed
			   bit 3: reserved
			   bit 4: 0 if 1:1 scaling, 1 if 2:1 scaling
			   bit 5: device enabled
			   bit 6: 0 if stream mode, 1 if remote mode
			   bit 7: reserved
			CL = resolution (see AX=C203h)
			DL = sample rate, reports per second
	    01h set scaling at 1:1
	    02h set scaling at 2:1
Return: CF set on error
	    AH = status (see AX=C200h)
----------15C207-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - SET DEVICE HANDLER ADDR
	AX = C207h
	ES:BX = user device handler
Return: CF set on error
	    AH = status (see AX=C200h)
SeeAlso: INT 33/AX=000Ch
----------15C3------------------------------
INT 15 - SYSTEM - ENABLE/DISABLE WATCHDOG TIMEOUT (PS50+)
	AH = C3h
	AL = 00h disable
	     01h enable
		BX = timer counter
Return: CF set on error
	CF clear if successful
Note:	the watchdog timer generates an NMI
----------15C4-------------------------------
INT 15 - SYSTEM - PROGRAMMABLE OPTION SELECT (PS50+)
	AH = C4h
	AL = 00h return base POS register address
	     01h enable slot
		 BL = slot number
	     02h enable adapter
Return: CF set on error
	DX = base POS register address (if function 00h)
----------15C5-------------------------------
INT 15 - OS HOOK (undoc) - ROM BIOS TRACING CALLOUT (PS30/286,PS50Z,PS95)
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
----------15C6-------------------------------
INT 15 - PS/2 Model 95 - ???
	AH = C6h
	???
Return: ???
----------15C7-------------------------------
INT 15 - PS/2 Model 95 - ???
	AH = C7h
	???
Return: ???
----------15C8-------------------------------
INT 15 - PS/2 Model 95 - ???
	AH = C8h
	???
Return: ???
----------15C9-------------------------------
INT 15 - PS/2 Model 95 - ???
	AH = C9h
	???
Return: ???
----------15CA-------------------------------
INT 15 - PS/2 Model 95 - ???
	AH = CAh
	???
Return: ???
----------15CB-------------------------------
INT 15 - PS/2 Model 95 - ???
	AH = CBh
	???
Return: ???
----------15CC-------------------------------
INT 15 - PS/2 Model 95 - ???
	AH = CCh
	???
Return: ???
----------15CD-------------------------------
INT 15 - PS/2 Model 95 - ???
	AH = CDh
	???
Return: ???
----------15CE-------------------------------
INT 15 - PS/2 Model 95 - ???
	AH = CEh
	???
Return: ???
----------15CF-------------------------------
INT 15 - PS/2 Model 95 - ???
	AH = CFh
	???
Return: ???
----------15D800-----------------------------
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
		6: set if product ID readable
	      4,5: slot type (00=expansion, 01=embedded, 10=virtual device)
	      0-3: duplicate ID number if bit 7 set
	BH = major revision level of configuration utility
	BL = minor revision level of configuration utility
	CX = checksum of configuration file
	DH = number of device functions
	DL = combined function information byte
	SI:DI = 4-byte compressed ID (DI = bytes 0&1, SI = bytes 2&3)
Note:	call with AL=80h if using 32-bit CS addressing mode instead of 16-bit
SeeAlso: AX=D801h,AX=D804h
----------15D801-----------------------------
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
----------15D802-----------------------------
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
----------15D803-----------------------------
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
----------15D804-----------------------------
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
----------15D8-------------------------------
INT 15 - EISA SYSTEM ROM - 32-bit CS ADDRESSING MODE CALLS
	AH = D8h
	AL = 80h to 84h
	other registers as appropriate for AL=00h to 04h
Return: as appropriate for AL=00h to 04h
Note:	these functions are identical to AX=D800h to D804h, except that they
	  should be called when using 32-bit CS addressing mode (pointers use
	  ESI rather than SI as offset) instead of 16-bit addressing mode
SeeAlso: AX=D800h,AX=D801h,AX=D802h,AX=D803h,AX=D804h
----------15DE00-----------------------------
INT 15 - DESQview - GET PROGRAM NAME
	AX = DE00h
Return: AX = offset into DESQVIEW.DVO of current program's record (see below)
SeeAlso: AX=DE07h

Format of program entry in DESQVIEW.DVO:
Offset	Size	Description
 00h	BYTE	length of name
 01h  N BYTEs	name
      2 BYTEs	keys to invoke program (second = 00h if only one key used)
	WORD	??? seems always to be 0000h
	BYTE	end flag: 00h for all but last entry, which is FFh
----------15DE01-----------------------------
INT 15 - DESQview - UPDATE "OPEN WINDOW" MENU
	AX = DE01h
Return: nothing
Note:	reads DESQVIEW.DVO, disables Open menu if file not in current directory
----------15DE02-----------------------------
INT 15 - DESQview 1.x only - SET ??? FLAG FOR CURRENT WINDOW
	AX = DE02h
Return: nothing
Note:	this call is a NOP in DV 2.x
SeeAlso: AX=DE03h
----------15DE03-----------------------------
INT 15 - DESQview 1.x only - GET ??? FOR CURRENT WINDOW
	AX = DE03h
Return: AX = ??? for current window
	BX = ??? for current window
Note:	this call is a NOP in DV 2.x
SeeAlso: AX=DE02h
----------15DE04-----------------------------
INT 15 - DESQview - GET AVAILABLE COMMON MEMORY
	AX = DE04h
Return: BX = bytes of common memory available
	CX = largest block available
	DX = total common memory in bytes
SeeAlso: AX=DE05h,AX=DE06h
----------15DE05-----------------------------
INT 15 - DESQview - GET AVAILABLE CONVENTIONAL MEMORY
	AX = DE05h
Return: BX = K of memory available
	CX = largest block available
	DX = total conventional memory in K
SeeAlso: AX=DE04h,AX=DE06h
----------15DE06-----------------------------
INT 15 - DESQview - GET AVAILABLE EXPANDED MEMORY
	AX = DE06h
Return: BX = K of expanded memory available
	CX = largest block available
	DX = total expanded memory in K
SeeAlso: AX=DE04h,AX=DE05h
----------15DE07-----------------------------
INT 15 - DESQview - "APPNUM" - GET CURRENT PROGRAM'S NUMBER
	AX = DE07h
Return: AX = number of program as it appears on the "Switch Windows" menu
Note:	this API call may be made from a hardware interrupt handler
SeeAlso: AX=DE00h
----------15DE08-----------------------------
INT 15 - DESQview - GET ???
	AX = DE08h
Return: AX = 0000h if ??? is not set to the current task
	     0001h if ??? is set to the current task
----------15DE09-----------------------------
INT 15 - DESQview - UNIMPLEMENTED
	AX = DE09h
Return: nothing (NOP in DV 1.x and 2.x)
----------15DE0A-----------------------------
INT 15 - DESQview 2.x - "DBGPOKE" - DISPLAY CHARACTER ON STATUS LINE
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
----------15DE0B-----------------------------
INT 15 - DESQview 2.x - "APILEVEL" - DEFINE MINIMUM API LEVEL REQUIRED
	AX = DE0Bh
	BL = API level major version number
	BH = API level minor version number
Return: AX = maximum API level (AL = major, AH = minor)
Notes:	if the requested API level is greater than the version of DESQview, a
	  "You need a newer version" error window is popped up
	the API level defaults to 1.00, and is inherited by child tasks
	some early copies of DV 2.00 return AX=0200h instead of 0002h
----------15DE0C-----------------------------
INT 15 - DESQview 2.x - "GETMEM" - ALLOCATE "SYSTEM" MEMORY
	AX = DE0Ch
	BX = number of bytes
Return: ES:DI -> allocated block or 0000h:0000h (DV 2.26+)
Note:	use SETERROR (AX=DE15h) to avoid a user prompt if there is insufficient
	  system memory
SeeAlso: AX=1001h,AX=DE0Dh,AX=DE15h
----------15DE0D-----------------------------
INT 15 - DESQview 2.x - "PUTMEM" - DEALLOCATE "SYSTEM" MEMORY
	AX = DE0Dh
	ES:DI -> previously allocated block
Return: nothing
SeeAlso: AX=1002h,AX=DE0Ch
----------15DE0E-----------------------------
INT 15 - DESQview 2.x - "FINDMAIL" - FIND MAILBOX BY NAME
	AX = DE0Eh
	ES:DI -> name to find
	CX = length of name
Return: BX = 0000h not found
	     0001h found
		DS:SI = object handle
SeeAlso: AH=12h/BH=11h
----------15DE0F-----------------------------
INT 15 - DESQview 2.x - ENABLE DESQview EXTENSIONS
	AX = DE0Fh
Return: AX and BX destroyed (seems to be bug, weren't saved&restored)
Notes:	sends a manager stream with opcodes AEh, BDh, and BFh to task's window
	enables an additional mouse mode
----------15DE10-----------------------------
INT 15 - DESQview 2.x - "PUSHKEY" - PUT KEY INTO KEYBOARD INPUT STREAM
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
----------15DE11BL00-------------------------
INT 15 - DESQview 2.x - ENABLE/DISABLE AUTOMATIC JUSTIFICATION OF WINDOW
	AX = DE11h
	BL = 00h      viewport will not move automatically
	     nonzero  viewport will move to keep cursor visible (default)
Return: nothing
----------15DE12BX0000-----------------------
INT 15 - DESQview 2.01+ - "CSTYLE" - SET "C"-COMPATIBLE CONTROL CHAR INTERPRET
	AX = DE12h
	BX = 0000h    select normal style (linefeed only moved down)
	     nonzero  select C style (linefeed moves to start of next line)
Return: nothing
Note:	set on a per-task basis, and inherited from the parent task
----------15DE13-----------------------------
INT 15 - DESQview 2.2+ - GET CRITICAL NESTING COUNT
	AX = DE13h
Return: BX = number of calls to BEGINC or ENTERC (see INT 15/AX=101Bh,DE1Ch)
	     without matching ENDC (see INT 15/AX=101Ch)
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=101Bh,AX=101Ch,AX=DE1Bh,AX=DE1Ch
----------15DE14-----------------------------
INT 15 - DESQview 2.2+ - GET OBJECT TYPE
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
----------15DE15BL00-------------------------
INT 15 - DESQview 2.2+ - SET ERROR HANDLING
	AX = DE15h
	BL = 00h post system error on all error conditions
	     01h return carry flag set on calls to ADDTO, SUBFROM, and WRITE
		 messages sent to mailboxes which fail due to lack of system
		 or common memory
	     02h (v2.26+) same as 01h, but return null pointer for GETMEM
		 calls which fail due to lack of system memory
Return: nothing
SeeAlso: AX=DE16h
----------15DE16-----------------------------
INT 15 - DESQview 2.2+ - GET ERROR HANDLING
	AX = DE16h
Return: BL = 00h always post system error
	     01h return carry flag set on failed mailbox writes
	     02h return CF set on failed mailbox writes and NULL on failed
		 GETMEM calls
SeeAlso: AX=DE15h
----------15DE17-----------------------------
INT 15 - DESQview 2.20-2.25 - reserved
	AX = DE17h
Return: pops up "Programming error" window
Note:	AX = 1117h is NOT identical to this call under DESQview 2.20 thru 2.25
SeeAlso: AX=1117h
----------15DE17BX0000-----------------------
INT 15 - DESQview 2.26+ - "ASSERTMAP" - GET/SET MAPPING CONTEXT
	AX = DE17h
	BX = 0000h	get current mapping context without setting
	     nonzero	set new mapping context
Return: BX = mapping context in effect before call
Notes:	mapping contexts determine conventional-memory addressability; setting
	  a mapping context ensures that the associated program and data areas
	  are in memory for access.  Usable by drivers, TSRs and shared
	  programs.
	caller need not be running under DESQview
	this API call may be made from a hardware interrupt handler
SeeAlso: AX=1117h,INT 2F/AX=1685h
----------15DE18-----------------------------
INT 15 - DESQview 2.2+ internal -
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
----------15DE19-----------------------------
INT 15 - DESQview 2.23+ - "GETCOMMON" - ALLOCATE "COMMON" MEMORY
	AX = DE19h
	BX = number of bytes to allocate
Return: AX = 0000h successful
		ES:DI -> allocated block
	     nonzero insufficient memory
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=DE0Ch,AX=DE15h,AX=DE1Ah
----------15DE1A-----------------------------
INT 15 - DESQview 2.23+ - "PUTCOMMON" - DEALLOCATE "COMMON" MEMORY
	AX = DE1Ah
	DS:SI -> previously allocated block
Note:	this function may be called from within a hardware interrupt handler
SeeAlso: AX=DE0Dh,AX=DE19h
----------15DE1B-----------------------------
INT 15 - DESQview 2.23+ internal - DECREMENT CRITICAL NESTING COUNT
	AX = DE1Bh
Return: nothing
SeeAlso: AX=101Ch,AX=DE13h,AX=DE1Ch
----------15DE1C-----------------------------
INT 15 - DESQview 2.23+ - "ENTERC" - INCREMENT CRITICAL NESTING COUNT
	AX = DE1Ch
Return: nothing
Notes:	similar to AX=101Bh, but begins the critical region without ensuring
	  that DOS is free
	the official documentation states that this call should be paired with
	  "ENDC" (AX=101Ch); no mention is made of AX=DE1Bh
	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=101Bh,AX=101Ch,AX=DE13h,AX=DE1Bh
----------15DE1D-----------------------------
INT 15 - DESQview 2.23+ - "PUTKEY" - FAKE USER KEYSTROKES
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
----------15DE1E-----------------------------
INT 15 - DESQview 2.23+ - "SCRNINFO" - GET TRUE VIDEO PARAMETERS
	AX = DE1Eh
Return:	CL = actual number of rows on screen
	CH = actual number of columns on screen
	BL = actual video mode (may differ from INT 10/AH=0Fh return) (v2.26+)
Note:	this API call may be made from a hardware interrupt handler
SeeAlso: INT 10/AH=0Fh
----------15DE1F-----------------------------
INT 15 - DESQview 2.23+ - "DOSUSER" - GET HANDLE OF TASK CURRENTLY USING DOS
	AX = DE1Fh
Return: BX = segment of task handle or 0000h if no tasks are using DOS
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=DE13h
----------15DE20-----------------------------
INT 15 - DESQview 2.26+ - "DISPATCHINT" - INTERRUPT ANOTHER TASK
	AX = DE20h
	BX = segment of handle of task to interupt
	DX:CX -> FAR interrupt routine
Return: nothing
Notes:	unlike "PGMINT" (AX=1021h), DISPATCHINT may be applied to the task
	  making the DISPATCHINT call
	multiple "DISPATCHINT" calls are processed in the order in which they
	  were executed
	the FAR routine is entered with the current ES, DS, SI, DI, and BP
	  values, using the task's internal stack (see AX=101Ah); only SS:SP
	  needs to be preserved
	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=1021h
----------15DE21BX0000-----------------------
INT 15 - DESQview 2.26+ - "ASSERTVIR" - CONTROL 386 SCREEN VIRTUALIZATION
	AX = DE21h
	BX = 0000h turn off
	     nonzero turn on
Return: BX = old state of virtualization
Note:	this API call may be made from within a hardware interrupt handler
----------15DE22-----------------------------
INT 15 - DESQview 2.26+ - "PROCESSMEM" - GET TASK MEMORY STATUS
	AX = DE22h
	DX = segment of task handle
Return: DX = total amount of memory in paragraphs
	BX = amount of system memory in paragraphs
	CX = largest block of system memory available in paragraphs
	AX = flags
	    bit 0: system memory resides in shared memory
		1: process's memory is swapped out
		2: process's system memory is swapped out
Notes:	if the task handle is a child task, the returned values will be for the
	  process containing the task, rather than the task itself
	if the process's system memory is swapped out, BX,CX,DX remain
	  unchanged, because the memory usage cannot be determined
SeeAlso: AX=DE04h,AX=DE05h,AX=DE06h
----------15DE23-----------------------------
INT 15 - DESQview 2.31+ - ???
	AX = DE23h
	BX = ???
	CX = ???
Return: ???
----------15E00F-----------------------------
INT 15 - Compaq Systempro - MULTIPROCESSOR DISPATCH
	AX = E00Fh
	ES:BX -> start of 2nd processor's execution
Return: AL = 0Fh successful
	   = 00h failure	
SeeAlso: AX=E10Eh,AX=E200h
----------15E10E-----------------------------
INT 15 - Compaq Systempro - MULTIPROCESSOR END-OF-DISPATCH
	AX = E10Eh
	ES:BX -> start of 2nd processor's execution
Return: AL = 0Fh successful (halted)
	   = 00h failure (not halted)
SeeAlso: AX=E00Fh,AX=E200h
----------15E200-----------------------------
INT 15 - Compaq Systempro - MULTIPROCESSOR AVAILABLE
	AX = E200h
Return: AX = 8000h if 2nd processor available
SeeAlso: AX=E00Fh,AX=E10Eh
----------1600-------------------------------
INT 16 - KEYBOARD - GET KEYSTROKE
	AH = 00h
Return: AH = scan code
	AL = ASCII character
Note:	on extended keyboards, this function discards any extended keystrokes,
	  returning only when a non-extended keystroke is available
SeeAlso: AH=01h,AH=05h,AH=10h
----------1601-------------------------------
INT 16 - KEYBOARD - CHECK FOR KEYSTROKE
	AH = 01h
Return: ZF set if no keystroke available
	ZF clear if keystroke available
	    AH = scan code
	    AL = ASCII character
Note:	if a keystroke is present, it is not removed from the keyboard buffer;
	  however, any extended keystrokes which are not compatible with 83/84-
	  key keyboards are removed in the process of checking whether a
	  non-extended keystroke is available
SeeAlso: AH=00h,AH=11h
----------1602-------------------------------
INT 16 - KEYBOARD - GET SHIFT FLAGS
	AH = 02h
Return: AL = shift flags
	    bit 7: Insert active
		6: CapsLock active
		5: NumLock active
		4: ScrollLock active
		3: Alt key pressed (either Alt on 101/102-key keyboards)
		2: Ctrl key pressed (either Ctrl on 101/102-key keyboards)
		1: left shift key pressed
		0: right shift key pressed
SeeAlso: AH=12h
----------1603-------------------------------
INT 16 - KEYBOARD - SET TYPEMATIC RATE AND DELAY
	AH = 03h
	AL = subfunction
	    00h (PCjr) set default delay and rate
	    01h (PCjr) increase delay before repeat
	    02h (PCjr) decrease repeat rate by factor of 2
	    03h (PCjr) increase delay and decrease repeat rate
	    04h (PCjr) turn off typematic repeat
	    05h (AT,PS) set repeat rate and delay
		BH = delay value (00h = 250ms to 03h = 1000ms)
		BL = repeat rate (00h=30/sec to 0Ch=10/sec [def] to 1Fh=2/sec)
----------1604-------------------------------
INT 16 - KEYBOARD - SET KEYCLICK (PCjr only)
	AH = 04h
	AL = keyclick state
	    00h off
	    01h on
SeeAlso: AH=03h
----------1605-------------------------------
INT 16 - KEYBOARD - STORE KEYSTROKE IN KEYBOARD BUFFER (AT/PS w enh keybd only)
	AH = 05h
	CH = scan code
	CL = ASCII character
Return: AL = 00h if successful
	     01h if keyboard buffer full
Note:	under DESQview, the following "keystrokes" invoke the following actions
	  when they are read from the keyboard buffer:
		38FCh	pop up DESQview main menu
		38FEh	close the current window
		38FFh	pop up DESQview learn menu
SeeAlso: AH=00h,AH=71h,INT 15/AX=DE10h
----------1610-------------------------------
INT 16 - KEYBOARD - GET ENHANCED KEYSTROKE (enhanced kbd support only)
	AH = 10h
Return: AH = scan code
	AL = ASCII character
Notes:	if no keystroke is available, this function waits until one is placed
	  in the keyboard buffer
	unlike AH=00h, this function does not discard extended keystrokes
SeeAlso: AH=00h,AH=11h
----------1611-------------------------------
INT 16 - KEYBOARD - CHECK FOR ENHANCED KEYSTROKE (enh kbd support only)
	AH = 11h
Return: ZF set if no keystroke available
	ZF clear if keystroke available
	    AH = scan code
	    AL = ASCII character
Notes:	if a keystroke is available, it is not removed from the keyboard buffer
	unlike AH=01h, this function does not discard extended keystrokes
SeeAlso: AH=01h,AH=10h
----------1612-------------------------------
INT 16 - KEYBOARD - GET EXTENDED SHIFT STATES (enh kbd support only)
	AH = 12h
Return: AL = shift flags 1 (same as returned by AH=02h)
	    bit 7: Insert active
		6: CapsLock active
		5: NumLock active
		4: ScrollLock active
		3: Alt key pressed (either Alt on 101/102-key keyboards)
		2: Ctrl key pressed (either Ctrl on 101/102-key keyboards)
		1: left shift key pressed
		0: right shift key pressed
	AH = shift flags 2
	    bit 7: SysRq key pressed
		6: CapsLock pressed
		5: NumLock pressed
		4: ScrollLock pressed
		3: right Alt key pressed
		2: right Ctrl key pressed
		1: left Alt key pressed
		0: left Ctrl key pressed
Notes:	AL bit 3 set only for left Alt key on many machines
	AH bits 7 through 4 always clear on a Compaq SLT/286
SeeAlso: AH=02h
----------164500-----------------------------
INT 16 - Shamrock Software EMAIL - GET STATUS
	AX = 4500h
	DL = port number (01h = COM1)
	ES:BX -> 13-byte buffer for ASCIZ name
Return: AX = 4D00h if EMAIL installed on specified port
	    ES:BX -> "" if no connection
	          -> "*" if connection but caller has not identified name
		  -> name otherwise
	    CX = version (CH = major, CL = minor)
	    DL = privilege level of user (00h = guest)
	    DH = chosen language (00h German, 01h English)
SeeAlso: AX=4501h,AX=4502h
----------164501-----------------------------
INT 16 - Shamrock Software EMAIL - GET ELAPSED ONLINE TIME AND MAXIMUM TIME
	AX = 4501h
	DL = port number (01h = COM1)
Return: AX = 4D00h if EMAIL installed on specified port
	    BX = maximum connect time in clock ticks
	    CX = maximum connect time for guests (without name) in clock ticks
	    DX = elapsed connect time of current user in clock ticks
SeeAlso: AX=4500h	
----------164502-----------------------------
INT 16 - Shamrock Software EMAIL - GET CURRENT COMMUNICATIONS PARAMETERS
	AX = 4502h
	DL = port number (01h = COM1)
Return: AX = 4D00h if EMAIL installed on specified port
	    BL = current value of serial port's Line Control Register
	    BH = flags
		bit 0: ISO code
		    1: pause
		    2: linefeed
		    3: ANSI sequences
	    CX = selected country code (33 = France, 49 = Germany, etc)
	    DX = baudrate divisor (115200/DX = baudrate)
SeeAlso: AX=4500h
----------164503-----------------------------
INT 16 - Shamrock Software EMAIL - SPECIFY COMMAND-WORD FOR USER FUNCTION
	AX = 4503h
	DL = port number (01h = COM1)
	DH = maximum execution time in clock ticks (00h = 5 seconds)
	ES:BX -> ASCIZ string with new user command-word
Return: AX = 4D00h if EMAIL installed on specified port
Notes:	a single user command (consisting of only uppercase letters and digits)
	  may be defined, and remains valid until it is overwritten or the
	  EMAIL program terminates; the user command must be activated by
	  calling AX=4504h at least once.
	an existing command word may be redefined with this function
SeeAlso: AX=4504h,AX=4505h
----------164504-----------------------------
INT 16 - Shamrock Software EMAIL - CHECK FOR USER FUNCTION COMMAND-WORD
	AX = 4504h
	DL = port number (01h = COM1)
	ES:BX -> 80-byte buffer for ASCIZ user input line
Return: AX = 4D00h if EMAIL installed on specified port
	    DL = flags
	        bit 0: user function supported (always set)
		    1: user entered user-function command word
	    if DL bit 1 set,
	        ES:BX buffer contains line entered by user which begins with
			the defined command word and has been converted to all
			caps
Note:	caller must process the returned commandline and invoke AX=4505h
	  within five seconds with the result of that processing
SeeAlso: AX=4503h,AX=4505h
----------164505-----------------------------
INT 16 - Shamrock Software EMAIL - SEND RESULT OF USER FUNCTION
	AX = 4505h
	DL = port number (01h = COM1)
	DH = error flag
	    bit 3: set on error
	ES:BX -> ASCIZ text to return to user, max 1024 bytes
Return: AH = 4Dh if EMAIL installed on specified port
	AL = status
	    00h successful
	    02h unable to perform function (timeout, prev call not complete)
	    other error
Notes:	if the error flag in DH is set, the string is not sent and an error
	  message is generated instead; if this function is not called within
	  five seconds of AX=4504h, EMAIL automatically generates an error
	  message
	the string is copied into an internal buffer, allowing this function's
	  caller to continue immediately
SeeAlso: AX=4503h,AX=4504h,INT 17/AX=2400h
----------164506-----------------------------
INT 16 - Shamrock Software EMAIL - MONITOR XMODEM DOWNLOAD
	AX = 4506h
	DL = port number (01h = COM1)
	ES:BX -> 13-byte buffer for ASCIZ filename
Return: AX = 4D00h if EMAIL installed on specified port
	    DH = Xmodem status
	        00h no XGET command given
		01h XGET in progress
		02h XGET completed successfully
	    ES:BX buffer filled with last filename given to XGET command
	    	(without path)
Note:	DH=02h will only be returned once per XGET; subsequent calls will
	  return DH=00h
SeeAlso: AX=4500h,INT 17/AX=2408h
----------165500-----------------------------
INT 16 - Microsoft Word internal - MICROSOFT WORD COOPERATION WITH TSR
	AX = 5500h
Return: AX = 4D53h if keyboard TSR present
Notes:	during startup, Microsoft Word tries to communicate with any TSRs
	  that are present through this call.
	If the return is not 4D53h, Word installs its own INT 9h and INT 16h
	  handlers, otherwise it assumes that the TSR will handle the keyboard.
----------166969BX6968-----------------------
INT 16 - PC Tools v5.1+ BACKTALK - UNHOOK
	AX = 6969h
	BX = 6968h
Return: resident code unhooked, but not removed from memory
----------166969BX6969-----------------------
INT 16 - PC Tools v5.1+ BACKTALK - INSTALLATION CHECK
	AX = 6969h
	BX = 6969h
	DX = 0000h
Return: DX nonzero if installed
	    BX = CS of resident code
	    DX = PSP segment of resident code
	    DS:SI -> ASCIZ identification string "CPoint Talk"
----------166F-------------------------------
INT 16 - MS Windows - ???
	AH = 6Fh
	???
Return: ???
----------166F00BX0000-----------------------
INT 16 - MS Windows - ???
	AX = 6F00h
	BX = 0000h
	???
Return: BX = 4850h if ???
Note:	called by recent MS Mouse drivers
----------1670-------------------------------
INT 16 - FAKEY.COM - INSTALLATION CHECK
	AH = 70h
Return: AX = 1954h if installed
Note:	FAKEY is a keystroke faking utility by System Enhancement Associates
----------1671-------------------------------
INT 16 - FAKEY.COM - PUSH KEYSTROKES
	AH = 71h
	CX = number of keystrokes
	DS:SI -> array of words containing keystrokes to be returned by AH=00h
Note:	FAKEY is a keystroke faking utility by System Enhancement Associates
SeeAlso: AH=05h,AH=72h
----------1672-------------------------------
INT 16 - FAKEY.COM - CLEAR FAKED KEYSTROKES
	AH = 72h
Note:	FAKEY is a keystroke faking utility by System Enhancement Associates
SeeAlso: AH=71h
----------1673-------------------------------
INT 16 - FAKEY.COM - PLAY TONES
	AH = 73h
	CX = number of tones to play
	DS:SI -> array of tones (see below)
Note:	FAKEY is a keystroke faking utility by System Enhancement Associates
SeeAlso: INT 15/AX=1019h

Format of tone array entries:
Offset	Size	Description
 00h	WORD	divisor for timer channel 2
 02h	WORD	duration in clock ticks
----------1675-------------------------------
INT 16 - pcANYWHERE III - SET TICK COUNT FOR SCANNING
	AH = 75h
	AL = number of ticks between checks for new screen changes
----------1676-------------------------------
INT 16 - pcANYWHERE III - SET ERROR CHECKING TYPE
	AH = 76h
	AL = error checking type
	    00h none
	    01h fast
	    02h slow
----------1677-------------------------------
INT 16 - pcANYWHERE III - LOG OFF
	AH = 77h
	AL = mode
	    00h wait for another call
	    01h leave in Memory Resident Mode
	    02h leave in Automatic Mode
	    FFh leave in current operating mode
----------167761-----------------------------
INT 16 - WATCH.COM - INSTALLATION CHECK
	AX = 7761h ('wa')
Return: AX = 5741h ('WA') if installed
Note:	WATCH.COM is part of the "TSR" package by Kim Kokkonen
----------167788BX7789-----------------------
INT 16 - PC Magazine PUSHDIR.COM - INSTALLATION CHECK
	AX = 7788h
	BX = 7789h
Return: AX = 7789h
	BX = 7788h
	DS:SI -> signature string
----------1679-------------------------------
INT 16 - pcANYWHERE III - CHECK STATUS
	AH = 79h
Return: AX = status
	    FFFFh if resident and active
	    FFFEh if resident but not active
	    FFFDh if in Memory Resident mode
	    FFFCh if in Automatic mode
	    other value if not resident
SeeAlso: AX=7B00h,INT 21/AX=2B44h
----------167A-------------------------------
INT 16 - pcANYWHERE III - CANCEL SESSION
	AH = 7Ah
----------167B00-----------------------------
INT 16 - pcANYWHERE III - SUSPEND
	AX = 7B00h
SeeAlso: AH=79h,AX=7B01h
----------167B01-----------------------------
INT 16 - pcANYWHERE III - RESUME
	AX = 7B01h
SeeAlso: AH=79h,AX=7B00h
----------167C-------------------------------
INT 16 - pcANYWHERE III - GET PORT CONFIGURATION
	AH = 7Ch
Return: AH = port number
	AL = baud rate
	    00h = 50 baud
	    01h = 75 baud
	    02h = 110 baud
	    03h = 134.5 baud
	    04h = 150 baud
	    05h = 300 baud
	    06h = 600 baud
	    07h = 1200 baud
	    08h = 1800 baud
	    09h = 2000 baud
	    0Ah = 2400 baud
	    0Bh = 4800 baud
	    0Ch = 7200 baud
	    0Dh = 9600 baud
	    0Eh = 19200 baud
----------167D-------------------------------
INT 16 - pcANYWHERE III - GET/SET TERMINAL PARAMETERS
	AH = 7Dh
	AL = subfunction
	    00h set terminal parameters
	    01h get terminal parameters
	    02h get configuration header and terminal parameters
	DS:CX -> terminal parameter block
----------167E-------------------------------
INT 16 - pcANYWHERE III - COMMUNICATIONS I/O THROUGH PORT
	AH = 7Eh
	AL = subfunction
	    01h port input status
		Return AX = 0 if no characer ready,
		       AX = 1 if character ready
	    02h port input character
		Return AL = received character
	    03h port output character in CX
	    11h hang up phone
----------167F-------------------------------
INT 16 - pcANYWHERE III - SET KEYBOARD/SCREEN MODE
	AH = 7Fh
	AL = subfunction
	    00h enable remote keyboard only
	    01h enable host keyboard only
	    02h enable both keyboards
	    08h display top 24 lines
	    09h display bottom 24 lines
	    10h Hayes modem
	    11h other modem
	    12h direct connect
----------1680-------------------------------
INT 16 - MAKEY.COM - INSTALLATION CHECK
	AH = 80h
Return: AX = 1954h if installed
Note:	MAKEY is a utility by System Enhancement Associates
----------16AA-------------------------------
INT 16 - PTxxx.COM - (xxx=CGA,EGA,VGA,HER...) CALL GATE FOR GRAPHICS
	AH = AAh
	Various registers set up by high level language.
Return: Graphics performed
Note:	PT stands for Paint Tools which is a graphics library for Turbo Pascal,
	  Modula 2 and others from DataBiten in Sweden. The library is
	  installed as a memory resident driver.
----------16E0E0-----------------------------
INT 16 - TurboPower TSRs - ALTERNATE INSTALLATION CHECK
	AX = E0E0h
Return: AX = 1F1Fh if installed
	    DWORD 0040h:00F0h -> last data block in TSR list (see AX=F0F0h)
Note:	the returned TSR list provides support for communication among TSRs
	  built with TurboPower's Turbo Professional and Object Professional
	  libraries for Turbo Pascal
SeeAlso: AX=F0F0h
----------16F0-------------------------------
INT 16 - Compaq 386 - SET CPU SPEED
	AH = F0h
	AL = speed
	    00h equivalent to 6 MHz 80286 (COMMON)
	    01h equivalent to 8 MHz 80286 (FAST)
	    02h full 16 MHz (HIGH)
	    03h toggles between 8 MHz-equivalent and speed set by system board
		switch (AUTO or HIGH)
	    08h full 16 MHz except 8 MHz-equivalent during floppy disk access
	    09h specify speed directly
		CX = speed value, 1 (slowest) to 50 (full), 3 ~= 8088
SeeAlso: AH=F1h,AH=F3h
----------16F0F0-----------------------------
INT 16 - TurboPower TSRs - INSTALLATION CHECK
	AX = F0F0h
Return: AX = 0F0Fh if installed
	    ES:DI -> last data block in TSR list
Note:	the returned TSR list provides support for communication among TSRs
	  built with TurboPower's Turbo Professional and Object Professional
	  libraries for Turbo Pascal
SeeAlso: AX=E0E0h

Format of data block:
Offset	Size	Description
 00h	DWORD	pointer to program tag (counted ASCII string)
 04h	WORD	interface version number (0400h)
 06h	DWORD	pointer to command entry point
 0Ah	DWORD	pointer to previous data block (0000h:0000h if none)
 0Eh	DWORD	pointer to next data block (0000h:0000h if none)
---swappable TSRs only---
 12h	DWORD	pointer to swapping data
 16h	DWORD	pointer to user data
	more???
----------16F1-------------------------------
INT 16 - Compaq 386 - READ CURRENT CPU SPEED
	AH = F1h
Return:	AL = speed code (see AH=F0h)
	     if AL = 09h, CX = speed code
SeeAlso: AH=F0h,AH=F3h
----------16F2-------------------------------
INT 16 - Compaq 386 - DETERMINE ATTACHED KEYBOARD TYPE
	AH = F2h
Return: AL = type
	    00h if 11-bit AT keyboard is in use
	    01h if 9-bit PC keyboard is in use 
----------16F3-------------------------------
INT 16 - Compaq 80286s - SET CPU SPEED LIMIT (OVERRIDE JUMPER)
	AH = F3h
	AL = 00h limit is 6 Mhz
	   = 01h limit is 8 Mhz/6 Mhz
SeeAlso: AH=F0h,AH=F1h
----------16F400-----------------------------
INT 16 - Compaq Systempro - CACHE CONTROLLER STATUS
	AX = F400h
Return: AH = E2h
	AL = status
	    00h not present
	    01h enabled
	    02h disabled
SeeAlso: AX=F401h,AX=F402h
----------16F401-----------------------------
INT 16 - Compaq Systempro - ENABLE CACHE CONTROLLER
	AX = F401h
Return: AX = E201h
SeeAlso: AX=F400h,AX=F402h
----------16F402-----------------------------
INT 16 - Compaq Systempro - DISABLE CACHE CONTROLLER
	AX = F402h
Return: AX = E202h
SeeAlso: AX=F400h,AX=F401h
----------16FFA5CX1111-----------------------
INT 16 - PC-Cache v6+ - INSTALLATION CHECK
	AX = FFA5h
	CX = 1111h
Return: CH = 00h if installed
	    ES:DI -> internal data (see below)
	    CL = cache state
	    	01h enabled
		02h disabled
SeeAlso: INT 13/AH=A0h,INT 21/AH=2Bh/CX=4358h

Format of internal data:
Offset	Size	Description
-1Ch 20 BYTEs	cached drive list, one byte per drive A: to T:
		each byte is either blank (20h) or drive letter (41h-54h)
 -8	BYTE	???
 -7	WORD	number of physical transfers (scaled down to 0000h-7FFFh)
 -5	WORD	number of saved transfers (scaled down to 0000h-7FFFh)
 -3   3 BYTEs	???
----------16FFA5CXAAAA-----------------------
INT 16 - PC-Cache v6+ - ENABLE DELAYED WRITES
	AX = FFA5h
	CX = AAAAh
Return: AX = ??? (apparently either 0000h or sectors_in_cache - 5)
SeeAlso: AX=FFA5h/CX=CCCCh
----------16FFA5CXCCCC-----------------------
INT 16 - PC-Cache v6+ - FLUSH CACHE AND DISABLE DELAYED WRITES
	AX = FFA5h
	CX = CCCCh
Return: AX = ??? (apparently either 0000h or sectors_in_cache - 5)
Note:	delayed writes are automatically disabled on EXECing
	  (see INT 21/AH=4Bh) a program named either WIN.CO? or DV.E??;
	  however, delayed writes are not automatically reenabled upon the
	  program's termination in v6.
SeeAlso: AX=FFA5h/CX=AAAAh,AX=FFA5h/CX=FFFFh
----------16FFA5CXDDDD-----------------------
INT 16 - PC-Cache v6+ - FLUSH AND DISABLE CACHE
	AX = FFA5h
	CX = DDDDh
SeeAlso: AX=FFA5h/CX=EEEEh,AX=FFA5h/CX=FFFFh
----------16FFA5CXEEEE-----------------------
INT 16 - PC-Cache v6+ - ENABLE CACHE
	AX = FFA5h
	CX = EEEEh
SeeAlso: AX=FFA5h/CX=DDDDh
----------16FFA5CXFFFF-----------------------
INT 16 - PC-Cache v6+ - FLUSH CACHE
	AX = FFA5h
	CX = FFFFh
SeeAlso: AX=FFA5h/CX=CCCCh,AX=FFA5h/CX=DDDDh,INT 13/AH=A1h
----------16FFA6-----------------------------
INT 16 - PC Tools v6.0 DESKTOP API - GET ???
	AX = FFA6h
Return: DS:SI -> ???
----------16FFA7-----------------------------
INT 16 - PC Tools v6.0 DESKTOP API - GET ??? PATH
	AX = FFA7h
Return: DS:SI -> ASCIZ path (directory from which PCTools was run???)
----------16FFA8-----------------------------
INT 16 - PC Tools v6.0 DESKTOP API - ???
	AX = FFA8h
	DS:SI -> three consecutive ASCIZ strings for ??? (max 256 bytes total)
	???
Return: ???
Notes:	available only when popped up
	strings copied into internal buffer, among other actions
----------16FFA9-----------------------------
INT 16 - PC Tools v6.0 DESKTOP API - GET ???
	AX = FFA9h
Return: DS:SI -> version string???
----------16FFAA-----------------------------
INT 16 - PC Tools v6.0 DESKTOP API - ???
	AX = FFAAh
	???
Return: ???
Note:	available only when popped up
----------16FFAB-----------------------------
INT 16 - PC Tools v6.0 DESKTOP API - GET EDITOR SETTINGS???
	AX = FFABh
Return: DS:SI -> editor setting strings???
----------16FFAC-----------------------------
INT 16 - PC Tools v6.0 DESKTOP API - SET ???
	AX = FFACh
	DL = ???
Note:	available only when popped up
----------16FFAD-----------------------------
INT 16 - PC Tools v6.0 DESKTOP API - SET ???
	AX = FFADh
	DL = ???
----------16FFAE-----------------------------
INT 16 - PC Tools v6.0 DESKTOP API - GET ???
	AX = FFAEh
Return: AL = ???
----------16FFAF-----------------------------
INT 16 - PC Tools v6.0 DESKTOP API - SET ???
	AX = FFAFh
	DL = ???
----------16FFB0-----------------------------
INT 16 - PC Tools v6.0 DESKTOP API - SET ???
	AX = FFB0h
	BL = ???
----------16FFB1-----------------------------
INT 16 - PC Tools v6.0 DESKTOP API - ???
	AX = FFB1h
	???
Return: ???
----------16FFB2-----------------------------
INT 16 - PC Tools v5.5+ DESKTOP API - GET ???
	AX = FFB2h
Return: DS:SI -> ???
----------16FFB3-----------------------------
INT 16 - PC Tools v5.5+ DESKTOP API - ???
	AX = FFB3h
	???
Return: ???
Note:	available only when popped up
----------16FFB4-----------------------------
INT 16 - PC Tools v5.5+ DESKTOP API - SET ??? FLAG
	AX = FFB4h
Note:	available only when popped up
SeeAlso: AX=FFBBh
----------16FFB5-----------------------------
INT 16 - PC Tools v5.5+ DESKTOP API - GET/SET WINDOW PARAMETERS
	AX = FFB5h
	BX = window specifier (000Fh to 0019h) (see below)
	DX = 0000h get, nonzero = set
	ES:DI -> window parameter buffer (see below)
SeeAlso: AX=FFCBh

Values for window specifier:
 000Fh	comm/FAX
 0014h	hotkey selection
 0015h	ASCII table
 0016h	system colors menu

Format of window parameters:
Offset	Size	Description
 00h	BYTE	rows in window, not counting frame
 01h	BYTE	columns in window, not counting frame
 02h	BYTE	row number of top of window
 03h	BYTE	2*column number of left of window
 04h	BYTE	character attribute for ???
 05h	BYTE	character attribute for background/border
 06h	BYTE	character attribute for ???
 07h	DWORD	pointer to ??? on screen
 0Bh  4 BYTEs	???
 0Fh	BYTE	nonzero if window may be resized
Note:	if running in monochrome mode, character attributes at offsets 04h to
	  06h are stored unchanged, but attributes other than 07h, 0Fh, or 70h
	  are changed to 07h on reading
----------16FFB6-----------------------------
INT 16 - PC Tools v5.5+ DESKTOP API - GET ???
	AX = FFB6h
Return: AH = ???
	AL = ???
----------16FFB7-----------------------------
INT 16 - PC Tools v5.5+ DESKTOP API - GET/SET ???
	AX = FFB7h
	BX = direction
	    0000h copy to buffer
	    else  copy from buffer
	DS:SI -> 70-byte buffer with ???
Return: data copied
Note:	available only when popped up under v6.0+
----------16FFB8-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - GET/SET???
	AX = FFB8h
	BH = subfunction
	    00h get
		Return: BL = old value of ???
			CL = old value of ??? (v6.0+)
			CH = old value of ??? (v6.0+)
	    nonzero set
		BL = new value for ???
		CL = new value for ??? (v6.0+)
		CH = new value for ??? (v6.0+)
		DH = ???
		Return: AL = old value replaced by CL (v6.0+)
			AH = old value replaced by CH (v6.0+)
----------16FFB9-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFB9h
	???
Return: AX = ???
	CX = ???
	DS:SI -> ???
	ES:DI -> ???
----------16FFBA-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFBAh
	???
Return: AX = ???
Note:	available only when popped up
----------16FFBB-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - CLEAR ??? FLAG
	AX = FFBBh
Note:	available only when popped up
SeeAlso: AX=FFB4h
----------16FFBC-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - RESTORE ORIGINAL SCREEN???
	AX = FFBCh
----------16FFBD-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ??? DATABASE INDEXING MESSAGES
	AX = FFBDh
	???
Return: ???
----------16FFBE-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFBEh
	???
Return: ???
Note:	available only when popped up
----------16FFBF-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFBFh
	BX = DOS file handle to write on
	???
Return: ???
Note:	available only when popped up
----------16FFC0-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFC0h
	???
Return: AX = 0000h if successful
	AX = FFFFh on error
Note:	available only when popped up
----------16FFC1-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFC1h
	BL = ???
	ES:DI -> data structure (see below)
	???
Return: AX = ???
Note:	available only when popped up

Format of data structure:
Offset	Size	Description
 00h	WORD	???
 02h	WORD	???
 04h	WORD	???
 06h	WORD	???
 08h	WORD	???
 0Ah	BYTE	???
 0Bh	BYTE	???
	???
----------16FFC2-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFC2h
	???
Return: AH = ???
	CX = ???
	DH = ???
	DL = ???
Note:	available only when popped up
SeeAlso: AX=FFC3h
----------16FFC3-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFC3h
	???
Return: AH = ???
	CX = ???
	DH = ???
	DL = ???
Note:	available only when popped up
SeeAlso: AX=FFC2h
----------16FFC4-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - GET ???
	AX = FFC4h
Return: AL = ???
	BX = segment of scratch space???
	CX = segment of stored screen data (section covered by window???)
	DX = segment of window parameters for ???
	ES:BP -> ???
Note:	available only when popped up in versions prior to 6.0
----------16FFC5-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - CHECK WHETHER DESKTOP LOADED RESIDENT
	AX = FFC5h
Return: BL = nonzero if loaded resident
	   = 00h if nonresident
Note:	available only when popped up
SeeAlso: AX=FFEFh,AX=FFF3h
----------16FFC6-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - SET ???
	AX = FFC6h
	BL = new value for ???
----------16FFC7-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - REMOVE WINDOW
	AX = FFC7h
	???
Return: ???
----------16FFC8-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - GET ???
	AX = FFC8h
Return: DS:SI -> ???
Note:	valid only while popped up
----------16FFC9-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - COPY DATA TO CLIPBOARD
	AX = FFC9h
	DS:SI -> characters to store in clipboard
	CX = size in bytes
Return: CF set on error
Notes:	available only when popped up
	while copying, bytes of 00h and 0Ah are skipped
----------16FFCA-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - SET ???
	AX = FFCAh
	DX = ???
Return: AX destroyed
Note:	available only when popped up
----------16FFCB-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - SELECT WINDOW PARAMETERS???
	AX = FFCBh
	DX = window specifier???
Return: AX destroyed
Note:	available only when popped up
SeeAlso: AX=FFB5h
----------16FFCC-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - DISPLAY ASCIZ STRING CENTERED IN WINDOW
	AX = FFCCh
	DS:SI -> ASCIZ string
Return: AX = ???
	CX = ???
	ES:DI -> address past last character displayed (v5.1/5.5)
	      -> ??? on menu bar
----------16FFCD-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFCDh
	DS:DX -> ???
Return: ???
Note:	available only when popped up
----------16FFCE-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - SET ??? DELAYS
	AX = FFCEh
	CX = ???
Return: nothing???
----------16FFCF-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - CLOSE PRINTER/PRINT FILE
	AX = FFCFh
Note:	available only when popped up
----------16FFD0-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - PREPARE TO PRINT???
	AX = FFD0h
	???
Return: ???
Note:	available only when popped up
----------16FFD1-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - DISPLAY PRINT OPTIONS MENU
	AX = FFD1h
Return: BX = number of copies
	DX = destination
	    00h cancel
	    01h LPT1
	    02h LPT2
	    03h	LPT3
	    04h	COM1
	    05h	COM2
	    06h disk file
Note:	available only when popped up
----------16FFD2-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFD2h
	BX = ???
Return: BL = ???
Note:	available only when popped up
----------16FFD3-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFD3h
	DS:SI -> 92-byte data record for ???
Return: ???
----------16FFD4BH3C-------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - CREATE/OPEN/DELETE FILE
	AX = FFD4h
	BH = 3Ch create file (with no attributes)
	     3Dh open file
	     41h delete file
	BL = access mode
	     00h read only
	     01h write only
	     02h read/write
	DS:SI -> ASCIZ filename
Return: BX = file handle
	    0000h on error
Note:	operation is attempted in (in order) the directory from which the
	  desktop was started/run???, the directory specified with the
	  filename, X:\PCTOOLS\, and X:\
----------16FFD5-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFD5h
	???
Return: ???
Note:	available only when popped up
----------16FFD6-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFD6h
	BX = ???
	CX = ???
	DX = offset in ???
	???
Return: ???
Note:	available only when popped up
----------16FFD7-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFD7h
	???
Return: BL = ???
Note:	available only when popped up
----------16FFD8-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - SAFE CREATE FILE
	AX = FFD8h
	DS:BX -> ASCIZ filename
Return: BX = file handle
	    0000h on error
Note:	pops up confirmation menu if file already exists
	only available when popped up???
----------16FFD9-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - GET ???
	AX = FFD9h
Return: AX = ???
Note:	available only when popped up
----------16FFDA-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - GET NAME OF LAST FILE OPENED
	AX = FFDAh
	DS:SI -> ??? (v5.1/5.5 only)
Return: DS:SI -> filename
----------16FFDB-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - SET ???
	AX = FFDBh
	BL = ???
Note:	available only when popped up
----------16FFDC-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - UNHOOK
	AX = FFDCh
Return: interrupt vectors 09h, 10h (v6.0+), 16h, 1Ch, and 21h restored to
	  original values
----------16FFDDBX0000-----------------------
INT 16 - PC Tools v5.1+ PCShell API - INSTALLATION CHECK
	AX = FFDDh
	BX = 0000h
Return: CX = 5555h 
	DX = 5555h if PCShell installed in resident mode
----------16FFDDBX0001-----------------------
INT 16 - PC Tools v5.1+ PCShell API - REQUEST POP-UP
	AX = FFDDh
	BX = 0001h
SeeAlso: AX=FFDDh/BX=0003h
----------16FFDDBX0002-----------------------
INT 16 - PC Tools v5.1-5.5 PCShell API - GET ???
	AX = FFDDh
	BX = 0002h
Return: AL = 
	    00h ???
	    01h ???
Note:	PCShell v6.0 displays the error message "Incorrect PCRUN version",
	  awaits a keystroke, and aborts the current process
----------16FFDDBX0003-----------------------
INT 16 - PC Tools v5.1+ PCShell API - REQUEST POP-UP
	AX = FFDDh
	BX = 0003h
SeeAlso: AX=FFDDh/BX=0001h
----------16FFDDBX0004-----------------------
INT 16 - PC Tools v5.1+ PCShell API - GET ???
	AX = FFDDh
	BX = 0004h
Return: CF clear if successful
	    DS:SI -> ???
----------16FFDDBX0005-----------------------
INT 16 - PC Tools v5.1+ PCShell API - ???
	AX = FFDDh
	BX = 0005h
	???
Return: ???
----------16FFDDBX0006-----------------------
INT 16 - PC Tools v5.1+ PCShell API - ???
	AX = FFDDh
	BX = 0006h
	???
Return: ???
----------16FFDDBX0007-----------------------
INT 16 - PC Tools v5.1+ PCShell API - SET ??? FLAG
	AX = FFDDh
	BX = 0007h
Return: CF clear if successful
SeeAlso: AX=FFDDh/BX=0008h
----------16FFDDBX0008-----------------------
INT 16 - PC Tools v5.1+ PCShell API - CLEAR ??? FLAG
	AX = FFDDh
	BX = 0008h
Return: ???
SeeAlso: AX=FFDDh/BX=0007h
----------16FFDDBX0009-----------------------
INT 16 - PC Tools v6.0 PCShell API - GET PCRUN PARAMETERS
	AX = FFDDh
	BX = 0009h
Return: CF clear if successful
	    DS:SI -> list of pointers (see below)

Format of returned pointer list:
Offset	Size	Description
 00h	WORD	offset of WORD containing ???
 02h	WORD	offset of name of program to execute
 04h	WORD	offset of 80-byte buffer for ???
 06h	WORD	offset of buffer for ??? (length in WORD preceding buffer)
 08h	WORD	offset of buffer for ??? (length in WORD preceding buffer)
----------16FFDDBX000A-----------------------
INT 16 - PC Tools v6.0 PCRUN API - INSTALLATION CHECK
	AX = FFDDh
	BX = 000Ah
Return: CX = 5555h if running
	DX = 5555h
Note:	also sets a flag
----------16FFDDBX000B-----------------------
INT 16 - PC Tools v6.0 PCRUN API - ???
	AX = FFDDh
	BX = 000Bh
	???
Return: CX = 5555h if PCRUN active
	DX = 5555h
Note:	also clears flag set by AX=FFDDh/BX=000Ah
----------16FFDE-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - DISPLAY POPUP MENU
	AX = FFDEh
	DS:DX -> menu description (must be on a paragraph boundary)
Return: AX = ???
	    AL seems to be the number of the selected button
Note:	available only when popped up
----------16FFDF-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFDFh
	???
Return: ???
----------16FFE0-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFE0h
	CX = ???
	DX = ???
Note:	available only when popped up
----------16FFE1-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - BEEP
	AX = FFE1h
----------16FFE2-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFE2h
	DX = ???
Return: ???
Note:	available only when popped up
----------16FFE3-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - PRINT CHARACTER
	AX = FFE3h
	BL = character to print to currently open printer or print file
Return: CF set on error
Note:	available only when popped up
----------16FFE4-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFE4h
	DX = segment of ???
Return: ???
Note:	available only when popped up
----------16FFE5-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - POP UP FILE SELECTION MENU
	AX = FFE5h
	DS:SI -> ASCIZ wildcard filespec followed by ASCIZ menu title
	DX = segment of window parameters???
Return: AX = DOS file handle for file
		DS:DX -> filename???
	   = FFFFh if cancelled by user
Note:	available only when popped up
SeeAlso: AX=FFDAh
----------16FFE6-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - CHECK FOR AND GET KEYSTROKE
	AX = FFE6h
Return: AX = 0000h if no key available
	     else  BIOS keycode
Notes:	available only when popped up
	invokes INT 28 idle interrupt before checking for key
----------16FFE7-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFE7h
	BX = segment of ???
Return: ???
Note:	available only when popped up
----------16FFE8-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - DISPLAY NUMBER
	AX = FFE8h
	CX = number
	DH = attribute
	DS:SI -> destination for ASCII number
Return: DS:SI buffer filled in with alternating characters and attributes
----------16FFE9-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - GET FILE LIST???
	AX = FFE9h
Return: BX = segment of file/directory list (14 bytes per file, NUL-padded)
Note:	available only when popped up
----------16FFEA-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - DISPLAY COUNTED STRING
	AX = FFEAh
	DS:SI -> counted string (count byte followed by string)
Return: ???
Note:	available only when popped up
----------16FFEB-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFEBh
	???
Return: ???
----------16FFEC-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - GET KEY
	AX = FFECh
	DS:SI -> FAR routine to ???
	BX = ???
	???
Return: AX = keystroke
	    FFFFh if F10 pressed to go to menu
Notes:	available only when popped up
	invokes INT 28 while waiting for keystroke
	F10 is hotkey to Desktop menu
----------16FFED-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - GET ???
	AX = FFEDh
Return: AX = ???
Note:	available only when popped up
----------16FFEE-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - DEFINE PULLDOWN MENUS
	AX = FFEEh
	DS:SI -> pulldown menu system description (see below)
Return: AX destroyed
Notes:	available only when popped up
	if the accessory does not need any menu items of its own, it should
	  call AX=FFFAh instead
SeeAlso: AX=FFF7h,AX=FFFAh

Format of pulldown menu system description:
Offset	Size	Description
 00h	WORD	offset of menu bar contents (counted string)
 02h	WORD	number of items on menu bar
 04h 10 BYTEs	scan codes for hotkeying to each of up to ten menu items
 0Eh 10	BYTEs	which character to highlight in each menu item (01h=first)
 18h	WORD	offset of first menu definition (see below)
 1Ah	WORD	offset of second menu definition
	...

Format of menu definition:
Offset	Size	Description
 00h	WORD	offset of menu contents (see below)
 02h	WORD	number of entries in menu
 04h	for each entry:
		Offset	Size	Description
		 00h	BYTE	scancode of Alt-key to invoke entry
		 01h	BYTE	character to highlight (01h=first, etc)
		 02h	WORD	offset of FAR routine to handle selection

Format of menu contents:
Offset	Size	Description
 00h	BYTE	number of lines in menu
 01h	BYTE	width of menu
 02h  N BYTEs	counted strings, one for each line in menu
----------16FFEFCX0000-----------------------
INT 16 - PC Tools v5.1+ DESKTOP API - INSTALLATION CHECK
	AX = FFEFh
	CX = 0000h
Return: CX = ABCDh if PC Tools DESKTOP.EXE installed
	    BX = segment of resident portion
	    AX = ??? (v5.1/5.5 only)
SeeAlso: AX=FFC5h,AX=FFF3h
----------16FFF0-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - SET ???
	AX = FFF0h
	DX = ???
Return: AX destroyed
Note:	available only when popped up
----------16FFF1BX0000-----------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ALTERNATE INSTALLATION CHECK
	AX = FFF1h
	BX = 0000h  leave ??? flag as is
	    nonzero set ??? flag
Return: CX = 5555h if installed
	DX = 5555h
----------16FFF2-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - DISPLAY HELP LINE
	AX = FFF2h
	DS:SI -> ASCIZ function key label string (each label preceded by '[')
		or help text
Return: AX destroyed
Notes:	available only when popped up
	if the specified string does not start with '[', it is displayed
	  centered on the bottom line, else the function key labels are shown
----------16FFF3-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - PREPARE TO UNLOAD RESIDENT DESKTOP
	AX = FFF3h
Note:	releases any EMS being used; restores video mode, page, and cursor
	  shape; and restores interrupt vectors
SeeAlso: AX=FFC5h,AX=FFEFh
----------16FFF4-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - ???
	AX = FFF4h
	???
Return: ???
Note:	available only when popped up
SeeAlso: AX=FFF6h
----------16FFF5-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - GET SCREEN ATTRIBUTE ARRAY
	AX = FFF5h
Return: ES:BX -> screen attributes data structure (see below)
	AL = ??? (v6.0+)

Format of attribute data structure:
Offset	Size	Description
 -1	BYTE	attribute for desktop background
 00h	BYTE	attribute for normal characters on desktop menu
 01h	BYTE	attribute for highlighted characters on desktop menu
 02h  5	BYTEs	???
 07h	BYTE	attribute for dialog boxes
 08h 15 BYTEs	???
 17h	BYTE	attribute for message boxes
----------16FFF6-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - INVOKE NOTEPAD EDITOR
	AX = FFF6h
	DS = segment of editor buffer structure (see below)
	BX = ???
	DX = segment of window parameters structure (see AX=FFB5h)
Return: ???
Note:	available only when popped up
SeeAlso: AX=FFF4h

Format of editor buffer structure:
Offset	Size	Description
 00h	WORD	offset of current cursor position in buffer segment
 02h  2 BYTEs	???
 04h	WORD	offset of beginning of file data in buffer segment
 06h 10 BYTEs	???
 10h  N BYTEs	ASCIZ name of file being edited
----------16FFF7-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - PROCESS MENU BAR ENTRY???
	AX = FFF7h
	DS:SI -> ???
	???
Return: ???
Notes:	available only when popped up
	performs input processing on the menu bar set up with AX=FFEEh
SeeAlso: AX=FFEEh,AX=FFFBh
----------16FFF8-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - DRAW EMPTY WINDOW
	AX = FFF8h
	DS:0000h -> window parameters structure (see AX=FFB5h)
	DS:BX -> DWORD to store address of ??? on screen
Return: ???
----------16FFF9-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - DEFINE SCREEN REFRESH ROUTINE
	AX = FFF9h
	ES:BX -> FAR routine to redisplay the utility's window
Note:	available only when popped up
----------16FFFA-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - DEFINE STANDARD PULLDOWN MENUS
	AX = FFFAh
Notes:	available only when popped up
	adds the "Window" option to the "Desktop" option which is the only one
	  available when no accessories are active.  Unlike AX=FFEEh, no
	  additional menu items are added between "Desktop" and "Window"
SeeAlso: AX=FFEEh,AX=FFFBh
----------16FFFB-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - PROCESS STANDARD MENU BAR
	AX = FFFBh
Return: ???
Notes:	available only when popped up
	performs input processing on the standard menu bar set up with AX=FFFAh
SeeAlso: AX=FFF7h
----------16FFFC-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - GET HOTKEYS AND KEYBOARD VECTOR
	AX = FFFCh
Return: ES:BX -> hotkey table (see below)
	DS:DX = original INT 9 vector

Format of hotkey table:
Offset	Size	Description
 00h  2 BYTEs	scancode/shift state for desktop hotkey
 02h  2 BYTEs	scancode/shift state for clipboard paste key
 04h  2 BYTEs	scancode/shift state for clipboard copy key
 06h  2 BYTEs	scancode/shift state for screen autodial key
----------16FFFD-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - COPY ???
	AX = FFFDh
Return: AX destroyed
Note:	copies 4000 bytes from ??? to ??? under certain circumstances
----------16FFFE-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - SHOW MOUSE CURSOR
	AX = FFFEh
SeeAlso: AX=FFFFh,INT 33/AX=0001h
----------16FFFF-----------------------------
INT 16 - PC Tools v5.1+ DESKTOP API - HIDE MOUSE CURSOR
	AX = FFFFh
SeeAlso: AX=FFFEh,INT 33/AX=0002h
----------17----DX0ABC-----------------------
INT 17 - PRINTER - LPTx v5.x INSTALLATION CHECK
	DX = 0ABCh
Return: AX = AAAAh
	DX = BAAAh
	ES = code segment of resident portion
----------17----DX0B90-----------------------
INT 17 - PRINTER - LPTx v6.x INSTALLATION CHECK
	DX = 0B90h
Return: DX = ABBBh
	ES = code segment of resident portion
----------17----DX0B91-----------------------
INT 17 - PRINTER - LPTx v7.x INSTALLATION CHECK
	DX = 0B91h
Return: DX = ABCBh
	ES = code segment of resident portion
----------17----DX0F5F-----------------------
INT 17 - PRINTER - LPTx v4.x INSTALLATION CHECK
	DX = 0F5Fh
Return: AX = AAAAh
	DX = F555h
	ES = code segment of resident portion
----------1700-------------------------------
INT 17 - PRINTER - WRITE CHARACTER
	AH = 00h
	AL = character to write
	DX = printer number (00h-02h)
Return: AH = printer status
	    bit 7: not busy
		6: acknowledge
		5: out of paper
		4: selected
		3: I/O error
		2: unused
		1: unused
		0: timeout
----------1701-------------------------------
INT 17 - PRINTER - INITIALIZE PORT
	AH = 01h
	DX = printer number (00h-02h)
Return: AH = printer status (see AH=00h)
SeeAlso: AH=02h
----------1702-------------------------------
INT 17 - PRINTER - GET STATUS
	AH = 02h
	DX = printer number (00h-02h)
Return: AH = printer status (see AH=00h)
SeeAlso: AH=01h
----------1702--DX0000-----------------------
INT 17 - INSET - INSTALLATION CHECK
	AH = 02h
	DX = 0000h
	CX = 07C3h (1987d)
Return: CX = 07C2h (1986d) if installed
Note:	INSET is a text/graphics integration program
----------172400-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - ENABLE/DISABLE API FUNCTIONS
	AX = 2400h
	DL = new state
	    00h disabled
	    01h enabled
Return: DL = 24h if installed
	DH = minor version number
	CX = network address of this machine
	AL = status
	    00h successful
	    01h timeout
	    02h header error
	    03h data error
	    04h busy
	    05h invalid parameters
SeeAlso: AX=2403h,INT 16/AX=4500h
----------172401-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - RECEIVE BLOCK, NO HANDSHAKE
	AX = 2401h
	BL = timeout in clock ticks
Return: AL = status (see AX=2400h)
	DX:BX -> receive buffer
SeeAlso: AX=2402h,AX=2404h,AX=2408h
----------172402-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - TRANSMIT BLOCK, NO HANDSHAKE
	AX = 2402h
	transmit buffer filled (see AX=2403h)
Return: AL = status (see AX=2400h)
SeeAlso: AX=2401h,AX=2403h,AX=2404h,AX=2409h
----------172403-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - GET STATUS AND TRANSMISSION BUFFER
	AX = 2403h
Return: AL = status (see AX=2400h)
	CX = number of characters in receive ring buffer
	DX:BX -> transmit buffer
SeeAlso: AX=2400h,AX=2402h
----------172404-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - SEND ACK BLOCK
	AX = 2404h
	BX = target address
Return: AL = status (see AX=2400h)
SeeAlso: AX=2402h,AX=2405h
----------172405-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - SEND NAK BLOCK
	AX = 2405h
	BX = target address
Return: AL = status (see AX=2400h)
SeeAlso: AX=2402h,AX=2404h
----------172406-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - PREPARE CHARACTER-ORIENTED RECEIVE
	AX = 2406h
Return: AL = status (see AX=2400h)
SeeAlso: AX=2407h,AX=240Ah
----------172407-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - RECEIVE CHARACTER FROM REMOTE
	AX = 2407h
Return: AL = status (see also AX=2400h)
	    06h end of data
	DL = received character
SeeAlso: AX=2406h
----------172408-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - RECEIVE BLOCK, WITH HANDSHAKE
	AX = 2408h
Return: AL = status (see also AX=2400h)
	    06h end of data
	CX = number of bytes in receive buffer
	DX:SI -> receive buffer
SeeAlso: AX=2401h,AX=2405h,AX=2409h
----------172409-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - TRANSMIT COMMAND, WITH HANDSHAKE
	AX = 2409h
	BX = target address
	CX = number of data byte
	DL = command code to send
	DS:SI -> data bytes for command
Return: AL = status (see also AX=2400h)
	    03h no response
	    06h remote currently unable to perform command
SeeAlso: AX=2405h,AX=2408h
----------17240A-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - PREPARE CHARACTER-ORIENTED TRANSMIT
	AX = 240Ah
Return: AL = status (see AX=2400h)
SeeAlso: AX=2406h,AX=240Bh,AX=240Ch
----------17240B-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - TRANSMIT SINGLE CHARACTER TO REMOTE
	AX = 240Bh
	DL = character to send
Return: AL = status (see also AX=2400h)
	    03h transmission error
	    06h write error
SeeAlso: AX=2407h,AX=240Ah,AX=240Ch
----------17240C-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - END CHARACTER-ORIENTED TRANSMIT
	AX = 240Ch
Return: AL = status (see also AX=2400h)
	    03h transmission error
	    06h remote breaks connection
SeeAlso: AX=240Ah,AX=240Bh
----------1760-------------------------------
INT 17 - FLASHUP.COM - INSTALLATION CHECK
	AH = 60h
Return: AL = 60h
	DX = CS of resident code
Notes:	FLASHUP.COM is part of Flash-Up Windows by The Software Bottling Co.
	FLASHUP also hooks INT 10 and received commands via INT 10/AH=09h,0Ah
	  consisting of an 80h followed by the actual command
SeeAlso: INT 10/AH=09h,INT 10/AH=0Ah
----------1761-------------------------------
INT 17 - SPEEDSCR.COM - INSTALLATION CHECK
	AH = 61h
Return: AL = 61h
	DX = CS of resident code
Note:	SPEEDSCR.COM is by The Software Bottling Co.
----------1781-------------------------------
INT 17 - Alloy NTNX, MW386 - CANCEL JOBS FOR CURRENT USER
	AH = 81h
	AL = 00h (NTNX compatibility mode)
	CL = number of jobs to cancel
Return: AL = status
	    00h success
	    01h..7Fh warning
	    80h general failure
	    81h host overloaded (NTNX only)
	    82h module busy (NTNX only)
	    83h host busy (NTNX only)
	    84h re-entry flag set
	    85h invalid request
	    86h invalid printer
	    87h invalid process ID
	    89h access denied
	    8Ah option not available for given port type
	    8Bh option not available for given task type
	    91h printer busy
	    C2h file not found
	    C3h path not found
	    C4h file access failure
Note:	cancels the last CL printouts for the current task
SeeAlso: AH=82h
----------1782-------------------------------
INT 17 - Alloy NTNX, MW386 - CANCEL ALL JOBS FOR CURRENT USER
	AH = 82h
	AL = 00h (NTNX compatibility mode)
Return: AL = status (see AH=81h)
SeeAlso: AH=81h
----------1783-------------------------------
INT 17 - Alloy NTNX, MW386 - SET NUMBER OF COPIES
	AH = 83h
	AL = mode
	    00h NTNX compatibility
		CL = number of copies (max 99, default 1)
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
		CX = number of copies
Return: AL = status (see AH=81h)
Note:	in NTNX compatibility mode, this function only affects LPT1
----------1784-------------------------------
INT 17 - Alloy NTNX, MW386 - GENERATE PRINT BREAK
	AH = 84h
	AL = mode
	    00h NTNX compatibility
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
Note:	closes spool file and tells spooler to queue the print job (LPT1 only
	  under MW386 in NTNX compatibility mode)
----------1787-------------------------------
INT 17 - Alloy NTNX - SET INDOS POINTER
	AH = 87h
	AL = 00h
	CX:BX -> buffer for user-written printer drivers
Return: BX,CX destroyed
Note:	must be executed before the printer is enabled
SeeAlso: AH=8Ah
----------1788-------------------------------
INT 17 - Alloy NTNX, MW386 - REMOVE PRINTER FROM SPOOLER
	AH = 88h
	AL = mode
	    00h NTNX compatibility
		DX = NTNX printer number
		    00h host LPT1
		    01h host LPT2
		    02h host LPT3
		    03h host LPT4
		    04h host COM1
		    05h host COM2
		    06h user's logical COM2
		    07h user's terminal AUX port
		    08h user's logical COM1 (MW386 only)
	    01h MW386
		DX = MW386 printer number
Return: AH = status (see AH=81h)
Note:	removes specified printer from the spooler's list of printers
SeeAlso: AH=89h,AH=8Bh
----------1789-------------------------------
INT 17 - Alloy NTNX, MW386 - ADD PRINTER TO SPOOLER
	AH = 89h
	AL = mode
	    00h NTNX compatibility
		DX = NTNX printer number (see AH=88h)
	    01h MW386
		DX = MW386 printer number
Return: AL = status (see AH=81h)
Note:	the specified printer is added to the spooler's list of available
	  printers
SeeAlso: AH=88h,AH=8Bh
----------178A-------------------------------
INT 17 - Alloy NTNX - ACTIVATE USER-WRITTEN PRINTER DRIVER
	AH = 8Ah
	???
SeeAlso: AH=92h
----------178B-------------------------------
INT 17 - Alloy MW386 - GET PHYSICAL DEVICE NUMBER FROM NAME
	AH = 8Bh
	DS:DX -> ASCIZ printer name
Return: AL = status (see also AH=81h)
	    00h successful
		DX = physical device number
SeeAlso: AH=89h,AH=8Ch,INT 14/AH=20h"Alloy"
----------178C-------------------------------
INT 17 - Alloy MW386 - GET DEVICE NAME FROM PHYSICAL DEVICE NUMBER
	AH = 8Ch
	DX = physical device number
	ES:DI -> 17-byte buffer for ASCIZ device name
Return: AL = status (see also AH=81h)
	    00h successful
		ES:DI buffer filled
SeeAlso: AH=88h,AH=8Bh
----------178D-------------------------------
INT 17 - Alloy NTNX - RESET SPOOLER
	AH = 8Dh
	AL = 00h
Note:	clears all buffers and resets spooler to boot-up values
Return: AL = status (see AH=81h)
----------178E-------------------------------
INT 17 - Alloy NTNX - GET INT 28 ENTRY POINT
	AH = 8Eh
	AL = 00h
Return: CX:BX -> INT 28 entry point
SeeAlso: AH=8Fh
----------178F-------------------------------
INT 17 - Alloy NTNX - GET DOS INTERCEPT ENTRY POINT
	AH = 8Fh
	AL = 00h
Return: CX:BX -> DOS intercept routine
SeeAlso: AH=8Eh
----------1790-------------------------------
INT 17 - Alloy NTNX, MW386 - SPOOL FILE BY NAME
	AH = 90h
	AL = mode
	    00h NTNX compatibility
		DL = printer code (FFh=current) (NTNX, MW386 v1.x only)
		DH = number of copies (FFh=current) (NTNX, MW386 v1.x only)
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
	CX:SI -> ASCIZ pathname
Return: AL = status (see AH=81h)
Note:	in mode 00h, the file is always sent to logical LPT1
SeeAlso: AH=A0h
----------1791-------------------------------
INT 17 - Alloy NTNX, MW386 - GET USER NUMBER AND CURRENT PRINTER
	AH = 91h
	AL = mode
	    00h NTNX compatibility
		Return: CX = user number (00h = host)
			DX = currently selected printer number (00h-08h)
	    01h MW386
		Return: CX = user number
			DX = physical dev number of currently selected printer
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
		Return: CX = user number
			DX = physical device number
Return: AL = status (see AH=81h)
SeeAlso: AH=8Ch
----------1792-------------------------------
INT 17 - Alloy NTNX - CHECK PRINTER DRIVER
	AH = 92h
	AL = 00h
	CL = 00h
Return: CL = driver state
	    01h initialized
	    80h not initialized
	AX = status (see AH=81h)
SeeAlso: AH=8Ah
----------1794-------------------------------
INT 17 - Alloy NTNX, MW386 - SELECT PRINTER
	AH = 94h
	AL = mode
	    00h NTNX compatibility
		DX = NTNX printer number (see AH=88h)
	    01h MW386
		DX = MW386 printer number
	    02h MW386 v2+
		BX = logical printer number
		DX = MW386 printer number
Return: AL = status (see AH=81h)
Note:	modes 00h and 01h affect only logical LPT1
SeeAlso: AH=8Bh,AH=95h
----------1795-------------------------------
INT 17 - Alloy NTNX, MW386 - GET CURRENT PRINTER
	AH = 95h
	AL = mode
	    00h NTNX compatibility
		Return: DX = NTNX printer number (see AH=88h)
			    (FFFFh if current printer not compatible with NTNX)
	    01h MW386
		Return: DX = MW386 printer number
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
		Return: DX = MW386 printer number (FFFFh = none)
Return: AL = status (see AH=81h)
Note:	modes 00h and 01h return the printer number of logical LPT1 only
SeeAlso: AH=94h
----------1796-------------------------------
INT 17 - Alloy NTNX - SET SERIAL PORT PARAMETERS
	AH = 96h
	AL = 00h
Note:	documentation states that this is a NOP, doing only XOR AX,AX before
	  returning
SeeAlso: INT 14/AH=24h
----------1797-------------------------------
INT 17 - Alloy NTNX, MW386 - SET DATA DRIVEN PRINT BREAK
	AH = 97h
	AL = mode
	    00h NTNX compatibility
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
	CH,CL,DH = three character break sequence
	DL = subfunction
	    00h set break string
	    else reset break
Return: AL = status (see AH=81h)
Notes:	mode 00h affects only logical LPT1
	when the break string is encountered, the spool file will be closed and
	  queued for printing automatically
	the break string is not permanently saved, and will be reset each time
	  MW386 or the user is rebooted
SeeAlso: AH=9Bh
----------1798-------------------------------
INT 17 - Alloy NTNX - RESTART PRINTER
	AH = 98h
	AL = 00h
	DL = printer number (FFh=current)
Return: AL = status
	    00h successful
	    01h incorrect printer
	    02h task not found
----------1799-------------------------------
INT 17 - Alloy NTNX, MW386 - GET/SET PRINTER MODE
	AH = 99h
	AL = mode
	    00h NTNX compatibility
		DL = NTNX printer number (see AH=88h)
			(FFh = task's current logical LPT1)
		DH = mode
		    bit 0: get mode if 1, set mode if 0
			1: private ("attached")
			2: direct instead of spooled
			3-7 reserved (0)
	    01h MW386
		DX = MW386 printer number
		CL = mode (as for DH above)
Return: AL = status (see AH=81h)
	DH = mode (bits 1 and 2 set as above)
	DL = printer owner's user number if not spooled
----------179A-------------------------------
INT 17 - Alloy MW386 - SET TAB EXPANSION
	AH = 9Ah
	AL = mode
	    00h NTNX compatibility
		DX = NTNX printer number (see AH=88h)
			(FFFFh = current logical LPT1)
	    01h MW386
		DX = MW386 printer number
	CL = tab length (00h = no expansion, 01h-63h = spaces per tab)
Return: AL = status (see AH=81h)
Note:	beginning with MW386 v2.0, tab expansion is set on a per-printer basis
	  rather than a per-user basis; NTNX and MW386 v1.x ignore DX
SeeAlso: AH=A4h
----------179B-------------------------------
INT 17 - Alloy MW386 - SET PRINT BREAK TIMEOUT
	AH = 9Bh
	AL = mode
	    00h NTNX compatibility
		CX = timeout value in clock ticks (1/18 sec) (00h = never)
	    01h MW386
		CX = timeout value in seconds (00h = never)
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
		CX = timeout value in seconds (00h = never)
Return: AL = status (see AH=81h)
Notes:	modes 00h and 01h affect only the current logical LPT1
	if no data is sent to a printer for the specified amount of time, the
	  spool file will be closed and queued for printing automatically
SeeAlso: AH=97h
----------17A0-------------------------------
INT 17 - Alloy MW386 - SPOOL COPY OF FILE
	AH = A0h
	AL = mode
	    00h NTNX compatibility
		DX = ??? (NTNX, MW386 v1.x only)
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
	CX:SI -> ASCIZ pathname
Return: AL = status (see AH=81h)
Notes:	makes a copy of the specified file in the spooler's directory, allowing
	  the original file to be modified or deleted while the copy is printed
	in mode 00h, the file is printed on logical LPT1
SeeAlso: AH=90h
----------17A4-------------------------------
INT 17 - Alloy MW386 - ENABLE/DISABLE FORM FEED
	AH = A4h
	AL = new state
	    00h form feed after end of print job disabled
	    01h form feed enabled
Return: AL = status (see AH=81h)
Note:	only affects the current logical LPT1
SeeAlso: AH=9Ah,AH=A6h,INT 7F/AH=05h"NTNX (Host)"
----------17A6-------------------------------
INT 17 - Alloy MW386 - ENABLE/DISABLE BANNER PAGE
	AH = A6h
	AL = new state
	    00h banner page before print job disabled
	    01h banner page enabled
Return: AL = status (see AH=81h)
Note:	only affects the current logical LPT1
SeeAlso: AH=A4h
----------17A7-------------------------------
INT 17 - Alloy MW386 v2+ - GET/SET SPOOL FLAGS
	AH = A7h
	AL = spool flags
	    bit 0: banner page enabled (see AH=A4h)
		1: form feed enabled (see AH=A6h)
		2-6: reserved (0)
		7: set flags if 1, get flags if 0
	BX = logical device number
	    00h-03h = LPT1-LPT4
	    04h-07h = COM1-COM4
Return: AL = status (see AH=81h)
Note:	the documentation does not state which register contains the result of
	  a GET
SeeAlso: AH=A4h,AH=A6h
----------17A8-------------------------------
INT 17 - Alloy MW386 - DEFINE TEMPORARY FILENAME
	AH = A8h
	CX:SI -> ASCIZ filename without extension (max 8 chars)
Return: AL = status (see AH=81h)
Note:	allows application to specify banner page filename for spool files
	  collected from the application's printer output
SeeAlso: AH=A9h
----------17A9-------------------------------
INT 17 - Alloy MW386 - CHANGE TEMPORARY SPOOL DRIVE
	AH = A9h
	AL = new spool drive (2=C:,3=D:,etc)
Return: AL = status (see AH=81h)
Note:	does not remove previous spooling directory since jobs may be pending
SeeAlso: AH=A8h
----------17AA-------------------------------
INT 17 - Alloy MW386 v2+ - GET REAL-TIME PRINTER STATUS
	AH = AAh
	AL = mode
	    00h NTNX
		DX = NTNX printer number (see AH=88h)
	    01h MW386
		DX = MW386 printer number
Return: AH = instantaneous printer status
	    00h printer ready
	    01h not ready
	    12h off line
	    13h out of paper
	    14h general device failure
	    15h device timeout
	    16h bad device number
----------17AF-------------------------------
INT 17 - Alloy MW386 - CHECK SPOOLER
	AH = AFh
Return: AX = 55AAh if spooler available
----------17C0-------------------------------
INT 17 - PC Magazine PCSpool - GET CONTROL BLOCK ADDRESS
	AH = C0h
	DX = printer port (0-3)
Return: ES:BX -> control block
SeeAlso: AH=C1h
----------17C1--------------------------------
INT 17 - PC Magazine PCSpool - BUILD CONTROL RECORD
	AH = C1h
	DX = printer port (0-3)
	DS:SI -> ASCIIZ string to save for display
Note:	flushes pending writes
SeeAlso: AH=C0h,AH=C2h
----------17C2-------------------------------
INT 17 - PC Magazine PCSpool - FLUSH PENDING WRITES
	AH = C2h
	DX = printer port (0-3)
SeeAlso: AH=C3h
----------17C3-------------------------------
INT 17 - PC Magazine PCSpool - CANCEL PRINTER QUEUE (FLUSH ALL QUEUED OUTPUT)
	AH = C3h
	DX = printer port (0-3)
SeeAlso: AH=C2h,AH=C7h
----------17C4-------------------------------
INT 17 - PC Magazine PCSpool - QUERY SPOOLER ACTIVE
	AH = C4h
Return: DI = B0BFh
	SI = segment
----------17C5-------------------------------
INT 17 - PC Magazine PCSpool - JOB SKIP PRINTER QUEUE
	AH = C5h
	DX = printer port (0-3)
Note:	cancels up to the pause record 
----------17C6-------------------------------
INT 17 - PC Magazine PCSpool - CHECK PRINTER QUEUE STATUS
	AH = C6h
	DX = printer port (0-3)
Return: AX = 0 printer not active or at pause
	   = 1 printer busy
----------17C7-------------------------------
INT 17 - PC Magazine PCSpool - CLOSE QUEUE
	AH = C7h
	DX = printer port (0-3)
SeeAlso: AH=C3h
----------17CD00-----------------------------
INT 17 - INSET - EXECUTE COMMAND STRING
	AX = CD00h
	DS:DX -> ASCIZ command string (max 80 bytes)
Return: CX = 07C2h (1986d)
Note:	user interface menus pop up after last command, unless that command
	exits INSET
----------17CD01-----------------------------
INT 17 - INSET - GET IMAGE SIZE
	AX = CD01h
	DS:DX -> ASCIZ name of image file
Return: AX = height in 1/720th inch
	BX = width in 1/720th inch
	CX = 07C2h (1986d)
----------17CD02-----------------------------
INT 17 - INSET - INITIALIZE
	AX = CD02h
Return: CX = 07C2h (1986d)
Note:	all open files are closed and the printer is reset
SeeAlso: AX=CD04h
----------17CD03-----------------------------
INT 17 - INSET - EXECUTE INSET MENU WITHIN OVERRIDE MODE
	AX = CD03h
Return: CX = 07C2h (1986d)
----------17CD04-----------------------------
INT 17 - INSET - INITIALIZE LINKED MODE
	AX = CD04h
	ES:DI -> FAR routine for linked mode
Return: CX = 07C2h
Note:	calling sequence for linked-mode routine
	AL = 00h send character in BL to printer
	   = 01h send CX bytes from DS:DX to printer
	   = 02h move print head to horizontal starting position of image
	return code for linked-mode routine:
	AX = 0000h success
	   = 0001h failure
SeeAlso: AX=CD02h,AX=CD08h
----------17CD05-----------------------------
INT 17 - INSET - START MERGING IMAGE INTO TEXT
	AX = CD05h
	DS:DX -> ASCIZ name of PIX file
	CX = left margin of text in 1/720th inch
Return: AH = printer type
	    00h page-oriented (multiple images may be placed side-by-side)
	    01h line-oriented (use AX=CD06h for vertical paper movement)
	CX = 07C2h (1986d)
SeeAlso: AX=CD07h
----------17CD06-----------------------------
INT 17 - INSET - GRAPHICS LINE FEED
	AX = CD06h
Return: AH = completion status
	    00h image complete
	    01h image incomplete
	CX = 07C2h (1986d)
SeeAlso: AX=CD09h
----------17CD07-----------------------------
INT 17 - INSET - FLUSH GRAPHICS FROM MERGE BUFFER
	AX = CD07h
Return: CX = 07C2h
SeeAlso: AX=CD05h
----------17CD08-----------------------------
INT 17 - INSET - CANCEL LINK MODE
	AX = CD08h
Return: CX = 07C2h
SeeAlso: AX=CD04h
----------17CD09-----------------------------
INT 17 - INSET - ALTER GRAPHICS LINE SPACING
	AX = CD09h
	CX = line spacing in 1/720th inch
Return: CX = 07C2h
Note:	not yet implemented, line spacing is currently fixed at 1/6 inch
SeeAlso: AX=CD06h
----------17CD0A-----------------------------
INT 17 - INSET - GET SETUP
	AX = CD0Ah
	DS:DX -> buffer for IN.SET data
Return: CX = 07C2h
----------17CD0B-----------------------------
INT 17 - INSET - START GETTING SCALED IMAGE
	AX = CD0Bh
	DS:SI -> ASCIZ pathname of .PIX file
	BX = number of bitplanes
	CX = number of rows in output bitmap
	DX = number of columns in output bitmap
Return: AX = status
	    0000h OK
	    FFFFh error	
Note:	image is returned in strips by repeated calls to AX=CD0Ch
----------17CD0C-----------------------------
INT 17 - INSET - GET NEXT IMAGE STRIP
	AX = CD0Ch
Return:	AX = status
	    0000h OK but not complete
	    0001h OK and image complete
	    FFFFh error
	DS:SI -> buffer (max 4K) for bit map strip 
	CX = start row
	DX = number of rows
	BX = offset in bytes between bit planes
Note:	buffer may be overwritten by subsequent calls
SeeAlso: AX=CD0Bh
----------17F0-------------------------------
INT 17 - NorthNet Jetstream API - INSTALLATION CHECK
	AH = F0h
	DX = printer port (0-3)
Return: AX = 0001h Jetstream present
	     else  non-Jetstream port
Note:	NorthNet Jetstream is a high-performance DMA-driven parallel card able
	  to drive printers at up to 80000 characters per second
----------17F1-------------------------------
INT 17 - NorthNet Jetstream API - PRINT DATA BUFFER
	AH = F1h
	CX = data buffer length
	DX = printer port (0-3)
	DS:SI -> data buffer
Return: AX = status
	    0000h printer not ready (see also AH=02h)
	    other printing started
SeeAlso: AH=F2h,AH=F3h,AH=F5h
----------17F2-------------------------------
INT 17 - NorthNet Jetstream API - GET PRINT PROGRESS STATUS
	AH = F2h
	DX = printer port (0-3)
Return: AX = status
	    0000h prior print request finished
	    other number of characters left to print
SeeAlso: AH=F1h,AH=F3h
----------17F3-------------------------------
INT 17 - NorthNet Jetstream API - ABORT PRINT OPERATION
	AH = F3h
	DX = printer port (0-3)
Return: AX = number of unprinted characters due to abort
SeeAlso: AH=F1h,AH=F4h
----------17F4-------------------------------
INT 17 - NorthNet Jetstream API - SET COMPLETION (POST) ADDRESS
	AH = F4h
	DX = printer port (0-3)
	DS:DS -> FAR post address (called with interrupts on)
SeeAlso: AH=F1h,AH=F3h
----------17F5-------------------------------
INT 17 - NorthNet Jetstream API - PRINT DATA BUFFER FROM EXTENDED MEMORY
	AH = F5h
	CX = data buffer length
	DX = printer port (0-3)
	DS:SI -> data buffer (32-bit physical address)
Return: AX = status
	    0000h printer not ready (see also AH=02h)
	    other printing started
SeeAlso: AH=F1h
----------18---------------------------------
INT 18 - START CASSETTE BASIC
Note:	only PCs produced by IBM contain BASIC in ROM, so the action is
	  unpredicatable on compatibles; this interrupt often reboots the
	  system, and often has no effect at all
SeeAlso: INT 86"NetBIOS"
----------19---------------------------------
INT 19 - SYSTEM - BOOTSTRAP LOADER
   Reboot the system without clearing memory or restoring interrupt vectors.
   Because interrupt vectors are preserved, this interrupt usually causes a
   system hang if any TSRs have hooked vectors from 00h through 1Ch,
   particularly INT 08.

   Usually, the BIOS will try to read sector 1, head 0, track 0 from drive A:
   to 0000h:7C00h.  If this fails, and a hard disk is installed, the BIOS will
   read sector 1, head 0, track 0 of the first hard disk.  This sector should
   contain a master bootstrap loader and a partition table.  After loading the
   master boot sector at 0000h:7C00h, the master bootstrap loader is given
   control.  It will scan the partition table for an active partition, and will
   then load the operating system's bootstrap loader (contained in the first
   sector of the active partition) and give it control.

   True IBM PCs issue an INT 18 if neither floppy nor hard disk have a valid
   boot sector.

Notes:	to accomplish a warm boot equivalent to Ctrl-Alt-Del, store 1234h in
	  0040h:0072h and jump to FFFFh:0000h.	For a cold boot equivalent to
	  a reset, store 0000h at 0040h:0072h before jumping.
	VDISK.SYS hooks this interrupt to allow applications to find out how
	  much extended memory has been used by VDISKs (the three bytes at
	  offset 2Ch in the INT 19 handler's segment contain the linear address
	  of the first free extended memory).
	default handler is at F000h:E6F2h for 100% compatible BIOSes
SeeAlso: INT 14/AH=17h,INT 18

Format of hard disk master boot sector:
Offset	Size	Description
 00h 446 BYTEs	Master bootstrap loader code
1BEh 16 BYTEs	partition record for partition 1 (see below)
1CEh 16 BYTEs	partition record for partition 2
1DEh 16 BYTEs	partition record for partition 3
1EEh 16 BYTEs	partition record for partition 4
1FEh	WORD	signature, AA55h indicates valid boot block

Format of partition record:
Offset	Size	Description
 00h	BYTE	boot indicator (80h = active partition)
 01h	BYTE	partition start head
 02h	BYTE	partition start sector (bits 0-5)
 03h	BYTE	partition start track (bits 8,9 in bits 6,7 of sector)
 04h	BYTE	operating system indicator (see below)
 05h	BYTE	partition end head
 06h	BYTE	partition end sector (bits 0-5)
 07h	BYTE	partition end track (bits 8,9 in bits 6,7 of sector)
 08h	DWORD	sectors preceding partition
 0Ch	DWORD	length of partition in sectors

Values for operating system indicator:
 00h empty
 01h DOS 12-bit FAT
 02h XENIX file system
 03h XENIX /usr file system (obsolete)
 04h DOS 16-bit FAT
 05h DOS 3.3+ extended partition
 06h DOS Large File System
 07h QNX, OS/2 HPFS
 08h AIX bootable partition
 09h AIX data partition
 51h Disk Manager
 52h CP/M
 56h GB ???
 61h SpeedStor
 63h SysV/386
 64h Novell NetWare
 75h PC/IX
 80h Minix v1.3 and below
 81h Minix v1.5+
 DBh CP/M
 E1h SpeedStor 12-bit FAT extended partition
 E4h SpeedStor 16-bit FAT extended partition
 FEh LANstep
 FFh Bad Blocks
----------1A00-------------------------------
INT 1A - TIME - GET SYSTEM TIME
	AH = 00h
Return: CX:DX = number of clock ticks since midnight
	AL = midnight flag, nonzero if midnight passed since time last read
Notes:	there are approximately 18.2 clock ticks per second, 1800B0h per 24 hrs
	IBM and many clone BIOSes set the flag for AL rather than incrementing
	  it, leading to loss of a day if two consecutive midnights pass
	  without a request for the time (e.g. if the system is on but idle)
SeeAlso: AH=01h,AH=02h,INT 21/AH=2Ch
----------1A01-------------------------------
INT 1A - TIME - SET SYSTEM TIME
	AH = 01h
	CX:DX = number of clock ticks since midnight
SeeAlso: AH=00h,AH=03h,INT 21/AH=2Dh
----------1A02-------------------------------
INT 1A - TIME - GET REAL-TIME CLOCK TIME (AT,XT286,PS)
	AH = 02h
Return: CF clear if successful
	    CH = hour (BCD)
	    CL = minutes (BCD)
	    DH = seconds (BCD)	
	    DL = daylight savings flag (00h standard time, 01h daylight time)
	CF set on error (i.e. clock not running or in middle of update)
SeeAlso: AH=00h
----------1A03-------------------------------
INT 1A - TIME - SET REAL-TIME CLOCK TIME (AT,XT286,PS)
	AH = 03h
	CH = hour (BCD)
	CL = minutes (BCD)
	DH = seconds (BCD)
	DL = daylight savings flag (00h standard time, 01h daylight time)
SeeAlso: AH=01h
----------1A04-------------------------------
INT 1A - TIME - GET REAL-TIME CLOCK DATE (AT,XT286,PS)
	AH = 04h
Return: CF clear if successful
	    CH = century (BCD)
	    CL = year (BCD)
	    DH = month (BCD)
	    DL = day (BCD)
	CF set on error
SeeAlso: AH=02h,AH=05h,INT 21/AH=2Ah
----------1A05-------------------------------
INT 1A - TIME - SET REAL-TIME CLOCK DATE (AT,XT286,PS)
	AH = 05h
	CH = century (BCD)
	CL = year (BCD)
	DH = month (BCD)
	DL = day (BCD)
SeeAlso: AH=04h,INT 21/AH=2Bh
----------1A06-------------------------------
INT 1A - TIME - SET ALARM (AT,XT286,PS)
	AH = 06h
	CH = hour (BCD)
	CL = minutes (BCD)
	DH = seconds (BCD)
Return: CF set on error (alarm already set or clock stopped for update)
	CF clear if successful
Note:	the alarm occurs every 24 hours until turned off, invoking INT 4A each
	  time
SeeAlso: AH=07h,INT 4A
----------1A07-------------------------------
INT 1A - TIME - CANCEL ALARM (AT,XT286,PS)
	AH = 07h
Return: alarm disabled
Note:	does not disable the real-time clock's IRQ
SeeAlso: AH=06h,INT 70
----------1A08-------------------------------
INT 1A - TIME - SET RTC ACTIVATED POWER ON MODE (CONVERTIBLE)
	AH = 08h
	CH = hours in BCD
	CL = minutes in BCD
	DH = seconds in BCD
----------1A09-------------------------------
INT 1A - TIME - READ RTC ALARM TIME AND STATUS (CONV,PS30)
	AH = 09h
Return: CH = hours in BCD
	CL = minutes in BCD
	DH = seconds in BCD
	DL = alarm status
	    00h alarm not enabled
	    01h alarm enabled but will not power up system
	    02h alarm will power up system
----------1A0A-------------------------------
INT 1A - TIME - READ SYSTEM-TIMER DAY COUNTER (XT2,PS)
	AH = 0Ah
Return: CF set on error
	CF clear if successful
	    CX = count of days since Jan 1,1980
SeeAlso: AH=04h,AH=0Bh
----------1A0B-------------------------------
INT 1A - TIME - SET SYSTEM-TIMER DAY COUNTER (XT2,PS)
	AH = 0Bh
	CX = count of days since Jan 1,1980
Return: CF set on error
	CF clear if successful
SeeAlso: AH=05h,AH=0Ah
----------1A3601-----------------------------
INT 1A - WORD PERFECT 5.0 Third Party Interface - INSTALLATION CHECK
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
----------1A80-------------------------------
INT 1A - PCjr - SET UP SOUND MULTIPLEXOR
	AH = 80h
	AL = 00h source is 8253 channel 2
	     01h source is cassette input
	     02h source is I/O channel "Audio IN"
	     03h source is sound generator chip
----------1AA0-------------------------------
INT 1A - Disk Spool II v??? - INSTALLATION CHECK
	AH = A0h
Return: AH = B0h
	ES = code segment
	BX -> name of current spool file
	SI -> current despool file
	CL = 00h despooler is disabled
	   = 41h despooler is enabled
	CH = 00h spooler is disabled
	   = 41h spooler is enabled
	DL = 00h despooler is currently active printing a file
	   = 41h despooler is standing by
SeeAlso: AH=D0h
----------1AAB-------------------------------
INT 1A - Disk Spool II v1.83 - INSTALLATION CHECK
	AH = ABh
Return: ES = code segment
	BX -> name of current spool file
	SI -> current despool file
	CL = ???
	CH = ???
	DL = ???
	DH = 00h ???
	   = 41h ???
	AL = ???
	AH = BAh
	DI = 0000h ???
	     0001h ???
SeeAlso: AH=ACh,AH=ADh
----------1AAC-------------------------------
INT 1A - Disk Spool II v1.83 - INSTALLATION CHECK
	AH = ACh
Return: (see AH=ABh)
Note:	this function is identical to AH=ABh
SeeAlso: AH=ABh,AH=ADh
----------1AAD-------------------------------
INT 1A - Disk Spool II v1.83 - FUNCTION CALLS
	AH = ADh
	AL = function code
	    02h enable spooler only
	    03h enable the despooler
	    04h disable the despooler
	    08h inhibit popup menu
	    09h enable popup menu
	    0Ah ???
	    0Bh disable the spooler
	    0Ch ???
	    0Dh ???
	    0Eh pop up the menu
	    0Fh ???
	    11h ???
	    14h ???
	    15h ???
	    16h ???
	    17h ???
	    18h ???
	    19h ???
	    20h ???
	    21h	???
	    22h	???
	    23h ???
	    30h ???
Return: AH = 00h if successful
SeeAlso: AH=ABh
----------1AD0-------------------------------
INT 1A - Disk Spool II v??? - FUNCTION CALLS
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
	    0Bh disable the spooler
	    0Ch start despooler after last successfully printed document
	    0Dh start despooler at the exact point where it last left off
	    0Eh pop up the menu
	    20h clear file pointed to by the despooler
SeeAlso: AH=A0h
----------1AFE-------------------------------
INT 1A - AT&T 6300 - READ TIME AND DATE
	AH = FEh
Return: BX = day count (0 = Jan 1, 1984)
	CH = hour
	CL = minute
	DH = second
	DL = hundredths
SeeAlso: AH=FFh,INT 21/AH=2Ah,INT 21/AH=2Ch
----------1AFF-------------------------------
INT 1A - AT&T 6300 - SET TIME AND DATE
	AH = FFh
	BX = day count (0 = Jan 1, 1984)
	CH = hour
	CL = minute
	DH = second
	DL = hundredths
Return: ???
SeeAlso: AH=FEh,INT 21/AH=2Bh,INT 21/AH=2Dh
----------1B---------------------------------
INT 1B - KEYBOARD - CONTROL-BREAK HANDLER
   called when INT 09 determines that Control-Break has been pressed
Note:	normally points to a short routine in DOS which sets the Ctrl-C flag,
	  thus invoking INT 23h the next time DOS checks for Ctrl-C.
SeeAlso: INT 23
----------1C---------------------------------
INT 1C - TIME - SYSTEM TIMER TICK
   called on each clock tick by the INT 08 handler
Note:	preferred interrupt to chain when a program needs to be invoked
	  regularly
SeeAlso: INT 08
----------1D---------------------------------
INT 1D - SYSTEM DATA - VIDEO PARAMETER TABLES
Note:	default parameter table at F000h:F0A4h for 100% compatible BIOSes
SeeAlso: INT 10/AH=00h

Format of video parameters:
Offset	Size	Description
 00h 16 BYTEs	6845 register values for modes 00h and 01h
 10h 16 BYTEs	6845 register values for modes 02h and 03h
 20h 16 BYTEs	6845 register values for modes 04h and 05h
 30h 16 BYTEs	6845 register values for modes 06h and 07h
 40h	WORD	bytes in video buffer for modes 00h and 01h
 42h	WORD	bytes in video buffer for modes 02h and 03h
 44h	WORD	bytes in video buffer for modes 04h and 05h
 46h	WORD	bytes in video buffer for modes 06h and 07h
 48h  8 BYTEs	columns on screen for each of modes 00h through 07h
 50h  8 BYTEs	CRT controller mode bytes for each of modes 00h through 07h
----------1E---------------------------------
INT 1E - SYSTEM DATA - DISKETTE PARAMETERS
Note:	default parameter table at F000h:EFC7h for 100% compatible BIOSes
SeeAlso: INT 13/AH=0Fh,INT 41

Format of diskette parameter table:
Offset	Size	Description
 00h	BYTE	first specify byte
		bits 7-4: step rate
		     3-0: head unload time (0Fh = 240 ms)
 01h	BYTE	second specify byte
		bits 7-1: head load time (01h = 4 ms)
		       0: non-DMA mode (always 0)
 02h	BYTE	delay until motor turned off (in clock ticks)
 03h	BYTE	bytes per sector (00h = 128, 01h = 256, 02h = 512, 03h = 1024)
 04h	BYTE	sectors per track
 05h	BYTE	length of gap between sectors (2Ah for 5.25", 1Bh for 3.5")
 06h	BYTE	data length (ignored if bytes-per-sector field nonzero)
 07h	BYTE	gap length when formatting (50h for 5.25", 6Ch for 3.5")
 08h	BYTE	format filler byte (default F6h)
 09h	BYTE	head settle time in milliseconds
 0Ah	BYTE	motor start time in 1/8 seconds
----------1F---------------------------------
INT 1F - SYSTEM DATA - 8x8 GRAPHICS FONT
   points at 1024 bytes of graphics data, 8 bytes for each character 80h-FFh
Note:	graphics data for characters 00h-7Fh stored at F000h:FA6Eh in 100%
	  compatible BIOSes
---------------------------------------------
