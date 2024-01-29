INT 60 - reserved for user interrupt
---------------------------------------------
INT 60 - FTP Driver - PC/TCP Packet Driver Specification
   The handler for the interrupt will start with a 3-byte jump instruction, 
   followed by the ASCIZ string "PKT DRVR".  To find the interrupt being used
   by the driver, an application should scan through interrupt vectors 60h to
   80h until it finds one with the "PKT DRVR" string.

Network Interface classes/types:
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
INT 60 - FTP Driver - DRIVER INFO
	AX = 01FFh
	BX = handler returned by function 02h
Return: CF set on error
	    DH = error code
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
	CF clear if successful
	    BX = version
	    CH = class	    	
	    DX = type
	    CL = number
	    DS:SI -> name
	    AL = driver type
		01h basic
		02h extended
		FFh not installed
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
	    DH = error code (see above)
	CF clear if successful
	    AX = handle	    	

Receiver called with
	AX = subfunction
	    00h application to return pointer to buffer in ES:DI
		ES:DI = 0:0 means throw away packet
	    01h copy to DS:SI buffer completed
	BX = handle
	CX = buffer length
when a packet is received
---------------------------------------------
INT 60 - FTP Driver - RELEASE TYPE
	AH = 03h
	BX = handle
Return: CF set on error
	   DH = error code (see above)
	CF clear if successful	
---------------------------------------------
INT 60 - FTP Driver - SEND PACKET
	AH = 04h
	DS:SI -> buffer
	CX = length
Return: CF set on error
	    DH = error code (see above)
---------------------------------------------
INT 60 - FTP Driver - TERMINATE DRIVER FOR HANDLE
	AH = 05h
	BX = handle
Return: CF set on error
	   DH = error code (see above)
---------------------------------------------
INT 60 - FTP Driver - GET ADDRESS
	AH = 06h
	BX = handle
	ES:DI -> buffer
	CX = length
Return: CF set on error
	    DH = error code (see above)
	CF clear if successful
	    CX = length	
Note: copies the local net address associated with the handle into the buffer	    
---------------------------------------------
INT 60 - FTP Driver - RESET INTERFACE
	AH = 07h
	BX = handle
Return: CF set on error
	    DH = error code (see above)
---------------------------------------------
INT 60 - 10-NET - LOCK AND WAIT
	AH = 11h
	AL = drive number or 0
	DX = number of seconds to wait
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status
	    0 successful
	    1 timeout
	    2 server not responding
	    3 invalid semaphore name
	    4 semaphore list is full
	    5 invalid drive ID
	    6 invalid Ethernet address
	    7 not logged in
	    8 write to network failed
	    9 semaphore already logged for this CPU
---------------------------------------------
INT 60 - 10-NET - LOCK
	AH = 12h
	AL = drive number or 0
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see function 11h)
	    1 semaphore currently logged
Note: unlike function 11h, this function returns immediately
---------------------------------------------
INT 60 - 10-NET - UNLOCK
	AH = 13h
	AL = drive number or 0
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see function 11h)
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
	    DH = error code (see function 01h above)
	CF clear if successful
	    AX = mode	
---------------------------------------------
INT 60 - FTP Driver - GET STATISTICS
	AH = 24h
	BX = handle
Return: CF set on error
	    DH = error code
	CF clear if successful
	    DS:SI -> statistics
		DWORD packets in
		DWORD packets out
		DWORD bytes in
		DWORD bytes out
		DWORD errors in
		DWORD errors out
		DWORD packets dropped	
---------------------------------------------
INT 61 - reserved for user interrupt
---------------------------------------------
INT 62 - reserved for user interrupt
---------------------------------------------
INT 63 - reserved for user interrupt
---------------------------------------------
INT 64 - reserved for user interrupt
---------------------------------------------
INT 65 - reserved for user interrupt
---------------------------------------------
INT 66 - reserved for user interrupt
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
	AH = error code (see AH=40h above)
---------------------------------------------
INT 67 - LIM EMS - GET NUMBER OF PAGES
	AH = 42h
Return: AH = 00h function successful
	    BX = number of unallocated pages
	    DX = total number of pages
	AH = error code (see AH=40h above)
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
		AL = bytes in page-mapping array (subfunction 03h only)
		array pointed to by ES:DI receives mapping info (AL=00/02)
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
	    01h set handle attributes
	       BL = new attribute (see returned AL)
	    02h get attribute capability
	DX = handle
