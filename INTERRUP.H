Interrupt List, part 8 of 10
This compilation is Copyright (c) 1989,1990,1991,1992,1993 Ralf Brown
--------D-30---------------------------------
INT 30 - (NOT A VECTOR!) - DOS 1+ - FAR JMP instruction for CP/M-style calls
   the CALL 5 entry point does a FAR jump to here
Note:	under DOS 2+, the instruction at PSP:0005 points two bytes too low in
	  memory
SeeAlso: INT 21/AH=26h
--------D-31---------------------------------
INT 31 - overwritten by CP/M jump instruction in INT 30
--------v-31---------------------------------
INT 31 - VIRUS - "Vacsina" series - INSTALLATION CHECK (NOT A VECTOR!)
Note:	if one of the Vacsina viruses is resident, the low byte of this
	  interrupt still contains the last byte of the INT 30 CP/M JMP
	  instruction, but the remaining three bytes are 7Fh 39h followed
	  by the Vacsina version number
SeeAlso: INT 21/AX=FFFFh"VIRUS",INT 32"VIRUS"
--------E-310000-----------------------------
INT 31 P - DPMI 0.9+ - ALLOCATE LDT DESCRIPTORS
	AX = 0000h
	CX = number of descriptors to allocate
Return: CF clear if successful
	    AX = base selector
	CF set on error
	    AX = error code (DPMI 1.0+) (see below)
Notes:	DPMI is the DOS Protected-Mode Interface
	the base and limit of the returned descriptors will be 0, and the type
	  will be "data"
	add the value returned by INT 31/AX=0003h to move to subsequent
	  descriptors if multiple descriptors were allocated
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0001h,AX=000Dh,INT 21/AX=3501h

Values for error code:
 0000h-7FFFh DOS error passed through by DPMI
 8001h	unsupported function
 8002h	object in wrong state for function
 8003h	system integrity would be endangered
 8004h	deadlock detected
 8005h	pending serialization request cancelled
 8010h	out of DPMI internal resources
 8011h	descriptor unavailable
 8012h	linear memory unavailable
 8013h	physical memory unavailable
 8014h	backing store unavailable
 8015h	callback unavailable
 8016h	handle unavailable
 8017h	maximum lock count exceeded
 8018h	shared memory already serialized exclusively by another
 8019h	shared memory already serialized shared by another client
 8021h	invalid value for numeric or flag parameter
 8022h	invalid segment selector
 8023h	invalid handle
 8024h	invalid callback
 8025h	invalid linear address
 8026h	request not supported by hardware
--------E-310001-----------------------------
INT 31 P - DPMI 0.9+ - FREE LDT DESCRIPTOR
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
SeeAlso: AX=0000h,AX=000Ah,AX=000Dh,INT 21/AX=3502h
--------E-310002-----------------------------
INT 31 P - DPMI 0.9+ - SEGMENT TO DESCRIPTOR
	AX = 0002h
	BX = real mode segment
Return: CF clear if successful
	    AX = selector corresponding to real mode segment (64K limit)
	CF set on error
	    AX = error code (DPMI 1.0+) (8011h) (see AX=0000h)
Notes:	multiple calls for the same real mode segment return the same selector
	the returned descriptor can never be modified or freed
	not supported by MS Windows 3.0 in Standard mode
--------E-310003-----------------------------
INT 31 P - DPMI 0.9+ - GET NEXT SELECTOR INCREMENT VALUE
	AX = 0003h
Return: CF clear
	    AX = value to add to get next sequential selector
Notes:	the increment will be a power of two
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0000h
--------E-310004-----------------------------
INT 31 P - DPMI 0.9+ - LOCK SELECTOR
	AX = 0004h
	BX = selector to lock (prevent paging)
Return: ???
Note:	although marked as reserved in versions 0.9 and 1.0 of the DPMI
	  specification, this function is called by MS Windows TASKMAN,
	  PROGMAN, and KERNEL
SeeAlso: AX=0005h,AX=0600h
--------E-310005-----------------------------
INT 31 P - DPMI 0.9+ - UNLOCK SELECTOR
	AX = 0005h
	BX = selector to unlock (permit paging)
Return: ???
Note:	although marked as reserved in versions 0.9 and 1.0 of the DPMI
	  specification, this function is called by MS Windows TASKMAN,
	  PROGMAN, and KERNEL
SeeAlso: AX=0004h,AX=0601h
--------E-310006-----------------------------
INT 31 P - DPMI 0.9+ - GET SEGMENT BASE ADDRESS
	AX = 0006h
	BX = selector
Return: CF clear if successful
	    CX:DX = linear base address of segment
	CF set on error
	    AX = error code (DPMI 1.0+) (8022h) (see AX=0000h)
Note:	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0007h,INT 21/AX=3504h
--------E-310007-----------------------------
INT 31 P - DPMI 0.9+ - SET SEGMENT BASE ADDRESS
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
SeeAlso: AX=0006h,AX=0008h,AX=0009h,AX=000Ch,INT 21/AX=3503h
SeeAlso: INT 21/AH=E9h"OS/286"
--------E-310008-----------------------------
INT 31 P - DPMI 0.9+ - SET SEGMENT LIMIT
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
SeeAlso: AX=0007h,AX=0009h,AX=000Ch,INT 21/AX=3505h,INT 21/AH=E9h"OS/286"
--------E-310009-----------------------------
INT 31 P - DPMI 0.9+ - SET DESCRIPTOR ACCESS RIGHTS
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
--------E-31000A-----------------------------
INT 31 P - DPMI 0.9+ - CREATE ALIAS DESCRIPTOR
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
--------E-31000B-----------------------------
INT 31 P - DPMI 0.9+ - GET DESCRIPTOR
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
--------E-31000C-----------------------------
INT 31 P - DPMI 0.9+ - SET DESCRIPTOR
	AX = 000Ch
	BX = LDT selector
	ES:(E)DI -> 8-byte buffer containing descriptor
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8021h,8022h,8025h) (see AX=0000h)
Notes:	16-bit programs use ES:DI as pointer, 32-bit must use ES:EDI
	only modify descriptors allocated with INT 31/AX=0000h
	DPMI 1.0+ automatically reloads any segment registers containing the
	  selector being modified
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=000Bh
--------E-31000D-----------------------------
INT 31 P - DPMI 0.9+ - ALLOCATE SPECIFIC LDT DESCRIPTOR
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
--------E-31000E-----------------------------
INT 31 P - DPMI 1.0+ - GET MULTIPLE DESCRIPTORS
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
--------E-31000F-----------------------------
INT 31 P - DPMI 1.0+ - SET MULTIPLE DESCRIPTORS
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
--------E-310100-----------------------------
INT 31 P - DPMI 0.9+ - ALLOCATE DOS MEMORY BLOCK
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
--------E-310101-----------------------------
INT 31 P - DPMI 0.9+ - FREE DOS MEMORY BLOCK
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
--------E-310102-----------------------------
INT 31 P - DPMI 0.9+ - RESIZE DOS MEMORY BLOCK
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
--------E-310200-----------------------------
INT 31 P - DPMI 0.9+ - GET REAL MODE INTERRUPT VECTOR
	AX = 0200h
	BL = interrupt number
Return: CF clear
	CX:DX = segment:offset of real mode interrupt handler
Note:	the DPMI implementation is required to support all 256 vectors
SeeAlso: AX=0201h,AX=0204h,INT 21/AX=2503h
--------E-310201-----------------------------
INT 31 P - DPMI 0.9+ - SET REAL MODE INTERRUPT VECTOR
	AX = 0201h
	BL = interrupt number
	CX:DX = segment:offset of real mode handler
Return: CF clear
Note:	all memory that may be touched by a hardware interrupt handler must be
	  locked down with INT 31/AX=0600h
SeeAlso: AX=0200h,AX=0205h,AX=0600h,INT 21/AX=2505h
--------E-310202-----------------------------
INT 31 P - DPMI 0.9+ - GET PROCESSOR EXCEPTION HANDLER VECTOR
	AX = 0202h
	BL = exception number (00h-1Fh)
Return: CF clear if successful
	    CX:(E)DX = selector:offset of handler
	CF set on error
	    AX = error code (DPMI 1.0+) (8021h) (see AX=0000h)
Notes:	16-bit programs receive the pointer in CX:DX, 32-bit programs in CX:EDX
	DPMI 1.0+ supports this function only for backward compatibility; use
	   AX=0210h or AX=0211h instead
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0203h,AX=0210h,AX=0211h,INT 2F/AX=FB42h/BX=0021h
--------E-310203-----------------------------
INT 31 P - DPMI 0.9+ - SET PROCESSOR EXCEPTION HANDLER VECTOR
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
SeeAlso: AX=0202h,AX=0212h,AX=0213h,INT 2F/AX=FB42h/BX=0022h

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
--------E-310204-----------------------------
INT 31 P - DPMI 0.9+ - GET PROTECTED MODE INTERRUPT VECTOR
	AX = 0204h
	BL = interrupt number
Return: CF clear
	CX:(E)DX = selector:offset of handler
Notes:	16-bit programs use CX:DX, 32-bit programs use CX:EDX
	DPMI implementations are required to support all 256 vectors
	not supported by MS Windows 3.0 in Standard mode
SeeAlso: AX=0200h,AX=0205h,INT 21/AX=2502h,INT 2F/AX=FB42h/BX=0024h
--------E-310205-----------------------------
INT 31 P - DPMI 0.9+ - SET PROTECTED MODE INTERRUPT VECTOR
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
SeeAlso: AX=0201h,AX=0204h,INT 21/AX=2504h,INT 2F/AX=FB42h/BX=0025h
--------E-310210-----------------------------
INT 31 P - DPMI 1.0+ - GET PROTECTED MODE EXTENDED PROCESSOR EXCEPTION HANDLER
	AX = 0210h
	BL = exception number (00h-1Fh)
Return: CF clear if successful
	    CX:(EDX) = selector:offset of exception handler
	CF set on error
	    AX = error code (8021h) (see AX=0000h)
Note:	DPMI host reflects exception to current client's handler
SeeAlso: AX=0202h,AX=0211h,AX=0212h
--------E-310211-----------------------------
INT 31 P - DPMI 1.0+ - GET REAL MODE EXTENDED PROCESSOR EXCEPTION HANDLER
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
--------E-310212-----------------------------
INT 31 P - DPMI 1.0+ - SET PROTECTED MODE EXTENDED PROCESSOR EXCEPTION HANDLER
	AX = 0212h
	BL = exception or fault number (00h-1Fh)
	CX:(E)DX = exception handler selector:offset
Return: CF clear if successful
	CF set on error
	    AX = error code (8021h,8022h) (see AX=0000h)
Note:	DPMI host sends exception to current client's handler
SeeAlso: AX=0203h,AX=0210h,AX=0213h
--------E-310213-----------------------------
INT 31 P - DPMI 1.0+ - SET REAL MODE EXTENDED PROCESSOR EXCEPTION HANDLER
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
--------E-310300-----------------------------
INT 31 P - DPMI 0.9+ - SIMULATE REAL MODE INTERRUPT
	AX = 0300h
	BL = interrupt number
	BH = flags
	    bit 0: reset the interrupt controller and A20 line (DPMI 0.9)
		   reserved, must be 0 (DPMI 1.0+)
	    others must be 0
	CX = number of words to copy from protected mode to real mode stack
	ES:(E)DI = selector:offset of real mode call structure (see below)
Return: CF clear if successful
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
SeeAlso: INT 2F/AX=FB42h/BX=000Dh

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
--------E-310301-----------------------------
INT 31 P - DPMI 0.9+ - CALL REAL MODE PROCEDURE WITH FAR RETURN FRAME
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
--------E-310302-----------------------------
INT 31 P - DPMI 0.9+ - CALL REAL MODE PROCEDURE WITH IRET FRAME
	AX = 0302h
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
	the flags in the call structure are pushed on the real mode stack to
	  form an interrupt stack frame, and the trace and interrupt flags are
	  clear on entry to the handler
	the real mode procedure must exit with an IRET
	DPMI will provide a small (30 words) real mode stack if SS:SP is zero
	the real mode handler must return with the stack in the same state as
	  it was on being called
SeeAlso: AX=0300h
--------E-310303-----------------------------
INT 31 P - DPMI 0.9+ - ALLOCATE REAL MODE CALLBACK ADDRESS
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
--------E-310304-----------------------------
INT 31 P - DPMI 0.9+ - FREE REAL MODE CALLBACK ADDRESS
	AX = 0304h
	CX:DX = real mode callback address
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8024h) (see AX=0000h)
SeeAlso: AX=0303h
--------E-310305-----------------------------
INT 31 P - DPMI 0.9+ - GET STATE SAVE/RESTORE ADDRESSES
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
--------E-310306-----------------------------
INT 31 P - DPMI 0.9+ - GET RAW MODE SWITCH ADDRESSES
	AX = 0306h
Return: CF clear
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
--------E-310400-----------------------------
INT 31 P - DPMI 0.9+ - GET DPMI VERSION
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
SeeAlso: AX=0401h,INT 21/AX=250Ch,INT 2F/AX=1687h,INT 67/AX=DE0Ah
--------E-310401-----------------------------
INT 31 P - DPMI 1.0+ - GET DPMI CAPABILITIES
	AX = 0401h
	ES:(E)DI -> 128-byte buffer for host description (see below)
Return: CF clear if successful
	    AX = capabilities (see below)
	    CX = reserved (00h)
	    DX = reserved (00h)
	    buffer filled
	CF set on error (DPMI 0.9 only)
SeeAlso: AX=0400h

Bitfields for capabilities:
 bit 0	paged accessed/dirty supported (see AX=0506h,AX=0507h)
 bit 1	exceptions restartability supported
 bit 2	device mapping supported (see AX=0508h)
 bit 3	conventional memory mapping supported (see AX=0509h)
 bit 4	demand zero-fill supported
 bit 5	write-protect client capability supported
 bit 6	write-protect host capability supported
 bits 7-15 reserved

Format of host description:
Offset	Size	Description
 00h	BYTE	host major version number
 01h	BYTE	host minor version number
 02h 126 BYTEs	ASCIZ host vendor name
--------E-310500-----------------------------
INT 31 P - DPMI 0.9+ - GET FREE MEMORY INFORMATION
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
--------E-310501-----------------------------
INT 31 P - DPMI 0.9+ - ALLOCATE MEMORY BLOCK
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
SeeAlso: INT 2F/AX=FB42h/BX=0002h
--------E-310502-----------------------------
INT 31 P - DPMI 0.9+ - FREE MEMORY BLOCK
	AX = 0502h
	SI:DI = handle of memory block
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8023h) (see AX=0000h)
Note:	any selectors allocated for the memory block must also be freed,
	  preferably before freeing the memory block
SeeAlso: AX=0001h,AX=0101h,AX=0501h,AX=0D01h
--------E-310503-----------------------------
INT 31 P - DPMI 0.9+ - RESIZE MEMORY BLOCK
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
--------E-310504-----------------------------
INT 31 P - DPMI 1.0+ - ALLOCATE LINEAR MEMORY BLOCK
	AX = 0504h
	EBX = page-aligned linear address of memory block (00000000h if any
		address is acceptable)
	ECX = size in bytes (nonzero)
	EDX = flags
	    bit 0: set to create committed pages instead of uncommitted pages
	    bits 1-31 reserved (0)
Return: CF clear if successful
	    EBX = linear address of memory block
	    ESI = memory block handle
	CF set on error
	    AX = error code (8001h,8012h-8014h,8016h,8021h,8025h)(see AX=0000h)
Note:	only supported by 32-bit DPMI hosts, but may be used by 16-bit clients
SeeAlso: AX=0501h,AX=0505h
--------E-310505-----------------------------
INT 31 P - DPMI 1.0+ - RESIZE LINEAR MEMORY BLOCK
	AX = 0505h
	ESI = memory block handle
	ECX = new size in bytes (nonzero)
	EDX = flags
	    bit 0: create committed pages rather than uncommitted pages
	    bit 1: segment descriptor update required
		ES:EBX -> buffer containing array of WORDs with selectors
		EDI = number of selectors in array
	    bits 2-31 reserved (0)
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
--------E-310506-----------------------------
INT 31 P - DPMI 1.0+ - GET PAGE ATTRIBUTES
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
--------E-310507-----------------------------
INT 31 P - DPMI 1.0+ - MODIFY PAGE ATTRIBUTES
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
--------E-310508-----------------------------
INT 31 P - DPMI 1.0+ - MAP DEVICE IN MEMORY BLOCK
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
--------E-310509-----------------------------
INT 31 P - DPMI 1.0+ - MAP CONVENTIONAL MEMORY IN MEMORY BLOCK
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
--------E-31050A-----------------------------
INT 31 P - DPMI 1.0+ - GET MEMORY BLOCK SIZE AND BASE
	AX = 050AH
	SI:DI = memory block handle
Return: CF clear if successful
	    SI:DI = size in bytes
	    BX:CX = base address
	CF set on error
	    AX = error code (8023h) (see AX=0000h)
SeeAlso: AX=0501h,AX=0504h
--------E-31050B-----------------------------
INT 31 P - DPMI 1.0+ - GET MEMORY INFORMATION
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
--------E-310600-----------------------------
INT 31 P - DPMI 0.9+ - LOCK LINEAR REGION
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
--------E-310601-----------------------------
INT 31 P - DPMI 0.9+ - UNLOCK LINEAR REGION
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
--------E-310602-----------------------------
INT 31 P - DPMI 0.9+ - MARK REAL MODE REGION AS PAGEABLE
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
--------E-310603-----------------------------
INT 31 P - DPMI 0.9+ - RELOCK REAL MODE REGION
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
--------E-310604-----------------------------
INT 31 P - DPMI 0.9+ - GET PAGE SIZE
	AX = 0604h
Return: CF clear if successful
	    BX:CX = page size in bytes
	CF set on error
	    AX = error code (DPMI 1.0+)
		8001h unsupported, 16-bit host
--------E-310700-----------------------------
INT 31 P - DPMI 0.9+ - MARK PAGES AS PAGING CANDIDATES
	AX = 0700h
	BX:CX = starting linear page number
	SI:DI = number of pages to mark as paging candidates
