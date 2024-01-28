Interrupt List, part 10 of 15
Copyright (c) 1989,1990,1991,1992,1993,1994,1995,1996 Ralf Brown
--------m-2F4300-----------------------------
INT 2F - EXTENDED MEMORY SPECIFICATION (XMS) v2+ - INSTALLATION CHECK
	AX = 4300h
Return: AL = 80h XMS driver installed
	AL <> 80h no driver
Notes:	XMS gives access to extended memory and noncontiguous/nonEMS memory
	  above 640K
	this installation check DOES NOT follow the format used by other
	  software
SeeAlso: AX=4310h
Index:	installation check;XMS version 2+
--------m-2F4308-----------------------------
INT 2F U - HIMEM.SYS v2.77+ - GET A20 HANDLER NUMBER
	AX = 4308h
Return: AL = 43h if supported
	    BL = A20 handler number (value of /MACHINE:nn switch)
	    BH = AT A20 switch time (00h medium, 01h fast, 02h slow)
Note:	if the A20 handler number returned in BL is 00h, an external handler
	  is being used (see AX=4330h)
SeeAlso: AX=4309h,AX=4330h
--------m-2F4309-----------------------------
INT 2F U - HIMEM.SYS v3.09+ - GET XMS HANDLE TABLE
	AX = 4309h
Return: AL = 43h if function supported
	    ES:BX -> XMS handle table (see #1976)
Note:	HIMEM.SYS v3.09 is part of MS-DOS 6.0.
SeeAlso: AX=4308h

Format of XMS handle table:
Offset	Size	Description	(Table 1976)
 00h	BYTE	??? (01h in HIMEM.SYS v3.09)
 01h	BYTE	size of one handle descriptor
 02h	WORD	number of handles (default = 20h)
 04h	DWORD	pointer to XMS handle array (see #1977)
SeeAlso: #2006

Format of XMS handle descriptor [array]:
Offset	Size	Description	(Table 1977)
 00h	BYTE	flag
		01h=free, 02h=used, 04h=in pool but not associated with any EMB
 01h	BYTE	lock count (00h=unlocked)
 02h	DWORD	address of XMS block in KB (shift left by 10 for abs. address)
 06h	DWORD	size of XMS block in KB
--------m-2F4310-----------------------------
INT 2F - EXTENDED MEMORY SPECIFICATION (XMS) v2+ - GET DRIVER ADDRESS
	AX = 4310h
Return: ES:BX -> driver entry point (see #1978,#1979,#1982,#1989,#1998,#2003)
Notes:	HIMEM.SYS v2.77 chains to previous handler if AH is not 00h or 10h
	HIMEM.SYS requires at least 256 bytes free stack space when calling
	  the driver entry point
SeeAlso: AX=4300h,AX=4310h"Cloaking",AX=4310h"Netroom",AX=4310h"XMZ"

Format of XMS driver entry point:
Offset	Size	Description	(Table 1978)
 00h  5 BYTEs	jump to actual handler
		either short jump (EBh XXh) followed by three NOPs or
		  far jump (EAh XXXX:XXXX) to a program which has hooked itself
		  into the XMS driver chain
Note:	to hook into the XMS driver chain, a program should follow the chain of
	  far jumps until it reaches the short jump of the driver at the end
	  of the chain; this short jump is to be replaced with a far jump to
	  the new handler's entry point, which should contain a short jump
	  followed by three NOPs.  The new handler must return to the address
	  pointed at by the short jump which was overwritten.  Using this
	  method, the new handler becomes the first to see every XMS request.

(Table 1979)
Call the XMS driver "Get XMS version number" function with:
	AH = 00h
Return: AX = XMS version (in BCD, AH=major, AL=minor)
	BX = internal revision number (in BCD for HIMEM.SYS)
	DX = High Memory Area (HMA) state
	    0001h HMA (1M to 1M + 64K) exists
	    0000h HMA does not exist
SeeAlso: #1980,#1981,#1986,#1987,#1993

(Table 1980)
Call the XMS driver "Request High Memory Area" function with:
	AH = 01h
	DX = memory in bytes (for TSR or device drivers)
	    FFFFh if application program
Return: AX = status
	    0001h success
	    0000h failure
		BL = error code (80h,81h,90h,91h,92h) (see #2004)
Note:	HIMEM.SYS will fail function 01h with error code 91h if AL=40h and
	  DX=KB free extended memory returned by last call of function 08h
SeeAlso: #1981,#2013

(Table 1981)
Call the XMS driver "Release High Memory Area" function with:
	AH = 02h
Return: AX = status
	    0001h success
	    0000h failure
		BL = error code (80h,81h,90h,93h) (see #2004)
SeeAlso: #1980

(Table 1982)
Call the XMS driver "Global enable A20, for using the HMA" function with:
	AH = 03h
Return: AX = status
	    0001h success
	    0000h failure
		BL = error code (80h,81h,82h) (see #2004)
SeeAlso: #1983,#1984

(Table 1983)
Call the XMS driver "Global disable A20" function with:
	AH = 04h
Return: AX = status
	    0001h success
	    0000h failure
		BL = error code (80h,81h,82h,94h) (see #2004)
SeeAlso: #1982,#1985

(Table 1984)
Call the XMS driver "Local enable A20" function with:
	AH = 05h
Return: AX = status
	    0001h success
	    0000h failure
		BL = error code (80h,81h,82h) (see #2004)
Note:	this function is used for direct access to extended memory
SeeAlso: #1982,#1985

(Table 1985)
Call the XMS driver "Local disable A20" function with:
	AH = 06h
Return: AX = status
	    0001h success
	    0000h failure
		BL = error code (80h,81h,82h,94h) (see #2004)
SeeAlso: #1983,#1984

(Table 1986)
Call the XMS driver "Query A20 state" function with:
	AH = 07h
Return: AX = status
	    0001h enabled
	    0000h disabled
		BL = error code (00h,80h,81h) (see #2004)
SeeAlso: #1979,#1987

(Table 1987)
Call the XMS driver "Query free extended memory" function with:
	AH = 08h
	BL = 00h (some implementations leave BL unchanged on success)
Return: AX = size of largest extended memory block in KB
	DX = total extended memory in KB
	BL = error code (00h,80h,81h,A0h) (see #2004)
Note:	this function does not include the HMA in the returned memory sizes
SeeAlso: #1979,#1986,#1988,#2000

(Table 1988)
Call the XMS driver "Allocate extended memory block" function with:
	AH = 09h
	DX = Kbytes needed
Return: AX = status
	    0001h success
		DX = handle for memory block
	    0000h failure
		BL = error code (80h,81h,A0h) (see #2004)
SeeAlso: #1987,#1990,#1993,#1994,#1995,#2001

(Table 1989)
Call the XMS driver "Free extended memory block" function with:
	AH = 0Ah
	DX = handle of block to free
Return: AX = status
	    0001h success
	    0000h failure
		BL = error code (80h,81h,A2h,ABh) (see #2004)
SeeAlso: #1988,#2001

(Table 1990)
Call the XMS driver "Move extended memory block" function with:
	AH = 0Bh
	DS:SI -> EMM structure (see #2005)
Return: AX = status
	    0001h success
	    0000h failure
		BL = error code (80h-82h,A3h-A9h) (see #2004)
Note:	if either handle in the EMM structure is 0000h, the corresponding
	  offset is considered to be an absolute segment:offset address in
	  directly addressable memory
SeeAlso: #1988,#1991

(Table 1991)
Call the XMS driver "Lock extended memory block" function with:
	AH = 0Ch
	DX = handle of block to lock
Return: AX = status
	    0001h success
		DX:BX = 32-bit physical address of locked block
	    0000h failure
		BL = error code (80h,81h,A2h,ACh,ADh) (see #2004)
Note:	MS Windows 3.x rejects this function for handles allocated after
	  Windows started
SeeAlso: #1988,#1990,#1992

(Table 1992)
Call the XMS driver "Unlock extended memory block" function with:
	AH = 0Dh
	DX = handle of block to unlock
Return: AX = status
	    0001h success
	    0000h failure
		BL = error code (80h,81h,A2h,AAh) (see #2004)
SeeAlso: #1991

(Table 1993)
Call the XMS driver "Get handle information" function with:
	AH = 0Eh
	DX = handle for which to get info
Return: AX = status
	    0001h success
		BH = block's lock count
		BL = number of free handles left
		DX = block size in KB
	    0000h failure
		BL = error code (80h,81h,A2h) (see #2004)
BUG:	MS Windows 3.10 acts as though unallocated handles are in use
Note:	MS Windows 3.00 has problems with this call
SeeAlso: #1979,#1988,#2002

(Table 1994)
Call the XMS driver "Reallocate extended memory block" function with:
	AH = 0Fh
	DX = handle of block
	BX = new size of block in KB
Return: AX = status
	    0001h success
	    0000h failure
		BL = error code (80h,81h,A0h-A2h,ABh) (see #2004)
SeeAlso: #1988,#1997

(Table 1995)
Call the XMS driver "Request upper memory block" function with:
	AH = 10h
	DX = size of block in paragraphs
Return: AX = status
	    0001h success
		BX = segment address of UMB
		DX = actual size of block
	    0000h failure
		BL = error code (80h,B0h,B1h) (see #2004)
		DX = largest available block
Notes:	Upper Memory consists of non-EMS memory between 640K and 1024K
	the XMS driver need not implement functions 10h through 12h to be
	  considered compliant with the standard
	under DOS 5+, if CONFIG.SYS contains the line DOS=UMB, then no upper
	  memory blocks will be available for allocation because all blocks
	  have been grabbed by MS-DOS while booting
SeeAlso: #1988,#1996,#2014,INT 21/AH=58h"UMB"

(Table 1996)
Call the XMS driver "Release upper memory block" function with:
	AH = 11h
	DX = segment address of UMB to release
Return: AX = status
	    0001h success
	    0000h failure
		BL = error code (80h,B2h) (see #2004)
Note:	the XMS driver need not implement functions 10h through 12h to be
	  considered compliant with the standard
SeeAlso: #1989,#1995,#1997

(Table 1997)
Call the XMS v3.0+ driver "Reallocate upper memory block" function with:
	AH = 12h
	DX = segment address of UMB to resize
	BX = new size of block in paragraphs
Return: AX = status
	    0001h success
	    0000h failure
		BL = error code (80h,B0h,B2h) (see #2004)
		DX = maximum available size (RM386)
Note:	the XMS driver need not implement functions 10h through 12h to be
	  considered compliant with the standard
SeeAlso: #1994,#1995,#1996,#2012

(Table 1998)
Call the QEMM v5.11 "???" function with:
	AH = 34h  (QEMM 5.11 only, undocumented)
	???
Return: ???
SeeAlso: #1999

(Table 1999)
Call the QEMM v5.11 "???" function with:
	AH = 44h  (QEMM 5.11 only, undocumented)
	???
Return: ???
SeeAlso: #1998,#2012

(Table 2000)
Call the XMS v3.0 driver "Query free extended memory" function with:
	AH = 88h
Return: EAX = largest block of extended memory, in KB
	BL = status (00h,80h,81h,A0h) (see #2004)
	ECX = physical address of highest byte of memory
	    (valid even on error codes 81h and A0h)
	EDX = total Kbytes of extended memory (0 if status A0h)
BUG:	HIMEM v3.03-3.07 crash on an 80286 machine if any of the 8Xh functions
	  are called
SeeAlso: #1987,#2001

(Table 2001)
Call the XMS v3.0 driver "Allocate any extended memory" function with:
	AH = 89h
	EDX = Kbytes needed
Return: AX = status
	    0001h success
		DX = handle for allocated block (free with AH=0Ah) (see #1989)
	    0000h failure
		BL = status (80h,81h,A0h,A1h,A2h) (see #2004)
SeeAlso: #1988,#2000

(Table 2002)
Call the XMS v3.0 driver "Get extended EMB handle information" function with:
	AH = 8Eh
	DX = handle
Return: AX = status
	    0001h success
		BH = block's lock count
		CX = number of free handles left
		EDX = block size in KB
	    0000h failure
		BL = status (80h,81h,A2h) (see #2004)
BUG:	MS-DOS 6.0 HIMEM.SYS leaves CX unchanged
SeeAlso: #1993,#2001,#2003

(Table 2003)
Call the XMS v3.0 driver "Reallocate any extended memory block" function with:
	AH = 8Fh
	DX = unlocked memory block handle
	EBX = new size in KB
Return: AX = status
	    0001h success
	    0000h failure
		BL = status (80h,81h,A0h-A2h,ABh) (see #2004)
BUG:	HIMEM v3.03-3.07 crash on an 80286 machine if any of the 8Xh functions
	  are called
SeeAlso: #1994,#2002

(Table 2004)
Values for XMS error code returned in BL:
 00h	successful
 80h	function not implemented
 81h	Vdisk was detected
 82h	an A20 error occurred
 8Eh	a general driver error
 8Fh	unrecoverable driver error
 90h	HMA does not exist or is not managed by XMS provider
 91h	HMA is already in use
 92h	DX is less than the /HMAMIN= parameter
 93h	HMA is not allocated
 94h	A20 line still enabled
 A0h	all extended memory is allocated
 A1h	all available extended memory handles are allocated
 A2h	invalid handle
 A3h	source handle is invalid
 A4h	source offset is invalid
 A5h	destination handle is invalid
 A6h	destination offset is invalid
 A7h	length is invalid
 A8h	move has an invalid overlap
 A9h	parity error occurred
 AAh	block is not locked
 ABh	block is locked
 ACh	block lock count overflowed
 ADh	lock failed
 B0h	only a smaller UMB is available
 B1h	no UMB's are available
 B2h	UMB segment number is invalid

Format of EMM structure:
Offset	Size	Description	(Table 2005)
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

Format of XMS handle info [array]:
Offset	Size	Description	(Table 2006)
 00h	BYTE	handle
 01h	BYTE	lock count
 02h	DWORD	handle size
 06h	DWORD	handle physical address (only valid if lock count nonzero)
SeeAlso: #1976
--------m-2F4310-----------------------------
INT 2F - Cloaking - REAL-MODE API
	AX = 4310h
Return: ES:BX -> driver entry point (see #1978,#2007,#2008,#2009,#2010)
SeeAlso: AX=4310h"XMS"

(Table 2007)
Call the Cloaking v1.01 "Client Registration" function with:
	AH = 7Eh
	BX = subfunction
	    0000h get client registration count
	    0001h get client registration structures
		ES:DI -> buffer for registration structures
Return: AX = status
	    0000h failed
	    0001h successful
		---subfunction 00h---
		BX = size of client structure in bytes
		CX = number of clients installed
		---subfunction 01h---
		ES:DI buffer filled
SeeAlso: #2008,#2010,INT 2C/AX=0033h

(Table 2008)
Call the Cloaking v1.01 "Verify Cloaking Host" function with:
	AH = 7Fh
Return: AX = status
	    0000h failed
	    0001h (successful) if installed
		BX = version (0101h for v1.01)
		CX = flags
		    bit 0: host is VCPI-based
		DS:DX -> ASCIZ Cloaking host signature
		    "CLOAKING.EXE"0, followed by a far-call entry point to
		      uninstall host (see #2009) in Helix's CLOAKING.EXE
SeeAlso: #2007,#2010
Index:	installation check;Cloaking host|installation check;CLOAKING.EXE

(Table 2009)
Call the CLOAKING.EXE "Uninstall Host" function with:
Return:	AX = 4F4Bh ('OK') if successfully uninstalled protected-mode code

(Table 2010)
Call the Cloaking "Start Protected-Mode Client" function with:
	AH = 82h
	DX = XMS handle of locked block containing protected-mode code
	CL = code size (00h 16-bit, else 32-bit)
	ESI, EDI = parameters to pass to protected-mode code
Return: AX = status
	    nonzero success
	    0000h failed
		BL = error code (A2h,B0h) (see #2004)
Notes:	this function calls a user initialization function at offset 0 in
	  the XMS memory block (see #2011)
	supported by Helix's RM386 v6.00 and Helix's CLOAKING.EXE
SeeAlso: #2007,#2008

(Table 2011)
Values user initialization function is called with:
	EBX = physical address of block's start
	ESI = user data from function 82h call
	EDI = user data from function 82h call
	CS = code selector for XMS block at EBX (16-bit or 32-bit)
	DS = data selector for XMS block, starting at EBX
	ES = selector for V86 memory access to full real-mode 1088K
	GS = selector for full 4G flat address space
	SS:ESP -> stack provided by host
Return: via 32-bit FAR return
Note:	the initialization function may call any protected-mode Cloaking
	  service; it should store the values of DS, ES, and GS for future
	  reference
--------m-2F4310-----------------------------
INT 2F - Helix Netroom RM386 v6.00 - XMS EXTENSIONS
	AX = 4310h
Return: ES:BX -> driver entry point (see #2012,#2013,#2014,#2015)
Notes:	HIMEM.SYS v2.77 chains to previous handler if AH is not 00h or 10h
	HIMEM.SYS requires at least 256 bytes free stack space when calling
	  the driver entry point
SeeAlso: AX=4300h,AX=4310h"XMS",AX=4310h"Cloaking"

(Table 2012)
Call the Netroom RM386 v6.00 "Reallocate upper memory block" function with:
	AH = 80h
	DX = segment address of UMB to resize
	BX = new size of block in paragraphs
Return: AX = status
	    0001h success
	    0000h failure
		BL = error code (80h,B0h,B2h) (see #2004)
		DX = maximum available size
Note:	this function is identical to function 12h
SeeAlso: #1997,#2013

(Table 2013)
Call the Netroom RM386 v6.00 "re-enable HMA allocation" function with:
	AH = 81h
Return: AX = 0001h (success)
SeeAlso: #1980,#2012,#2014

(Table 2014)
Call the Netroom RM386 v6.00 "Create new UMB entry" function with:
	AH = 83h
	BX = segment of high-memory block
	DX = first page of start of block
	CX = number of consecutive pages in block
	DI = start of UMB in block
Return: AX = 0001h (success)
	DI = segment of first high-DOS block
Note:	the new UMB is not linked into the high-memory chain
SeeAlso: #1995,#2013,#2015

(Table 2015)
Call the Netroom RM386 v6.00 "Get all XMS handles info" function with:
	AH = 84h
	CX = size of buffer for handle info
	ES:DI -> buffer for handle info (see #2006)
Return: AX = 0001h (success)
	DX = current number of allocated XMS handles
SeeAlso: #2014,#2000
--------m-2F4310-----------------------------
INT 2F - NEC PC-9800 - XMZ - PRIVATE API
	AX = 4310h
Return: ES:BX -> driver entry point (see #2016,2713)
Program: XMZ is an XMS 2.x-compatible driver for the NEC PC-98 series written
	  by ZOBplus Hayami and available at
	  ftp:/ftp.tohoku.ac.jp/pub/msdos/Memory/xmz/
SeeAlso: AX=4300h,AX=4310h"XMS"

(Table 2016)
Call XMZ v1.02 "Get HMA Information" function with:
	AH = FFh  (XMZ only)
	AL = 01h
Return: AX = 1 on success
	DX = minimum HMA allocation size (/HMAMIN=)
	BX = actual size of HMA allocation, if in use (i.e. the value in DX
	      when XMS function 1 was called)
SeeAlso: #2017

(Table 2017)
Call XMZ v1.02 "Get EMB Handle Information" function with:
	AH = FFh  (XMZ only)
	AL = 02h
Return: AX = 1 on success
	DX = number of EMB handles configured (/NUMHANDLES=)
	BX = offset in XMZ's segment of the handle table (use segment of
	      entry point) (see #2018)
SeeAlso: #2016

Format of XMZ v1.02 EMB Handle structure:
Offset	Size	Description	(Table 2018)
 00h	BYTE	flag byte
		04h unused handle slot
		02h in-use handle slot
		01h handle slot that represents a free block
 01h	BYTE	lock count
 02h	WORD	block start address (1K increments)
 04h	WORD	block length (1K increments)
SeeAlso: #2017
--------m-2F4320-----------------------------
INT 2F U - HIMEM.SYS - Mach 20 SUPPORT
	AX = 4320h
	???
Return: ???
--------m-2F4330-----------------------------
INT 2F CU - HIMEM.SYS v2.77+ - GET EXTERNAL A20 HANDLER ADDRESS
	AX = 4330h
Return: AL = 80h if external A20 handler provided
	    ES:BX -> external A20 handler (see #2019)
	    CL = A20 detection support
		00h handler is unable to report A20 state
		01h handler supports function 0002h to report A20 state
Note:	HIMEM.SYS calls this function to allow an external program to provide
	  an A20 handler (i.e. to support a machine not supported by HIMEM
	  itself)
SeeAlso: AX=4308h,AX=4310h

(Table 2019)
Call parameters for external A20 handler are:
	AX = function
	    0000h disable A20
	    0001h enable A20
	    0002h get A20 state
Return: AX = status (functions 0000h and 0001h)
	    0000h failure
	    0001h successful
	AX = A20 state (function 0002h)
	    0000h disabled
	    0001h enabled
Note:	HIMEM.SYS only calls function 0002h if the returned CL indicated that
	  the handler supports the call
----------2F43D6-----------------------------
INT 2F - Multiplex - ???
	AX = 43D6h
Note:	Central Point's CPBACKUP v9 calls this function with CX=7FFh and
	  DX=80D3h at startup
--------E-2F43E0BX0000-----------------------
INT 2F - DOS Protected Mode Services (DPMS) v1.0 - INSTALLATION CHECK
	AX = 43E0h
	BX = 0000h
	CX = 4450h ('DP')
	DX = 4D53h ('MS')
Return: AX = 0000h if installed
	    CF clear
	    ES:DI -> server structure (see #2020)
	    ES:BX -> registration structure (pre-NWDOS 7 beta spec) (see #2022)
Note:	the DPMS 1.0 server included with the original release of Novell DOS
	  7.0 supports both the beta and 1.0 specification, setting ES:BX even
	  if CX and DX are not as specified on entry (since the beta
	  specification did not use those registers).  However, the DPMS 1.1
	  server included with the March 1994 update does not support the beta
	  specification
SeeAlso: AX=43E1h,AX=43E2h,AX=43E3h,INT 2F/AX=1687h
Index:	signature strings;DPMS

Format of DPMS 1.0 server structure:
Offset	Size	Description	(Table 2020)
 00h  4 BYTEs	signature string "DPMS"
 04h  2 BYTEs	DPMS version (major,minor)
 06h  8 BYTEs	blank-padded server OEM name
 0Eh  2 BYTEs	OEM server version (major,minor)
 10h	WORD	DPMS flags (see #2021)
 12h	BYTE	CPU type
		(02h = 286, 03h = 386 or higher, higher values allowed)

Bitfields for DPMS flags:
Bit(s)	Description	(Table 2021)
 0	fast processor reset available (286 only)
 1	DPMS server is enabled
 2	memory is remapped
 3-15	reserved (undefined)

Format of beta DPMS registration structure:
Offset	Size	Description	(Table 2022)
 00h	DWORD	real-mode API entry point (see #2024)
 04h	DWORD	16-bit protected-mode API entry point (see #2024)
 08h  8 BYTEs	reserved (0)
 10h  8 BYTEs	blank-padded server OEM name
 18h	WORD	flags
		bit 0: fast processor reset available (286 only)
		bits 1-15 reserved (undefined)
 1Ah  2 BYTEs	DPMS version (major,minor)
 1Ch	BYTE	CPU type (02h = 286, 03h = 386 or higher)
--------m-2F43E1-----------------------------
INT 2F - DOS Protected Mode Services (DPMS) v1.0 - REGISTER CLIENT
	AX = 43E1h
	CX = required protected-mode stack size in bytes
	ES:DI -> DPMS client interface structure (see #2023)
Return: AX = 0000h if supported
	   CF clear
	   ES:DI buffer filled with API entry point code from offset 0Ah
Note:	the client is allowed to copy the returned API code to any location in
	  memory, and need not keep the three code fields together
SeeAlso: AX=43E0h,AX=43E2h,AX=43E3h

Format of DPMS client interface structure:
Offset	Size	Description	(Table 2023)
 00h	WORD	0000h (structure version / flags)
 02h  8 BYTEs	blank-padded client name
 0Ah  7 BYTEs	real/virtual-86 mode API code (see #2024)
 11h	BYTE	space for return instruction
		set to C3h for near return, CBh for far return
 12h  7 BYTEs	16-bit protected-mode API code (see #2024)
 19h	BYTE	space for return instruction
		set to C3h for near return, CBh for far return
 1Ah  9 BYTEs	32-bit protected-mode API code (see #2024)
 23h	BYTE	space for return instruction
		set to C3h for near return, CBh for far return
Note:	the DPMS server fills the return opcode bytes with zeros and DPMS
	  requests will thus crash the system unless the application
	  explicitly sets them (some early versions set them to C3h by
	  default, but one should not rely on that)

(Table 2024)
Call DPMS entry point with:
	AX = 0000h unregister client from server
 ---control transfer functions---
	AX = 0100h call protected-mode procedure
		CX = number of words of stack to copy
		ES:(E)DI -> callup/down register structure (see #2026)
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
	AX = 0101h call real-mode procedure (RETF return)
		CX = number of words of stack to copy
		ES:(E)DI -> callup/down register structure (see #2026)
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
	AX = 0102h call real-mode procedure (IRET return)
		CX = number of words of stack to copy
		ES:(E)DI -> callup/down register structure (see #2026)
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
	AX = 0103h call real-mode interrupt handler
		BL = interrupt number
		CX = number of words of stack to copy
		ES:(E)DI -> callup/down register structure (see #2026)
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
	AX = 0104h register default protected mode procedure
		ES:(E)DI -> default register structure (see #2027)
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
	AX = 0105h register default real-mode procedure (RETF return)
		ES:(E)DI -> default register structure (see #2027)
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
		Note:	the procedure will be called from 16-bit prot. mode
	AX = 0106h register default real-mode procedure (IRET return)
		ES:(E)DI -> default register structure (see #2027)
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
		Note:	the procedure will be called from 16-bit prot. mode
	AX = 0107h register default real-mode interrupt handler
		BL = interrupt number
		ES:(E)DI -> default register structure (see #2027)
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
		Note:	the handler will be called from 16-bit protected mode
	AX = 0108h register default real-mode procedure (RETF return)
		ES:(E)DI -> default register structure (see #2027)
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
		Note:	the procedure will be called from 32-bit prot. mode
	AX = 0109h register default real-mode procedure (IRET return)
		ES:(E)DI -> default register structure (see #2027)
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
		Note:	the procedure will be called from 32-bit prot. mode
	AX = 010Ah register default real-mode interrupt handler
		BL = interrupt number
		ES:(E)DI -> default register structure (see #2027)
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
		Note:	the handler will be called from 32-bit protected mode
 ---descriptor management---
	AX = 0200h allocate descriptors
		CX = number of descriptors to allocate
		Return: CF clear if successful
			    AX = selector for first descriptor allocated
			CF set on error
			    AX = error code (see #2025)
	AX = 0201h free a descriptor
		BX = selector for descriptor
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
	AX = 0202h create alias descriptor
		BX = selector for descriptor to be aliased
		Return: CF clear if successful
			    AX = alias descriptor
			CF set on error
			    AX = error code (see #2025)
	AX = 0203h build alias to real-mode segment
		BX = descriptor
		CX = real-mode segment
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
	AX = 0204h set descriptor base
		BX = descriptor
		CX:DX = base address
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
	AX = 0205h set descriptor limit
		BX = descriptor
		CX = limit
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
	AX = 0206h set descriptor type/attribute
		BX = descriptor
		CL = type
		CH = attribute
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
	AX = 0207h get descriptor base
		BX = descriptor
		Return: CF clear if successful
			    CX:DX = base address
			CF set on error
			    AX = error code (see #2025)
 ---linear memory functions---
	AX = 0300h get size of largest free block of memory
		Return: CF clear if successful
			    BX:CX = size
			CF set on error
			    AX = error code (see #2025)
	AX = 0301h allocate block of extended memory
		BX:CX = required size
		Return: CF clear if successful
			    BX:CX = base address
			    SI:DI = handle
			CF set on error
			    AX = error code (see #2025)
	AX = 0302h free block of extended memory
		SI:DI = handle
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
	AX = 0303h map linear memory
		ES:(E)DI -> DDS (see #2028)
		Return: CF clear if successful
			    BX:CX = base address
			    SI:DI = handle
			CF set on error
			    AX = error code (see #2025)
	AX = 0304h unmap linear memory
		SI:DI = handle
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
	AX = 0305h get page table entries
		ESI = linear address
		(E)CX = count
		ES:(E)DI -> buffer for page table entries
		Return: CF clear if successful
			    ES:(E)DI buffer filled
			CF set on error
			    AX = error code (see #2025)
	AX = 0306h set page table entries
		EBX = linear memory handle
		ESI = linear address
		(E)CX = count
		ES:(E)DI -> buffer containing page table entries
		Return: CF clear if successful
			CF set on error
			    AX = error code (see #2025)
	AX = 0307h get largest mappable block size
		Return: CF clear if successful
			    BX:CX = size
			CF set on error
			    AX = error code (see #2025)
 ---miscellaneous---
	AX = 0400h relocate segment to extended memory
		ES:SI = base address
		CX = limit
		BL = type
		BH = attribute
		DX = selector or 0000h
		Return: CF clear if successful
			    AX = selector
			    BX:CX = new base address
			    SI:DI = handle
			CF set on error
			    AX = error code (see #2025)
Note:	the beta DPMS specification, which is still supported by the Novell
	  DOS 7.0 DPMS host, only supported functions 0100h-0103h, 0200h-0207h,
	  0300h-0304h, and 0400h

(Table 2025)
Values for DPMS error code:
 8000h	general error
 8001h	unsupported function
 8002h	unable to switch to protected mode
 8004h	no default stack defined
 8005h	unknown client
 8010h	resource unavailable
 8011h	descriptor unavailable
 8012h	linear memory unavailable
 8013h	physical memory unavailable
 8021h	invalid value
 8022h	invalid selector
 8023h	invalid handle
 8025h	invalid linear address

Format of DPMS callup/down register structure:
Offset	Size	Description	(Table 2026)
 00h	DWORD	EDI
 04h	DWORD	ESI
 08h	DWORD	EBP
 0Ch  4 BYTEs	reserved (0) (ESP, may be used by DPMS server)
 10h	DWORD	EBX
 14h	DWORD	EDX
 18h	DWORD	ECX
 20h	DWORD	EAX
 24h	DWORD	EIP
 28h	WORD	CS
 2Ah  2 BYTEs	reserved (0)
 2Ch	DWORD	EFLAGS
 30h	DWORD	ESP
 34h	WORD	SS
 36h  2 BYTEs	reserved (0)
 38h	WORD	ES
 3Ah  2 BYTEs	reserved (0)
 3Ch	WORD	DS
 3Eh  2 BYTEs	reserved (0)
 40h	WORD	FS
 42h  2 BYTEs	reserved (0)
 44h	WORD	GS
 46h  2 BYTEs	reserved (0)

Format of DPMS default register structure:
Offset	Size	Description	(Table 2027)
 00h	DWORD	EIP
 04h	WORD	CS
 06h  2 BYTEs	reserved (0)
 08h	WORD	number of words to copy from stack to stack
 0Ah	BYTE	(call) 00h
		(ret) nonzero if call could not be made
 0Bh	BYTE	reserved (may be used by some servers)
 0Ch	DWORD	ESP
 10h	WORD	SS
 12h  2 BYTEs	reserved (0)
 14h	WORD	ES
 16h  2 BYTEs	reserved (0)
 18h	WORD	DS
 1Ah  2 BYTEs	reserved (0)
 1Ch	WORD	FS
 1Eh  2 BYTEs	reserved (0)
 20h	WORD	GS
 22h  2 BYTEs	reserved (0)
 24h  9 BYTEs	API entry code (filled in by server)

Format of DPMS lock DDS:
Offset	Size	Description	(Table 2028)
 00h	DWORD	total size in bytes
 04h	DWORD	offset
 08h	WORD	segment or selector
 0Ah	WORD	reserved
 0Ch	WORD	maximum number of physical blocks structure has space for
 0Eh	WORD	number of physical blocks listed
 10h	DWORD	physical address of first block
 14h	DWORD	size in bytes of first block
	...
--------m-2F43E2-----------------------------
INT 2F - DOS Protected Mode Services (DPMS) v1.0 - ENABLE/DISABLE DPMS
	AX = 43E2h
	BX = new state (0000h disable, 0001h enable)
Return: AX = 0000h if supported
Note:	this function should normally be called only by system software
SeeAlso: AX=43E0h,AX=43E1h,AX=43E3h
--------m-2F43E3BX0000-----------------------
INT 2F - DOS Protected Mode Services (DPMS) v1.0 - DPMS STARTUP BROADCAST
	AX = 43E3h
	BX = 0000h
	CX = 4450h ('DP')
	DX = 4D53h ('MS')
SeeAlso: AX=43E0h,AX=43E4h
--------m-2F43E4BX0000-----------------------
INT 2F - DOS Protected Mode Services (DPMS) v1.0 - DPMS EXIT BROADCAST
	AX = 43E4h
	BX = 0000h
	CX = 4450h ('DP')
	DX = 4D53h ('MS')
SeeAlso: AX=43E0h,AX=43E3h
--------E-2F44-------------------------------
INT 2F U - DOS Extender support???
	AH = 44h
	AL = function (at least 0Bh, 15h, 17h)
	???
Return: ???
Note:	called by Codeview for Windows
SeeAlso: AH=86h
--------G-2F4500-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - INSTALLATION CHECK
	AX = 4500h
Return: AL = installation status
	    01h if PROF.COM installed
	    02h if VPROD.386 installed
SeeAlso: AX=4501h,AX=4502h
--------G-2F4501-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - SETUP PROFILER
	AX = 4501h
	BX = CSIPS buffer size in KB (first parameter for ProfSetup)
	CX = output limit in KB (second parameter for ProfSetup)
Note:	this call is not supported by PROF.COM
SeeAlso: AX=4502h,AX=4503h
--------G-2F4502-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - SET SAMPLING RATE
	AX = 4502h
	BL = sampling rate for PROF.COM (0 < BL <= 13)
	    (01h = 8192/s, 04h = 1024/s, 08h = 32/s, 0Dh = 1/s)
	CX = sampling rate for VPROD.386
Note:	for PROF.COM, this programs the CMOS clock by setting BL+2 as the
	  low four bits of CMOS register 0Ah.  The interruption rate is
	  1 SHL (15 - BL) per second.
SeeAlso: AX=4501h,AX=4503h
--------G-2F4503-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - START PROFILING
	AX = 4503h
Notes:	Profiling is also turned on by the key combinations
	  LeftShift + RightShift + Alt and LeftShift + RightShift + Ctrl
	for PROF.COM, this call programs the CMOS clock by reading register
	  0Ch, and setting bit 6 of register 0Bh.  It then makes sure that IRQ8
	  is unmasked
SeeAlso: AX=4504h
--------G-2F4504-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - STOP PROFILING
	AX = 4504h
Notes:	profiling is also turned off by the key combination
	  LeftShift + RightShift
	for PROF.COM, this programs the CMOS clock by reading register 0Ch
	  and clearing bit 6 of register 0Bh.  It then masks IRQ8.
SeeAlso: AX=4503h,AX=4505h,AX=4506h,AX=4507h
--------G-2F4505-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - CLEAR PROFILING DATA
	AX = 4505h
SeeAlso: AX=4503h,AX=4504h,AX=4506h
--------G-2F4506-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - "ProfFlush"
	AX = 4506h
SeeAlso: AX=4505h,AX=4507h
--------G-2F4507-----------------------------
INT 2F U - Microsoft Profiler (PROF.COM/VPROD.386) - "ProfFinish"
	AX = 4507h
Note:	this call is essentially a "ProfStop" (AX=4504h) followed by
	  "ProfFlush" (AX=4506h)
SeeAlso: AX=4504h,AX=4505h,AX=4506h
--------G-2F4508-----------------------------
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
--------D-2F4601-----------------------------
INT 2F CU - MS Windows WINOLDAP - SWITCHING ???
	AX = 4601h
Return: ???
Note:	the DOS 5+ kernel intercepts this function and copies the MCB
	   following the caller's PSP memory block into the DOS data segment;
	   in conjunction with AX=4602h, this intercept is used by DOS to
	   avoid corruption of the Windows real-mode heap's end sentinel
SeeAlso: AX=1700h,AX=4602h
--------D-2F4602-----------------------------
INT 2F CU - MS Windows WINOLDAP - SWITCHING ???
	AX = 4602h
Return: ???
Note:	the DOS 5+ kernel intercepts this function and copies the
	  previously-saved MCB from the DOS data segment into the MCB following
	  the caller's PSP memory block; in conjunction with AX=4601h, this
	  intercept is used by DOS to avoid corruption of the Windows real-mode
	  heap's end sentinel
SeeAlso: AX=1700h,AX=4601h
--------E-2F46-------------------------------
INT 2F U - Windows/286 DOS Extender
	AH = 46h
	AL = subfunction (03h,04h)
Return: ???
Note:	these two subfunctions are called by MS Windows 3.0
--------v-2F4653CX0002-----------------------
INT 2F - F-PROT v1.x only - F-LOCK.EXE - API
	AX = 4653h ('FS')
	CX = 0002h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
		Return: AX,BX,ES destroyed
	    0002h  disable (v1.08 and below only)
	    0003h  enable (v1.08 and below only)
Program: F-LOCK is part of the shareware F-PROT virus/trojan protection
	  package by Fridrik Skulason
SeeAlso: AX=4653h/CX=0003h,AX=CA00h,INT 21/AX=4BEEh
Index:	installation check;F-LOCK|uninstall;F-LOCK
--------v-2F4653CX0003-----------------------
INT 2F - F-PROT v1.x only - F-XCHK.EXE - API
	AX = 4653h ('FS')
	CX = 0003h
	BX = subfunction
	    0000h  installation check
		Return: AX = FFFFh
	    0001h  uninstall
		Return: AX,BX,ES destroyed
Program: F-XCHK is part of the shareware F-PROT virus/trojan protection
	  package by Fridrik Skulason
SeeAlso: AX=4653h/CX=0002h,AX=4653h/CX=0004h,AX=CA00h
Index:	installation check;F-XCHK|uninstall;F-XCHK
--------v-2F4653CX0004-----------------------
INT 2F - F-PROT v1.x only - F-POPUP.EXE - API
	AX = 4653h ('FS')
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
Program: F-POPUP is part of the shareware F-PROT virus/trojan protection
	  package by Fridrik Skulason
SeeAlso: AX=4653h/CX=0003h,AX=4653h/CX=0005h,AX=CA00h
Index:	installation check;F-POPUP|uninstall;F-POPUP
--------v-2F4653CX0005-----------------------
INT 2F - F-PROT v1.x only - F-DLOCK.EXE - API
	AX = 4653h ('FS')
	CX = 0005h
	BX = subfunction
	    0000h installation check
		Return: AX = FFFFh
	    0001h uninstall
		Return: AX,BX,ES destroyed
Program: F-DLOCK is part of the shareware F-PROT virus/trojan protection
	  package by Fridrik Skulason
SeeAlso: AX=4653h/CX=0004h,AX=CA00h
Index:	installation check;F-DLOCK|uninstall;F-DLOCK
----------2F4653CX0007-----------------------
INT 2F - F-PROT v2.x - VIRSTOP - ENABLE/DISABLE BOOTSECTOR READ CHECKING
	AX = 4653h ('FS')
	CX = 0007h
	BL = new state of bootsector checking (01h = disabled)
Program: VIRSTOP is the resident virus-checker from Fridrik Skulason's F-PROT
	  virus/trojan protection package
----------2F4653CX0008-----------------------
INT 2F - F-PROT v2.x - ???
	AX = 4653h ('FS')
	CX = 0008h
	???
Return: ???
Note:	called by F-PROT v2.x VIRSTOP
----------2F4653CX0008-----------------------
INT 2F - F-PROT v2.x - VIRSTOP - INSTALLATION CHECK
	AX = 4653h ('FS')
	CX = 0008h
Return: AX = 5346h if installed
	    BX = version???
	    DS:SI -> ASCIZ name of file containing virus signatures
	    DS:DI -> 80-byte buffer for ??? 
--------W-2F4680-----------------------------
INT 2F U - MS Windows v3.0 - INSTALLATION CHECK
	AX = 4680h
Return: AX = result
	    0000h MS Windows 3.0 running in real (/R) or standard (/S) mode,
		  or DOS 5 DOSSHELL active
	    nonzero  no Windows, Windows prior to 3.0, or Windows3 in enhanced
		  mode
Note:	Windows 3.1 finally provides an installation check which works in all
	  modes (see AX=160Ah)
SeeAlso: AX=1600h,AX=160Ah
----------2F47-------------------------------
INT 2F U - ???
	AH = 47h
	???
Return: ???
Note:	reportedly called by Microsoft BASIC Compiler v7.0
--------K-2F4800-----------------------------
INT 2F - DOS 5+ DOSKEY - INSTALLATION CHECK
	AX = 4800h
Return: AL = nonzero if installed (DOS 5.0 and 6.0 return AX=AA02h)
	    ES = segment of DOSKEY resident portion
Note:	DOSKEY chains if AL is not 00h or 10h on entry
SeeAlso: AX=4800h"PCED",AX=4810h
--------K-2F4800-----------------------------
INT 2F - PCED v2.1 - INSTALLATION CHECK
	AX = 4800h
Return: AX = AACDh if installed
	    ES = segment of PCED kernel (PCED has multiple code segments)
Program: PCED v2.1 is a command line editor/history/macro facility by
	  Cove Software.  It is the commercial version of the freeware CED.
Notes:	DOSKEY also responds to this call if installed, returning AX=AA02h.
	unlike DOSKEY, PCED does *not* chain if AL contains an
	  unsupported function code.  It IRETs with all registers intact.
--------K-2F4810-----------------------------
INT 2F - DOS 5+ DOSKEY, PCED v2.1 - READ INPUT LINE FROM CONSOLE
	AX = 4810h
	DS:DX -> line buffer (see #0661 at INT 21/AH=0Ah)
Return: AX = 0000h if successful
Notes:	the first byte (length) of the buffer MUST be 80h, or DOSKEY chains to
	  the previous handler; PCED allows sizes other than 80h
	if the user's input is a macro name, no text is placed in the buffer
	  even though AX=0000h on return; the program must immediately issue
	  this call again to retrieve the expansion of the macro.  Similarly,
	  if the user enters a special parameter such as $*, this call must
	  be repeated to retrieve the expansion; on the second call, DOSKEY
	  overwrites the macro name on the screen with its expansion.
	unlike DOSKEY, PCED expands all macros on the first call, so it is
	  not necessary to make two calls; since the buffer is not empty on
	  return, DOSKEY-aware programs will not make the second call
	DOSKEY chains if AL is not 00h or 10h on entry
SeeAlso: AX=4800h,INT 21/AH=0Ah
--------K-2F48C0-----------------------------
INT 2F - PCED v2.1 - PCED API
	AX = 48C0h
	DX = API function code
	other registers as required by the specified function
Return: CF clear if successful
	CF set on error
	    AX = PCED error code
	other registers as appropriate for API function
Program: PCED v2.1 is a command line editor/history/macro facility by
	  Cove Software.  It is the commercial version of the freeware CED.
Note:	the full API information is available from Cove Software
SeeAlso: AX=4800h"PCED",AX=48C1h,AX=48C2h,AX=48C3h
--------U-2F48C1BL00-------------------------
INT 2F - PCED/VSTACK - INSTALLATION CHECK
	AX = 48C1h
	BL = 00h
Return: AX = 0000h if installed
	    BX = VSTACK resident segment
Program: VSTACK is a resident backscroll utility included as part of the PCED
	  package by Cove Software
Note:	chains if BL <> 00h on entry
SeeAlso: AX=48C0h,AX=48C2h
--------U-2F48C2BL00-------------------------
INT 2F - PCED/ATTRIB - INSTALLATION CHECK
	AX = 48C2h
	BL = 00h
Return: AX = 0000h if installed
	    BX = ATTRIB resident segment
Program: ATTRIB is a resident file attribute changer included as part of the
	  PCED package by Cove Software
Note:	chains if BL <> 00h on entry
SeeAlso: AX=48C0h,AX=48C1h,AX=48C3h
--------K-2F48C3BL00-------------------------
INT 2F - PCED/KEYDEF - INSTALLATION CHECK
	AX = 48C3h
	BL = 00h
Return: AX = 0000h if installed
	    BX = KEYDEF resident segment
Program: KEYDEF is a resident keyboard redefinition utility included as part
	  of the PCED package by Cove Software
Note:	chains if BL <> 00h on entry
SeeAlso: AX=48C0h,AX=48C2h,AX=48C4h
--------U-2F48C4BL00-------------------------
INT 2F - PCED/FLIST - INSTALLATION CHECK
	AX = 48C4h
	BL = 00h
Return: AX = 0000h if installed
	    BX = FLIST resident segment
Program: FLIST is a resident filelist processor included as part of the PCED
	  package by Cove Software
Note:	chains if BL <> 00h on entry
SeeAlso: AX=48C0h,AX=48C3h,AX=48C5h
--------U-2F48C5BL00-------------------------
INT 2F - PCED/ASSOC - INSTALLATION CHECK
	AX = 48C5h
	BL = 00h
Return: AX = 0000h if installed
	    BX = ASSOC resident segment
Program: ASSOC is a resident utility included as part of the PCED package which
	  associated files with executable programs based on their extensions
Note:	chains if BL > 02h on entry
SeeAlso: AX=48C0h,AX=48C4h,AX=48C5h/BL=01h,AX=48C5h/BL=02h
--------U-2F48C5BL01-------------------------
INT 2F - PCED/ASSOC - GET VERSION
	AX = 48C5h
	BL = 01h
Return: AX = 0000h if installed
	    BX = binary ASSOC version (BL = major, BH = minor)
Note:	chains if BL > 02h on entry
SeeAlso: AX=48C0h,AX=48C5h/BL=00h,AX=48C5h/BL=02h
--------U-2F48C5BL02-------------------------
INT 2F - PCED/ASSOC - ASSOCIATION TEST
	AX = 48C5h
	BL = 02h
	DS:SI -> ASCIZ filename
Return: AX = status
	    0000h if filename is unknown
	    0001h if there is an association defined for the file
	BX destroyed
Program: ASSOC is a resident utility included as part of the PCED package which
	  associated files with executable programs based on their extensions
Note:	chains if BL > 02h on entry
SeeAlso: AX=48C0h,AX=48C5h/BL=00h,AX=48C5h/BL=01h
----------2F49-------------------------------
INT 2F U - ???
	AH = 49h
	???
Return: ???
Note:	reportedly called by DOS 5.0 installation
--------D-2F4A00CX0000-----------------------
INT 2F CU - DOS 5+ - FLOPPY-DISK LOGICAL DRIVE CHANGE NOTIFICATION
	AX = 4A00h
	CX = 0000h
	DH = new drive number
	DL = current drive number
Return: CX = FFFFh to skip "Insert diskette for drive X:" message
Note:	called by MS-DOS 5.0+ IO.SYS just before displaying the message
	  "Insert diskette for drive X:" on single-floppy systems
--------D-2F4A01-----------------------------
INT 2F - DOS 5+ - QUERY FREE HMA SPACE
	AX = 4A01h
Return: BX = number of bytes available in HMA (0000h if DOS not using HMA)
	ES:DI -> start of available HMA area (FFFFh:FFFFh if not using HMA)
Notes:	called by Windows 3.1 DOSX.EXE
	supported by Novell DOS 7
SeeAlso: AX=4310h,AX=4A02h
--------D-2F4A02-----------------------------
INT 2F - DOS 5+ - ALLOCATE HMA SPACE
	AX = 4A02h
	BX = number of bytes
Return: ES:DI -> start of allocated HMA block or FFFFh:FFFFh
	BX = number of bytes actually allocated (rounded up to next paragraph
	      for DOS 5.0 and 6.0)
Notes:	this call is not valid unless DOS is loaded in the HMA (DOS=HIGH)
	called by Windows 3.1 DOSX.EXE
	supported by Novell DOS 7
SeeAlso: AX=4A01h
--------T-2F4A05-----------------------------
INT 2F U - DOS 5+ DOSSHELL - TASK SWITCHING API???
	AX = 4A05h
	SI = function
	    0000h reset???
	    0001h ???
		ES:BP -> 80-byte buffer containing ???
	    0002h ???
	    0003h ???
	    0004h ???
		BL = ???
	    0005h ???
	    0006h get ???
		Return: ES:SI -> ???
	    0007h get ???
		Return: AX = ???
	    0008h get ???
		Return: DX:AX -> ??? (internal control data of some kind)
	    0009h get ???
		Return: ES:SI -> ??? (apparently identical to function 0006h)
	    000Ah ???
		BL = length of buffer
		ES:BP -> buffer containing ???
	    000Bh get ???
		Return: AX = ???
	    000Ch ???
		BL = ???
		Return: if BL nonzero on entry
			    DX:AX -> ???
			if BL = 00h on entry
			    ES:SI -> ???
Notes:	DOSSHELL chains to the previous handler if SI is not one of the values
	  listed above
	the DOSSWAP.EXE module calls functions 03h,04h,05h,07h,08h,09h,0Ch
	the Windows 3.1 DSWAP.EXE and WSWAP.EXE task switchers use these calls
SeeAlso: AX=4B01h
--------D-2F4A06-----------------------------
INT 2F CU - DOS 5+ - DOS SUPERVISOR "REBOOT PANEL" - ADJUST MEMORY SIZE
	AX = 4A06h
	DX = segment following last byte of conventional memory
Return: DX = segment following last byte of memory available for use by DOS
Desc:	used to override the default memory size when booting diskless
	  workstations
Notes:	called by MS-DOS 5+ IO.SYS startup code if the signature "RPL" is
	  present three bytes beyond the INT 2F handler; this call overrides
	  the value returned by INT 12
	hooked by RPL code at the top of memory to protect itself from being
	  overwritten; DOS builds a memory block with owner = 0008h and name
	  "RPL" which must be freed by the RPL code when it is done
SeeAlso: INT 12,INT 18
--------N-2F4A07-----------------------------
INT 2F U - RESERVED FOR PROTMAN SUPPORT
	AX = 4A07h
	???
Return: ???
--------c-2F4A10BX0000-----------------------
INT 2F - SMARTDRV v4.00+ - INSTALLATION CHECK AND HIT RATIOS
	AX = 4A10h
	BX = 0000h
	CX = EBABh (v4.1+; see Note)
Return: AX = BABEh if installed
	    DX:BX = cache hits
	    DI:SI = cache misses
	    CX = number of dirty cache elements
	    BP = version in BCD (4.10 = 0410h)
Notes:	most of the SMARTDRV API, including this call, is supported by
	  PC-Cache v8.0 and recent versions of the Norton Caches
	if DBLSPACE.BIN is installed but SMARTDRV has not yet been installed,
	  then calls of this function with CX<>EBABh on entry cause
	  DBLSPACE.BIN to display the error message
	  "Cannot run SMARTDrive 4.0 with DoubleSpace" and abort the caller
	  with INT 21/AX=4C00h
	SMARTDRV v3.x had a completely different API using IOCTL calls, which
	  was also supported by the Norton Caches
SeeAlso: AX=4A10h/BX=0001h,AX=4A10h/BX=0004h,AX=4A10h/BX=0005h
SeeAlso: AX=4A10h/BX=0007h,AX=4A10h/BX=1234h,AX=4A11h/BX=0000h
SeeAlso: INT 21/AX=4402h"SMARTDRV",INT 21/AX=4403h"SMARTDRV"
--------c-2F4A10BX0000-----------------------
INT 2F U - Novell NWCACHE - ???
	AX = 4A10h
	BX = 0000h
	CX = 0EDCh ('EDC' = Novell European Development Center)
Return: ???
SeeAlso: AX=4A10h/BX=0001h"NWCACHE"
--------c-2F4A10BX0001-----------------------
INT 2F - SMARTDRV v4.00+ - FLUSH BUFFERS (COMMIT CACHE)
	AX = 4A10h
	BX = 0001h
Note:	this function is also supported by PC-Cache v8.0.
SeeAlso: AX=4A10h/BX=0000h,AX=4A10h/BX=0002h
--------c-2F4A10BX0001-----------------------
INT 2F U - Novell NWCACHE - ???
	AX = 4A10h
	BX = 0001h
	CX = 0EDCh ('EDC' = Novell European Development Center)
Return: ???
SeeAlso: AX=4A10h/BX=0000h"NWCACHE"
--------c-2F4A10BX0002-----------------------
INT 2F - SMARTDRV v4.00+ - RESET CACHE
	AX = 4A10h
	BX = 0002h
Note:	this function is also supported by PC-Cache v8.0.
SeeAlso: AX=4A10h/BX=0000h,AX=4A10h/BX=0001h
--------c-2F4A10BX0003-----------------------
INT 2F - SMARTDRV v4.00+ - STATUS
	AX = 4A10h
	BX = 0003h
	BP = drive number (0=A, 1=B, etc.)
	DL = subfunction
	    00h only get information
	    01h turn on read cache
	    02h turn off read cache
	    03h turn on write cache
	    04h turn off write cache
Return: AX = BABEh if OK
	DL = status (see #2029)
	DL = FFh if drive does not exist
Notes:	If the read cache is off, reads will not be cached, but writes will
	  continue to be cached if the write-cache is enabled.
	this function is also supported by PC-Cache v8.0.
SeeAlso: AX=4A10h/BX=0000h

Bitfields for SMARTDRV status:
Bit(s)	Description	(Table 2029)
 7	not cached
 6	write-through (not write-cached)
 0-5	real drive number (0=A, 1=B...)
--------c-2F4A10BX0004-----------------------
INT 2F - SMARTDRV v4.00+ - GET CACHE SIZE
	AX = 4A10h
	BX = 0004h
Return: AX = size in elements of full-sized cache
	BX = current size in elements
	CX = size of one element in bytes
	DX = number of elements under Windows
Note:	this function is also supported by PC-Cache v8.0.
SeeAlso: AX=4A10h/BX=0000h,AX=4A10h/BX=0003h,AX=4A10h/BX=0005h
--------c-2F4A10BX0005-----------------------
INT 2F - SMARTDRV v4.00+ - GET DOUBLE-BUFFER STATUS
	AX = 4A10h
	BX = 0005h
	BP = drive number (0=A, 1=B...)
Return: AX = BABEh if double-buffered
	    ES:DI -> 16-byte array of status bytes for fixed disks (see #2030)
SeeAlso: AX=4A10h/BX=0000h,AX=4A10h/BX=0003h,AX=4A10h/BX=0006h

(Table 2030)
Values for SMARTDRV status byte:
 00h	state unknown
 FFh	drive double-buffered
 else	not double-buffered
--------c-2F4A10BX0006-----------------------
INT 2F CU - SMARTDRV v4.00+ - CHECK IF DRIVE CACHEABLE
	AX = 4A10h
	BX = 0006h
	CL = drive number (01h = A:)
Return: AX = 0006h if drive should not be cached by SMARTDRV
Note:	called by SMARTDRV at startup to determine whether it should cache
	  a particular drive
SeeAlso: AX=4A10h/BX=0000h
--------c-2F4A10BX0007-----------------------
INT 2F - SMARTDRV v4.00+ - GET DEVICE DRIVER FOR DRIVE
	AX = 4A10h
	BX = 0007h
	BP = drive number (00h=A:)
Return: DL = unit number within device driver
	ES:DI -> device driver header for drive
Note:	this function is also supported by PC-Cache v8.0.
	this call is reported to always return the driver header of the
	  standard block driver (A:-C:+) for SmartDrive v5.00 from MS-DOS 6.2
SeeAlso: AX=4A10h/BX=0000h,AX=4A11h/BX=0003h,AX=4A11h/BX=0004h
--------c-2F4A10BX0008-----------------------
INT 2F - SMARTDRV v4.20+ - GET/SET FLUSH BEFORE PROMPT, CD-ROM SUPPORT
	AX = 4A10h
	BX = 0008h
	DL = subfunction
	    00h set
		DH = new states
		    bit 0: flush before prompt
		    bits 1-7 reserved (0)
	    01h get
		Return: DH = status flags
			    bit 0: (v4.2+) flush before prompt
			    bit 1: (v5.0+) CD-ROM caching support installed
Note:	v4.2 was an interim release to fix problems in the SMARTDRV included
	  with MS-DOS 6.00; v5.00 is included with MS-DOS 6.2
--------c-2F4A10BX000A-----------------------
INT 2F - SMARTDRV v4.00+ - GET ELEMENT STATUS TABLE
	AX = 4A10h
	BX = 000Ah
Return: ES:BX -> information pointer table (see #2031)
Note:	this function is also supported by PC-Cache v8.0.
SeeAlso: AX=4A10h/BX=0000h

Format of SMARTDRV information pointer table:
Offset	Size	Description	(Table 2031)
 00h	WORD	offset of ??? byte/word array (byte if elements < 2000h bytes)
 02h	WORD	offset of dirty flag byte/word array (byte if elts < 2000h)
		each byte/word is a bit string of the dirty sectors in element
 04h	WORD	offset of word array containing low halves of unique
		  identifiers for the corresponding element's contents
 06h	WORD	offset of word array containing high halves of unique
		  identifiers for the corresponding element's contents
 08h	WORD	offset of WORD containing current number of elements in cache
--------c-2F4A10BX1234-----------------------
INT 2F - SMARTDRV v4.00+ - SIGNAL SERIOUS ERROR
	AX = 4A10h
	BX = 1234h
Desc:	this function pops up a message box saying that a serious error
	  occurred and to hit R to retry, then waits for the keypress
Note:	this function is also supported by PC-Cache v8.0.
SeeAlso: AX=4A10h/BX=0000h
--------k-2F4A11BX0000-----------------------
INT 2F - DBLSPACE.BIN - "GetVersion" - INSTALLATION CHECK
	AX = 4A11h
	BX = 0000h
Return: AX = 0000h (successful)
	BX = 444Dh ("DM")
	CL = first drive letter used by DBLSPACE (41h ['A'] = A:)
	CH = number of drive letters used by DBLSPACE
	DX = internal DBLSPACE.BIN version number (bits 14-0)
		bit 15 set if DBLSPACE.BIN has not yet been relocated to final
		  position in memory (i.e. DBLSPACE.SYS /MOVE)
Program: DBLSPACE.BIN is the resident driver for DoubleSpace, the
	  disk-compression software bundled with MS-DOS 6.0 and 6.20
Notes:	this function is also supported by the version of SuperStor bundled
	  with IBM DOS 6.x and "preloading" versions of Stacker
	the complete DBLSPACE.BIN API is still supported by MS-DOS 6.22's
	  DRVSPACE.BIN
SeeAlso: AX=4A11h/BX=0001h,AX=4A11h/BX=0002h,AX=4A11h/BX=0003h
SeeAlso: AX=4A11h/BX=0005h,AX=4A11h/BX=0007h,AX=4A11h/BX=FFFFh
SeeAlso: INT 21/AX=4404h"DBLSPACE"
--------k-2F4A11BX0001-----------------------
INT 2F - DBLSPACE.BIN - "GetDriveMapping" - GET DRIVE MAPPING
	AX = 4A11h
	BX = 0001h
	DL = drive number (0=A:)
Return: AX = status (see also #2032)
	    0000h successful
		if DL was compressed drive,
		    BL = host drive (bit 7 set if drive is compressed)
		else if DL was host drive,
		    BL = compressed drive
		else
		    BL = specified drive (if available for DoubleSpace)
		BH = DoubleSpace sequence number
	    other error code (0101h) (see #2032)
		apparently never returned for the MS-DOS 6.2 DoubleSpace
Note:	the compressed volume file for the specified compressed drive is
	  host:\DBLSPACE.sequence
SeeAlso: AX=4A11h/BX=0000h

(Table 2032)
Values for DBLSPACE function status:
 0000h	successful
 0100h	bad function
 0101h	invalid drive
 0102h	not a compressed drive
 0103h	drive already swapped
 0104h	drive not swapped
--------k-2F4A11BX0002-----------------------
INT 2F - DBLSPACE.BIN - "Swap Drive" - SWAP DRIVE LETTERS OF CVF AND HOST DRIVE
	AX = 4A11h
	BX = 0002h
	DL = drive number (0=A:) of compressed drive to swap with its host
Return: AX = status (0000h,0101h,0102h,0103h) (see #2032)
Note:	this function is intended for use by DBLSPACE.EXE only
SeeAlso: AX=4A11h/BX=0000h
--------k-2F4A11BX0003-----------------------
INT 2F - DBLSPACE.BIN - "DSGetEntryPoints" - GET DEVICE DRIVER ENTRY POINTS
	AX = 4A11h
	BX = 0003h
	CL = drive number (0=A:) of compressed drive
Return: CL = FFh on error (not compressed drive)
	CL <> FFh driver unit number of host drive
	    ES:SI -> device driver's strategy routine
	    ES:DI -> device driver's interrupt routine
	BX destroyed
Note:	in conjunction with subfunction 0004h, this call allows disk caches
	  like SMARTDRV to apply a device driver wrapper to DoubleSpaced
	  drives just like SMARTDRV applies to regular block devices
SeeAlso: AX=4A10h/BX=0007h,AX=4A11h/BX=0000h,AX=4A11h/BX=0004h
--------k-2F4A11BX0004-----------------------
INT 2F - DBLSPACE.BIN - "DSSetEntryPoints" - SET DEVICE DRIVER ENTRY POINTS
	AX = 4A11h
	BX = 0004h
	CL = drive number (0=A:) of compressed drive
	DL = unit number for new driver entry points
	DH = 00h
	ES:SI -> device driver strategy routine to call for drive
	ES:DI -> device driver interrupt routine to call for drive
Return: CL = FFh on error (not a compressed drive)
	BX destroyed
Program: DBLSPACE.BIN is the resident driver for DoubleSpace, the
	  disk-compression software bundled with MS-DOS 6.0
Note:	in conjunction with subfunction 0003h, this call allows disk caches
	  like SMARTDRV to apply a device driver wrapper to DoubleSpaced
	  drives just like SMARTDRV applies to regular block devices
SeeAlso: AX=4A10h/BX=0007h,AX=4A11h/BX=0000h,AX=4A11h/BX=0003h
--------k-2F4A11BX0005-----------------------
INT 2F - DBLSPACE.BIN - "ActivateDrive" - MOUNT COMPRESSED DRIVE
	AX = 4A11h
	BX = 0005h
	DL = drive number (0=A:) to assign to new drive
	ES:SI -> activation record (see #2033)
Return: status returned in activation record (see #2034)
SeeAlso: AX=4A11h/BX=0000h,AX=4A11h/BX=0006h

Format of DBLSPACE activation record:
Offset	Size	Description	(Table 2033)
 00h  2 BYTEs	signature "MD" (4Dh 44h)
 02h	BYTE	4Dh ('M') mount command
 03h	BYTE	error code (set to FFh before calling) (see #2034)
 04h	BYTE	host drive number (0=A:)
 05h	???	DISK_UNIT structure (not documented)

(Table 2034)
Values for DBLSPACE Mount error code:
 00h	successful
 01h	drive letter not available for DoubleSpace
 02h	drive letter already in use
 03h	no more disk units (increase MaxRemovableDrives in .INI)
 09h	CVF too fragmented
--------k-2F4A11BX0006-----------------------
INT 2F - DBLSPACE.BIN - "DeactivateDrive" - UNMOUNT COMPRESSED DRIVE
	AX = 4A11h
	BX = 0006h
	DL = drive number (0=A:) to unmount
Return: AX = status (0000h,0102h) (see #2032)
SeeAlso: AX=4A11h/BX=0000h,AX=4A11h/BX=0005h
--------k-2F4A11BX0007-----------------------
INT 2F - DBLSPACE.BIN - "GetDriveSpace" - GET SPACE AVAIL ON COMPRESSED DRIVE
	AX = 4A11h
	BX = 0007h
	DL = compressed drive number (0=A:)
Return: AX = status (0000h,0102h) (see also #2032)
	    0000h successful
		DS:SI -> free space record (see #2035)
Program: DBLSPACE.BIN is the resident driver for DoubleSpace, the
	  disk-compression software bundled with MS-DOS 6.0
SeeAlso: AX=4A11h/BX=0000h,AX=4A11h/BX=0008h

Format of DBLSPACE free space record:
Offset	Size	Description	(Table 2035)
 00h	DWORD	total number of sectors in drive's sector heap
 04h	DWORD	number of free sectors in drive's sector heap
--------k-2F4A11BX0008-----------------------
INT 2F - DBLSPACE.BIN - "GetFileFragmentSpace" - GET SIZE OF FRAGMENT HEAP
	AX = 4A11h
	BX = 0008h
	DL = compressed drive number (0=A:)
Return: AX = status (0000h,0102h) (see also #2032)
	    0000h successful
		BX = maximum entries in File Fragment heap
		CX = available entries in File Fragment heap
SeeAlso: AX=4A11h/BX=0000h,AX=4A11h/BX=0007h,AX=4A11h/BX=0009h
--------k-2F4A11BX0009-----------------------
INT 2F - DBLSPACE.BIN - "GetExtraInfo" - DETERMINE NUMBER OF DISK_UNIT STRUCTS
	AX = 4A11h
	BX = 0009h
	DL = compressed drive number (0=A:)
Return: AX = status (see also #2032)
	    0000h successful
		CL = number of DISK_UNIT structures allocated
			  (see AX=4A11h/BX=0005h)
		CH = DoubleGuard enabled-checks bitflags in bits 6-0 (DOS 6.2)
Note:	the DoubleGuard checks are enabled or disabled as a block by the
	  DoubleGuard= line in DBLSPACE.INI; they may be individually set with
	  the CheckSum= line.
SeeAlso: AX=4A11h/BX=0000h,AX=4A11h/BX=0008h
--------k-2F4A11BX000A-----------------------
INT 2F - DBLSPACE.BIN v6.2 - SET AUTOMOUNT DRIVES
	AX = 4A11h
	BX = 000Ah
	CX:DX = bitmask of drives on which to enable AutoMount
		(DX bit 0 = A:, CX bit 0 = P:, etc.)
Return: AX = 0000h if supported
	    CX:DX = old mask or 0000h:0000h on error
	BX destroyed
SeeAlso: AX=4A11h/BX=000Bh
--------k-2F4A11BX000B-----------------------
INT 2F - DBLSPACE.BIN v6.2 - GET AUTOMOUNT DRIVES
	AX = 4A11h
	BX = 000Bh
Return: AX = 0000h if supported
	    CX:DX = mask of drives with AutoMount enabled
		0000h:0000h on error
	BX destroyed
SeeAlso: AX=4A11h/BX=000Ah
--------k-2F4A11BXFFFE-----------------------
INT 2F U - DBLSPACE.BIN - RELOCATE
	AX = 4A11h
	BX = FFFEh
	ES = segment to which to relocate DBLSPACE.BIN
Return: ???
Notes:	called by DBLSPACE.SYS to relocate DBLSPACE.BIN to its final position
	  in memory
	this function also unhooks and discards the code providing this
	  function and AX=4A11h/BX=FFFFh
	this function is also supported by the version of SuperStor bundled
	  with IBM DOS 6.x and "preloading" versions of Stacker
SeeAlso: AX=4A11h/BX=FFFFh
--------k-2F4A11BXFFFF-----------------------
INT 2F U - DBLSPACE.BIN - GET RELOCATION SIZE
	AX = 4A11h
	BX = FFFFh
Return: AX = number of paragraphs needed by DBLSPACE.BIN
Note:	used by DBLSPACE.SYS to relocate the DBLSPACE driver to its final
	  position in memory
	this function is also supported by the version of SuperStor bundled
	  with IBM DOS 6.x and "preloading" versions of Stacker
SeeAlso: AX=4A11h/BX=0000h,AX=4A11h/BX=FFFEh
--------k-2F4A12CX4D52-----------------------
INT 2F - Microsoft Realtime Compression Interface (MRCI) - RAM-BASED SERVER
	AX = 4A12h
	CX = 4D52h ("MR")
	DX = 4349h ("CI")
Return: CX = 4943h ("IC") if installed
	DX = 524Dh ("RM") if installed
	    ES:DI -> MRCINFO structure (see #0590 at INT 1A/AX=B001h)
Note:	this call is functionally identical to INT 1A/AX=B001h, but should be
	  called first, as the latter call is used for the first, ROM-based
	  MRCI server, while this call is used for RAM-based servers which
	  may be partially or entirely replacing a prior server
SeeAlso: AX=4A12h/CX=5354h,INT 1A/AX=B001h
--------k-2F4A12CX5354-----------------------
INT 2F - Stacker 4 LZS Compression Interface (LZSAPI)
	AX = 4A12h
	CX = 5354h ("ST")
	DX = 4143h ("AC")
Return: AX = 4F4Bh ("OK") if installed
	CX = 7374h ("st") if installed
	DX = 6163h ("ac") if installed
	    ES:DI -> entry point in LZSAPI server (usually, driver
		      STACKER.COM) containing far address of an actual
		      LZSINFO structure (see #2036)
SeeAlso: AX=4A12h/CX=4D52h,INT 25/AX=CDCDh

Format of LZSINFO structure:
Offset	Size	Description	(Table 2036)
 00h  6 BYTEs	signature "LZSAPI"
 06h	WORD	server version (200 (0C8h) for Stacker 4 and Stacker Anywhere)
 08h  4 BYTEs	vendor signature
		"STAC" = Stac Electronics, Inc.
 0Ch  6 BYTEs	???
 12h	WORD	bit flags: server status/capabilities (see #2037)
 14h	DWORD	-> Stacker 3.X-compatible compression procedure
 18h	DWORD	-> Stacker 3.X-compatible decompression procedure
 1Ch  4 BYTEs	reserved (always set to 0)
 20h	DWORD	-> incremental Stacker 3.x-compatible compression procedure
		  (see #2038)
 24h  4 BYTEs	???
 28h	DWORD	-> incremental Stacker 3.x-compatible decompression procedure
		  (see #2039)
 2Ch  4	BYTES	???
 30h	DWORD	-> new (Stacker 4) compression procedure
 34h  4 BYTEs	???
 38h	DWORD	-> new (Stacker 4) decompression procedure
Notes:	Stacker 4 usally keeps two different data-compression algorithms in
	  memory (preferably in XMA):
	    1) new (Stacker 4) data compression algorithm (4K LZ77 with hashing
		  and static Huffman encoding), and
	    2) old (Stacker 3.x-compatible) one (2K LZ77 with hashing), which
		  is used to work with STACVOL files created under older
		  versions of Stacker.

Bitfields for LZSAPI capabilities:
Bit(s)	Description	(Table 2037)
 0	???
 1	busy/error flag
 2-10	???
 11	maximum compressor/decompressor presented

(Table 2038)
Call Stacker 3.x-style non-incremental functions with:
	STACK:	DWORD	return address for compress/decompress procedure
		WORD	compression algorithm parameters (see #2040)
		WORD	size of destination buffer (in bytes)
		DWORD	address of destination buffer
		WORD	size of source buffer (in bytes)
		DWORD	address of source buffer
Return: (compression/decompression procedure)
	AX = size of resulting data in destination buffer
	    0000h if error (either destination buffer too small or error in
		  compressed data)

(Table 2039)
Call Stacker 4-style incremental procedures with:
	STACK:	DWORD	return address for compr./decompr. procedure
		DWORD	address of LZSSWAP structure (see #2041)
			if 0000:0000, procedure uses non-incremental technique
		WORD	compression algorithm parameters (see #2040)
		WORD	size of destination buffer (in bytes)
		DWORD	address of destination buffer
		WORD	size of source buffer (in bytes)
		DWORD	address of source buffer

(Table 2040)
Values for Compression algorithm parameters:
Value	Compression level (/P=xx parameter)
 07F9h	  1
 0621h	  2
 0625h	  3
 0665h	  4
 0669h	  5
 06E9h	  6
 06EDh	  7
 07D1h	  8
 07D9h	  9

Format of LZSSWAP structure:
Offset	Size	Description	(Table 2041)
 00h  2 BYTEs	signature "CS"
 02h  6 BYTEs	reserved
 08h	DWORD	address of destination buffer swapping procedure
 0Ch	DWORD	address of stack swapping procedure
--------k-2F4A13-----------------------------
INT 2F U - DBLSPACE.BIN - GET ??? ENTRY POINTS
	AX = 4A13h
Return: AX = 134Ah if supported
	    ES:BX -> entry point record (see #2042)
SeeAlso: AX=4A11h/BX=0000h

Format of DBLSPACE entry point record:
Offset	Size	Description	(Table 2042)
 00h	DWORD	pointer to FAR function for ???
 04h  5 BYTEs	FAR JUMP instruction to ???
----------2F4A33-----------------------------
INT 2F - Windows95 - CHECK MS-DOS VERSION 7
	AX = 4A33h
Return: AX = 0000h for MS-DOS 7.00+
	    BX,DX,SI,DS may be destroyed
	AX nonzero if MS-DOS 6- or other DOS
SeeAlso: INT 21/AH=30h
--------N-2F4B-------------------------------
INT 2F - LAN Manager 2.0 DOS Enh NETWKSTA.EXE - NETWORK WORKSTATION REDIRECTOR
	AH = 4Bh
	???
Return: ???
Note:	LAN Manager enhanced mode adds features beyond the standard redirector
	  file/printer services
SeeAlso: AX=118Ah,AX=4100h,AH=42h
--------T-2F4B01-----------------------------
INT 2F C - DOS 5+ TASK SWITCHER - BUILD CALLOUT CHAIN
	AX = 4B01h
	CX:DX -> task switcher entry point (see #2045)
	ES:BX = 0000h:0000h
Return: ES:BX -> callback info structure (see #2043) or 0000h:0000h
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
	  point with AX=0005h (see #2045)
	the task switcher entry point should not be saved, as it is subject to
	  change and will be provided on any notification call
	the Windows 3.1 Standard Mode supports this API
SeeAlso: AX=160Bh,AX=4B02h

Format of task switcher callback info structure:
Offset	Size	Description	(Table 2043)
 00h	DWORD	pointer to next callback info structure
 04h	DWORD	pointer to notification function (see #2044)
 08h	DWORD	reserved
 0Ch	DWORD	address of zero-terminated list of API info structures
		(see #2047)

(Table 2044)
Values task switcher notification function is called with:
	AX = function
	    0000h switcher initialization
		Return: AX = status
			    0000h if OK to load
			    nonzero to abort task switcher
	    0001h query suspend
		BX = session ID
		Return: AX = status
			    0000h if OK to switch session
			    0001h if not
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
	ES:DI -> task switcher entry point (see #2045)
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
--------T-2F4B02BX0000-----------------------
INT 2F - DOS 5+ TASK SWITCHER - INSTALLATION CHECK
	AX = 4B02h
	BX = 0000h
	ES:DI = 0000h:0000h
Return: ES:DI = 0000h:0000h if task switcher not loaded
	ES:DI -> task switcher entry point (see #2045) if loaded
	    AX = 0000h
Notes:	the returned entry point is that for the most-recently loaded task
	  switcher; the entry points for prior task switchers may be determined
	  with the "get version" call (see #2045)
	this function is supported by PC Tools v8+ CPTASK
SeeAlso: AX=4A05h,AX=4B03h

(Table 2045)
Call task switcher entry point with:
	AX = 0000h get version
		Return: CF clear if successful
			    AX = 0000h
			    ES:BX -> task switcher version struct (see #2046)
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
			  (see #2043)
		Return: CF clear if successful
			    AX = 0000h
			CF set if unsupported function
	AX = 0005h unhook notification chain
		ES:DI -> callback info structure to be removed from chain
			  (see #2043)
		Return: CF clear if successful
			    AX = 0000h
			CF set if unsupported function
	AX = 0006h query API support
		BX = asynchronous API identifier
		Return: CF clear if successful
			    AX = 0000h
			    ES:BX -> API info structure (see #2047) for the
				      client which provides the highest
				      level of API support
			CF set if unsupported function

Format of task switcher version structure:
Offset	Size	Description	(Table 2046)
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
Offset	Size	Description	(Table 2047)
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
--------T-2F4B03-----------------------------
INT 2F - DOS 5+ TASK SWITCHER - ALLOCATE SWITCHER ID
	AX = 4B03h
	ES:DI -> task switcher entry point (see #2045)
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
	this function is supported by PC Tools v8+ CPTASK, but appears to
	  always return an ID of 0000h
SeeAlso: AX=4B02h,AX=4B04h
--------T-2F4B04-----------------------------
INT 2F - DOS 5+ TASK SWITCHER - FREE SWITCHER ID
	AX = 4B04h
	BX = switcher ID
	ES:DI -> task switcher entry point (see #2045)
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
	this call is supported by PC Tools v8+ CPTASK, but appears to return
	  sucessfully no matter which ID is given
SeeAlso: AX=4B02h,AX=4B03h
--------T-2F4B05-----------------------------
INT 2F C - DOS 5+ TASK SWITCHER - IDENTIFY INSTANCE DATA
	AX = 4B05h
	ES:BX = 0000h:0000h
	CX:DX -> task switcher entry point (see #2045)
Return: ES:BX -> startup info structure (see #2048) or 0000h:0000h
Notes:	called by task switcher
	clients with instance data should hook this call, pass it through to
	  the previous handler with unchanged registers using a simulated
	  interrupt.  On return, the client should create a startup info
	  structure (see #2048), store the returned ES:BX in the "next"
	  field, and return the address of the created structure in ES:BX
	all MS-DOS function calls are available from within this call
SeeAlso: AX=1605h,AX=160Bh,AX=4B02h

Format of task switcher startup info structure:
Offset	Size	Description	(Table 2048)
 00h  2 BYTEs	major, minor version of info structure (03h,00h)
 02h	DWORD	pointer to next startup info structure or 0000h:0000h
 06h	DWORD	0000h:0000h (ignored)
 0Ah	DWORD	ignored
 0Eh	DWORD	pointer to instance data records (see #2049)

Format of one instance data record in array:
Offset	Size	Description	(Table 2049)
 00h	DWORD	address of instance data (end of array if 0000h:0000h)
 04h	WORD	size of instance data
--------W-2F4B06-----------------------------
INT 2F - MS Windows - WIN.COM - GET ??? POINTER TO WIN.COM
	AX = 4B06h
Return:	AX = 0000h
	ES:BX -> ??? function in WIN.COM
Note:	the entry point is called with
	    AX = 0001h or 0003h
	    BX = ???
SeeAlso: AX=4B80h
--------W-2F4B20-----------------------------
INT 2F - MS Windows 3 - WIN.COM - SET PROGRAM TO EXECUTE ON EXIT
	AX = 4B20h
Return: AX = 0000h if successful
	    DX:CX -> 256-byte buffer for pathname and commandline (see #2050)
Note:	when the Windows function ExitWindows is called with an exit code of
	  44h, WIN.COM executes the program specified in the returned buffer
	  and then restarts Windows

Format of WIN.COM buffer:
Offset	Size	Description	(Table 2050)
 00h 128 BYTEs	ASCIZ pathname of program to execute
 80h 128 BYTEs	commandline for program
--------W-2F4B80-----------------------------
INT 2F - MS Windows - WSWAP.EXE - RESET INTERNAL VARIABLES
	AX = 4B80h
Return: nothing
Note:	called by WINOLDAP.MOD
SeeAlso: AX=4B06h
--------p-2F4C-------------------------------
INT 2F U - Advanced Power Management
	AH = 4Ch
	AL = function
	    00h version check
	    01h suspend system requested
	    FFh suspend/resume battery notification
	???
Return: ???
----------2F4D-------------------------------
INT 2F U - ???
	AH = 4Dh
	???
Return: ???
Note:	reportedly called by Kana Kanji Converter and MSKK
--------N-2F4E53BL00-------------------------
INT 2F - SilverNET v2+ - INSTALLATION CHECK
	AX = 4E53h ("NS")
	BL = 00h (function "installation check")
	BH = module ID (see #2051)
Return: AX = 0000h if specified module installed
	BX = 4E53h if installed
Program: SilverNET is an SMB-compatible peer-to-peer NOS for DOS or
	  Windows systems, by Net-Source, Inc. of Santa Clara, CA.
SeeAlso: AX=4E53h/BL=01h,AX=4E53h/BL=02h,AX=B800h,AX=B809h

(Table 2051)
Values for SilverNET module ID:
 01h	SilverCACHE
 02h	Workstation
 03h	NetBIOS
 04h	Peer
 20h	NS Share
 80h	NetWare help TSR
--------N-2F4E53BL01-------------------------
INT 2F - SilverNET - GET RUNTIME PARAMETER
	AX = 4E53h ("NS")
	BL = 01h (function "get runtime parameter")
	BH = module ID (see #2051)
	CX = parameter index (see #2052,#2054,#2055)
Return: AX = WORD value at specified index (see #2053)
Desc:	retrieve a word of data from the specified SilverNET module

(Table 2052)
Values for SilverNET Peer parameter index (* = read-only):
 00h *	maximum outstanding SMB buffers
 02h *	maximum logged-in nodes
 04h *	number of shareable resources
 06h *	number of characters to print per time slice
 08h *	number of printers that can be shared
 0Ah *	number of nodes logged in
 0Ch *	number of files to allow opened
 0Eh	how fast to despool (/PSLICE)
 10h	audit flag
 24h *	far pointer to resource table (each resource is 96 bytes in length)
 32h *	far pointer to SFT (internal if SilverNET files > CONFIG.SYS files,
	else DOS SFT)
 36h	spool flags (see #2053)

Bitfields for spool flags:
Bit(s)	Description	(Table 2053)
 0	LPT1 needs despooling
 1	LPT2 needs despooling
 2	LPT2 needs despooling
 4	COM1 needs despooling
 5	COM2 needs despooling
 6	COM3 needs despooling

(Table 2054)
Values for NS Share parameter index (* = read-only):
 00h	version number (high byte = minor, low byte = major)
 10h *	segment of first lock record (other records in consecutive paragraphs)
	(if PSP field = 0000h, lock record is free)
 12h *	maximum possible number of lock records
 14h *	starting segment of sharing buffer
	(NS Share's sharing records are identical to DOS SHARE except that
	  fields which are normally offsets into SHARE are segment numbers)
 18h *	size of sharing buffer in paragraphs
 1Ah *	total free paragraphs in sharing buffer
 1Ch *	current number of shared files
 1Eh *	current number of locked records

(Table 2055)
Values for Workstation parameter index (* = read-only):
 00h	version number (high byte = minor, low byte = major)
 02h *	size of each network buffer for file operations
 04h *	number of redirector file buffers
 06h *	size of each print cache buffer
 08h *	number of network LPT printers
 0Ch	flush time in ticks (idle time on network printer before flushing)
 0Eh	(16 WORDs) last active time for each printer
 2Eh *	stub segment if program split into two parts
 60h	receive name number for datagram listens
 62h *	18-byte machine name
 74h *	LASTDRIVE (01h = A:, etc.)
 7Ch	row number of message box on screen
 7Eh	message time in clock ticks
 82h *	number of network adapters in use
 84h	station ID broadcast flag (never set on redirectors)
 96h *	NetBIOS names left
 98h *	NCBs left
 9Ah *	sessions left
 A2h *	total number of network printers (LPT+COM)
 A4h *	number of serial network printers
 A8h *	segment containing file cache buffers
 AAh *	segment containing print cache buffers
 ACh *	bytes remaining free in HMA before program loaded
 AEh *	start of free memory in HMA
 B2h *	flag: using HMA
--------N-2F4E53BL02-------------------------
INT 2F - SilverNET - SET RUNTIME PARAMETERS
	AX = 4E53h ("NS")
	BL = 02h (function "set runtime parameters")
	BH = module ID (see #2051)
	CX = parameter index (see #2054,#2055)
	DX = new value for specified parameter
Desc:	set a WORD value in the specified SilverNET module
Note:	not all indexed parameters are writable; modifying a read-only
	  parameter can result in system crashes
SeeAlso: AX=4E53h/BL=00h,AX=4E53h/BL=01h
--------N-2F5100-----------------------------
INT 2F U - ODIHLP.EXE - INSTALLATION CHECK
	AX = 5100h
Return: AL = FFh if installed
	    BX = 0000h
	    DX:SI -> signature string "ODI$HLP$"
Program: ODIHLP is a real-mode helper allowing the Windows for Workgroups 3.11
	  protected-mode NDIS3 protocol to work with real-mode ODI drivers
	  and LSL.COM
Note:	the returned signature string might be the first field of a structure
SeeAlso: AX=C000h"LSL.COM"
--------k-2F5200-----------------------------
INT 2F - JAM.SYS v1.10+ - "GetVersion" - INSTALLATION CHECK
	AX = 5200h
Return: AH = 80h (successful) if installed
	BX = internal JAM.SYS version number
	CX = size of JAMINFO structure (see #2056,#2057)
	DX = JAM.SYS segment address
Program: JAM.SYS is a main component of the JAM Real-Time Data Compression
	  Utilities by George A. Reznik and friends (JAM Software).
SeeAlso: AX=5201h

Format of JAMINFO v1.10 structure:
Offset	Size	Description	(Table 2056)
 00h 25 BYTEs	extended BIOS parameter block (BPB)
 19h 11 BYTEs	???
 25h	DWORD	total number of sectors in JAM archive file
		(size of compressed data area)
 29h	BYTE	flags (see #2058)
 2Ah 127 BYTEs	full JAM archive file name
 A9h	WORD	the number of fragments in archive file
 ABh 96 BYTEs	archive file fragmentation list -
		array of 16 FRAGMENT structures (see #2059)
10Bh	DWORD	address of the host-drive DPB (Drive Parameter Block)
10Fh	DWORD	number of free sectors in JAM archive file
113h	WORD	device status word (see #2060)
SeeAlso: #2057

Format of JAMINFO v1.20 structure:
Offset	Size	Description	(Table 2057)
 00h 25 BYTEs	extended BIOS parameter block (BPB)
 19h	BYTE	physical driver number
 1Ah	BYTE	reserved
 1Bh	BYTE	extended boot record signature
 1Ch	DWORD	volume serial number
 20h 11 BYTEs	volume label
 2Bh  8 BYTEs	file system ID
 33h	DWORD	total number of sectors in JAM archive file
		(size of compressed data area)
 37h	BYTE	flags (see #2058)
 38h 128 BYTEs	full JAM archive file name
 B8h	WORD	the number of fragments in archive file
 BAh 96 BYTEs	archive file fragmentation list -
		array of 16 FRAGMENT structures (see #2059)
11Ah	DWORD	address of the host-drive DPB (Drive Parameter Block)
11Eh	DWORD	number of free sectors in JAM archive file
122h	WORD	device status word (see #2060)
Note:	the first 33h bytes are copied from the archive file's boot sector
SeeAlso: #2056

Bitfields for JAMINFO flags:
Bit(s)	Description	(Table 2058)
 2-0	reserved
 3	(v1.20+)
 4	enable direct write requests (Int 26h, non-DOS requests, etc.)
 5	read-only mode
 6	no write-behind caching
 7	full undelete-compatible allocation strategy
SeeAlso: #2056,#2057

Format of JAM FRAGMENT structure:
Offset	Size	Description	(Table 2059)
 00h	WORD	starting sector (low word)
 02h	BYTE	starting sector (high byte)
 03h	WORD	size of fragment (low word)
 05h	BYTE	size of fragment (high byte)
SeeAlso: #2056,#2057

(Table 2060)
Values for JAM.SYS status (high byte):
 00h	successful
 01h	drive is not a JAM drive
 02h	drive is already attached
 03h	archive file cluster size value is larger than driver's one
 04h	drive is not attached
 05h	drive is locked
 06h	drive is not locked
 07h	bad physical-level request
 08h	host drive reading/writing error
 09h	bad entries in JAM descriptor table
 0Ah	compressed data integrity error
 0Bh	archive file overflow
 0Ch	bad DOS request
 0Dh	incorrect parameters in JAMINFO structure
Note:	the low byte of the status is the DOS error code for the Host drive
SeeAlso: #1885 at INT 2F/AX=0802h
--------k-2F5201-----------------------------
INT 2F - JAM.SYS v1.10+ - "GetInfo" - GET COMPRESSED DRIVE INFORMATION
	AX = 5201h
	DL = compressed drive number (0-default, 1-A:, etc.)
	DS:BX -> buffer for JAMINFO structure (see #2056,#2057)
Return: AH = status (00h,01h) (see #2060)
SeeAlso: AX=5200h
--------k-2F5202-----------------------------
INT 2F - JAM.SYS v1.10+ - "Attach" - MOUNT COMPRESSED DRIVE
	AX = 5202h
	DL = drive number (0-default, 1-A:, etc.) to attach to the JAM
	      archive file
	DS:BX -> pointer to JAMINFO structure (see #2056,#2057), which
	      contains parameters of the JAM file to mount, and pointer
	      to the host drive DPB (i.e. DPB of the drive on which the
	      JAM file is located)
Return: AH = status (00h,02h,03h,08h,09h,0Dh) (see also #2060)
	    03h archive file cluster size value is larger than driver's - not
		  mounted
	    09h bad entries in JAM descriptor table - file mounted read-only
	AL = host drive error code (see #1885 at INT 2F/AX=0802h)
SeeAlso: AX=5203h
--------k-2F5203-----------------------------
INT 2F - JAM.SYS v1.10+ - "Detach" - UNMOUNT COMPRESSED DRIVE
	AX = 5203h
	DL = drive number (0-default, 1-A:, etc.) to detach
Return: AH = status (00h,01h,04h,05h,08h,09h,0Bh,0Dh) (see #2060)
	AL = host drive error code (see #1885 at INT 2F/AX=0802h)
SeeAlso: AX=5202h
--------k-2F5204-----------------------------
INT 2F - JAM.SYS v1.10+ - "Lock" - LOCK COMPRESSED DRIVE
	AX = 5204h
	DL = drive number (0-default, 1-A:, etc.) to lock
Return: AH = status (00h,01h,04h,05h,08h,09h,0Bh,0Dh) (see #2060)
	AL = host drive error code (see #1885 at INT 2F/AX=0802h)
SeeAlso: AX=5205h, AX=5206h, AX=5207h
--------k-2F5205-----------------------------
INT 2F - JAM.SYS v1.10+ - "UnLock" - UNLOCK COMPRESSED DRIVE
	AX = 5205h
	DL = drive number (0-default, 1-A:, etc.) to unlock
Return: AH = status (00h,01h,04h,06h,08h,09h,0Dh) (see #2060)
	AL = host drive error code (see #1885 at INT 2F/AX=0802h)
SeeAlso: AX=5204h, AX=5206h, AX=5207h
Note:	Lock and UnLock functions were added to the JAM API to prevent
	  asynchronous physical-level access (see AX=5206h,AX=5207h) to
	  compressed data on JAM drives. In other words, two or more programs
	  which use JAM API (say, JMAX optimizer and JCHKDSK - disk checker)
	  cannot be run on the same JAM drive simultaneously.
--------k-2F5206-----------------------------
INT 2F - JAM.SYS v1.10+ - "Read" - PHYSICAL READ DATA FROM JAM ARCHIVE
	AX = 5206h
	DL = drive number (0-default, 1-A:, etc.)
	DS:BX -> disk transfer packet (see #2061)
Return: AH = status (00h,01h,04h,06h,07h,08h,0Dh) (see #2060)
	AL = host drive error code (see #1885 at INT 2F/AX=0802h)
Program: JAM.SYS is a main component of the JAM Real-Time Data Compression
	  Utilities by George A. Reznik and friends (JAM Software).
SeeAlso: AX=5207h

Format of disk transfer packet:
Offset	Size	Description	(Table 2061)
 00h	DWORD	sector number
 04h	WORD	number of sectors to read(write)
 06h	DWORD	transfer address
--------k-2F5207-----------------------------
INT 2F - JAM.SYS v1.10+ - "Write" - PHYSICAL WRITE DATA TO JAM ARCHIVE
	AX = 5207h
	DL = drive number (0-default, 1-A:, etc.)
	DS:BX -> disk transfer packet (see #2061)
Return: AH = status (00h,01h,04h,06h,07h,08h,0Dh) (see #2060)
	AL = host drive error code (see #1885 at INT 2F/AX=0802h)
SeeAlso: AX=5206h
--------p-2F53-------------------------------
INT 2F U - POWER.EXE - APM event broadcasting???
	AH = 53h
	AL = event???
	    05h CPU idle
	    0Bh PM event broadcast API
Return: ???
Note:	called by MS Windows 3.1 POWER.DRV; hooked by MS Mouse driver v8.20+
	  and PC-Cache v8.0
SeeAlso: AX=530Bh,AH=54h,INT 33/AX=002Fh
--------p-2F530B-----------------------------
INT 2F U - ??? (MOUSEPWR.COM, others) - ???
	AX = 530Bh
	BX = subfunction
	    0003h ???
	    0004h ???
	???
Return: ???
Note:	it appears that subfunction 0003h reads or restores the current mouse
	  settings (the MS Mouse driver hooks AX=530Bh), and 0004h might be
	  the converse
--------p-2F5400-----------------------------
INT 2F U - POWER.EXE - INSTALLATION CHECK
	AX = 5400h
Return: AX = POWER.EXE version (AH = major, AL = minor) if installed
	BX = 504Dh ("PM")
	CF clear
Note:	called by MS Windows 3.1 POWER.DRV
SeeAlso: AH=53h,AX=5401h,AX=5402h,AX=5481h,AX=5482h
--------p-2F5401-----------------------------
INT 2F U - POWER.EXE - GET/SET POWER STATUS
	AX = 5401h
	BH = function
	    00h get status
		Return: BL = current power management status (see #2062)
	    01h set status
		BL = new power managment status (see #2062)
Return: AX = function status (see #2063)
Note:	called by MS Windows 3.1 POWER.DRV
SeeAlso: AH=53h,AX=5400h,AX=5402h,AX=5403h

Bitfields for power management status:
Bit(s)	Description	(Table 2062)
 0	POWER.EXE power management enabled
 1	APM firmware power management enabled
 2-7	reserved (0)
Notes:	bit 1 is ignored if there is no APM firmware
	bits 1-0: 00 = POWER OFF, 10 = POWER STD, 11 = POWER ADV

(Table 2063)
Values for POWER.EXE function status:
 0000h	successful
 0002h	"ERROR_PM_ALREADY_CONNECTED"
 0003h	"ERROR_PM_NOT_CONNECTED"
 0087h	"ERROR_PM_INVALID_PARAMETER"
--------p-2F5402-----------------------------
INT 2F U - POWER.EXE - GET/SET IDLE DETECTION STRATEGY
	AX = 5402h
	BH = subfunction
	    00h get
	    other set
		BL = detection strategy (00h-0Fh or FFh)
Return: BX = current/new detection strategy
SeeAlso: AH=53h,AX=5400h,AX=5401h,AX=5481h,AX=5482h
--------p-2F5403-----------------------------
INT 2F U - POWER.EXE - GET/SET ADVANCED POWER MANAGEMENT SETTING
	AX = 5403h
	BX = new power management setting or 0000h to get current setting
Return: AX = status
	    0000h successful
		BX = power management setting (see #2064)
	    other error code
SeeAlso: AX=5401h,AX=5480h

(Table 2064)
Values for power management setting:
 0001h-0005h "min"
 0006h	     "reg"
 0007h-0008h "max"
--------t-2F5453-----------------------------
INT 2F - TesSeRact RAM-RESIDENT PROGRAM INTERFACE
	AX = 5453h
	BX = subfunction
	    00h installation check
		CX = 0000h
		DS:SI -> 8-char blank-padded name (see #2065)
		Return: AX = FFFFh installed
				CX = ID number of already-installed copy
			AX = anything else, not installed
				CX = ID number for TSR when installed
	    01h get user parameters
		CX = TSR ID number
		Return: AX = status
			    0000h successful
				ES:BX -> user parameter block (see #2066)
			    nonzero failed
	    02h check if hotkey in use
		CL = scan code of hot key (see #0005)
		Return: AX = FFFFh hot key conflicts with another TSR
			     otherwise safe to use the hotkey
	    03h replace default critical error handler
		CX = TSR ID number
		DS:SI -> new routine for INT 24h
		Return: AX = nonzero, unable to install new handler
	    04h get internal data area
		CX = TSR ID number
		Return: AX = status
			    0000h successful
				ES:BX -> TSR's internal data area (see #2067)
			    nonzero, TSR not found
	    05h set multiple hot keys
		CX = TSR ID number
		DL = number of additional hot keys to allocate
		DS:SI -> table of hot keys
			BYTE  hotkey scan code (see #0005)
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
SeeAlso: AX=CAFEh,INT 16/AX=55FFh,INT 2D"AMIS"
Index:	installation check;TesSeRact TSR interface|uninstall;TesSeRact

(Table 2065)
Values for TesSeRact names:
 "AVATAR  "	AVATAR.SYS
 "QeditTSR"	TSR version of SemWare's Qedit editor
 "SCRNBLNK"	Trusted Access screen blanker

Format of TesSeRact User Parameter Block:
Offset	Size	Description	(Table 2066)
 00h  8 BYTEs	blank-padded TSR name
 08h	WORD	TSR ID number
 0Ah	DWORD	bitmap of supported functions
 0Eh	BYTE	scan code of primary hotkey (see #0005)
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
Index:	hotkeys;TesSeRact TSR interface

Format of TSR internal data area:
Offset	Size	Description	(Table 2067)
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
 28h  3 WORDs	DOS 3.0+ extended error info
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
--------p-2F5480-----------------------------
INT 2F U - POWER.EXE - GET/SET ???
	AX = 5480h
	BX = direction
	    0000h get
	    other set
	CX = size of buffer (at least 0010h)
	DS:SI -> buffer
Return: AX = status
	    0000h successful
	    other error code
SeeAlso: AX=5400h,AX=5481h,AX=548Fh
--------p-2F5481-----------------------------
INT 2F U - POWER.EXE - GET STATISTICS
	AX = 5481h
	BX = which statistics
	    0000h idle detection
	    0001h APM statistics
	CX = length of buffer in bytes
	DS:SI -> buffer for statistics (see #2068,#2069)
Return: AX = status
	    0000h successful
	    0071h "ERROR_PM_BUFFER_TOO_SMALL"
	    0087h "ERROR_PM_INVALID_PARAMETER"
SeeAlso: AH=53h,AX=5400h,AX=5480h,AX=5402h,AX=5482h

Format of POWER.EXE idle detection statistics:
Offset	Size	Description	(Table 2068)
 00h	DWORD	"CPU_ON_TIME" total time CPU is active with POWER.EXE idle
		  detection enabled, in timer ticks
 04h	DWORD	"CPU_IDLE_TIME" timer ticks during which CPU was idle
		(divide by previous to get idle	rate)
 08h	DWORD	total idle calls
 0Ch	DWORD	"TOTAL_APP_IDLE" total INT 2Fh idle calls
 10h	DWORD	"TOTAL_DOS_YIELD" total INT 28h idle calls
 14h	DWORD	"TOTAL_KEY_IDLE" total INT 16h idle calls
 18h	DWORD	"TOTAL_DOS_IDLE" total INT 2Ah idle calls

Format of APM statistics:
Offset	Size	Description	(Table 2069)
 00h	DWORD	"RESUME_COUNT" total number of resumes since last APM_ENABLE
--------p-2F5482-----------------------------
INT 2F U - POWER.EXE - GET/SET APM POLLING FREQUENCY
	AX = 5482h
	BX = new polling frequency or 0000h to get current frequency
Return: AX = 0000h (successful)
	BX = current frequency if BX=0000h on entry
SeeAlso: AH=53h,AX=5400h,AX=5401h,AX=5480h,AX=5481h,AX=548Fh
--------p-2F548F-----------------------------
INT 2F U - POWER.EXE - GET/SET ???
	AX = 548Fh
	BX = ??? or 0000h to get current ???
Return: AX = 0000h (successful)
	BX = current ???
	CX = ???
SeeAlso: AX=5400h,AX=5480h,AX=5482h
--------l-2F5500-----------------------------
INT 2F U - DOS 5+ - COMMAND.COM INTERFACE
	AX = 5500h
Return: AX = 0000h if an instance of COMMAND.COM is already running
	DS:SI -> entry point table
Notes:	used to access the shareable portion of COMMAND.COM, which may have
	  been moved into the HMA; only the primary COMMAND.COM retains this
	  portion
	procedures called from a dispatcher in COMMAND's resident portion;
	  most assume that the segment address of the resident portion is on
	  the stack and are thus not of general use
SeeAlso: AX=5501h
--------l-2F5501-----------------------------
INT 2F U - DOS 5+ - ROM COMMAND.COM INTERFACE
	AX = 5501h
Return: ???
Note:	used to determine whether the caller is the first instance of ROM
	  COMMAND.COM
SeeAlso: AX=5500h
--------R-2F5600-----------------------------
INT 2F - INTERLNK - INSTALLATION CHECK
	AX = 5600h
	DX = magic value FFFFh
	BL = instance number (00h = any, 01h = first loaded, etc.)
Return: AL = FFh if installed
	    BL = instance number
	    CX = ??? (apparently always 0001h)
	    DX = resident CS of driver, DX:0000h -> header (see #2070)
SeeAlso: AX=5601h,AX=5602h,INT 60/AX=0000h

Format of Interlnk device driver header:
Offset	Size	Description	(Table 2070)
 00h	DWORD	pointer to next driver, offset=FFFFh if last driver
 04h	WORD	device attributes (see #0954,#0955)
 06h	WORD	device strategy entry point
 08h	WORD	device interrupt entry point
 0Ah  8 BYTEs	character device name "NUL2    "
 12h 165 BYTEs	???
 B7h 67 BYTEs	fully qualified Interlnk filename
 FAh  6 BYTEs	???
100h	DWORD	pointer back to Interlnk filename at offset B7h
104h  8 BYTEs	???
10Ch	BYTE	total number of redirected drives
10Dh	BYTE	first local drive number (0=A:)
10Eh	BYTE	printer redirection (0=no, 1=yes)
10Fh	BYTE	???
110h  3	BYTEs	LPT1...3 status (0FFh=invalid)
113h 26 BYTEs	remote drive number (0=A:, 0FEh=unused) (see note below)
12Dh 26 BYTEs	always 0FEh ???
147h 26 BYTEs	always 0FFh ???
Note:	to obtain the remote drive number, subtract the value at offset 10Ch
	  from the local drive number before indexing into the table at 113h
	  (example: if local drives F, G, H are remote drives C, F, E then
	  the first three bytes at offset 113h are 02h, 05h, 04h)
	for each instance of Interlnk, an extra device driver is loaded, but
	  all have the same device name NUL2
SeeAlso: #0953 at INT 21/AH=52h
--------R-2F5601-----------------------------
INT 2F - INTERLNK - CHECK IF REDIRECTED DRIVE
	AX = 5601h
	DX = magic value FFFFh
	BH = drive number (0=A:)
	BL = 00h
Return: (as for AL=00h if redirected drive)
SeeAlso: AX=5600h
--------R-2F5602-----------------------------
INT 2F - INTERLNK - GET ???
	AX = 5602h
	DX = magic value FFFFh
Return: CX = ???
SeeAlso: AX=5600h
----------2F57-------------------------------
INT 2F U - ???
	AH = 57h
	???
Return: ???
Note:	reportedly used by Iomega Corp.
--------c-2F5758BX4858-----------------------
INT 2F U - Helix Multimedia Cloaking - CACHECLK - INSTALLATION CHECK
	AX = 5758h
	BX = 4858h ('HX')
	DX = 4443h ('DC')
	CX <> 5758h
Return: BX = 6878h if installed
	DX = 6463h if installed
	   CX = version (CH=major,CL=minor)
Program: CACHECLK is a 'Cloaked' disk cache by Helix Software
Note:	returns with registers unchanged if CX=5758h on entry
SeeAlso: INT 16/AX=5758h/BX=4858h,INT 2F/AX=4310h"Cloaking"
--------X-2F5D00-----------------------------
INT 2F U - PCMCIA - AWARD PCDISK - GET INFO FROM DRIVER ???
	AX = 5D00h
Return: ES:BX -> ???
Note:	supported by Ventura Micro / Award PCDISK.EXE v1.02c PCMCIA/ATA driver
SeeAlso: AX=5D01h,INT 21/AX=440Dh
--------X-2F5D01-----------------------------
INT 2F U - PCMCIA - AWARD PCDISK - PUT INFO INTO DRIVER ???
	AX = 5D01h
	ES:BX -> ???
Return: nothing
Note:	supported by Ventura Micro / Award PCDISK.EXE v1.02c PCMCIA/ATA driver
SeeAlso: AX=5D00h,INT 21/AX=440Dh
--------s-2F60FFDL00-------------------------
INT 2F U - IPLAY v1.00b - INSTALLATION CHECK
	AX = 60FFh
	DL = 00h (function number)
	BX = 5344h ('SD')
	CX = 4D50h ('MP')
Return: AX = 4F4Bh ('OK') if installed
Program: IPLAY is the Inertia Player by Prime and Excalibur for .MODules
	  (digitized music files)
Note:	in version 1.00b, any value for DL except 01h invokes this function
SeeAlso: AX=60FFh/DL=01h
--------s-2F60FFDL01-------------------------
INT 2F U - IPLAY v1.00b - GET DATA SEGMENT
	AX = 60FFh
	DL = 01h (function number)
	BX = 5344h ('SD')
	CX = 4D50h ('MP')
Return: AX = data segment
Program: IPLAY is the Inertia Player by Prime and Excalibur for .MODules
	  (digitized music files)
SeeAlso: AX=60FFh/DL=00h
--------v-2F6282-----------------------------
INT 2F U - PC Tools v7.0+ VDEFEND, VSAFE, VWATCH, DATAMON - SET ??? ADDRESS
	AX = 6282h
	CX:DX -> ??? or 0000h:0000h
	DI = segment of ??? record (see #2071) or 0000h/FFFFh to ignore
Return: BX = 0062h
Note:	if CX:DX = 0000h:0000h on entry, the ??? address is not changed
	  (DATAMON only)
SeeAlso: INT 13/AH=FAh"VSAFE",INT 21/AH=FAh"VDEFEND"

Format of VSAFE/VWATCH record:
Offset	Size	Description	(Table 2071)
 00h	DWORD	???
 04h	WORD	offset of ??? in record's segment
		VSAFE 2.0 sets byte at +01h to 56h or 58h
		VWATCH 2.1 sets byte at +02h to 56h or 58h
 06h  2 BYTEs	???
 08h	BYTE	??? (01h/other)
--------v-2F6284BX0000-----------------------
INT 2F U - PC Tools v7-8 DATAMON, v9+ DPROTECT	- INSTALLATION CHECK
	AX = 6284h
	BX = 0000h
	CX = 0000h
Return: AX = segment of resident code
	BX = 5555h
	CX = 5555h
Note:	also supported by DOS 6 UNDELETE which is licensed from PC Tools
SeeAlso: AX=6284h/BX=0001h,INT 16/AX=FFA3h
--------v-2F6284BX0001-----------------------
INT 2F U - PC Tools v7-8 DATAMON, v9+ DPROTECT - GET ???
	AX = 6284h
	BX = 0001h
	CX = 0001h
Return: AX:BX -> ??? data (see #2072)
	CX = BX
SeeAlso: AX=6284h/BX=0000h

Format of DPROTECT data for v9.0:
Offset	Size	Description	(Table 2072)
 00h  5 BYTEs	???
 05h	WORD	resident code segment (may be segment of DWORD at +03h)
 07h	DWORD	-> FAR function to sound alert tone
	???
--------v-2F6284BX0002-----------------------
INT 2F U - PC Tools v7-8 DATAMON, v9+ DPROTECT - GET OPTIONS
	AX = 6284h
	BX = 0002h
	CX = 0002h
Return: AX = options (see #2073)
	BX = ??? (0000h for v9)
	CX = AX
	DX = BX
Note:	also supported by DOS 6 UNDELETE which is licensed from PC Tools
SeeAlso: AX=6284h/BX=0000h,AX=6284h/BX=0003h

Bitfields for DATAMON/DPROTECT options:
Bit(s)	Description	(Table 2073)
 1	???
 12	disabled
 13	using Delete Sentry
 14	using Delete Tracker
--------v-2F6284BX0003-----------------------
INT 2F U - PC Tools v7-8 DATAMON, v9+ DPROTECT - SET OPTION??? FLAGS
	AX = 6284h
	BX = 0003h
	CX = flags (see #2074)
	DX = flags
	    bit 15: ???
Note:	v9 DPROTECT only checks bit 12 of CX, and ignores DX entirely
SeeAlso: AX=6284h/BX=0002h

Bitfields for DATAMON/DPROTECT CX flags:
Bit(s)	Description	(Table 2074)
 3	???
 5	???
 10	???
 12	disable DATAMON/DPROTECT
--------v-2F6284BX0004-----------------------
INT 2F U - PC Tools v8 DATAMON, v9+ DPROTECT - ???
	AX = 6284h
	BX = 0004h
	CX = 0004h
Return: AX = 5555h
	BX = ??? (0800h)
	CX = ??? (FCCCh for v8, FCCBh for v9)
--------V-2F6400-----------------------------
INT 2F - SCRNSAV2.COM - INSTALLATION CHECK
	AX = 6400h
Return: AL = installation state
	    00h not installed
	    FFh installed
Program: SCRNSAV2.COM is a screen saver for PS/2s with VGA by Alan Ballard
SeeAlso: INT 10/AX=5555h,INT 14/AX=AA01h
Index:	screen saver;SCRNSAV2
--------N-2F7000-----------------------------
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
--------N-2F7001-----------------------------
INT 2F - License Service API - REQUEST LICENSE
	AX = 7001h
	CX = license server index (0000h to 001Fh)
	DS:DX -> SLSREQUEST structure (see #2075)
Return: AX = status
	    0000h success
	    else  provider error code
	ES:BX = provider specific handle for the license context
SeeAlso: AX=7002h,AX=7004h,AX=7005h

Format of License Service SLSREQUEST structure:
Offset	Size	Description	(Table 2075)
 00h	DWORD	(ret) status code
 04h	DWORD	(ret) handle identifying context
 08h	DWORD	(call) address of Publisher string
 0Ch	DWORD	(call) address of Product string
 10h	DWORD	(call) address of Version string
 14h	DWORD	units required
 18h	DWORD	address of comment string
 1Ch	DWORD	address of SLSCHALLENGE structure (see #2076)

Format of License Service SLSCHALLENGE structure:
Offset	Size	Description	(Table 2076)
 00h	DWORD	algorithm (currently always 1)
 04h	DWORD	secret to be challenged (1-255)
 08h	DWORD	size of challenge in bytes (1-255)
 0Ch  N BYTEs	challenge data
--------N-2F7002-----------------------------
INT 2F - License Service API - RELEASE LICENSE
	AX = 7002h
	CX = license server index (0000h to 001Fh)
	DS:DX -> SLSRELEASE structure (see #2077)
	ES:BX = provider specific handle for the license context
Return: AL = status
	    00h not installed
	    FFh installed
SeeAlso: AX=7001h,AX=7005h

Format of License Service SLSRELEASE structure:
Offset	Size	Description	(Table 2077)
 00h	DWORD	handle indentifying license context
 04h	DWORD	total units consumed
 08h	DWORD	address of comment string
--------N-2F7003-----------------------------
INT 2F - License Service API - UPDATE
	AX = 7003h
	CX = license server index (0000h to 001Fh)
	DS:DX -> SLSUPDATE structure (see #2078)
	ES:BX = provider specific handle for the license context
Return: AL = status
	    00h not installed
	    FFh installed
SeeAlso: AX=7004h,AX=7005h

Format of License Service SLSUPDATE structure:
Offset	Size	Description	(Table 2078)
 00h	DWORD	(ret) status code
 04h	DWORD	(call) handle identifying license context
 08h	DWORD	(call) total units consumed
 0Ch	DWORD	additional units required
 10h	DWORD	address of comment string
 14h	DWORD	address of SLSCHALLENGE structure (see #2076)
--------N-2F7004-----------------------------
INT 2F - License Service API - GET ERROR
	AX = 7004h
	CX = license server index (0000h to 001Fh)
	DS:DX -> SLSGETERROR structure (see #2079)
	ES:BX = provider specific handle for the license context
Return: AL = status
	    00h not installed
	    FFh installed
SeeAlso: AX=7000h,AX=7001h

Format of License Service SLSGETERROR structure:
Offset	Size	Description	(Table 2079)
 00h	DWORD	(ret) status code
 04h	DWORD	handle identifying license context
 08h	DWORD	error code
 0Ch	DWORD	buffer size in bytes
 10h  N BYTEs	data buffer
--------N-2F7005-----------------------------
INT 2F - License Service API - QUERY LICENSE
	AX = 7005h
	CX = license server index (0000h to 001Fh)
	DS:DX -> SLSQUERY structure (see #2080)
	ES:BX = provider specific handle for the license context
Return: AL = status
	    00h not installed
	    FFh installed
SeeAlso: AX=7001h,AX=7002h

Format of License Service SLSQUERY structure:
Offset	Size	Description	(Table 2080)
 00h	DWORD	(ret) status code
 04h	DWORD	handle identifying license context
 08h	DWORD	information index
 0Ch	DWORD	buffer size in bytes
 10h  N BYTEs	data buffer
--------K-2F7041BX4B70-----------------------
INT 2F U - HP 200LX - KEY200 - INSTALLATION CHECK
	AX = 7041h
	BX = 4B70h
Return: BX = 7965h if keyboard remapper KEY200.COM installed
--------d-2F7200-----------------------------
INT 2F - SRDISK v1.30+ - INSTALLATION CHECK
	AX = 7200h
Return: AL = FFh if installed
	    ES = segment of device driver header (see #2081)
Program: SRDISK is a freeware resizeable RAMdisk by Marko Kohtala
SeeAlso: AX=7201h

Format of SRDISK device driver header:
Offset	Size	Description	(Table 2081)
 00h 10 BYTEs	same as standard device driver header
		  (see #0953 at INT 21/AH=52h)
 0Ah	BYTE	number of subunits (drives) supported by driver
 0Bh  3 BYTEs	signature "SRD"
 0Eh  4 BYTEs	memory type string ("XMS "/"EMS ")
 12h  4 BYTEs	ASCII driver version string "N.NN"
 16h	BYTE	00h
 17h	BYTE	configuration format version (currently 00h or 01h)
 18h	WORD	offset of drive configuration data
--------d-2F7201-----------------------------
INT 2F - SRDISK v2.02 - GET CODE/DATA SEGMENT
	AX = 7201h
Return: AL = FFh if installed
	    ES = segment of device driver header
Program: SRDISK is a freeware resizeable RAMdisk by Marko Kohtala
SeeAlso: AX=7200h
--------N-2F7A00-----------------------------
INT 2F - Novell NetWare - LOW-LEVEL API (IPX) INSTALLATION CHECK
	AX = 7A00h
Return: AL = status
	    00h not installed
	    FFh installed
		ES:DI -> FAR entry point for routines accessed exclusively
			  through INT 7A in NetWare versions through 2.0a.
			  Call with same values as INT 7A
		ES:BX -> two bytes containing IPX major/minor version
			(IPXODI v2.12; BX unchanged by older IPX drivers)
SeeAlso: AX=7AFFh/BX=0000h,AX=D800h,INT 64"Novell",INT 7A"Novell"
--------N-2F7A10-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET TBMI STATUS
	AX = 7A10h
Return: DH = major TBMI version number
	DL = minor TBMI version number (01h for v1.1)
	CX = segment address of TBMI resident part
	BX = status word of TBMI (see #2082)
Note:	TBMI is the Task-Switched Buffer Manager Interface
SeeAlso: AX=7A11h,AX=7A12h,AX=7A13h,AX=7A14h

Bitfields for NetWare TBMI status word:
Bit(s)	Description	(Table 2082)
 0	INT2F intercepted by TBMI
 1	INT7A intercepted by TBMI
 2	INT64 intercepted by TBMI
 3-14	reserved or unused ???
 15	outstanding task ID was detected
--------N-2F7A11-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET INT2F HANDLERS
	AX = 7A11h
Return: ES:BX -> old INT 2F handler
	DS:DX -> TBMI INT 2F handler
SeeAlso: AX=7A10h,AX=7A12h,AX=7A13h,AX=7A1Ah
--------N-2F7A12-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET INT64 HANDLERS
	AX = 7A12h
Return: ES:BX -> old INT 64 handler
	DS:DX -> TBMI INT 64 handler
SeeAlso: AX=7A10h,AX=7A11h,AX=7A13h
--------N-2F7A13-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET INT7A HANDLERS
	AX = 7A13h
Return: ES:BX -> old INT 7A handler
	DS:DX -> TBMI INT 7A handler
SeeAlso: AX=7A10h,AX=7A11h,AX=7A12h
--------N-2F7A14-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET STATISTICS
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
Return: BX = maximum supported subfunction (000Ch)
SeeAlso: AX=7A10h
--------N-2F7A15-----------------------------
INT 2F OU - Novell NetWare - TBMI v1.1 only - RESET ???
	AX = 7A15h
Return: BX = new value of ???
Desc:	set ??? to its default value
Note:	this call is a NOP under TBMI v2.0 (TBMI2)
SeeAlso: AX=7A17h
--------N-2F7A16-----------------------------
INT 2F OU - Novell NetWare - TBMI v1.1 only - ???
	AX = 7A16h
	CX = ???
	???
Return: ???
Note:	this call is a NOP under TBMI v2.0 (TBMI2)
--------N-2F7A17-----------------------------
INT 2F OU - Novell NetWare - TBMI v1.1 only - ???
	AX = 7A17h
	???
Return: BX = old value of ???
	CX = new value of ???
Note:	this call is a NOP under TBMI v2.0 (TBMI2)
SeeAlso: AX=7A15h
--------N-2F7A18-----------------------------
INT 2F U - Novell NetWare - TASKID v1.0 - INSTALLATION CHECK
	AX = 7A18h
Return: AL = FFh if installed
	    BX = configuration flags (see #2083)
	    CX = resident code segment
SeeAlso: AX=7A10h

Bitfields for NetWare TASKID configuration flags:
Bit(s)	Description	(Table 2083)
 0	INT 2F hooked
 3	INT 08 hooked
 other	unused
--------N-2F7A19-----------------------------
INT 2F U - Novell NetWare - TASKID v1.0 - GET INT 08 HANDLERS
	AX = 7A19h
Return: AL = FFh
	DS:DX -> TASKID INT 08 handler
	ES:BX -> original INT 08 handler
--------N-2F7A1A-----------------------------
INT 2F U - Novell NetWare - TASKID v1.0 - GET INT 2F HANDLERS
	AX = 7A1Ah
Return: AL = FFh
	DX:DX -> TASKID INT 2F handler
	ES:BX -> original INT 2F handler
SeeAlso: AX=7A11h,AX=7A19h
--------N-2F7A1B-----------------------------
INT 2F U - Novell NetWare - TASKID v1.0 - GET DIAGNOSTICS INFORMATION
	AX = 7A1Bh
	CX = desired information
	    0000h supported functions
	    0001h TASKID ID number
		Return: CX = ID number
	    0002h set-ID count
		Return: CX = ID set count
Return: AL = FFh
	BX = highest supported subfunction number (0002h)
SeeAlso: AX=7A14h,AX=7A18h
--------N-2F7A1C-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - ???
	AX = 7A1Ch
	BP = ???
	CX:DX = ???
Return: AX = 70FFh
--------N-2F7A1D-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - ???
	AX = 7A1Dh
	???
Return: ES = ???
	???
	SI destroyed
--------N-2F7A1E-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - ???
	AX = 7A1Eh
	ES:SI -> ???
	???
Return: ???
--------N-2F7A20BX0000-----------------------
INT 2F - Novell NetWare - Adv NetWare 4.0 DOS Requester - GET VLM CALL ADDRESS
	AX = 7A20h
	BX = 0000h
Return: AX = 0000h on success (installed)
	    ES:BX -> far call address for DOS Requester (see #2084)
Notes:	the DOS Requester replaces the NetWare Shell (ANETx, NETx) on
	  NetWare LAN's as of the release of Advanced NetWare 4.0 (1993).  It
	  is backward compatible with NetWare 2.1x through 3.11 servers as
	  well.	 Note that there was a NetWare 4.0 in the early 1980's, which
	  can cause confusion.
	this call is used as the installation check by VLM.EXE, which is the
	  loader for all the modules of the DOS Requester
	.VLMs are standard old .EXE format executables whose normal entry point
	  merely terminates to prevent loading from the command line.  The
	  real entry point is found by looking at the VLM header at the
	  beginning of the load image (see #2087)
Index:	installation check;NetWare 4.0 DOS Requester

(Table 2084)
Call DOS Requester entry point with:
	STACK:	WORD	destination function
		WORD	destination VLM ID (see #2086)
		WORD	source VLM ID (0000h = application program)
	registers as appropriate for function
Return: AX = status code (0000h,8811h,8846h,8848h,8853h) (see #2085)
	other registers as appropriate for function
	STACK popped
	BP destroyed

(Table 2085)
Values for VLM status code:
 0000h	successful
 88xxh	error generated by requester
 8801h	invalid or non-attached connection handle
 8803h	cannot add CDS
 8804h	bad path
 8805h	error sending or receiving NCP packets
 8811h	nonexistent function called
 8836h	attempted function with invalid parameter
 8846h	???
 8848h	non-loaded or nonexistent VLM called
 884Dh	no more SFT entries (too many handles)
 8850h	too many reply fragments
 8853h	???
 89xxh	error generated by server
	low byte = return code from server (see also #1221,#1255)
 8900h	server successful
 8901h	out of disk space
 897Eh	NCP boundary check failed
 897Fh	???
 8980h	lock failed; file in use
 8981h	out of handles
 8982h	no open privileges
 8983h	hard (non-correctable) I/O error
 8984h	no creation privileges
 8985h	no create/delete privileges
 8986h	attempted to create a file which already exists read-only
 8987h	filename error during creation (wildcards in name)
 8988h	invalid file handle
 8989h	no search privileges
 898Ah	no deletion privileges
 898Bh	no rename privileges
 898Ch	no modify privileges
 898Dh	some affected files are in use
 898Eh	all affected files are in use
 898Fh	some affected files are read-only
 8990h	all affected files are read-only; volume read-only
 8991h	some files could not be renamed because target names already exist
 8992h	all affected names exist
 8993h	no read privileges
 8994h	no write privileges
 8995h	file detached
 8996h	server out of memory
 8997h	no disk space for spool file
 8998h	disk map error; volume does not exist
 8999h	directory full
 899Ah	attempt to rename across volumes
 899Bh	bad directory handle
 899Ch	invalid path; no more trustees
 899Dh	no directory handles
 899Eh	bad filename
 899Fh	directory active
 89A0h	directory not empty
 89A1h	directory I/O error
 89A2h	I/O lock error
 89A3h-89BEh ???
 89BFh	invalid name space
 89C0h	no account privileges
 89C1h	no account balance
 89C2h	credit limit exceeded
 89C4h	account disabled
 89C5h	login lockout (intruder detection activated)
 89C6h	no console rights
 89C7h-89CFh
 89D0h	queue error
 89D1h	no queue
 89D2h	no queue server
 89D3h	no queue rights
 89D4h	queue full
 89D5h	no queue job
 89D6h	no job rights; unencrypted password
 89D7h	queue servicing error; duplicate password; bad account
 89D8h	queue not active; password too short
 89D9h	station not queue server; maximum logins exceeded
 89DAh	queue halted; bad login time
 89DBh	maximum queue servers; unauthorized login station
 89DCh	account disabled or expired
 89DEh	password expired (all grace logins used up)
 89DFh	password expired but login allowed (grace login)
 89E0h-89E6h ???
 89E7h	no disk track
 89E8h	property is not an item property; write to group
 89E9h	member exists
 89EAh	no such member
 89EBh	property is not a set property
 89ECh	no such set
 89EDh	property exists
 89EEh	object exists
 89EFh	illegal name
 89F0h	illegal wildcard
 89F1h	invalid bindery security level
 89F2h	not allowed to read object
 89F3h	not allowed to write/rename object
 89F4h	not allowed to delete object
 89F5h	not allowed to create object
 89F6h	not allowed to delete property
 89F7h	not allowed to create property; attempt to use non-local drive
 89F8h	not allowed to write property; already attached to server
 89F9h	not allowed to read property; no free connection slots
 89FAh	temporary remap error; no more server slots
 89FBh	no such property; invalid parameters
 89FCh	no such object; internet packet request canceled; unknown file server
 89FDh	bad station number; lock collision
 89FEh	directory locked; bindery locked; timeout
 89FFh	general error; hard error; lock error
Note:	some server-generated error codes have multiple interpretations; use
	  the one appropriate to the failing call

(Table 2086)
Values for VLM identifier:
 0001h	VLM.EXE		Virtual Loadable Modules manager (see also #2089)
 0010h	CONN.VLM	connection table manager (see also #2090)
 0020h	TRAN.VLM	transport protocol multiplexor (see also #2094)
 0021h	IPXNCP.VLM	transport protocol implementation using IPX (see #2096)
 0022h	TCPNCP.VLM	TCP/IP transport
 0030h	NWP.VLM		NetWare protocol multiplexor (see also #2098)
 0031h	BIND.VLM	bindery
 0032h	NDS.VLM		NetWare Directory Services (see also #2099)
 0033h	PNW.VLM		Personal NetWare
 0034h	RSA.VLM		RSA encryption for directory services re-authentication
 0040h	REDIR.VLM	DOS redirector (see also #2101)
 0041h	FIO.VLM		file I/O (see also #2103)
 0042h	PRINT.VLM	printer redirector (see also #2105)
 0043h	GENERAL.VLM	misc functions for NETx and REDIR (see also #2107)
 0050h	NETX.VLM	NetWare shell compatibility (see also #2109)
 0060h	AUTO.VLM	auto-reconnect/auto-retry
 0061h	SECURITY.VLM	enhanced security module (see #2110)
 0100h	NMR.VLM		NetWare management responder
 09F2h	DRVPRN.VLM	Desktop SNMP Services - Drive/Printer Mappings
 09F5h	SAA.VLM		SAA client API for Netware
 09F6h	IPXMIB.VLM	SNMP IPX-monitoring Module???
 09F7h	PNWMIB.VLM	Personal Netware SNMP Instrumentation Module
 09F8h	PNWTRAP.VLM	Personal Netware SNMP Trap Module
 09F9h	MIB2PROT.VLM	MIB-II Protocol Groups
 09FAh	MIB2IF.VLM	MIB-II Interfaces Group
 09FBh	NVT.VLM		???
 09FCh	WSTRAP.VLM	Desktop SNMP Services - Trap Module
 09FDh	WSREG.VLM	Desktop SNMP Services - Registration Module
 09FEh	WSASN1.VLM	Desktop SNMP Services - ASN.1 Module
 09FFh	WSSNMP.VLM	Desktop SNMP Services - Agent Module

Format of VLM header:
Offset	Size	Description	(Table 2087)
 00h	DWORD	-> initialization entry point
 04h	DWORD	-> VLM API entry point
 08h	DWORD	-> ??? entry point
 0Ch	DWORD	-> ??? entry point
 10h	DWORD	-> ??? entry point
	...
 var	DWORD	00000000h (end of entry point list)
      4 BYTEs	signature "NVlm"
	WORD	VLM identifier (see #2086)
---v1.20+ ---
 1Eh	WORD	???
 20h	WORD	Transient Switch Count
 22h	WORD	VLM Call Count
 24h	WORD	Offset ControlBlocks (See #2088)
 26h	WORD	Current VLMID
 28h	BYTE	Memory Type
		00h=Conventional 02h=EMS 04h=XMS
 29h	BYTE	Modules Loaded
 2Ah	WORD	BlockId
 2Ch	WORD	Transient Block
 2Eh	WORD	Global Segment
 30h  3	DWORDs	pointers to AsyncQueue head, tail, and s???
 3Ch  3	DWORDs	pointers BusyQueue head, tail, and s???
 48h	WORD	ReEntrance Level
 4Ah	WORD	Full Map Count
 4Ch	WORD	???
 4Eh 80 BYTEs	ASCIZ configuration file filename
Note:	the number of entry points in the header is reported as "Func" in the
	  VLM /D display.

Format of VLM Control Block for VLM v1.20 [array]:
Offset	Size	Description	(Table 2088)
 00h	WORD	Flag
 02h	WORD	VLM Identifier (See #2086)
 04h	WORD	Func
 06h	WORD	Maps
 08h	WORD	number of times called
 0Ah	WORD	???
 0Ch	WORD	Transient Segment
 0Eh	WORD	Global Segment
 10h	WORD	Address Low
 12h	WORD	Address High
 14h	WORD	TSegSize
 16h	WORD	GSegSize
 18h	WORD	SSegSize
 1Ah	BYTE	VLMName[9] ASCIZ
Note:	this information is shown in VLM /d under the dashed line. There are 
	  as many 35-byte blocks as modules loaded
SeeAlso: #2087

(Table 2089)
Call VLM Manager (VLM.EXE, ID 0001h) with:
Func	Description/Registers
 01h	VLM Notify
	BX = function
	    0000h get version
		Return: AX = status (see #2085)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	VLM Statistics
 04h	VLM internal use
	BX = function
	    0000h get interrupt vector (calls INT 21/AH=35h)
	    0001h begin critical section (calls INT 2F/AX=1681h)
	    0002h end critical section (calls INT 2F/AX=1682h)
	    0003h ???

(Table 2090)
Call Connection Manager (CONN.VLM, ID 0010h) with:
Func	Description/Registers
 01h	Conn Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #2085)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	Conn Statistics
	CX = length of buffer
	ES:DI -> buffer for connection statistics (see #2091)
	Return: AX = status (0000h successful)
 04h	Conn Alloc Handle
	Return: AX = status (0000h successful)
		CX = connection handle
 05h	Conn Validate Handle
	CX = connection handle
	Return: AX = 0000h if valid handle
 06h	Conn Free Handle
	CX = connection handle
	Return: AX = status (0000h successful)
 07h	Conn Get Entry Field
	BH = connection parameter (see #2093)
	CX = connection handle
	DX = value if BH is non-array parameter
	DH = offset in array if BH is array parameter
	DL = number of bytes to copy if BH is array
	ES:DI -> return buffer if BH is array
	Return: AX = 0000h if successful
		DL/DX = value if non-array parameter
		DH = maximum number of bytes in buffer if array parameter
		DL = number of bytes copied if array
		BX destroyed
 08h	Conn Set Entry Field
	BH = connection parameter (see #2093)
	CX = connection handle
	DL/DX = value if BH is non-array parameter
	DH = offset in array if BH is array parameter
	DL = number of bytes to copy if BH is array
	DS:SI -> buffer if BH is array
	Return: AX = 0000h if successful
		DH = maximum number of bytes in buffer
		DL = number of bytes copied
		BX destroyed
 09h	Conn Reset Entry Field
	BH = connection parameter (see #2093)
	CX = connection handle
	Return: AX = 0000h if successful
		BX,DX destroyed
 0Ah	Conn Lookup Handle
	BL = lookup type (00h equal, 40h not equal)
	BH = connection parameter (see #2093)
	CX = connection handle, 0000h if first
	DL/DX = value if BH is non-array parameter
	DH = offset in array if BH is array parameter
	DL = number of bytes to copy if BH is array
	DS:SI (ES:DI???) -> buffer if BH is array
	Return: AX = 0000h if successful
		CX = handle matching given parameters
 0Dh	Conn Name Lookup
	CX = connection handle
	ES:DI -> 49-byte buffer for server name or 0000h:0000h
	Return: AX = 0000h if successful
		BX = length of server name
		ES:DI buffer filled if pointer not 0000h:0000h
 0Eh	Conn Name To Handle
	DS:SI -> uppercased server name
	CX = length of server name, 0000h if ASCIZ name
	Return: AX = error code or 0000h if successful
		    CX = connection handle if successful
 0Fh	Conn Get Num Connections
	Return: AX = status (0000h if successful)
		DX = number of connections
		CX = segment of connection table 
		    first entry in table (See #2092)

Format of VLM connection statistics:
Offset	Size	Description	(Table 2091)
 00h	WORD	total length of statistics record (including this word)
 02h	WORD	number of connection handles allocated
 04h	WORD	average name length (configured in NET.CFG)
 06h	WORD	maximum number of tasks (configured in NET.CFG)
 08h	WORD	number of failed "allocate handle" calls
 0Ah	WORD	number of failed "add name" calls
 0Ch	WORD	number of failed task calls
Note:	some versions of the NetWare requester reportedly do not implement
	  this correctly
SeeAlso: #2090

Format of NetWare VLM Connection Table [array]:
Offset	Size	Description	(Table 2092)
 00h	WORD	Protocol VLMid	  0032(NDS) 0031(BIND)		Func 07 equiv.
				  0033(PNW) 0000(unused)       bh=01h
 02h	BYTE	(connection status)
		bit 6: connection locked		       bh=16h
		bit 5: authenticated			       bh=03h
		bit 4: permanent			       bh=02h
		bit 2: broadcast msg waiting		       bh=12h
 03h	BYTE	(connection capabilities)
		bit 5: Large Internet Packets		       none
		bit 3: Packet Burst Reset		       bh=07h
		bit 2: Max I/O				       bh=06h
		bit 1: SFT3 change			       bh=05h
		bit 0: Packet Burst Support		       bh=04h
 04h	WORD	reference count				       bh=09h
 06h	WORD	soft resource count			       bh=15h
 08h	BYTE	NCP Order Number			       bh=0Eh
 09h	BYTE	Server security options			       bh=14h
		bit 0: CRC enabled
		bit 1: packet signing required
		bit 5: packet signing enabled
 0Ah	BYTE	OS Major Version			       bh=08h
 0Bh	BYTE	OS Minor Version			       bh=08h
 0Ch	WORD	Hops to Server				       bh=0Ah
 0Eh	WORD	Maximum Packet Size for this connection	       bh=0Bh
 10h	WORD	LIP Parameters				       bh=13h
 12h	WORD	NCP Request Type			       bh=10h
 14h	BYTE	NCP Sequence				       bh=0Ch
 15h	WORD	Connection Number			       bh=0Dh
 17h	BYTE	???					       none
 18h	WORD	Transport VLMid 21(IPXNCP) 22(TCPNCP)	       bh=0Fh	  
 1Ah	BYTE	Node Address[4]				       bh=11h
 1Eh	BYTE	Network[6]				       bh=11h
 24h	BYTE	Socket[2]				       bh=11h  
 26h	BYTE	Local Target[6]				       bh=11h
 2Ch	WORD	Round Trip Time				       bh=11h
 2Eh	WORD	???					       none
SeeAlso: #2090

(Table 2093)
Values for NetWare Connection Manager CEI (Connection Entry Information):
 number	flags	description
 00h	FR	error
 01h	WL	VLM id of transport protocol (NDS/BIND/PNW)
		00h = wildcard
 02h	FR	permanent flag (01h if connection is permanent)
 03h	F	authenticated flag (01h if connection is authenticated)
 04h	F	packet burst supported
 05h	FR	SFT3 change status
 06h	FR	connection needs maximum I/O transmission
 07h	FR	packet burst reset needed
 08h	W	server version
 09h	W	reference count (tasks using connection, 00h = dynamic)
 0Ah	W	distance to server associated with connection
 0Bh	W	maximum packet size supported by transport protocol
 0Ch	B	NCP sequence number
 0Dh	W	connection number
 0Eh	B	NCP order number
 0Fh	WL	VLM id for transport protocol
		00h = wildcard, 21h = IPX, 22h = TCP
 10h	W	NCP request type
 11h	A	transport specific buffer
		12 byte server address
		6 byte	router address
		2 byte round trip time
 12h	FR	broadcast message waiting
 13h	W	large internet packets supported
 14h	B	security options
		bit 0: CRC enabled
		bit 1: packet signing enabled
		bit 5: packet signing active
 15h	W	soft resource count
 16h	FR	connection locked
Note:	flag meanings
	    F=flag value
	    B=byte value
	    W=word value
	    A=array
	    R=resettable
	    L=settable only before authentication
	    others=read only
SeeAlso: #2090

(Table 2094)
Call TRAN.VLM (VLM ID 0020h) with:
Func	Description/Registers
 01h	TRAN Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #2085)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	TRAN Statistics
 06h	TRAN Request Reply (see INT 21/AH=F2h)
	AL = request code (see #1391 at INT 21/AH=F2h)
	BH = error handler flag
	    00h default error handler
	    01h return network errors to caller
	    02h handle network errors in requester
	BL = request list length (max 5 fragments) (see #2095)
	CX = connection handle
	DH = 00h (reserved)
	DL = reply list length (max 5 fragments) (see #2095)
	DS:SI -> address list (each element is DWORD address + WORD length)
	ES:DI -> address list
	Return: AX = error code, 0000h if successful
		BX,DX destroyed
		reply buffer updated if successful
 08h	TRAN Schedule/Cancel Event
 09h	TRAN Get Max Phys Size
	??? = subfunction
	    00h get maximum node size
	    01h get maximum route size to specified server
 0Ah	TRAN Broadcast Mux

Format of TRAN.VLM request/reply fragment descriptor (array):
Offset	Size	Description	(Table 2095)
 00h	DWORD	address of buffer
 04h	WORD	length of buffer

(Table 2096)
Call IPXNCP.VLM (VLM ID 0021h) with:
Func	Description/Registers
 01h	IPX Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #2085)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	IPX Statistics
	CX = length of buffer
	ES:DI -> buffer for statistics (see #2097)
	Return:	AX = status (see #2085)
 06h	IPXNCP Request Reply???
	functionally equivalent to Tran Request Reply???

Format of NetWare IPX statistics:
Offset	Size	Description	(Table 2097)
 00h	WORD	size of statistics, including this word
 02h	DWORD	number of TRAN Request Reply calls made
 06h	WORD	number of user aborts
 08h	WORD	number of user retries
 0Ah	WORD	IPX receive errors
 0Ch	WORD	IPX send errors
 0Eh	WORD	number of unrecognized responses
 10h	WORD	number of bad connection numbers in requests
 12h	WORD	number of bad sequence responses
 14h	WORD	receive buffer overflows
 16h	WORD	number of times route to attached server was lost
 18h	WORD	number of times server responded "busy"
 1Ah	WORD	number of unknown "NCPRepCompCode" values
 1Ch	WORD	number of bad connection numbers in responses
 1Eh	WORD	padding for NETX compatibility
 20h	WORD	padding for NETX compatibility
 22h	WORD	number of attach requests to server without route
 24h	WORD	number of times server responded to attach without slot
 26h	WORD	number of times a server went down during a request
 28h	DWORD	same-server optimizations
 2Ch	WORD	local route changes
 2Eh	WORD	IPX CRC errors
 30h	WORD	number of user fails
 32h	BYTE	flag: CRCs enabled
 33h	BYTE	flag: LIP enabled
 34h	BYTE	flag: configurable NET error handler
SeeAlso: #2096

(Table 2098)
Call NWP.VLM (VLM ID 0030h) with:
Func	Description/Registers
 01h	NWP Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #2085)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	NWP Statistics
 04h	NWP Connect
 05h	NWP Disconnect
 06h	NWP Attach
 08h	NWP Login
 09h	NWP Logout
 0Ah	NWP Get Bindery Object/Get Message Handler
	BX = subfunction
	    0002h set workstation's broadcast message mode
	    0003h get object ID for object name
	    0004h get object name for object ID
	    0005h retrieve broadcast message
 0Ch	NWP context (passed through to NDS.VLM's function 0Ch) (see #2099)
 0Eh	NWP Ordered Send To All
 0Fh	NWP Preferred Handler
	BX = subfunction
	    0000h get preferred connection name
		DX = VLM ID (NDS/BIND/PNW)
		ES:DI -> 49-byte buffer for connection name
		Return: ES:DI buffer filled
	    0001h set preferred connection name
		DX = VLM ID (NDS/BIND/PNW)
		CX = length of connection name (may be 0000h, max 48)
		DS:SI -> name of preferred connection
	    0002h get preferred connection ID
		DX = VLM ID (NDS/BIND/PNW)
		Return: AX = status
			CX = connection handle if successful
	    0003h get server address
		CX = connection handle or 0000h
		DS:SI -> name to be resolved
		ES:DI -> 12-byte buffer for server address
 10h	NWP ???
	BX = subfunction
	    0001h get security flags (see also INT 21/AX=B301h)
		Return: BX:CX indicates signature level
				= 0100h:0000h if signature level=0
				= 0300h:0000h if signature level=1
				= 0302h:0000h if signature level=2
				= 0302h:0202h if signature level=3
	    0002h create session keys (see also INT 21/AX=B302h)
		CX = server connection handle
		DS:SI -> 24-byte input buffer
	    0004h set security flags (see also INT 21/AX=B304h)
		BL:CL = new flags
	    0006h renegotiate security level (see also INT 21/AX=B306h)
		CX = server connection number (01h-08h)

(Table 2099)
Call NDS.VLM (VLM ID 0032h) with:
Func	Description/Registers
 01h	NDS Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #2085)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	NDS Statistics
 06h	NDS Attach
	CX = allocated connection handle
	DS:SI -> server address
 08h	NDS Fragment Requst
	Return: AX = 8836h (invalid parameter)
	Note:	this function was documented but does not work
 0Ch	NDS context
	BX = subfunction
	    0000h get default name context
		CX = length of buffer for default context
		ES:DI -> buffer to receive name
		Return: ES:DI buffer filled
	    0001h set default context
		CX = length of new default context name
		DS:SI -> context name
	    0002h read from TDS
		CX = reply buffer length
		DX = 0110h ???
		SI = offset in TDS
		ES:DI -> reply buffer
	    0003h write to TDS
	    0005h "NWDSChangeResourceConnection/Lock Connection"
		CX = connection handle
		DL = subfunction (00h-09h)
		    04h = NWDSChangeResourceOnConnection
		    07h = NWDSChangeResourceOnConnection
		    08h = NWDSLockConnection
	    0006h NDS change connection state (internal)
		CX = connection handle
		AL = 00h or 01h
	    0007h "NWDSSetMonitoredConnection"
		AX = subfunction
		    0001h get monitored connection
			Return: CX = connection handle???
		    0002h set monitored connection
			CX = connection handle???
	    0008h send NDS request
		AX = NDS function
		CX = connection handle
		DS:SI -> request buffer descriptor (see #2100)
		ES:DI -> reply buffer descriptor (see #2100)
	    000Ah set NDS CEI Info
		DL = buffer length
		DS:SI -> input buffer

Format of NetWare NDS request/reply buffer descriptor:
Offset	Size	Description	(Table 2100)
 00h	DWORD	-> buffer
 04h	WORD	length of buffer in bytes
SeeAlso: #2099

(Table 2101)
Call REDIR.VLM (VLM ID 0040h) with:
Func	Description/Registers
 01h	Redir Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #2085)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	Redir Statistics
 04h	Redir Build SFT (see INT 21/AH=B4h"NetWare")
	CX = connection handle
	ES:DI -> SFT build request (see #2102)
	Return: AX = 0000h if successful
		    BX = DOS file handle
 05h	Redir DOS To NW Handle
 08h	Redir Specific
	BX = 0000h get item
	    DS:SI -> ASCIZ string "LPTx" (x='1'-'9') or drive spec ("d:")
	    ES:DI -> 512-byte reply buffer for
		      "\\server\resource",00h,"path",00h

Format of NetWare SFT build request:
Offset	Size	Description	(Table 2102)
 00h  6 BYTEs	NetWare handle
 06h	WORD	reserved for internal use
 08h 14 BYTEs	ASCIZ filename
 16h	BYTE	DOS file attributes
		bit 7: file is shareable
 17h	BYTE	reserved
 18h	LONG	file size
 1Ch	WORD	creation date
 1Eh	WORD	last access date
 20h	WORD	last update date
 22h	WORD	last update time

(Table 2103)
Call File I/O FIO.VLM (VLM ID 0041h) with:
Func	Description/Registers
 01h	FIO Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #2085)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	FIO Statistics
	CX = length of buffer
	ES:DI -> buffer for statistics (see #2104)
	Return: AX = status (0000h if successful)
		buffer filled if successful
 04h	FIO Remote Copy

Format of NetWare FIO statistics:
Offset	Size	Description	(Table 2104)
 00h	WORD	length of statistics record (including this word)
 02h	WORD	number of read requests
 04h	WORD	number of write requests
 06h	WORD	number of cache read hits
 08h	WORD	number of cache write hits
 0Ah	WORD	number of cacheable files with free blocks
 0Ch	WORD	number of cacheable files without free blocks
 0Eh	WORD	number of standard read requests
 10h	WORD	number of standard write requests
 12h	WORD	number of burst read requests
 14h	WORD	number of burst write requests
 16h	BYTE	flag: cache writes enabled
 17h	BYTE	flag: true commits enabled
 18h	WORD	number of cache blocks
 1Ah	WORD	size of a cache buffer
 1Ch	WORD	number of ECBs for packet bursts (0000h if bursts disabled)
SeeAlso: #2103

(Table 2105)
Call PRINT.VLM (VLM ID 0042h) with:
Func	Description/Registers
 01h	Print Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #2085)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	Print Statistics
 04h	Print Get/Set Data
	BX??? = subfunction
	    00h set printer control flags
	    01h get printer control flags
	    02h set extended printer control flags
	    03h get extended printer control flags
 05h	Print Open Capture File
 07h	Print Get Num Of Printers
 08h	Print Redirection
	BX = subfunction
	    0000h redirect device to queue
		AX = length of queue name, 0000h to use queue ID
		DS:SI -> uppercased ASCIZ queue name
		ES:DI -> queue ID, 0000h:0000h to use queue name
	    0001h test whether device is redirected
	    0002h cancel redirection
	    0003h redirect device to file
		AX = 0000h or 4E57h ('NW')
		ES:DI -> ASCIZ path of file
	    0004h get extended redirection information (see #2106)
	CX = connection handle
	DX = printer (0=LPT1)
	Return: AX = 0000h if successful
 09h	Print Flush And Close Job
 0Ch	Print Get/Set Banner Name

Format of PRINT.VLM standard print control information:
Offset	Size	Description	(Table 2106)
 00h	BYTE	PFStatus (reserved, 00h)
 01h	BYTE	print flags (default 80h)
		bit 2: release job for printing if capture interrupted
		bit 3: suppress form feed
		bit 4: notify
		bit 6: text file
		bit 7: print banner
 02h	BYTE	tab size (01h-12h, default 08h)
 03h	BYTE	number of copies (default 01h)
 04h	BYTE	???
 05h	BYTE	form type to be mounted in printer (default 00h)
 06h	BYTE	reserved (00h)
 07h 14 BYTEs	banner
 15h	BYTE	capture printer (LPT) number
 16h	WORD	capture timeout in seconds
 18h	BYTE	job concatenation flag (00h or 01h, default 00h)
 19h	BYTE	maximum lines per page (default 66)
 1Ah	BYTE	???
 1Bh	BYTE	maximum characters per line (default 132)
 1Ch	BYTE	???
 1Dh 13 BYTEs	name of form to be mounted in printer
 2Ah	BYTE	flag: capture active (00h or FFh, default 00h)
 2Bh	BYTE	flag: capturing to file (00h or 01h, default 00h)
 2Ch	BYTE	flag: timeout field is being decremented (default 00h)
 2Dh	DWORD	-> printer setup string
 31h	DWORD	-> printer reset string
 35h	BYTE	reserved (01h)
 36h	BYTE	flag: job has started printing (00h or FFh, default 00h)
 37h	BYTE	flag: job placed in queue (00h or FFh, default 00h)
 38h	BYTE	flag: PJobValid (00h or FFh, default 00h)
 39h	DWORD	print-queue ID
 3Dh	BYTE	low byte of print-job number (default 00h)
 3Eh	BYTE	???
 3Fh	BYTE	number of chars in INT 17h print cache buffer (default 00h)
 40h	BYTE	???
 41h	BYTE	high byte of print-job number (default 00h)
SeeAlso: #2105

(Table 2107)
Call GENERAL.VLM (VLM ID 0043h) with:
Func	Description/Registers
 01h	Gen Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #2085)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	Gen Statistics
	CX = length of statistics buffer
	ES:DI -> buffer for statistics (see #2108)
	Return: AX = status (see #2085)
 04h	Gen Get/Set Primary
	BX = subfunction
	    0001h get primary connection
		CX = primary connection handle to be retrieved
		Return: AX = status (see #2085)
			CX = primary connection handle
	    0002h set primary connection
		CX = primary connection handle to be stored
		Return: AX = status (see #2085)
 06h	Gen Specific
	BX = subfunction
	    0000h get command processor and master environment addresses
		Return: DX = segment of master environment
			ES:DI -> command processor's private COMSPEC= copy
	    0001h get default or primary connection
		Return: AX = status (0000h successful)
			CX = connection handle if successful
	    0002h last queue information
		AL = operation
		    00h zap
		    01h set
		    02h get
		DI:DX = queue file handle
		CX = connection handle
		Return: AX = status (0000h successful)
			DI:DX = queue file handle
			CX = connection handle or 0000h if queue info invalid
	    0003h get/set machine name(s)
		AX = name type
		    00h get short machine name
		    02h get long machine name
		    04h set short machine name
		    06h set long machine name
		    08h get DOS name
		    0Ah set DOS name
		ES:SI -> ASCIZ name if setting
		Return: AX = status (0000h if successful)
			ES:SI -> ASCIZ name if getting
	    0004h set per-task EXEC search mode
		Return: AX = status (0000h if successful)
 09h	Gen Return Drive Info
	BX = subfunction
	    0000h get first available drive
		Return: AX = status (see #2085)
			BX = drive letter of first drive
	    0001h get Lastdrive
		Return: AX = status (see #2085)
			CH = number lastdrive 1=A: - 1Ah=Z:

Format of NetWare GENERAL.VLM statistics:
Offset	Size	Description	(Table 2108)
 00h	WORD	size of statistics record, including this word
 02h	DWORD	previous INT 21 vector
SeeAlso: #2107

(Table 2109)
Call NETX.VLM (VLM ID 0050h) with:
Func	Description/Registers
 01h	NetX Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #2085)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	NetX Statistics

(Table 2110)
Call SECURITY.VLM (VLM ID 0061h) with:
Func	Description/Registers
 01h	Security Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #2085)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	Security Statistics
 04h	???
	AL = subfunction
	    01h compute session key
		DS:SI -> 24-byte input buffer
		ES:DI -> 8-byte output buffer
--------N-2F7A20BX0001-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM CallA ADDRESS
	AX = 7A20h
	BX = 0001h
Return: AX = 0000h if request was handled
	    ES:BX -> CallA entry point (see #2111)

(Table 2111)
Call VLM CallA entry point with:
	AX = function
	    0000h submit
	    0001h cancel (not implemented)
	ES:DI -> Overlay Asynchronous Control Block structure (see #2112)

Format of Overlay Asynchronous Control Block (OACB):
Offset	Size	Description	(Table 2112)
 00h	DWORD	link to next OACB, 0000h:0000h if last
 04h	DWORD	callback address or 0000h:0000h
 08h	BYTE	InUse flag (00h if complete)
 09h	BYTE	flag, reserved for VLM use
 0Ah	WORD	destination VLM
 0Ch	WORD	destination function
 0Eh	WORD	temporary storage for VLM.EXE
 10h  6 BYTEs	reserved
 16h  6 DWORDs	EAX,EBX,ECX,EDX,ESI,EDI
 2Eh  4 WORDs	DS,ES,FS,GS (FS and GS not used)
--------N-2F7A20BX0002-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM MULTIPLEX ADDRESS
	AX = 7A20h
	BX = 0002h
Return: AX = 0000h
	ES:BX -> VLM multiplex entry point (see #2113)
Note:	for v1.10, this function is only available while VLM.EXE is loading
	  the .VLM modules, because ES is destroyed on return

(Table 2113)
Call DOS Requester entry point with:
	BX = function???
	    0000h
		DX = ???
		DI = ???
		BP = ???
	    0002h
		CX = ???
	    0003h
		DX = ???
		BP = ???
	    0006h
		AH = subfunction???
		AL = ???
		STACK: variable (0, 4, 10, 14 bytes seen)
--------N-2F7A20BX0003-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM PARSE API ADDRESS
	AX = 7A20h
	BX = 0003h
Return: AX = 0000h if request was handled
	    ES:BX -> VLM parse API entry point
--------N-2F7A20BX0004-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM MULTICAST CALLOUT
	AX = 7A20h
	BX = 0004h
Return: AX = 0000h if request was handled
	    ES:BX -> VLM multicast data (see #2114)

Format of DOS Requester data:
Offset	Size	Description	(Table 2114)
 00h	DWORD	pointer to ??? (code)
 04h  4 BYTEs	???
 08h	DWORD	pointer to ??? (code) (see #2115)
	???

(Table 2115)
Call offset 08h function with:
	AL = function (00h-07h)
	???
Return: ???
--------N-2F7A20BX0005-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM INT 24 ADDRESS
	AX = 7A20h
	BX = 0005h
Return: AX = 0000h if request was handled
	    ES:BX -> VLM INT 24 handler
--------N-2F7A20BX0006-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0006h
Return: AX = 0000h if request was handled
	    ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
--------N-2F7A20BX0007-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0007h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
--------N-2F7A20BX0008-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0008h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
--------N-2F7A20BX0080-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0080h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
Note:	this function is identical to AX=7A20h/BX=0006h in v1.03 and v1.10
--------N-2F7A20BX0081-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0081h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
Note:	this function is identical to AX=7A20h/BX=0007h in v1.03 and v1.10
--------N-2F7A20BX0082-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0082h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
Note:	this function is identical to AX=7A20h/BX=0008h in v1.03 and v1.10
--------N-2F7A21-----------------------------
INT 2F C - Novell NetWare - DOS Requester - BROADCAST CALLBACK
	AX = 7A21h
	CX = server connection (FFFFh if message from Personal NetWare user)
	interrupts disabled
Return: CX = 0000h if broadcast handled
	interrupts disabled
Note:	this function is only linked into INT 2F when INT 21/AH=DEh/DL=05h
	  has been issued
SeeAlso: AX=7A22h,AX=7A85h,INT 21/AH=DEh
--------N-2F7A22-----------------------------
INT 2F C - Novell NetWare - DOS Requester - BROADCAST/SFT3 INFORM
	AX = 7A22h
	DL = function
	    21h ('!') broadcast waiting for workstation
	    40h ('@') SFT3 server-change inform
	BX = transport type
	    0021h IPX
	    0022h TCP
	ES:SI -> transport-specific data block
	    (ECB for IPX, undefined for TCP)
	interrupts disabled
Return: AX = 0000h if event handled, unchanged if not
	interrupts disabled
Note:	this callback is made from within a hardware interrupt handler; a
	  separate call to AX=7A21h is made once the system is in a safe
	  state for receiving the message
SeeAlso: AX=7A21h
--------N-2F7A2F-----------------------------
INT 2F U - Novell NetWare - IPXODI v2.12 - GET GNMA SUPPORT
	AX = 7A2Fh
Return: AX = 0000h if supported and active
	    BX = support level (0001h)
	    ES:DI -> GNMA entry point (see #2116)
Program: GNMA is the Generic NetWare Management Agent
Note:	IPXODI v2.12 is distributed as part of the Personal NetWare system
	  bundled with Novell DOS 7
SeeAlso: INT 7A/BX=001Fh

(Table 2116)
Call IPXODI GNMA entry point with:
	BX = function
	    0000h ???
		ES:SI -> ??? data
	    0001h ???
		AX = ???
		Return: ES:SI -> ??? data
	    0002h get ??? address
		Return: ES:SI -> ??? buffer
	    0003h send SPX packet???
		AL = ???
		CX = ???
		DX = ???
		SI = ???
		Return: ??? (registers from a call to INT 7A/BX=0016h)
Return: BX corrupted
--------N-2F7A2FBX0EDC-----------------------
INT 2F U - Personal NetWare - HRMIB - UNINSTALL
	AX = 7A2Fh
	BX = 0EDCh ('EDC' = Novell European Development Center)
Return: ???
SeeAlso: AX=7AA0h
--------N-2F7A40-----------------------------
INT 2F U - Novell NetWare - TCP/IP Protocol Stack - INSTALLATION CHECK
	AX = 7A40h
Return: AX = 7AFFh if installed
	    BX = ??? bit flags (see #2117)
	    CX = version (CH=major, CL=minor)
	    DX = 0000h
	    ES:DI -> entry point for TCP/IP stack (see #2118)
Notes:	Novell's LAN Workplace for DOS TCPIP.EXE also supports this interface
	this function is also supported by the Beame&Whiteside BWLWP40 shim,
	  but it only returns AL and ES:DI, and does not support AX=7A41h
SeeAlso: AX=7A41h,INT 15/AX=DE2Eh,INT 60"Excelan"

Bitfields for returned BX:
Bit(s)	Description	(Table 2117)
 0	???
 1	???
 15-2	reserved???

(Table 2118)
Call NetWare TCP/IP entry point with:
	ES:SI -> parameter block (see #2119)
Return: ES:SI parameter block updated

Format of NetWare TCP/IP parameter block:
Offset	Size	Description	(Table 2119)
 00h  4 BYTEs	???
 04h	WORD	(ret) ???
 06h	WORD	(ret) ???
 08h	DWORD	-> FAR routine called if bit 7 of function code set
 0Ch	BYTE	flags???
 0Dh  7 BYTEs	???
 14h	BYTE	(ret) ???
 15h	BYTE	(call) function code (bit 7 set if ???) (see #2120)
 16h	BYTE	socket number
 17h	BYTE	(ret) result or error code
 18h  4 WORDs	parameter words 0 to 3 (see #2120 for usage)
 20h	WORD	length of packet sent/received
 22h	WORD	number of pointer/length pairs following
 24h 6N BYTEs	buffer descriptors, each
		Offset	Size	Description
		 00h	DWORD	pointer to buffer
		 04h	WORD	length of buffer

(Table 2120)
Values for NetWare TCP/IP function code:
 01h	"accept"
 02h	"bind"
 03h	close socket
	Call:	socket number field set
 04h	"connect"
 05h	get IP address
	Call:	socket number field set to 0000h
	Return:	parameter words 1 and 2 contain caller's IP address
 06h	get hardware address
 07h	"getpeername"
 08h	get socket name
 0Ah	get netmask
 0Bh	"ioctl"
 0Ch	"listen"
 0Dh	"select"
 10h	"shutdown"
 11h	open socket
	Call:	socket number field set to 0000h
		parameter word 0 = desired protocol (6 = TCP, 17 = UDP)
	Return: socket number set
 12h	"read"
 13h	"recvfrom"
	Call:	socket number set
		packet length and buffer descriptors set
	Return:	packet length and receive buffers updated
		parameter word 1 = source port number
		parameter words 2 and 3 = source IP address
 14h	"write"
 15h	"sendto"
	Call:	socket number set
		flags field = ???
		parameter word 0 = 0000h
		parameter word 1 = destination port number
		parameter words 2 and 3 = destination IP address
		packet length and buffer descriptors set
 16h	get BOOTP data
Note:	these functions are based on the Unix socket interface
--------N-2F7A41-----------------------------
INT 2F - Novell NetWare - TCP/IP Protocol Stack - WINDOWS SUPPORT???
	AX = 7A41h
	ES:DI -> FAR entry point for ??? (will be called with BX=1,2,3,4)
Return: AX = 7AFFh if supported
	    BX = ??? (see #2117)
	    CX = version (CH=major, CL=minor)
	    DX = 0000h
	    ES:SI -> DWORD containing passed value of ES:DI
	    ES:DI -> entry point for TCP/IP stack
Notes:	Novell's LAN Workplace for DOS TCPIP.EXE also supports this interface
	the pointer which is set to ES:DI is cleared to 0000h:0000h when
	  a Windows exit broadcast is received
SeeAlso: AX=7A40h
--------N-2F7A42-----------------------------
INT 2F - Novell NetWare - TCPIP.EXE v4.1 - GET ??? ENTRY POINT
	AX = 7A42h
Return: AX = 7AFFh if supported
	    ES:DI -> ??? entry point (see #2121)

(Table 2121)
Call NetWare TCPIP.EXE entry point with:
	DX = ???
	ES:DI -> ??? (see #2122)
Return: AX = 0000h
	other registers destroyed

Format of data buffer:
Offset	Size	Description	(Table 2122)
 00h	WORD	offset of WORD ??? or 0000h
 02h	WORD	offset of DWORD ??? or 0000h
 04h	WORD	offset of DWORD ??? or 0000h
--------N-2F7A43-----------------------------
INT 2F - Novell NetWare - TCPIP.EXE v4.1 - GET ???
	AX = 7A43h
Return: AX = 7AFFh if supported
	    DX = offset of ???
SeeAlso: AX=7A44h
--------N-2F7A44-----------------------------
INT 2F - Novell NetWare - TCPIP.EXE v4.1 - SET ???
	AX = 7A44h
	DX = offset of ??? (see AX=7A43h)
Return: AX = 7AFFh if supported
SeeAlso: AX=7A43h
--------N-2F7A4C-----------------------------
INT 2F - Novell NetWare - TCPIP.EXE v4.1 - GET ???
	AX = 7A4Ch
Return: AX = 7AFFh if supported
	    BX = ??? (0037h)
	    CX = ??? (001Ch)
--------N-2F7A4DBX0001-----------------------
INT 2F - Novell NetWare - ???
	AX = 7A4Dh
	BX = 0001h
	ES:DI -> ???
Return: AL = FFh if ???
	    ES:DI -> ???
Note:	called by NETBIOS.EXE v3.01
--------N-2F7A4E-----------------------------
INT 2F - Novell LAN Workplace for DOS - RARPD.EXE - INSTALLATION CHECK
	AX = 7A4Eh
Return: AX = 7AFFh if installed
SeeAlso: AX=7A4Fh"RARPD"
--------N-2F7A4F-----------------------------
INT 2F - Novell LAN Workplace for DOS - RARPD.EXE - UNINSTALL
	AX = 7A4Fh
Return: AX = 7AFFh if installed
	DX,ES destroyed
Note:	this call conflicts with SNMP.EXE (both RARPD and SNMP are supplied
	  with LAN Workplace for DOS!), such that running SNMP will uninstall
	  RARPD as SNMP checks whether it is already installed!
SeeAlso: AX=7A4Eh"RARPD",AX=7A4Fh/BX=0001h
--------N-2F7A4FBX0001-----------------------
INT 2F - Novell NetWare - SNMP.EXE - INSTALLATION CHECK
	AX = 7A4Fh
	BX = 0001h
Return: AX = 7AFFh if installed
Note:	this call conflicts with RARPD.EXE (both SNMP and RARPD are supplied
	  with LAN Workplace for DOS!), such that running SNMP will uninstall
	  RARPD as SNMP checks whether it is already installed!
SeeAlso: AX=7A4Fh"RARPD",AX=7A4Fh/BX=0002h
--------N-2F7A4FBX0002-----------------------
INT 2F - Novell NetWare - SNMP.EXE - ???
	AX = 7A4Fh
	BX = 0002h
Return: AL = status
	    4Fh if failed
	    FFh if successful
SeeAlso: AX=7A4Fh/BX=0001h
--------N-2F7A80-----------------------------
INT 2F C - Novell NetWare - SHELL 3.01d BROADCAST - ABNORMAL EXIT
	AX = 7A80h
Return: nothing
Notes:	called on abnormal exit of the NetWare shell to notify other Novell
	  TSRs that it is unsafe to call the shell in the future.
	must be passed through so that all interested programs see the exit
	on receiving this call, IPXODI clears an internal pointer to a
	  default value; Novell's NETBIOS.EXE clears its INT 21h pointer to
	  0000h:0000h and stops calling it
SeeAlso: AX=7A81h
--------N-2F7A81-----------------------------
INT 2F C - Novell NetWare - SHELL 3.01d BROADCAST - SET SHELL INT 21 HANDLER
	AX = 7A81h
	CX:DX -> shell's INT 21h entry point
Return: nothing
Notes:	the shell calls this function as it loads to allow interested TSRs
	  and drivers to make a local copy of the shell's entry point
	must be passed through so that all interested programs see it
--------N-2F7A85-----------------------------
INT 2F C - Novell NetWare - shell 3.01 - BROADCAST INFORM
	AX = 7A85h
	CX = broadcast server number
Return: CX = 0000h if broadcast message handled by another program
	CX unchanged if broadcast not handled
SeeAlso: AX=7A21h
--------N-2F7A90-----------------------------
INT 2F U - Novell NetWare - NETBIOS.EXE 3+ - INSTALLATION CHECK
	AX = 7A90h
Return: AL = 00h if present
	    BX = ???
	    CX = PSP segment of NETBIOS resident code
SeeAlso: AX=7AFEh
--------N-2F7AA0-----------------------------
INT 2F U - Personal NetWare - HRMIB - ???
	AX = 7AA0h
	BX = function
	    0000h ???
	    0001h ???
Return: ???
SeeAlso: AX=7A2Fh/BX=0EDCh
--------N-2F7AC1-----------------------------
INT 2F - LAN HiJack - LHR - DISABLE???
	AX = 7AC1h
Program: LAN HiJack is a NetWare utility by KDS Software which allows a user
	  to take over control of a workstation remotely; LHR is the program
	  run on the slave workstation
SeeAlso: AX=7AC8h,AX=7AC9h,AX=7ACFh
--------N-2F7AC2-----------------------------
INT 2F - LAN HiJack - LHR - SYNCHRONIZE SHIFT STATES???
	AX = 7AC2h
Note:	sets BIOS keyboard status byte to an internal variable
SeeAlso: AX=7AC3h,AX=7ACFh
--------N-2F7AC3-----------------------------
INT 2F - LAN HiJack - LHR - CLEAR ??? FLAG
	AX = 7AC3h
SeeAlso: AX=7AC2h,AX=7ACFh
--------N-2F7AC8-----------------------------
INT 2F - LAN HiJack - LHR - ENABLE FUNCTIONS
	AX = 7AC8h
	BL = function(s) to enable (see #2123)
SeeAlso: AX=7AC1h,AX=7AC9h,AX=7ACFh

Bitfields for LAN HiJack function(s) to enable/disable:
Bit(s)	Description	(Table 2123)
 0	???
 1	remote keyboard enabled
 2	support remote's mouse
 3-7	unused
--------N-2F7AC9-----------------------------
INT 2F - LAN HiJack - LHR - DISABLE FUNCTIONS
	AX = 7AC9h
	BL = function(s) to disable (see #2123)
SeeAlso: AX=7AC1h,AX=7AC8h
--------N-2F7ACA-----------------------------
INT 2F - LAN HiJack - LHJ - ???
	AX = 7ACAh
	BL = ???
Return: ???
Program: LAN HiJack is a NetWare utility by KDS Software which allows a user
	  to take over control of a workstation remotely; LHJ is the program
	  run on the controlling workstation
--------N-2F7ACB-----------------------------
INT 2F - LAN HiJack - LHJ - ???
	AX = 7ACBh
	BX = ???
Return: ???
Note:	this function appears to be related to the keyboard
SeeAlso: AX=7ACCh
--------N-2F7ACC-----------------------------
INT 2F - LAN HiJack - LHJ - ???
	AX = 7ACCh
	BX = ???
Return: ???
Note:	this function appears to be related to the mouse
SeeAlso: AX=7ACBh
--------N-2F7ACFBX0000-----------------------
INT 2F - LAN HiJack - LHR - INSTALLATION CHECK
	AX = 7ACFh
	BX = 0000h
Return: BX = segment of resident code if installed
Program: LAN HiJack is a NetWare utility by KDS Software which allows a user
	  to take over control of a workstation remotely; LHR is the program
	  run on the slave workstation
--------N-2F7AF0-----------------------------
INT 2F - Novell NetWare - DOSNP.EXE v1.30G - INSTALLATION CHECK
	AX = 7AF0h
Return: AL = FFh if present
	    ES = 7AF0h
	    CX = PSP segment of resident code
--------N-2F7AF1-----------------------------
INT 2F - Novell NetWare - Access Server Driver - INSTALLATION CHECK
	AX = 7AF1h
	BL = sequence number (01h first driver, 02h second, 00h no driver)
Return: AX <> 7AF1h if present
	    BH = total number of drivers
	    ---if BL nonzero on entry---
	    AL = number of ports provided by specified driver
	    ES:DI -> driver entry point
		      (see #2124,#2125,#2126,#2127,#2128,#2129,#2130,#2131)
	    ES:DX -> ID string
SeeAlso: INT 7A/BX=001Ch

(Table 2124)
Call Access Server driver "initialize port" function with:
	AH = 01h
	AL = port number (00h-0Fh)
	ES:BX -> configuration parameter block (see #2137)
	interrupts disabled
Return: CF clear if successful
	CF set on error
SeeAlso: #2125

(Table 2125)
Call Access Server driver "get port status" function with:
	AH = 02h
	AL = port number (00h-0Fh)
	interrupts disabled
Return: CF clear if successful
	    BL = transmitter status (see #2134)
	    BH = receiver status (see #2135)
	    DL = external status signals (see #2136)
	CF set on error
	interrupts disabled
SeeAlso: #2124,#2126,#2129

(Table 2126)
Call Access Server driver "get input from port" function with:
	AH = 03h
	AL = port number (00h-0Fh)
	CX = size of data buffer
	ES:BX -> buffer for data
	interrupts disabled
Return: CF clear if successful
	CF set on error
	interrupts disabled
	CX = number of bytes read
Note:	the driver will add a NUL to the buffer when a break signal is detected
SeeAlso: #2126,#2127

(Table 2127)
Call driver "send output data to port" function with:
	AH = 04h
	AL = port number (00h-0Fh)
	CX = number of bytes to send
	ES:BX -> buffer containing data
	interrupts disabled
Return: CF clear if successful
	CF set on error
	interrupts disabled
	CX = number of bytes actually written
SeeAlso: #2126,#2128

(Table 2128)
Call driver "get I/O character counts" function with:
	AH = 05h
	AL = port number (00h-0Fh)
	interrupts disabled
Return: CF clear if successful
	    BX = number of bytes pending transmission
	    CX = number of bytes available for reading
	CF set on error
	interrupts disabled
SeeAlso: #2126,#2127

(Table 2129)
Call driver "control XON/XOFF" function with:
	AH = 06h
	AL = port number (00h-0Fh)
	DL = new state
	    (00h software flow control disabled, else enabled)
	interrupts disabled
Return: CF clear if successful
	CF set on error
	interrupts disabled
SeeAlso: #2130

(Table 2130)
Call driver "get error counts and statistics" function with:
	AH = 07h
	AL = port number (00h-0Fh)
	ES:BX -> buffer for statistics (see #2138)
	interrupts disabled
Return: CF clear if successful
	    ES:BX buffer filled
	CF set on error
	interrupts disabled
SeeAlso: #2131,#2132,#2133

(Table 2131)
Call driver "general request" function with:
	AH = 08h
	AL = port number (00h-0Fh)
	DX = requested operations
	    bit 0: flush transmit buffers
	    bit 1: flush receive buffers
	    bit 4: define XON/XOFF characters
	ES:BX -> XON/XOFF characters (see #2139) if DX bit 4 set
	interrupts disabled
Return: CF clear if successful
	CF set on error
	interrupts disabled

(Table 2132)
Call driver "deadman timer management" function with:
	AH = 09h
	AL = port number (00h-0Fh)
	BX = next time interval in seconds (0000h to disable timer)
	interrupts disabled
Return: CF clear
	interrupts disabled
SeeAlso: #2133

(Table 2133)
Call driver "get buffer sizes" function with:
	AH = 0Ah
	AL = port number (00h-0Fh)
	interrupts disabled
Return: CF clear if successful
	   BX = size of transmit buffer
	   CX = size of receive buffer
	CF set on error
	interrupts disabled
SeeAlso: #2132

(Table 2134)
Values for Access Server transmitter status:
 00h	uninitialized
 01h	ready, not transmitting
 02h	transmitting
 03h	XOFF received
 04h	transmitting, buffer full
 05h	XOFF received and buffer full

(Table 2135)
Values for Access Server receiver status:
 00h	uninitialized
 01h	ready
 02h	receive buffer full, data may have been lost

Bitfields for external status signals:
Bit(s)	Description	(Table 2136)
 7,6	undefined
 5	CTS active
 4	DSR active
 3	DCD active
 2,1	undefined
 0	ring indicator

Format of Access Server configuration parameter block:
Offset	Size	Description	(Table 2137)
 00h	BYTE	receive baud rate index
		00h 50 bps, 01h 75 bps, 02h 110 bps, 03h 134.5 bps,
		04h 150 bps, 05h 300 bps, 06h 600 bps, 07h 1200 bps,
		08h 1800 bps, 09h 2000 bps, 0Ah 2400 bps, 0Bh 3600 bps,
		0Ch 4800 bps, 0Dh 7200 bps, 0Eh 9600 bps, 0Fh 19200 bps,
		10h 38400 bps, 11h 57600 bps, 12h 115200 bps
 01h	BYTE	receive bits per character (0=5 bits..3=8 bits)
 02h	BYTE	receive stop bits
 03h	BYTE	receive parity
		00h none, 01h odd, 02h even, 03h mark, 04h space
 04h	BYTE	transmit baud rate index (same as receive baud rate)
 05h	BYTE	transmit bits per character (0=5 bits..3=8 bits)
 06h	BYTE	transmit stop bits
 07h	BYTE	transmit parity (same as receive parity)
 08h	BYTE	DTR state (00h off, 01h on)
 09h	BYTE	RTS state (00h off, 01h on)
 0Ah	BYTE	flow control (00h none, 01h XON/XOFF, 02h RTS/CTS, 03h both)
 0Bh	BYTE	break control (00h off, 01h on)

Format of Access Server statistics:
Offset	Size	Description	(Table 2138)
 00h	BYTE	port number
 01h	BYTE	external status signals (see #2136)
 02h	BYTE	transmitter status (see #2134)
 03h	BYTE	receiver status (see #2135)
 04h	DWORD	number of characters received
 08h	DWORD	number of characters transmitted
 0Ch	WORD	input parity errors
 0Eh	WORD	input framing errors
 10h	WORD	lost characters due to hardware overrun
 12h	WORD	lost characters due to data buffer overrun
Note:	the counts are not allowed to wrap around; once a count reaches FFFFh
	  or FFFFFFFFh, it is no longer incremented

Format of Access Server XON/XOFF characters:
Offset	Size	Description	(Table 2139)
 00h	BYTE	04h (number of bytes following)
 01h	BYTE	transmit XON character
 02h	BYTE	transmit XOFF character
 03h	BYTE	receive XON character
 04h	BYTE	receive XOFF character
--------N-2F7AFE-----------------------------
INT 2F - Novell NetWare - DOSNP.EXE - INSTALLATION CHECK
	AX = 7AFEh
Return: AL = FFh if present
	    ES = (data???) segment of DOSNP
Program: DOSNP.EXE provides "named pipes" support for DOS workstations running
	   NetWare
Note:	the NetWare shell calls this function and refuses to load if DOSNP is
	  present
SeeAlso: AX=7A90h
--------N-2F7AFFBX0000-----------------------
INT 2F - Novell NetWare - TBMI v1.1+ - INSTALLATION CHECK / Windows SUPPORT
	AX = 7AFFh
	BX = 0000h
	CX = 4E65h ("Ne")
	DX = 7457h ("tW")
	ES:DI -> Windows support procedure (see #2140)
Return: AL = FFh if installed
	    CX = configured sockets (14h)
	    DS:SI -> data table ???
	    ES:DI -> IPX far call handler
Notes:	for IPX/SPX this call reportedly returns DS:SI pointing to the table
	  of pointers to service events queue head and tail
	this function is also supported by IPXODI; v2.12 does not change DS,
	  but does set SI to an internal address
SeeAlso: AX=7AFFh/BX=0001h

(Table 2140)
Values Windows support procedure called with:
	BP = function
	    0001h Get ECB
		BX = socket number
		Return: ES:SI -> ECB or 0000h:0000h if none available
	    0002h Count Listen ECBs
		AX = BX = socket
		Return: CX = number of listen ECBs for socket
				(must be >= 2 for SPX to work)
	    0003h ???
	    0004h Inform task switcher of ECB locations
		Note:	registers other than those listed above are equal
			  to the values when IPX was called
Note:	the support function will not be called if IPX is called with BX
	  bit 15 set
--------N-2F7AFFBX0001-----------------------
INT 2F - Novell NetWare - TBMI v1.1+, shell v3.01d - INSTALLATION CHECK???
	AX = 7AFFh
	BX = 0001h
	CX = 4E65h ("Ne")
	DX = 7457h ("tW")
Return: AL = FFh if installed
	    CX = ???  (8000h)
	    SI = ??? (or -> ???) (0002h and 0007h seen)
	    ES:DI -> IPX far call handler
	    ES:DX -> 6-byte data area ???
Note:	this function is also supported by IPXODI, but IPXODI v2.12 does not
	  return ES:DX
SeeAlso: AX=7AFFh/BX=0000h
--------d-2F7F00-----------------------------
INT 2F - Jim Harper's CD-ROM redirector SCSI driver - INSTALLATION CHECK
	AX = 7F00h
Return: AL = FFh if installed
SeeAlso: AX=7F01h,AX=7F02h,AX=7F03h
--------d-2F7F01-----------------------------
INT 2F - Jim Harper's CD-ROM redirector SCSI driver - DO COMMAND
	AX = 7F01h
	DS:DX -> command record (see #2141)
Return: AL = status
	    00h successful
	    else error code
SeeAlso: AX=7F00h,AX=7F02h,INT 11/AH=FFh"SDLP",INT 21/AX=4402h"ASPI"
SeeAlso: INT 4F/AX=8100h

Format of CD-ROM redirector command record:
Offset	Size	Description	(Table 2141)
 00h	BYTE	ID
 01h 10 BYTEs	CDB (Command Descriptor Block) for operation
 0Bh	WORD	segment of buffer
 0Dh	WORD	offset of buffer
 0Fh	BYTE	status
 10h	BYTE	sense
 12h	WORD	count
--------d-2F7F02-----------------------------
INT 2F - Jim Harper's CD-ROM redirector SCSI driver - DO RESET
	AX = 7F02h
SeeAlso: AX=7F00h,AX=7F01h
--------d-2F7F03-----------------------------
INT 2F - Jim Harper's CD-ROM redirector SCSI driver - UNINSTALL
	AX = 7F03h
Return: AL = status
	    00h successful
	    01h unable to uninstall
SeeAlso: AX=7F00h
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
--------N-2F8000-----------------------------
INT 2F - EASY-NET - INSTALLATION CHECK
	AX = 8000h
Return: AL = 00h not installed
	     FFh installed
Program: EASY-NET is a shareware two-machine serial-port network
--------N-2F8000-----------------------------
INT 2F - Nanosoft, Inc. TurboNET server - INSTALLATION CHECK
	AX = 8000h
Return: AL = FFh if installed
	    BX = CS of resident code
	    CX = ??? (03FCh)
Program: TurboNET is a NetBIOS-based file redirector and server; a
	  demonstration version may be downloaded from Nanosoft's BBS
SeeAlso: AX=8100h
--------t-2F8000-----------------------------
INT 2F - CS_TSR specification - TSR INSTALLATION CHECK
	AX = 8000h
	DS:SI -> 4-byte CS_TSR signature (11h 43h 53h 10h)
Return: AL = status
	    00h no CS_TSR-compliant TSRs installed
	    01h installed, but signature did not match
	    FFh installed, signature matches
		ES:DI -> resident process block (see #2142) of last installed
			  TSR (if DS:SI pointed at signature on entry)
Program: the CS_TSR specification is a standardized TSR interface by Compact
	  Soft group in Kiev, Ukraine
Desc:	determine whether any CS_TSR-compliant TSRs are installed on the
	  selected multiplex number
Range:	AH=80h to AH=FFh
SeeAlso: AX=8001h"CS_TSR",AX=8002h"CS_TSR",AX=8003h"CS_TSR"

Format of CS_TSR process block:
Offset	Size	Description	(Table 2142)
 00h  4 BYTEs	CS_TSR signature 11h 43h 53h 10h
 04h	BYTE	INT 2F multiplex number
 05h	WORD	virtual process handle (unique among loaded TSRs)
 07h  2 BYTEs	version (binary minor version, then major version)
 09h	WORD	PSP segment of TSR
 0Bh	DWORD	pointer to ASCIZ program name
 0Fh  3 BYTEs	program creation date (day, month, year)
 12h  3 BYTEs	process start time (seconds, minutes, hours)
 15h  3 BYTEs	process start date (day, month, year)
--------F-2F8000DX0000-----------------------
INT 2F - FaxBIOS interface - INSTALLATION CHECK
	AX = 8000h
	DX = 0000h
	DI = 0000h
Return: AL = FFh if installed
	DX:DI -> signature "FaxBiosjpc"
Range:	AH=80h to AH=FFh, selected by scanning multiplex numbers for signature
SeeAlso: AH=2Ah,AX=80FBh
--------N-2F8001-----------------------------
INT 2F - Nanosoft, Inc. TurboNET server - ???
	AX = 8001h
	DS:SI -> 16-byte buffer for ???
Return: AH = status
	    00h successful
	    01h error (TurboNET busy)
Note:	makes NetBIOS calls
--------t-2F8001-----------------------------
INT 2F - CS_TSR specification - GET HANDLE (TSR-SPECIFIC INSTALLATION CHECK)
	AX = 8001h
	DS:SI -> ASCIZ signature string for desired TSR (see #2143)
Return: BX = process handle or 0000h if specified TSR not installed
	ES:DI -> process block for TSR (see #2142) if BX<>0000h
Note:	A widely-available copy of ASCII billing itself as "ASCII 2.OO by
	  Nick Zaikin Jr." is in fact a hacked copy of the Compact Soft
	  ASCII v4.23 which is identical except for the changed attribution
	  and version (in fact, some instances of "4.23" were missed); the
	  hacked copy requires the signature string
	  "ASCII 2.OO by Nick Zaikin Jr." instead of the unhacked version's
	  simple signature "ASCII"
SeeAlso: AX=8000h"CS_TSR",AX=8002h"CS_TSR"

(Table 2143)
Values for CS_TSR signature strings:
 "ASCII"	ASCII, a popup ASCII table with character input
 "Halculator"	HALC, a 32-bit RPN WYSIWIH calculator with undo and ptr support
 "AntiTurbo"	AT!, an intelligent system slow-down utility
--------t-2F8002-----------------------------
INT 2F - CS_TSR specification - GET PROCESS BLOCK BY PROCESS HANDLE
	AX = 8002h
	BX = process handle for TSR (see AX=8001h"CS_TSR")
Return: ES:DI -> process block for specified TSR (see #2142)
		unchanged if no match for process handle
Note:	This function is used to allocate a process handle when the TSR
	  installs itself, by setting ES:DI to point at something other than
	  a CS_TSR process block's signature string and iterating through the
	  possible process handles (0001h to FFFFh) until ES:DI is returned
	  unchanged
SeeAlso: AX=8000h"CS_TSR",AX=8001h"CS_TSR",AX=8003h"CS_TSR"
--------t-2F8003-----------------------------
INT 2F - CS_TSR specification - CUSTOM SUBFUNCTION
	AX = 8003h
	BX = process handle for TSR (see AX=8001h"CS_TSR")
	other registers vary by TSR
Return: vary by TSR, unchanged if not supported
Program: the CS_TSR specification is a standardized TSR interface by Compact
	  Soft group in Kiev, Ukraine
SeeAlso: AX=8000h"CS_TSR",AX=8001h"CS_TSR",AX=8002h"CS_TSR"
--------F-2F80FB-----------------------------
INT 2F - FaxBIOS interface - COMMAND SUBMISSION
	AX = 80FBh
	BX = function number (see #2144)
	DX:DI -> command buffer
		  (see #2146,#2149,#2150,#2151,#2152,#2153,#2158,#2164,#2171)
Return: AL = FFh if submitted OK
	CX = result code (see #2145)
Range:	AH=80h to AH=FFh, selected by scanning multiplex numbers for signature
SeeAlso: AX=8000h"FaxBIOS",AX=CBDDh

(Table 2144)
Values for FaxBIOS function number:
 0001h	SYS_LOGIN
 0002h	SYS_LOGOUT
 0003h	SYS_GET_FAXAPP_INFO
 0004h	STAT_IO_GET
 0005h	STAT_FAXBIOS_GET
 0006h	PDIR_OPEN
 0007h	PDIR_CLOSE (see #2154)
 0008h	PDIR_READ_PERSON (see #2155)
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
 0013h	SCHED_OPEN (see #2156)
 0014h	SCHED_ADD_DEST (see #2157)
 0015h	SCHED_ADD_FILE (see #2158)
 0016h	SCHED_SET_PARAMS (see #2159)
 0017h	SCHED_CANCEL (see #2156)
 0018h	SCHED_CLOSE (see #2160)
 0019h	SLOG_OPEN (see #2161)
 001Ah	SLOG_CLOSE (see #2161)
 001Bh	SLOG_SHORT_ENV_STAT
 001Ch	SLOG_LONG_ENV_STAT
 001Dh	SLOG_DEST_STAT
 001Eh	SLOG_FILE_STAT
 001Fh	SLOG_CANCEL_ENV
 0020h	RLOG_OPEN (see #2161)
 0021h	RLOG_CLOSE (see #2161)
 0022h	RLOG_READ
 0023h	GRAPH_GET_FILE_TYPE (see #2162)
 0024h	GRAPH_EXPORT_FILE
 0025h	GRAPH_GET_LAYOUT_INFO
 0026h	GRAPH_CREATE_FILE (see #2163)
 0027h	GRAPH_CLOSE_FILE (see #2164)
 0028h	GRAPH_CREATE_PAGE (see #2165)
 0029h	GRAPH_WRITE (see #2166)
 002Ah	GRAPH_END_PAGE
 002Bh	GRAPH_OPEN_FILE (see #2167)
 002Ch	GRAPH_GOTO_PAGE (see #2168)
 002Dh	GRAPH_READ (see #2169)
 002Eh	IOCTL_GET
 002Fh	IOCTL_SET
 0030h	IOCTL_ANSWER_FAX (see #2170)
 0031h	IOCTL_DIAL (see #2171)

(Table 2145)
Values for FaxBIOS result code:
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
 050Ah	Subject text was not an ASCIZ string
 050Bh	From text was not an ASCIZ string
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
 0617h	a graphics file to be read is empty
 0618h	GRAPH_CREATE_PAGE called before GRAPH_END_PAGE
 0619h	graph read or write attempted without goto or create
 061Ah	graph page contains no data
 061Bh	Phone Directory is already open for this client
 061Ch	schedule log is already open for this client
 061Dh	receive log is aready open for this client
 061Eh	Phone Directory function requires write mode
 0800h	denied exclusive use of the API

Format of FaxBIOS SYS_LOGIN command buffer:
Offset	Size	Description	(Table 2146)
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
 2Ch	WORD	FaxBIOS capabilities (see #2147)
 2Eh	DWORD	T.30 capabilities (see #2148)
 32h	WORD	IPC handle
 34h	DWORD	amount of memory needed to load
 38h	WORD	scope (00h for public, nonzero for private)
 3Ah  6 BYTEs	future expansion
 40h	WORD	structure size

Bitfields for FaxBIOS capabilities:
Bit(s)	Description	(Table 2147)
 0	transmit supported
 1	receive supported
 2	IOCTL supported
 3	IOCTL_DIAL supported
 4	IOCTL_ANSWER_FAX supported
 5	manual transmit supported
 6	optional phone services supported
 7	canonical phone objects
 8	seam with next supported

Bitfields for T.30 capabilities:
Bit(s)	Description	(Table 2148)
 0	low vertical resolution (minimum)
 1	high vertical resolution
 2	page width 107mm (4.21 in)
 3	page width 151mm (5.91 in)
 4	page width 215mm (8.46 in) (minimum)
 5	page width 255mm (10.04 in)
 6	page width 303mm (11.93 in)
 7	unused
 8	page length 297mm (11.69 in) (minimum)
 9	page length 364mm (14.33 in)
 10	page length 279mm (11 in)
 11	page length unlimited
 12	Group 4 resolution 300x300
 13	Group 4 resolution 400x400
 14	able to respond to poll from remote
 15	able to poll remote
 16	binary file transfer supported

Format of FaxBIOS SYS_LOGOUT command buffer:
Offset	Size	Description	(Table 2149)
 00h	WORD	structure size
 02h	WORD	function number
 04h	WORD	return code
 06h	WORD	client ID
 08h	DWORD	client tag (for client's internal use)
 0Ch  6 BYTEs	future expansion
 12h	WORD	structure size

Format of FaxBIOS SYS_GET_FAXAPP_INFO command buffer:
Offset	Size	Description	(Table 2150)
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

Format of FaxBIOS STAT_IO_GET command buffer:
Offset	Size	Description	(Table 2151)
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
 70h 104 BYTEs	remote number
 D8h 20 BYTEs	last name
 ECh 20 BYTEs	first name
100h 32 BYTEs	company name
120h 32 BYTEs	notes
140h	WORD	current envelope ID (if sending)
142h	WORD	total pages in transmission (if sending)
144h  6 BYTEs	future expansion
14h	WORD	structure size

Format of FaxBIOS STAT_FAXBIOS_GET command buffer:
Offset	Size	Description	(Table 2152)
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

Format of FaxBIOS PDIR_OPEN command buffer:
Offset	Size	Description	(Table 2153)
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

Format of FaxBIOS PDIR_CLOSE command buffer:
Offset	Size	Description	(Table 2154)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	Phone Directory handle
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size

Format of FaxBIOS PDIR_READ_PERSON command buffer:
Offset	Size	Description	(Table 2155)
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

Format of FaxBIOS SCHED_OPEN, SCHED_CANCEL command buffer:
Offset	Size	Description	(Table 2156)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	scheduler handle
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size

Format of FaxBIOS SCHED_ADD_DEST command buffer:
Offset	Size	Description	(Table 2157)
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
SeeAlso: #2158

Format of FaxBIOS SCHED_ADD_FILE command buffer:
Offset	Size	Description	(Table 2158)
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
SeeAlso: #2157,#2159

Format of FaxBIOS SCHED_SET_PARAMS command buffer:
Offset	Size	Description	(Table 2159)
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
SeeAlso: #2157,#2158,#2160

Format of FaxBIOS SCHED_CLOSE command buffer:
Offset	Size	Description	(Table 2160)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	scheduler handle
 0Eh	WORD	envelope ID generated
 10h  6 BYTEs	future expansion
 16h	WORD	structure size
SeeAlso: #2159

Format of FaxBIOS SLOG_OPEN, SLOG_CLOSE, RLOG_OPEN, RLOG_CLOSE command buffer:
Offset	Size	Description	(Table 2161)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	log handle
 0Eh	WORD	number of entries
 10h  6 BYTEs	future expansion
 16h	WORD	structure size

Format of FaxBIOS GRAPH_GET_FILE_TYPE command buffer:
Offset	Size	Description	(Table 2162)
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
SeeAlso: #2163,#2164

Format of FaxBIOS GRAPH_CREATE_FILE command buffer:
Offset	Size	Description	(Table 2163)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch 80 BYTEs	filename
 5Ch	WORD	graph handle
 5Eh  6 BYTEs	future expansion
 64h	WORD	structure size
SeeAlso: #2162,#2164,#2165

Format of FaxBIOS GRAPH_CLOSE_FILE, GRAPH_END_PAGE command buffer:
Offset	Size	Description	(Table 2164)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	graph handle
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size
SeeAlso: #2163,#2165

Format of FaxBIOS GRAPH_CREATE_PAGE command buffer:
Offset	Size	Description	(Table 2165)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	graph handle
 0Eh	WORD	resolution
 10h	WORD	page width
 12h  6 BYTEs	future expansion
 18h	WORD	structure size
SeeAlso: #2163,#2164,#2166

Format of FaxBIOS GRAPH_WRITE_PAGE command buffer:
Offset	Size	Description	(Table 2166)
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
SeeAlso: #2165,#2167

Format of FaxBIOS GRAPH_OPEN_FILE command buffer:
Offset	Size	Description	(Table 2167)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch 80 BYTEs	filename
 5Ch	WORD	file type
 5Eh	WORD	graph handle
 60h	WORD	number of pages
 62h  6 BYTEs	future expansion
 68h	WORD	structure size
SeeAlso: #2166,#2168

Format of FaxBIOS GRAPH_GOTO_PAGE command buffer:
Offset	Size	Description	(Table 2168)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	graph handle
 0Eh	WORD	page number
 10h	WORD	vertical resolution
 12h	WORD	page width
 14h	DWORD	page length
 18h  6 BYTEs	future expansion
 1Eh	WORD	structure size
SeeAlso: #2166,#2167,#2169

Format of FaxBIOS GRAPH_READ_PAGE command buffer:
Offset	Size	Description	(Table 2169)
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

Format of FaxBIOS IOCTL_ANSWER_FAX command buffer:
Offset	Size	Description	(Table 2170)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	device number
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size
SeeAlso: #2171

Format of FaxBIOS IOCTL_DIAL command buffer:
Offset	Size	Description	(Table 2171)
 00h 12 BYTEs	common data (see SYS_LOGOUT above)
 0Ch	WORD	device number
 0Eh  6 BYTEs	country code
 14h  6 BYTEs	city or area code
 1Ah 14 BYTEs	local number
 28h 14 BYTEs	extension
 36h 14 BYTEs	reserved
 4Eh  6 BYTEs	future expansion
 54h	WORD	structure size
SeeAlso: #2170
--------N-2F8100-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - INSTALLATION CHECK
	AX = 8100h
Return: AL = FFh if installed
Program: TurboNET is a NetBIOS-based file redirector and server; a
	  demonstration version may be downloaded from Nanosoft's BBS
SeeAlso: AX=8000h"TurboNET"
--------N-2F8101-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8101h
Return: AL = ???
	DL = ???
--------N-2F8102-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8102h
Return: AL = ???
	DL = ???
--------N-2F8103-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - GET MACHINE NAME???
	AX = 8103h
	ES:DI -> 17-byte buffer
Return: buffer filled
--------N-2F8104-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8104h
	BL = ???
	BH = ???
	CX = ???
	DX = ???
	DS:SI -> 16-byte buffer containing ???
Return: AL = 00h ???
--------N-2F8105-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8105h
	CX = ??? (don't change current value if 0000h)
	DX = ??? (don't change current value if 0000h)
Return: AL = 00h successful
--------s-2F8200-----------------------------
INT 2F - RESPLAY - SAMPLE/PLAYBACK
	AX = 8200h
	DX:DI -> start of sample space
	CX:BX = length in bytes
Return: AX = status (see #2172)
Program: RESPLAY is a freeware sound sampling/playback utility by Mark J. Cox
SeeAlso: AX=8201h"RESPLAY",AX=8210h

(Table 2172)
Values for RESPLAY status:
 1000h	successful
 2000h	not initialized (see AX=8210h)
 other	RESPLAY not installed
--------G-2F8200-----------------------------
INT 2F U - Nanosoft, Inc. CAPDOS - INSTALLATION CHECK
	AX = 8200h
Return: AL = FFh if installed
Program: CAPDOS is a TSR by Nanosoft, Inc. which allows INT 21h calls to be
	  captured and recorded for later analysis
SeeAlso: AX=8100h,AX=8201h"CAPDOS",AX=8202h"CAPDOS",AX=8203h"CAPDOS"
SeeAlso: AX=8204h"CAPDOS"
--------s-2F8201-----------------------------
INT 2F - RESPLAY - INSTALLATION CHECK
	AX = 8201h
Return: AX = 7746h if installed
SeeAlso: AX=8202h"RESPLAY",AX=8210h
--------G-2F8201-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - CLEAR QUEUE
	AX = 8201h
Note:	resets queue of captured INT 21 calls
SeeAlso: AX=8200h"CAPDOS"
--------s-2F8202-----------------------------
INT 2F - RESPLAY - UNINSTALL
	AX = 8202h
Return: AX = status
	    1000h successful
SeeAlso: AX=8201h"RESPLAY",AX=8210h"RESPLAY"
--------G-2F8202-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - START COLLECTION
	AX = 8202h
SeeAlso: AX=8200h"CAPDOS",AX=8203h"CAPDOS"
--------G-2F8203-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - STOP COLLECTION
	AX = 8203h
SeeAlso: AX=8200h"CAPDOS",AX=8202h"CAPDOS",AX=8204h"CAPDOS"
--------G-2F8204-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - GET QUEUE PARAMETERS
	AX = 8204h
Return: AH = flag: queue wrapped if nonzero
	BX = index of current start of queue
	CX = size of queue in entries
SeeAlso: AX=8200h"CAPDOS",AX=8202h"CAPDOS",AX=8205h"CAPDOS"
--------G-2F8205-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - GET QUEUE ITEM
	AX = 8205h
	BX = queue item number
Return: AX,BX,CX,DX,SI,DI,DS,ES as on entry to captured DOS call
SeeAlso: AX=8200h"CAPDOS",AX=8204h"CAPDOS"
--------s-2F8210-----------------------------
INT 2F - RESPLAY - INITIALIZE
	AX = 8210h
	BL = sound device number (see #2173)
	BH = sample rate in multiples of 250 Hz (14h to A0h)
	CL = direction
	    00h playback
	    01h sample
Return: AX = status (see #2172)
SeeAlso: AX=8200h"RESPLAY"

(Table 2173)
Values for RESPLAY sound device:
 00h	printer port LPT1
 01h	printer port LPT2
 02h	prototype board at I/O address 0300h
 03h	printer port (alternative LPT1)
 04h	internal speaker
----------2F86-------------------------------
INT 2F U - ???
	AH = 86h
	AL = function (at least 06h and 07h)
	???
Return: ???
Note:	called by Codeview for Windows
SeeAlso: AH=44h
--------U-2F8900-----------------------------
INT 2F - WHOA!.COM - INSTALLATION CHECK
	AX = 8900h
Return: AL = state
	    00h not installed
	    FFh installed
Program: WHOA!.COM is a system slow-down utility by Brad D Crandall
SeeAlso: AX=8901h,AX=8902h
--------U-2F8901-----------------------------
INT 2F - WHOA!.COM - UNINSTALL
	AX = 8901h
Return: AL = status
	    FDh successful
	    FEh error
SeeAlso: AX=8900h
--------U-2F8902-----------------------------
INT 2F - WHOA!.COM - SET DELAY COUNT
	AX = 8902h
	BX = delay count (larger values slow system down more)
Return: AL = status
	    FDh successful
	    FEh error
Program: WHOA!.COM is a system slow-down utility by Brad D Crandall
SeeAlso: AX=8900h
--------U-2F9000-----------------------------
INT 2F U - RAID - INSTALLATION CHECK
	AX = 9000h
Return: AL = FFh if installed
Program: RAID (Resident AID) is a TSR utility program by Ross Neilson Wentworth
	  that resides mostly in EMS
--------U-2F9001-----------------------------
INT 2F U - RAID - GET ???
	AX = 9001h
Return: DX:AX -> ???
SeeAlso: AX=9000h
--------U-2F9002-----------------------------
INT 2F U - RAID - GET RESIDENT SEGMENT
	AX = 9002h
Return: AX = segment of resident (conventional memory) portion
SeeAlso: AX=9000h
--------U-2F9003-----------------------------
INT 2F U - RAID - UNINSTALL
	AX = 9003h
Return: ???
SeeAlso: AX=9000h
--------U-2F9004-----------------------------
INT 2F U - RAID - GET ???
	AX = 9004h
Return: AX = first available paragraph past end of resident portion???
	CX destroyed
SeeAlso: AX=9000h
--------e-2F92-------------------------------
INT 2F - Network Courier E-Mail - API
	AH = 92h
	AL = function
	    00h installation check
	    01h uninstall
	    02h pop down MICRO.EXE notification window
	    03h ???
	    04h ???
	    05h ???
Return: ???
Program: The Network Courier is an electronic mail package by Consumers
	  Software of Vancouver, BC which was bought by Microsoft in 1991 and
	  renamed Microsoft Mail v3.0.
SeeAlso: AX=9400h,AX=9401h,AX=9402h,AH=9Ch
Index:	installation check;Network Courier E-Mail
Index:	uninstall;Network Courier E-Mail
--------R-2F9200-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - BUG
	AX = 9200h
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
BUG:	jumps to data because jump table entry is 0000h
Note:	DRIVEMAP returns AX=FFFFh if not a valid function number in AL
--------R-2F9201-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - CHECK IF MAPPED DRIVE
	AX = 9201h
	DL = drive number (01h = A:, etc.)
Return: AL = 92h if mapped drive
	AH may be destroyed (v8.0 DRIVEMAP returns AX=0000h if not mapped)
SeeAlso: AX=9204h,AX=920Bh
--------R-2F9202-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - UNINSTALL
	AX = 9202h
	BX = caller's CS
Return: AX = status
	    0000h failed
	    nonzero successful
SeeAlso: AX=9204h
--------R-2F9203-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET VERSION
	AX = 9203h
Return: AH = major version
	AL = minor version
	CX = segment of resident code
Note:	the DRIVEMAP included with PC Tools v8.0 is version 1.00
SeeAlso: AX=9204h,INT 16/AX=FF70h
--------R-2F9204-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - INSTALLATION CHECK
	AX = 9204h
Return: AX = 9200h if installed
	   BL = ???
	   CX = segment of resident code
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
SeeAlso: AX=9201h,AX=9202h,AX=9203h
--------R-2F9205-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - SET ???
	AX = 9205h
	BX = ??? to set
Return: CX = new value of ???
--------R-2F9206-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9206h
	???
Return: ???
--------R-2F9207-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 9207h
	???
Return: AX = ???
--------R-2F9208-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9208h
	???
Return: ???
--------R-2F9209-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9209h
	???
Return: AX = ???
	BX = ???
	CX = ???
	DX = ???
--------R-2F920A-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 920Ah
	BX = ???
Return: AX = ??? or FFFBh on error
--------R-2F920B-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - SET DRIVE MAPPING
	AX = 920Bh
	BL = drive letter (41h ['A'] = A:, etc)
	CX = ??? (0000h removes mapping)
Return: AX = ??? or FFF8h on error
SeeAlso: AX=9201h,AX=920Dh
--------R-2F920C-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 920Ch
	???
Return: AX = ??? (0002h)
	CX = ??? (0000h)
--------R-2F920D-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET DRIVE TYPE
	AX = 920Dh
	BL = drive letter (41h ['A'] = A:, etc)
Return: AX = type flags
		bit 0: ???
		bit 1: available
		bit 5: local
	BX = ???
	CX = segment of resident code (apparently an unintended side effect)
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
SeeAlso: AX=9218h,INT 16/AX=FF70h
--------R-2F920E-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - SET LPT MAPPING
	AX = 920Eh
	BX = port number (0-2)
	CX = ??? (0000h to unmap)
Return: ???
--------R-2F920F-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 920Fh
	ES:DI -> 3-byte buffer for ???
Return: CX = 0000h
	ES:DI buffer filled
--------R-2F9210-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9210h
	???
Return: ???
--------R-2F9211-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 9211h
	ES:DI -> 8-word buffer for ???
Return: CX = 0000h
	ES:DI buffer filled
--------R-2F9212-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - CRITICAL SECTION???
	AX = 9212h
	BX = phase
	    0000h leave critical section???
	    nonzero enter critical section???
--------R-2F9213-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9213h
	BX = function number (0000h-000Bh)
	???
Return: ???
--------R-2F9214-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 9214h
	ES:DI -> 6-word buffer for ???
Return: CX = 0000h
	AX = ???
	ES:DI buffer filled
--------R-2F9215-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 9215h
	ES:DI -> 100-word buffer for ???
Return: CX = 0000h
	ES:DI buffer filled
--------R-2F9216-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9216h
	ES:DI -> ???
Return: ???
--------R-2F9217-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9217h
	DS:SI -> 25-word buffer containing ???
Return: ???
--------R-2F9218-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET LPT TYPE???
	AX = 9218h
	BX = port number???
Return: AX = ???
	BX = ??? (0000h)
	CX = ??? (0000h)
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
--------R-2F9219-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9219h
	???
Return: ???
--------R-2F921A-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 921Ah
	???
Return: AH = ???
	AL = ???
	BX = ???
--------R-2F921B-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 921Bh
	???
Return: AX = ???
	CX = segment of resident code (apparently an unintended side effect)
--------R-2F921C-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 921Ch
	???
Return: ???
--------R-2F921D-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 921Dh
Return: AX = ???
--------R-2F921E-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 921Eh
	???
Return: ???
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
Note:	this function sets two variables to 24h each
SeeAlso: INT 16/AX=FF70h
--------V-2F93-------------------------------
INT 2F - InnerMission v1.7+ - INSTALLATION CHECK
	AH = 93h
	BX = CX = AX
Return: AL = state
	    FFh if installed and BX=CX=AX on entry
		BX = segment of resident code
	    01h if installed but BX or CX differ from AX (multiplex number not
		  available)
Program: InnerMission is a shareware graphical screen blanker by Kevin Stokes
SeeAlso: INT 14/AX=AA01h,INT 2F/AX=6400h
Index:	screen saver;InnerMission
--------e-2F9400-----------------------------
INT 2F - MICRO.EXE - INSTALLATION CHECK
	AX = 9400h
Return: AL = 07h or 08h if installed
Program: MICRO.EXE is a TSR of the Microsoft Mail part of Workgroup Connection
SeeAlso: AH=92h"Network Courier",AX=9401h,AX=9402h,AX=9403h,AX=9404h
SeeAlso: INT 21/AH=3Fh"WORKGRP.SYS"
--------e-2F9401-----------------------------
INT 2F - MICRO.EXE - SET ??? FLAG
	AX = 9401h
SeeAlso: AX=9400h,AX=9403h
--------e-2F9402-----------------------------
INT 2F - MICRO.EXE - ???
	AX = 9402h
	???
Return: ???
SeeAlso: AX=9400h
--------e-2F9403-----------------------------
INT 2F - MICRO.EXE - SET ??? FLAG
	AX = 9403h
SeeAlso: AX=9400h,AX=9404h
--------e-2F9404-----------------------------
INT 2F - MICRO.EXE - CLEAR ??? FLAG
	AX = 9404h
	ES:DI -> name of executable from which MICRO.EXE was started
Note:	if the specified name is identical to the name of the program file
	  from which MICRO was started, the ??? flag is cleared; otherwise,
	  it is left unchanged
SeeAlso: AX=9400h,AX=9403h
--------V-2F96C7-----------------------------
INT 2F U - STRETCH - INSTALLATION CHECK
	AX = 96C7h
Return: AX = AAAAh if installed
Program: stretch.exe is a TSR for Toshiba Laptops with WD90C24 video chip
	  to avoid blank screen areas in VGA text modes by increasing
	  inter-line spacing
--------V-2F9800-----------------------------
INT 2F U - S3RMDRV.SYS - INSTALLATION CHECK / VERSION CHECK
	AX = 9800h
	BX = function
	    0000h installation check
		Return: AX = 524Dh ('RM') if installed
	    0001h get driver version
		Return: AX = driver version (AH=major, AL=BCD minor)
Program: S3RMDRV.SYS provides support for the S3 MPEG driver FMPDRV
SeeAlso: AX=9803h
--------V-2F9803-----------------------------
INT 2F U - S3RMDRV.SYS - COPY ??? INTO USER BUFFER
	AX = 9803h
	DX:BX -> 116-byte buffer for ASCIZ ???
Return: AX = 0000h
Note:	the examined version of the driver returns CF set for any AL other
	  than 00h or 03h
SeeAlso: AX=9800h
--------e-2F9C-------------------------------
INT 2F - Network Courier E-Mail OPERATOR.EXE - API
	AH = 9Ch
	AL = subfunction
	    01h uninstall
Return: ???
Program: The Network Courier is an electronic mail package by Consumers
	  Software of Vancouver, BC which was bought by Microsoft in 1991 and
	  renamed Microsoft Mail v3.0.
SeeAlso: AH=92h
Index:	uninstall;Network Courier E-Mail OPERATOR.EXE
--------G-2F9E00-----------------------------
INT 2F U - INTMON v2.1 - INSTALLATION CHECK
	AX = 9E00h
Return: AX = FFFFh if installed
	    BX = segment of resident code
Program: INTMON is a shareware interactive interrupt monitoring TSR for 386
	  and higher machines by Celso Minnitti, Jr.
SeeAlso: AX=9E01h,AX=9E02h,AX=9E03h,AX=9F00h
--------G-2F9E01-----------------------------
INT 2F U - INTMON v2.1 - RESET
	AX = 9E01h
Return: ???
Desc:	this function specifies that INTMON should assume that any interrupts
	  on which it is currently awaiting a return have completed (i.e.
	  interrupts which never return such as INT 20 and INT 27)
SeeAlso: AX=9E00h,AX=9E03h
--------G-2F9E02-----------------------------
INT 2F U - INTMON v2.1 - DISPLAY CPU REGISTERS???
	AX = 9E02h
Return: ???
SeeAlso: AX=9E00h
--------G-2F9E03-----------------------------
INT 2F U - INTMON v2.1 - HOOK INTERRUPT???
	AX = 9E03h
	BH = interrupt number???
Return: ???
Note:	if AL > 03h on entry, INTMON 2.1 returns immediately
SeeAlso: AX=9E00h,AX=9E01h
--------G-2F9F00-----------------------------
INT 2F U - INTCFG v2.1 - INSTALLATION CHECK
	AX = 9F00h
Return: AX = FFFFh if installed
Program: INTCFG is an optionally-resident control program for INTMON by Celso
	  Minnitti, Jr.
SeeAlso: AX=9E00h,AX=9F01h,AX=9F30h,AX=9F49h
--------G-2F9F01-----------------------------
INT 2F U - INTCFG v2.1 - ???
	AX = 9F01h
	???
Return: ???
SeeAlso: AX=9F00h
--------G-2F9F30-----------------------------
INT 2F U - INTCFG v2.1 - GET ???
	AX = 9F30h
Return: AX = ??? (0002h)
SeeAlso: AX=9F00h
--------G-2F9F49-----------------------------
INT 2F U - INTCFG v2.1 - UNINSTALL
	AX = 9F49h
Return: AX,DX,DS,ES destroyed
SeeAlso: AX=9F00h
--------E-2FA1--BX0081-----------------------
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
SeeAlso: AX=ED00h,AX=FBA1h/BX=0081h,INT 15/AX=BF02h
--------m-2FA189-----------------------------
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
Program: HRAMDEV.SYS is a part of the shareware package HRAM by Biologic which
	  provides improved high memory access under MS-DOS 5.0
Note:	functions 00h and 01h use a stack of four entries; function 01h always
	  removes the values stored with the most recent function 00h call
	  which has not yet been matched with a function 01h call.
--------U-2FA4E0-----------------------------
INT 2F - Futurus Team - INSTALLATION CHECK
	AX = A4E0h
Return: AL = 52h ("R") if installed
	    AH = major version plus 30h ("0")
	    ES:BX -> ??? (INT A4 handler???)
Note:	older versions of Right Hand Man (from which Team evolved) store the
	  signature "RH" at offset 103h in the INT 2F handler's segment
SeeAlso: INT A4"Right Hand Man"
--------U-2FA900-----------------------------
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
--------U-2FA901-----------------------------
INT 2F - METZTSR.COM - GET TIME OF LAST KEYBOARD ACTIVITY
	AX = A901h
	CF set
Return: CF clear if successful
	    AX:DX = BIOS time at which INT 09 was last invoked
	CF set if not present
SeeAlso: INT 09,INT 1A/AH=00h
--------U-2FA902-----------------------------
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
--------U-2FA903-----------------------------
INT 2F - METZTSR.COM - GET METZ Ctrl-Alt-Del FLAG
	AX = A903h
	CF set
Return: CF clear if successful
	    AX = 97FFh if Ctrl-Alt-Del allowed
	    AX = 0000h if Ctrl-Alt-Del not allowed
	CF set if not resident
SeeAlso: AX=A902h
--------U-2FAA00-----------------------------
INT 2F - VIDCLOCK.COM - INSTALLATION CHECK
	AX = AA00h
Return: AL = 00h not installed
	     FFh installed
Program: VIDCLOCK.COM is a memory-resident clock by Thomas G. Hanlin III
--------f-2FAB00-----------------------------
INT 2F - Btrieve Multi-User - INSTALLATION CHECK
	AX = AB00h
Return: AL = 4Dh if installed
SeeAlso: AX=AB01h,AX=AB02h,INT 7B"Btrieve"
----------2FAB00-----------------------------
INT 2F - SRSoft MODAL PC v2+ - INSTALLATION CHECK / GET VERSION
	AX = AB00h
Return: AX = 5253h ('SR' byte-swapped) if installed
	    BX = MODAL PC version (BL = major, BH = minor)
Program: MODAL PC is an algorithm/real-system simulation package by SR Soft
	  using Petri-nets to describe simulated objects
SeeAlso: AX=AB01h"MODAL",AX=AB02h"MODAL",AX=AB06h"MODAL"
--------f-2FAB01-----------------------------
INT 2F - Btrieve Multi-User - EXECUTE Btrieve OPERATION
	AX = AB01h
	BX = process ID
	DS:DX -> 38-byte parameter record (see #3011 at INT 7B"Btrieve")
Return: AL = status
	    00h OK
	    other retry after calling INT 7F/AX=0200h
SeeAlso: AX=AB00h"Btrieve",AX=AB02h"Btrieve",INT 7B"Btrieve",INT 7F/AX=0200h
----------2FAB01-----------------------------
INT 2F - SRSoft MODAL PC v2+ - GET PROCESS RUN PARAMETER
	AX = AB01h
Return: AX = 5253h ('SR' byte-swapped) if installed
	BL = run parameter
	    00h normal process
	    01h run with tracing enabled
	    02h run initialization process (first thread of main task)
SeeAlso: AX=AB00h"MODAL",AX=AB02h"MODAL"
--------f-2FAB02-----------------------------
INT 2F - Btrieve Multi-User - GET NEW PROCESS ID
	AX = AB02h
Return: AL = 00h successful
	    BX = process ID
	AL > 00h failed, retry after calling INT 7F/AX=0200h
SeeAlso: AX=AB00h,AX=AB01h,INT 7B"Btrieve",INT 7F/AX=0200h
----------2FAB02-----------------------------
INT 2F - SRSoft MODAL PC v2+ - SET PROCESS EXIT CODE
	AX = AB02h
	BL = exit code
Return: AX = 5253h ('SR' byte-swapped) if installed
SeeAlso: AX=AB00h"MODAL",AX=AB01h"MODAL",AX=AB03h"MODAL"
----------2FAB03-----------------------------
INT 2F - SRSoft MODAL PC v2+ - ALLOCATE COMMON MEMORY
	AX = AB03h
	BX = required size of common memory for variables/semaphores in bytes
Return: AX = 5253h ('SR' byte-swapped) if installed
SeeAlso: AX=AB00h"MODAL",AX=AB02h"MODAL",AX=AB04h"MODAL"
----------2FAB04-----------------------------
INT 2F - SRSoft MODAL PC v2+ - GET ALL COMMON VARIABLES AND SEMAPHORES
	AX = AB04h
	DS:DX -> buffer for common data
Return: AX = 5253h ('SR' byte-swapped) if installed
	CF clear if successful
	CF set on error
SeeAlso: AX=AB00h"MODAL",AX=AB03h"MODAL",AX=AB05h"MODAL",AX=AB06h,AX=AB07h
----------2FAB05-----------------------------
INT 2F - SRSoft MODAL PC v2+ - SET ALL COMMON VARIABLES AND SEMAPHORES
	AX = AB05h
	DS:DX -> buffer containing common data
Return: AX = 5253h ('SR' byte-swapped) if installed
	CF clear if successful
	CF set on error
SeeAlso: AX=AB00h"MODAL",AX=AB03h"MODAL",AX=AB04h"MODAL",AX=AB06h,AX=AB07h
----------2FAB06-----------------------------
INT 2F - SRSoft MODAL PC v2+ - GET A COMMON VARIABLE OR SEMAPHORE
	AX = AB06h
	BX = offset of variable or semaphore in common memory
	CX = variable/semaphore size in bytes
	DS:DX -> buffer for variable or semaphore
Return: AX = 5253h ('SR' byte-swapped) if installed
	CF clear if successful
	CF set on error
SeeAlso: AX=AB00h"MODAL",AX=AB04h,AX=AB05h,AX=AB07h
----------2FAB07-----------------------------
INT 2F - SRSoft MODAL PC v2+ - SET A COMMON VARIABLE OR SEMAPHORE
	AX = AB07h
	BX = offset of variable or semaphore in common memory
	CX = variable/semaphore size in bytes
	DS:DX -> buffer containing variable or semaphore
Return: AX = 5253h ('SR' byte-swapped) if installed
	CF clear if successful
	CF set on error
SeeAlso: AX=AB00h"MODAL",AX=AB04h,AX=AB05h,AX=AB06h
--------V-2FAC00-----------------------------
INT 2F - DOS 4.01+ GRAPHICS.COM - INSTALLATION CHECK
	AX = AC00h
Return: AX = FFFFh
	ES:DI -> ??? (graphics data?) (not documented)
Note:	this installation check was moved here to avoid the conflict with the
	  CD-ROM extensions that occurred in DOS 4.00
SeeAlso: AX=1500h"GRAPHICS"
--------V-2FAC00DI1092-----------------------
INT 2F - QRIP/TSR - GIVE CPU TO QRIP
	AX = AC00h
	DI = 1092h
Return: nothing
Program: QRIP/TSR is a shareware TSR by Shane Hathaway implementing the Remote
	  Imaging Protocol (RIP, RIPscrip) used by several BBS systems to
	  provide a graphical user interface
Desc:	give QRIP some CPU time to update music and flashing timers
Notes:	if DI <> 1092h on entry, QRIP chains the call
	this function should be called regularly whenever the terminal program
	  is otherwise idle; the updates are automatically performed on any
	  other QRIP call
SeeAlso: AX=AC01h,AX=ACF0h
--------V-2FAC01DI1092-----------------------
INT 2F - QRIP/TSR - CHANGE INTERNAL FLAGS
	AX = AC01h
	DI = 1092h
	BX = flags to be turned on (see #2174)
	CX = flags to be turned off (see #2174)
Return: AX = 9142h if installed
	    DX = DOS-takeover flag (nonzero if QRIP able to take over DOS)
	    ---if DX nonzero---
	    BX = QRIP version number in hex (BH = major, BL = minor)
	    CX = new flags (see #2174)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC00h/DI=1092h,AX=ACF0h

Bitfields for QRIP internal flags:
Bit(s)	Description	(Table 2174)
 0	ANSI emulation enabled (default on)
 1	RIP emulation enabled (default on)
 2	graphical commands allowed (default on)
 3	TTY text allowed (default on)
 4	disable @ variables (default off in TSR mode)
 5	wait for key on RIP "end scene" command (default off)
 6	anti-stripping (default off in TSR mode)
 7	sound enabled (default on)
 8	automatic message filter (default off in TSR mode)
 9	display-only mode (no user prompts)
 10	TTY text suppression (default off in TSR mode)
 11-15	reserved
--------V-2FAC02DI1092-----------------------
INT 2F - QRIP/TSR - TURN OFF GRAPHICS SCREEN
	AX = AC02h
	DI = 1092h
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC03h,AX=ACF0h
--------V-2FAC03DI1092-----------------------
INT 2F - QRIP/TSR - TURN ON GRAPHICS SCREEN
	AX = AC03h
	DI = 1092h
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	this function does not restore the contents of the screen (see AX=AC15h)
SeeAlso: AX=AC02h,AX=AC14h,AX=AC15h
--------V-2FAC04DI1092-----------------------
INT 2F - QRIP/TSR - OUTPUT STRING THROUGH QRIP
	AX = AC04h
	DI = 1092h
	DX:BX -> string
	CX = length of string
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC05h,AX=AC09h,AX=AC0Ah,AX=ACF0h
--------V-2FAC05DI1092-----------------------
INT 2F - QRIP/TSR - OUTPUT NULL-TERMINATED STRING THROUGH QRIP
	AX = AC05h
	DI = 1092h
	DX:BX -> ASCIZ string
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC04h,AX=AC06h,AX=AC09h,AX=AC0Ah,AX=ACF0h
--------V-2FAC06DI1092-----------------------
INT 2F - QRIP/TSR - RECEIVE CHARACTERS FROM QRIP
	AX = AC06h
	DI = 1092h
Return: AX = character to send to BBS (0001h-00FFh) or special code (see #2175)
	BX = string-waiting flag
	    0001h entire string waiting to be sent to terminal (call AX=AC0Ch)
	CX = DX = AX
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC04h,AX=AC05h,AX=AC0Ch,AX=AC16h,AX=AC18h,AX=AC1Ah

(Table 2175)
Values for QRIP special codes:
 0000h	if none
 0100h	wait for user keypress (must call AX=AC16h/BL=00h or AX=AC18h)
 0101h	both/middle mouse button pressed
 0102h	entering block mode (up/download) (call AX=AC1Ah)
 0103h	right mouse button pressed
 0104h	BBS requested status bar on
 0105h	BBS requested status bar off
 0106h	BBS requested VT-102 terminal emulation
	(keypad keys should send VT-102 escape codes)
 0107h	BBS requested VT-102 mode off
 0108h	BBS requested doorway mode (raw IBM keyboard ASCII/scan code pairs)
 0109h	BBS requested doorway mode off
 010Ah	hotkey mode on
 010Bh	hotkey mode off
 010Ch	BBS requested Tab-key button changing on
 010Dh	BBS requested Tab-key mode off
 010Eh	XOFF (use flow control to stop incoming characters)
 010Fh	XON (use flow control to resume incoming characters)
 0110h-0119h BBS requested application (0-9) be run
	application 0 should be a standard text editor
 01FFh	send ASCII 00h to BBS
Note:	for special codes 0104h to 010Dh, the terminal program should report
	  any mode changes it make in response by calling AX=AC16h
--------V-2FAC07DI1092-----------------------
INT 2F - QRIP/TSR - GET FONT DIRECTORY
	AX = AC07h
	DI = 1092h
Return: DX:BX -> 80-byte internal buffer containing ASCIZ font directory name
Notes:	if DI <> 1092h on entry, QRIP chains the call
	the application may change the font directory by overwriting the
	  returned buffer, ensuring that it does not exceed 80 bytes incl. NUL
	if changed, the new path will not become effective until the graphics
	  screen is reinitialized
SeeAlso: AX=AC08h,AX=ACF0h
--------V-2FAC08DI1092-----------------------
INT 2F - QRIP/TSR - GET ICON DIRECTORY
	AX = AC08h
	DI = 1092h
Return: DX:BX -> 80-byte internal buffer containing ASCIZ icon directory name
Notes:	if DI <> 1092h on entry, QRIP chains the call
	the application may change the icon directory by overwriting the
	  returned buffer, ensuring that it does not exceed 80 bytes incl. NUL,
	  and includes a trailing backslash
	if changed, the new path becomes effective immediately
SeeAlso: AX=AC07h,AX=ACF0h
--------V-2FAC09DI1092-----------------------
INT 2F - QRIP/TSR - OUTPUT STRING THROUGH QRIP
	AX = AC09h
	DI = 1092h
	DX:BX -> string
	CX = length of string
Return: AX = character to send to BBS (0001h-00FFh) or special code (see #2175)
	BX = string-waiting flag
	    0001h entire string waiting to be sent to terminal (call AX=AC0Ch)
	CX = DX = AX
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC04h,AX=AC06h,AX=AC0Ah,AX=ACF0h
--------V-2FAC0ADI1092-----------------------
INT 2F - QRIP/TSR - OUTPUT NULL-TERMINATED STRING THROUGH QRIP
	AX = AC0Ah
	DI = 1092h
	DX:BX -> ASCIZ string
Return: AX = character to send to BBS (0001h-00FFh) or special code (see #2175)
	BX = string-waiting flag
	    0001h entire string waiting to be sent to terminal (call AX=AC0Ch)
	CX = DX = AX
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC05h,AX=AC06h,AX=AC09h,AX=ACF0h
--------V-2FAC0BDI1092-----------------------
INT 2F - QRIP/TSR - EXECUTE RIP "END SCENE" COMMAND
	AX = AC0Bh
	DI = 1092h
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	enables all mouse buttons and cancels the RIP timeout
SeeAlso: AX=AC01h,AX=AC04h,AX=ACF0h
--------V-2FAC0CDI1092-----------------------
INT 2F - QRIP/TSR - GET STRING TO BE SENT TO BBS
	AX = AC0Ch
	DI = 1092h
Return: AX = status
	    0000h nothing to be sent
	    0001h a string is waiting to be sent
		DX:BX -> string to be sent (may contain NULs)
		CX = length of string
	    0002h special code waiting (call AX=AC06h)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC06h,AX=ACF0h
--------V-2FAC0DDI1092-----------------------
INT 2F - QRIP/TSR - SET PROTECTED SCREEN AREA
	AX = AC0Dh
	DI = 1092h
	CL = number of text lines at bottom of screen to protect (00h = off)
	BL = attribute with which to fill area (bit 7 = high-int. background)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Eh,AX=AC0Fh,AX=AC10h,AX=ACF0h
--------V-2FAC0EDI1092-----------------------
INT 2F - QRIP/TSR - WRITE ASCIZ STRING IN PROTECTED AREA
	AX = AC0Eh
	DI = 1092h
	DX:BX -> ASCIZ string to be written
	CL = column at which to begin writing
	CH = row number within protected area (00h = first line)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Dh,AX=AC0Fh,AX=AC10h,AX=ACF0h
--------V-2FAC0FDI1092-----------------------
INT 2F - QRIP/TSR - SCROLL PROTECTED AREA
	AX = AC0Fh
	DI = 1092h
	BH,BL = row,column of upper-left corner in protected area
	DH,DL = row,column of lower-right corner
	CL = number of lines to scroll up
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Dh,AX=AC0Eh,AX=AC10h,AX=ACF0h
--------V-2FAC10DI1092-----------------------
INT 2F - QRIP/TSR - SET OUTPUT COLOR FOR PROTECTED AREA
	AX = AC10h
	DI = 1092h
	BL = new attribute (bit 7 set for high-intensity background)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Dh,AX=AC0Eh,AX=AC0Fh,AX=AC11h,AX=ACF0h
--------V-2FAC11DI1092-----------------------
INT 2F - QRIP/TSR - CONVERT PROTECTED AREA TO ENTIRE SCREEN
	AX = AC11h
	DI = 1092h
	BX = mode (0000h = normal protect, 0001h = allow full-screen access)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Dh,AX=AC0Eh,AX=AC0Fh,AX=AC10h,AX=AC12h,AX=ACF0h
--------V-2FAC12DI1092-----------------------
INT 2F - QRIP/TSR - BEGIN POPUP-WINDOW MODE
	AX = AC12h
	DI = 1092h
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	while popup-mode is in effect, the terminal program can write to the
	  screen (and easily restore it) by outputting a RIP file with AX=AC04h
	  or AX=AC05h
	QRIP will automatically drop out of popup-window mode if the terminal
	  program invokes RIP pick-lists
	any changes to the protected area will be restored when popup-window
	  mode is cancelled
SeeAlso: AX=AC04h,AX=AC11h,AX=AC13h,AX=ACF0h
--------V-2FAC13DI1092-----------------------
INT 2F - QRIP/TSR - END POPUP-WINDOW MODE
	AX = AC13h
	DI = 1092h
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	restores screen
SeeAlso: AX=AC12h,AX=ACF0h
--------V-2FAC14DI1092-----------------------
INT 2F - QRIP/TSR - SAVE GRAPHICS SCREEN AND SWITCH TO TEXT MODE
	AX = AC14h
	DI = 1092h
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC03h,AX=AC15h
--------V-2FAC15DI1092-----------------------
INT 2F - QRIP/TSR - RESTORE GRAPHICS SCREEN
	AX = AC15h
	DI = 1092h
Return: nothing
Desc:	restores the graphics screen saved by the last call to AX=AC14h
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC03h,AX=AC14h
--------V-2FAC16DI1092-----------------------
INT 2F - QRIP/TSR - REPORT MODE CHANGE TO QRIP
	AX = AC16h
	DI = 1092h
	BL = new mode
	    00h terminate key wait
	    01h status bar on
	    02h status bar off
	    03h VT-102 mode on
	    04h VT-102 mode off
	    05h doorway mode on
	    06h doorway mode off
	    07h hotkeys mode on
	    08h hotkeys mode off
	    09h tabkey mode on
	    0Ah tabkey mode off
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	all modes default to OFF when QRIP is first installed
--------V-2FAC17DI1092-----------------------
INT 2F - QRIP/TSR - CALL (EXECUTE) A RIP FILE
	AX = AC17h
	DI = 1092h
	DX:BX -> ASCIZ filename for RIP file to be executed
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	the specified file may be in the current icon directory, the QRIP
	  startup directory, or the current directory; any pathnames specified
	  with the filename are ignored
--------V-2FAC18DI1092-----------------------
INT 2F - QRIP/TSR - SEND USER KEY TO QRIP
	AX = AC18h
	DI = 1092h
	BX = key (00xxh is normal ASCII, xx00h is an extended key)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC06h,AX=ACF0h
--------V-2FAC19DI1092-----------------------
INT 2F - QRIP/TSR - HANGUP
	AX = AC19h
	DI = 1092h
Return: nothing
Desc:	inform QRIP that carrier has been lost
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=ACF0h
--------V-2FAC1ADI1092-----------------------
INT 2F - QRIP/TSR - GET RIP_ENTER_BLOCK_MODE INFORMATION
	AX = AC1Ah
	DI = 1092h
Return: AH = requested protocol (see #2176)
	AL = file type (see #2177)
	DX:BX -> ASCIZ filename or 0000h:0000h
	CX = length of filename
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=ACF0h

(Table 2176)
Values for QRIP protocol identifier:
 00h	Xmodem (checksum)
 01h	Xmodem-CRC
 02h	Xmodem-1K
 03h	Xmodem-1K-G
 04h	Kermit
 05h	Ymodem
 06h	Ymodem-G
 07h	Zmodem with crash recovery
 08h-0Fh same as 00h-07h, but for uploading instead of downloading
SeeAlso: #2177

(Table 2177)
Values for QRIP file type:
 00h	RIP file sequence to be displayed
 01h	RIP file sequence to be stored in icon directory
 02h	ICN file sequence to be stored in icon directory
 03h	HLP file sequence to be stored, then auto-loaded if needed
 04h	COMPOSITE DYNAMIC file sequence (batch protocols only)
 05h	ACTIVE DYNAMIC file sequence (batch protocols only)
Note:	for file types 04h and 05h, any .RIP or .ICN files are stored in
	  the icon directory; in mode 05h, any .RIP files are also played
	  back as they are received
SeeAlso: #2176
--------V-2FAC1BDI1092-----------------------
INT 2F - QRIP/TSR - SET SYSTEM FONT SIZE
	AX = AC1Bh
	DI = 1092h
	BX = font size (see #2178)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC04h,AX=ACF0h

(Table 2178)
Values for QRIP font size specifier:
 00h	8x8 font, 80x43 screen
 01h	7x8 font, 90x43 screen
 02h	8x14 font, 80x25 screen
 03h	7x14 font, 90x25 screen
 04h	16x14 font, 40x25 screen
--------V-2FACF0DI1092-----------------------
INT 2F - QRIP/TSR - INSTALLATION CHECK
	AX = ACF0h
	DI = 1092h
Return: AX = 9142h if installed
	    DX = DOS-takeover flag (nonzero if QRIP able to take over DOS)
	    ---if DX nonzero---
	    BX = QRIP version number in hex (BH = major, BL = minor)
	    CX = current flags (see AX=AC01h)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC00h/DI=1092h,AX=AC01h,AX=AC04h,AX=AC06h,AX=AC1Ah,AX=ACFFh
--------V-2FACFFDI1092-----------------------
INT 2F - QRIP/TSR - UNINSTALL
	AX = ACFFh
	DI = 1092h
Return: AX = status
	    0000h unable to remove (interrupt vector hooked by another prog)
	    0001h successful
	    0002h unable to take over DOS at this time (retry uninstall)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=ACF0h
--------V-2FAD00-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - INSTALLATION CHECK
	AX = AD00h
Return: AL = FFh if installed
	    BX = ??? (0100h for MS-DOS 3.3+)
Note:	DOS 5+ DISPLAY.SYS chains to previous handler if AL is not one of the
	  subfunctions listed here
SeeAlso: AX=AD01h"DISPLAY",AX=AD02h"DISPLAY"
--------O-2FAD00-----------------------------
INT 2F U - DR DOS 3.41-5.0, Novell DOS 7 KEYB - INSTALLATION CHECK
	AX = AD00h
Return: AX = FFFFh if installed
	flags destroyed
SeeAlso: AX=AD80h"Novell"
--------V-2FAD01-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - SET ACTIVE CODE PAGE
	AX = AD01h
	BX = new code page (see #1060 at INT 21/AX=6602h)
Return: CF clear if successful
	    AX = 0001h
	CF set on error (unsupported code page)
	    AX = 0000h
SeeAlso: AX=AD02h"DISPLAY"
--------O-2FAD01-----------------------------
INT 2F U - DR DOS 3.41,5.0 KEYB - GET CONFIGURATION
	AX = AD01h
Return: BX = current code page (see #1060 at INT 21/AX=6602h)
	CX = current keyboard layout (0100h = US, 0102h = foreign)
	ES = resident code segment
SeeAlso: AX=AD00h"KEYB",AX=AD02h"KEYB",AX=AD83h"KEYB"
--------V-2FAD02-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - GET ACTIVE CODE PAGE
	AX = AD02h
Return: CF set if code page never set
	    AX = 0001h
	    BX = FFFFh (assume first hardware code page)
	CF clear if successful
	    BX = current code page (see #1060 at INT 21/AX=6602h)
SeeAlso: AX=AD01h"DISPLAY",AX=AD03h
--------O-2FAD02-----------------------------
INT 2F U - Novell DOS 7 KEYB - ???
	AX = AD02h
	DX = ??? (0000h)
Return: AX = FFFFh if installed
	flags destroyed
SeeAlso: AX=AD01h"KEYB"
--------V-2FAD03-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - GET CODE PAGE INFORMATION
	AX = AD03h
	ES:DI -> buffer for code page information (see #2179)
	CX = size of buffer in bytes
Return: CF set if buffer too small
	CF clear if successful
	    ES:DI buffer filled
SeeAlso: AX=AD01h,AX=AD02h

Format of DOS 5.0-6.0 DISPLAY.SYS code page information:
Offset	Size	Description	(Table 2179)
 00h	WORD	number of software code pages
 02h	WORD	??? (0003h)
 04h	WORD	number of hardware code pages
 06h  N WORDs	hardware code page numbers (see #1060 at INT 21/AX=6602h)
      N WORDs	software (prepared) code pages (FFFFh if not yet prepared)
--------V-2FAD04-----------------------------
INT 2F U - DOS 4.x only DISPLAY.SYS internal - ???
	AX = AD04h
	???
Return: ???
--------V-2FAD10-----------------------------
INT 2F U - DOS 4.x DISPLAY.SYS internal - INSTALLATION CHECK???
	AX = AD10h
	???
Return: AX = FFFFh
	BX = ??? (0100h in PC-DOS 4.01)
--------V-2FAD10-----------------------------
INT 2F U - DOS 5+ DISPLAY.SYS internal - ???
	AX = AD10h
	???
Return: CF clear if successful
	CF set on error
Note:	this function is a NOP if the active code page has never been set
	  (AX=AD02h returns BX=FFFFh); its purpose otherwise is not known
--------V-2FAD40-----------------------------
INT 2F - DOS 4.0+ - ???
	AX = AD40h
	DX = ???
	???
Return: ???
Note:	called by PC-DOS 4.01 PRINT.COM
--------K-2FAD80-----------------------------
INT 2F u - MS-DOS 3.3+ KEYB.COM internal - INSTALLATION CHECK
	AX = AD80h
Return: AL = FFh if installed
	    BX = version number (BH = major, BL = minor)
	    ES:DI -> internal data (see #2180)
	    AH destroyed (set to FFh by some implementations/versions)
Notes:	MS-DOS 3.30, PC-DOS 4.01, and MS-DOS 5.00 all report version 1.00.
	this function was undocumented prior to the release of DOS 5.0
SeeAlso: AX=AD80h"Novell",AX=AD81h,AX=AD82h,AX=AD83h

Format of KEYB internal data:
Offset	Size	Description	(Table 2180)
 00h	DWORD	original INT 09
 04h	DWORD	original INT 2F
 08h  6 BYTEs	???
 0Eh	WORD	flags (see #2181)
 10h	BYTE	???
 11h	BYTE	???
 12h  4 BYTEs	???
 16h  2 BYTEs	country ID letters
 18h	WORD	current code page (see #1060 at INT 21/AX=6602h)
---DOS 3.3---
 1Ah	WORD	pointer to first item in list of code page tables???
 1Ch	WORD	pointer to ??? item in list of code page tables
 1Eh  2 BYTEs	???
 20h	WORD	pointer to key translation data (see #2183)
 22h	WORD	pointer to last item in code page table list (see #2182)
 24h  9 BYTEs	???
---DOS 4.01---
 1Ah  2 BYTEs	???
 1Ch	WORD	pointer to first item in list of code page tables???
 1Eh	WORD	pointer to ??? item in list of code page tables
 20h  2 BYTEs	???
 22h	WORD	pointer to key translation data (see #2183)
 24h	WORD	pointer to last item in code page table list (see #2182)
 26h  9 BYTEs	???
Note:	at least in MS-DOS v6.22, the signature "SHARED DATA" immediately
	  precedes this structure

Bitfields for MS-DOS v6.22 KEYB flags:
Bit(s)	Description	(Table 2181)
 15	INT 16/AH=1xh supported (INT 16h/AH=92h call returns AH<=80h)
 14	INT 16/AH=2xh supported (INT 16h/AH=A2h call returns AH<=80h)
 13	unused (0)
 12	network installed (INT 2F/AX=B800h)
 11	original IBM PC (BIOS date 1981)
 10	PC or PC/XT (BIOS machine type byte of FBh or FEh)
 9	PC Convertible (BIOS machine type byte of F9h); use INT 15/AX=4104h
 8	unused (0)
 7	IBM PS/2 model 30 (BIOS machine type byte of FAh)
 6	IBM AT (BIOS machine type FCh)
 5	IBM PS/2 (BIOS machine type F8h)
 4	PS/2 and unknown only:
	non-standard 8042 or no AT->PC scancode translation???
 3	temporary flag???
 2-0	???
SeeAlso: #2180

Format of code page table list entries:
Offset	Size	Description	(Table 2182)
 00h	WORD	pointer to next item, FFFFh = last
 02h	WORD	code page (see #1060 at INT 21/AX=6602h)
 04h  2 BYTEs	???

Format of KEYB translation data:
Offset	Size	Description	(Table 2183)
 00h	WORD	size of data in bytes, including this word
 02h N-2 BYTEs	???
--------K-2FAD80-----------------------------
INT 2F u - Novell DOS 7 KEYB.COM - INSTALLATION CHECK
	AX = AD80h
Return: AX = FFFFh if installed
	    CX = Novell DOS KEYB version number (CL = major, CH = minor)
	    DX = current keyboard codepage
	    ES:DI -> internal data and tables (ES=FFFEh if KEYB in HMA)
	flags destroyed
Note:	versions: v2.08 (original ship 4/94), v2.09 (Update 10, 11/18/94),
	  v2.10 (Update 12, 2/22/95), v2.11 (Update 13, 5/8/95),
	  v2.12 (Update 14, 7/31/95)
SeeAlso: AX=AD80h"MS-DOS"
--------K-2FAD81-----------------------------
INT 2F - DOS 3.3+ KEYB.COM - SET KEYBOARD CODE PAGE
	AX = AD81h
	BX = code page (see #1060 at INT 21/AX=6601h)
Return: CF set on error
	    AX = 0001h (code page not available)
	CF clear if successful
Notes:	called by DISPLAY.SYS
	this function was undocumented prior to the release of DOS 5.0
SeeAlso: AX=AD80h,AX=AD82h
--------K-2FAD82-----------------------------
INT 2F - DOS 3.3+ KEYB.COM - SET KEYBOARD MAPPING
	AX = AD82h
	BL = new state
	    00h US keyboard (Control-Alt-F1)
	    FFh foreign keyboard (Control-Alt-F2)
Return: CF set on error (BL not 00h or FFh)
	CF clear if successful
Note:	this function was undocumented prior to the release of DOS 5.0
SeeAlso: AX=AD80h,AX=AD81h,AX=AD83h
--------K-2FAD83-----------------------------
INT 2F - DOS 5+ KEYB.COM - GET KEYBOARD MAPPING
	AX = AD83h
Return: BL = current state
	    00h US keyboard
	    FFh foreign keyboard
SeeAlso: AX=AD82h
--------l-2FAE00-----------------------------
INT 2F U - DOS 3.3+ internal - INSTALLABLE COMMAND - INSTALLATION CHECK
	AX = AE00h
	DX = magic value FFFFh
	CH = FFh
	CL = length of command line tail (4DOS v4.0)
	DS:BX -> command line buffer (see #2184)
	DS:SI -> command name buffer (see #2185)
	DI = 0000h (4DOS v4.0)
Return: AL = FFh if this command is a TSR extension to COMMAND.COM
	AL = 00h if the command should be executed as usual
Notes:	This call provides a mechanism for TSRs to install permanent
	  extensions to the command repertoire of COMMAND.COM.	It appears
	  that COMMAND.COM makes this call before executing the current
	  command line, and does not execute it itself if the return is FFh.
	APPEND hooks this call, to allow subsequent APPEND commands to
	  execute without re-running APPEND
SeeAlso: AX=AE01h

Format of COMMAND.COM command line buffer:
Offset	Size	Description	(Table 2184)
 00h	BYTE	max length of command line, as in INT 21/AH=0Ah
 01h	BYTE	count of bytes to follow, excluding terminating 0Dh
      N BYTEs	command line text, terminated by 0Dh

Format of command name buffer:
Offset	Size	Description	(Table 2185)
 00h	BYTE	length of command name
 01h  N BYTEs	uppercased command name (blank-padded to 11 chars by 4DOS v4)
--------l-2FAE01-----------------------------
INT 2F U - DOS 3.3+ internal - INSTALLABLE COMMAND - EXECUTE
	AX = AE01h
	DX = magic value FFFFh
	CH = 00h
	CL = length of command name (4DOS v4.0)
	DS:BX -> command line buffer (see #2184)
	DS:SI -> command name buffer (see #2185)
Return: DS:SI buffer updated
	  if length byte is nonzero, the following bytes contain the uppercase
	  internal command to execute and the command line buffer contains the
	  command's parameters (the first DS:[SI] bytes are ignored)
Notes:	this call requests execution of the command which a previous call to
	  AX=AE00h indicated was resident
	APPEND hooks this call
BUG:	Novell DOS 7.0's COMMAND.COM (prior to Update 12) will attempt to run
	  a disk program with the indicated name even if the returned length
	  byte is zero, because the register used to flag this case is
	  clobbered without first checking it.	The workaround is to set the
	  command name buffer to "REM" followed by enough blanks to pad out
	  the original command's length, which will also work with MS-DOS 6.
	  (from padgett@tccslr.dnet.mmc.com)
SeeAlso: AX=AE00h
--------O-2FAF00-----------------------------
INT 2F - WinDOS v2.11 - INSTALLATION CHECK
	AX = AF00h
Return: AL = FFh if installed
Program: WinDOS is a DOS clone (claimed to be mostly MS-DOS 5.0 API compatible)
	  written by Heiko Goemann
SeeAlso: AX=AF01h"WinDOS",INT 21/AH=30h
----------2FAF00-----------------------------
INT 2F U - ???
	AX = AF00h
	???
Return: AX = 0000h if interface supported
SeeAlso: AX=AF02h,AX=AF03h,AX=AF04h,AX=AF13h,AX=AF30h
--------O-2FAF01-----------------------------
INT 2F - WinDOS v2.11 - TURN ON ONLINE MODE
	AX = AF01h
Return: nothing
Desc:	indicate that the user will not exchange floppy disks, allowing WinDOS
	  to cache disk sectors in memory and avoid writing modified sectors
	  back out to the floppy disk
SeeAlso: AX=AF00h"WinDOS",AX=AF02h"WinDOS"
--------O-2FAF02-----------------------------
INT 2F - WinDOS v2.11 - TURN OFF ONLINE MODE
	AX = AF02h
Return: nothing
Desc:	indicate that the floppy disk may be removed, and that WinDOS should
	  write all buffered sectors out to the floppy disk
SeeAlso: AX=AF00h"WinDOS",AX=AF01h"WinDOS"
----------2FAF02-----------------------------
INT 2F U - ???
	AX = AF02h
	???
Return: ES = ???
SeeAlso: AX=AF00h
--------O-2FAF03-----------------------------
INT 2F - WinDOS v2.11 - TURN VIDMEM ON
	AX = AF03h
Return: AX = status
	    0000h successful
	    0001h CPU not in mode set by DOS386=On
	    0002h video adapter in graphics mode
	    0003h memory chain corrupted
SeeAlso: AX=AF00h"WinDOS",AX=AF04h"WinDOS",AX=AF05h"WinDOS"
----------2FAF03-----------------------------
INT 2F U - ???
	AX = AF03h
	???
Return: DX = ???
SeeAlso: AX=AF00h
--------O-2FAF04-----------------------------
INT 2F - WinDOS v2.11 - TURN VIDMEM OFF
	AX = AF04h
Return: AX = status
	    0000h successful
	    0001h video memory is in use
SeeAlso: AX=AF00h"WinDOS",AX=AF03h"WinDOS",AX=AF05h"WinDOS"
----------2FAF04-----------------------------
INT 2F U - ???
	AX = AF04h
	???
Return: ???
SeeAlso: AX=AF00h
--------O-2FAF05-----------------------------
INT 2F - WinDOS v2.11 - GET VIDMEM STATE
	AX = AF05h
Return: AX = status (0000h off, 0001h on)
SeeAlso: AX=AF00h"WinDOS",AX=AF03h"WinDOS",AX=AF04h"WinDOS"
----------2FAF05-----------------------------
INT 2F U - ???
	AX = AF05h
	???
Return: ???
SeeAlso: AX=AF00h
--------O-2FAF06-----------------------------
INT 2F - WinDOS v2.11 - MAKE PROGRAM UNBREAKABLE
	AX = AF06h
	DS:DX -> break handler
	DI:BX = stack to use for break handler
Return: nothing
Desc:	set a handler which should be invoked when Ctrl-C is pressed instead of
	  aborting the program
SeeAlso: AX=AF00h"WinDOS",AX=AF0Ah"WinDOS",AX=AF0Ch"WinDOS"
--------O-2FAF07-----------------------------
INT 2F - WinDOS v2.11 - SIGNAL FATAL OVERLAY FAULT
	AX = AF07h
Return: never -- system reset
Desc:	pop up a window indicating that the system overlay file can not be
	  loaded
SeeAlso: AX=AF00h"WinDOS",AX=AF08h"WinDOS"
--------O-2FAF08-----------------------------
INT 2F - WinDOS v2.11 - SIGNAL RECOVERABLE OVERLAY FAULT
	AX = AF08h
Return: nothing
Desc:	pop up a window requesting that a disk containing SH.OVL be inserted
SeeAlso: AX=AF00h"WinDOS",AX=AF07h"WinDOS",AX=AF0Bh
--------O-2FAF09-----------------------------
INT 2F - WinDOS v2.11 - GET TERMINATED PSP
	AX = AF09h
Return: DS = PSP segment of most recently ended TSR
SeeAlso: AX=AF00h"WinDOS",AX=AF0Ah
--------O-2FAF0A-----------------------------
INT 2F - WinDOS v2.11 - GET MAIN SHELL PSP
	AX = AF0Ah
Return: AX = shell's PSP (same as DS on last call to AX=AF06h)
Desc:	get the PSP address of the last program to call AX=AF06h (normally
	  the main command interpreter)
SeeAlso: AX=AF00h"WinDOS",AX=AF06h"WinDOS",AX=AF09h
--------O-2FAF0B-----------------------------
INT 2F - WinDOS v2.11 - SIGNAL FATAL ERROR
	AX = AF0Bh
Return: never -- system reset
Desc:	pop up a window indicating a terminal system error
SeeAlso: AX=AF00h"WinDOS",AX=AF07h,AX=AF08h,AX=AF15h"WinDOS"
--------O-2FAF0C-----------------------------
INT 2F - WinDOS v2.11 - GET OTHER MAIN SHELL PARAMETERS
	AX = AF0Ch
Return: DI:AX = stack
	SI = offset of break handler
Desc:	retrieve the parameters last set by AX=AF06h (normally by the main
	  command interpreter)
SeeAlso: AX=AF00h"WinDOS",AX=AF06h"WinDOS"
--------O-2FAF0D-----------------------------
INT 2F - WinDOS v2.11 - GET CURRENT PARAMETER
	AX = AF0Dh
	BX = offset of desired parameter in global data area
Return: AX = current value of parameter (AH undefined if byte value)
SeeAlso: AX=AF00h"WinDOS",AX=AF0Eh
--------O-2FAF0E-----------------------------
INT 2F - WinDOS v2.11 - SET CURRENT PARAMETER BYTE VALUE
	AX = AF0Eh
	BX = offset of desired parameter in global data area
	DL = new value of parameter
Return: nothing
SeeAlso: AX=AF00h"WinDOS",AX=AF0Dh
--------O-2FAF0F-----------------------------
INT 2F - WinDOS v2.11 - GET HISTORY SEGMENT
	AX = AF0Fh
Return: AX = segment of buffer for input history, or 0000h if none 
SeeAlso: AX=AF00h"WinDOS",AX=AF10h"WinDOS"
--------O-2FAF10-----------------------------
INT 2F - WinDOS v2.11 - SET HISTORY SEGMENT
	AX = AF10h
	BX = segment of new buffer for input history
Return: nothing
Note:	the buffer must have been allocated with INT 21/AH=48h
SeeAlso: AX=AF00h"WinDOS",AX=AF0Fh"WinDOS"
--------O-2FAF11-----------------------------
INT 2F - WinDOS v2.11 - FREE XMS BLOCKS
	AX = AF11h
Return: nothing
Desc:	free all XMS blocks whose XMS identification value (see AX=AF12h)
	  equals the current PSP
SeeAlso: AX=AF00h"WinDOS",AX=AF12h"WinDOS",INT 21/AH=50h
--------O-2FAF12-----------------------------
INT 2F - WinDOS v2.11 - SET XMS IDENTIFICATION VALUE
	AX = AF12h
	DS = new XMS identification value (normally caller's PSP segment)
Return: nothing
SeeAlso: AX=AF00h"WinDOS",AX=AF11h"WinDOS"
----------2FAF12-----------------------------
INT 2F U - ???
	AX = AF12h
	???
Return: ES = ???
SeeAlso: AX=AF00h
--------O-2FAF13-----------------------------
INT 2F - WinDOS v2.11 - SET ASSIGN VALUE
	AX = AF13h
	BL = number of drive to remap (00h = A:)
	DL = number of drive to be accessed via drive number BL
Return: nothing
Desc:	remap a drive letter
Note:	the remapping can be canceled by specifying DL=BL
SeeAlso: AX=AF00h"WinDOS",AX=AF14h"WinDOS",AX=0601h
----------2FAF13-----------------------------
INT 2F U - ???
	AX = AF13h
	???
Return: ???
SeeAlso: AX=AF00h
--------O-2FAF14-----------------------------
INT 2F - WinDOS v2.11 - GET ASSIGN VALUE
	AX = AF14h
	BL = drive number (00h = A:)
Return: DL = drive number which is actually accessed by drive number BL
Desc:	determine the current mapping for a drive
SeeAlso: AX=AF00h"WinDOS",AX=AF13h"WinDOS",AX=0601h
--------O-2FAF15-----------------------------
INT 2F - WinDOS v2.11 - SIGNAL STACK ERROR
	AX = AF15h
Return: never -- system reset
Desc:	pop up a window indicating a stack overflow
SeeAlso: AX=AF00h"WinDOS",AX=AF0Bh"WinDOS"
--------O-2FAF16-----------------------------
INT 2F - WinDOS v2.11 - GET SIMPLE TRUENAME
	AX = AF16h
	DS:SI -> path to be canonicalized
	ES:DI -> buffer for canonicalized filename/pathname
Return: CF clear if successful
	    AX = 0000h
	CF set on error
	    AX = DOS error code (see #0980 at INT 21/AH=59h)
Desc:	partially canonicalize a path, omitting SUBST, JOIN, ASSIGN, and
	  network redirections
SeeAlso: AX=AF00h"WinDOS",INT 21/AH=60h
--------O-2FAF17-----------------------------
INT 2F - WinDOS v2.11 - QUERY FOR NEW CURRENT DRIVE
	AX = AF17h
Return: nothing
Desc:	pop up a dialog allowing the user to select a new default drive
SeeAlso: AX=AF00h"WinDOS"
--------O-2FAF18-----------------------------
INT 2F - WinDOS v2.11 - SET CTRL-C/CTRL-BREAK DISABLE FLAG
	AX = AF18h
	DL = new break-checking state (00h enabled, 01h disabled)
Return: nothing
SeeAlso: AX=AF00h"WinDOS"
--------O-2FAF19-----------------------------
INT 2F - WinDOS v2.11 - SET HEAD SETTLE FLAG
	AX = AF19h
	DL = new state
	    00h diskette head settling time reset to 15ms before each access
	    01h no additional head settling time used between accesses
Return: nothing
SeeAlso: AX=AF00h"WinDOS"
--------O-2FAF1A-----------------------------
INT 2F - WinDOS v2.11 - SEARCH FOR NON-FRAGMENTED DISK AREA
	AX = AF1Ah
	BL = drive (00h = current, 01h = A:, etc.)
	CX = number of clusters desired
Return: CF clear if successful
	    DI = first free cluster on logical drive
	    BP = first cluster of contiguous free area
	    AX destroyed
	CF set on error
	    AX = DOS error code (see #0980 at INT 21/AH=59h)
Desc:	attempt to find an area of the disk containing the specified number
	  of contiguous unallocated clusters
SeeAlso: AX=AF00h"WinDOS"
----------2FAF30-----------------------------
INT 2F U - ???
	AX = AF30h
	???
Return: ???
SeeAlso: AX=AF00h
--------d-2FAFDE-----------------------------
INT 2F - Disk-Emu - INSTALLATION CHECK / GET VERSION
	AX = AFDEh
	ES:DI -> 14-byte buffer for data (see #2186)
Return: AX = CFDEh (Carlos Fernandez Disk-Emu) if installed
	    BX = version (BH = major, BL = minor)

Format of Disk-Emu information data:
Offset	Size	Description	(Table 2186)
 00h	BYTE	number of tracks
 01h	BYTE	sectors per track
 02h	WORD	bytes per sector
 04h	BYTE	number of heads
 05h	BYTE	flag: 00h inactive, 01h active
 06h	BYTE	write protection (00h none, 01h full, 02h pseudo)
 07h	BYTE	saved (00h some unsaved data, 01h all data saved)
 08h	BYTE	disk in memory (00h no, 01h yes)
 09h	WORD	EMS handle
 0Bh	WORD	XMS handle
 0Dh	BYTE	memory type used for disk (00h XMS, 01h EMS)
--------V-2FB000-----------------------------
INT 2F - DOS 3.3+ GRAFTABL.COM - INSTALLATION CHECK
	AX = B000h
Return: AL = status
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
Notes:	called by DISPLAY.SYS
	documented for DOS 5.0, but undocumented in prior versions
SeeAlso: AX=2300h,AX=2E00h,AX=B001h
--------V-2FB001-----------------------------
INT 2F - DOS 3.3+ GRAFTABL.COM - GET GRAPHICS FONT TABLE
	AX = B001h
	DS:BX -> DWORD buffer for address of 8x8 font table
Return: buffer filled
	AL = FFh
Note:	PC-DOS 3.30/4.01 and MS-DOS 6.0 set the font table offset to 0130h,
	  MS-DOS 3.30 sets it to 0030h
SeeAlso: AH=2Eh"GRAFTABL",AX=B000h
--------I-2FB400-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - INSTALLATION CHECK
	AX = B400h
Return: AL = FFh if installed
--------I-2FB401-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - GET HOST BUFFER ADDRESS
	AX = B401h
Return: ES -> host screen buffer (PC ASCII format)
	ES unchanged if communications not started
--------I-2FB402-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B402h
	BX = ???
Return: ???
--------I-2FB403-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B403h
	???
Return: ???
--------I-2FB404-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B404h
	???
Return: ???
--------I-2FB405-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B405h
	???
Return: ???
--------f-2FB700-----------------------------
INT 2F - APPEND - INSTALLATION CHECK
	AX = B700h
Return: AL = status
	    00h not installed
	    FFh installed
Note:	MS-DOS 3.30 APPEND refuses to install itself when run inside TopView or
	  a TopView-compatible environment
SeeAlso: AX=B702h
--------f-2FB701-----------------------------
INT 2F U - APPEND v3.21 only - GET APPEND PATH
	AX = B701h
Return: ES:DI -> active APPEND path
Notes:	the only version of APPEND known to support this call is the APPEND
	  shipped with Microtek MS-DOS 3.21; MS-DOS 3.30-6.00 APPEND displays
	  "Incorrect APPEND Version" and aborts the caller
	use AX=B704h first, and only call this function if that one is not
	  supported
SeeAlso: AX=B700h,AX=B704h
--------f-2FB702-----------------------------
INT 2F - APPEND - GET VERSION
	AX = B702h
Return: AX = FFFFh if not DOS 4.0 APPEND (also if DOS 5.0 APPEND)
	AL = major version number
	AH = minor version number, otherwise
SeeAlso: AX=B700h,AX=B710h
--------f-2FB703-----------------------------
INT 2F U - DOS 3.3, DOS 5.0 APPEND - HOOK INT 21
	AX = B703h
	ES:DI -> INT 21 handler APPEND should chain to
Return: ES:DI -> APPEND's INT 21 handler
Note:	each invocation of this function toggles a flag which APPEND uses to
	  determine whether to chain to the user handler or the original
	  INT 21
SeeAlso: AX=B700h,AX=B706h
--------f-2FB704-----------------------------
INT 2F - DOS 3.3+ APPEND - GET APPEND PATH
	AX = B704h
Return: ES:DI -> active APPEND path (128 bytes max)
Note:	some versions of append do not support this call, and return ES
	  unchanged; in this case, you should call AX=B701h to get the APPEND
	  path
SeeAlso: AX=B701h
--------f-2FB706-----------------------------
INT 2F - DOS 4.0+ APPEND - GET APPEND FUNCTION STATE
	AX = B706h
Return: BX = APPEND state (see #2187)
SeeAlso: AX=B700h,AX=B707h

Bitfields for APPEND state:
Bit(s)	Description	(Table 2187)
 0	set if APPEND enabled
 1-11	reserved
 12	(DOS 5.0) set if APPEND applies directory search even if a drive has
	  been specified
 13	set if /PATH flag active
 14	set if /E flag active (environment var APPEND exists)
 15	set if /X flag active
--------f-2FB707-----------------------------
INT 2F - DOS 4.0+ APPEND - SET APPEND FUNCTION STATE
	AX = B707h
	BX = APPEND state bits (see #2187)
SeeAlso: AX=B700h,AX=B706h
--------f-2FB710-----------------------------
INT 2F U - DOS 3.3+ APPEND - GET VERSION INFO
	AX = B710h
Return: AX = current APPEND state (see #2187)
	BX = ??? (0000h in MS-DOS 3.30 and 5.00)
	CX = ??? (0000h in MS-DOS 3.30 and 5.00)
	DL = major version
	DH = minor version
SeeAlso: AX=B700h,AX=B702h
--------f-2FB711-----------------------------
INT 2F - DOS 4.0+ APPEND - SET RETURN FOUND NAME STATE
	AX = B711h
Note:	if the next INT 21h call (and ONLY the next) is function 3Dh, 43h, or
	  6Ch (also 4B03h and 4Eh if /X active), the fully qualified filename
	  is written over top of the filename passed to the INT 21h call.  The
	  application must provide a sufficiently large buffer.	 This state is
	  reset after the next INT 21h call processed by APPEND.
	APPEND uses the byte at offset 3Dh in the PSP
	  (see #0691 at INT 21/AH=26h) to store the flag telling it to
	  overwrite the filename
BUG:	DOS 4.0 APPEND reportedly overwrites DS:DX instead of DS:SI for
	  INT 21/AH=6Ch
SeeAlso: INT 21/AH=26h,INT 21/AH=4Eh
--------N-2FB800-----------------------------
INT 2F - NETWORK - INSTALLATION CHECK
	AX = B800h
Return: AL = status
	    00h	    not installed
	    nonzero installed
	      BX = installed component flags (test in this order!)
		   bit 6   server
		   bit 2   messenger
		   bit 7   receiver
		   bit 3   redirector
		   bit 1   LANPUP (LANtastic 4.0)
Notes:	this function is supported by PC LAN Program, LAN Manager, LANtastic,
	  NetWare Lite, SilverNET, 10NET, etc.
	LANtastic and NetWare Lite use only BL for the return value, preserving
	  BH; LAN Manager and DOS LAN Requester return BH=00h.	This permits
	  differentiation between those two groups by setting BH to a nonzero
	  value before the call and checking its value on return.
SeeAlso: AX=4E53h,AX=B809h
--------N-2FB800CXF041-----------------------
INT 2F - 10NET - INSTALLATION CHECK
	AX = B800h
	CX = F041h
Return: AL = status
	    00h	    not installed
	    nonzero installed
		BX = installed component flags (test in this order!)
		   bit 6   server
		   bit 2   messenger
		   bit 7   receiver
		   bit 3   redirector
		   bit 1   LANPUP (LANtastic 4.0)
		CX = 10Net data segment
		CX:DX -> 10Net Configuration Table
			  (see #0991 at INT 21/AX=5E01h"10NET")
Note:	if CX <> F041h on entry, neither CX nor DX will be changed, and this
	  call becomes identical to the standard installation check above
SeeAlso: AX=B800h"network",INT 21/AX=5E01h"10NET"
--------N-2FB803-----------------------------
INT 2F - NETWORK - GET NETWORK EVENT POST HANDLER
	AX = B803h
Return: ES:BX -> current event post handler (see AX=B804h)
Note:	this function is supported by PC LAN Program, 10NET v5.0
SeeAlso: AC=B800h,AX=B804h,AX=B903h
--------N-2FB804-----------------------------
INT 2F - NETWORK - SET NETWORK EVENT POST HANDLER
	AX = B804h
	CX = (10NET) 0370h if 10Windows is hooking post handler
	ES:BX -> new event post handler (see #2188)
Notes:	used in conjunction with AX=B803h to hook into the network event post
	  routine
	this function is supported by PC LAN Program, 10NET v5.0
	The specified handler is called on any network event.  Two events are
	  defined: message received and critical network error.
SeeAlso: AX=B800h,AX=B803h,AX=B904h

(Table 2188)
Values network post routine is called with:
	AX = 0000h single block message
	    DS:SI -> ASCIZ originator name
	    DS:DI -> ASCIZ destination name
	    ES:BX -> text header (see #2189)
	AX = 0001h start multiple message block
	    CX = block group ID
	    DS:SI -> ASCIZ originator name
	    DS:DI -> ASCIZ destination name
	AX = 0002h multiple block text
	    CX = block group ID
	    ES:BX -> text header (see #2189)
	AX = 0003h end multiple block message
	    CX = block group ID
	AX = 0004h message aborted due to error
	    CX = block group ID
	AX = 0101h server received badly formatted network request
	    Return: AX = FFFFh (PC LAN will process error)
	AX = 0102h unexpected network error
	    ES:BX -> NCB (see #2425 at INT 5C)
	AX = 0103h server received INT 24 error
	    other registers as for INT 24, except AH is in BH
	    Return: as below, but only 0000h and FFFFh allowed
Return: AX = response code
	    0000h user post routine processed message
	    0001h PC LAN will process message, but message window not displayed
	    FFFFh PC LAN will process message

Format of text header:
Offset	Size	Description	(Table 2189)
 00h	WORD	length of text (maximum 512 bytes)
 02h  N BYTEs	text of message
Note:	all CRLF sequences in message text are replaced by 14h; all other
	  values below 20h (space) are reserved
--------N-2FB807-----------------------------
INT 2F - NETWORK - GET NetBIOS NAME NUMBER OF MACHINE NAME
	AX = B807h
Return: CH = NetBIOS name number of the machine name
SeeAlso: INT 21/AX=5E00h
--------N-2FB808-----------------------------
INT 2F U - NETWORK - RELINK KEYBOARD HANDLER
	AX = B808h
	ES:BX -> INT 09 handler network should call after it finishes INT 09
Notes:	this call replaces the address to which the network software chains on
	  an INT 09 without preserving the original value.  This allows a prior
	  handler to unlink, but does not allow a new handler to be added
	  such that the network gets the INT 09 first unless the new handler
	  completely takes over INT 09 and never chains.
	this function is called by the DOS 3.2 KEYBxx.COM
SeeAlso: AX=B908h
--------N-2FB809-----------------------------
INT 2F - NETWORK - LANtastic, NetWare Lite - GET VERSION
	AX = B809h
Return: AH = major version
	AL = minor version (decimal)
Notes:	this function is supported in this form by LANtastic, NetWare Lite,
	  SilverNET, ...
	NetWare Lite returns its own version number rather than a PC LAN
	  compatibility version
SeeAlso: AX=4E53h,AX=B800h,AX=B809h"PC LAN Program"
--------N-2FB809-----------------------------
INT 2F - NETWORK - PC LAN Program - GET VERSION
	AX = B809h
Return: AH = minor version (decimal)
	AL = major version
Notes:	this function is supported in this form by PC LAN Program, LAN Manager,
	  the DOS LAN Requester, and 10NET v5.0
	10NET returns version 1.10 (AX=0A01h) for compatibility
SeeAlso: AX=4E53h,AX=B800h,AX=B809h"LANtastic"
--------N-2FB80A-----------------------------
INT 2F u - PC Network 1.00 - ???
	AX = B80Ah
	???
Return: ???
Program: PC Network is an early networking package which was renamed the
	  IBM PC Local Area Network Program (PC LAN Program) as of v1.10
Note:	called by RECEIVER (equivalent to NetWare Lite SERVER)
--------N-2FB80F-----------------------------
INT 2F - DOS LAN Requester - GET START PARAMETERS
	AX = B80Fh
	CX = size of return data buffer
	ES:DI -> return data buffer (see #2190)
Return: AX = status
	     00h     network started
	     nonzero network not started
	CX = number of bytes returned in buffer
	ES:DI buffer filled
SeeAlso: AX=B809h"PC LAN Program"

Format of DOS LAN Requester return data buffer:
Offset	Size	Description	(Table 2190)
 00h	BYTE	major version
 01h	BYTE	minor version
 02h	WORD	configuration flags given when network was started (see #2191)
 04h 15 BYTEs	NET START machine name (space padded)
 13h	BYTE	00h
 14h 9	BYTEs	NET START domain name (NULL padded)
 1Dh	BYTE	00h
 1Eh 32 BYTEs	/WRK heuristics string (space padded, not terminated)
 3Eh	WORD	/SRV value
 40h	WORD	/ASG value
 42h	WORD	/NBC value
 44h	WORD	/NBS value
 46h	WORD	/BBC value
 48h	WORD	/BBS value
 4Ah	WORD	/PBC value
 4Ch	WORD	/PBS value
 4Eh	WORD	/PFS value
 50h	WORD	/PFT value
 52h	WORD	/PWT value
 54h	WORD	/KUC value
 56h	WORD	/KST value
 58h	WORD	/NVS value
 5Ah	WORD	/NMS value
 5Ch	WORD	/NDB value
 5Eh	WORD	/MBI value
 60h	BYTE	NetBIOS name number for machine name
 61h	BYTE	NetBIOS name number for domain name
 62h	WORD	NetBIOS sessions required for configuration
 64h	WORD	NetBIOS commands required for configuration
 66h	WORD	NetBIOS names required for configuration
 68h 128 BYTEs	NET START path (LANROOT)
 E8h	BYTE	00h

Bitfields for configuration flags:
Bit(s)	Description	(Table 2191)
 0	/NVS nonzero
 1	/NMS nonzero
 2	/API
 3	/HIM
 4	/LIM
 5	/ENC
 6	/POP
 7	/EMS
 8	/RPL
 9-12	reserved
 13	RDR started
 14	RCV started
 15	User is currently logged on
--------N-2FB900-----------------------------
INT 2F - PC Network RECEIVER.COM - INSTALLATION CHECK
	AX = B900h
Return: AL = state
	    00h if not installed
	    FFh if installed
--------N-2FB901-----------------------------
INT 2F - PC Network RECEIVER.COM - GET RECEIVER.COM INT 2F HANDLER ADDRESS
	AX = B901h
Return: AL = ???
	ES:BX -> RECEIVER.COM INT 2F handler
Desc:	allows more efficient execution by letting the caller bypass any other
	  INT 2F handlers which have been added since RECEIVER.COM was
	  installed
--------N-2FB903-----------------------------
INT 2F - PC Network RECEIVER.COM - GET RECEIVER.COM POST ADDRESS
	AX = B903h
Return: ES:BX -> POST handler
SeeAlso: AX=B803h,AX=B904h
--------N-2FB904-----------------------------
INT 2F - PC Network RECEIVER.COM - SET RECEIVER.COM POST ADDRESS
	AX = B904h
	ES:BX -> new POST handler
SeeAlso: AX=B804h,AX=B903h
--------N-2FB905-----------------------------
INT 2F - PC Network RECEIVER.COM - GET FILENAME
	AX = B905h
	DS:BX -> 128-byte buffer for filename 1
	DS:DX -> 128-byte buffer for filename 2
Return: buffers filled from RECEIVER.COM internal buffers
Note:	use of filenames is unknown, but one appears to be for storing messages
SeeAlso: AX=B906h
--------N-2FB906-----------------------------
INT 2F - PC Network RECEIVER.COM - SET FILENAME
	AX = B906h
	DS:BX -> 128-byte buffer for filename 1
	DS:DX -> 128-byte buffer for filename 2
Return: RECEIVER.COM internal buffers filled from user buffers
Note:	use of filenames is unknown, but one appears to be for storing messages
SeeAlso: AX=B905h
--------N-2FB908-----------------------------
INT 2F - PC Network RECEIVER.COM - UNLINK KEYBOARD HANDLER
	AX = B908h
	ES:BX -> INT 09 handler RECEIVER should call after it finishes INT 09
Note:	this call replaces the address to which RECEIVER.COM chains on an
	  INT 09 without preserving the original value.	 This allows a prior
	  handler to unlink, but does not allow a new handler to be added
	  such that RECEIVER gets the INT 09 first.
SeeAlso: AX=B808h
--------V-2FBC00-----------------------------
INT 2F - Windows 3.0, DOS 5+ EGA.SYS - INSTALLATION CHECK
	AX = BC00h
Return: AL = state
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
		BX = 5456h ("TV")
Range:	AH=80h to AH=FFh, selected by commandline switch
SeeAlso: AX=BC06h"EGA",INT 10/AH=FAh"EGA"
--------s-2FBC00BX3F3F-----------------------
INT 2F - MediaVision MVSOUND.SYS - INSTALLATION CHECK
	AX = BC00h
	BX = 3F3Fh ('??')
	CX = 0000h
	DX = 0000h
Return: if installed, BX XOR CX XOR DX = 4D56h ('MV')
Program: MVSOUND.SYS is a driver for the MediaVision ProAudio Spectrum family
	  of sound boards; its primary programmer was Bryan Crane
SeeAlso: AX=BC01h"MVSOUND",AX=BC02h,AX=BC03h,AX=BC04h,AX=BC06h"MVSOUND"
--------s-2FBC01-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET VERSION
	AX = BC01h
	BX = magic value 6D20h ('m ')
	CX = magic value 2076h (' v')
	DX = magic value 2020h ('  ')
Return: BX = ASCII major version (leading zeros significant)
	CX = ASCII minor version (leading zeros significant)
SeeAlso: AX=BC00h/BX=3F3Fh
--------s-2FBC02-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET STATE TABLE POINTER
	AX = BC02h
Return: BX:DX -> state table
SeeAlso: AX=BC00h/BX=3F3Fh,AX=BC03h
--------s-2FBC03-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET FUNCTION TABLE POINTER
	AX = BC03h
Return: BX:DX -> function table
SeeAlso: AX=BC00h/BX=3F3Fh,AX=BC02h
--------s-2FBC04-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET DMA AND IRQ CHANNELS
	AX = BC04h
Return: AX = 4D56h ('MV')
	BL = DMA channel
	CL = IRQ number
SeeAlso: AX=BC00h/BX=3F3Fh,AX=BC01h"MVSOUND"
--------V-2FBC06-----------------------------
INT 2F U - MS Windows 3.0, DOS 5+ EGA.SYS - GET VERSION INFO
	AX = BC06h
Return: BX = 5456h ("TV")
	CH = major version
	CL = minor version
	DL = revision
SeeAlso: AX=BC00h"EGA",INT 10/AH=FAh"EGA"
--------s-2FBC06-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET STATUS STRING
	AX = BC06h
Return: AX = 4D56h ('MV')
	DX:BX -> status string (first byte 0Ch if no status message to display)
SeeAlso: AX=BC00h/BX=3F3Fh,AX=BC01h"MVSOUND",AX=BC0Bh"MVSOUND"
--------s-2FBC0B-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET EXECUTABLE PATH
	AX = BC0Bh
Return: BX:DX -> ASCIZ path for MVPROAS.EXE, 0000h:0000h if not available
SeeAlso: AX=BC00h/BX=3F3Fh
--------U-2FBE00-----------------------------
INT 2F - REDVIEW - INSTALLATION CHECK
	AX = BE00h
Return: AL = FFh if installed
Program: REDVIEW is a public-domain TSR by Alexandr Novy and Petr Horak which
	  copies data sent to standard output to standard error when the
	  former has been redirected to a file, thus allowing the data to
	  be seen on the screen at the same time it is captured in a file
--------N-2FBF00-----------------------------
INT 2F - PC LAN PROGRAM REDIRIFS.EXE internal - INSTALLATION CHECK
	AX = BF00h
Return: AL = FFh if installed
--------N-2FBF01-----------------------------
INT 2F U - PC LAN PROGRAM REDIRIFS.EXE internal - ???
	AX = BF01h
	???
Return: ???
--------N-2FBF80-----------------------------
INT 2F - PC LAN PROG REDIR.SYS internal - SET REDIRIFS ENTRY POINT
	AX = BF80h
	ES:DI -> FAR entry point to IFS handler in REDIRIFS
Return: AL = FFh if installed
	    ES:DI -> internal workspace
Note:	all future IFS calls to REDIR.SYS are passed to the ES:DI entry point
--------F-2FC0-------------------------------
INT 2F - MTEZ XpressFax Hardware TSR (CLASS2) - API
	AH = C0h
	AL = function code (01h to 15h)
Return: ???
SeeAlso: AX=C000h/BX=444Bh,AX=CB00h/BX=4D53h
--------N-2FC000-----------------------------
INT 2F - Novell ODI Link Support Layer (LSL.COM) - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    DX:BX -> FAR entry point (see #2192,#2193,#2194)
	    ES:SI -> signature string "LINKSUP$"
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	on return, ES = DX for LSL v1.10 and v2.05; LSL makes use of this in
	  its search for a previous installation
SeeAlso: AX=5100h,AX=C000h"NESL"

(Table 2192)
Call LSL function "Request MLID Registration" with:
	BX = 0001h
	ES:SI -> registration??? record (see #2196)
	DS:DI -> buffer for LSL information block (see #2197)
Return: AX = completion code (0000h,8001h) (see #2195)
	DS:DI buffer filled if successful
	BX,CX corrupted
Note:	see "Novell LAN Driver Developer's Guide, Volume III" for more details

(Table 2193)
Call LSL function "get support entry points" with:
	BX = 0002h
	ES:SI -> buffer for entry point record (see #2198)
Return: ES:SI buffer filled

(Table 2194)
Call LSL function "Request MLID API entry point" with:
	BX = 0003h
Return: ES:SI -> MLID (Multiple Link Interface Driver) API entry point
		(call with BX=function 00h-10h, not range-checked)
Note:	LSL v1.10 and v2.05 execute BX=0003h for BX=0000h and any BX >= 0003h

(Table 2195)
Values for LSL completion code:
 0000h	successful
 8001h	out of resources
 8002h	bad parameter
 8003h	no more items
 8004h	item not present
 8005h	failed
 8006h	receive overflow
 8007h	canceled
 8008h	bad command
 8009h	duplicate entry
 800Ah	no such handler
 800Bh	no such driver

Format of LSL registration record:
Offset	Size	Description	(Table 2196)
 00h	DWORD	-> ??? FAR function (to be called with ES:SI -> ??? and
		  returning AX = completion code)
 04h	DWORD	-> ???
 08h	DWORD	-> ??? data (at least 3Eh bytes)

Format of LSL information block:
Offset	Size	Description	(Table 2197)
 00h	DWORD	-> ??? entry point (called with BX=function 00h-11h)
 04h	WORD	???
 06h	WORD	???
Note:	due to a fencepost error, LSL v2.05 (distributed with Novell DOS 7)
	  will crash if the above entry point is called with BX=0012h

Format of entry point record:
Offset	Size	Description	(Table 2198)
 00h	DWORD	pointer to protocol support entry point in LSL (see #2199)
 04h	DWORD	pointer to general support entry point in LSL (see #2200)

(Table 2199)
Call protocol support entry point with:
	BX = function number
	    0000h ???
	    0001h ???
	    0002h ???
	    0003h "ScheduleAESEvent"
		ES:SI -> AES ECB to be scheduled (see #2203)
		Return: ES,SI preserved
	    0004h "CancelAESEvent"
		ES:SI -> ECB to be cancelled (see #2203)
		Return: ES,SI preserved
	    0005h "GetIntervalMarker"
		Return: DX:AX = current interval marker in milliseconds
			all other registers preserved
	    0006h "RegisterStack"
		AX = logical board number
		ES:SI -> bound stack info structure (see #2213)
		Return: BX = assigned Stack ID if AX=0000h
	    0007h "DeRegisterStack"
		AX = protocol stack's assigned Stack ID
	    0008h "RegisterDefaultStack"
		AX = logical board number
		ES:SI -> stack info structure (see #2214)
	    0009h "DeRegisterDefaultStack"
		AX = logical board number
	    000Ah "RegisterPrescanStack"
		AX = logical board number
		ES:SI -> stack info structure (see #2214)
	    000Bh "DeRegisterPrescanStack"
		AX = logical board number
	    000Ch "SendPacket"
		ES:SI -> send ECB
		Return: interrupts disabled
	    000Dh ???
	    000Eh ???
	    000Fh ???
	    0010h "GetStackIDFromName"
		ES:SI -> counted NUL-terminated protocol name (max 15 chars)
		Return: BX = Stack ID if AX=0000h
	    0011h "GetPIDFromStackIDBoard"
		AX = Stack ID for protocol
		CX = logical board number
		ES:SI -> 6-byte buffer for protocol ID
	    0012h "GetMLIDControlEntry"
		AX = logical board number
		Return: ES:SI -> MLID control handler (see #2201) if AX=0000h
	    0013h "GetProtocolControlEntry"
		AX = Stack ID or
			FFFEh Prescan stack
			    CX = logical board number
			FFFFh default protocol
			    CX = logical board number
		Return: ES:SI -> protocol stack control entry point if AX=0000h
				  (see #2202)
	    0014h "GetLSLStatistics"
		Return: AX = 0000h (successful)
			ZF set
			ES:SI -> LSL statistics table (see #2205)
	    0015h "BindStack"
		AX = protocol stack's assigned Stack ID
		CX = logical board number
	    0016h "UnbindStack"
		AX = protocol stack's assigned Stack ID
		CX = logical board number
	    0017h "AddProtocolID"
		AX = frame type ID code
		ES:SI -> 6-byte protocol ID
		CX:DI -> counted NUL-terminated short protocol name (max 15 ch)
	    0018h "RelinquishControl"
		Return: after LSL performs any necessary background processing
	    0019h "GetLSLConfiguration"
		Return: AX = 0000h (successful)
			ZF set
			ES:SI -> LSL configuration table (see #2204)
	    001Ah "GetTickMarker"
		Return: AX = number of 55ms ticks since LSL loaded
			BX destroyed
Return: AX = completion code (see #2195)
	ZF set if successful
	SS:SP, DS, BP preserved; most other registers may be destroyed

(Table 2200)
Call general support entry point with:
	BX = function number
	    0000h "Allocate Memory" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0001h "Free Memory" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0002h "Realloc Memory" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0003h "Memory Statistics" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0004h "Add Memory To Pool" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0005h "AddGeneralService"
		ES:SI -> General Service Control Block (see #2215)
	    0006h "RemoveGeneralService"
		ES:SI -> General Service Control Block (see #2215)
	    0007h "GetNETcfgPath"
		Return: AX = 0000h (successful)
			DS:DX -> ASCIZ pathname for NET.CFG
	    0008h U ???	 (in LSL 1.10)
		Return: AX = 0000h
			ES:SI -> ??? (a 22-byte data area)
	    000Ah "GetCriticalSectionStatus"
		Return: BX = total outstanding calls to "StartCriticalSection"
	    000Bh "ServiceEvents"
		interrupts disabled
		Return: interrupts disabled
	    0010h "GetStackECB"
		DS:DI -> Lookahead structure (see #2216)
		interrupts disabled
		Return: ES:SI -> ECB if successful (AX=0000h,ZF set)
			interrupts disabled
	    8000h-FFFFh reserved for user general service providers
Return: AX = completion code (see #2195)
	ZF set if successful
	SS:SP, DS, BP preserved

(Table 2201)
Call MLID control handler with:
	AX = logical board number
	BX = function number
	    0000h "GetMLIDConfiguration"
		Return: ES:SI -> MLID's configuration table if successful
				  (see #2208 for format)
	    0001h "GetMLIDStatistics"
		Return: ES:SI -> MLID's statistics table if successful
				  (see #2208 for format)
	    0002h "AddMulticastAddress"
		ES:SI -> 6-byte multicast address to add
	    0003h "DeleteMulticastAddress"
		ES:SI -> 6-byte multicast address to delete
	    0005h "MLIDShutdown"
		CX = type
		    0000h permanent (also deregisters from LSL)
		    other temporary (shutdown hardware only)
	    0006h "MLIDReset" reinitialize board / restart from temp shutdown
	    0007h "Create Connection" (obsolete?)
		???
	    0008h "Delete Connection" (obsolete?)
		???
	    0009h "SetLookAheadSize"
		CX = requested lookahead size (00h-80h)
	    000Ah "PromiscuousChange"
		CX = what to receive promiscuously
		    bit 0: MAC frames
		    bit 1: non-MAC frames
	    000Bh "RegisterReceiveMonitor"
		CX = subfunction
		    0000h disable receive monitoring
		    else  enable receive monitoring
		ES:SI -> monitor receive routine
		ES:DI -> monitor transmit routine
	    000Ch "Driver Poll" (obsolete?)
		???
Return: AX = completion code (see #2195)
	ZF set if successful
Note:	not all boards/MLIDs support function 0010h; see bit 13 in the MLID
	  mode flags field of the MLID's configuration table

(Table 2202)
Call protocol stack control entry point with:
	BX = function number
	    0000h "GetProtocolStackConfiguration"
		Return: ES:SI -> protocol stack's configuration table
				   (see #2207)
	    0001h "GetProtocolStackStatistics"
		Return: ES:SI -> protocol stack's statistics table (see #2206)
	    0002h "BindToMLID"
		CX = board number to bind to
		ES:SI -> implementation-dependant parameter string
	    0003h "UnBindFromMLID"
		CX = board number from which protocol should unbind
		ES:SI -> optional implementation-dependant parameter string
	    0004h "MLIDDeRegistered"
		CX = board number that has de-registered from LSL
Return: AX = status
	    0000h successful
	    else implementation-dependant error codes
	ZF set if successful
	SS:SP, DS, BP preserved

Format of AES ECB:
Offset	Size	Description	(Table 2203)
 00h	DWORD	"AESLink" pointer used by LSL for list management
 04h	DWORD	number of milliseconds to wait
 08h	DWORD	"AESStatus" (is set to 00000000h when AES ESR is invoked)
 0Ch	DWORD	-> function to be invoked when time expires
		ES:SI will point to this structure on entry,
		DS, BP, and SS:SP must be preserved.
SeeAlso: #2217

Format of LSL Configuration Table:
Offset	Size	Description	(Table 2204)
 00h	BYTE	major version of configuration table
 01h	BYTE	minor version of configuration table (decimal, 0-99)
 02h  8 BYTEs	reserved
 0Ah	BYTE	LSL major version (decimal)
 0Bh	BYTE	LSL minor version (decimal, 0-99)
---LSL 1.0x ---
 0Ch 14 BYTEs	reserved
---LSL 1.10+ ---
 0Ch	WORD	maximum number of boards which LSL can handle
 0Eh	WORD	maximum number of protocol IDs which LSL can handle
 10h 12 BYTEs	reserved

Format of LSL Statistics Table:
Offset	Size	Description	(Table 2205)
 00h	BYTE	major version of statistics table format
 01h	BYTE	minor version of statistics table format (decimal, 0-99)
 02h	WORD	"GenericCounters" number of counters in static portion of
		  table
 04h	DWORD	"ValidCountersMask" bit mask indicating which generic
		  counters are actually used.  Bit 31 = TotalTxPackets, bit 30
		  is the next field, etc.
 08h	DWORD	"TotalTxPackets" total SendPacket requests made
 0Ch	DWORD	reserved
 10h	DWORD	reserved
 14h	DWORD	"AESEventsCount" number of completed AES events
 18h	DWORD	"PostponedEvents" number of events postponed due to critical
		  sections inside the MLIDs
 1Ch	DWORD	"CancelAESFailures" number of times CancelAESEvent failed
 20h	DWORD	reserved
 24h	DWORD	reserved
 28h	DWORD	"TotalRxPackets" total number of GetStackECB requests
 2Ch	DWORD	"UnclaimedPackets" total number of packets not consumed by a
		  protocol stack
 30h	WORD	"NumberCustom" number of custom variables that follow
 32h  N DWORDs	custom counters
      N DWORDs	-> CustomCounterStrN (one per custom counter)
	var	length-prepended and NULL terminated string for Counter 0
	...
	var	length-prepended and NULL terminated string for Counter N-1
SeeAlso: #2206,#2212

Format of Protocol Stack Statistics Table:
Offset	Size	Description	(Table 2206)
 00h	BYTE	statistics table major version
 01h	BYTE	statistics table minor version (decimal, 0-99)
 02h	WORD	number of generic counters following
 04h	DWORD	"ValidCountersMask" (bitmask, bit 31 is TotalTxPackets)
 08h	DWORD	TotalTxPackets
 0Ch	DWORD	TotalRxPackets
 10h	DWORD	IgnoredRxPackets
 14h	WORD	number of custom counters
 16h  N DWORDs	custom counters
      N DWORDs	-> CustomCounterStrN (one per custom counter)
	var	length-prepended and NULL terminated string for Counter 0
	...
	var	length-prepended and NULL terminated string for Counter N-1
SeeAlso: #2205,#2212

Format of Protocol Stack Configuration Table:
Offset	Size	Description	(Table 2207)
 00h	BYTE	configuration table major version
 01h	BYTE	configuration table minor version (decimal, 0-99)
 02h	DWORD	-> counted NUL-terminated long descriptive name for protocol
 06h	DWORD	-> counted NUL-terminated short name for protocol (15 chars)
 0Ah	BYTE	protocol stack major version
 0Bh	BYTE	protocol stack minor version (decimal, 0-99)
 0Ch 16 BYTEs	reserved for future use

Format of MLID Configuration Table:
Offset	Size	Description	(Table 2208)
 00h 26 BYTEs	signature 'HardwareDriverMLID	     ' (8 spaces on end)
 1Ah	BYTE	configuration table major version
 1Bh	BYTE	configuration table minor version (decimal, 0-99)
 1Ch  6 BYTEs	node address
 22h	WORD	MLID mode flags (see #2209)
 24h	WORD	board number
 26h	WORD	board instance (if more than one of same board installed)
 28h	WORD	maximum packet size
 2Ah	WORD	BestDataSize
 2Ch	WORD	WorstDataSize
 2Eh	DWORD	-> counted NUL-terminated long name for NIC
 32h	DWORD	-> counted NUL-terminated short name for NIC (8 chars max)
 36h	DWORD	-> counted NUL-terminated Frame and Media type
 3Ah	WORD	reserved (0000h)
 3Ch	WORD	frame type ID
 3Eh	WORD	TransportTime (milliseconds)
 40h	DWORD	-> SourceRouteHandler for TokenRing. (Used by ROUTE.COM)
 44h	WORD	lookahead size
 46h	WORD	line speed (Mbps if high bit clear, else Kbps)
 48h	WORD	QueueDepth
 4Ah  6 BYTEs	reserved (0)
 50h	BYTE	driver major version
 51h	BYTE	driver minor version (decimal, 0-99)
 52h	WORD	bus/multicast flags (see #2210)
 54h	WORD	send retries
 56h	DWORD	ConfigTableLink
 5Ah	WORD	MLID sharing flags (see #2211)
 5Ch	WORD	slot number
 5Eh	WORD	I/O address 1
 60h	WORD	I/O range 1
 62h	WORD	I/O address 2
 64h	WORD	I/O range 2
 66h	DWORD	memory address 1
 6Ah	WORD	memory size 1
 6Ch	DWORD	memory address 2
 70h	WORD	memory size 2
 72h	BYTE	interrupt line 1
 73h	BYTE	interrupt line 2
 74h	BYTE	DMA line 1
 75h	BYTE	DMA line 2

Bitfields for MLID mode flags:
Bit(s)	Description	(Table 2209)
 15	MLID supports Octet Reversal
 14	node address is non-canonical
 13	promiscuous mode is supported
 12-8	reserved
 7	LDataSize field in LookAhead structure supported
 6	raw send supported
 5	MLID needs to be polled by LSL
 4	reserved (0)
 3	multicasting is supported
 2	not currently used by DOS ODI, set to 0.
 1	network card uses DMA.
 0	RealDriverBit, always set to 1.

Bitfields for bus/multicast flags:
Bit(s)	Description	(Table 2210)
 10-9	specialized multicast support
	00 = Group addressing is default for medium
	01 = Invalid
	10 = Filter group address in MLID.
	11 = Adapter filters group address.
 2	supports Micro Channel cards
 1	supports ISA cards
 0	supports EISA cards

Bitfields for MLID sharing flags:
Bit(s)	Description	(Table 2211)
 8	NIC can share DMA2
 7	NIC can share DMA1
 6	NIC can share IRQ2
 5	NIC can share IRQ1
 4	NIC can share Memory2
 3	NIC can share Memory1
 2	NIC can share IO2
 1	NIC can share IO1
 0	MLID is currently shut down

Format of MLID Statistics Table:
Offset	Size	Description	(Table 2212)
 00h	BYTE	driver statistics table major version
 01h	BYTE	driver statistics table minor version (decimal, 0-99)
 02h	WORD	number of generic counters (typically 13)
 04h	DWORD	"ValidCountersMask" (bit mask, bit 31 is TotalTxCount)
 08h	DWORD	TotalTxCount
 0Ch	DWORD	TotalRxCount
 10h	DWORD	NoECBAvailableCount
 14h	DWORD	TxTooBigCount
 18h	DWORD	TxTooSmallCount
 1Ch	DWORD	RxOverflowCount
 20h	DWORD	RxTooBigCount
 24h	DWORD	RxTooSmallCount
 28h	DWORD	TxMiscCount
 2Ch	DWORD	RxMiscCount
 30h	DWORD	TxRetryCount
 34h	DWORD	RxChecksumErrorCount
 38h	DWORD	RxMismatchCount
 3Ch	WORD	number of custom counters
 3Eh  N DWORDs	custom counters
      N DWORDs	-> CustomCounterStrN (one per custom counter)
	var	length-prepended and NULL terminated string for Counter 0
	...
	var	length-prepended and NULL terminated string for Counter N-1
SeeAlso: #2205,#2206

Format of bound stack info structure:
Offset	Size	Description	(Table 2213)
 00h	DWORD	-> protocol stack's short name (counted, NUL-terminated)
 04h	DWORD	-> receive handler
 08h	DWORD	-> control handler

Format of stack info structure:
Offset	Size	Description	(Table 2214)
 00h	DWORD	-> receive handler
 04h	DWORD	-> control handler

Format of General Service Control Block:
Offset	Size	Description	(Table 2215)
 00h	DWORD	-> next GSCB (maintained internally by LSL)
 04h	DWORD	-> entry point for general service handler
 08h	WORD	command code for this general service (8000h-FFFFh)
Note:	the control block must not be altered or deallocated until the general
	  service is removed

Format of Lookahead structure:
Offset	Size	Description	(Table 2216)
 00h	DWORD	-> Media header
 04h	DWORD	-> lookahead buffer
 08h	WORD	length of lookahead buffer
 0Ah  6 BYTEs	protocol ID
 10h	WORD	logical board number
 12h	WORD	lookahead size

Format of ODI ECB:
Offset	Size	Description	(Table 2217)
 00h	DWORD	link to next ECB
 04h	DWORD	link to previous ECB
 08h	WORD	general status
		0000h received successfully
		8006h packet overflow
		8007h reception aborted (data not valid)
 0Ah	DWORD	-> event service routine or RETF (never 0000h:0000h)(see #2218)
 0Eh	WORD	protocol stack identifier
 10h  6 BYTEs	protocol ID (sending only)
 16h	WORD	MLID board number (sending only)
 18h  6 BYTEs	MAC destination address
 1Eh  4 BYTEs	driver workspace
 22h  4 BYTEs	protocol workspace
 26h	WORD	total length of sent buffer
 28h	WORD	fragment count
 2Ah  2 WORDs	segment,offset of first fragment buffer
 2Eh	WORD	length of first fragment buffer
	...
SeeAlso: #2203

(Table 2218)
Values event service routine is called with:
	ES:SI -> associated ODI ECB (see #2217)
	interrupts disabled
Return: DS,BP,SS,SP preserved
	interrupt disabled
Notes:	the service routine may invoke any IPX/ODI function except CloseSocket
	it is safe to send a packet and wait for completion if enough stack
	  space is available
--------N-2FC000-----------------------------
INT 2F - Novell NetWare Event Service Layer (NESL) 1.0 - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    DX:BX -> FAR entry point (see #2219,#2220,#2221,#2222,#2223,#2224)
	    ES:SI -> signature string "NESL_EVENTS"
Program: NESL is a generic interface for event handling in ODI drivers and
	  other NetWare-oriented modules.  Primarily intended to support
	  power management and "hot swapping" of PCMCIA cards, but it is not
	  limited to this.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"Link Support Layer",AX=C000h"NETWARN"

(Table 2219)
Call NESL function GetNESLConfigPointer with:
	BX = 0000h
Return: AX = completion code (0000h,8008h) (see #2225)
	ES:SI -> NESL configuration table if successful (see #2226)
	BP,DS,STACK preserved
Desc:	Obtain a pointer to the NESL Configuration Table
SeeAlso: #2220,#2223

(Table 2220)
Call NESL function RegisterEventProducer with:
	BX = 0001h
	ES:SI -> Producer Event Control Block (PECB) (see #2227)
Return: AX = completion code (0000h, 8005h, 8008h) (see #2225)
	ES:SI -> still points to PECB
	BP,DS,STACK preserved
Desc:	Allows a module to register as a producer of a given event class
Note:	PECB_ClassName and PECB_Flags must be filled in on entry
SeeAlso: #2093,#2221,#2222,#2223

(Table 2221)
Call NESL function DeRegisterEventProducer with:
	BX = 0002h
	ES:SI -> PECB previously passed to RegisterEventProducer (see #2227)
Return: AX = completion code (0000h, 8002h, 8008h) (see #2225)
	ES:SI -> still points to PECB
	BP,DS,STACK preserved
Desc:	Allows a module to de-register as a producer of a given event class
SeeAlso: #2220,#2224

(Table 2222)
Call NESL function EventNotification with:
	BX = 0003h
	ES:SI -> PECB previously registered (see #2227)
Return: AX = completion code (0h, 8005h, 8008h) (see #2225)
	ES:SI -> still points to PECB
	BP,DS,STACK preserved
Desc:	Allows a module to signal that an event has just occurred in a given
	  event class.
Notes:	Once called, NESL will generate corresponding callouts for this
	  event, as described in Table #2229.
	on entry, the PECB_DataPtr must point at an Event Parameter Block (EPB)
	  (see #2230) filled in to match the desired event
SeeAlso: #2220

(Table 2223)
Call NESL function RegisterEventConsumer with:
	BX = 0004h
	ES:SI -> Consumer Event Control Block (CECB) (see #2228)
Return: AX = completion code (0h, 8005h, 8008h) (see #2225)
	ES:SI -> still points to CECB
	BP,DS,STACK preserved
Desc:	Allows a module to register as a consumer of a given event class
Note:	on entry, the CECB_ClassName, CECB_NotifProc and CECB_OSILevel must be
	  filled in.
SeeAlso: #2220,#2224

(Table 2224)
Call NESL function DeRegisterEventConsumer with:
	BX = 0005h
	ES:SI -> CECB previously passed to RegisterEventConsumer (see #2228)
Return: AX = completion code (0h, 8002h, 8008h) (see #2225)
	ES:SI -> still points to CECB
	BP,DS,STACK preserved
Desc:	Allows a module to de-register as a consumer of a given event class
SeeAlso: #2221,#2223

(Table 2225)
Values for NESL Error code:
 0000h	Successful
 8002h	Bad Parameter
 8005h	Fail
 8008h	Bad Command

Format of NESL Configuration Table:
Offset	Size	Description	(Table 2226)
 00h	WORD	NESL_Cfg_MajVer	 Major Version of this table (=1)
 02h	WORD	NESL_Cfg_MinVer	 Minor Version of this table (=0)
 04h	DWORD	NESL_Cfg_ModLName   -> ASCIZ long name of NESL module
		(typically -> "NetWare Event Service Layer for 16-Bit DOS")
 08h	DWORD	NESL_Cfg_ModSName   -> ASCIZ short name of NESL module
		(typically -> "NESL")
 0Ch	WORD	NESL_Cfg_ModMajVer  Major Version of NESL itself (=1)
 0Eh	WORD	NESL_Cfg_ModMinVer  Minor Version of NESL itself (=0)

Format of NESL Producer Event Control Block (PECB):
Offset	Size	Description	(Table 2227)
 00h	WORD	PECB_MajVer  Major Version of this structure (=1)
 02h	WORD	PECB_MinVer  Minor Version of this structure (=0)
 04h	DWORD	PECB_NextProducer   -> next PECB.  NULL if last.
 08h	DWORD	PECB_ClassName	    -> ASCIZ string identifying event
					  class (see #2231)
 0Ch	DWORD	PECB_ConsumerList   -> list of consumers for this event class
 10h	DWORD	PECB_DataPtr	    -> points to additional data during events
 14h	DWORD	PECB_Flags
		Bit 0	=0  consumers should be called "top down" for this
			    event class.  (OSI level 7 down to OSI level 1)
			=1  consumers should be called "bottom up"
		Bits 1-31   Reserved =0
 18h  8 BYTEs	PECB_Reserved (all zeros)
Note:	Although the event producer provides the memory for the PECB, the
	  NESL module controls this memory until the event class is
	  de-registered.
	While owned by NESL, this structure should be treated as read-only,
	  except for the PECB_DataPtr field.

Format of NESL Consumer Event Control Block (CECB):
Offset	Size	Description	(Table 2228)
 00h	WORD	CECB_MajVer  Major Version of this structure (=1)
 02h	WORD	CECB_MinVer  Minor Version of this structure (=0)
 04h	DWORD	CECB_NextConsumer   -> next CECB.  NULL if last.
 08h	DWORD	CECB_ClassName	    -> ASCIZ string identifying event
					  class (see #2231)
 0Ch	DWORD	CECB_NotifProc	    -> FAR CALL event handler (see #2229)
 10h	WORD	CECB_OSILevel
		Bits 4-7 = OSI Layer of this module (1 through 7)
		Bits 0-3 = relative ordering with other modules on same layer
 13h 14 BYTEs	CECB_Reserved (all zeros)
Note:	Although the event consumer provides the memory for the CECB, the
	  NESL module controls this memory until the consumer is de-registered.
	While owned by NESL, this structure should be treated as read-only,

(Table 2229)
Values NESL Consumer Notification Procedure is called with:
	ES:SI -> Event Parameter Block (EPB) (see #2230)
Return: AX = completion code (0000h, 8005h) (see #2225)
	ES:SI -> still points to EPB
Desc:	Called by NESL to notify the consumer when an event has occurred in
	  an event class for which it has registered.
SeeAlso: #2228

Format of NESL Event Parameter Block (EPB):
Offset	Size	Description	(Table 2230)
 00h	WORD	EPB_MajVer  Major Version of this structure (=1)
 02h	WORD	EPB_MinVer  Minor Version of this structure (=0)
 04h	DWORD	EPB_ClassName  -> ASCIZ string identifying event class
				  (see #2231)
 08h	DWORD	EPB_EventName  -> ASCIZ string identifying event within
				  class (see #2232)
 0Ch	DWORD	EPB_ModuleName -> ASCIZ string identifying module
				  producing event
 10h	DWORD	EPB_DataPtr0   -> event-defined data or NULL if not used
 14h	DWORD	EPB_DataPtr1   -> event-defined data or NULL if not used
 18h  8 BYTEs	EPB_Reserved (all zeros)

(Table 2231)
Values for NESL Event Class Names:
 Event Class		Description
 -------------------	-----------------------------------------
 Service Suspend	Suspension of a service.  Called top-down.
 Service Resume		Resumption/availability of a service. Called bottom-up.
 Service/Status Change	Change in status or level of service.  Called top-down.
 Suspend Request	Request to suspend a service.  Called bottom-up.
Note:	Contact Novell Labs to register new event classes.

(Table 2232)
Values for NESL Event Names:
 Event Name			Class		    Description
 --------------------------	-------------	    ---------------------------
 MLID Cable Disconnect		Service Suspend	    Cable disconnected from NIC
 MLID Card Removal		Service Suspend	    PCMCIA card removed
 MLID Hardware Failure		Service Suspend	    Serious hardware
							  failure in NIC
 MLID Not In Range		Service Suspend	    Wireless access point
							  is out of range
 MLID Shutdown			Service Suspend	    MLID was shut down
 MLID Media Access Denied	Service Suspend	    Access to physical
							  medium unsuccessful
 MLID Cable Reconnect		Service Resume	    Cable re-connected to NIC
 MLID Card Insertion Complete	Service Resume	    PCMCIA card inserted
 MLID In Range			Service Resume	    Wireless access point
							  in range
 MLID Reset			Service Resume	    MLID was just reset
 MLID Access Point Change	Serv/Status Change  Station has moved to
							  new access point
 MLID Speed Change		Serv/Status Change  Change in communic. speed
Note:	Contact Novell Labs to register new event names.
	For all predefined events above, EPB_DataPtr0 (see #2230) points
	  to the MLID Configuration table (see AX=C000h"ODI") for the
	  affected MLID.
--------N-2FC000-----------------------------
INT 2F - Novell NetWare Connect NETWARN - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    SI = segment of resident portion
Program: NETWARN is a utility supplied with NetWare Connect to warn a
	  remote dialup user when programs are about to be loaded slowly over
	  the modem link.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	on return, verify that it is NETWARN responding by examining signature
	  at in NETWARN's data table in the resident segment (see #2233)
SeeAlso: AX=C000h"ODI",AX=C000h"NESL"

Format of NETWARN Configuration structure:
Offset	Size	Description	(Table 2233)
 103h 7 BYTEs	signature string "NETWARN"
 10Ah	BYTE	major version in ASCII (="1")
 10Bh	BYTE	minor version in ASCII (="0")
 10Ch	DWORD	minimum size of EXE cared about in bytes (/S=xxxx)
 110h	WORD	same value in kilobytes (see 0113h, bit 4 below)
 112h	BYTE	multiplex code (AH value) actually being used
 113h	WORD	options (see #2234)
 115h	DWORD	INT 21h vector before NETWARN loaded
 119h	DWORD	INT 2Fh vector before NETWARN loaded
 11Dh 16 BYTEs	ASCIIZ local name of last device which was checked
 12Dh 128 BYTEs ASCIIZ remote name of last device which was checked
Note:	the specified offsets are from the start of the resident segment

Bitfields for NETWARN options:
Bit(s)	Description	(Table 2234)
 0	??? (=0)
 1	/U (Unload) selected (never in resident)
 2	/E (Enabled) Will trap & check EXEC's
 3	/D (Disabled) No EXEC checking done
 4	/S (Size) was set (see 010Ch, 0110h above)
 5	/P (Path shown)
 6	/H or /? (Help) (never in resident)
SeeAlso: #2233
--------f-2FC000-----------------------------
INT 2F - FN32 32 character filename utilities - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	   ES:DI -> signature string "FN32 32CHAR TSR"
Program: FN32 is a TSR which supports 32 character filenames under PC/MS-DOS
Note:	the TSR intercepts INT 21 calls and performs filename substitution by
	  managing dictionary files in each directory which contains long
	  filenames
--------M-2FC000-----------------------------
INT 2F - QMR - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    ES:DI -> signature string "QMR1!"
Program: QMR (Cove Software, Quick Mouse Reset) monitors the mouse
	  service interrupt (int 33h) and substitutes a fast software
	  reset (mouse fn 21h) for the slow hardware reset (mouse fn 0).
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C001h"QMR",AX=C002h"QMR",AX=C003h"QMR"
--------V-2FC000-----------------------------
INT 2F - VGAsave v1.93 - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    BX = segment of resident code
Program: VGAsave is a freeware VGA-specific, mouse-aware screenblanker by Bill
	  Javurek
Range:	AH=C0h to AH=FFh, selected by scanning for a free multiplex number
Note:	the transient portion of VGAsave compares the first 38 bytes of the
	  resident code (addressed through BX) against its own copy of the
	  resident code to complete the installation check
SeeAlso: INT 14/AX=AA01h,INT 2F/AH=93h
Index:	screen saver;VGAsave
--------V-2FC000-----------------------------
INT 2F - AD-DOS - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    BX = 4144h ('AD')
	    CX = 2D44h ('-D')
	    DX = 4F53h ('OS')
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C001h,AX=C003h,AX=C005h,AX=C007h,AX=C009h,AX=C020h,INT 14/AX=AA01h
Index:	screen saver;AD-DOS
--------U-2FC000-----------------------------
INT 2F U - WANG_ER.COM - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    ES = segment of resident code
Program: WANG_ER is a TSR from Compaq which permits Compaq systems equipped
	  with 3-mode floppy drives to read Wang document diskettes
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	The installation check is completed by comparing the resident code
	  with the copy in the transient program
--------i-2FC000-----------------------------
INT 2F O - ASPIHOOK.SYS - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if multiplex number in use
	    ES:DI -> ASCIZ signature "ASPIHOOK" if ASPIHOOK.SYS installed
Program: ASPIHOOK is a device driver for monitoring SCSI activity through an
	  ASPI host manager; it is part of the Personal Measure system
	  activity monitor from Spirit of Performance, Inc.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"PMEASURE"
--------i-2FC000-----------------------------
INT 2F - PMEASURE.EXE - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if multiplex number in use
	    ES:DI -> ASCIZ signature "PMEASURE.EXE" if PMEASURE.EXE installed
Program: PMEASURE.EXE is a TSR for monitoring system hardware activity which
	  is part of the Personal Measure system activity monitor from Spirit
	  of Performance, Inc.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	If a Personal Measure Hook Module, such as ASPIHOOK.SYS, is already
	  installed, PMEASURE.EXE uses the next highest free multiplex number.
SeeAlso: AX=C000h"ASPIHOOK",AX=C000h"PERSONAL MEASURE"
--------i-2FC000-----------------------------
INT 2F - PERSONAL MEASURE - HOOK MODULE INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	ES:DI -> signature string "PMEASUREHOOK"
	AX = C000 if not installed, per mux id conventions
	DH = major release number (binary)
	DL = minor release number (binary)
Program: The Personal Measure system activity monitor from Spirit of
	  Performance, Inc. uses an extensible series of modules to hook
	  into various operating system interfaces and monitor system calls.
	  Current hook modules are ASPIHOOK.SYS for ASPI device activity
	  and CDRHOOK.SYS for non-ASPI CD-ROM activity.	 All hook modules
	  share the same mux id.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"PMEASURE.EXE",AX=C001h"PERSONAL MEASURE"
--------c-2FC000-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    SI = signature value 20D6h
	    DI = signature value 8761h
	    ES:BX -> configuration table (see #2235)
	    CX = ??? (0300h)
	    DX = ??? (0020h)
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=0100h/SI=20D6h,AX=C001h"PCACHE"

Format of PrintCache configuration table:
Offset	Size	Description	(Table 2235)
 00h 26 BYTEs	ASCIZ signature string "TORQ Configuration Table: "
 1Ah  2 BYTEs	???
 1Ch	DWORD	-> data table (see #2236)
 20h  4 BYTEs	ASCIZ version string ("3.1" for v3.1)
 24h  5 BYTEs	???
 29h 12 BYTEs	ASCIZ version date string ("Aug 31 1993" for v3.1)
 35h	WORD	buffered port type (01h = LPT, 02h = COM)
 37h	WORD	buffered port BIOS port number
 39h  5 BYTEs	ASCIZ buffered port name ("LPTn" or "COMn")
 3Eh	WORD	physical port type (01h = LPT, 02h = COM)
 40h	WORD	physical port BIOS port number
 42h  5 BYTEs	ASCIZ physical port name ("LPTn" or "COMn")
 47h	BYTE	port driver IRQ
 48h 21 BYTEs	???
 5Dh	WORD	buffer size in K
 5Fh 27 BYTEs	???
 7Ah	BYTE	popup hotkey shift states (see #0477 at INT 16/AH=02h)
 7Bh	BYTE	popup hotkey scan code (see #0005 at INT 09h"IRQ1")
 7Ch  4 BYTEs	???
 80h 20 BYTEs	ASCIZ printer type name
	???

Format of PrintCache data table:
Offset	Size	Description	(Table 2236)
 00h  2 BYTEs	???
 02h	DWORD	-> ??? entry point
	???
--------U-2FC000-----------------------------
INT 2F - Frank Kintrup TSR Utilities - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    BX = program ID (see #2237)
	    CX = 464Bh (signature "FK")
	    DX = revision number (DH = major, DL = minor)
	    ES = resident segment of TSR
Range:	AH=C0h to AH=FFh, selected by searching for a free multiplex number
SeeAlso: AX=C001h"Kintrup",AX=C002h"Kintrup"

(Table 2237)
Values for Frank Kintrup TSR program ID:
 4153h	"AS"	ASCII.COM	ASCII table with paste function
 434Ch	"CL"	CLOCK.COM	clock with date/time display and alarm
 5043h	"PC"	PCALC.COM	programmer's calculator with paste function
 5343h	"SC"	SCRSAVE.COM	screen saver with mouse support and hotkey
 5544h	"UD"	UNDEL.COM	undelete program like SMARTCAN or DPROTECT
--------K-2FC000-----------------------------
INT 2F U - HP 100LX/200LX - PUSHKEYS - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if possibly installed
Range:	AH=C0h to AH=FFh, selected by scanning for signature with AL=AEh
SeeAlso: AX=C001h"HP 100LX",AX=C0AEh"HP 100LX",AX=C0AFh"HP 100LX"
--------V-2FC000-----------------------------
INT 2F - DIMWIT - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    ES:DI -> signature string "DIMDOS" or "DIMWIN"
Program: DIMWIT is a freeware Windows-aware screen blanker by Larry Board
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"AD-DOS",AX=C001h"DIMWIT"
Index:	screen saver;DIMWIT
--------F-2FC000BX444B-----------------------
INT 2F - MTEZ XpressFax Hardware TSR (CLASS2) - INSTALLATION CHECK
	AX = C000h
	BX = 444Bh ('DK')
	CX = 4A4Eh ('AN')
Return: AL = status
	    00h not installed, OK to install
	    FFh installed
		BX = 646Bh ('dk')
		CX = 6A6Eh ('an')
Range:	AH=C0h to AH=FFh, selected automatically
SeeAlso: AH=C0h"MTEZ"
--------V-2FC000-----------------------------
INT 2F U - TSENGP.COM - INSTALLATION CHECK
	AX = C000h
Return: AL = status
	    00h not installed, OK to install
	    FFh installed
		DS = segment of resident code
Program: TSENGP.COM is a TSR supplied by Compaq to fix an incompatibility
	  between some applications and Tseng ET4000-based video adapters
Range:	AH=C0h to AH=FFh, selected automatically
Note:	the installation check is completed by comparing the first eleven
	  bytes at DS:005Fh against the TSR's code (80h FCh 06h 74h 0Ah
	  80h FCh 07h 74h 05h EAh)
--------N-2FC000-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if one of the components is installed
	CX:BX -> signature within LLRA component:
	    "TSI_LapLinkCore" for LLRA1.EXE
	    "TSI_Blackbird"   for LLRA2.EXE
	    "TSI_Redirector"  for LLRA3.EXE
	    "TSI_Compression" for LLRA4.EXE
	DL = major version number
	DH = minor version number
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	LapLink components are installed in the order listed above, but not
	  necessarily all four; each gets its own multiplex number (default
	  C0h-C3h)
SeeAlso: AX=C002h"LapLink",AX=C205h"LapLink",AX=C2F0h"LapLink"
SeeAlso: AX=C2F1h"LapLink",AX=C301h"LapLink",AX=C3F0h"LapLink"
SeeAlso: AX=C3F1h"LapLink"
--------M-2FC001-----------------------------
INT 2F - QMR - REQUEST HARDWARE RESET
	AX = C001h
Return: ES = QMR code segment
	AL destroyed
Desc:	this function is used to force a full mouse reset when QMR is installed
SeeAlso: AX=C000h"QMR",AX=C002h"QMR"
--------V-2FC001-----------------------------
INT 2F - DIMWIT - GET CONFIGURATION DATA
	AX = C001h
Return: ES:DI -> TSR configuration data (see #2238)
Program: DIMWIT is a freeware Windows-aware screen blanker by Larry Board
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"DIMWIT",AX=C001h"AD-DOS"
Index:	screen saver;DIMWIT

Format of DIMWIT TSR configuration data:
Offset	Size	Description	(Table 2238)
 00h	WORD	blanking delay in clock ticks
 02h	BYTE	instant-blanking hotkey scan code (see #0005)
		Ctrl and Alt must also be pressed
--------V-2FC001ES0000-----------------------
INT 2F - AD-DOS - GET RESIDENT CODE SEGMENT
	AX = C001h
	ES = 0000h
Return: AL = 00h if successful
	    ES = AD-DOS TSR Code Segment
SeeAlso: AX=C000h"AD-DOS",AX=C001h"DIMWIT"
Index:	screen saver;AD-DOS
--------c-2FC001-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ENTRY POINTS
	AX = C001h
Return: AL = FFh if installed
	    ES:BX -> ???
	    ES:DX -> ???
	    ES:SI -> ???
	    ES:DI -> ??? (equivalent to AX=C002h)
SeeAlso: AX=C000h"PCACHE",AX=C002h"PCACHE"
--------U-2FC001-----------------------------
INT 2F - Frank Kintrup TSR Utilities - CLOCK - DISABLE DISPLAY UPDATE
	AX = C001h
Range:	AH=C0h to AH=FFh, selected by searching for a free multiplex number
SeeAlso: AX=C000h"Kintrup",AX=C002h"Kintrup"
--------K-2FC001CX03FB-----------------------
INT 2F U - HP 100LX/200LX - PUSHKEYS - INTERNAL - UNINSTALL
	AX = C001h
	CX = 03FBh return address to continue uninstall if possible
Return: program uninstalled
Range:	AH=C0h to AH=FFh, selected by scanning for signature with AL=AEh
SeeAlso: AX=C000h"HP 100LX",AX=C0AEh"HP 100LX",AX=C0AFh"HP 100LX"
--------i-2FC001-----------------------------
INT 2F - PERSONAL MEASURE - PASS PARAMETERS TO HOOK MODULE(S)
	AX = C001h
	DX = segment of PMEASURE.EXE or 0000h
	BX = offset in PMEASURE.EXE or 0000h
	CX = offset in PMEASURE.EXE or 0000h
Return: None
Program: PMEASURE.EXE is a TSR for monitoring system hardware activity which
	  is part of the Personal Measure system activity monitor from Spirit
	  of Performance, Inc.	PMEASURE uses this call to inform its hook
	  modules whether or not it is running and to pass information about
	  shared data and procedures.
Warning: This information documents a function that is private to Personal
	  Measure and is provided as information only.	It should NOT be called
	  by any software other than Personal Measure.
SeeAlso: AX=C000h"PERSONAL MEASURE HOOK MODULE"
--------V-2FC002-----------------------------
INT 2F - AD-DOS - CHECK FOR NEW INPUT
	AX = C002h
Return: AL = 00h if successful
	    BX = status
		0000h no input since last check
		0001h new input available
Note:	this call also resets the new-input flag
SeeAlso: AX=C000h"AD-DOS",AX=C004h
Index:	screen saver;AD-DOS
--------M-2FC002-----------------------------
INT 2F - QMR - DISABLE QMR
	AX = C002h
Return: ES = QMR code segment
	AL destroyed
Desc:	this call temporarily disables QMR
SeeAlso: AX=C000h"QMR",AX=C003h"QMR"
--------c-2FC002-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET BUFFER SIZE
	AX = C002h
Return: AX = ??? in K
	BX = size of print buffer in K
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
SeeAlso: AX=C000h"PCACHE"
--------U-2FC002-----------------------------
INT 2F - Frank Kintrup TSR Utilities - CLOCK - ENABLE DISPLAY UPDATE
	AX = C002h
Range:	AH=C0h to AH=FFh, selected by searching for a free multiplex number
SeeAlso: AX=C000h"Kintrup",AX=C002h"Kintrup"
--------N-2FC002-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Core - ???
	AX = C002h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C2F0h"LapLink"
SeeAlso: AX=C2F1h"LapLink",AX=C301h"LapLink"
--------V-2FC003-----------------------------
INT 2F - AD-DOS - SET MINUTES TO WAIT
	AX = C003h
	BX = minutes to wait before blanking screen
Return: AL = 00h if successful
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	this call also resets the delay timer
SeeAlso: AX=C000h"AD-DOS",AX=C004h
Index:	screen saver;AD-DOS
--------M-2FC003-----------------------------
INT 2F - QMR - ENABLE QMR
	AX = C003h
Return: ES = QMR code segment
	AL destroyed
Desc:	this call enables QMR after it has been disabled
SeeAlso: AX=C000h"QMR",AX=C002h"QMR"
--------c-2FC003-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - SET ??? FLAG
	AX = C003h
Return: BX destroyed
SeeAlso: AX=C004h"PCACHE"
--------V-2FC004-----------------------------
INT 2F - AD-DOS - GET MINUTES TO WAIT
	AX = C004h
Return: AL = 00h if successful
	    BX = minutes to wait before blanking screen
SeeAlso: AX=C000h"AD-DOS",AX=C003h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC004-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - CLEAR ??? FLAG
	AX = C004h
Return: BX destroyed
SeeAlso: AX=C003h"PCACHE"
--------V-2FC005-----------------------------
INT 2F - AD-DOS - SET BLANKER STATUS
	AX = C005h
	BX = new state (0000h inactive, 0001h active) (default 0001h)
Return: AL = 00h if successful
SeeAlso: AX=C006h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC005-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C005h
	???
Return: BX destroyed
	???
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE"
--------V-2FC006-----------------------------
INT 2F - AD-DOS - GET BLANKER STATUS
	AX = C006h
Return: AL = 00h if successful
	    BX = current state of screen blanker (0000h inactive, 0001h active)
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"AD-DOS",AX=C005h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC006-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C006h
	???
Return: BX destroyed
	???
Note:	this function appears to be identical to AX=C007h
SeeAlso: AX=C000h"PCACHE",AX=C007h"PCACHE"
--------V-2FC007-----------------------------
INT 2F - AD-DOS - SET HOT KEY
	AX = C007h
	BX = hot key
	CL = hot key shift status
Return: AL = 00h if successful
SeeAlso: AX=C008h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC007-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C007h
	???
Return: BX destroyed
	???
Note:	this function appears to be identical to AX=C006h
SeeAlso: AX=C000h"PCACHE",AX=C006h"PCACHE"
--------V-2FC008-----------------------------
INT 2F - AD-DOS - GET CURRENT HOT KEY
	AX = C008h
Return: AX = status
	    0000h successful
		BX = Hot Key
		CL = Hot Key Shift Status
	    0008h otherwise
SeeAlso: AX=C000h"AD-DOS",AX=C007h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC008-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - CLEAR ??? FLAG
	AX = C008h
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C009h"PCACHE"
--------V-2FC009-----------------------------
INT 2F - AD-DOS - UNBLANK MONITOR
	AX = C009h
Return: AL = 00h if successful
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	this function works by simulating keyboard activity
Index:	screen saver;AD-DOS
--------c-2FC009-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - SET ??? FLAG
	AX = C009h
Return: BX destroyed
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE",AX=C008h"PCACHE"
--------V-2FC00A-----------------------------
INT 2F - AD-DOS - ???
	AX = C00Ah
Return: AX = status
	    0000h successful
		BH = ??
		BL = ??
	    000Ah failed
Index:	screen saver;AD-DOS
--------c-2FC00A-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C00Ah
	???
Return: AH = bit flags
	    bit 5: ???
	AL = bit flags
	    bit 4: ???
	    bit 3: ???
	BX destroyed
	???
SeeAlso: AX=C000h"PCACHE"
--------V-2FC00B-----------------------------
INT 2F - AD-DOS - ???
	AX = C00Bh
Return: AX = status
	    0000h successful
	    000Bh failed
Index:	screen saver;AD-DOS
--------c-2FC00B-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - NOP
	AX = C00Bh
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE"
--------V-2FC00C-----------------------------
INT 2F - AD-DOS - SET ??? INTERNAL FLAG TO 01h
	AX = C00Ch
Return: AX = status
	    0000h successful
	    000Ch failed
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Index:	screen saver;AD-DOS
--------c-2FC00C-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ???
	AX = C00Ch
Return: AX = ??? (0000h)
	BX = ??? (0000h)
	CX = ??? (0100h)
	DL = ???
	DH = ???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC00D-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - SET ???
	AX = C00Dh
	DL = ???
Return: BX destroyed
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE"
--------V-2FC00E-----------------------------
INT 2F - AD-DOS - SET PASSWORD STATUS
	AX = C00Eh
	BX = new state (0000h disabled, 0001h enabled)
Return: ???
SeeAlso: AX=C000h"AD-DOS",AX=C00Fh"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC00E-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - INSTALL ???
	AX = C00Eh
	ES:DX -> ???
Return: BX destroyed
Note:	ES:DX is stored internally if the variable is currently 0000h:0000h,
	  but ignored if already set; a counter is incremented
SeeAlso: AX=C000h"PCACHE",AX=C00Fh"PCACHE"
--------V-2FC00F-----------------------------
INT 2F - AD-DOS - GET PASSWORD STATUS
	AX = C00Fh
Return: BX = current state (0000h disabled, 0001h enabled)
SeeAlso: AX=C00Eh"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC00F-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - REMOVE ???
	AX = C00Fh
Return: BX destroyed
Note:	this function decrements the counter used by AX=C00Eh, and clears the
	  internal pointer variable to 0000h:0000h when it reaches zero
SeeAlso: AX=C000h"PCACHE",AX=C00Eh"PCACHE"
--------c-2FC010-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ???
	AX = C010h
	CX = index of ??? table (00h-02h, others treated as 00h)
	SI = offset into data table
Return:	AL = byte at specified offset into table
	BX destroyed
SeeAlso: AX=C000h"PCACHE"
--------c-2FC011-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ???
	AX = C011h
Return: AX = ??? (0007h)
	BX = ??? (0001h)
	CH = ???
	CL = ???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC012-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ???
	AX = C012h
Return: AX = ???
	BX = ???
	CX = ???
	DX = ???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC013-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C013h
	???
Return: BX destroyed
	???
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE"
--------c-2FC014-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C014h
	???
Return: BX destroyed
	???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC015-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C015h
	???
Return: BX destroyed
	???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC016-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - INCREMENT ???
	AX = C016h
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C017h"PCACHE"
--------c-2FC017-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - DECREMENT ???
	AX = C017h
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C016h"PCACH"
--------c-2FC018-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C018h
	???
Return: BX destroyed
	???
Note:	the first instruction of this function is an indirect jump which points
	  at a RET by default
SeeAlso: AX=C000h"PCACHE",AX=C019h"PCACHE"
--------c-2FC019-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C019h
	???
Return: BX destroyed
	???
Note:	the first instruction of this function is an indirect jump which points
	  at a RET by default
SeeAlso: AX=C000h"PCACHE",AX=C018h"PCACHE"
--------c-2FC01A-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - CLEAR ??? FLAG
	AX = C01Ah
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C01Bh"PCACHE"
--------c-2FC01B-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - SET ??? FLAG
	AX = C01Bh
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C01Ah"PCACHE"
--------c-2FC01C-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C01Ch
	???
Return: AX = ???
	BX destroyed
SeeAlso: AX=C000h"PCACHE"
--------c-2FC01D-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - NOP
	AX = C01Dh to C01Fh
Return: BX destroyed
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE"
--------V-2FC020-----------------------------
INT 2F - AD-DOS - GET AND RESET VxD API STATUS
	AX = C020h
Return: AL = 00h if successful
	    BX = VxD API Status
		0000h no error
		0001h error
		0100h neither Windows 3.X enhanced mode nor Windows/386 2.x
			  is running
		0200h VM API entry point not found (VxD not installed)
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	this call resets the VxD API Status to zero
SeeAlso: AX=1602h,AX=1607h
Index:	screen saver;AD-DOS
--------V-2FC04E-----------------------------
INT 2F - Explosiv v2.00+ - NON-TSR EXECUTING CHECK
	AX = C04Eh
Return: AL = 4Fh if Explosiv is running but not memory-resident
Program: Explosiv is a shareware animated screen blanker for DOS and Windows 3
	  by H&G Software (Reidar Gresseth and Chris Hook)
Range:	AH=C0h to AH=C9h, selected by configuration
SeeAlso: AX=C050h
Index:	screen saver;Explosiv
--------V-2FC050-----------------------------
INT 2F - Explosiv v2.00+ - INSTALLATION CHECK
	AX = C050h
Return: AL = 51h if installed
	---v3.0+ ---
	    BX = interval in clock ticks
	    CH = animation display color (00h mono, 01h tinge, 02h color)
	    CL = animation delay factor
	    DH = animation parameters
	    DL = INT 10 checking (00h on, 01h off)
	    SI = number of bytes available for animation code
	    DI = display type (00h VGA, 01h EGA, 02h CGA, 03h HGC, 04h MDA)
Program: Explosiv is a shareware animated screen blanker for DOS and Windows 3
	  by H&G Software (Reidar Gresseth and Chris Hook)
Range:	AH=C0h to AH=C9h, selected by configuration
SeeAlso: AH=93h,AX=C000h"AD-DOS",AX=C04Eh,AX=C052h,AX=C054h"v3"
SeeAlso: INT 14/AX=AA01h
Index:	screen saver;Explosiv
--------V-2FC052-----------------------------
INT 2F - Explosiv v2.00+ - UNINSTALL
	AX = C052h
	DX:BX = address to return to on successful uninstall
Return: at specified address if successful
	AL = 53h on error
Note:	specified return address must have the segment of the caller's PSP
SeeAlso: AX=C050h
Index:	screen saver;Explosiv
--------V-2FC054-----------------------------
INT 2F - Explosiv v2.x - GET ANIMATION DELAY FACTOR
	AX = C054h
Return: AL = delay factor
SeeAlso: AX=C057h
Index:	screen saver;Explosiv
--------V-2FC054-----------------------------
INT 2F - Explosiv v3.0+ - UPDATE PARAMETERS
	AX = C054h
	BX = new interval in clock ticks
	CH = animation display color (00h mono, 01h tinge, 02h color)
	CL = animation delay factor
	DH = animation parameters
	DL = INT 10 checking (00h on, 01h off)
SeeAlso: AX=C050h
Index:	screen saver;Explosiv
--------V-2FC055-----------------------------
INT 2F - Explosiv v2.x - SET BLANKING INTERVAL
	AX = C055h
	BX = new interval in clock ticks
Index:	screen saver;Explosiv
--------V-2FC056-----------------------------
INT 2F - Explosiv v2.x - SET ANIMATION DISPLAY TYPE
	AX = C056h
	BL = animated display type (00h mono, 01h color)
SeeAlso: AX=C058h"v2.x"
Index:	screen saver;Explosiv
--------V-2FC056-----------------------------
INT 2F - Explosiv v3.0+ - ENABLE/DISABLE EXPLOSIV
	AX = C056h
	BX = new state
	    0000h disabled
	    0100h enabled
	    0101h enabled, but never blank
	    0102h enabled, always blank
--------V-2FC057-----------------------------
INT 2F - Explosiv v2.x - SET ANIMATION DELAY FACTOR
	AX = C057h
	BL = delay factor
SeeAlso: AX=C054h"v2.x"
Index:	screen saver;Explosiv
--------V-2FC058-----------------------------
INT 2F - Explosiv v2.x - SET ANIMATION PARAMETER
	AX = C058h
	BL = animation parameter
Note:	the animation parameter has different interpretations for each display
SeeAlso: AX=C056h"v2.x"
Index:	screen saver;Explosiv
--------V-2FC058-----------------------------
INT 2F - Explosiv v3.0+ - LOAD NEW ANIMATION DISPLAY CODE
	AX = C058h
	BX = file handle for file containing display code
	CX = number of bytes to load
	DX = offset at which animation code should be loaded
Return: AL = status (see #2239)
Note:	if AL=00h-03h on return, the file will be closed
Index:	screen saver;Explosiv

(Table 2239)
Values for Explosiv function status:
 00h	successful
 01h	code too large to available space
 02h	no data read, load aborted
 03h	incomplete load, default blanking display loaded instead
 58h	unexpected offset in DX
--------V-2FC059-----------------------------
INT 2F - Explosiv v2.x - DISABLE EXPLOSIV
	AX = C059h
Note:	clears flag set by AX=C05Ah
SeeAlso: AX=C05Ah
Index:	screen saver;Explosiv
--------V-2FC05A-----------------------------
INT 2F u - Explosiv v2.x - ENABLE EXPLOSIV
	AX = C05Ah
	BL = ???
Note:	sets flag cleared by AX=C059h then stores BL
SeeAlso: AX=C059h,AX=C05Bh
Index:	screen saver;Explosiv
--------V-2FC05B-----------------------------
INT 2F - Explosiv v2.x - CHANGE ANIMATION DISPLAY
	AX = C05Bh
	BL = animation display
Note:	this function fails silently if the requested display is not in memory
SeeAlso: AX=C05Ah,AX=C05Ch
Index:	screen saver;Explosiv
--------V-2FC05C-----------------------------
INT 2F - Explosiv v2.x - SET INT 10 CHECKING
	AX = C05Ch
	BL = new state of INT 10 checking (00h enabled, 01h disabled)
SeeAlso: AX=C05Bh
Index:	screen saver;Explosiv
--------v-2FC080-----------------------------
INT 2F U - AMI IAM.SYS - INSTALL ??? CALLBACK
	AX = C080h
	CX:DX -> ??? callback
	DI = segment of ??? buffer (first WORD copied into IAM.SYS)
Program: IAM.SYS is the Illegal Activity Monitor portion of American
	  Megatrends, Inc.'s PC-Defender anti-virus product
Note:	also sets ??? flag
SeeAlso: AX=C081h

Format of IAM.SYS buffer:
Offset	Size	Description	(Table 2240)
 00h	BYTE	???
 01h	BYTE	???
 02h  N BYTEs	??? (ASCIZ strings)
--------v-2FC081-----------------------------
INT 2F U - AMI IAM.SYS - CLEAR ???
	AX = C081h
Desc:	clears the ??? flag that AX=C080h sets
SeeAlso: AX=C080h
--------K-2FC0AE-----------------------------
INT 2F U - HP 100LX/200LX - PUSHKEYS - INSTALLATION CHECK
	AX = C0AEh
Return: AX = 4453h if installed
	CX = 5259h if installed
Range:	AH=C0h to AH=FFh, selected by scanning for signature
SeeAlso: AX=C000h"HP 100LX",AX=C001h"HP 100LX",AX=C0AFh"HP 100LX"
--------K-2FC0AF-----------------------------
INT 2F U - HP 100LX/200LX - PUSHKEYS - INTERNAL - GET BUFFER ADDRESS
	AX = C0AFh
Return: ES:DI -> buffer (behind code)
Range:	AH=C0h to AH=FFh, selected by scanning for signature with AL=AEh
SeeAlso: AX=C000h"HP 100LX",AX=C001h"HP 100LX",AX=C0AEh"HP 100LX"
--------N-2FC100-----------------------------
INT 2F U - Personal NetWare - STPIPX v1.00 - INSTALLATION CHECK
	AX = C100h
Return: AL = FFh if installed
	    ES:SI -> signature string "STP-IPX$"
	    BX = version??? (0001h for v1.00)
	    DI corrupted
Note:	AH=C1h is the default value; STPIPX probably scans a range of
	  multiplex numbers to find a free one, as LSL does
SeeAlso: AX=C000h"LSL",AX=C101h
--------N-2FC101-----------------------------
INT 2F U - Personal NetWare - STPIPX v1.00 - UNINSTALL
	AX = C101h
Return: AL = status???
	BX corrupted
SeeAlso: AX=C101h
--------N-2FC205-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Redirector - ???
	AX = C205h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C2F0h"LapLink"
SeeAlso: AX=C2F1h"LapLink",AX=C301h"LapLink"
--------N-2FC2F0-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Redirector - ???
	AX = C2F0h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C205h"LapLink"
SeeAlso: AX=C2F1h"LapLink",AX=C301h"LapLink"
--------N-2FC2F1-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Redirector - ???
	AX = C2F1h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C205h"LapLink"
SeeAlso: AX=C2F0h"LapLink",AX=C301h"LapLink"
--------d-2FC300-----------------------------
INT 2F - SETWPR.COM - INSTALLATION CHECK
	AX = C300h
Return: AL = FFh if installed
Program: SETWPR is a hard-disk write-protection TSR by Jaroslaw Rafa
SeeAlso: AX=C302h"SETWPR"
--------k-2FC300DX0000-----------------------
INT 2F U - SpaceManager - INSTALLATION CHECK
	AX = C300h
	DX = 0000h
Return: AL = FFh if any SpaceManager programs installed
	    BX = 6F73h
	    CX = 6F68h
Program: SpaceManager is an enhancement for MS-DOS DoubleSpace by Vertisoft
	  Systems, Inc.
Range:	AH=C3h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C300h/DX=0666h
--------k-2FC300-----------------------------
INT 2F U - SpaceManager - INSTALLATION VERIFICATION
	AX = C300h
	DX = program identifier (see #2241) or 0666h for any SpaceManager prog
	BX = 4F53h ('OS')
	CX = 4F48h ('OH')
Return: AL = FFh if BX/CX as specified and specified program installed
	    BX = 6F73h ('os')
	    CX = 6F68h ('oh')
Range:	AH=C3h to AH=FFh, selected by scanning for first free multiplex number
Note:	this call is chained if BX,CX, or DX are not as specified above
SeeAlso: AX=C300h/DX=0000h

(Table 2241)
Values for SpaceManager program identifier:
 9000h	SMOUNT (SuperMount)
 9001h	SELECTC (SelectCompress)
 9002h	SUPERX (SuperExchange)
 9003h	FORTUNE (FortuneTeller)
--------k-2FC301-----------------------------
INT 2F U - SpaceManager - ???
	AX = C301h
	DX = program identifier (9000h,9001h,9003h) (see #2241)
	???
Return: ???
--------N-2FC301-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Compression - ???
	AX = C301h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C205h"LapLink"
SeeAlso: AX=C2F0h"LapLink",AX=C3F0h"LapLink",AX=C3F1h"LapLink"
--------k-2FC302-----------------------------
INT 2F U - SpaceManager - ENABLE PROGRAM
	AX = C302h
	DX = program identifier (9000h,9001h,9003h) (see #2241)
Return: AX destroyed
SeeAlso: AX=C303h,AX=C306h
--------d-2FC302-----------------------------
INT 2F - SETWPR.COM - SET WRITE-PROTECTION STATE
	AX = C302h
	BL = new state
	    00h disk may be written
	    01h disk write-protected
Return: AL = FFh if installed
Program: SETWPR is a hard-disk write-protection TSR by Jaroslaw Rafa
SeeAlso: AX=C300h"SETWPR"
--------k-2FC303-----------------------------
INT 2F U - SpaceManager - DISABLE PROGRAM
	AX = C303h
	DX = program identifier (9000h,9001h,9003h) (see #2241)
Return: AX destroyed
SeeAlso: AX=C302h,AX=C306h
--------k-2FC304-----------------------------
INT 2F U - SpaceManager - GET PER-DRIVE ENABLEMENT TABLE
	AX = C304h
	DX = program identifier (9000h,9001h,9003h) (see #2241)
Return: ES:BX -> 26-byte drive table (00h disabled for drive, 01h enabled)
	AX destroyed
--------k-2FC305DX9003-----------------------
INT 2F U - SpaceManager - FORTUNE.EXE - NOP
	AX = C305h
	DX = 9003h
Return: AX destroyed
--------k-2FC305-----------------------------
INT 2F U - SpaceManager - ???
	AX = C305h
	DX = program identifier (9000h,9001h) (see #2241)
	???
Return: ???
--------k-2FC306-----------------------------
INT 2F U - SpaceManager - CHECK WHETHER PROGRAM ENABLED
	AX = C306h
	DX = program identifier (9000h,9001h,9003h) (see #2241)
Return: AL = current state (00h disabled, FAh enabled)
	AH destroyed
SeeAlso: AX=C302h,AX=C303h
--------k-2FC307DX9001-----------------------
INT 2F U - SpaceManager - SELECTC - ???
	AX = C307h
	DX = 9001h
	BX = ???
	CX = ???
	???
Return: ???
--------k-2FC308DX9001-----------------------
INT 2F U - SpaceManager - SELECTC - ???
	AX = C308h
	DX = 9001h
	???
Return: ???
--------N-2FC3F0-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Compression - ???
	AX = C3F0h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C205h"LapLink"
SeeAlso: AX=C2F0h"LapLink",AX=C301h"LapLink",AX=C3F1h"LapLink"
--------N-2FC3F1-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Compression - ???
	AX = C3F1h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C205h"LapLink"
SeeAlso: AX=C2F0h"LapLink",AX=C301h"LapLink",AX=C3F0h"LapLink"
--------d-2FC64CBX5553-----------------------
INT 2F U - Smart Prompt - INSTALLATION CHECK
	AX = C64Ch
	BX = 5553h
Return: AX = 4CC6h if installed
	BX = 5355h if installed
Program: Smart Prompt (SMARTPMT) is a freeware TSR by Steve Gibson which forces
	  an immediate flush of SmartDrive's (and compatible caches') buffers
	  on returning to the DOS prompt
--------V-2FC700CX434C-----------------------
INT 2F u - COLAP - INSTALLATION CHECK
	AX = C700h
	CX = 434Ch  "CL"
Return: AL = FFh if installed
Program: colap.com is a freeware TSR by Eric Meyer which controls contrast
	  and brightness of color laptops by changing the VGA palette colors;
	  for Toshiba laptops there are more hotkeys for shutting off display
	  and harddisk.
--------v-2FC900BP0000-----------------------
INT 2F U - ThunderByte??? - INSTALLATION CHECK
	AX = C900h
	BP = 0000h
Return: AL = FFh if installed
	    BP >= 0014h
Note:	called by TBSCANX
SeeAlso: AX=C987h,AX=CA00h
--------v-2FC987-----------------------------
INT 2F U - ThunderByte??? - DISINFECT FILE???
	AX = C987h
	BX:DX -> filename
	BX:CX -> virus name
Return: AX = status
	    0000h successful???
Note:	called by TBSCANX
SeeAlso: AX=CA00h
--------r-2FC9FF-----------------------------
INT 2F C - StackMan - INSTALLATION BROADCAST
	AX = C9FFh
	BL = BCD version number
	CX = number of stacks
	DX = stack size in bytes
Program: StackMan is a freeware stack manager by Franz Veldman of ESaSS B.V.
	  which functions as a replacement for the DOS STACK= command as well
	  as permitting multiple TSRs to share a pool of stack space
Notes:	called by StackMan when it goes resident to inform interested TSRs that
	  its API is available
	the installation check consists of testing for the string "STACKXXX" at
	  offset 0Ah from the INT B4 handler
SeeAlso: INT B4"StackMan",INT B5"StackMan"
Index:	installation check;STACKMAN|broadcasts;STACKMAN installation
--------F-2FCA-------------------------------
INT 2F - FAXPLUS - FAX TSR
	AH = CAh
	???
Return: ???
Program: FAXTSR is a resident FAX send/receive module for FAXPLUS by Frans
	  Veldman
SeeAlso: AH=2Ah"Gammafax"
--------v-2FCA00BX5442-----------------------
INT 2F - TBSCANX - INSTALLATION CHECK
	AX = CA00h
	BX = 5442h ('TB')
Return: AL = state
	    00h not installed
	    FFh installed
		BX = 7462h ('tb') if BX was 5442h on entry
Program: TBSCANX is a resident virus scanning module by Frans Veldman.
Note:	programs may perform virus checks on themselves, other program files,
	  or their data files by invoking the TBSCANX API.
SeeAlso: AX=4653h,AX=C900h
--------v-2FCA01-----------------------------
INT 2F - TBSCANX - GET STATUS
	AX = CA01h
Return: AH = BCD version number (v2.2+)
	    CAh for versions before 2.2
	AL = state (00h = disabled, 01h = enabled)
	CX = number of signatures which will be searched
---v2.0---
	BX = EMS handle, 0000h if not using EMS
---v2.3+---
	BX = segment of swap area, 0000h if not swapped
	DX = EMS or XMS handle (XMS handle if BX=0000h), FFFFh if not using EMS
SeeAlso: AX=CA02h
--------v-2FCA02-----------------------------
INT 2F - TBSCANX - SET STATE
	AX = CA02h
	BL = new state (00h = disabled, 01h = enabled)
SeeAlso: AX=CA01h
--------v-2FCA03-----------------------------
INT 2F - TBSCANX - SCAN BUFFER
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
--------v-2FCA04-----------------------------
INT 2F - TBSCANX - SCAN FILE
	AX = CA04h
	DS:DX -> filename
Return: CF clear if no virus signatures found
	    BX,ES destroyed
	CF set if signature found
	    ES:BX -> ASCIZ virus name
	AX,CX,DX destroyed
Note:	this function requires at least 4K free memory
SeeAlso: AX=CA03h
--------U-2FCAFEBX0000-----------------------
INT 2F U - THELP v3.0 - INSTALLATION CHECK
	AX = CAFEh
	BX = 0000h
Return: BX = segment of resident code if installed
	    0000h if not installed
SeeAlso: AX=5453h,INT 2D"AMIS"
--------!---Section--------------------------