Return: AL = attribute (for subfunction 00h)
	    00h handle is volatile
	    01h handle is nonvolatile
	AL = attribute capability (for subfunction 02h)
	    00h only volatile handles supported
	    01h both volatile and non-volatile supported
	AH = status
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
Return: (if successful, the target address is called.  Use a RETF to return and
	 restore mapping context)
	BX = stack space required (subfunction 02h)
	AH = status
	    00h successful
	    80h internal error
	    81h hardware failure
	    83h invalid handle
	    84h undefined function requested
	    8Ah invalid logical page number encountered
	    8Bh invalid physical page number encountered
	    8Fh undefined subfunction
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
Return: BX = unallocated raw pages (subfunction 01h)
	DX = total raw pages (subfunction 01h)
	AH = status
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
	    01h set alternate map register set
	       BL = new alternate map register set number
	       ES:DI -> map register context save area if BL=0
	    02h get alternate map save array size
	    03h allocate alternate map register set
	    04h deallocate alternate map register set
	       BL = number of alternate map register set
Return: BL = current active alternate map register set number if nonzero (AL=0)
	ES:DI -> map register context save area if BL=0 (AL=0)
	DX = array size in bytes (subfunction 02h)
	BL = number of alternate map register set; zero if not supported (AL=3)
	AH = status
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
	    06h enable DMA on alternate map register set
	       BL = DMA register set number
	       DL = DMA channel number
	    07h disable DMA on alternate map register set
	       BL = DMA register set number
	    08h deallocate DMA register set
	       BL = DMA register set number
Return: BL = DMA register set number; zero if not supported (subfunction 05h)
	AH = status
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
	    BX = version number
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
Note:	also available in protected mode by calling the protected-mode VCPI
	entry point
---------------------------------------------
INT 67 - Virtual Control Program Interface - ALLOCATE 4K PAGE
	AX = DE04h
Return: AH = 00h successful
	    EDX = physical address of allocated page
	AH nonzero: failed
Note:	also available in protected mode by calling the protected-mode VCPI
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
	CX = page number
Return: AH = 00h successful
	    EDX = physical address of page
	AH nonzero: failed
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
---------------------------------------------
INT 67 - Virtual Control Program Interface - GET 8259 INTERRUPT VECTOR MAPPINGS
	AX = DE0Ah
Return: AH = 00h successful
	    BX = first vector used by master 8259 (IRQ0)
	    CX = first vector used by slave 8259 (IRQ8)
	AH nonzero: failed
---------------------------------------------
INT 67 - Virtual Control Program Interface - SET 8259 INTERRUPT VECTOR MAPPINGS
	AX = DE0Bh
	BX = first vector used by master 8259
	CX = first vector used by slave 8259
Return: AH = 00h successful
	AH nonzero: failed
---------------------------------------------
INT 67 - Virtual Control Program Interface - SWITCH TO PROTECTED MODE
	AX = DE0Ch
	ESI = linear address in first megabyte of values for system registers
	interrupts disabled
Return: interrupts disabled
	SS:ESP must have a few words of space, and the entry point is required
		to set up a new stack immediately
	EAX, ESI, DS, ES, FS, GS destroyed

Note: in protected mode, calling the protected-mode VCPI entry point with 
	AX = DE0Ch
	DS = segment selector from function DE01h
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
		12 BYTEs reserved
		   WORD  verb (action)
		 6 BYTEs 0
		   DWORD (high byte first) return code
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
if verb = 1B00h (DISPLAY), control block continues
	WORD  0
      8 BYTEs (high byte first) logical unit ID
      8 BYTEs (high byte first) partner logical unit name
      8 BYTEs (high byte first) mode name
	BYTE  logical unit session limit
	BYTE  partner logical unit session limit
	BYTE  mode maximum negotiable session limit
	BYTE  current session limit
	BYTE  minimum negotiated winner limit
	BYTE  maximum negotiated loser limit
	BYTE  active session count
	BYTE  active CONWINNER session count
	BYTE  active CONLOSER session count
	BYTE  session termination count
	BYTE  bit 7: SESSION_TERMINATION_TARGET_DRAIN
	      bit 6: SESSION_TERMINATION_SOURCE_DRAIN