Return: ???
Note:	although marked as reserved in versions 0.9 and 1.0 of the DPMI
	  specification, this function is called by MS Windows TASKMAN,
	  PROGMAN, and KERNEL
SeeAlso: AX=0701h,AX=0702h
--------E-310701-----------------------------
INT 31 P - DPMI 0.9+ - DISCARD PAGES
	AX = 0701h
	BX:CX = starting linear page number
	SI:DI = number of pages to discard
Return: ???
Note:	although marked as reserved in versions 0.9 and 1.0 of the DPMI
	  specification, this function is called by MS Windows TASKMAN,
	  PROGMAN, and KERNEL
SeeAlso: AX=0700h,AX=0703h
--------E-310702-----------------------------
INT 31 P - DPMI 0.9+ - MARK PAGE AS DEMAND PAGING CANDIDATE
	AX = 0702h
	BX:CX = starting linear address
	SI:DI = number of bytes to mark as paging candidates
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8025h) (see AX=0000h)
Notes:	this function is advisory, and does not force immediate paging
	partial pages will not be discarded
SeeAlso: AX=0700h,AX=0703h
--------E-310703-----------------------------
INT 31 P - DPMI 0.9+ - DISCARD PAGE CONTENTS
	AX = 0703h
	BX:CX = starting linear address
	SI:DI = number of bytes to mark as discarded
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8025h) (see AX=0000h)
Notes:	this function is advisory, and may be ignored by DPMI implementations
	partial pages will not be discarded
SeeAlso: AX=0701h,AX=0702h
--------E-310800-----------------------------
INT 31 P - DPMI 0.9+ - PHYSICAL ADDRESS MAPPING
	AX = 0800h
	BX:CX = physical address (should be above 1 MB)
	SI:DI = size in bytes
Return: CF clear if successful
	    BX:CX = linear address which maps the requested physical memory
	CF set on error
	    AX = error code (DPMI 1.0+) (8003h,8021h) (see AX=0000h)
Notes:	implementations may refuse this call because it can circumvent protects
	the caller must build an appropriate selector for the memory
	do not use for memory mapped in the first megabyte
SeeAlso: AX=0002h,AX=0508h,AX=0509h,AX=0801h,INT 21/AX=250Ah,INT 21/AX=EB05h
--------E-310801-----------------------------
INT 31 P - DPMI 1.0+ - FREE PHYSICAL ADDRESS MAPPING
	AX = 0801h
	BX:CX = linear address returned by AX=0800h
Return: CF clear if successful
	CF set on error
	    AX = error code (8025h) (see AX=0000h)
Note:	should be called at end of access to device mapped with AX=0800h
SeeAlso: AX=0508h,AX=0509h,AX=0800h,INT 21/AX=EB03h
--------E-310900-----------------------------
INT 31 P - DPMI 0.9+ - GET AND DISABLE VIRTUAL INTERRUPT STATE
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
--------E-310901-----------------------------
INT 31 P - DPMI 0.9+ - GET AND ENABLE VIRTUAL INTERRUPT STATE
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
--------E-310902-----------------------------
INT 31 P - DPMI 0.9+ - GET VIRTUAL INTERRUPT STATE
	AX = 0902h
Return: CF clear
	AL = 00h if disabled
	   = 01h if enabled
Note:	should be used rather than PUSHF because that instruction yields the
	  physical interrupt state rather than the per-client virtualized
	  interrupt flag
SeeAlso: AX=0900h,AX=0901h
--------E-310A00-----------------------------
INT 31 P - DPMI 0.9+ - GET VENDOR SPECIFIC API ENTRY POINT
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
--------E-310B00-----------------------------
INT 31 P - DPMI 0.9+ - SET DEBUG WATCHPOINT
	AX = 0B00h
	BX:CX = linear address
	DL = size (1,2,4 bytes)
	DH = type (00h execute, 01h write, 02h read/write)
Return: CF clear if successful
	    BX = watchpoint handle
	CF set on error
	    AX = error code (DPMI 1.0+) (8016h,8021h,8025h) (see AX=0000h)
SeeAlso: AX=0212h,AX=0601h
--------E-310B01-----------------------------
INT 31 P - DPMI 0.9+ - CLEAR DEBUG WATCHPOINT
	AX = 0B01h
	BX = watchpoint handle
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8023h) (see AX=0000h)
Note:	the watchpoint handle is freed
SeeAlso: AX=0B00h
--------E-310B02-----------------------------
INT 31 P - DPMI 0.9+ - GET STATE OF DEBUG WATCHPOINT
	AX = 0B02h
	BX = watchpoint handle
Return: CF clear if successful
	    AX = status flags
		bit 0: watch point has been executed since AX=0B00h or AX=0B03h
	CF set on error
	    AX = error code (DPMI 1.0+) (8023h) (see AX=0000h)
SeeAlso: AX=0B00h,AX=0B03h
--------E-310B03-----------------------------
INT 31 P - DPMI 0.9+ - RESET DEBUG WATCHPOINT
	AX = 0B03h
	BX = watchpoint handle
Return: CF clear if successful
	CF set on error
	    AX = error code (DPMI 1.0+) (8023h) (see AX=0000h)
SeeAlso: AX=0B02h
--------E-310C00-----------------------------
INT 31 P - DPMI 1.0+ - INSTALL RESIDENT HANDLER INIT CALLBACK
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
--------E-310C01-----------------------------
INT 31 P - DPMI 1.0+ - TERMINATE AND STAY RESIDENT
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
--------E-310D00-----------------------------
INT 31 P - DPMI 1.0+ - ALLOCATE SHARED MEMORY
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
--------E-310D01-----------------------------
INT 31 P - DPMI 1.0+ - FREE SHARED MEMORY
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
--------E-310D02-----------------------------
INT 31 P - DPMI 1.0+ - SERIALIZE SHARED MEMORY
	AX = 0D02h
	SI:DI = shared memory block handle
	DX = flags
	    bit 0: return immediately rather than suspending if serialization
			unavailable
	    bit 1: shared rather than exclusive serialization
	    bits 2-15 reserved (0)
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
--------E-310D03-----------------------------
INT 31 P - DPMI 1.0+ - FREE SERIALIZATION ON SHARED MEMORY
	AX = 0D03h
	SI:DI = shared memory block handle
	DX = flags
	    bit 0: release shared serialization rather than exclusive serialztn
	    bit 1: free pending serialization
	    bits 2-15 reserved (0)
Return: CF clear if successful
	CF set on error
	    AX = error code (8002h,8023h) (see AX=0000h)
SeeAlso: AX=0D00h,AX=0D02h
--------E-310E00-----------------------------
INT 31 P - DPMI 1.0+ - GET COPROCESSOR STATUS
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
	    bits 8-15 not used
Note:	supported by 386MAX v6.01, which otherwise only supports DPMI 0.9
SeeAlso: AX=0E01h
--------E-310E01-----------------------------
INT 31 P - DPMI 1.0+ - SET EMULATION
	AX = 0E01h
	BX = coprocessor flag bits
	    bit 0: enable numeric coprocessor for current client
	    bit 1: client will emulate coprocessor
	    bits 2-15 not used
Return: CF clear if successful
	CF set on error
	    AX = error code (8026h) (see AX=0000h)
Note:	supported by 386MAX v6.01, which otherwise only supports DPMI 0.9
SeeAlso: AX=0E00h
----------3157-------------------------------
INT 31 - Netroom3 DPMI.EXE v3.00 - ???
	AH = 57h
	AL = subfunction (at least 02h,03h,04h,05h,07h,08h,09h,0Ah)
	???
Return: ???
SeeAlso: INT 2C/AX=0000h"RM386"
----------315702-----------------------------
INT 31 - Netroom3 DPMI.EXE v3.00 - SWITCH TO PROTECTED MODE
	AX = 5702h
	DX = PSP segment of caller
	STACK: WORD	???
	       WORD	flags (bit 0 set if 32-bit program)
Return: as for DPMI mode-switch entry point (see INT 2F/AX=1687h)
Note:	this function is called by the real-mode DPMI mode-switch entry point
SeeAlso: INT 2F/AX=1687h
--------v-32---------------------------------
INT 32 - VIRUS - reportedly used by "Tiny" Viruses
SeeAlso: INT 21/AX=FFFFh"VIRUS",INT 31"VIRUS",INT 44"VIRUS"
--------v-32---------------------------------
INT 32 - VIRUS - "Plovdiv 1.3"/"Damage 1.3" - ORIGINAL INT 21h VECTOR
SeeAlso: INT 31"VIRUS",INT 9E"VIRUS"
--------M-330000-----------------------------
INT 33 - MS MOUSE - RESET DRIVER AND READ STATUS
	AX = 0000h
Return: AX = status
	    0000h hardware/driver not installed
	    FFFFh hardware/driver installed
	BX = number of buttons
	    0000h other than two
	    0002h two buttons (many drivers)
	    0003h Mouse Systems/Logitech three-button mouse
	    FFFFh two buttons
Notes:	to use mouse on a Hercules-compatible monographics card in graphics
	  mode, you must first set 0040h:0049h to 6 for page 0 or 5 for page 1,
	  and then call this function.	Logitech drivers v5.01 and v6.00
	  reportedly do not correctly use Hercules graphics in dual-monitor
	  systems, while version 4.10 does.
	the Logitech mouse driver contains the signature string "LOGITECH"
	  three bytes past the interrupt handler; many of the Logitech mouse
	  utilities check for this signature.
SeeAlso: AX=0011h,AX=0021h,AX=002Fh,INT 62/AX=007Ah,INT 74
--------M-330001-----------------------------
INT 33 - MS MOUSE - SHOW MOUSE CURSOR
	AX = 0001h
SeeAlso: AX=0002h,INT 16/AX=FFFEh,INT 62/AX=007Bh
--------M-330002-----------------------------
INT 33 - MS MOUSE - HIDE MOUSE CURSOR
	AX = 0002h
Note:	multiple calls to hide the cursor will require multiple calls to
	  function 01h to unhide it.
SeeAlso: AX=0001h,AX=0010h,INT 16/AX=FFFFh,INT 62/AX=007Bh
--------M-330003-----------------------------
INT 33 - MS MOUSE - RETURN POSITION AND BUTTON STATUS
	AX = 0003h
Return: BX = button status
	   bit 0  left button pressed if 1
	   bit 1  right button pressed if 1
	   bit 2  middle button pressed if 1 (Mouse Systems/Logitech mouse)
	CX = column
	DX = row
SeeAlso: AX=0004h,AX=000Bh,INT 2F/AX=D000h"ZWmous"
--------M-330004-----------------------------
INT 33 - MS MOUSE - POSITION MOUSE CURSOR
	AX = 0004h
	CX = column
	DX = row
Note:	the row and column are truncated to the next lower multiple of the cell
	  size; however, some versions of the Microsoft documentation
	  incorrectly state that the coordinates are rounded
SeeAlso: AX=0003h,INT 62/AX=0081h
--------M-330005-----------------------------
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
SeeAlso: AX=0006h,INT 62/AX=007Ch
--------M-330006-----------------------------
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
SeeAlso: AX=0005h,INT 62/AX=007Ch
--------M-330007-----------------------------
INT 33 - MS MOUSE - DEFINE HORIZONTAL CURSOR RANGE
	AX = 0007h
	CX = minimum column
	DX = maximum column
SeeAlso: AX=0008h,AX=0010h,AX=0031h,INT 62/AX=0080h
--------M-330008-----------------------------
INT 33 - MS MOUSE - DEFINE VERTICAL CURSOR RANGE
	AX = 0008h
	CX = minimum row
	DX = maximum row
SeeAlso: AX=0007h,AX=0010h,AX=0031h,INT 62/AX=0080h
--------M-330009-----------------------------
INT 33 - MS MOUSE - DEFINE GRAPHICS CURSOR
	AX = 0009h
	BX = column of cursor hot spot in bitmap (-16 to 16)
	CX = row of cursor hot spot (-16 to 16)
	ES:DX -> bitmap
		16 words screen mask
		16 words cursor mask
		    each word defines the sixteen pixels of a row, low bit
		    rightmost
SeeAlso: AX=000Ah,AX=0012h,AX=002Ah,INT 62/AX=007Fh
--------M-33000A-----------------------------
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
SeeAlso: AX=0009h,INT 62/AX=007Eh
--------M-33000B-----------------------------
INT 33 - MS MOUSE - READ MOTION COUNTERS
	AX = 000Bh
Return: CX = number of mickeys mouse moved horizontally since last call
	DX = number of mickeys mouse moved vertically
Notes:	a mickey is the smallest increment the mouse can sense
	positive values indicate down/right
SeeAlso: AX=0003h,AX=001Bh,AX=0027h
--------M-33000C-----------------------------
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
--------M-33000D-----------------------------
INT 33 - MS MOUSE - LIGHT PEN EMULATION ON
	AX = 000Dh
SeeAlso: AX=000Eh,INT 10/AH=04h
--------M-33000E-----------------------------
INT 33 - MS MOUSE - LIGHT PEN EMULATION OFF
	AX = 000Eh
SeeAlso: AX=000Dh
--------M-33000F-----------------------------
INT 33 - MS MOUSE - DEFINE MICKEY/PIXEL RATIO
	AX = 000Fh
	CX = number of mickeys per 8 pixels horizontally (default 8)
	DX = number of mickeys per 8 pixels vertically (default 16)
SeeAlso: AX=0013h,AX=001Ah,INT 62/AX=0082h
--------M-330010-----------------------------
INT 33 - MS MOUSE - DEFINE SCREEN REGION FOR UPDATING
	AX = 0010h
	CX,DX = X,Y coordinates of upper left corner
	SI,DI = X,Y coordinates of lower right corner
Note:	mouse cursor is hidden in the specified region, and needs to be
	  explicitly turned on again
SeeAlso: AX=0001h,AX=0002h,AX=0007h,AX=0010h"Genius MOUSE",AX=0031h
--------M-330010-----------------------------
INT 33 - Genius MOUSE - DEFINE SCREEN REGION FOR UPDATING
	AX = 0010h
	ES:DX -> update region list (see below)
Notes:	mouse cursor is hidden in the specified region, and needs to be
	  explicitly turned on again
	this version of the call is described in an August 1988 version of the
	  Genius Mouse programmer's reference; it has been changed to conform
	  to the Microsoft version shown above by version 9.06 (and possibly
	  earlier versions)
SeeAlso: AX=0001h,AX=0002h,AX=0007h,AX=0010h"MS MOUSE"

Format of update region list:
Offset	Size	Description
 00h	WORD	left-most column
 02h	WORD	top-most row
 04h	WORD	right-most column
 06h	WORD	bottom-most row
--------M-330011-----------------------------
INT 33 - Genius Mouse 9.06 - GET NUMBER OF BUTTONS
	AX = 0011h
Return: AX = FFFFh
	BX = number of buttons
SeeAlso: AX=0000h
--------M-330012-----------------------------
INT 33 - MS MOUSE - SET LARGE GRAPHICS CURSOR BLOCK
	AX = 0012h
	BH = cursor width in words
	CH = rows in cursor
	BL = horizontal hot spot (-16 to 16)
	CL = vertical hot spot (-16 to 16)
	ES:DX -> bit map of screen and cursor maps
Return: AX = FFFFh if successful
SeeAlso: AX=0009h,AX=002Ah,AX=0035h
--------M-330013-----------------------------
INT 33 - MS MOUSE - DEFINE DOUBLE-SPEED THRESHOLD
	AX = 0013h
	DX = threshold speed in mickeys/second, 0000h = default of 64/second
Note:	if speed exceeds threshold, the cursor's on-screen motion is doubled
SeeAlso: AX=000Fh,AX=001Bh,AX=002Ch
--------M-330014-----------------------------
INT 33 - MS MOUSE - EXCHANGE INTERRUPT SUBROUTINES
	AX = 0014h
	CX = call mask (see AX=000Ch)
	ES:DX -> FAR routine
Return: CX = call mask of previous interrupt routine
	ES:DX = FAR address of previous interrupt routine
SeeAlso: AX=000Ch,AX=0018h
--------M-330015-----------------------------
INT 33 - MS MOUSE - RETURN DRIVER STORAGE REQUIREMENTS
	AX = 0015h
Return: BX = size of buffer needed to store driver state
SeeAlso: AX=0016h,AX=0017h,AX=0042h
--------M-330016-----------------------------
INT 33 - MS MOUSE - SAVE DRIVER STATE
	AX = 0016h
	BX = size of buffer (see AX=0015h)
	ES:DX -> buffer for driver state
Note:	although not documented, many drivers appear to require BX on input
SeeAlso: AX=0015h,AX=0017h
--------M-330017-----------------------------
INT 33 - MS MOUSE - RESTORE DRIVER STATE
	AX = 0017h
	BX = size of buffer (see AX=0015h)
	ES:DX -> buffer containing saved state
Notes:	although not documented, many drivers appear to require BX on input
	some mouse drivers range-check the values in the saved state based on
	  the current video mode; thus, the video mode should be restored
	  before the mouse driver's state is restored
SeeAlso: AX=0015h,AX=0016h
--------M-330018-----------------------------
INT 33 - MS MOUSE - SET ALTERNATE MOUSE USER HANDLER
	AX = 0018h
	CX = call mask (see below)
	ES:DX -> FAR routine
Return: AX = 0018h if successful
	   = FFFFh on error
Notes:	when the subroutine is called, it is passed the following values:
	  AX = condition mask (same bit assignments as call mask)
	  BX = button state
	  CX = cursor column
	  DX = cursor row
	  SI = horizontal mickey count
	  DI = vertical mickey count
	up to three handlers can be defined by separate calls to this function
	some versions of the documentation erroneously reverse the order of
	  the bits in the call mask
SeeAlso: AX=000Ch,AX=0014h,AX=0019h

Bitfields for call mask:
 bit 0	call if mouse moves
 bit 1	call if left button pressed
 bit 2	call if left button released
 bit 3	call if right button pressed
 bit 4	call if right button released
 bit 5	call if shift button pressed during event
 bit 6	call if ctrl key pressed during event
 bit 7	call if alt key pressed during event
--------M-330019-----------------------------
INT 33 - MS MOUSE - RETURN USER ALTERNATE INTERRUPT VECTOR
	AX = 0019h
	CX = call mask (see AX=0018h)
Return: BX:DX = user interrupt vector
	CX = call mask (0000h if not found)
Note:	attempts to find a user event handler (defined by function 18h)
	  whose call mask matches CX
SeeAlso: AX=0018h
--------M-33001A-----------------------------
INT 33 - MS MOUSE - SET MOUSE SENSITIVITY
	AX = 001Ah
	BX = horizontal speed \
	CX = vertical speed   / (see AX=000Fh)
	DX = double speed threshold (see AX=0013h)
SeeAlso: AX=0013h,AX=001Bh,INT 62/AX=0082h
--------M-33001B-----------------------------
INT 33 - MS MOUSE - RETURN MOUSE SENSITIVITY
	AX = 001Bh
Return: BX = horizontal speed
	CX = vertical speed
	DX = double speed threshold
SeeAlso: AX=000Bh,AX=001Ah
--------M-33001C-----------------------------
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
--------M-33001D-----------------------------
INT 33 - MS MOUSE - DEFINE DISPLAY PAGE NUMBER
	AX = 001Dh
	BX = display page number
Note:	the cursor will be displayed on the specified page
SeeAlso: AX=001Eh
--------M-33001E-----------------------------
INT 33 - MS MOUSE - RETURN DISPLAY PAGE NUMBER
	AX = 001Eh
Return: BX = display page number
SeeAlso: AX=001Dh
--------M-33001F-----------------------------
INT 33 - MS MOUSE - DISABLE MOUSE DRIVER
	AX = 001Fh
Return: AX = 001Fh unsuccessful
	     FFFFh successful
	ES:BX = vector for INT 33 before mouse driver was first installed
Notes:	restores vectors for INT 10 and INT 71 (8086) or INT 74 (286/386)
	if you restore INT 33 to ES:BX, driver will be completely disabled
	many drivers return AX=001Fh even though the driver has been disabled
SeeAlso: AX=0020h
--------M-330020-----------------------------
INT 33 - MS MOUSE - ENABLE MOUSE DRIVER
	AX = 0020h
Return: AX = 0020h unsuccessful (or driver not installed)
	     FFFFh successful
Notes:	restores vectors for INT 10h and INT 71h (8086) or INT 74h (286/386)
	  which were removed by function 1Fh
	many drivers return AX=0020h even though the driver has been enabled
SeeAlso: AX=001Fh
--------M-330021-----------------------------
INT 33 - MS MOUSE - SOFTWARE RESET
	AX = 0021h
Return: AX = FFFFh if mouse driver installed
		BX = number of buttons (FFFFh = two buttons)
	     0021h if mouse driver not installed
Note:	identical to funtion 00h, but does not reset the mouse
SeeAlso: AX=0000h
--------M-330022-----------------------------
INT 33 - MS MOUSE - SET LANGUAGE FOR MESSAGES
	AX = 0022h
	BX = language (see below)
Note:	only available on international versions of the driver; US versions
	  ignore this call
SeeAlso: AX=0023h

Values for language:
 00h	English
 01h	French
 02h	Dutch
 03h	German
 04h	Swedish
 05h	Finnish
 06h	Spanish
 07h	Portugese
 08h	Italian
--------M-330023-----------------------------
INT 33 - MS MOUSE - GET LANGUAGE FOR MESSAGES
	AX = 0023h
Return: BX = language (see AX=0022h)
Note:	the US version of the driver always returns zero
SeeAlso: AX=0022h
--------M-330024-----------------------------
INT 33 - MS MOUSE v6.26+ - GET SOFTWARE VERSION, MOUSE TYPE, AND IRQ NUMBER
	AX = 0024h
Return: AX = FFFFh on error
	otherwise,
	    BH = major version
	    BL = minor version
	    CH = type (1=bus, 2=serial, 3=InPort, 4=PS/2, 5=HP)
	    CL = interrupt (0=PS/2, 2=IRQ2, 3=IRQ3,...,7=IRQ7)
SeeAlso: AX=004Dh,AX=006Dh
--------M-330025-----------------------------
INT 33 - MS MOUSE v6.26+ - GET GENERAL DRIVER INFORMATION
	AX = 0025h
Return: AX = general information
	    bit 15: driver loaded as device driver rather than TSR
	    bit 14: driver is newer integrated type
	    bits 13,12: current cursor type
			00 software text cursor
			01 hardware text cursor
			1X graphics cursor
	    bits 11-8: interrupt rate (see AX=001Ch)
	    bits 7-0:  count of currently-active Mouse Display Drivers (MDD),
			the newer integrated driver type
	BX = cursor lock flag for OS/2 to prevent reentrancy problems
	CX = mouse code active flag (for OS/2)
	DX = mouse driver busy flag (for OS/2)
--------M-330026-----------------------------
INT 33 - MS MOUSE v6.26+ - GET MAXIMUM VIRTUAL COORDINATES
	AX = 0026h
Return: BX = mouse-disabled flag
	CX = maximum virtual X (for current video mode)
	DX = maximum virtual Y
SeeAlso: AX=0031h
--------M-330026-----------------------------
INT 33 - Genius Mouse 9.06 - ???
	AX = 0026h
Return: CX = 0204h if CX was 0105h on entry, else unchanged
--------M-330027-----------------------------
INT 33 - MS MOUSE v7.01+ - GET SCREEN/CURSOR MASKS AND MICKEY COUNTS
	AX = 0027h
Return: AX = screen-mask value (or hardware cursor scan-line start for v7.02+)
	BX = cursor-mask value (or hardware cursor scan-line stop for v7.02+)
	CX = horizontal mickeys moved since last call
	DX = vertical mickeys moved since last call
SeeAlso: AX=000Bh
--------M-330028-----------------------------
INT 33 - MS MOUSE v7.0+ - SET VIDEO MODE
	AX = 0028h
	CX = new video mode (call is NOP if 0000h)
	DH = Y font size (00h = default)
	DL = X font size (00h = default)
Return: CL = status (00h = successful)
Note:	DX is ignored unless the selected video mode supports font size control
SeeAlso: AX=0029h,INT 10/AH=00h
--------M-330029-----------------------------
INT 33 - MS MOUSE v7.0+ - ENUMERATE VIDEO MODES
	AX = 0029h
	CX = previous video mode
	    0000h get first supported video mode
	    other get next supported mode after mode CX
Return: CX = first/next video mode (0000h = no more video modes)
	DS:DX -> description of video mode or 0000h:0000h if none
Notes:	the enumerated video modes may be in any order and may repeat
	the description string (if available) is terminated by '$' followed by
	  a NUL byte
SeeAlso: AX=0028h
--------M-33002A-----------------------------
INT 33 - MS MOUSE v7.02+ - GET CURSOR HOT SPOT
	AX = 002Ah
Return: AX = internal counter controlling cursor visibility
	BX = cursor hot spot column
	CX = cursor hot spot row
	DX = mouse type (00h none, 01h bus, 02h serial, 03h InPort, 04h IBM,
			 05h Hewlett-Packard)
Note:	the hot spot location is relative to the upper left corner of the
	  cursor block and may range from -128 to +127 both horizontally and
	  vertically
SeeAlso: AX=0009h,AX=0012h,AX=0035h
--------M-33002B-----------------------------
INT 33 - MS MOUSE v7.0+ - LOAD ACCELERATION PROFILES
	AX = 002Bh
	BX = active acceleration profile
		0001h-0004h or FFFFh to restore default curves
	ES:SI -> buffer containing acceleration profile data (see below)
Return: AX = success flag
SeeAlso: AX=002Ch,AX=002Dh,AX=0033h

Format of acceleration profile data:
Offset	Size	Description
 00h	BYTE	length of acceleration profile 1
 01h	BYTE	length of acceleration profile 2
 02h	BYTE	length of acceleration profile 3
 03h	BYTE	length of acceleration profile 4
 04h 32 BYTEs	threshold speeds for acceleration profile 1
 24h 32 BYTEs	threshold speeds for acceleration profile 2
 44h 32 BYTEs	threshold speeds for acceleration profile 3
 64h 32 BYTEs	threshold speeds for acceleration profile 4
 84h 32 BYTEs	speedup factor for acceleration profile 1
		(10h = 1.0, 14h = 1.25, 20h = 2.0, etc)
 A4h 32 BYTEs	speedup factor for acceleration profile 2
		(10h = 1.0, 14h = 1.25, 20h = 2.0, etc)
 C4h 32 BYTEs	speedup factor for acceleration profile 3
		(10h = 1.0, 14h = 1.25, 20h = 2.0, etc)
 E4h 32 BYTEs	speedup factor for acceleration profile 4
		(10h = 1.0, 14h = 1.25, 20h = 2.0, etc)
104h 16 BYTEs	name of acceleration profile 1 (blank-padded)
114h 16 BYTEs	name of acceleration profile 2 (blank-padded)
124h 16 BYTEs	name of acceleration profile 3 (blank-padded)
134h 16 BYTEs	name of acceleration profile 4 (blank-padded)
Note:	unused bytes in the threshold speed fields are filled with 7Fh and
	  unused bytes in the speedup factor fields are filled with 10h
--------M-33002C-----------------------------
INT 33 - MS MOUSE v7.0+ - GET ACCELERATION PROFILES
	AX = 002Ch
Return: AX = status (0000h success)
	BX = currently-active acceleration profile
	ES:SI -> acceleration profile data (see AX=002Bh)
SeeAlso: AX=002Bh,AX=002Dh,AX=0033h
--------M-33002D-----------------------------
INT 33 - MS MOUSE v7.0+ - SELECT ACCELERATION PROFILE
	AX = 002Dh
	BX = acceleration level
		0001h-0004h to set profile, or FFFFh to get current profile
Return: AX = status
	    0000h successful
		ES:SI -> 16-byte blank-padded name of acceleration profile
	    FFFEh invalid acceleration curve number
		ES:SI destroyed
	BX = active acceleration curve number
SeeAlso: AX=0013h,AX=002Bh,AX=002Ch,AX=002Eh
--------M-33002E-----------------------------
INT 33 - MS MOUSE v8.10+ - SET ACCELERATION PROFILE NAMES
	AX = 002Eh
	BL = flag (if nonzero, fill ES:SI buffer with default names on return)
	ES:SI -> 64-byte buffer for profile names (16 bytes per name)
Return: AX = status (0000h success)
	ES:SI buffer filled with default names if BL nonzero on entry
Note:	not supported by Logitech driver v6.10
SeeAlso: AX=002Ch,AX=002Dh,AX=012Eh,AX=022Eh
--------M-33002F-----------------------------
INT 33 - MS MOUSE v7.02+ - MOUSE HARDWARE RESET
	AX = 002Fh
Return: AX = status
Note:	invoked by mouse driver v8.20 on being called with INT 2F/AX=530Bh
SeeAlso: INT 2F/AH=53h
--------M-330030-----------------------------
INT 33 - MS MOUSE v7.04+ - GET/SET BallPoint INFORMATION
	AX = 0030h
	CX = command
	    0000h get status of BallPoint device
	    other set rotation angle and masks
		BX = rotation angle (-32768 to 32767 degrees)
		CH = primary button mask
		CL = secondary button mask
Return: AX = button status (FFFFh if no BallPoint)
		bit 5: button 1
		bit 4: button 2
		bit 3: button 3
		bit 2: button 4
		other: zero
	BX = rotation angle (0-360 degrees)
	CH = primary button mask
	CL = secondary button mask
--------M-330031-----------------------------
INT 33 - MS MOUSE v7.05+ - GET CURRENT MINIMUM/MAXIMUM VIRTUAL COORDINATES
	AX = 0031h
Return: AX = virtual X minimum
	BX = virtual Y minimum
	CX = virtual X maximum
	DX = virtual Y maximum
Note:	the minimum and maximum values are those set by AX=0007h and AX=0008h;
	  the default is minimum = 0 and maximum = absolute maximum
	  (see AX=0026h)
SeeAlso: AX=0007h,AX=0008h,AX=0010h,AX=0026h
--------M-330032-----------------------------
INT 33 - MS MOUSE v7.05+ - GET ACTIVE ADVANCED FUNCTIONS
	AX = 0032h
Return: AX = active function flags (FFFFh for v8.10)
		bit 15: function 0025h supported
		bit 14: function 0026h supported
		...
		bit 0:	function 0034h supported
	BX = ??? (0000h) officially unused
	CX = ??? (E000h) officially unused
	DX = ??? (0000h) officially unused
--------M-330033-----------------------------
INT 33 - MS MOUSE v7.05+ - GET SWITCH SETTINGS AND ACCELERATION PROFILE DATA
	AX = 0033h
	CX = size of buffer
	    0000h get required buffer size
		Return: AX = 0000h
			CX = required size (0154h for Logitech v6.10, 0159h
				for MS v8.10-8.20)
	    other
		ES:DX -> buffer of CX bytes
		Return: AX = 0000h
			CX = number of bytes returned
			ES:DX buffer filled (see below)
SeeAlso: AX=002Bh

Format of data buffer:
Offset	Size	Description
 00h	BYTE	mouse type
 01h	BYTE	current language
 02h	BYTE	horizontal sensitivity (00h-64h)
 03h	BYTE	vertical sensitivity (00h-64h)
 04h	BYTE	double-speed threshold (00h-64h)
 05h	BYTE	ballistic curve (01h-04h)
 06h	BYTE	interrupt rate (01h-04h)
 07h	BYTE	cursor override mask
 08h	BYTE	laptop adjustment
 09h	BYTE	memory type (00h-02h)
 0Ah	BYTE	SuperVGA support (00h,01h)
 0Bh	BYTE	rotation angle
 0Ch	BYTE	???
 0Dh	BYTE	primary button (01h-04h)
 0Eh	BYTE	secondary button (01h-04h)
 0Fh	BYTE	click lock enabled (00h,01h)
 10h 324 BYTEs	acceleration profile data (see AX=002Bh)
154h  5 BYTEs	??? (Microsoft driver, but not Logitech)
--------M-330034-----------------------------
INT 33 - MS MOUSE v8.0+ - GET INITIALIZATION FILE
	AX = 0034h
Return: AX = status (0000h successful)
	ES:DX -> ASCIZ initialization (.INI) file name
--------M-330035-----------------------------
INT 33 - MS MOUSE v8.10+ - LCD SCREEN LARGE POINTER SUPPORT
	AX = 0035h
	BX = function
	    FFFFh get current settings
		Return: AX = 0000h
			BH = style (see below)
			BL = size (see below)
			CH = threshold
			CL = active flag (00h disabled, 01h enabled)
			DX = delay
	    other
		BH = style (00h normal, 01h reverse, 02h transparent)
		BL = size (00h small "1", 01h medium "1.5", 02h large "2")
		CH = threshold (00h-64h)
		CL = active flag (00h disable size change, 01h enable)
		DX = delay (0000h-0064h)
		Return: AX = 0000h
Note:	not supported by Logitech driver v6.10
SeeAlso: AX=0012h,AX=002Ah
--------M-330042-----------------------------
INT 33 - PCMOUSE - GET MSMOUSE STORAGE REQUIREMENTS
	AX = 0042h
Return: AX = FFFFh successful
		BX = buffer size in bytes for functions 50h and 52h
	   = 0000h MSMOUSE not installed
	   = 0042h functions 42h, 50h, and 52h not supported
Note:	this function is also supported by the Genius Mouse 9.06 driver
SeeAlso: AX=0015h,AX=0050h,AX=0052h
--------M-330043-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - CONFIGURE MOUSE???
	AX = 0043h
	CX:BX -> ??? buffer (see below)
	DL = ???
Return: ???
Notes:	also calls routines for INT 33/AX=0053h and INT 33/AX=004Fh
	this function is also supported by the Genius Mouse 9.06 driver

Format of buffer:
Offset	Size	Description
 00h	WORD	I/O port address
 02h	BYTE	???
 03h	BYTE	interrupt number
 04h	BYTE	interrupt mask for interrupt controller
 05h  5 BYTEs	???
--------M-330044CXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - TOGGLE ???
	AX = 0044h
	CX = CDEFh
Return: AX = new state of ???
Note:	this function is also supported by the Genius Mouse 9.06 driver
SeeAlso: AX=0045h
--------M-330045CXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - TOGGLE ???
	AX = 0045h
	CX = CDEFh
Return: AX = new state of ???
Note:	this function is also supported by the Genius Mouse 9.06 driver
SeeAlso: AX=0044h
--------M-330047-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - SET BUTTON ASSIGNMENTS
	AX = 0047h
	ES:BX -> button assignments (3 bytes, combinations of "L", "M", "R")
Return: ???
Note:	also supported by Genius Mouse 9.06 driver
SeeAlso: AX=0067h
--------M-330048BXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - GET ???
	AX = 0048h
	BX = CDEFh
Return: CX = ???
	BH = ???
	BL = ??? (if 50h, driver is using PS/2 pointing device BIOS interface)
Note:	also supported by Genius Mouse 9.06 driver
--------M-33004B-----------------------------
INT 33 - Z-NIX MOUSE DRIVER v7.04d - INSTALLATION CHECK
	AX = 004Bh
Return: ES:DI -> signature/description string if installed
Note:	the signature string in v7.04d is
	  "Z-NIX;BUS,AUX,Serial 3-byte and 5-byte Mouse Driver;ZMOUSE;v7.04d"
--------M-33004CBXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - SET ??? FLAG
	AX = 004Ch
	BX = CDEFh
Note:	also supported by Genius Mouse 9.06
SeeAlso: AX=006Ch
--------M-33004D-----------------------------
INT 33 - MS MOUSE - RETURN POINTER TO COPYRIGHT STRING
	AX = 004Dh
Return: ES:DI -> copyright message "*** This is Copyright 1983 Microsoft"
Notes:	also supported by Logitech, Kraft, Genius Mouse, and Mouse Systems
	  mouse drivers
	in the Genius Mouse 9.06 driver, the ASCIZ signature "KYE" immediately
	  follows the above copyright message (KYE Corp. manufactures the
	  driver)
SeeAlso: AX=0024h,AX=006Dh
--------M-33004F-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - ENABLE MOUSE
	AX = 004Fh
Return: nothing
Note:	also supported by Genius Mouse 9.06
SeeAlso: AX=0043h,AX=0053h
--------M-330050-----------------------------
INT 33 - PCMOUSE - SAVE MSMOUSE STATE
	AX = 0050h
	BX = buffer size (ignored by some driver versions)
	ES:DX -> buffer