if verb=2000h (Attach Physical Unit), control block continues
	WORD  0
	BYTE  version
	BYTE  release
      8 BYTEs (high byte first) net name
      8 BYTEs (high byte first) physical unit name
      8 BYTEs 0
	DWORD pointer to SYSTEM_LOG_EXIT routine, FFFFFFFFh = don't log errors
	DWORD 0
	BYTE  0 RETURN_CONTROL: COMPLETE
	      1 RETURN_CONTROL: INCOMPLETE
if verb=2100h (Attach Logical Unit), control block continues
	WORD  70  offset to partner logical unit record
      8 BYTEs (high byte first) logical unit name
      8 BYTEs (high byte first) logical unit ID
	BYTE  logical unit local address
	BYTE  logical unit session limit
	DWORD pointer to CREATE_TP_EXIT routine,
	      FFFFFFFFh = reject incoming ALLOCATEs
	      00000000h = queue ALLOCATEs
	DWORD 0
	DWORD pointer to SYSTEM_LOG_EXIT routine, FFFFFFFFh = don't log errors
	DWORD 0
	BYTE  maximum TPs
	BYTE  queue depth
	DWORD pointer to LU_LU_PASSWORD_EXIT routine, FFFFFFFFh = no pswd exit
	DWORD 0
	WORD  total length of partner records
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
if verb=2200h (Detach Logical Unit), control block continues:
      8 BYTEs (high byte first) logical unit ID
	BYTE  0
if verb=2700h (Detach Physical Unit), control block continues:
	BYTE  0  type: hard
	      1  type: soft
if verb=2B00h (Activate DLC), control block continues:
      8 BYTEs (high byte first) DLC name
	BYTE  adapter number

Routines defined by LU_LU_PASSWORD_EXIT, CREATE_TP_EXIT, and SYSTEM_LOG_EXIT
pointers are called by pushing the DWORD pointer to the verb on the stack and
then performing a FAR call.

ACCESS_LU_LU_PW verb:
     12 BYTEs reserved
	WORD  1900h
      8 BYTEs (high byte first) logical unit ID
      8 BYTEs (high byte first) logical unit name
      8 BYTEs (high byte first) partner logical unit name
     17 BYTEs (counted string) partner fully qualified logical unit name
	BYTE  password available (0=no, 1=yes)
      8 BYTEs password
CREATE_TP verb:
     12 BYTEs reserved
	WORD  2300h
      6 BYTEs 0
	DWORD (high byte first) sense code
	      00000000h    Ok
	      080F6051h    SECURITY_NOT_VALID
	      084B6031h    TP_NOT_AVAIL_RETRY
	      084C0000h    TP_NOT_AVAIL_NO_RETRY
	      10086021h    TP_NAME_NOT_RECOGNIZED
	      10086034h    CONVERSATION_TYPE_MISMATCH
	      10086041h    SYNC_LEVEL_NOT_SUPPORTED
      8 BYTEs (high byte first) TP ID
      8 BYTEs (high byte first) logical unit ID
	DWORD (high byte first) conversation ID
	BYTE  0 basic conversation, 1 mapped conversation
	BYTE  0 no sync level, 1 confirm
	BYTE  reserved
     65 BYTEs (counted string) transaction program name
      6 BYTEs 0
	WORD  length of ERROR_LOG_DATA to return
	DWORD pointer to ERROR_LOG_DATA buffer
      8 BYTEs (high byte first) partner logical unit name
     18 BYTEs (counted string) partner fully qualified logical unit name
      8 BYTEs (high byte first) mode name
     12 BYTEs 0
     11 BYTEs (counted string) password
     11 BYTEs (counted string) user ID
	BYTE  0 verification should be performed
	      1 already verified
SYSLOG verb:
     12 BYTEs reserved
	WORD  2600h
     10 BYTEs 0
	WORD  (high byte first) type
	DWORD (high byte first) subtype
	DWORD pointer to ADDITIONAL_INFO
	DWORD (high byte first) conversation ID
      8 BYTEs (high byte first) TP ID
      8 BYTEs (high byte first) physical unit or logical unit name
	WORD  length of data
	DWORD pointer to data
	BYTE  0