Return: AX = FFFFh if successful
Notes:	the buffer must be large enough to hold the entire state, or following
	  data will be overwritten by state data in versions which ignore BX;
	  use INT 33/AX=0042h to get the required size
	this function is also supported by the Genius Mouse 9.06 driver
SeeAlso: AX=0042h,AX=0052h
--------M-330052-----------------------------
INT 33 - PCMOUSE - RESTORE MSMOUSE STATE
	AX = 0052h
	BX = buffer size (ignored by some driver versions)
	ES:DX -> buffer
Return: AX = FFFFh if successful
Note:	also supported by Genius Mouse 9.06 driver
SeeAlso: AX=0050h
--------M-330053-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - DISABLE MOUSE
	AX = 0053h
Return: nothing
Note:	also supported by Genius Mouse 9.06
SeeAlso: AX=0043h,AX=004Fh
--------M-330054CXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - SELECT ULTRARES ACCELERATION LEVEL
	AX = 0054h
	CX = CDEFh
	BX = ??? (NOP if <= 0000h)
Return: ???
Note:	this function is also supported by the Genius Mouse 9.06 driver
SeeAlso: AX=005Ah
--------M-330055-----------------------------
INT 33 - Kraft Mouse - GET ???
	AX = 0055h
Return: CX = ???
	DX = ???
	ES = ???
--------M-330058-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - ???
	AX = 0058h
Return: AX = CS of driver
	CX:BX = original INT 33 vector
	DX = ???
Note:	this function is also supported by the Genius Mouse 9.06 driver
--------M-33005A-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - SET ULTRARES ACCELERATIONS
	AX = 005Ah
	CX = number of WORDs to copy (max 0014h, but not range-checked)
	DX:SI -> buffer containing thresholds??? (CX words)
	DX:BX -> buffer containing acceleration values???
		(9*14h words, only first CX of each 14h used)
	???
Return: CF clear
	???
Note:	this function is also supported by Genius Mouse 9.06
SeeAlso: AX=0054h
--------M-330061BXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - ???
	AX = 0061h
	BX = CDEFh
Return: CX = ???
Note:	also supported by Genius Mouse 9.06
--------M-330067-----------------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - GET MOUSE BUTTONS???
	AX = 0067h
Return: BL = number of buttons???
Note:	also supported by Genius Mouse 9.06
SeeAlso: AX=0047h
--------M-33006CBXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - CLEAR ??? FLAG
	AX = 006Ch
	BX = CDEFh
Note:	also supported by Genius Mouse 9.06
SeeAlso: AX=004Ch
--------M-33006D-----------------------------
INT 33 - MS MOUSE - GET VERSION STRING
	AX = 006Dh
Return: ES:DI -> Microsoft version number of resident driver (see below)
Notes:	also supported by Logitech, Mouse Systems, Kraft, and Genius mouse
	  drivers
	the Mouse Systems 7.01 and Genius Mouse 9.06 drivers report their
	  Microsoft version as 7.00 even though they do not support any of the
	  functions from 0025h through 002Dh supported by the MS 7.00 driver
	  (the Genius Mouse driver supports function 0026h, but it differs
	  from the Microsoft function)
SeeAlso: AX=0024h,AX=004Dh,AX=266Ch

Format of Microsoft version number:
Offset	Size	Description
 00h	BYTE	major version
 01h	BYTE	minor version (BCD)
--------M-330070BXABCD-----------------------
INT 33 - Mouse Systems MOUSE DRIVER - POPUP.COM - INSTALLATION CHECK
	AX = 0070h
	BX = ABCDh
Return: AX = ABCDh if installed
	    BX:CX -> data structure (see below)
Notes:	this function is also supported by the Genius Mouse 9.06 driver
	the v7.01 POPUP.COM and menu drivers also check for the signature
	  CDh ABh BAh DCh at offset -2Ch from the interrupt handler
	if POPUP is not loaded, the returned data structure contains the proper
	  signature at offset 00h, but not at offset 08h

Format of data structure:
Offset	Size	Description
 00h	WORD	signature ABCDh
 02h	DWORD	pointer to info structure???
 06h  2 BYTEs	???
 08h	WORD	signature ABCDh

Format of info structure:
Offset	Size	Description
 00h	WORD	driver version
 02h  8 BYTEs	???
 0Ah	WORD	segment of ???
	???
--------M-330072BXABCD-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - ???
	AX = 0072h
	BX = ABCDh
Return: ???
Note:	this function is also supported by the Genius Mouse 9.06 driver
--------M-330073BXCDEF-----------------------
INT 33 - Mouse Systems MOUSE DRIVER v7.01 - GET BUTTON ASSIGNMENTS
	AX = 0073h
	BX = CDEFh
	ES:DX -> 3-byte buffer for button assignments
Return: CX = number of buttons???
	ES:DX buffer filled (default is "LMR")
Note:	also supported by Genius Mouse 9.06
SeeAlso: AX=0067h
--------M-33012E-----------------------------
INT 33 - MS MOUSE v8.10+ - ???
	AX = 012Eh
	BL = ???
Return: AX = 0000h
Note:	not supported by Logitech driver v6.10
SeeAlso: AX=002Eh,AX=022Eh
--------M-33022E-----------------------------
INT 33 - MS MOUSE v8.10+ - ???
	AX = 022Eh
	BL = ???
Return: AX = 0000h
Note:	not supported by Logitech driver v6.10
SeeAlso: AX=002Eh,AX=012Eh
--------M-33136C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 136Ch
	BX = ???
Return: AX = ???
	BX = ???
--------M-33146C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - GET/SET ???
	AX = 146Ch
	BL = function
	    00h set ???
		BH = new value (zero/nonzero to clear/set)
	    else get ???
		Return: ???
--------M-33156C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - GET SIGNATURE AND VERSION STRINGS
	AX = 156Ch
Return: ES:DI -> signature "LOGITECH MOUSE DRIVER"
	ES:SI -> version string, terminated with CRLF
--------M-33166C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 166Ch
	BL = ???
	    00h ???
	    01h ???
	    other ???
		BH = new value of ???
		Return: AX = FFFFh
--------M-33176C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 176Ch
	???
Return: ???
--------M-33186C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 186Ch
	???
Return: ???
--------M-33196C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 196Ch
	???
Return: ???
--------M-331A6C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - GET ???
	AX = 1A6Ch
Return: AX = FFFFh
	BX = ???
	CX = ???
SeeAlso: AX=1B6Ch
--------M-331B6C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - SET ???
	AX = 1B6Ch
	BX = new value for ??? (0000h-0003h)
Return: AX = FFFFh
SeeAlso: AX=1A6Ch
--------M-331C6C-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 1C6Ch
	BX = ???
		<42h ???
		=42h ???
		>42h ???
			ES:DI -> ???
			Return: AX = ???
--------M-331D6C-----------------------------
INT 33 - LOGITECH MOUSE - GET COMPASS PARAMETER
	AX = 1D6Ch
Return: BX = direction (0=north, 1=south, 2=east, 3=west)
SeeAlso: AX=1E6Ch
--------M-331E6C-----------------------------
INT 33 - LOGITECH MOUSE - SET COMPASS PARAMETER
	AX = 1E6Ch
	BX = direction (0=north, 1=south, 2=east, 3=west)
SeeAlso: AX=1D6Ch
--------M-331F6C-----------------------------
INT 33 - LOGITECH MOUSE - GET BALLISTICS INFORMATION
	AX = 1F6Ch
Return: BX = 0=off, 1=on
	CX = 1=low, 2=high
SeeAlso: AX=002Ch,AX=236Ch
--------M-33206C-----------------------------
INT 33 - LOGITECH MOUSE - SET LEFT OR RIGHT PARAMETER
	AX = 206Ch
	BX = parameter (00h = right, FFh = left)
SeeAlso: AX=216Ch
--------M-33216C-----------------------------
INT 33 - LOGITECH MOUSE - GET LEFT OR RIGHT PARAMETER
	AX = 216Ch
Return: BX = parameter (00h = right, FFh = left)
SeeAlso: AX=206Ch
--------M-33226C-----------------------------
INT 33 - LOGITECH MOUSE - REMOVE DRIVER FROM MEMORY
	AX = 226Ch
Note:	this only frees memory; does not restore hooked interrupts
--------M-33236C-----------------------------
INT 33 - LOGITECH MOUSE - SET BALLISTICS INFORMATION
	AX = 236Ch
	BX = 0=off, 1=on
	CX = 1=low, 2=high
SeeAlso: AX=002Ch,AX=1F6Ch
--------M-33246C-----------------------------
INT 33 - LOGITECH MOUSE - GET PARAMETERS AND RESET SERIAL MOUSE
	AX = 246Ch
	ES:DX -> parameter table buffer (see below)
Return: AX = FFFFh if driver installed for serial mouse
SeeAlso: AX=0000h,AX=256Ch/BX=0000h,AX=256Ch/BX=0001h,AX=256Ch/BX=0003h

Format of parameter table:
Offset	Size	Description
 00h	WORD	baud rate divided by 100  (serial mouse only)
 02h	WORD	emulation		  (serial mouse only)
 04h	WORD	report rate		  (serial mouse only)
 06h	WORD	firmware revision	  (serial mouse only)
 08h	WORD	00h			  (serial mouse only)
 0Ah	WORD	port			  (serial mouse only)
 0Ch	WORD	physical buttons
 0Eh	WORD	logical buttons
--------M-33256CBX0000-----------------------
INT 33 - LOGITECH MOUSE - SET PARAMETERS - SET BAUD RATE (SERIAL MOUSE ONLY)
	AX = 256Ch
	BX = 0000h
	CX = rate (0=1200, 1=2400, 2=4800, 3=9600)
Return: AX = FFFFh if driver installed for serial mouse
SeeAlso: AX=246Ch,AX=256Ch/BX=0001h,AX=256Ch/BX=0002h,AX=276Ch
--------M-33256CBX0001-----------------------
INT 33 - LOGITECH MOUSE - SET PARAMETERS - SET EMULATION (SERIAL MOUSE ONLY)
	AX = 256Ch
	BX = 0001h
	CX = emulation
	    00h 5 byte packed binary
	    01h 3 byte packed binary
	    02h hexadecimal
	    03h relative bit pad
	    04h not supported
	    05h MM Series
	    06h not supported
	    07h Microsoft
Return: AX = FFFFh if driver installed for serial mouse
SeeAlso: AX=246Ch,AX=256Ch/BX=0000h,AX=256Ch/BX=0003h,AX=276Ch
--------M-33256CBX0002-----------------------
INT 33 - LOGITECH MOUSE - SET PARAMETERS - SET REPORT RATE (SERIAL MOUSE ONLY)
	AX = 256Ch
	BX = 0002h
	CX = rate (0=10, 1=20, 2=35, 3=50, 4=70, 5=100, 6=150)
Return: AX = FFFFh if driver installed for serial mouse
SeeAlso: AX=246Ch,AX=256Ch/BX=0001h,AX=256Ch/BX=0003h,AX=276Ch
--------M-33256CBX0003-----------------------
INT 33 - LOGITECH MOUSE - SET PARAMETERS - SET MOUSE PORT (SERIAL MOUSE ONLY)
	AX = 256Ch
	BX = 0003h
	CX = port (1, 2)
Return: AX = FFFFh if driver installed for serial mouse
SeeAlso: AX=246Ch,AX=256Ch/BX=0000h,AX=256Ch/BX=0004h,AX=276Ch
--------M-33256CBX0004-----------------------
INT 33 - LOGITECH MOUSE - SET PARAMETERS - SET MOUSE LOGICAL BUTTONS
	AX = 256Ch
	BX = 0004h
	CX = buttons (2, 3)
Return: AX = FFFFh if driver installed for serial mouse
SeeAlso: AX=246Ch,AX=276Ch
--------M-33266C-----------------------------
INT 33 - LOGITECH MOUSE - GET VERSION???
	AX = 266Ch
Return: BX = 'SS'
	CH = '4'  major version number
	CL = '1'  minor version number
SeeAlso: AX=006Dh
--------M-33276C-----------------------------
INT 33 - LOGITECH MOUSE - ??? Tries MMSeries, Baud 2400
	AX = 276Ch
SeeAlso: AX=256Ch
--------M-333000-----------------------------
INT 33 - Smooth Mouse Driver, PrecisePoint - INSTALLATION CHECK
	AX = 3000h
Return: AX = FFFFh if installed
	    BX = version number (BH = major, BL = minor)
Program: SMD is a programmer's library by Andy Hakim which provides a
	  graphics-style mouse cursor in text mode.  PrecisePoint is an
	  SMD-based TSR which replaces the block mouse cursor in text
	  applications.
SeeAlso: AX=0000h,AX=3001h,AX=3003h
--------M-333001-----------------------------
INT 33 - Smooth Mouse Driver, PrecisePoint - ENABLE SMOOTH MOUSE
	AX = 3001h
Return: AX = status (0000h = disabled, 0001h = enabled)
Note:	SMD remains disabled if running under Desqview or in graphics mode
SeeAlso: AX=0001h,AX=0002h,AX=3002h
--------M-333002-----------------------------
INT 33 - Smooth Mouse Driver, PrecisePoint - DISABLE SMOOTH MOUSE
	AX = 3002h
Return: AX = status (0000h = disabled, 0001h = enabled)
SeeAlso: AX=0001h,AX=0002h,AX=3000h,AX=3001h
--------M-333003-----------------------------
INT 33 - Smooth Mouse Driver, PrecisePoint - GET INFORMATION
	AX = 3003h
	BL = data structure selector
	    00h Primary Bitmap (used for 25 line mode)
	    01h Secondary Bitmap (used for 43/50 line modes)
	    02h Sacrifice Character Map
	    03h Program Information
Return: ES:DX -> selected data structure
SeeAlso: AX=3000h

Format of Primary/Secondary Bitmap [SMD_BITMAP_STRUCT]
Offset	Size	Description
 00h	BYTE	vertical size of bitmap (00h - 10h)
 01h	BYTE	horizontal size of bitmap (00h - 10h)
 02h	BYTE	vertical hotspot position (00h - 10h)
 03h	BYTE	horizontal hotspot position (00h - 10h)
 04h 16 WORDs	cursor bitmap data
 14h 16 WORDs	screen bitmap data

Format of Sacrifice Character Map [SMD_SMAP_STRUCT]
Offset	Size	Description
 00h	BYTE	bytes are character values (00h-FFh) used in place of the
 01h	BYTE	actual character for the corresponding position on the screen
 02h	BYTE	     +--------------+	  occupied by part or all of the mouse
 03h	BYTE	     | 0h | 1h | 2h |	  cursor
 04h	BYTE	     |----+----+----|
 05h	BYTE	     | 3h | 4h | 5h |
 06h	BYTE	     |----+----+----|
 07h	BYTE	     | 6h | 7h | 8h |
 08h	BYTE	     +--------------+

Format of Program Information [SMD_INFO_STRUCT]
Offset	Size	Description
 00h	WORD	segment of old interrupt 33h handler
 02h	WORD	offset of old interrupt 33h handler
 04h	WORD	PSP of SMD
 06h	BYTE	ENABLE/DISABLE manual setting status
 07h	BYTE	ENABLE/DISABLE internal usage status
--------M-333004-----------------------------
INT 33 - Smooth Mouse Driver, PrecisePoint - RESERVED FUTURE EXPANSION
	AX = 3004h
SeeAlso: AX=3000h
--------M-333005-----------------------------
INT 33 - Smooth Mouse Driver, PrecisePoint - RESERVED FUTURE EXPANSION
	AX = 3005h
SeeAlso: AX=3000h
--------M-334F00-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - GET ???
	AX = 4F00h
Return: AX = 004Fh if supported
	BX = ???
	ES:DI -> ???
SeeAlso: AX=4F01h
--------M-334F01-----------------------------
INT 33 - LOGITECH MOUSE v6.10+ - ???
	AX = 4F01h
	ES = ???
Return: AX = 004Fh if supported
	ES:DI -> ???
SeeAlso: AX=4F00h
--------T-33FFE6-----------------------------
INT 33 - Switch-It v3.23 - GET ??? PROGRAM
	AX = FFE6h
	CX = length of buffer
	ES:DI -> buffer for program name
Return: ES:DI buffer filled
Program: Switch-It is a task switcher supporting up to 100 programs
	  simultaneously by Better Software Technology, Inc.
--------T-33FFE7-----------------------------
INT 33 - Switch-It v3.23 - GET ???
	AX = FFE7h
Return: AX = ???
--------T-33FFE8-----------------------------
INT 33 - Switch-It v3.23 - ???
	AX = FFE8h
	CX = length of name including terminating NUL
	DS:SI -> ASCIZ program pathname
--------T-33FFE9-----------------------------
INT 33 - Switch-It v3.23 - SET ???
	AX = FFE9h
	BX = ???
--------T-33FFEA-----------------------------
INT 33 - Switch-It v3.23 - SET ???
	AX = FFEAh
	BL = ???
--------T-33FFEB-----------------------------
INT 33 - Switch-It v3.23 - SET ??? FLAG
	AX = FFEBh
--------T-33FFEC-----------------------------
INT 33 - Switch-It v3.23 - SET ???
	AX = FFECh
	BL = ???
--------T-33FFED-----------------------------
INT 33 - Switch-It v3.23 - GET ???
	AX = FFEDh
Return: AX = ??? (0001h)
	BX = ???
Program: Switch-It is a task switcher supporting up to 100 programs
	  simultaneously by Better Software Technology, Inc.
--------T-33FFEE-----------------------------
INT 33 - Switch-It v3.23 - GET ???
	AX = FFEEh
Return: AX = ???
--------T-33FFEF-----------------------------
INT 33 - Switch-It v3.23 - GET ???
	AX = FFEFh
Return: BX:AX -> ???
--------T-33FFF0-----------------------------
INT 33 - Switch-It v3.23 - SET ???
	AX = FFF0h
	BL = ???
--------T-33FFF1-----------------------------
INT 33 - Switch-It v3.23 - GET CONFIGURATION FILE
	AX = FFF1h
Return: BX:AX -> ASCIZ pathname of configuration file
Program: Switch-It is a task switcher supporting up to 100 programs
	  simultaneously by Better Software Technology, Inc.