---------------------------------------------
INT 68 - APPC/PC
	AH = 02h
	DS:DX -> control block
		12 BYTEs reserved
		   WORD  verb (action)
		   BYTE  1 if MC_ (mapped conversation) form of verb
			 0 if basic verb
		 5 BYTEs 0
		   WORD  (high byte first) primary return code
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
		   DWORD (high byte first) error code
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
		 8 BYTEs (high byte first) TP_ID
		   DWORD (high byte first) conversation ID
if verb=0100h (Allocate or MC_Allocate), control block continues:
	BYTE  (MC_Allocate only) 0 basic conversation
				 1 mapped conversation
	BYTE  0 SYNC_LEVEL = none
	      1 SYNC_LEVEL = confirm
	WORD  0
	BYTE  0 RETURN_CONTROL: when session allocated
	      1 RETURN_CONTROL: immediate
	      2 RETURN_CONTROL: when session free
      8 BYTEs 0
      8 BYTEs (high byte first) partner logical unit name
      8 BYTEs (high byte first) mode name
     65 BYTEs (counted string) TP name
	BYTE  0 security: none
	      1 security: same
	      2 security: pgm
     11 BYTEs 0
     11 BYTEs (counted string) password
     11 BYTEs (counted string) user ID
	WORD  PIP_DATA length
	DWORD pointer to PIP_DATA
if verb=0300h (Confirm or MC_Confirm), then control block continues:
	BYTE  request to send received (0=no, 1=yes)
if verb=0400h (Confirmed or MC_Confirmed), no additional fields
if verb=0500h (Deallocate or MC_Deallocate), then control block continues:
	BYTE  0
	BYTE  type 0 SYNC_LEVEL
		   1 FLUSH
		   2 ABEND_PROC
		   3 ABEND_SVC
		   4 ABEND_TIMER
		   5 ABEND
	WORD  (MC_Deallocate only) length of error log data
	DWORD (MC_Deallocate only) pointer to error log data
if verb=0600h (Flush or MC_Flush), no additional fields
if verb=0700h (Get_Attributes or MC_Get_Attributes), control block continues:
      8 BYTEs (high byte first) logical unit ID
	BYTE  0
	BYTE  SYNC_LEVEL (0=none, 1=confirm)
      8 BYTEs (high byte first) mode name
      8 BYTEs (high byte first) own net name
      8 BYTEs (high byte first) own logical unit name
      8 BYTEs (high byte first) partner logical unit name
     18 BYTEs (counted string) partner's fully qualified logical unit name
	BYTE  0
     11 BYTEs (counted string) user ID
if verb=0800h (Get_Type), then control block continues:
	BYTE  type (0=basic conversation, 1=mapped conversation)
if verb=0900h (Post_on_Receipt), then control block continues:
	WORD  maximum length
	BYTE  fill (0=buffer, 1=LL)
if verb=0A00h (Prepare_to_Receive or MC_Prepare_to_Receive):
	BYTE  type (0=SYNC_LEVEL, 1=FLUSH)
	BYTE  locks (0=short, 1=long)
if verb=0B00h (Receive_and_Wait or MC_Receive_and_Wait), control block cont:
	BYTE  what received
		0 data
		1 data complete
		2 data incomplete
		3 confirm
		4 confirm send
		5 confirm deallocate
		6 send
	BYTE  (MC_Receive_and_Wait only) fill (0=buffer, 1=LL)
	BYTE  Request_to_Send_Received (0=no, 1=yes)
	WORD  maximum length
	WORD  data length
	DWORD pointer to data
if verb=0C00h (Receive_Immediate or MC_Receive_Immediate), control block:
	BYTE  what received
		0 data
		1 data complete
		2 data incomplete
		3 confirm
		4 confirm send
		5 confirm deallocate
		6 send
	BYTE  (MC_Receive_Immediate only) fill (0=buffer, 1=LL)
	BYTE  Request_to_Send_Received (0=no, 1=yes)
	WORD  maximum length
	WORD  data length
	DWORD pointer to data
if verb=0E00h (Request_to_Send or MC_Request_to_Send), no additional fields
if verb=0F00h (Send_Data or MC_Send_Data), then control block continues:
	BYTE  request to send received (0=no, 1=yes)
	BYTE  0
	WORD  data length
	DWORD pointer to data
if verb=1000h (Send_Error or MC_Send_Error)
	BYTE  request to send received (0=no, 1=yes)
	BYTE  type (0=program, 1=SVC)
	DWORD 0
	WORD  (MC_Send_Error only) LOG_DATA length
	DWORD (MC_Send_Error only) pointer to LOG_DATA
if verb=1200h (Test or MC_Test), then control block continues:
	BYTE  (MC_Test only) test (0=posted, 1=request_to_send received)
    Note: error code has different interpretations for:
	0 posted data
	1 posted not data (primary return code = 0)
	1 bad TP_ID (primary return code = 1)
if verb=1300h (Wait), then control block continues:
	BYTE  number of conversations to wait on
    Note: error codes have interpretations as for 1200h (Test) above
---------------------------------------------
INT 68 - APPC/PC
	AH = 03h
	DS:DX -> control block
		12 BYTEs reserved
		   WORD  verb (action)
		 6 BYTEs 0
		   DWORD (high byte first) return code (see AH=01h)
		   WORD  0
		 8 BYTEs (high byte first) logical unit ID
if verb=2400h (TP Started), control block continues:
      8 BYTEs (high byte first) TP ID
if verb=2800h (Get ALLOCATE), control block continues:
	BYTE  type
		0 dequeue
		1 test
	DWORD pointer to CREATE_TP record
if verb=2A00h (Change Logical Unit). control block continues:
	DWORD pointer to CREATE_TP_EXIT routine
		FFFFFFFFh reject incoming ALLOCATEs
		00000000h queue ALLOCATEs
	DWORD 0
	DWORD pointer to SYSTEM_LOG_EXIT routine, FFFFFFFFh = don't log errors
	DWORD 0
	BYTE  maximum TPs
	BYTE  0 stop QUEUE_ALLOCATEs
	      1 resume QUEUE_ALLOCATEs
	DWORD pointer to LU_LU_PASSWORD_EXIT routine, FFFFFFFFh = no exit
	DWORD 0
---------------------------------------------
INT 68 - APPC/PC
	AH = 04h
	DS:DX -> control block
		12 BYTEs reserved
		   WORD  verb (action)
			2500h TP_ENDED
			2900h TP_VALID
		 6 BYTEs 0
		   DWORD (high byte first) return code (see AH=01h)
		   WORD  0
		 8 BYTEs (high byte first) TP_ID
		   DWORD -> CREATE_TP record (only if verb = 2900h)
---------------------------------------------
INT 68 - APPC/PC - TRANSFER MSG DATA
	AH = 05h
	DS:DX -> control block
		12 BYTEs reserved
		   WORD  1C00h
		   BYTE  0 user defined
			 1 NMVT
			 2 alert subvectors
			 3 PDSTATS subvectors
		 5 BYTEs 0
		   DWORD (high byte first) return code (see AH=01h)
		12 BYTEs 0
		   BYTE  if bit 0 clear, add correlation subvector
			 if bit 1 clear, add product set ID subvector
			 if bit 2 clear, do SYSLOG
			 if bit 3 clear, send SSCP_PU_SESSION
		   BYTE  0
		   WORD  length of data
		 N BYTEs data
---------------------------------------------
INT 68 - APPC/PC - CHANGE NUMBER OF SESSIONS
	AH = 06h
	DS:DX -> control block
		12 BYTEs reserved
		   WORD  1500h
		 6 BYTEs 0
		   WORD  (high byte first) primary return code (see AH=02h)
		   DWORD (high byte first) secondary return code (see AH=01h)
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
		 8 BYTEs (high byte first) logical unit ID
		 8 BYTEs blanks
		 8 BYTEs (high byte first) partner logical unit name
		 8 BYTEs (high byte first) mode name
		   BYTE  bit 7: use MODE_NAME_SELECT_ALL rather than MODE_NAME
			 bit 6: set negotiable values
		   BYTE  partner logical unit mode session limit
		   BYTE  minimum CONWINNERS_SOURCE
		   BYTE  maximum CONWINNERS_TARGET
		   BYTE  automatic activation
		   BYTE  0
		   BYTE  bit 7: drain targer
			 bit 6: drain source
			 bit 5: target responsible, not source
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
	DS:DX -> control block
		12 BYTEs reserved
		   WORD  1A00h
		 6 BYTEs 0
		   DWORD (high byte first) return code
		   BYTE  conversion
			   0 ASCII to EBCDIC
			   1 EBCDIC to ASCII
		   BYTE  character set
			   0 AE
			   1 A
			   2 G
		   WORD  length of string to convert
		   DWORD pointer to source
		   DWORD pointer to target
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
INT 68 - APPC/PC - TRACE DESTINATION
	AH = FEh
	AL = trace destinations
	    bit 0  storage (DS:DX -> trace stats record)
	    bit 1  display
	    bit 2  file (trace written to file OUTPUT.PC)
	    bit 3  printer