--------T-33FFF2-----------------------------
INT 33 - Switch-It v3.23 - SET ??? FLAG
	AX = FFF2h
Return: AL = 01h
--------T-33FFF3-----------------------------
INT 33 - Switch-It v3.23 - GET ???
	AX = FFF3h
Return: AX = ???
--------T-33FFF4-----------------------------
INT 33 - Switch-It v3.23 - SET ???
	AX = FFF4h
	BX = ???
	CX = ???
--------T-33FFF5-----------------------------
INT 33 - Switch-It v3.23 - GET ???
	AX = FFF5h
Return: AX = ???
--------T-33FFF6-----------------------------
INT 33 - Switch-It v3.23 - GET ???
	AX = FFF6h
Return: AX = ???
--------T-33FFF7-----------------------------
INT 33 - Switch-It v3.23 - GET ???
	AX = FFF7h
	BX = index of ???
Return: AX = ???
--------T-33FFF8-----------------------------
INT 33 - Switch-It v3.23 - ???
	AX = FFF8h
	BX = ???
	CX = length of program name, including terminating NUL
	DS:SI -> ASCIZ program pathname
Return: ???
Program: Switch-It is a task switcher supporting up to 100 programs
	  simultaneously by Better Software Technology, Inc.
--------T-33FFF9-----------------------------
INT 33 - Switch-It v3.23 - NOP
	AX = FFF9h
--------T-33FFFA-----------------------------
INT 33 - Switch-It v3.23 - SET ???
	AX = FFFAh
	BX = index of program
SeeAlso: AX=FFFBh,AX=FFFCh
--------T-33FFFB-----------------------------
INT 33 - Switch-It v3.23 - GET ???
	AX = FFFBh
	BX = index of program
Return: AX = ??? (0000h or 0001h)
SeeAlso: AX=FFFAh,AX=FFFCh
--------T-33FFFC-----------------------------
INT 33 - Switch-It v3.23 - CLEAR ???
	AX = FFFCh
	BX = index of program
SeeAlso: AX=FFFAh,AX=FFFCh
--------T-33FFFD-----------------------------
INT 33 - Switch-It v3.23 - GET MEMORY ADDRESSES???
	AX = FFFDh
Return: AX = first available segment???
	BX = paragraph of top of conventional memory
	DX = PSP segment of SI.EXE
--------T-33FFFE-----------------------------
INT 33 - Switch-It v3.23 - INSTALLATION CHECK
	AX = FFFEh
Return: BX = ???
	DX = 5349h ("SI")
--------T-33FFFF-----------------------------
INT 33 - Switch-It v3.23 - ???
	AX = FFFFh
	BX = ???
Program: Switch-It is a task switcher supporting up to 100 programs
	  simultaneously by Better Software Technology, Inc.
--------r-34---------------------------------
INT 34 - FLOATING POINT EMULATION - OPCODE D8h
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of D8h
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 35,INT 3E
--------r-35---------------------------------
INT 35 - FLOATING POINT EMULATION - OPCODE D9h
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of D9h
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 34,INT 36
--------r-36---------------------------------
INT 36 - FLOATING POINT EMULATION - OPCODE DAh
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of DAh
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 35,INT 37
--------r-37---------------------------------
INT 37 - FLOATING POINT EMULATION - OPCODE DBh
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of DBh
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 36,INT 38
--------r-38---------------------------------
INT 38 - FLOATING POINT EMULATION - OPCODE DCh
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of DCh
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 37,INT 39
--------O-38---------------------------------
INT 38 - PC-MOS/386 v3.0 - API
Note:	this API was been moved to INT D4h sometime between versions 3.0 and
	  5.01; v3.0 supported at least functions 02h,04h,0703h,10h,11h, and
	  12h
SeeAlso: INT D4/AH=02h,INT D4/AH=04h,INT D4/AH=07h,INT D4/AH=10h,INT D4/AH=11h
--------r-39---------------------------------
INT 39 - FLOATING POINT EMULATION - OPCODE DDh
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of DDh
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 38,INT 3A
--------r-3A---------------------------------
INT 3A - FLOATING POINT EMULATION - OPCODE DEh
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of DEh
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 39,INT 3B
--------r-3B---------------------------------
INT 3B - FLOATING POINT EMULATION - OPCODE DFh
Desc:	this interrupt is used to emulate floating-point instructions with
	  an opcode of DFh
Note:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
SeeAlso: INT 3A,INT 3C
--------r-3C---------------------------------
INT 3C - FLOATING POINT EMULATION - INSTRUCTIONS WITH SEGMENT OVERRIDE
Notes:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
	the generated code is  CD 3C xy mm ....
	  where xy is a modified ESC instruction and mm is the modR/M byte.
	  The xy byte appears to be encoded as
		s s 0 1 1 x x x	  or	s s 0 0 0 x x x
	  where "ss" specifies the segment override:
		00 -> DS:
		01 -> SS:
		10 -> CS:
		11 -> ES:
SeeAlso: INT 3B,INT 3D
--------r-3D---------------------------------
INT 3D - FLOATING POINT EMULATION - STANDALONE FWAIT
Notes:	the floating-point emulators in Borland and Microsoft languages and
	  Lahey FORTRAN use this interrupt
	this vector is modified but not restored by Direct Access v4.0, and
	  may be left dangling by other programs written with the same version
	  of compiled BASIC
SeeAlso: INT 3C,INT 3E
--------r-3E---------------------------------
INT 3E - FLOATING POINT EMULATION - Borland LANGUAGES "SHORTCUT" CALL
Notes:	the two bytes following the INT 3E instruction are the subcode and
	  a NOP (90h), except for subcodes DCh and DEh, where the second byte
	  is a register count (01h-08h)
	this vector is modified but not restored by Direct Access v4.0, and
	  may be left dangling by other programs written with the same version
	  of compiled BASIC
SeeAlso: INT 3D

Values for subcode:
Subcode		Function
 DCh	load 8086 stack with 8087 registers; overwrites the 10*N bytes at the
	  top of the stack prior to the INT 3E with the 8087 register contents
 DEh	load 8087 registers from top of 8086 stack; ST0 is furthest from top
	  of 8086 stack
 E0h	round TOS and R1 to single precision, compare, pop twice
	  returns AX=8087 status word, FLAGS=8087 condition bits
 E2h	round TOS and R1 to double precision, compare, pop twice
	  returns AX=8087 status word, FLAGS=8087 condition bits
	Note: buggy in TPas5.5, because it sets the 8087 precision control
	  field to the undocumented value 01h; this results in actually
	  rounding to single precision
 E4h	compare TOS/R1 with two POP's
	  returns FLAGS=8087 condition bits
 E6h	compare TOS/R1 with POP
	  returns FLAGS=8087 condition bits
 E8h	FTST (check TOS value)
	  returns FLAGS=8087 condition bits
 EAh	FXAM (check TOS value)
	  returns AX=8087 status word
 ECh	sine(ST0)
 EEh	cosine(ST0)
 F0h	tangent(ST0)
 F2h	arctangent(ST0)
 F4h	ST0 = ln(ST0)
 F6h	ST0 = log2(ST0)
 F8h	ST0 = log10(ST0)
 FAh	ST0 = e**ST0
 FCh	ST0 = 2**ST0
 FEh	ST0 = 10**ST0
--------r-3F---------------------------------
INT 3F - Overlay manager interrupt (Microsoft LINK.EXE, Borland TLINK VROOMM)
Notes:	INT 3F is the default, and may be overridden while linking
	this vector is modified but not restored by Direct Access v4.0, and
	  may be left dangling by other programs written with the same version
	  of compiled BASIC
SeeAlso: INT FE"OVERLAY"
--------r-3F---------------------------------
INT 3F - Microsoft Dynamic Link Library manager
SeeAlso: INT 21/AH=4Bh
--------B-40---------------------------------
INT 40 - DISKETTE - ROM BIOS DISKETTE HANDLER RELOCATED BY HARD DISK BIOS
SeeAlso: INT 13,INT 47"SuperBIOS",INT 63
--------h-40---------------------------------
INT 40 - Z100 - Master 8259 - Parity error or S100 error
SeeAlso: INT 41"Z100",INT FF"Z100"
--------O-40---------------------------------
INT 40 - Acorn BBC Master 512 - "OSFIND" - OPEN FILE
	AL = operation
	    00h close file
	    40h open file for reading
	    80h open file for writing
	    C0h open file for random access
	DS:BX -> CR-terminated filename
Return: AL = file handle (00h if file closed or could not be opened)
Note:	the Acorn BBC Master 512 is an 80186-based add-on board for the
	  6502-based Master 128 which uses the original CPU as an I/O processor
SeeAlso: INT 41"Acorn",INT 42"Acorn",INT 43"Acorn",INT 44"Acorn",INT 4C"Acorn"
--------B-41---------------------------------
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
 0Ah	BYTE	formatting timeout (XT and WD1002 only, 0 for others)
 0Bh	BYTE	timeout for checking drive (XT and WD1002 only, 0 for others)
 0Ch	WORD	cylinder number of landing zone (AT and later only)
 0Eh	BYTE	number of sectors per track (AT and later only)
 0Fh	BYTE	reserved
--------h-41---------------------------------
INT 41 - Z100 - Master 8259 - Processor Swap
SeeAlso: INT 40"Z100",INT 42"Z100"
--------O-41---------------------------------
INT 41 - Acorn BBC Master 512 - "OSGBPB" - MULTI-BYTE GET/PUT
	AL = function
	    01h put bytes sequentially
	    02h put bytes, ignoring sequential pointer
	    03h get bytes sequentially
	    04h get bytes, ignoring sequential pointer
	    05h get media title and boot option
	    06h get current device and directory
	    07h get current library and device
	    08h search directory
	DS:BX -> control block (see below)
Return: CF clear if successful
	CF set on error
	AL = 00h if operation attempted
	AL unchanged if unsupported function
SeeAlso: INT 40"Acorn",INT 42"Acorn",INT 43"Acorn"

Format of control block:
Offset	Size	Description
 00h	BYTE	file handle
 01h	DWORD	pointer to data in either I/O processor or Tube processor
 05h	DWORD	number of bytes to be transferred
 09h	DWORD	transfer address
--------G-4112-------------------------------
INT 41 P - MS Windows debugging kernel - "OutputDebugString"
	AH = 12h
	???
Return: ???
SeeAlso: AH=50h
--------G-4150-------------------------------
INT 41 P - MS Windows debugging kernel - "DefineDebugSegment"
	AH = 50h
	???
Return: ???
SeeAlso: AH=12h
--------V-42---------------------------------
INT 42 - VIDEO - RELOCATED DEFAULT INT 10 VIDEO SERVICES (EGA,VGA)
SeeAlso: INT 10
Note:	not used by PS/2 built-in VGA or XGA
--------h-42---------------------------------
INT 42 - Z100 - Master 8259 - Timer
SeeAlso: INT 41"Z100",INT 43"Z100"
--------b-42---------------------------------
INT 42 - Western Digital WD1002 SuperBIOS - INT 40 CASCADE
Note:	if the second WD1002 controller in the system finds INT 40 already in
	  use, it uses this vector to cascade to the first controller's BIOS
SeeAlso: INT 40"DISKETTE",INT 47"SuperBIOS"
--------O-42---------------------------------
INT 42 - Acorn BBS Master 512 - "OSBPUT" - WRITE SINGLE BYTE TO FILE
	AL = byte to be written
	BH = file handle
Return: flags destroyed
SeeAlso: INT 40"Acorn",INT 41"Acorn",INT 43"Acorn",INT 47"Acorn",INT 49"Acorn"
--------V-43---------------------------------
INT 43 - VIDEO DATA - CHARACTER TABLE (EGA,MCGA,VGA)
   points at graphics data for characters 00h-7Fh of the current font
SeeAlso: INT 1F,INT 44"VIDEO"
--------h-43---------------------------------
INT 43 - Z100 - Master 8259 - Slave 8259 input
Note:	slave runs in special fully nested mode
SeeAlso: INT 42"Z100",INT 44"Z100"
--------O-43---------------------------------
INT 43 - Acorn BBC Master 512 - "OSBGET" - READ SINGLE BYTE FROM FILE
	BH = file handle
Return: CF clear if successful
	    AL = byte read from file
	CF set on error
SeeAlso: INT 40"Acorn",INT 41"Acorn",INT 42"Acorn",INT 46"Acorn"
--------V-44---------------------------------
INT 44 - VIDEO DATA - ROM BIOS CHARACTER FONT, CHARACTERS 00h-7Fh (PCjr)
   points at graphics data for current character font
SeeAlso: INT 1F,INT 43"VIDEO"
--------N-44---------------------------------
INT 44 - Novell NetWare - HIGH-LEVEL LANGUAGE API
--------I-44---------------------------------
INT 44 - IBM 3270-PC High Level Language API
	DS:SI -> parameter control block
--------h-44---------------------------------
INT 44 - Z100 - Master 8259 - Serial A
SeeAlso: INT 43"Z100",INT 45"Z100"
--------v-44---------------------------------
INT 44 - VIRUS - "Lehigh" - ORIGINAL INT 21h VECTOR
SeeAlso: INT 32"VIRUS",INT 60"VIRUS",INT 70"VIRUS",INT 9E"VIRUS"
--------O-4400-------------------------------
INT 44 - Acorn BBC Master 512 - "OSARGS" - GET/SET FILE PARAMS FOR OPEN FILE
	AH = 00h
	AL = function
	    00h get current filing system
		Return: AL = filing system (see below)
	    01h get address of commandline tail
		Return: BX buffer filled with address of command tail in I/O
				processor address space (use INT 4A/AL=05h to
				retrieve)
	    FFh flush all files onto secondary storage
	BX -> 4-byte data buffer
Note:	the commandline tail is terminated with a carriage return (0Dh)
SeeAlso: INT 40"Acorn",INT 45"Acorn"

Values for filing system:
 00h	none
 01h	1200 bps cassette
 02h	300 bps cassette
 03h	ROM FS
 04h	DFS
 05h	ANFS/NFS
 06h	TFS
 08h	ADFS
--------O-44---------------------------------
INT 44 - Acorn BBC Master 512 - "OSARGS" - GET/SET FILE PARAMS FOR OPEN FILE
	AH = nonzero file handle
	    AL = function
		00h get sequential pointer for file
		01h set sequential pointer for file
		02h get length of file
	BX -> 4-byte data buffer
Return: BX buffer updated if appropriate
SeeAlso: INT 40"Acorn",INT 41"Acorn",INT 44/AH=00h,INT 45"Acorn",INT 4A"Acorn"
--------h-45---------------------------------
INT 45 - Z100 - Master 8259 - Serial B
SeeAlso: INT 44"Z100",INT 46"Z100"
--------O-45---------------------------------
INT 45 - Acorn BBC Master 512 - "OSFILE" - READ/WRITE FILE OR DIRECTORY INFO
	AL = function
	    00h save block of memory as file
	    01h update directory entry for existing file
	    02h set load address for existing file
	    03h set execution address for existing file
	    04h set attributes for existing file
	    05h read directory
	    06h delete file
	    FFh load file
	DS:BX -> control block (see below)
Return: FLAGS destroyed
	AL = file type
	    00h not found
	    01h file found
	    02h directory found
	    FFh protected file
SeeAlso: INT 40"Acorn",INT 41"Acorn",INT 44"Acorn",INT 46"Acorn"

Format of control block:
Offset	Size	Description
 00h	WORD	address of CR-terminated filename
 02h	DWORD	load address of file
 06h	DWORD	execution address of file
 0Ah	DWORD	start address of data to save
 0Eh	DWORD	end address of data to save, or file attributes
		file attributes in low byte (see below)
		other three bytes are filing-system specific file attributes

Bitfields for file attributes:
 bit 0	no owner read access
 bit 1	no owner write access
 bit 2	not executable by owner
 bit 3	not deletable by owner
 bit 4	no public read access
 bit 5	no public write access
 bit 6	not executable with public access
 bit 7	not deletable with public access
--------B-46---------------------------------
INT 46 - SYSTEM DATA - HARD DISK 1 DRIVE PARAMETER TABLE
SeeAlso: INT 13/AH=09h,INT 41
--------h-46---------------------------------
INT 46 - Z100 - Master 8259 - Keyboard, Retrace, and Light Pen
SeeAlso: INT 45"Z100",INT 47"Z100"
--------O-46---------------------------------
INT 46 - Acorn BBC Master 512 - "OSRDCH" - GET CHARACTER FROM CUR INPUT STREAM
Return: CF clear if successful
	    AL = character read
	CF set on error
	    AL = error code
SeeAlso: INT 40"Acorn",INT 43"Acorn",INT 47"Acorn",INT 49"Acorn"
--------h-47---------------------------------
INT 47 - Z100 - Master 8259 - Printer
SeeAlso: INT 46"Z100",INT 48"Z100"
--------O-47---------------------------------
INT 47 - Acorn BBC Master 512 - "OSWRCH" - WRITE CHARACTER TO CUR OUTPUT STREAM
	AL = character to be written
Return: FLAGS destroyed
SeeAlso: INT 40"Acorn",INT 46"Acorn",INT 49"Acorn"
--------b-47---------------------------------
INT 47 - Western Digital WD1002-27X SuperBIOS - INT 40 CASCADE
Desc:	used by the second WD1002-27X controller to cascade to the first
	  controller's INT 40
SeeAlso: INT 40"DISKETTE",INT 42"SuperBIOS",INT 48"SuperBIOS"
----------478000-----------------------------
INT 47 - SQL Base - DATABASE ENGINE API
	AX = 8000h
	DS:BX -> parameter block, first word is function number
Program: SQL Base is a network-oriented database engine by Gupta Technologies
SeeAlso: AX=8001h

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
Program: SQL Base is a network-oriented database engine by Gupta Technologies
SeeAlso: AX=8000h
--------B-48---------------------------------
INT 48 - KEYBOARD - CORDLESS KEYBOARD TRANSLATION (PCjr)
SeeAlso: INT 49"PCjr"
--------h-48---------------------------------
INT 48 - Z100 - Slave 8259 - S100 vectored line 0
SeeAlso: INT 47"Z100",INT 49"Z100"
--------N-48---------------------------------
INT 48 - Watstar PC Network data pointer 1
SeeAlso: INT 49"Watstar"
--------O-48---------------------------------
INT 48 - Acorn BBC Master 512 - "OSNEWL" - SEND NEWLINE TO OUTPUT STREAM
Return: FLAGS destroyed
Note:	writes a carriage return (0Dh) followed by a linefeed (0Ah)
SeeAlso: INT 40"Acorn",INT 47"Acorn",INT 49"Acorn"
--------b-48---------------------------------
INT 48 - Western Digital WD1002-27X SuperBIOS - DRIVE DATA (NOT A VECTOR!)
Note:	the second WD1002-27X controller in a system uses the low byte to
	  store the number of drives controlled by the second controller,
	  and the high word for temporary storage during track recalculation;
	  the first controller uses offsets 74h-77h in the BIOS data area
	  (see MEMORY.LST) to store data
SeeAlso: INT 47"SuperBIOS"
----------48---------------------------------
INT 48 U - Compaq UILIB.EXE - API
	AX = function (see below)
	BX = call type (0002h) (see AX=1A70h)
	???
Return: ???
Note:	returns AX=FFFFh if 1000h<=AX<=2000h and AX is not one of the functions
	  listed below
SeeAlso: AX=1A70h

Values for function:
 1000h	1160h	12D0h	1430h	1570h	1680h	17F0h	1920h	1A90h
 1010h	1170h	12E0h	1440h	1578h	1690h	1800h	1930h	1AA0h
 1020h	1180h	12F0h	1450h	1580h	16A0h	1810h	1940h
 1030h	1190h	1300h	1460h	1590h	16B0h	1820h	1950h
 1040h	11A0h	1310h	1470h	1594h	16C0h	1830h	1960h
 1050h	11B0h	1320h	1480h	1598h	16D0h	1840h	1970h
 1060h	11C0h	1330h	1490h	15A0h	16E0h	1848h	1980h
 1070h	11D0h	1340h	14A0h	15B0h	16F0h	1850h	1990h
 1080h	11E0h	1350h	14B0h	15C0h	1700h	1860h	19A0h
 1090h	11F0h	1360h	14B8h	15D0h	1710h	1870h	19B0h
 1095h	1200h	1370h	14BBh	15D4h	1720h	1878h	19C0h
 1098h	1210h	1380h	14C0h	15D8h	1730h	1880h	19D0h
 10A0h	1220h	1390h	14D0h	15E0h	1735h	1890h	19E0h
 10C0h	1230h	13A0h	14E0h	15F0h	1740h	1898h	19F0h
 10D0h	1240h	13B0h	14F0h	1600h	1750h	18A0h	1A00h
 10E0h	1250h	13B8h	1500h	1610h	1770h	18B0h	1A10h
 10F0h	1260h	13C0h	1508h	1620h	1780h	18C0h	1A20h
 1100h	1270h	13D0h	1510h	1630h	1790h	18D0h	1A30h
 1110h	1280h	13E0h	1520h	1640h	17A0h	18E0h	1A40h
 1120h	1290h	13F0h	1530h	1650h	17B0h	18F0h	1A50h
 1130h	12A0h	1400h	1540h	1660h	17C0h	1900h	1A60h
 1140h	12B0h	1410h	1550h	1664h	17D0h	1909h	1A70h
 1150h	12C0h	1420h	1560h	1670h	17E0h	1910h	1A80h
----------481A70-----------------------------
INT 48 U - Compaq UILIB.EXE - INSTALLATION CHECK
	AX = 1A70h
	BX = call type (see below)
Return: CX = 5649h ('VI') if installed
	DX = 4557h ('EW') if installed
	    AX = version??? (0106h)

Values for call type:
 0000h	near
 0001h	far
 0002h	INT (only valid call type when using INT 48)
 0003h	near
--------B-49---------------------------------
INT 49 - SYSTEM DATA - NON-KEYBOARD SCAN-CODE TRANSLATION TABLE (PCjr)
SeeAlso: INT 48"PCjr"

Format of translation table:
Offset	Size	Description
 00h	BYTE	number of nonkeyboard scancodes in the table
 01h  N WORDs	high byte 00h (NUL) byte scancode with low order byte
		representing the scancode mapped values relative to their
		input values within the range of 56h through 7Eh
--------h-49---------------------------------
INT 49 - Z100 - Slave 8259 - S100 vectored line 1
SeeAlso: INT 48"Z100",INT 4A"Z100"
----------49---------------------------------
INT 49 - Texas Instruments PC - VIDEO I/O???
	apparently provides direct video display on the TI Professional PC
--------N-49---------------------------------
INT 49 - Watstar PC Network data pointer 2
SeeAlso: INT 49"Watstar"
--------O-49---------------------------------
INT 49 - Acorn BBC Master 512 - "OSASCI" - WRITE CHARACTER TO CUR OUTPUT STREAM
	AL = character to be written
Return: FLAGS destroyed
Note:	converts carriage return (0Dh) into CRLF sequence (0Dh 0Ah)
SeeAlso: INT 40"Acorn",INT 46"Acorn",INT 47"Acorn",INT 48"Acorn"
--------a-490001-----------------------------
INT 49 - MAGic v1.16+ - TURN ON MAGNIFICATION
	AX = 0001h
Return: AX = status (see below)
	BX,CX,DX destroyed
Program: MAGic (MAGnification In Color) is a TSR by Microsystems Software, Inc.
	  providing 2x2 text and graphics magnification on VGA, XGA, and SVGA
Note:	INT 49 is the default, but may be overridden on the commandline.  The
	  actual interrupt in use may be found by searching for the signature
	  "MAGic" or "xMAGic" (for the deluxe version) immediately preceding
	  the interrupt handler (this is also the installation check).	MAGic
	  uses CodeRunneR, which places the signature "RT" at offset 0000h in
	  the interrupt handler's segment, followed by MAGic's TSR ID of
	  "VMAG".
SeeAlso: AX=0001h,AX=0003h,AX=0004h,AX=0008h
Index:	installation check;MAGic

Values for status:
 0000h	cannot magnify current video mode
 0002h	magnified (text mode)
 0003h	magnified (graphics mode)
 FFFDh	function works only in magnified mode
 FFFFh	MAGic busy, retry later
--------a-490002-----------------------------
INT 49 - MAGic v1.16+ - TURN OFF MAGNIFICATION
	AX = 0002h
Return: AX = status (see AX=0001h)
	BX,CX,DX destroyed
SeeAlso: AX=0001h
--------a-490003-----------------------------
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
--------a-490004-----------------------------
INT 49 - MAGic v1.16+ - REPOSITION MAGNIFIED WINDOW
	AX = 0004h
	BX = vertical position of upper left corner
	DX = horizontal position
Return: AX = status (see AX=0003h)
	BX,CX,DX destroyed
SeeAlso: AX=0001h,AX=0003h,AX=0005h
--------a-490005-----------------------------
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
--------a-490006-----------------------------
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
--------a-490007-----------------------------
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
--------a-490008-----------------------------
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
--------B-4A---------------------------------
INT 4A C - SYSTEM - USER ALARM HANDLER
Desc:	This interrupt is invoked by the BIOS when a real-time clock alarm
	  occurs; an application may use it to perform an action at a
	  predetermined time.
Note:	this interrupt is called from within a hardware interrupt handler,
	  so all usual precautions against reentering DOS must be taken
SeeAlso: INT 1A/AH=06h
--------h-4A---------------------------------
INT 4A - Z100 - Slave 8259 - S100 vectored line 2
SeeAlso: INT 49"Z100",INT 4B"Z100"
--------O-4A---------------------------------
INT 4A - Acorn BBC Master 512 - "OSWORD" - MISC FUNCTIONS USING CONTROL BLOCK
	AL = function code
	    FAh transfer data between 80186 and 65C12 I/O processor
	DS:BX -> control block (see below)
Return: FLAGS destroyed
	control block updated
Note:	there are more functions than are listed here, but details are not
	  available
SeeAlso: INT 40"Acorn",INT 4B"Acorn",INT 4C"Acorn"

Format of control block for function FAh:
Offset	Size	Description
 00h	BYTE	number of parameters sent to I/O processor (0Dh,0Eh)
 01h	BYTE	number of parameters read from I/O processor (01h)
 02h	DWORD	I/O processor address
 06h	DWORD	80186 segment:offset address
 0Ah	WORD	number of bytes to transfer
 0Ch	BYTE	operation type
		00h write to 65C12 at 24 us/byte
		01h read from 65C12 at 24 us/byte
		02h write to 65C12 at 26 us/word
		03h read from 65C12 at 26 us/word
		04h write to 65C12 at 10 us/byte using 256-byte blocks
		05h read from 65C12 at 10 us/byte using 256-byte blocks
 0Dh	BYTE	65C12 memory access control (only used if offset 00h = 0Eh)
		bit 7: unused
		bit 6: always use main screen memory if I/O addr 3000h-7FFFh
			(overrides bit 5)
		bit 5: use shadow screen memory if screen address specified
		bit 4: use current ROM rather than ROM selected by bits 3-0
			(only if I/O address between 8000h and BFFFh)
		bits 3-0: paged ROM number
--------h-4B---------------------------------
INT 4B - Z100 - Slave 8259 - S100 vectored line 3
SeeAlso: INT 4A"Z100",INT 4C"Z100"
--------d-4B---------------------------------
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
Index:	installation check;Common Access Method SCSI interface
--------O-4B---------------------------------
INT 4B - Acorn BBC Master 512 - "OSBYTE" - MISC FUNCTIONS USING REGISTER PARAMS
	AL = function code
	BL = first parameter
	BH = second parameter (if needed)
Return: BL = first return parameter
	BH = second return parameter
	CF depends on function
SeeAlso: INT 40"Acorn",INT 4A"Acorn",INT 4C"Acorn"
--------d-4B80-------------------------------
INT 4B - IBM SCSI interface
	AH = 80h
	details not yet available
--------d-4B8102DX0000-----------------------
INT 4B - Virtual DMA Specification (VDS) - GET VERSION
	AX = 8102h
	DX = 0000h
Return: CF clear if successful
	    AH = major version number
	    AL = minor version number
	    BX = product number (see below)
	    CX = product revision number
		always 0000h for QMAPS and HPMM.SYS
		always 0001h for Microsoft's EMM386.EXE v4.20-4.41
	    SI:DI = maximum DMA buffer size
	    DX = flags
		bit 0: PC/XT bus (DMA in first megabyte only)
		bit 1: physical buffer/remap region in first megabyte
		bit 2: automatic remap enabled
		bit 3: all memory is physically contiguous
		bits 4-15 reserved (zero)
	CF set on error
	    AL = error code (see below)
Note:	bit 5 of 0040h:007Bh is supposed to be set if VDS is supported; this is
	  apparently not always the case
SeeAlso: INT 2C/AX=002Bh,INT 31
Index:	installation check;Virtual DMA Spec

Values for product number:
 0000h	for Quadtel's QMAPS and Hewlett-Packard's HPMM.SYS
 0001h	for Microsoft's EMM386.EXE
 0003h	for Windows 3.x WIN386.EXE
 0EDCh	for DR-DOS 6.0 EMM386.SYS
 4560h	("E`") for Qualitas' 386MAX
 4D43h	("MC") for V Communication's Memory Commander
 5145h	("QE") for Quarterdeck's QEMM-386
 524Dh	("RM") for Helix's Netroom RM386

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
--------d-4B8103-----------------------------
INT 4B - Virtual DMA Specification - LOCK DMA REGION
	AX = 8103h
	DX = flags (see below)
	ES:DI -> DMA descriptor structure (see AX=8102h)
Return: CF clear if successful
	    DDS physical address field filled in
	    DDS buffer ID field filled (0000h if no buffer allocated)
	CF set on error
	    AL = error code (see AX=8102h)
	    DDS region size field filled wth maximum contiguous length in bytes
BUGS:	Windows 3.0 does not correctly support automatic remapping or copying
	  in enhanced mode
	Windows 3.0 in enhanced mode does not return a correct code on error
SeeAlso: AX=8104h,AX=8105h

Bitfields for flags:
 bit 0	reserved (zero)
 bit 1	data should be copied into buffer (ignored if bit 2 set)
 bit 2	buffer should not be allocated if region noncontiguous or crosses
	physical alignment boundary specified by bits 4-5
 bit 3	don't attempt automatic remap
 bit 4	region must not cross 64K physical alignment boundary
 bit 5	region must not cross 128K physical alignment boundary
 bits 6-15 reserved (zero)
--------d-4B8104-----------------------------
INT 4B - Virtual DMA Specification - UNLOCK DMA REGION
	AX = 8104h
	DX = flags
	    bit 0: reserved (zero)
	    bit 1: data should be copied out of buffer
	    bits 2-15 reserved (zero)
	ES:DI -> DMA descriptor structure (see AX=8102h) with region size,
		physical address, and buffer ID fields set
Return: CF clear if successful
	    DDS physical address field set
	    DDS buffer ID field set (0000h if no buffer allocated)
	CF set on error
	    AL = error code (see AX=8102h)
	    DDS region size field filled wth maximum contiguous length in bytes
Note:	Windows 3.0 does not check whether the region extends beyond the end of
	  a segment
BUG:	Windows 3.0 in enhanced mode does not return a correct code on error
SeeAlso: AX=8103h,AX=8106h
--------d-4B8105-----------------------------
INT 4B - Virtual DMA Specification - SCATTER/GATHER LOCK REGION
	AX = 8105h
	DX = flags
	    bits 0-5 reserved (zero)
	    bit 6: EDDS should be returned with page table entries
	    bit 7: only present pages should be locked (not-present pages
			receive entry of 0000h)
	    bits 8-15 reserved (zero)
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
BUG:	Windows 3.0 in enhanced mode may return zero instead of the physical
	  page address for pages which were originally not present
SeeAlso: AX=8103h,AX=8106h
--------d-4B8106-----------------------------
INT 4B - Virtual DMA Specification - SCATTER/GATHER UNLOCK REGION
	AX = 8106h
	DX = flags
	    bits 0-5 reserved (zero)
	    bit 6: EDDS contains page table entries
	    bit 7: EDDS may contain not-present pages (entry = 0000h)
	    bits 8-15 reserved (zero)
	ES:DI -> Extended DMA descriptor structure (see AX=8102h) returned
		by AX=8105h
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
Note:	according to the Microsoft version of the VDS specification, the
	  actual scatter/gather list is ignored, while according to the IBM
	  version of the specification, "the result of a LOCK operation"
	  must be provided to this function
SeeAlso: AX=8104h,AX=8105h
--------d-4B8107-----------------------------
INT 4B - Virtual DMA Specification - REQUEST DMA BUFFER
	AX = 8107h
	DX = flags
	    bit 0: reserved (zero)
	    bit 1: data should be copied into buffer
	    bits  2-15 reserved (zero)
	ES:DI -> DMA descriptor structure (see AX=8102h) with region size set
		(also region offset and region segment if DX bit 1 set)
Return: CF clear if successful
	    DDS physical address and buffer ID set
	    DDS region size filled with length of buffer
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=8108h
--------d-4B8108-----------------------------
INT 4B - Virtual DMA Specification - RELEASE DMA BUFFFER
	AX = 8108h
	DX = flags
	    bit 0: reserved (zero)
	    bit 1: data should be copied out of buffer
	    bits 2-15 reserved (zero)
	ES:DI -> DMA descriptor structure (see AX=8102h) with buffer ID set
		(also region size/region offset/segment if DX bit 1 set)
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
BUG:	under Windows 3.0 Enhanced mode, you must specify that data be copied
	  for this function to work correctly
SeeAlso: AX=8107h
--------d-4B8109DX0000-----------------------
INT 4B - Virtual DMA Specification - COPY INTO DMA BUFFER
	AX = 8109h
	DX = 0000h
	ES:DI -> DMA descriptor structure (see AX=8102h) with buffer ID,
		region segment/offset, and region size fields set
	BX:CX = starting offset into DMA buffer
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
BUG:	Windows 3.0 Enhanced mode does not correctly interpret the copy count
SeeAlso: AX=810Ah
--------d-4B810ADX0000-----------------------
INT 4B - Virtual DMA Specification - COPY OUT OF DMA BUFFER
	AX = 810Ah
	DX = 0000h
	ES:DI -> DMA descriptor structure (see AX=8102h) with buffer ID,
		region segment/offset, and region size fields set
	BX:CX = starting offset into DMA buffer
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
BUG:	Windows 3.0 Enhanced mode does not correctly interpret the copy count
SeeAlso: AX=8109h
--------d-4B810B-----------------------------
INT 4B - Virtual DMA Specification - DISABLE DMA TRANSLATION
	AX = 810Bh
	BX = DMA channel number
	DX = 0000h
Return: CF clear if successful
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=810Ch
--------d-4B810C-----------------------------
INT 4B - Virtual DMA Specification - ENABLE DMA TRANSLATION
	AX = 810Ch
	BX = DMA channel number
	DX = 0000h
Return: CF clear if successful
	    ZF set if disable count decremented to zero
	CF set on error
	    AL = error code (see AX=8102h)
SeeAlso: AX=810Bh
--------Q-4B810D-----------------------------
INT 4B - QEMM-386 - BUG
	AX = 810Dh
Note:	the code in QEMM v5.11 and 6.00 jumps to an invalid location on this
	  call
--------h-4C---------------------------------
INT 4C - Z100 - Slave 8259 - S100 vectored line 4
SeeAlso: INT 4B"Z100",INT 4D"Z100"
--------O-4C---------------------------------
INT 4C - Acorn BBC Master 512 - "OSCLI" - INTERPRET COMMAND LINE
	DS:BX -> CR-terminated command string
Return: FLAGS destroyed
SeeAlso: INT 40"Acorn",INT 4A"Acorn",INT 4B"Acorn"
--------h-4D---------------------------------
INT 4D - Z100 - Slave 8259 - S100 vectored line 5
SeeAlso: INT 4C"Z100",INT 4E"Z100"
--------d-4E---------------------------------
INT 4E - TI Professional PC - DISK I/O
	used instead of INT 13 on the TI Professional PC