Trace Statistics Record
	DWORD  pointer to storage trace buffer
	WORD   max number of 80-byte records in trace
	WORD   (high-order byte first!) current record number (must init to 0)
	DWORD  (high-order byte first!) number of records written (init to 0)
	DWORD  reserved
Note: do not move record while trace is active
---------------------------------------------
INT 68 - APPC/PC - SET PASSTHROUGH
	AH = FFh
	DS:DX -> passthrough exit routine
---------------------------------------------
INT 69 - unused
---------------------------------------------
INT 6A - unused
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
	AX = status (see function 00h)
	    FF08h superstation ID not already logged in
---------------------------------------------
INT 6F - 10-NET - STATUS OF NODE
	AH = 02h
	DS:DX -> 512-byte record
		8 BYTEs user name (0 if none)
		  BYTE	station type
			0  workstation
			1  superstation
			2  gateway station
			3  gateway active
			4  logged into multiple superstations
			5  reserved
	       24 BYTEs list of superstations logged into more than one
			superstation
	       12 BYTEs node ID
		  WORD	message count for this station (send for user node,
			receive for superstations)
	for superstations only:
		  WORD	drives allocated (bit 0=A:, bit 1=B:,...)
		  BYTE	user service flag
			bit 7: gate
			    6: print permit on
			    4: SUBMIT is on
			    3: mail waiting for node
			    2: calendar waiting for you
			    1: news waiting for you
			    0: mail waiting for you
		  BYTE	printers allocated (bit 0=LPT1,...)
		  BYTE	number of unprinted spool files
		  BYTE	number of opened files
		  BYTE	number of logged on nodes
		  BYTE	primary drive (1=A:)
		  BYTE	reserved
		N BYTEs list of logged on node IDs (each 12 bytes, max 37 IDs)
		(continues at offset 1F4h)
		3 BYTEs time: sec/min/hrs
		3 BYTEs date: day/mon/year-1980
Return: CF set on error
	    AX = error code (see function 00h)
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
	    AX = error code (see function 00h)
---------------------------------------------
INT 6F - 10-NET - RECEIVE
	AH = 05h
	CX = number of seconds before timeout
	DS:DX -> receive buffer
		12 BYTEs sending node's ID
		   WORD  length of message
		 N BYTEs message (maximum 1024 bytes)
Return: CF set on error
	    AX = error code (see function 00h)
	CF clear if successful
	    AH = FEh if dequeued message is a CB message
---------------------------------------------
INT 6F - 10-NET - LOCK HANDLE
	AH = 07h
	BX = file handle
	CX:DX = starting offset in file
	SI = record length
Return: CF set on error
	    AX = error code (see also function 00h)
		0002h file not found
---------------------------------------------
INT 6F - 10-NET - UNLOCK HANDLE
	AH = 08h
	BX = file handle
	AL = mode
	    0 unlock all
	    1 unlock record at CX:DX
Return: CF set on error
	    AX = error code (see also function 00h)
		2 file not found
---------------------------------------------
INT 6F - 10-NET - SUBMIT
	AH = 09h
	DS:BX -> record
		12 BYTEs destination node ID (must be logged in)
		   WORD  length+2 of following 'command line' text
		 N BYTEs command line text (<=100 bytes), system adds CR
---------------------------------------------
INT 6F - 10-NET - CHAT
	AH = 0Ah
	DS:BX -> control parameters
		 8 BYTEs sender ID, if nulls defaults to node's userID
		 8 BYTEs destination user ID, 'EVERYONE' may be used
		12 BYTEs destination node ID
	DS:DX -> chat message
		   WORD length+2 of following text
		 N BYTEs text, max 101 bytes