SeeAlso: INT 13
--------h-4E---------------------------------
INT 4E - Z100 - Slave 8259 - S100 vectored line 6
SeeAlso: INT 4D"Z100",INT 4F"Z100"
--------h-4F---------------------------------
INT 4F - Z100 - Slave 8259 - S100 vectored line 7
SeeAlso: INT 4E"Z100"
--------d-4F8100-----------------------------
INT 4F - Common Access Method SCSI interface rev 2.3 - SEND CCB TO XPT/SIM
	AX = 8100h
	ES:BX -> CAM Control Block (CCB) (see below)
Return: AH = status
	    00h successful
	    01h invalid CCB address (0000h:0000h)
Note:	the SCSI Interface Module (SIM) may complete the requested function
	  and invoke the completion callback function before this call returns
SeeAlso: AX=8200h,INT 2F/AX=7F01h,INT 4B"Common Access Method"

Values for CAM function code:
 00h	NOP
 01h	execute SCSI I/O
 02h	get device type
 03h	path inquiry
 04h	release SIM queue
 05h	set async callback
 06h	set device type
 07h-0Fh reserved
 10h	abort SCSI command
 11h	reset SCSI bus
 12h	reset SCSI device
 13h	terminate I/O process
 14h-1Fh reserved
 20h	engine inquiry
 21h	execute engine request
 22h-2Fh reserved
 30h	enable logical unit number
 31h	execute target I/O
 32h-7Fh reserved
 80h-FFh vendor-specific functions

Format of CAM Control Block:
Offset	Size	Description
 00h	DWORD	physical address of this CCB
 04h	WORD	CAM control block length
 06h	BYTE	function code (see above)
 07h	BYTE	CAM status (see below)
 08h	BYTE	SCSI status
 09h	BYTE	path ID (FFh = XPT)
 0Ah	BYTE	target ID
 0Bh	BYTE	logical unit number
 0Ch	WORD	CAM flags (see below)
 0Eh	BYTE	CAM address flags (see below)
 0Fh	BYTE	target-mode flags (see below)
---function 02h---
 10h	DWORD	pointer to 36-byte buffer for inquiry data or 0000h:0000h
 14h	BYTE	peripheral device type of target logical unit number
---function 03h---
 10h	BYTE	version number (00h-07h prior to rev 1.7, 08h = rev 1.7,
		09h-FFh = rev no, i.e. 23h = rev 2.3)
 11h	BYTE	SCSI capabilities (see below)
 12h	BYTE	target mode support
		bit 7: processor mode
		bit 6: phase-cognizant mode
		bit 5-0: reserved
 13h	BYTE	miscellaneous flags
		bit 7: scanned high to low instead of low to high
		bit 6: removables not included in scan
		bit 5: inquiry data not kept by XPT
		bits 4-0: reserved
 14h	WORD	engine count
 16h 14 BYTEs	vendor-specific data
 24h	DWORD	size of private data area
 28h	DWORD	asynchronous event capabilities (see below)
 2Ch	BYTE	highest path ID assigned
 2Dh	BYTE	SCSI device ID of initiator
 2Eh  2 BYTEs	reserved
 30h 16 BYTEs	SIM vendor ID
 40h 16 BYTEs	HBA (host bus adaptor) vendor ID
 50h  4 BYTEs	operating-system dependant usage
---functions 00h,04h,11h,12h---
 no additional fields
---function 05h---
 10h	DWORD	asynchronous event enables (see function 03h above)
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

Bitfields for CAM flags:
 bit 0	CDB is a pointer
 bit 1	tagged queue action enable
 bit 2	linked CDB
 bit 3	disable callback on completion
 bit 4	scatter/gather
 bit 5	disable autosense
 bits 7-6 direction (00 reserved, 01 in, 10 out, 11 no data transfer)
 bits 9-8 reserved
 bit 10 engine synchronize
 bit 11 SIM queue freeze
 bit 12 SIM queue priority
	1 head insertion
	0 tail insertion (normal)
 bit 13 disable synchronous transfers	/ exclusive
 bit 14 initiate synchronous transfers	\ mutually
 bit 15 disable disconnect

Bitfields for CAM address flags:
 bit 7	SG list/data (0 = host, 1 = engine)
 bit 6	CDB pointer    (bits 6-1: 0=virtual addr, 1=phys addr)
 bit 5	SG list/data
 bit 4	sense buffer
 bit 3	message buffer
 bit 2	next CCB
 bit 1	callback on completion
 bit 0	reserved

Values for CAM status:
 00h	request in progress
 01h	request successful
 02h	host aborted request
 03h	unable to abort request
 04h	request completed with error
 05h	CAM is busy
 06h	invalid request
 07h	invalid path ID
 08h	no such SCSI device
 09h	unable to terminate I/O process
 0Ah	timeout on target selection
 0Bh	timeout on command
 0Dh	receive message rejection
 0Eh	sent/received SCSI bus reset
 0Fh	detected uncorrectable parity error
 10h	Autosense request failed
 11h	no HBA detected
 12h	data over/underrun
 13h	bus freed unexpectedly
 14h	target bus phase sequence failure
 15h	CCB too small
 16h	requested capability not available
 17h	sent bus device reset
 18h	terminate I/O process
 38h	invalid LUN
 39h	invalid target ID
 3Ah	unimplemented function
 3Bh	nexus not established
 3Ch	invalid initiator ID
 3Dh	received SCSI Command Descriptor Block
 3Eh	LUN already enabled
 3Fh	SCSI bus busy
Note:	bit 6 set to indicate frozen SIM queue
	bit 7 set to indicate valid autosense

Bitfields for target-mode flags:
 bit 7	data buffer valid
 bit 6	status valid
 bit 5	message buffer valid
 bit 4	reserved
 bit 3	phase-cognizant mode
 bit 2	target CCB available
 bit 1	disable autodisconnect
 bit 0	disable autosave/restore

Bitfields for SCSI capabilities:
 bit 7	modify data pointers
 bit 6	wide bus (32 bits)
 bit 5	wide bus (16 bits)
 bit 4	synchronous transfers
 bit 3	linked commands
 bit 2	reserved
 bit 1	tagged queueing
 bit 0	soft reset

Bitfields for asynchronous event capabilities:
 bits 31-24	vendor-specific
 bits 23-8	reserved
 bit 7	new devices found during rescan
 bit 6	SIM module deregistered
 bit 5	SIM module registered
 bit 4	sent bus device reset to target
 bit 3	SCSI AEN
 bit 2	reserved
 bit 1	unsolicited reselection
 bit 0	unsolicited SCSI bus reset

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
--------d-4F8200CX8765-----------------------
INT 4F - Common Access Method SCSI interface rev 2.3 - INSTALLATION CHECK
	AX = 8200h
	CX = 8765h
	DX = CBA9h
Return: AH = 00h if installed
	    CX = 9ABCh
	    DX = 5678h
	    ES:DI -> "SCSI_CAM"
SeeAlso: AX=8100h,INT 4B"Common Access Method"
--------N-50---------------------------------
INT 50 - TIL Xpert AIM (X.25)
	AH = function
--------H-50---------------------------------
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
SeeAlso: INT D8"Screen Thief"
--------H-50---------------------------------
INT 50 - IRQ0 relocated by IBM 3278 emulation control program
SeeAlso: INT 51"IBM 3278"
--------H-50---------------------------------
INT 50 - IRQ0 relocated by OS/2 v1.x
SeeAlso: INT 51"OS/2"
--------V-500000-----------------------------
INT 50 - Vanderaart TEXT WINDOWS, PC Thuis Shell - OPEN TEXT WINDOW
	AX = 0000h
	ES:BX -> name string or ES:0000h if none
	CH,CL = row,column of upper left corner
	DH,DL = row,column of lower right corner
Return: AX = window handle or
	    0000h if not installed
	    FFFFh on error
SeeAlso: AX=0001h,AX=0002h"TEXT WINDOWS"
--------V-500001-----------------------------
INT 50 - Vanderaart TEXT WINDOWS, PC Thuis Shell - CLOSE TEXT WINDOW
	AX = 0001h
	DI = window handle
SeeAlso: AX=0000h
--------V-500002-----------------------------
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
--------l-500002-----------------------------
INT 50 - PC Thuis Organizer Shell - PLOT TEXT
	AX = 0002h
	ES:BX -> text string
	DH,DL = row,column of upper left corner
	DI = window handle
Return: AX = status
	    0000h successful (text fits in window)
	    FFFFh error
Program: The PC Thuis Organizer Shell was written by John Vanderaart and
	  published in the June/July 1990 issue of PC Thuis Power magazine
--------V-500003-----------------------------
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
--------l-500003-----------------------------
INT 50 - PC Thuis Organizer Shell - WRITE FILE
	AX = 0003h
	ES:BX -> data to be written
	CX = number of bytes to write
	DS:SI -> filename
Return: AX = status
	    0000h successful
	    FFFFh error
SeeAlso: AX=0004h"Shell"
--------V-500004-----------------------------
INT 50 - Vanderaart TEXT WINDOWS - GET KEY
	AX = 0004h
	CH = type
	    00h any key
	    01h 'J' or 'N' (Dutch for yes/no)
Return: AX = key
SeeAlso: INT 16/AH=00h
--------l-500004-----------------------------
INT 50 - PC Thuis Organizer Shell - READ FILE
	AX = 0004h
	ES:BX -> buffer for data
	CX = number of bytes to read or 0000h for entire file
	DL = file type
	    01h setting shell
	    02h setting sterm
	    03h INT21 file
	DS:SI -> filename
Return: AX = status
	    0000h successful
	    FFFFh error
Note:	file type numbers are maintained by John Vanderaart; if a new file type
	  is needed, a type number should be requested from him through the
	  magazine:
		PC Thuis BV
		Spaarne 55
		2011 CE HAARLEM
		The Netherlands
SeeAlso: AX=0003h"Shell"
--------V-500005-----------------------------
INT 50 - Vanderaart TEXT WINDOWS - CHANGE ATTRIBUTE
	AX = 0005h
	BL = new attribute
	CH,CL = row,column of upper left corner
	DH,DL = row,column of lower right corner
	DI = window handle
--------l-500005-----------------------------
INT 50 - PC Thuis Organizer Shell - PROMPT YES/NO
	AX = 0005h
	ES:BX -> prompt string (ES:0000h if no prompt)
Return: AX = key pressed
	    0000h "J" (Dutch "Ja" = "Yes")
	    FFFFh "N" (Dutch "Nee" = "No")
Program: The PC Thuis Organizer Shell was written by John Vanderaart and
	  published in the June/July 1990 issue of PC Thuis Power magazine
SeeAlso: AX=0008h"PC Thuis"
--------V-500006-----------------------------
INT 50 - Vanderaart TEXT WINDOWS - EDIT LINE IN WINDOW
	AX = 0006h
	ES:BX -> text string
	CH = type of input (see below)
	DH,DL = row,column of upper left corner
	DI = window handle
Return: AX = key which terminated entry
	    0000h Enter
	    0001h Esc
	    0002h Down arrow
	    0003h Up arrow
	    0004h F10

Values for type of input:
 00h	everything
 01h	uppercase only
 02h	positive numbers
 03h	Dutch postal code ("9999 AA")
 04h	'J' or 'N' (Dutch yes/no)
 05h	telephone or FAX number
 06h	positive or negative number
 07h	date (dd/mm/yy)
 08h	money
 09h	'1' through '8'
 0Ah	'1' through '4'
 0Bh	uppercase filenames
--------l-500006-----------------------------
INT 50 - PC Thuis Organizer Shell - ALERT USER
	AX = 0006h
	ES:BX -> string
--------l-500007-----------------------------
INT 50 - PC Thuis Organizer Shell - DO LINE
	AX = 0007h
	ES:BX -> text string
	CX = string length in bytes (0000h if NUL-terminated)
	DL = FFh to center string, else flush left
	DH = upper left row
	DI = window handle
Return: AX = status
	    0000h successful
	    FFFFh error
Program: The PC Thuis Organizer Shell was written by John Vanderaart and
	  published in the June/July 1990 issue of PC Thuis Power magazine
SeeAlso: AX=0008h
--------l-500008-----------------------------
INT 50 - PC Thuis Organizer Shell - DO MENU
	AX = 0008h
	ES:BX -> menu structure
Return: AL = index 1 or FFh if not selected
	AH = index 2 or FFh if not selected
	BL = index 3 or FFh if not selected
	BH = index 4 or FFh if not selected
SeeAlso: AX=0005h"PC Thuis",AX=0007h,AX=000Ch
--------l-500009-----------------------------
INT 50 - PC Thuis Organizer Shell - MESSAGE ON
	AX = 0009h
	ES:BX -> message string
SeeAlso: AX=000Ah
--------l-50000A-----------------------------
INT 50 - PC Thuis Organizer Shell - MESSAGE OFF
	AX = 000Ah
SeeAlso: AX=0009h
--------l-50000B-----------------------------
INT 50 - PC Thuis Organizer Shell - CHANGE ATTRIBUTE
	AX = 000Bh
	BL = new attribute
	CH,CL = row,column of upper left corner
	DH,DL = row,column of lower right corner
	DI = window handle
--------l-50000C-----------------------------
INT 50 - PC Thuis Organizer Shell - DO REQUEST
	AX = 000Ch
	ES:BX -> request structure
Return: AX = status
	    0000h confirmed
	    FFFFh denied
SeeAlso: AX=0008h
--------l-50000D-----------------------------
INT 50 - PC Thuis Organizer Shell - EDIT LINE
	AX = 000Dh
	ES:BX -> text string
	CL = length
	CH = type
	    bit 0: force uppercase
	    bit 1: integer
	    bit 2: no spaces allowed
	    bit 3: no cursor keys
	DH,DL = row,column of upper left corner
	DI = window handle
Return: AX = result code
Program: The PC Thuis Organizer Shell was written by John Vanderaart and
	  published in the June/July 1990 issue of PC Thuis Power magazine
--------l-50000E-----------------------------
INT 50 - PC Thuis Organizer Shell - PLOT CHARACTER
	AX = 000Eh
	BL = character
	BH = attribute
	DH,DL = row,column at which to plot
	DI = window handle
Return: AX = status
	    0000h successful
	    FFFFh errror
--------l-50000F-----------------------------
INT 50 - PC Thuis Organizer Shell - EMPTY WINDOW
	AX = 000Fh
	BL = character
	BH = attribute
	DI = window handle
--------l-500010-----------------------------
INT 50 - PC Thuis Organizer Shell - TRACE MENU
	AX = 0010h
	ES:BX -> first menu structure
	CL = hotkey to look up
Return: AL = index 1 or FFh if not selected
	AH = index 2 or FFh if not selected
	BL = index 3 or FFh if not selected
	BH = index 4 or FFh if not selected
Index:	hotkeys;PC Thuis Organizer Shell
--------l-500011-----------------------------
INT 50 - PC Thuis Organizer Shell - MOVE MEMORY
	AX = 0011h
	DS:SI -> source
	ES:DI -> destination
	CX = number of bytes to move (0000h = until NUL string terminator???)
SeeAlso: AX=0012h
--------l-500012-----------------------------
INT 50 - PC Thuis Organizer Shell - COMPARE MEMORY
	AX = 0012h
	DS:SI -> source
	ES:DI -> destination
	CX = number of bytes to compare (0000h=until NUL string terminator???)
Return: AX = status
	    0000h same
	    FFFFh different
SeeAlso: AX=0011h
--------l-500013-----------------------------
INT 50 - PC Thuis Organizer Shell - GET KEY
	AX = 0013h
	CH = type flags
	    bit 0: force uppercase
	    bit 1: integer
	    bit 2: no spaces
Return: AX = keystroke
--------l-500014-----------------------------
INT 50 - PC Thuis Organizer Shell - SCROLL WINDOW
	AX = 0014h
	BL = direction
	    06h up
	    07h down
	BH = attribute
	DI = window handle
SeeAlso: INT 10/AH=06h,INT 10/AH=07h
--------l-500015-----------------------------
INT 50 - PC Thuis Organizer Shell - GET MEMORY HANDLE
	AX = 0015h
	BL = handle size
	    00h 65536 bytes (64K)
	    01h 65535 bytes (64K-1)
	    02h 32768 bytes (32K)
	    03h 32767 bytes (32K-1)
Return: AX = segment
Program: The PC Thuis Organizer Shell was written by John Vanderaart and
	  published in the June/July 1990 issue of PC Thuis Power magazine
SeeAlso: INT 21/AH=48h
--------H-51---------------------------------
INT 51 - IRQ1 relocated by DESQview
Note:	this is the default location for older versions; see INT 50"DESQview"
	  for details of interrupt relocation
SeeAlso: INT 50"DESQview",INT 54"DESQview",INT 58"DESQview"
--------H-51---------------------------------
INT 51 - IRQ1 relocated by IBM 3278 emulation control program
SeeAlso: INT 50"IBM 3278",INT 54"IBM 3278"
--------H-51---------------------------------
INT 51 - IRQ1 relocated by OS/2 v1.x
SeeAlso: INT 50"OS/2",INT 54"OS/2"
--------H-52---------------------------------
INT 52 - IRQ2 relocated by DESQview
Note:	this is the default location for older versions; see INT 50"DESQview"
	  for details of interrupt relocation
SeeAlso: INT 50"DESQview",INT 54"DESQview",INT 58"DESQview"
--------H-52---------------------------------
INT 52 - IRQ2 relocated by IBM 3278 emulation control program, OS/2 v1.x
SeeAlso: INT 50"IBM 3278",INT 51"OS/2"
--------H-53---------------------------------
INT 53 - IRQ3 relocated by DESQview
Note:	this is the default location for older versions; see INT 50"DESQview"
	  for details of interrupt relocation
SeeAlso: INT 50"DESQview",INT 54"DESQview",INT 58"DESQview"
--------H-53---------------------------------
INT 53 - IRQ3 relocated by IBM 3278 emulation control program, OS/2 v1.x
SeeAlso: INT 50"IBM 3278",INT 51"OS/2"
--------N-53---------------------------------
INT 53 - WEB??? - API
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
Index:	installation check;unknown|installation check;WEBCO
--------H-54---------------------------------
INT 54 - IRQ4 relocated by DESQview
Note:	this is the default location for older versions; see INT 50"DESQview"
	  for details of interrupt relocation