---------------------------------------------
INT 6F - 10-NET - LOCK SEMAPHORE, RETURN IMMEDIATELY
	AH = 0Bh
	AL = drive number or 0
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status
	    0 successful
	    1 semaphore currently locked
	    2 server not responding
	    3 invalid semaphore name
	    4 semaphore list is full
	    5 invalid drive ID
	    6 invalid Ethernet address
	    7 not logged in
	    8 write to network failed
	    9 semaphore already logged in this CPU
Note: same as INT 60/AH=12h
---------------------------------------------
INT 6F - 10-NET - UNLOCK SEMAPHORE
	AH = 0Ch
	AL = drive number or 0
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see AH=0Bh)
	    1 semaphore not locked
Note: same as INT 60/AH=13h
---------------------------------------------
INT 6F - 10-NET - WHO
	AH = 0Dh
	AL = type code
	    01h return superstations only
	    02h return non-superstations only
	    otherwise return all
	CX = length of data
	DS:DX -> array of records to be filled
		12 BYTEs node ID
		   BYTE  flags
			bit 1 = workstation
			    2 = superstation
			    3 = xgate
			    4 = active gate
		(if AL=01h, record continues)
		   BYTE  version number
		   WORD  level number of 10Net software in responding node
		(if AL=02h, record continues)
		 8 BYTEs user ID
		   BYTE  version number
		   WORD  level number
Return: CL = number of records returned (responding stations)
---------------------------------------------
INT 6F - 10-NET - SPOOL/PRINT
	AH = 0Eh
	DS:DX -> record
		WORD  operation code
		      0 initiate spool
		      1 abort print
		      2 close spool
		      3 delete spool
		      4 print
		      5 get report info
		      6 set chat template
		      7 queue
		      8 return queue
		      9 queue non-spooled file for printing
	     11 BYTEs file name in FCB format
	(if operation code = 00h or 06h, record continues)
		BYTE  notification
			bit 7: queue to top
			bit 6: do ID page
			bit 5: no form feed
			bit 4: reserved
			bit 3: explicity queuing only
			bit 2: notify at print completion
			bit 1: notify server operator/reply
			bit 0: notify at print start
		BYTE  days to keep (FFh=forever)
		BYTE  bits 0,1: device (1=LPT1)
		      bits 4-7: remote drive to store spool file (1=A,...)
		WORD  length of following data area
	      N BYTEs up to 64 bytes of description
	(if operation code = 03h, record continues)
	      8 BYTEs user ID to associate with filename
	(if operation code = 04h, record continues)
		WORD  block number
	      8 BYTEs user ID to associate with filename
	(if operation code = 05h, record continues)
		BYTE  RRN to start retrieve
		BYTE  bits 0,1: local print device (LPTx)
		      bit 3: if set, return entries for all users
		WORD  length of following area
	      N BYTEs up to 1500 bytes to receive $SCNTL records returned
	(if operation code = 07h, record continues)
		BYTE  queue number
		BYTE  bits 0,1: local print device (LPTx)
		WORD  number of bytes of test print to be done
		BYTE  code: 01h prnt device
			    02h test print count
			    03h prn
	(if operation code = 08h, record continues)
		BYTE  queue location or $SCNTL location to start access
			returns next item for access:
				00h-7Fh queued items
				80h-FEh non-queued, non-printed items
				FFh	no more items
		WORD  unused
		WORD  length of following area
	      N BYTEs up to 64 bytes to receive $SCNTL records
	(if operation code = 09h, record continues)
	      3 BYTEs unused
	      N BYTEs path to non-spooled file to be queued for printing
Return: CF set on error
	    AX = error code (see also function 00h)
		FF17h device not mounted
		FF18h already spooling to named device

$SCNTL record:
      8 BYTEs user ID
     11 BYTEs filename in FCB format
      6 BYTEs node ID
      3 BYTEs creation date
	BYTE  flags
	      bit 7: queue to top
		  6: do ID page
		  5: no form feed at end
		  4: reserved
		  3: explicit queueing only
		  2: notify at completion
		  1: notify server operator/reply
		  0: notify at start
	BYTE  retention time in days
	BYTE  printing device (LPTx)
      3 BYTEs date last printed (0 = never)
	BYTE  device containing spoolfile
	WORD  bytes to print for test print
	WORD  block number to start print
	BYTE  reserved
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
	    1 sequential
	    2 random
	    3 random block
		CX = number of records
	DS:DX -> FCB