SeeAlso: INT 50"DESQview",INT 58"DESQview"
--------H-54---------------------------------
INT 54 - IRQ4 relocated by IBM 3278 emulation control program, OS/2 v1.x
SeeAlso: INT 51"IBM 3278",INT 51"OS/2"
--------H-55---------------------------------
INT 55 - IRQ5 relocated by DESQview
Note:	this is the default location for older versions; see INT 50"DESQview"
	  for details of interrupt relocation
SeeAlso: INT 50"DESQview",INT 58"DESQview"
--------H-55---------------------------------
INT 55 - IRQ5 relocated by IBM 3278 emulation control program, OS/2 v1.x
SeeAlso: INT 51"IBM 3278",INT 51"OS/2"
--------H-56---------------------------------
INT 56 - IRQ6 relocated by DESQview
Note:	this is the default location for older versions; see INT 50"DESQview"
	  for details of interrupt relocation
SeeAlso: INT 50"DESQview",INT 58"DESQview"
--------H-56---------------------------------
INT 56 - IRQ6 relocated by IBM 3278 emulation control program, OS/2 v1.x
SeeAlso: INT 51"IBM 3278",INT 51"OS/2"
--------H-57---------------------------------
INT 57 - IRQ7 relocated by DESQview
Note:	this is the default location for older versions; see INT 50"DESQview"
	  for details of interrupt relocation
SeeAlso: INT 50"DESQview",INT 58"DESQview"
--------H-57---------------------------------
INT 57 - IRQ7 relocated by IBM 3278 emulation control program, OS/2 v1.x
SeeAlso: INT 51"IBM 3278",INT 51"OS/2"
--------H-58---------------------------------
INT 58 - IRQ8 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 70
--------H-58---------------------------------
INT 58 - IRQ0 relocated by DoubleDOS
SeeAlso: INT 08
--------H-59---------------------------------
INT 59 - IRQ9 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 71
--------H-59---------------------------------
INT 59 - IRQ1 relocated by DoubleDOS
SeeAlso: INT 09
--------V-59---------------------------------
INT 59 - GSS Computer Graphics Interface (GSS*CGI)
	DS:DX -> block of 5 array pointers
Return: CF set on error
	    AX = error code
	CF clear if successful
	    AX = return code
Note:	INT 59 is the means by which GSS*CGI language bindings communicate with
	  GSS*CGI device drivers and the GSS*CGI device driver controller.
	also used by the IBM Graphic Development Toolkit
--------H-5A---------------------------------
INT 5A - IRQ10 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 72
--------H-5A---------------------------------
INT 5A - IRQ2 relocated by DoubleDOS
SeeAlso: INT 0A
--------N-5A---------------------------------
INT 5A - Cluster adapter BIOS entry address
	???
--------H-5B---------------------------------
INT 5B - IRQ11 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 73
--------H-5B---------------------------------
INT 5B - IRQ3 relocated by DoubleDOS
SeeAlso: INT 0B
--------N-5B---------------------------------
INT 5B - Used by cluster adapter
--------N-5B---------------------------------
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
--------N-5B---------------------------------
INT 5B - Microsoft Network Transport Layer Interface
Note:	used by MS-NET for executing network commands
SeeAlso: INT 5C"NetBIOS"
--------N-5B---------------------------------
INT 5B - used by Alloy NTNX
--------N-5B---------------------------------
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
----------5B5254DL04-------------------------
INT 5B U - SitBack v3.02R - GET ???
	AX = 5254h
	DL = 04h
Return: ES:BX -> ??? in resident portion
Program: SitBack is a background file backup utility by SitBack Technologies,
	  Inc. which initiates backups whenever the system is idle
SeeAlso: AX=8485h/DL=71h,AX=8485h/DL=72h
----------5B8485DL70-------------------------
INT 5B U - SitBack v3.02R - INSTALLATION CHECK
	AX = 8485h
	DL = 70h
Return: CX = 8485h if installed
	    DX:AX -> ??? (configuration data?)
Program: SitBack is a background file backup utility by SitBack Technologies,
	  Inc. which initiates backups whenever the system is idle
SeeAlso: AX=5254h/DL=04h,AX=8485h/DL=78h
----------5B8485DL71-------------------------
INT 5B U - SitBack v3.02R - SET ??? FLAG AND GET ??? ADDRESS
	AX = 8485h
	DL = 71h
Return: ES:BX -> FAR entry point to ???
Note:	the flag which is modified is located at the address returned by
	   AX=5254h/DL=04h
SeeAlso: AX=8485h/DL=72h
----------5B8485DL72-------------------------
INT 5B U - SitBack v3.02R - CLEAR ??? FLAG
	AX = 8485h
	DL = 72h
Note:	the flag which is modified is located at the address returned by
	   AX=5254h/DL=04h
SeeAlso: AX=8485h/DL=71h
----------5B8485DL73-------------------------
INT 5B U - SitBack v3.02R - ???
	AX = 8485h
	DL = 73h
	???
Return: ???
----------5B8485DL74-------------------------
INT 5B U - SitBack v3.02R - ???
	AX = 8485h
	DL = 74h
	???
Return: ???
----------5B8485DL75-------------------------
INT 5B U - SitBack v3.02R - ???
	AX = 8485h
	DL = 75h
	CX = ???
Return: ???
SeeAlso: AX=8485h/DL=76h
----------5B8485DL76-------------------------
INT 5B U - SitBack v3.02R - ???
	AX = 8485h
	DL = 76h
	CX = ???
Return: ???
Note:	conditionally calls the code for AX=8485h/DL=75h
SeeAlso: AX=8485h/DL=75h
----------5B8485DL77-------------------------
INT 5B U - SitBack v3.02R - SET ??? FLAG
	AX = 8485h
	DL = 77h
----------5B8485DL78-------------------------
INT 5B U - SitBack v3.02R - GET RESIDENT DATA SEGMENT
	AX = 8485h
	DL = 78h
Return: CX = 5342h if supported
	    ES = AX = segment of TSR data
SeeAlso: AX=8485h/DL=70h,AX=8485h/DL=79h
----------5B8485DL79-------------------------
INT 5B U - SitBack v3.02R - GET DTA
	AX = 8485h
	DL = 79h
Return: CX = 5342h if supported
	    ES:BX -> DTA set by last INT 21/AH=1Ah
Note:	this function is provided by SBOS.EXE rather than SB.EXE
SeeAlso: INT 21/AH=1Ah
----------5B8485DL7A-------------------------
INT 5B U - SitBack v3.02R - TOGGLE ???
	AX = 8485h
	DL = 7Ah
Return: CX = 5342h if supported
	    AL = new value of ??? (00h or 01h)
--------H-5C---------------------------------
INT 5C - IRQ12 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 74
--------H-5C---------------------------------
INT 5C - IRQ4 relocated by DoubleDOS
SeeAlso: INT 0C
--------N-5C---------------------------------
INT 5C - NetBIOS INTERFACE
	ES:BX -> network control block (NCB) (see below)
Return: AL = status (see below)
Note:	Sytek PCnet card uses DMA 3.
SeeAlso: INT 2A/AH=01h,INT 2A/AH=04h,INT 5B

Values for NetBIOS status:
 00h	successful
 01h	bad buffer size
 03h	invalid NETBIOS command
 05h	timeout
 06h	receive buffer too small
 07h	No-ACK command failed
 08h	bad session number
 09h	LAN card out of memory
 0Ah	session closed
 0Bh	command has been cancelled
 0Dh	name already exists
 0Eh	local name table full
 0Fh	name still in use, can't delete
 11h	local session table full
 12h	remote PC not listening
 13h	bad NCB_NUM field
 14h	no answer to CALL or no such remote
 15h	name not in local name table
 16h	duplicate name
 17h	bad delete
 18h	abnormal end
 19h	name error, multiple identical names in use
 1Ah	bad packet
 21h	network card busy
 22h	too many commands queued
 23h	bad LAN card number
 24h	command finished while cancelling
 26h	command can't be cancelled
 30h	name defined by another process (OS/2)
 34h	NetBIOS environment not defined, must issue reset (OS/2)
 35h	required operating system resources exhausted (OS/2)
 36h	maximum applications exceeded (OS/2)
 37h	no SAPs available for NetBIOS (OS/2)
 38h	requested resources not available (OS/2)
 40h	Lana System Error
 41h	Lana Remote Hot Carrier
 42h	Lana Local Hot Carrier
 43h	Lana No Carrier Detected
 44h	unusual network condition
 45h-4Dh hardware error
 4Eh	token ring is broken
 4Fh	token ring error
 50h	adapter malfunction
 F7h	error in explicit INITIALIZE
 F8h	error in implicit OPEN
 F9h	TOKREUI internal error
 FAh	hardware adapter testing
 FBh	NetBIOS emulator not found
 FCh	OPEN or OPEN_SAP failure
 FDh	unexpected adapter closure
 FFh	NetBIOS busy (command pending)

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

Values for command code field in NCB (OR with 80h for non-waiting call):
 10h	start session with NCB_NAME name (call)
 11h	listen for call
 12h	end session with NCB_NAME name (hangup)
 14h	send data via NCB_LSN
 15h	receive data from a session
 16h	receive data from any session
 17h	send multiple data buffers
 20h	send unACKed message (datagram)
 21h	receive datagram
 22h	send broadcast datagram
 23h	receive broadcast datagram
 30h	add name to name table
 31h	delete name from name table
 32h	reset adapter card and tables
 33h	get adapter status (see structure "astatus" below)
 34h	status of all sessions for name (see structure "sstatus" below)
 35h	cancel
 36h	add group name to name table
 48h	send data and receive data (LAN Manager NETBEUI.DOS)
 70h	unlink from IBM remote program (no F0h function)
 71h	send data without ACK
 72h	send multiple buffers without ACK
 72h	UngermannBass Register (conflicts with above function)
 73h	UngermannBass SendNmc
 74h	UngermannBass Callniu
 75h	UngermannBass Calladdr
 76h	UngermannBass Listenaddr
 77h	UngermannBass SendPkt
 78h	find name
 78h	UngermannBass RcvPkt (conflicts with above function)
 79h	token-ring protocol trace
 79h	UngermannBass SendAttn (conflicts with above function)
 7Ah	UngermannBass RcvAttn
 7Bh	UngermannBass Listenniu
 7Ch	UngermannBass RcvRaw
 7Dh	UngermannBass SendNmc2
 7Fh	Beame&Whiteside BWNB installation check (returns with return code and
	completion code both set to 03h, while invalid functions return only
	return code field set to 03h)

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
--------N-5C---------------------------------
INT 5C - TOPS INTERFACE
	ES:BX -> Network Control Block
Note:	TOPS card uses DMA 1, 3 or none.
--------N-5C---------------------------------
INT 5C - ATALK.SYS - AppleTalk INTERFACE
	DX:BX -> control block (see below)
Return: none
Notes:	this driver can use any interrupt from 5Ch to 70h
	the signature 'AppleTalk' appears 16 bytes prior to the interrupt
	  handler; this serves as the installation check
Index:	installation check;ATALK.SYS|installation check;AppleTalk interface

Values for command code:
 01h	"AT_INIT"	    initialize the driver
 02h	"AT_KILL"
 03h	"AT_GETNETINFO" get current network info incl init status
 04h	"AT_GETCLOCKTICKS"
 05h	"AT_STARTTIMER"
 06h	"AT_RESETTIMER"
 07h	"AT_CANCELTIMER"
 10h	"LAP_INSTALL"
 11h	"LAP_REMOVE"
 12h	"LAP_WRITE"
 13h	"LAP_READ"
 14h	"LAP_CANCEL"
 20h	"DDP_OPENSOCKET"
 21h	"DDP_CLOSESOCKET"
 22h	"DDP_WRITE"
 23h	"DDP_READ"
 24h	"DDP_CANCEL"
 30h	"NBP_REGISTER"
 31h	"NBP_REMOVE"
 32h	"NBP_LOOKUP"
 33h	"NBP_CONFIRM"
 34h	"NBP_CANCEL"
 35h	"ZIP_GETZONELIST"
 36h	"ZIP_GETMYZONE"
 37h	"ZIP_TAKEDOWN"
 38h	"ZIP_BRINGUP"
 40h	"ATP_OPENSOCKET"
 41h	"ATP_CLOSESOCKET"
 42h	"ATP_SENDREQUEST"
 43h	"ATP_GETREQUEST"
 44h	"ATP_SENDRESPONSE"
 45h	"ATP_ADDRESPONSE"
 46h	"ATP_CANCELTRANS"
 47h	"ATP_CANCELRESPONSE"
 48h	"ATP_CANCELREQUEST"
 50h	"ASP_GETPARMS"
 51h	"ASP_CLOSESESSION"
 52h	"ASP_CANCEL"
 53h	"ASP_INIT"
 54h	"ASP_KILL"
 55h	"ASP_GETSESSION"
 56h	"ASP_GETREQUEST"
 57h	"ASP_CMDREPLY"
 58h	"ASP_WRTCONTINUE"
 59h	"ASP_WRTREPLY"
 5Ah	"ASP_CLOSEREPLY"
 5Bh	"ASP_NEWSTATUS"
 5Ch	"ASP_ATTENTION"
 5Dh	"ASP_GETSTATUS"
 5Eh	"ASP_OPENSESSION"
 5Fh	"ASP_COMMAND"
 60h	"ASP_WRITE"
 61h	"ASP_GETATTENTION"
 70h	"PAP_OPEN"
 71h	"PAP_CLOSE"
 72h	"PAP_READ"
 73h	"PAP_WRITE"
 74h	"PAP_STATUS"
 75h	"PAP_REGNAME"
 76h	"PAP_REMNAME"
 77h	"PAP_INIT"
 78h	"PAP_NEWSTATUS"
 79h	"PAP_GETNEXTJOB"
 7Ah	"PAP_KILL"
 7Bh	"PAP_CANCEL"

Format of AppleTalk control block:
Offset	Size	Description
 00h	WORD	command code (see above)
		OR with the following flags
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
--------N-5C---------------------------------
INT 5C - IBM 802.2 INTERFACE (LLC)
	ES:BX -> CCB (see below)
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
--------N-5C---------------------------------
INT 5C - $25 LAN - INSTALLATION CHECK
Notes:	current versions only check whether the vector is 0000h:0000h or not
	future versions are supposed to have the signature "NET" in the three
	  bytes preceding the INT 5C handler
--------N-5C04-------------------------------
INT 5C - $25 LAN - CHECK IF CONNECTION ALIVE
	AH = 04h
	AL = COM port (0 = default)
	CX = wait count in character times (should be at least 100)
Return: ZF set if link alive
--------H-5D---------------------------------
INT 5D - IRQ13 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 75
--------H-5D---------------------------------
INT 5D - IRQ5 relocated by DoubleDOS
SeeAlso: INT 0D,INT 5C"DoubleDOS"
--------H-5E---------------------------------
INT 5E - IRQ14 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 76
--------H-5E---------------------------------
INT 5E - IRQ6 relocated by DoubleDOS
SeeAlso: INT 0E,INT 5D"DoubleDOS"
--------H-5F---------------------------------
INT 5F - IRQ15 relocated by DESQview 2.26+
Note:	this is the default, but other INTs may be used (see INT 50"DESQview")
SeeAlso: INT 50"DESQview",INT 77
--------H-5F---------------------------------
INT 5F - IRQ7 relocated by DoubleDOS
SeeAlso: INT 0F,INT 5E"DoubleDOS"
--------b-5F00-------------------------------
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
--------b-5F01-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - SET FILL MASK
	AH = 01h
	ES:DI -> 8-byte fill mask
Note:	the fill mask represents an 8x8 pixel box and is repeated as necessary
	  when drawing filled rectangles; it is always aligned with the byte
	  boundaries of video memory, regardless of the actual boundaries of
	  the rectangle
SeeAlso: AH=02h
--------b-5F02-------------------------------
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
--------b-5F03-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - SET LOGICAL ORIGIN
	AH = 03h
	CX = column
	DX = row
SeeAlso: AH=04h
--------b-5F04-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - SET CLIP REGION
	AH = 04h
	CX = left-most column
	DX = top-most row
	SI = right-most column
	DI = bottom-most row
SeeAlso: AH=03h
--------b-5F05-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - DRAW RECTANGLE
	AH = 05h
	AL = fill type
	    00h outline, using current line type and color
	    01h solid, using current color
	    02h pattern, using current fill mask and color
	DX,CX = row,column of other corner of rectangle
Note:	the rectangle is drawn starting at the current pen position
SeeAlso: AH=01h,AH=06h,AH=07h
--------b-5F06-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - DRAW LINE
	AH = 06h
	DX,CX = row,column of end point
Note:	the line is drawn starting at the current pen position
SeeAlso: AH=05h,AH=07h
--------b-5F07-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - PLOT POINT
	AH = 07h
	DX,CX = row,column of point
Note:	also sets pen position to the specified point
SeeAlso: AH=06h,AH=08h,AH=0Ch
--------b-5F08-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - MOVE PEN
	AH = 08h
	DX,CX = row,column of new pen position
SeeAlso: AH=07h,AH=09h
--------b-5F09-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - SET PEN COLOR
	AH = 09h
	AL = new color (00h = white, 01h = black)
SeeAlso: AH=08h,AH=0Ah,AH=0Bh
--------b-5F0A-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - SET REPLACEMENT RULE
	AH = 0Ah
	AL = new replacement rule
	    00h force
	    01h AND
	    02h OR
	    03h XOR
SeeAlso: AH=01h,AH=09h,AH=0Bh
--------b-5F0B-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - SET LINE TYPE
	AH = 0Bh
	CX = new line type
Note:	the line type specifies 16 bits which are repeated over and over while
	  drawing the pixels of a line
SeeAlso: AH=09h,AH=0Ah
--------b-5F0C-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - GET PIXEL
	AH = 0Ch
	DX,CX = row,column of pixel to read
Return: AX = pixel color
SeeAlso: AH=07h
--------b-5F0D-------------------------------
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
--------b-5F0E-------------------------------
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
--------b-5F0F-------------------------------
INT 5F - HP 95LX GRAPHICS PRIMITIVES - WRITE TEXT
	AH = 0Fh
	AL = rotate flag (if nonzero, rotate 90 degrees counter-clockwise)
	DX,CX = row,column of first character's top left corner
	ES:DI -> ASCIZ text
--------!------------------------------------