Return: CF set on error
	    AX = error code (see also function 00h)
		2 file not found
---------------------------------------------
INT 6F - 10-NET - UNLOCK FCB
	AH = 12h
	AL = mode
	    0 sequential
	    1 random
	    2 random block
		CX = number of records
	DS:DX -> FCB
Return: CF set on error
	    AX = error code (see also function 00h)
		2 file not found
---------------------------------------------
INT 6F - 10-NET v3.3 - GET REMOTE CONFIGURATION TABLE ADDRESS
	AH = 13h
	DS:DX -> node ID, 12 bytes blank-padded
Return: CF set on error
	    AX = error code (see function 00h)
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
	    AX = error code (see function 00h)
	CF clear if successful
	    CX = amount of memory copied to DS:SI
---------------------------------------------
INT 6F - 10-NET v3.3 - GET SHARED DEVICE ENTRY
	AX = 1501h
	BX = zero-based index
	DS:SI -> node ID, 12 bytes blank-padded
	ES:DI -> 85-byte buffer
Return: CF set on error
	    AX = error code (see function 00h)
	CF clear if successful
	    ES:DI buffer contains shared device table entry of BXth device:
		8 BYTEs device
		8 BYTEs alias
	       64 BYTEs path
		8 BYTEs password
		  BYTE	access
		4 BYTEs mask
---------------------------------------------
INT 6F - 10-NET v3.3 - SET SHARED DEVICE ENTRY
	AX = 1502h
	DS:SI -> node ID, 12 bytes blank-padded
	ES:DI -> valid shared device table entry
Return: CF set on error
	    AX = error code (see function 00h)
---------------------------------------------
INT 6F - 10-NET v3.3 - DELETE SHARED DEVICE ENTRY
	AX = 1503h
	BX = zero-based index
	DS:SI -> node ID, 12 bytes blank-padded
Return: CF set on error
	    AX = error code (see function 00h)
---------------------------------------------
INT 6F - 10-NET v3.3 - MOUNT
	AH = 17h
	AL = local drive number (0=A:)
	BL = remote drive letter or '1'..'3' for LPTn or '4' or '5' for COMx
	DS:DX -> node ID, 12 bytes blank-padded
Return: CF set on error
	    AX = error code (see function 00h)
---------------------------------------------
INT 6F - 10-NET v3.3 - UNMOUNT
	AH = 18h
	AL = local drive number (0=A:)
	BL = type
	    00h	    disk
	    01h-03h LPTn
	    04h,05h COMx
Return: CF set on error
	    AX = error code (see function 00h)
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
---------------------------------------------
INT 7A - AutoCAD Device Interface
---------------------------------------------
INT 7B - not used
---------------------------------------------
INT 7C - not used
---------------------------------------------
INT 7D - not used
---------------------------------------------
INT 7E - not used
---------------------------------------------
INT 7F - HDILOAD.EXE - 8514/A VIDEO CONTROLLER INTERFACE
	???
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
INT 86 to F0 - used by BASIC while in interpreter
---------------------------------------------
INT A4 - Right Hand Man API
	function number in AH
Note: Right-Hand Man is a TSR desk-top utility
---------------------------------------------
INT E0 - CP/M-86 function calls
---------------------------------------------
INT E4 - Logitech Modula v2.0 - MonitorEntry
	AX = 0005h
	BX = priority
---------------------------------------------
INT E4 - Logitech Modula v2.0 - MonitorExit
	AX = 0006h
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
Please redistribute the following files (unmodified) as a group, in an archive
named INTER189:
	INTERRUP.A	INT 00 through INT 5F
	INTERRUP.B	INT 60 through INT FF
	INTERRUP.SUM	a one-line-per-function summary
	INTERRUP.PRI	a brief introduction to interrupts
	INTERRUP.1ST	the read-me file, containing credits
---------------------------------------------
ARPA: ralf@cs.cmu.edu			 \
UUCP: {ucbvax,harvard}!cs.cmu.edu!ralf	  > preferred
BIT:  ralf%cs.cmu.edu@cmuccvma		 /
FIDO: Ralf Brown 1:129/31
	or post a message to the DR_DEBUG echo
