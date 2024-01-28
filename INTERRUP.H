Interrupt List, part 8 of 8
This compilation is Copyright (c) 1989,1990,1991,1992,1993 Ralf Brown
--------I-68---------------------------------
INT 68 - Sangoma CCPOP 3270 resident module
SeeAlso: INT 67"Sangoma",INT 92"Sangoma"
--------N-6801-------------------------------
INT 68 - APPC/PC - NETWORK DEVICE CONTROL
	AH = 01h
	DS:DX -> control block

Format of control block:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	verb (action)
 0Eh  6 BYTEs	00h
 14h	DWORD	big-endian return code (see below)
---if verb = 1B00h (DISPLAY)---
 18h	WORD	00h
 1Ah  8 BYTEs	logical unit ID (big-endian)
 22h  8 BYTEs	partner logical unit name (big-endian)
 2Ah  8 BYTEs	mode name (big-endian)
 32h	BYTE	logical unit session limit
 33h	BYTE	partner logical unit session limit
 34h	BYTE	node maximum negotiable session limit
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
 18h	WORD	00h
 1Ah	BYTE	version
 1Bh	BYTE	release
 1Ch  8 BYTEs	net name (big-endian)
 24h  8 BYTEs	physical unit name (big-endian)
 2Ch  8 BYTEs	00h
 34h	DWORD	pointer to SYSTEM_LOG_EXIT routine, FFFFFFFFh=don't log errors
 38h	DWORD	00h
 3Ch	BYTE	00h RETURN_CONTROL: COMPLETE
		01h RETURN_CONTROL: INCOMPLETE
---if verb=2100h (Attach Logical Unit)---
 18h	WORD	70  offset to partner logical unit record
 1Ah  8 BYTEs	logical unit name (big-endian)
 22h  8 BYTEs	logical unit ID (big-endian)
 2Ah	BYTE	logical unit local address
 2Bh	BYTE	logical unit session limit
 2Ch	DWORD	pointer to CREATE_TP_EXIT routine,
		FFFFFFFFh = reject incoming ALLOCATEs
		00000000h = queue ALLOCATEs
 30h	DWORD	00h
 34h	DWORD	pointer to SYSTEM_LOG_EXIT routine, FFFFFFFFh=don't log errors
 38h	DWORD	00h
 3Ch	BYTE	maximum TPs
 3Dh	BYTE	queue depth
 3Eh	DWORD	pointer to LU_LU_PASSWORD_EXIT routine, FFFFFFFFh=no pswd exit
 42h	DWORD	00h
 46h	WORD	total length of partner records
    for each partner logical unit:
	WORD	length of this partner logical unit record
	WORD	42  offset to mode records
      8 BYTEs	partner logical unit name (big-endian)
	BYTE	partner logical unit security capabilities
		bit 7: already verified
		bit 6: conversation level security
		bit 5: session level security
	BYTE	partner logical unit session limit
	WORD	partner logical unit maximum MC_SEND_LL
      8 BYTEs	partner logical unit DLC name (big-endian)
	BYTE	partner logical unit adapter number
     17 BYTEs	(counted string) partner logical unit adapter address
	WORD	total length of mode records
   for each mode:
	WORD	16  length of this mode record
      8 BYTEs	mode name (big-endian)
	WORD	RU_SIZE high bound
	WORD	RU_SIZE low bound
	BYTE	mode maximum negotiable session limit
	BYTE	pacing size for receive
---if verb=2200h (Detach Logical Unit)---
 18h  8 BYTEs	logical unit ID (big-endian)
 20h	BYTE	00h
---if verb=2700h (Detach Physical Unit)---
 18h	BYTE	00h  type: hard
		01h  type: soft
---if verb=2B00h (Activate DLC)---
 18h  8 BYTEs	DLC name (big-endian)
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
 0Eh  8 BYTEs	logical unit ID (big-endian)
 16h  8 BYTEs	logical unit name (big-endian)
 1Eh  8 BYTEs	partner logical unit name (big-endian)
 26h 17 BYTEs	(counted string) partner fully qualified logical unit name
 37h	BYTE	password available (0=no, 1=yes)
 38h  8 BYTEs	password

Format of CREATE_TP verb:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2300h
 0Eh  6 BYTEs	00h
 14h	DWORD	sense code (big-endian)
		00000000h	Ok
		080F6051h	SECURITY_NOT_VALID
		084B6031h	TP_NOT_AVAIL_RETRY
		084C0000h	TP_NOT_AVAIL_NO_RETRY
		10086021h	TP_NAME_NOT_RECOGNIZED
		10086034h	CONVERSATION_TYPE_MISMATCH
		10086041h	SYNC_LEVEL_NOT_SUPPORTED
 18h  8 BYTEs	TP ID (big-endian)
 20h  8 BYTEs	logical unit ID (big-endian)
 28h	DWORD	conversation ID (big-endian)
 2Ch	BYTE	0 basic conversation, 1 mapped conversation
 2Dh	BYTE	0 no sync level, 1 confirm
 2Eh	BYTE	reserved
 2Fh 65 BYTEs	(counted string) transaction program name
 70h  6 BYTEs	00h
 76h	WORD	length of ERROR_LOG_DATA to return
 78h	DWORD	pointer to ERROR_LOG_DATA buffer
 7Ch  8 BYTEs	partner logical unit name (big-endian)
 84h 18 BYTEs	(counted string) partner fully qualified logical unit name
 96h  8 BYTEs	mode name (big-endian)
 9Eh 12 BYTEs	00h
 AAh 11 BYTEs	(counted string) password
 B5h 11 BYTEs	(counted string) user ID
 C0h	BYTE	0 verification should be performed
		1 already verified

Format of SYSLOG verb:
Offset	Size	Description
 00h 12 BYTEs	reserved
 0Ch	WORD	2600h
 0Eh 10 BYTEs	00h
 18h	WORD	type (big-endian)
 1Ah	DWORD	subtype (big-endian)
 1Eh	DWORD	pointer to ADDITIONAL_INFO
 22h	DWORD	conversation ID (big-endian)
 26h  8 BYTEs	TP ID (big-endian)
 2Eh  8 BYTEs	physical unit or logical unit name (big-endian)
 36h	WORD	length of data
 38h	DWORD	pointer to data
 3Ch	BYTE	00h
--------N-6802-------------------------------
INT 68 - APPC/PC - CONNECTION CONTROL
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
 2Bh  8 BYTEs	00h
 33h  8 BYTEs	(high byte first) partner logical unit name
 3Bh  8 BYTEs	(high byte first) mode name
 43h 65 BYTEs	(counted string) TP name
 84h	BYTE	00h security: none
		01h security: same
		02h security: pgm
 85h 11 BYTEs	00h
 90h 11 BYTEs	(counted string) password
 9Bh 11 BYTEs	(counted string) user ID
 A6h	WORD	PIP_DATA length
 A8h	DWORD	pointer to PIP_DATA
---if verb=0300h (Confirm or MC_Confirm)---
 26h	BYTE  request to send received (0=no, 1=yes)
---if verb=0400h (Confirmed or MC_Confirmed), no additional fields---
---if verb=0500h (Deallocate or MC_Deallocate)---
 26h	BYTE	00h
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
 2Eh	BYTE	00h
 2Fh	BYTE	SYNC_LEVEL (0=none, 1=confirm)
 30h  8 BYTEs	(high byte first) mode name
 38h  8 BYTEs	(high byte first) own net name
 40h  8 BYTEs	(high byte first) own logical unit name
 48h  8 BYTEs	(high byte first) partner logical unit name
 50h 18 BYTEs	(counted string) partner's fully qualified logical unit name
 62h	BYTE	00h
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
 27h	BYTE	00h
 28h	WORD	data length
 2Ah	DWORD	pointer to data
---if verb=1000h (Send_Error or MC_Send_Error)---
 26h	BYTE	request to send received (0=no, 1=yes)
 27h	BYTE	type (0=program, 1=SVC)
 28h	DWORD	00h
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
 0000h	successful
 0001h	parameter check
 0002h	state check
 0003h	allocation error
 0005h	deallocate abended
 0006h	deallocate abended program
 0007h	deallocate abended SVC
 0008h	deallocate abended timer
 0009h	deallocate normal return
 000Ah	data posting blocked
 000Bh	posting not active
 000Ch	PROG_ERROR_NO_TRUNC
 000Dh	PROG_ERROR_TRUNC
 000Eh	PROG_ERROR_PURGING
 000Fh	CONV_FAILURE_RETRY
 0010h	CONV_FAILURE_NO_RETRY
 0011h	SVC_ERROR_NO_TRUNC
 0012h	SVC_ERROR_TRUNC
 0013h	SVC_ERROR_PURGING
 0014h	unsuccessful
 0018h	CNOS partner logical unit reject
 0019h	conversation type mixed
 F001h	APPC disabled
 F002h	APPC busy
 F003h	APPC abended
 F004h	incomplete

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
--------N-6803-------------------------------
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
--------N-6804-------------------------------
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
--------N-6805-------------------------------
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
--------N-6806-------------------------------
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
--------N-6807-------------------------------
INT 68 - APPC/PC - PASSTHROUGH
	AH = 07h
	DS:DX -> control block (format depends on application subsystem)
SeeAlso: AH=FFh
--------N-68FA-------------------------------
INT 68 - APPC/PC - ENABLE/DISABLE APPC
	AH = FAh
	AL bit 0 = 0 enable
		   1 disable
--------N-68FB-------------------------------
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
--------N-68FC-------------------------------
INT 68 - APPC/PC - ENABLE/DISABLE MESSAGE TRACING
	AH = FCh
	AL = 00h disable tracing
	   = 01h enable tracing
		DX = number of bytes to keep (0=all)
SeeAlso: AH=FDh
--------N-68FD-------------------------------
INT 68 - APPC/PC - ENABLE/DISABLE API VERB TRACING
	AH = FDh
	AL = 00h disable tracing
	     01h enable tracing
SeeAlso: AH=FCh,AH=FEh
--------N-68FE-------------------------------
INT 68 - APPC/PC - SET TRACE DESTINATION
	AH = FEh
	AL = trace destinations
	    bit 0  storage (DS:DX -> trace stats record)
	    bit 1  display
	    bit 2  file (trace written to file OUTPUT.PC)
	    bit 3  printer
SeeAlso: AH=FDh

Format of Trace Statistics Record:
Offset	Size	Description
 00h	DWORD	pointer to storage trace buffer
 04h	WORD	max number of 80-byte records in trace
 06h	WORD	(high-order byte first!) current record number (must init to 0)
 08h	DWORD	(high-order byte first!) number of records written (init to 0)
 0Ch	DWORD	reserved
Note:	do not move record while trace is active
--------N-68FF-------------------------------
INT 68 - APPC/PC - SET PASSTHROUGH
	AH = FFh
	DS:DX -> passthrough exit routine
SeeAlso: AH=07h
--------b-69---------------------------------
INT 69 - Zenith AT BIOS - ???
   called by INT 09 handler
--------N-690100-----------------------------
INT 69 - DECnet DOS CTERM - INSTALLATION CHECK
	AX = 0100h
Return: AL = FFh if present
SeeAlso: AX=010Fh
--------N-690101-----------------------------
INT 69 - DECnet DOS CTERM - SEND BYTE
	AX = 0101h
	BL = character
	DX = session handle
Return: AH >= 80h on error
SeeAlso: AX=0102h
--------N-690102-----------------------------
INT 69 - DECnet DOS CTERM - READ BYTE
	AX = 0102h
	DX = session handle
Return: AH >= 80h on error
	AH < 80h if successful
	    AL = character
SeeAlso: AX=0101h
--------N-690103-----------------------------
INT 69 - DECnet DOS CTERM - STATUS
	AX = 0103h
	DX = session handle
Return: AH status flags
	    bit 7 session has been aborted
		6 DECnet error
		1 trace data available
		0 receive data available
	AL = reason code if DECnet error
	    00h normal disconnect
	    01h unknown message from host
	    02h protocol violation from host
	    03h could not process the initiate message
	    04h error receiving message from host
	    05h error sending message to host
	    06h error checking for message from host
	    07h remote system does not support CTERM
	    08h remote system does not support correct protocol version
	    09h did not receive BIND message from host
	    0Ah could not send BIND message to host
	    0Bh no more sessions available
	    0Ch session does not exist
	    0Dh not enough memory to complete operation
	    0Eh connection has broken
SeeAlso: AX=0104h
--------N-690104-----------------------------
INT 69 - DECnet DOS CTERM - DECnet STATUS
	AX = 0104h
	DX = session handle
Return: AX = reason code (see AX=0103h)
Note:	use this call when AX=0103h returns a DECnet error
SeeAlso: AX=0103h
--------N-690105-----------------------------
INT 69 - DECnet DOS CTERM - OPEN SESSION
	AX = 0105h
	DS:BX -> ASCIZ node name
	ES:DX -> buffer for session control block (see INT 6A/AH=D0h)
Return: AX <= 0 on error
	AX > 0 session handle
SeeAlso: AX=0103h,AX=0106h,AX=010Ah
--------N-690106-----------------------------
INT 69 - DECnet DOS CTERM - CLOSE SESSION
	AX = 0106h
	DX = session handle
Return: AH = 00h good close
	   other error code (see AX=0103h)
SeeAlso: AX=0103h,AX=0105h
--------N-69010A-----------------------------
INT 69 - DECnet DOS CTERM - GET SESSION CONTROL BLOCK SIZE
	AX = 010Ah
Return: AX = length of session control block in bytes
SeeAlso: AX=0105h
--------N-69010B-----------------------------
INT 69 - DECnet DOS CTERM - GET DECnet SOCKET
	AX = 010Bh
	DX = session handle
Return: AX > 0	DECnet socket for the session
	   = 0	no match for handle
--------N-69010F-----------------------------
INT 69 - DECnet DOS CTERM - DEINSTALL CTERM
	AX = 010Fh
Return: AH = 00h succesful uninstall
	   other error code
Note:	CTERM must have been the last TSR loaded in order to deinstall it
SeeAlso: AX=0100h
Index:	uninstall;DECnet DOS CTERM
--------N-690A-------------------------------
INT 69 - DECnet DOS 2.1+ - DATA LINK LAYER
	AH = 0Ah
	AL = function
	    00h initialize
	    01h open portal
	    02h close portal
	    03h enable multicast address
	    04h disable multicast address
	    05h transmit
	    06h request transmit buffer
	    07h deallocate transmit buffer
	    08h read channel status
	    09h read datalink portal list
	    0Ah read information about a datalink portal
	    0Bh read and/or clear counters
	    0Ch request to boot from a network server
	    0Dh enable Ethernet channel
	    0Eh disable Ethernet channel
	    0Fh start MOP/send a System ID message
	    10h stop MOP
	    11h get DECPARM
	    12h set DECPARM
	    13h external loopback
	ES:BX -> Datalink Communication Block
Return: AX = status
	    00h successful
	    01h hardware failed to initialize
	    02h channel state was not off (must be off to execute that command)
	    03h channel state is off (must be on to execute that command)
	    04h address not set
	    05h hardware missing
	    06h buffer too small
	    07h no more buffers available
	    08h no more resources available
	    09h promiscuous receiver active
	    0Ah non exclusive
	    0Bh unrecognized portal
	    0Ch protocol type in use
	    0Dh not a valid Multicast address
	    0Eh outstanding calls
	    0Fh hardware doesn't support receiving bad frames
	    10h none outstanding
	    11h no events
	    12h broken
	    13h buffer quota exceeded
	    14h already initialized
	    15h loopback failure
SeeAlso: INT 6D"DECnet"

Format of Datalink Communication Block
Offset	Type	Description
 00h	WORD	portal ID
 02h  6 BYTEs	source address
 08h  6 BYTEs	destination address
 0Eh	DWORD	buffer pointer
 12h	WORD	buffer length
 14h	WORD	operation
 16h	BYTE	pad flag (used on open)
		    00h no pad
		    01h pad
 17h	BYTE	mode flag (used on open)
		    00h 802.3
		    01h Ethernet
		    02h promiscuous
 18h	DWORD	line status change function
 1Ch	DWORD	received data function
 20h	DWORD	transmitted data function
 24h	BYTE	maximum outstanding transmits/receives
 25h  2 BYTEs	protocol type
 27h	WORD	buffers lost
--------N-694001-----------------------------
INT 69 - 10NET v5.0 - SYSSVC.COM - ???
	AX = 4001h
Return: CF clear
	AX = 0000h
	ES:SI -> ???
Note:	INT 69 is the default, and may be set to any interrupt from 60h-7Fh;
	  the signature "SYSV" immediately before the interrupt handler serves
	  as the installation check
SeeAlso: AX=4002h
Index:	installation check;10NET SYSSVC
--------N-694002-----------------------------
INT 69 - 10NET v5.0 - SYSSVC.COM - ???
	AX = 4002h
	???
Return: ???
Note:	INT 69 is the default, and may be set to any interrupt from 60h-7Fh;
	  the signature "SYSV" immediately before the interrupt handler serves
	  as the installation check
--------N-694101-----------------------------
INT 69 - 10NET v5.0 - SYSSVC.COM - ???
	AX = 4101h
Return: CF clear
	ES:SI -> ???
SeeAlso: AX=4102h,AX=4103h,AX=4104h
--------N-694102-----------------------------
INT 69 - 10NET v5.0 - SYSSVC.COM - ???
	AX = 4102h
	???
Return: ???
--------N-694103-----------------------------
INT 69 - 10NET v5.0 - SYSSVC.COM - ???
	AX = 4103h
	???
Return: ???
--------N-694104-----------------------------
INT 69 - 10NET v5.0 - SYSSVC.COM - ???
	AX = 4104h
	???
Return: ???
--------N-6942-------------------------------
INT 69 - 10NET v5.0 - SYSSVC.COM - ???
	AH = 42h
	AL = function (01h-14h)
	???
Return: ???
--------N-6943-------------------------------
INT 69 - 10NET v5.0 - SYSSVC.COM - ???
	AH = 43h
	AL = function (01h-05h)
	???
Return: ???
--------N-6944-------------------------------
INT 69 - 10NET v5.0 - SYSSVC.COM - ???
	AH = 44h
	AL = function (01h-03h)
	???
Return: ???
--------N-6949-------------------------------
INT 69 - 10NET v5.0 - SYSSVC.COM - BUG
	AH = 49h
Note:	due to a fencepost error, this function branches to hyperspace
SeeAlso: AX=4001h,AH=FFh
--------G-696996-----------------------------
INT 69 - ISR.COM v1.00 - SPECIFY INTERRUPT HANDLER
	AX = 6996h
	DS:DX -> interrupt handler or 0000h:0000h to disable
Return: AX = 9669h
Program: ISR (Interrupt Service Reflector) is a TSR by Rich Bono which permits
	  a program to provide hardware interrupt handlers even while being
	  debugged with a debugger that swaps interrupt vectors during
	  debugging.
Note:	the interrupt vector which is to be reflected is set at installation
	  time and cannot be changed
--------N-69FF-------------------------------
INT 69 - 10NET v5.0 - SYSSVC.COM - SIGNAL SYSTEM ERROR
	AH = FFh
Return: never???
Notes:	displays "System Error" message and register dump, then halts system
	INT 69 is the default, and may be set to any interrupt from 60h-7Fh;
	  the signature "SYSV" immediately before the interrupt handler serves
	  as the installation check
SeeAlso: AX=4001h,AH=49h
--------U-6A---------------------------------
INT 6A - OPTHELP.COM
Program: OPTHELP is an optionally-resident help system for SLR Systems's OPTASM
	  assembler
Note:	may be configured to use any interrupt from 60h to 7Fh (default 6Ah)
--------N-6A---------------------------------
INT 6A - DECnet DOS - LOCAL AREA TRANSPORT PROGRAM
Note:	the installation check consists of testing for a signature area
	  immediately preceding the interrupt handler
SeeAlso: INT 6B"DECnet",INT 6D"DECnet"
Index:	installation check;DECnet DOS Local Area Transport

Format of signature area:
Offset	Size	Description
 -5	BYTE	major version number
 -4	BYTE	minor version number
 -3   3 BYTEs	signature (ASCII "LAT")
--------N-6A01--DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - SEND BYTE
	AH = 01h
	DH = FFh
	AL = character
	DL = handle
Return: AH >= 80h on error
SeeAlso: AH=02h
--------N-6A02--DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - READ BYTE
	AH = 02h
	DH = FFh
	DL = handle
Return: AH < 80h if successful
	    AL = character
	AH >= 80h on error
SeeAlso: AH=01h
--------N-6A03--DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - STATUS
	AH = 03h
	DH = FFh
	DL = handle
Return: AH = status flags
	    bit 5 transmit buffer empty
		3 session in start state
		2 session not active
		1 unable to queue transmit data
		0 receive data available
--------N-6AD0--DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - OPEN SESSION
	AH = D0h
	DH = FFh
	AL = FFh no password
	   = 0Fh password at ES:DI
	ES:BX -> LAT session control block (see below)
	ES:DI -> 16-byte blank-padded password
Return: AH = 00h success
	    DL = handle
SeeAlso: AX=D000h

Format of LAT Session Control Block:
Offset	Size	Description
 00h 18 BYTEs	service name
 12h 18 BYTEs	node name (future use)
 24h 18 BYTEs	port name (future use)
 36h	DWORD	-> session stopped post routine
 3Ah	DWORD	-> service table overflow post routine
 3Eh	DWORD	-> transmit post routine
 42h	DWORD	-> receive post routine
 46h	WORD	session status
		04h circuit failure
		08h stop slot received
 48h	WORD	slot state (LAT driver use)
 4Ah	WORD	local credits (LAT driver use)
 4Ch	DWORD	-> VCB (LAT driver use)
 50h	WORD	backward slot (LAT driver use)
 52h	WORD	forward slot (LAT driver use)
 54h	WORD	remote slot ID (LAT driver use)
 56h	WORD	local slot ID (LAT driver use)
 58h	WORD	slot byte count (LAT driver use)
 5Ah	BYTE	remote credits (LAT driver use)
 5Bh 255 BYTEs	transmitted data slot
15Ah	BYTE	number of receive data slots (4 recommended)
15Bh	BYTE	number of occupied slots
15Ch	BYTE	index of next receive slot to use
15Dh	BYTE	index of current receive slot
15Eh	WORD	pointer to first received character
160h  N WORDs	pointers to receive slots (buffers); each is 259 bytes
Note:	set post routines to 0000h:0000h if polled operation will be used
--------N-6AD000DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - CLOSE SESSION
	AX = D000h
	DH = FFh
	DL = handle
Return: AX = 0000h successful
	   = 0001h no such session
	   = 0002h session not running, try again later
SeeAlso: AH=D0h
--------N-6AD100DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - SEND BREAK
	AX = D100h
	DH = FFh
	DL = handle
Return: AX = 0000h if successful
	AH bit 7 set if unable to send break
--------N-6AD300DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - RESET LAT COUNTERS
	AX = D300h
	DH = FFh
SeeAlso: AX=D400h
--------N-6AD400DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - COPY LAT COUNTERS
	AX = D400h
	DH = FFh
	CX = buffer size
	ES:BX -> buffer for LAT counters
Return: AX = 0000h counters copied into buffer
	   = FFFFh buffer too small
SeeAlso: AX=D300h
--------N-6AD500DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - GET NEXT LAT SERVICE NAME
	AX = D500h
	DH = FFh
	ES:BX -> 17-byte buffer for name
Return: AH = 00h if successful
	   ES:BX buffer filled
	AX = FFFFh if end of table or no name available
Notes:	use this function to get the names of the hosts on the network
	successive calls are necessary to get all names
SeeAlso: AX=D600h
--------N-6AD600DHFF-------------------------
INT 6A - DECnet DOS LOCAL AREA TRANSPORT - LAT SERVICE TABLE RESET
	AX = D600h
	DH = FFh
Return: AX = number of service table entries
	BX = 0000h service table has not overflowed
	   = FFFFh service table has overflowed
SeeAlso: AX=D500h
--------N-6B---------------------------------
INT 6B - DECnet DOS - PORT DRIVER
Note:	the installation check consists of testing for a signature area
	  immediately preceding the interrupt handler
SeeAlso: INT 6A"DECnet",INT 6C"DECnet"
Index:	installation check;DECnet DOS Port Driver

Format of signature area:
Offset	Size	Description
 -5	BYTE	major version number
 -4	BYTE	minor version number
 -3   3 BYTEs	signature (ASCII "PDV")
--------S-6B0000-----------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - BUFFERED WRITE
	AX = 0000h
	CX = length
	ES:BX -> buffer
Return: CX = number of bytes written
Note:	also supported by NPC NCSI
SeeAlso: AX=0100h,AH=18h,INT 14/AH=19h
--------S-6B0100-----------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - BUFFERED READ
	AX = 0100h
	CX = length of buffer
	ES:BX -> buffer
Return: CX = number of bytes read
Note:	also supported by NPC NCSI
SeeAlso: AX=0000h,AH=19h,INT 14/AH=18h,INT 14/AX=FF02h
--------S-6B02-------------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - INSTALL CHECK
	AH = 02h
	AL nonzero
Return: AL = 00h if present and OK
Note:	also supported by NPC NCSI
SeeAlso: AX=0700h
--------S-6B0600-----------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - CONTROL
	AX = 0600h
	CX = command
	    02h send break
	    04h disconnect
	    06h hold
Note:	also supported by NPC NCSI
--------S-6B0700-----------------------------
INT 6B - Novell NASI/NACS, Ungermann-Bass Net One SERIAL I/O - GET STATUS
	AX = 0700h
Return: CH <> 00h if connection active
Note:	also supported by NPC NCSI
SeeAlso: AH=02h,AH=10h
--------S-6B10-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - GET STATUS
	AH = 10h
	???
Return: ???
SeeAlso: AX=0700h,AH=12h,AH=1Fh
--------S-6B11-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - ALLOCATE A VIRTUAL CIRCUIT
	AH = 11h
	???
Return: ???
SeeAlso: AH=12h,AH=15h,AH=16h,AH=17h,AH=18h
--------S-6B12-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - VIRTUAL CIRCUIT STATUS
	AH = 12h
	???
Return: ???
SeeAlso: AH=10h,AH=15h,AH=1Ah,AH=1Bh,AH=1Fh
--------S-6B13-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - SET/RETRIEVE REQUEST/REPLY SERVICE NAME
	AH = 13h
	???
Return: ???
SeeAlso: AH=14h,AH=15h
--------S-6B14-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - SET/RETRIEVE SERVICE ADDRESS
	AH = 14h
	???
Return: ???
SeeAlso: AH=13h,AH=15h,AH=21h
--------S-6B15-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - SET/RETRIEVE VIRTUAL CIRCUIT CONFIG
	AH = 15h
	???
Return: ???
SeeAlso: AH=13h,AH=14h
--------S-6B16-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - LOG AND/OR INITIALIZE VIRTUAL CIRCUIT
	AH = 16h
	???
Return: ???
SeeAlso: AH=11h,AH=12h,AH=17h
--------S-6B17-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - DISCONNECT A VIRTUAL CIRCUIT
	AH = 17h
	???
Return: ???
SeeAlso: AH=11h,AH=16h
--------S-6B18-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - WRITE DATA ON A VIRTUAL CIRCUIT
	AH = 18h
	???
Return: ???
SeeAlso: AX=0000h,AH=12h,AH=19h
--------S-6B19-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - READ DATA ON A VIRTUAL CIRCUIT
	AH = 19h
	???
Return: ???
SeeAlso: AX=0100h,AH=12h,AH=18h
--------S-6B1A-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - RECEIVE STATUS
	AH = 1Ah
	???
Return: ???
SeeAlso: AH=12h,AH=1Bh
--------S-6B1B-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - TRANSMIT STATUS
	AH = 1Bh
	???
Return: ???
SeeAlso: AH=12h,AH=1Ah
--------S-6B1C-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - RECEIVE BUFFER CONTROL
	AH = 1Ch
	???
Return: ???
SeeAlso: AH=1Dh,AH=1Eh
--------S-6B1D-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - TRANSMIT BUFFER CONTROL
	AH = 1Dh
	???
Return: ???
SeeAlso: AH=1Ch,AH=1Eh
--------S-6B1E-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - ISSUE CONTROL REQUEST
	AH = 1Eh
	???
Return: ???
SeeAlso: AH=1Ch,AH=1Dh
--------S-6B1F-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - EXTERNAL STATUS
	AH = 1Fh
	???
Return: ???
SeeAlso: AH=10h,AH=12h
--------S-6B21-------------------------------
INT 6B - NPC NCSI EXTENDED SERIAL I/O - QUERY NAME SERVICE
	AH = 21h
	???
Return: ???
SeeAlso: AH=14h
----------6B6B-------------------------------
INT 6B - Tandy SCHOOLMATE PLUS - API
	AH = 6Bh
	AL = E0h to FFh
--------v-6B---------------------------------
INT 6B - VIRUS - "Saddam" - ???
SeeAlso: INT 21/AX=FFFFh,INT 61"VIRUS",INT 70"VIRUS"
----------6C---------------------------------
INT 6C - system resume vector (CONVERTIBLE)
----------6C---------------------------------
INT 6C - DOS 3.2 Realtime Clock update
--------N-6C---------------------------------
INT 6C - DECnet DOS network scheduler
Notes:	the installation check consists of testing for a signature area
	  immediately preceding the interrupt handler
	also supported by DEC Pathworks for DOS
SeeAlso: INT 6B"DECnet",INT 6D"DECnet",INT 6E"DECnet"
Index:	installation check;DECnet DOS scheduler

Format of signature area:
Offset	Size	Description
 -5	BYTE	major version number
 -4	BYTE	minor version number
 -3   3 BYTEs	signature (ASCII "SCH")
--------V-6D---------------------------------
INT 6D - VGA - internal
Note:	used by IBM, Paradise, Video7, and NCR
--------V-6D---------------------------------
INT 6D - ATI VGA Wonder - VIDEO BIOS ENTRY POINT
   points at the original INT 10 entry point set up by the ATI BIOS
SeeAlso: INT 10
--------N-6D---------------------------------
INT 6D - DECnet DOS (before 2.1) - DATA LINK LAYER PROGRAM
	AH = function
	???
Return: ???
Note:	the installation check consists of testing for a signature area
	  immediately preceding the interrupt handler
SeeAlso: INT 69/AH=0Ah,INT 6C"DECnet",INT 6E"DECnet"
Index:	installation check;DECnet DOS Data Link Layer

Format of signature area:
Offset	Size	Description
 -5	BYTE	major version number
 -4	BYTE	minor version number
 -3   3 BYTEs	signature (ASCII "SCH")
--------N-6E---------------------------------
INT 6E - DECnet DOS - DECnet NETWORK PROCESS API
Notes:	this is the main DECnet DOS access, and is described in Digital manual
	  AA-EB46B-TV ("DECnet-DOS Programmer's Reference Manual")
	there is a signature/data area immediately prior to the interrupt
	  handler which may be used as an installation check
Index:	installation check;DECnet DOS

Format of signature area:
Offset	Size	Description
 -5	BYTE	major version number
 -4	BYTE	minor version number
 -3   3 BYTEs	signature (ASCII "DNP")
--------N-6F---------------------------------
INT 6F - Novell NetWare - PCOX API (3270 PC terminal interface)
--------N-6F00-------------------------------
INT 6F - 10NET - LOGIN
	AH = 00h
	DS:DX -> login record (see below)
Return: CL = security level
	AX = status (see below)
SeeAlso: AH=01h,INT 21/AX=4402h"10MEMMGR"

Format of login record:
Offset	Size	Description
 00h  8 BYTEs	user name
 08h  8 BYTEs	password
 10h 12 BYTEs	name of SuperStation

Values for status:
	    0000h successful
	    01FFh time out on response
	    02FFh network (hardware) error
	    03FFh invalid password
	    04FFh local resource not available
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
	    14FFh DOS access incompatible
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
--------N-6F01-------------------------------
INT 6F - 10NET - LOGOFF
	AH = 01h
	DS:DX -> superstation ID or nulls (12 bytes)
Return: CX = number of files closed
	AX = status (see AH=00h)
	    FF08h superstation ID not already logged in
SeeAlso: AH=00h
--------N-6F02-------------------------------
INT 6F - 10NET - STATUS OF NODE
	AH = 02h
	DS:DX -> 512-byte status record (see below)
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful

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
		bit 6: print permit on
		bit 4: SUBMIT is on
		bit 3: mail waiting for node
		bit 2: calendar waiting for you
		bit 1: news waiting for you
		bit 0: mail waiting for you
 32h	BYTE	printers allocated (bit 0=LPT1,...)
 33h	BYTE	number of unprinted spool files
 34h	BYTE	number of opened files
 35h	BYTE	number of logged on nodes
 36h	BYTE	primary drive (1=A:)
 37h	BYTE	reserved
 38h  N BYTEs	list of logged on node IDs (each 12 bytes, max 37 IDs)
1F4h  3 BYTEs	time: sec/min/hrs
1F7h  3 BYTEs	date: day/mon/year-1980
--------W-6F0204-----------------------------
INT 6F C - MS Windows 3.0 - DOS APPLICATION SWITCH HOOK
	AX = 0204h
Return: AX = status
	    0000h switch is allowed
	    other switch not allowed
Note:	intercepting this call will allow a DOS application to ensure that
	  Windows will not switch away from it.
--------N-6F03-------------------------------
INT 6F - 10NET - GET ADDRESS OF CONFIGURATION TABLE
	AH = 03h
	DS:DI -> node ID (optional)
Return: ES:BX -> configuration table 
SeeAlso: AH=13h

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
---up to here, 10NET v3.3---
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
---beyond here, 10NET v3.3---
 47h	BYTE	bit 0 = RS232 gate
		    1 = Send6F gate (user set)
 48h	DWORD	pointer into gate (user set)
 4Ch	DWORD	pointer into 10Net send
 50h  N WORDs	addresses of timer blocks
--------N-6F04-------------------------------
INT 6F - 10NET - SEND
	AH = 04h
	DS:BX -> record
		12 BYTEs receiving node's ID
			if first byte has high-order bit set, message is
			   directed to the CT_RGATE vector at the receiver
			if second byte is 00h, first byte is taken as a CB
			   channel number and delivered to all nodes on same
			   channel
		   WORD	 length of data at DX
	DS:DX -> data (max 1024 bytes)
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
SeeAlso: AH=05h
--------N-6F05-------------------------------
INT 6F - 10NET - RECEIVE
	AH = 05h
	CX = number of seconds before timeout
	DS:DX -> receive buffer (see below)
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
	    AH = FEh if dequeued message is a CB message
SeeAlso: AH=04h

Format of receive buffer:
Offset	Size	Description
 00h 12 BYTEs	sending node's ID
 0Ch	WORD	length of message
 0Eh  N BYTEs	message (maximum 1024 bytes)
--------N-6F07-------------------------------
INT 6F - 10NET - LOCK HANDLE
	AH = 07h
	BX = file handle
	CX:DX = starting offset in file
	SI = record length
Return: CF set on error
	    AX = error code (see also AH=00h)
		0002h file not found
	CF clear if successful
SeeAlso: AH=08h,INT 21/AH=5Ch
--------N-6F08-------------------------------
INT 6F - 10NET - UNLOCK HANDLE
	AH = 08h
	BX = file handle
	AL = mode
	    00h unlock all
	    01h unlock record at CX:DX
Return: CF set on error
	    AX = error code (see also AH=00h)
		0002h file not found
	CF clear if successful
SeeAlso: AH=07h,INT 21/AH=5Ch
--------N-6F09-------------------------------
INT 6F - 10NET - SUBMIT
	AH = 09h
	DS:BX -> submit record (see below)

Format of submit record:
Offset	Size	Description
 00h 12 BYTEs	destination node ID (must be logged in)
 0Ch	WORD	length+2 of following 'command line' text
 0Eh  N BYTEs	command line text (<=100 bytes), system adds CR
--------N-6F0A-------------------------------
INT 6F - 10NET - CHAT
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
--------N-6F0B-------------------------------
INT 6F - 10NET - LOCK SEMAPHORE, RETURN IMMEDIATELY
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
Note:	same as INT 60/AH=12h
SeeAlso: AH=0Ch,INT 60/AH=12h
--------N-6F0C-------------------------------
INT 6F - 10NET - UNLOCK SEMAPHORE
	AH = 0Ch
	AL = drive number or 0
	ES:SI = Ethernet address or 0
	DS:BX -> 31-byte ASCIZ semaphore name
Return: AL = status (see also AH=0Bh)
	    01h semaphore not locked
Note:	same as INT 60/AH=13h
SeeAlso: AH=0Bh,INT 60/AH=13h
--------N-6F0D-------------------------------
INT 6F - 10NET - WHO
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
--------N-6F0E-------------------------------
INT 6F - 10NET - SPOOL/PRINT
	AH = 0Eh
	DS:DX -> spool/print record (see below)
Return: CF set on error
	    AX = error code (see also AH=00h)
		FF17h device not mounted
		FF18h already spooling to named device
	CF clear if successful

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
		bit 6: do ID page
		bit 5: no form feed at end
		bit 4: reserved
		bit 3: explicit queueing only
		bit 2: notify at completion
		bit 1: notify server operator/reply
		bit 0: notify at start
 1Dh	BYTE	retention time in days
 1Eh	BYTE	printing device (LPTx)
 1Fh  3 BYTEs	date last printed (0 = never)
 22h	BYTE	device containing spoolfile
 23h	WORD	bytes to print for test print
 25h	WORD	block number to start print
 27h	BYTE	reserved
--------N-6F0F-------------------------------
INT 6F - 10NET v5.0 - "RM LOCK" - ???
	AH = 0Fh
	???
Return: ???
--------N-6F10-------------------------------
INT 6F - 10NET - ATTACH/DETACH PRINTER
	AH = 10h
	AL = subfunction
	    00h initiate spooling if LPT1 is mounted
	    01h terminate spooling if LPT1 is mounted
SeeAlso: INT 21/AX=5D08h
--------N-6F11-------------------------------
INT 6F - 10NET - LOCK FCB
	AH = 11h
	AL = mode
	    01h sequential
	    02h random
	    03h random block
		CX = number of records
	DS:DX -> FCB (see INT 21/AH=0Fh)
Return: CF set on error
	    AX = error code (see also AH=00h)
		0002h file not found
	CF clear if successful
SeeAlso: AH=12h
--------N-6F12-------------------------------
INT 6F - 10NET - UNLOCK FCB
	AH = 12h
	AL = mode
	    00h sequential
	    01h random
	    02h random block
		CX = number of records
	DS:DX -> FCB (see INT 21/AH=0Fh)
Return: CF set on error
	    AX = error code (see also AH=00h)
		0002h file not found
	CF clear if successful
SeeAlso: AH=11h
--------N-6F13-------------------------------
INT 6F - 10NET v3.3+ - GET REMOTE CONFIGURATION TABLE ADDRESS
	AH = 13h
	DS:DX -> node ID, 12 bytes blank-padded
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
	    ES:BX = configuration table address on given machine
SeeAlso: AH=03h
--------N-6F14-------------------------------
INT 6F - 10NET v3.3+ - GET REMOTE MEMORY
	AH = 14h
	BX:SI = address of remote memory
	CX = length (<=1024 bytes)
	DS:DX -> node ID, 12 bytes blank-padded
	DS:DI -> area to receive remote memory image
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
	    CX = amount of memory copied to DS:SI
--------N-6F1501-----------------------------
INT 6F - 10NET v3.3+ - GET SHARED DEVICE ENTRY
	AX = 1501h
	BX = zero-based index
	DS:SI -> node ID, 12 bytes blank-padded
	ES:DI -> 85-byte buffer for shared device table entry (see below)
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
	    ES:DI buffer contains shared device table entry of BXth device:
SeeAlso: AX=1502h,AX=1503h

Format of shared device table entry:
Offset	Size	Description
 00h  8 BYTEs	device
 08h  8 BYTEs	alias
 10h 64 BYTEs	path
 50h  8 BYTEs	password
 58h	BYTE	access
 59h  4 BYTEs	mask
--------N-6F1502-----------------------------
INT 6F - 10NET v3.3+ - SET SHARED DEVICE ENTRY
	AX = 1502h
	DS:SI -> node ID, 12 bytes blank-padded
	ES:DI -> valid shared device table entry
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
SeeAlso: AX=1501h,AX=1503h
--------N-6F1503-----------------------------
INT 6F - 10NET v3.3+ - DELETE SHARED DEVICE ENTRY
	AX = 1503h
	BX = zero-based index
	DS:SI -> node ID, 12 bytes blank-padded
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
SeeAlso: AX=1501h,AX=1502h
--------N-6F16-------------------------------
INT 6F - 10NET v5.0 - "GL WHO" - ???
	AH = 16h
	???
Return: ???
--------N-6F17-------------------------------
INT 6F - 10NET v3.3+ - MOUNT
	AH = 17h
	AL = local drive number (0=A:)
	BL = remote drive letter or '1'..'3' for LPTn or '4' or '5' for COMx
	DS:DX -> node ID, 12 bytes blank-padded
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
SeeAlso: AH=18h
--------N-6F18-------------------------------
INT 6F - 10NET v3.3+ - UNMOUNT
	AH = 18h
	AL = local drive number (0=A:)
	BL = type
	    00h	    disk
	    01h-03h LPTn
	    04h,05h COMx
Return: CF set on error
	    AX = error code (see AH=00h)
	CF clear if successful
SeeAlso: AH=17h
--------N-6F19-------------------------------
INT 6F - 10NET v5.0 - "AUDIT" - ???
	AH = 19h
	???
Return: ???
--------N-6F1A-------------------------------
INT 6F - 10NET v5.0 - "BULL" - ???
	AH = 1Ah
	???
Return: ???
--------N-6F1B-------------------------------
INT 6F - 10NET v5.0 - "GMOUNT" - ???
	AH = 1Bh
	???
Return: ???
--------N-6F1C-------------------------------
INT 6F - 10NET v5.0 - "GLOGIN" - ???
	AH = 1Ch
	???
Return: ???
--------N-6F1D-------------------------------
INT 6F - 10NET v5.0 - "TABDATA" - ???
	AH = 1Dh
	???
Return: ???
--------N-6F1E-------------------------------
INT 6F - 10NET v5.0 - "SCHED" - ???
	AH = 1Eh
	???
Return: ???
--------N-6F1F-------------------------------
INT 6F - 10NET v5.0 - "WHOAMI" - ???
	AH = 1Fh
	???
Return: ???
--------N-6F20-------------------------------
INT 6F - 10NET v5.0 - ???
	AH = 20h
	???
Return: ???
--------N-6F21-------------------------------
INT 6F - 10NET v5.0 - ???
	AH = 21h
	???
Return: ???
--------N-6F22-------------------------------
INT 6F - 10NET v5.0 - ???
	AH = 22h
	???
Return: ???
--------b-6F22--BP0012-----------------------
INT 6F - HP ES-12 EXTENDED BIOS - READ CMOS MEMORY
	AH = 22h
	BP = 0012h
	BL = address of CMOS byte to read
Return: AH = status
	AL = byte read
	BP, DS destroyed
SeeAlso: BP=0012h/AH=24h
--------b-6F24--BP0012-----------------------
INT 6F - HP ES-12 EXTENDED BIOS - WRITE CMOS MEMORY
	AH = 24h
	BP = 0012h
	BL = address of CMOS byte to write
	AL = new value
Return: AH = status
	BP, DS destroyed
SeeAlso: BP=0012h/AH=22h
--------H-70---------------------------------
INT 70 - IRQ8 - CMOS REAL-TIME CLOCK
Desc:	this interrupt is called when the real-time clock chip generates an
	  alarm or periodic interrupt, among others.  The periodic interrupt
	  occurs 1024 times per second.
Nots:	many BIOSes turn off the periodic interrupt in the INT 70h handler
	  unless in an event wait (see INT 15/AH=83h or INT 15/AH=86h).
	may be masked by setting bit 0 on I/O port A1h
SeeAlso: INT 08,INT 0F"HP 95LX",INT 15/AH=01h"Amstrad",INT 15/AH=83h
SeeAlso: INT 15/AH=86h,INT 1A/AH=02h,INT 58"DESQview"
--------v-70---------------------------------
INT 70 - VIRUS "Stupid" - ???
SeeAlso: INT 6B"VIRUS",INT E0"VIRUS"
--------H-71---------------------------------
INT 71 - IRQ9 - REDIRECTED TO INT 0A BY BIOS
Notes:	may be masked by setting bit 1 on I/O port A1h
	the default BIOS handler invokes INT 0A for compatibility, since the
	  pin for IRQ2 on the PC expansion bus became the pin for IRQ9 on the
	  AT expansion bus.
	under DESQview, only the INT 15h vector and BASIC segment address (the
	  word at 0000h:0510h) may be assumed to be valid for the handler's
	  process
SeeAlso: INT 0A,INT 59
--------H-72---------------------------------
INT 72 - IRQ10 - RESERVED
Note:	may be masked by setting bit 2 on I/O port A1h
SeeAlso: INT 5A
--------H-73---------------------------------
INT 73 - IRQ11 - RESERVED
Note:	may be masked by setting bit 3 on I/O port A1h
SeeAlso: INT 5B
--------H-74---------------------------------
INT 74 - IRQ12 - POINTING DEVICE (PS)
Notes:	may be masked by setting bit 4 on I/O port A1h
	under DESQview, only the INT 15h vector and BASIC segment address (the
	  word at 0000h:0510h) may be assumed to be valid for the handler's
	  process
SeeAlso: INT 33,INT 5C
--------H-75---------------------------------
INT 75 - IRQ13 - MATH COPROCESSOR EXCEPTION (AT and up)
   redirected to INT 02 by the BIOS, for compatibility with the PC
Notes:	may be masked by setting bit 5 on I/O port A1h
	not all clones wire the coprocessor to generate this IRQ; some systems
	  generate an NMI (see INT 02) or assert the -ERROR pin on the CPU
	  (see INT 10"COPROCESSOR")
	under DESQview, only the INT 15h vector and BASIC segment address (the
	  word at 0000h:0510h) may be assumed to be valid for the handler's
	  process
SeeAlso: INT 10"COPROCESSOR",INT 5D
--------H-76---------------------------------
INT 76 - IRQ14 - HARD DISK CONTROLLER (AT and later)
Note:	may be masked by setting bit 6 on I/O port A1h
SeeAlso: INT 0E"IRQ6",INT 5E
--------H-77---------------------------------
INT 77 - IRQ15 - RESERVED (AT,PS)
Note:	may be masked by setting bit 7 on I/O port A1h
SeeAlso: INT 5F
--------H-77---------------------------------
INT 77 - IRQ15 - POWER CONSERVATION (Compaq SLT/286)
Note:	may be masked by setting bit 7 on I/O port A1h
SeeAlso: INT 15/AX=4600h,INT 5F
--------E-78---------------------------------
INT 78 - UofSalford DBOS DOS extender - API
	AH = function
	    00h (PB) display 32-bit memory specified by command argument
	    01h (PT) display 32-bit instruction(s) specified by command arg
	    02h specify offset to subsequent PB and PT commands
	    03h switch to protected mode
	    	DWORD following INT instruction point to map; protected-mode
			entry point is immediately following the DWORD
		Return: never
		Note:	if bit 31 of the map address is set, only a stub was
			  loaded by DOS and DBOS will load the entire program
	    04h specify that subsequent load (AH=03h) should leave program in
		memory
	    05h release program from memory
	    06h set break point at address and option count from commandline
	    07h resume program execution
	    08h single-step program
	    09h set read/write breakpoint using 386 debug registers
	    0Ah set write breakpoint using 386 debug register
	    0Bh set memory byte to new value
	    0Ch display CPU registers
	    0Dh run until specified program address reached
	    0Fh print trace from program map
	    10h specify an offset using a map symbol
	    14h print memory without any offset
	    18h switch DBOS into/out of test mode (ON/OFF commandline args)
	    1Dh get address of real/protected-mode communication buffer
	    	Return: ES:BP -> comm buffer
	    1Eh set real-mode memory size (specify how much real-mode memory
		  to leave free when running FTN77 programs)
	    22h uninstall DBOS
	    24h force DBOS to emulate coprocessor instructions
	    26h set named DBOS switches from commandline
	    27h reset named DBOS switched from commandline
	    2Ah set list of dynamic link libraries to contents of commandline
		file
	    35h specify that subsequent load (AH=03h) should stop at first
		instruction
Return: ???
Notes:	DBOS supports functions 00h through 50h; many of these functions
	  provide a low-level debugging interface
	command arguments are read from the calling program's PSP
SeeAlso: INT 79"DBOS"
Index:	uninstall;DBOS DOS extender
--------E-78---------------------------------
INT 78 - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ0
Program: GO32.EXE is a DOS extender included as part of the 80386 port of the
	  GNU C/C++ compiler by DJ Delorie and distributed as DJGPP
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 08,INT 10/AH=FFh"GO32",INT 79"GO32"
--------A-78---------------------------------
INT 78 - AutoCAD 10 ADI for Plotters
	AX = function
	    0001h initialize comm port and reset plotter
		BX = ??? (comm port?)
	    0002h close plotter
	    0003h move (pen up)
		BX = new X position
		CX = new Y position
	    0004h move (pen down)
		BX = new X position
		CX = new Y position
	    0005h select pen
		BX = pen number
	    0006h select drawing speed
		BX = drawing speed N
	    0007h select line style
		BX = line style N
	    0008h return pen to pen carrier??? (called before change-pen cmd)
Return: ???
SeeAlso: INT 7A"AutoCAD",INT 7B"AutoCAD"
--------d-78---------------------------------
INT 78 - ADP-60 IDE controller - ORIGINAL INT 13
SeeAlso: INT 79"ADP-60"
--------d-7800-------------------------------
INT 78 - TARGA.DEV - CMC International SCSI device driver - SET I/O PORT
	AH = 00h
	DX = interface board I/O port
Return:	CF set on error
	    AL = error code
		00h illegal command given to SCSI code
		01h invalid I/O port specified (must be from 100H to 3F8H, and
		    must be on an 8-port boundary)
		02h invalid DMA channel specified (must be from 1 to 3)
		03h invalid SCSI board number specified (must be from 0 to 7)
		04h error from data register test during self-test
		05h SCSI input signals not all 0 when SCSI RST activated
		06h SCSI input signals not all 0 before selecting a SCSI device
		07h BSY signal is active; SCSI bus is busy
		08h SCSI board not selected, BSY signal did not come on in
		    response to raising SEL
		09h time-out waiting for status state, signifying end of DMA
		    transfer
Note:	if this routine is not called, the port is the driver's default
	  (usually 0280h or 0300h)
	an installation check is performed by TARGA.DEV upon initialization
	  by checking for the string "SCSI" at offset 03h into the interrupt
	  handler
SeeAlso: AH=01h,AH=02h
Index:	installation check;TARGA.DEV
--------d-7801-------------------------------
INT 78 - TARGA.DEV - GET I/O PORT
	AH = 01h
Return: DX = current interface board I/O port
SeeAlso: AH=00h,AH=03h"TARGA"
--------d-7802-------------------------------
INT 78 - TARGA.DEV - SET DMA CHANNEL
	AH = 02h
	AL = interface board DMA channel
Return: CF set on error
	AL = error code (see AH=00h)
Note:	if this routine is not called, the DMA channel is the driver's default
	  (usually 3)
SeeAlso: AH=00h,AH=03h"TARGA"
--------d-7803-------------------------------
INT 78 - TARGA.DEV - GET DMA CHANNEL
	AH = 03h
Return: AL = current interface board DMA channel
SeeAlso: AH=01h,AH=02h
--------d-7804-------------------------------
INT 78 - TARGA.DEV - SET SCSI DEVICE NUMBER
	AH = 04h
	AL = SCSI device number
Return: CF set on error
	AL = error code (see AH=00h)
Note:	if this routine is not called, the device number used is the driver's
	  default (usually 0)
SeeAlso: AH=02h,AH=05h
--------d-7805-------------------------------
INT 78 - TARGA.DEV - GET SCSI DEVICE NUMBER
	AH = 05h
Return: AL = current SCSI device number
SeeAlso: AH=03h"TARGA",AH=04h
--------d-7806-------------------------------
INT 78 - TARGA.DEV - SET/CLEAR EARLY RETURN MODE
	AH = 06h
	AL = 00h clear early return mode
	   = 01h set early return mode
Note:	if early return mode is set then SCSI will return with no errors
	  when the last DMA transfer is started in a call with AH=13h or AH=14h
	if this routine is not called, early return mode is cleared
SeeAlso: AH=13h,AH=14h,AH=15h
--------d-7808-------------------------------
INT 78 - TARGA.DEV - INTERFACE BOARD SELF-TEST
	AH = 08h
Return: CF set on error
	AL = error code (see AH=00h)
Note:	the SCSI bus is also reset
SeeAlso: AH=09h
--------d-7809-------------------------------
INT 78 - TARGA.DEV - RESET SCSI BUS
	AH = 09h
Return: AL = error code if carry set (see AH=00h)
SeeAlso: AH=08h
--------d-7810-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND
	AH = 10h
	DS:SI -> command bytes
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see AH=00h)
SeeAlso: AH=11h,INT 21/AX=4403h"ST-01"

Format of SCSI Command:
Offset	Size	Description
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7811-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND, RECEIVE DATA (PROGRAMMED I/O)
	AH = 11h
	DS:SI -> command bytes
	ES:BX -> data storage area
	CX = number of data bytes to transfer
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see AH=00h)
Note:	this command receives data internally one byte at a time
SeeAlso: AH=10h,AH=13h

Format of SCSI Command:
Offset	Size	Description
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7812-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND AND DATA (PROGRAMMED I/O)
	AH = 12h
	DS:SI -> command bytes
	ES:BX -> data storage area
	CX = number of data bytes to transfer
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see AH=00h)
Note:	this command sends data internally one byte at a time
SeeAlso: AH=14h

Format of SCSI Command:
Offset	Size	Description
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7813-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND, RECEIVE DATA (DMA)
	AH = 13h
	DS:SI -> command bytes
	ES:BX -> data storage area
	DX:CX = number of data bytes to transfer
Return: AH = SCSI status byte (if early return mode is clear)
	CF clear if successful
	    AL = SCSI message byte (if early return mode is clear)
	CF set on error
	    AL = error code (see AH=00h)
Note:	this command receives data using DMA
SeeAlso: AH=11h,AH=12h

Format of SCSI Command:
Offset	Size	Description
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7814-------------------------------
INT 78 - TARGA.DEV - SEND SCSI COMMAND AND DATA (DMA)
	AH = 14h
	DS:SI -> command bytes
	ES:BX -> data storage area
	DX:CX = number of data bytes to transfer
Return: AH = SCSI status byte (if early return mode is clear)
	CF clear if successful
	    AL = SCSI message byte (if early return mode is clear)
	CF set on error
	    AL = error code (see AH=00h)
Note:	this command sends data using DMA
SeeAlso: AH=12h,AH=13h

Format of SCSI Command:
Offset	Size	Description
 00h	BYTE	length of command
 01h	???	command bytes
--------d-7815-------------------------------
INT 78 - TARGA.DEV - FINISH DATA TRANSFER (DMA)
	AH = 15h
Return: AH = SCSI status byte
	CF clear if successful
	    AL = SCSI message byte
	CF set on error
	    AL = error code (see AH=00h)
Note:	if AH=06h was previously called to set the early return mode, this
	  function finishes a command AH=13h or AH=14h which returned before
	  the last DMA transfer was finished
SeeAlso: AH=06h,AH=13h,AH=14h
--------V-79---------------------------------
INT 79 - AVATAR.SYS - FAST GET KEYSTROKE
Return: CF set if no keystroke available
	    AX = FFFFh
	CF clear if key pressed
	    AX = keystroke
Program: AVATAR.SYS is a CON driver by George Adam Stanislav which interprets
	  AVATAR command codes just as ANSI.SYS interprets ANSI commands
Note:	if a keystroke is available, it is removed from the keyboard buffer
	  before being returned
SeeAlso: INT 29
--------E-79---------------------------------
INT 79 - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ1
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 09,INT 78"GO32",INT 7A"GO32"
--------d-79---------------------------------
INT 79 U - ADP-60 IDE adapter - ???
SeeAlso: INT 78"ADP-60"
--------E-79---------------------------------
INT 79 - DBOS DOS Extender
	details not available
Desc:	this interrupt is used by an MS Windows virtual device driver with
	  which the DBOS extender communicates when run inside a Windows
	  Enhanced Mode DOS box
SeeAlso: INT 78"DBOS"
--------A-790001-----------------------------
INT 79 U - AutoCAD Device Interface - DIGITIZER - INITIALIZE
	AX = 0001h
Return: AX = 0001h ??? self-test result???
	BX = 0001h
SeeAlso: AX=0002h,AX=0003h,INT 7A"AutoCAD"
--------A-790002-----------------------------
INT 79 U - AutoCAD Device Interface - DIGITIZER - CLOSE
	AX = 0002h
SeeAlso: AX=0001h,AX=0003h
--------A-790003-----------------------------
INT 79 U - AutoCAD Device Interface - DIGITIZER - GET DIGITIZER STATUS
	AX = 0003h
Return: AX = button state
	    0002h no button pressed
		BX = X coordinate
		CX = Y coordinate
	    0003h Pick button (0,A,B,C,D) pressed
		BX = X coordinate
		CX = Y coordinate
	    0005h other button (1-9) pressed
		BX = number of button - 1
		CX = X coordinate
		DX = Y coordinate
Note:	these return values are valid for the Houston Instruments HiPad Plus
	  9236 digitizer with a 16-button cursor
SeeAlso: AX=0001h,AX=0002h
--------N-7A---------------------------------
INT 7A U - Topware Network Operating System - ???
	AL = ???
	???
Return: ???
SeeAlso: INT 21/AH=FFh"Topware",INT 2F/AX=FF00h
--------A-7A---------------------------------
INT 7A - AutoCAD Device Interface
	???
SeeAlso: INT 61/AX=0007h"OPTIMA",INT 78"AutoCAD",INT 79/AX=0001h
SeeAlso: INT 7B"AutoCAD"
--------N-7A---------------------------------
INT 7A - X.PC Packet software interface
	ES:BX -> parameter block
SeeAlso: INT 60/AX=01FFh
--------E-7A---------------------------------
INT 7A - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ2
Program: GO32.EXE is a DOS extender included as part of the 80386 port of the
	  GNU C/C++ compiler by DJ Delorie and distributed as DJGPP
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 0A,INT 79"GO32",INT 7B"GO32"
--------N-7A---------------------------------
INT 7A - Novell NetWare - LOW-LEVEL API - Notes
Note:	this interrupt is used for IPX/SPX access in NetWare versions through
	  2.0a; in later versions, you should use INT 2F/AX=7A00h to get an
	  entry point even though INT 7A still exists.	For both INT 7A and
	  the FAR entry point, BX contains the function number; IPX is
	  sometimes called internally with BX bit 15 set.
SeeAlso: INT 2F/AX=7A00h,INT 64"Novell",INT 7A/BX=0000h
--------N-7A----BX0000-----------------------
INT 7A - Novell NetWare - IPX Driver - OPEN SOCKET
	BX = 0000h
	AL = socket longevity
	    00h open until close or terminate
	    FFh open until close
	DX = socket number (high byte in DL)
	    0000h dynamic allocation
	    else  socket to open (see below)
Return: AL = return code
	    00h success
		DX = socket number
	    FEh socket table full
	    FFh socket already open
Notes:	TSRs which need to use sockets should set AL to FFh, non-resident
	  programs should normally use AL=00h
	IPX can be configured to support up to 150 open sockets on a
	  workstation, and defaults to 20
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0001h,BX=0004h

Values for socket number:
 0451h File Service
 0452h Service Advertising Socket
 0453h Routing Information Packet
 0455h NetBIOS Packet
 0456h diagnostics
 0457h ??? (appears to be related to server serial numbers)
 4000h-7FFFh used for dynamic allocation
 4444h Brightwork Development's SiteLock server
 5555h Brightwork Development's SiteLock client (workstation)
 8000h-FFFFh assigned by Novell
Note:	SiteLock is an application metering product using IPX to communicate
	  between the application and the license server
--------N-7A----BX0001-----------------------
INT 7A - Novell NetWare - IPX Driver - CLOSE SOCKET
	BX = 0001h
	DX = socket number (high byte in DL)
Notes:	also cancels events set by any Event Control Blocks for the socket
	the program must close all open sockets before terminating
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0000h
--------N-7A----BX0002-----------------------
INT 7A - Novell NetWare - IPX Driver - GET LOCAL TARGET
	BX = 0002h
	ES:SI -> target internetwork address (see INT 7A/BX=000Bh)
	ES:DI -> 6-byte buffer for local target
Return: AL = return code
	    00h success
	       CX = expected one-way transfer time (clock ticks) for a 576-byte
			packet
	       ES:DI -> local target
	    FAh unsuccessful (no path to destination)
Notes:	the internetwork address consists of a 4-byte network address followed
	  by a 6-byte node address.  The local target is only a 6-byte node
	  address.  If the target is in the same network, the local target is
	  just the node address of target; otherwise, the local target is the
	  node address of the bridge that leads to the target.
	this function may be called from inside IPX and AES Event Service
	  Routines, but not from other interrupt handlers
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0009h
--------N-7A----BX0003-----------------------
INT 7A - Novell NetWare - IPX Driver - SEND PACKET
	BX = 0003h
	ES:SI -> Event Control Block (see below)
Notes:	returns immediately; IPX attempts to send the packet in the background
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0004h,BX=000Fh,INT 21/AH=EEh"Novell"

Format of Event Control Block:
Offset	Size	Description
 00h	DWORD	Link
 04h	DWORD	-> Event Service Routine (00000000h if none)
 08h	BYTE	in use flag
		00h available
		E0h AES temporary
		F6h \ special IPX/SPX processing for v3.02+
		F7h /
		F8h IPX in critical section
		F9h SPX listening
		FAh processing
		FBh holding
		FCh AES waiting
		FDh AES couting down delay time
		FEh awaiting packet reception
		FFh sending packet
 09h	BYTE	completion code (see below)
 0Ah	WORD	socket number (big-endian) (see INT 7A/BX=0000h)
 0Ch  4 BYTES	IPX workspace
 10h 12 BYTES	driver workspace
 1Ch  6 BYTES	immediate local node address
 22h	WORD	fragment count
 24h	var	fragment descriptors
		Offset	Size	Description
		 00h	DWORD	-> fragment data
		 04h	WORD	size of fragment in bytes.
Notes:	ESR is a far procedure that is called when the ECB has been handled.
	  On call, the in use flag is zero if the ECB has been handled,
	  non-zero otherwise. If the flag is zero, the completion code holds
	  the result of the event.
	the first fragment should start with an IPX header
	all fragments are concatenated and sent in one piece
	node address FFh FFh FFh FFh FFh FFh broadcasts to all nodes

Values for ECB completion code:
 00h success
 ECh remote terminated connection without acknowledging packet
 EDh abnormal connection termination
 EEh invalid connection ID
 EFh SPX connection table full
 F9h event should not be cancelled
 FAh cannot establish connection with specified destination
 FCh cancelled
 FDh malformed packet
 FEh packet undeliverable
 FFh physical error

Event Service Routine called with:
	AL = caller's identity (00h = AES, FFh = IPX)
	ES:SI -> event control block
	interrupts disabled

Format of IPX header:
Offset	Size	Description
 00h	WORD	checksum (high byte first [big-endian])
 02h	WORD	length in bytes (high byte first) of total packet
 04h	BYTE	transport control
 05h	BYTE	packet type
		00h unknown packet type
		01h routing information packet
		02h echo packet
		03h error packet
		04h packet exchange packet (always use this one)
		05h SPX packet
		11h-1Eh experimental protocols
 06h 10 BYTES	destination internetwork address
 10h	WORD	destination socket (high byte first)
 12h 10 BYTES	source internetwork address
 1Ch	WORD	source socket (high byte first)

Format of Service Advertising Protocol Service Query Packet:
Offset	Size	Description
 00h 30 BYTEs	IPX header
 1Eh	WORD	query type (big-endian)
 20h	WORD	server type (big-endian) (see INT 21/AH=E3h"NetWare")

Format of Service Advertising Protocol Server Identification Packet:
Offset	Size	Description
 00h 30 BYTEs	IPX header
 1Eh	WORD	response type (big-endian)
		0002h general service
		0004h nearest service
 20h	WORD	server type (big-endian) (see INT 21/AH=E3h"NetWare")
 22h 48 BYTEs	ASCIZ server name
 52h  2 WORDs	network number (big-endian)
 54h  3 WORDs	node number (big-endian)
 5Ch	WORD	socket number (big-endian)
 5Eh	WORD	number of hops between caller and server (big-endian)
--------N-7A----BX0004-----------------------
INT 7A - Novell NetWare - IPX Driver - LISTEN FOR PACKET
	BX = 0004h
	ES:SI -> Event Control Block (see BX=0003h)
Return: AL = status
	    00h successful
	    FFh no listening socket for packet
Desc:	this function provides IPX with an ECB for receiving an IPX packet, but
	  does not wait for a packet to arrive
Notes:	the application must open a socket and initialize the ECB's ESR
	  address, socket number, fragment count, and fragment descriptor
	  fields before invoking this function
	there is no limit on the number of ECBs which may simultaneously be
	  listening on a socket
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0000h,BX=0003h
--------N-7A----BX0005-----------------------
INT 7A - Novell NetWare - IPX Driver - SCHEDULE IPX EVENT
	BX = 0005h
	AX = delay time in clock ticks
	ES:SI -> Event Control Block (see BX=0003h)
Note:	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0006h,BX=0007h,BX=0008h
--------N-7A----BX0006-----------------------
INT 7A - Novell NetWare - IPX Driver - CANCEL EVENT
	BX = 0006h
	ES:SI -> Event Control Block (see BX=0003h)
Return: AL = return code
	    00h success
	    F9h event in use
	    FCh event cancelled
	    FFh unsuccessful, event not in use, or unrecognized ECB flag
Notes:	cannot cancel packets which the node's driver has already sent
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0005h
--------N-7A----BX0007-----------------------
INT 7A - Novell NetWare - IPX Driver - SCHEDULE SPECIAL EVENT
	BX = 0007h
	AX = delay time
	ES:SI -> Event Control Block (see BX=0003h)
Note:	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0006h
--------N-7A----BX0008-----------------------
INT 7A - Novell NetWare - IPX Driver - GET INTERVAL MARKER
	BX = 0008h
Return: AX = interval marker in clock ticks
Notes:	may be used to measure the time elapsed between two events, up to one
	  hour
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0005h
--------N-7A----BX0009-----------------------
INT 7A - Novell NetWare - IPX Driver - GET INTERNETWORK ADDRESS
	BX = 0009h
	ES:SI -> buffer for own internetwork address (see below)
Return: ES:SI buffer filled
	SI destroyed
Note:	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0002h,BX=000Bh

Format of internetwork address:
Offset	Size	Description
 00h  4 BYTEs	network number (big-endian)
 04h  6 BYTEs	node number within network (big-endian)
--------N-7A----BX000A-----------------------
INT 7A - Novell NetWare - IPX Driver - RELINQUISH CONTROL
	BX = 000Ah
Desc:	this call indicates that the application is idle and permits the IPX
	  driver to do some work
Note:	this function is supported by Advanced NetWare 1.02+
SeeAlso: INT 15/AX=1000h,INT 21/AH=89h,INT 2F/AX=1680h
--------N-7A----BX000B-----------------------
INT 7A - Novell NetWare - IPX Driver - DISCONNECT FROM TARGET
	BX = 000Bh
	ES:SI -> internetwork address (see below)
Notes:	this function permits the network software on the remote machine to
	  remove any virtual connection with the calling machine
	only use in point-to-point networks
	should never be called from within an Event Service Routine
	this function is supported by Advanced NetWare 1.02+
SeeAlso: BX=0002h,BX=0009h

Format of internetwork address:
Offset	Size	Description
 00h  4 BYTEs	destination network (big-endian)
 04h  6 BYTEs	destination node (big-endian)
 0Ah  2 BYTEs	destination socket (big-endian)
--------N-7A----BX000C-----------------------
INT 7A U - Novell NetWare - IPX Driver - internal - INITIALIZE NETWORK ADDRESS
	BX = 000Ch
	CX:DX = global network address (see INT 7A/BX=0002h)
	ES:DI -> "OSINCRITICALSECTION" flag
	DS:SI -> current mode for socket
Note:	the address cannot be changed once it has been initialized
--------N-7A----BX000D-----------------------
INT 7A U - Novell NetWare - IPX Driver - internal - IPX GET PACKET SIZE
	BX = 000Dh
Return: AX = maximum packet size
	CX = retry count
SeeAlso: BX=001Ah
--------N-7A----BX000E-----------------------
INT 7A U - Novell NetWare - IPX Driver - internal - TERMINATE SOCKETS
	BX = 000Eh
Return: nothing
Note:	this function terminates all sockets opened with the current mode; this
	  may be intended for future enhancements as the socket mode never
	  changes in v2.15
--------N-7A----BX000F-----------------------
INT 7A U - Novell NetWare - IPX Driver - INTERNAL - SEND PACKET
	BX = 000Fh
	ES:SI -> Event Control Block (see BX=0003h)
Note:	similar to function 0003h, but apparently does not allow multiple
	  fragments (there is a report that the NetWare shell uses it with a
	  fragmented buffer)
SeeAlso: BX=0003h
--------N-7A----BX0010-----------------------
INT 7A - Novell NetWare - SPX Driver - INSTALLATION CHECK
	BX = 0010h
	AL = 00h
Return: AL = FFh if SPX loaded
	    BH = SPX major version
	    BL = SPX minor version
	    CX = maximum SPX connections
	    DX = SPX connections available
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: BX=0015h
--------N-7A----BX0011-----------------------
INT 7A - Novell NetWare - SPX Driver - ESTABLISH SPX CONNECTION
	BX = 0011h
	AL = retry count
	AH = watchdog flag
	ES:SI -> Event Control Block (see BX=0003h)
Return: AL = status
	    00h attempting to contact destination socket
	    EFh local connection table full
	    FDh buffer size not 42 or fragment count not 1
	    FFh sending socket not open
	DX = assigned connection ID number
Desc:	attempt to establish a connection with a listening socket
Notes:	there should always be at least two SPX ECB's listening to a socket, so
	  that NetWare can perform its internal packet exchanges
	the first fragment should start with a SPX header.  Fill in all
	  destination addresses.
	this function is supported by Advanced NetWare 2.1+
SeeAlso: BX=0000h,BX=0012h,BX=0013h,BX=0014h,BX=0015h
 
Format of SPX header:
Offset	Size	Description
 00h	WORD	checksum (big-endian)
 02h	WORD	length in bytes of total packet (big-endian)
 04h	BYTE	transport control
 05h	BYTE	packet type (see INT 7A/BX=0003h)
 06h 10 BYTEs	destination internet address
 10h	WORD	destination socket (big-endian)
 12h 10 BYTEs	source internet address
 1Ch	WORD	source socket (big-endian)
 1Eh	BYTE	connection control
 1Fh	BYTE	datastream type
 20h	WORD	source connection ID (big-endian)
 22h	WORD	destination connection ID (big-endian)
 24h	WORD	sequence number (big-endian)
 26h	WORD	acknowledge number (big-endian)
 28h	WORD	allocation number (big-endian)
--------N-7A----BX0012-----------------------
INT 7A - Novell NetWare - SPX Driver - LISTEN FOR SPX CONNECTION
	BX = 0012h
	AH = watchdog flag
	    00h disabled
	    01h enabled
	AL = retry count (00h = default)
	ES:SI -> Event Control Block (see BX=0003h)
Notes:	there should always be at least two SPX ECB's listening to a socket, so
	  that NetWare can perform its internal packet exchanges
	this function is supported by Advanced NetWare 2.1+
SeeAlso: BX=0011h,BX=0013h,BX=0014h
--------N-7A----BX0013-----------------------
INT 7A - Novell NetWare - SPX Driver - TERMINATE SPX CONNECTION
	BX = 0013h
	DX = connection ID to terminate
	ES:SI -> Event Control Block (see BX=0003h)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: BX=0011h,BX=0012h,BX=0014h
--------N-7A----BX0014-----------------------
INT 7A - Novell NetWare - SPX Driver - ABORT SPX CONNECTION
	BX = 0014h
	DX = connection ID to terminate
Notes:	this function is supported by Advanced NetWare 2.1+
	this function does not tell the other side that the connection has been
	  terminated
	also aborts any outstanding Establish Connection, Terminate Connection,
	  and Send Sequenced Packet commands
SeeAlso: BX=0011h,BX=0013h
--------N-7A----BX0015-----------------------
INT 7A - Novell NetWare - SPX Driver - GET SPX CONNECTION STATUS
	BX = 0015h
	DX = connection ID
	ES:SI -> status buffer (see below)
Return: AL = return code
	    00h connection still valid
		ES:SI -> status buffer filled
	    EEh no such connection
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: BX=0010h,BX=0011h
 
Format of status buffer:
Offset	Size	Description
 00h	BYTE	connection state
		01h waiting to establish connection
		02h starting (attempting to create connection)
		03h connection established
		04h terminating
 01h	BYTE	watchdog flag
		bit 0: used internally by SPX
		bit 1: SPX watchdog is monitoring connection
		bits 2-7 used internally by SPX
 02h	WORD	source connection ID (big-endian)
 04h	WORD	destination connection ID (big-endian)
 06h	WORD	sequence number of next packet sent (big-endian)
 08h	WORD	acknowledge number, expected sequence number of next received
		packet (big-endian)
 0Ah	WORD	maximum sequence number remote SPX may send without ACK from
		local SPX (big-endian)
 0Ch	WORD	remote acknowledge number, next sequence number remote SPX
		expects to receive (big-endian)
 0Eh	WORD	remote allocation number, maximum sequence number local SPX
		may send (big-endian)
 10h	WORD	connection socket (big-endian)
 12h  6 BYTEs	immediate node address--bridge on local network to destination
 18h 10 BYTEs	destination internetwork address (see INT 7A/BX=000Bh)
 22h	WORD	retransmit count (big-endian)
 24h	WORD	estimated roundtrip delay (big-endian)
 26h	WORD	retransmitted packets (big-endian)
 28h	WORD	suppressed packets (big-endian)
 2Ah 12 BYTEs	??? (v2.15)
--------N-7A----BX0016-----------------------
INT 7A - Novell NetWare - SPX Driver - SEND SPX PACKET
	BX = 0016h
	DX = connection ID
	ES:SI -> Event Control Block (see BX=0003h)
Notes:	this function is supported by Advanced NetWare 2.1+
	CX may need to be 0001h ???
SeeAlso: BX=0011h,BX=0017h
--------N-7A----BX0017-----------------------
INT 7A - Novell NetWare - SPX Driver - LISTEN FOR SPX PACKET
	BX = 0017h
	DX = connection ID (unused in v2.15)
	ES:SI -> Event Control Block (see BX=0003h)
Notes:	this function is supported by Advanced NetWare 2.1+
	CX may need to be 0001h ???
SeeAlso: BX=0011h,BX=0016h
--------N-7A----BX0018-----------------------
INT 7A U - Novell NetWare - SPX Driver - internal - ADD DIAGNOSTIC ELEMENT
	BX = 0018h
	ES:SI -> diagnostic element (see below) to be added to Diagnostic Queue
Note:	this function is supported on file servers only under v2.15; v3.02 also
	  supports it on workstations
SeeAlso: BX=0019h

Format of diagnostic element:
Offset	Size	Description
 00h	DWORD	pointer to next diagnostic element
 04h	DWORD	pointer to function for ???
 08h	DWORD	pointer to function for ???
--------N-7A----BX0019-----------------------
INT 7A U - Novell NetWare - IPX Driver - internal - CANCEL DIAGNOSTIC ELEMENT
	BX = 0019h
	ES:SI -> diagnostic element (see BX=0018h) to be removed
Note:	this function is supported on file servers only under v2.15; v3.02 also
	  supports it on workstations
SeeAlso: BX=0018h
--------N-7A----BX001A-----------------------
INT 7A U - Novell NetWare - IPX Driver - internal - GET DRIVER PACKT SIZE LIMIT
	BX = 001Ah
Return: AX = packet size with preamble
	CX = IPX retry count
Note:	this function is supported on file servers only under v2.15; v3.02 also
	  supports it on workstations
SeeAlso: BX=000Dh
--------N-7A----BX001B-----------------------
INT 7A U - Novell NetWare - IPX Driver - INTERNAL
	BX = 001Bh
	???
Return: ???
Note:	this function is supported on file servers only under v2.15; v3.02 also
	  supports it on workstations
--------I-7A04-------------------------------
INT 7A - IBM 3270 Workstation Program API - CREATE A QUEUE
	AH = 04h
	???
Return: ???
SeeAlso: AH=06h
--------I-7A06-------------------------------
INT 7A - IBM 3270 Workstation Program API - DELETE A QUEUE
	AH = 06h
	???
Return: ???
SeeAlso: AH=04h
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - SESSION SERVICES
	AH = 09h
	BX = 8020h (synchronous request)
	CX = 0000h
	DX = ID of session manager (SESSMGR)
	AL = service
	    01h get session ID
	    02h get session info
	    04h dettach from session
	    05h attach to session
	    06h get list of windows available
	    07h get environment of window
	    08h get 'PIF' (program information file) info
	    0Ah get base window ID
	    0Bh get cursor info
	ES:DI -> control block
Return: ???
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - KEYBOARD SERVICES
	AH = 09h
	BX = 8020h (synchronous request)
	CX = 0000h
	DX = ID of keyboard manager
	AL = service
	    01h connect to keyboard
	    02h disconnect from keyboard
	    03h read from keyboard
	    04h send keystroke to session
	    05h disable input
	    06h enable input
	    07h update status code
	ES:DI -> control block
Return: ???
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - WINDOW SERVICES
	AH = 09h
	BX = 8020h (synchronous request)
	CX = 00FFh
	DX = ID of window service controller (WSCTRL)
	AL = service
	    01h connect to WS control
	    02h disconnect from WS control
	    03h add a window
	    04h change window's position on screen
	    05h change window's size
	    06h change window's color
	    07h change window's position in the presentation space
	    08h hide/unhide toggle
	    09h enlarge/reduce toggle
	    0Ah change screen background color
	    0Bh get window's position on screen
	    0Ch get window's size
	    0Dh get window's color
	    0Eh get window's position in the presentation space
	    0Fh determine whether hidden
	    10h determine whether enlarged
	    11h get background color
	    12h get window names
	    13h delete all windows from profile
	    14h pick active window
	    15h redraw screen
	    16h redraw window
	    17h delete a window from profile
	    18h get active window
	    19h get active screen
	    1Ah get window data
	    1Bh change window data
	    1Ch select active screen
	ES:DI -> control block
Return: ???
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - PRESENTATION SPACE SERVICES
	AH = 09h
	BX = 8020h
	CX = 00FFh
	DX = ID of PCPSM
	AL = service
	    01h define presentation space
	    02h delete presentation space
	    03h display presentation space
	    04h position cursor in presentation space
	    05h change default presentation space
	ES:DI -> control block
Return: ???
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - 3270 EMULATION
	AH = 09h
	BX = 8020h
	CX = 00FFh
	DX = ID of 3270EML
	AL = service
	    01h connect
	    02h disconnect
	ES:DI -> control block
Return: ???
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - OPERATOR INFORMATION AREA
	AH = 09h
	BX = 8020h
	CX = 00FFh
	DX = ID of OIAM
	AL = service
	    01h read Operator Information Area
	    02h read OIA subset
	ES:DI -> control block
Return: ???
Note: the OIA is the 25th line on the Host session
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - TRANSLATE DATA
	AH = 09h
	BX = 8020h
	CX = 00FFh
	DX = ID of XLATE
	AL = service
	    01h translate from host characters to ASCII and vice versa
		(determined by control block byte 11)
	ES:DI -> control block
Return: ???
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - COPY SERVICE
	AH = 09h
	BX = 8020h
	CX = 00FFh
	DX = ID of copy service
	AL = service
	    01h copy string from one presentation space to another
	    02h copy block from one presentation space to another
	    03h connect to PC session for copy
	    04h disconnect PC session from copy
	ES:DI -> control block
Return: ???
--------I-7A09--BX8020-----------------------
INT 7A - IBM 3270 Workstation Program API - Multi-DOS
	AH = 09h
	BX = 8020h
	CX = 00FFh
	ES:DI -> control block
	DX = ID of INDJQRY  
		get environment size
	   = ID of INDJASY
		request DOS functions from workstation
	   = ID of MEMORY
		AL = function
		    01h allocate memory
		    02h deallocate memory
		    03h modify allocated size
Return: ???
--------I-7A09-------------------------------
INT 7A - IBM 3270 Workstation Program API - HOST SERVICES
	AH = 09h
	BX = request type (4000h async, 8028h synchronous)
	CX = 0000h
	DX = ID of MFIC
	AL = service
	   01h connect to host
	   02h disconnect from host
	   03h read DFT structured data from host
	   04h write DFT structured data to host
	   05h create a host buffer
	ES:DI -> control block
--------I-7A13-------------------------------
INT 7A - IBM 3270 Workstation Program API - GET DATA FROM A QUEUE
	AH = 13h
	???
Return: ???
----------7A7A-------------------------------
INT 7A - Canon IX-30F Image Scanner SI3.SYS - INTERFACE
	AH = 7Ah
	???
Return: AX = 0000h success
	     000Eh undefined function code
Note:	this interface is normally on INT 7A but can be changed via device
	  driver command line arguments
--------I-7A81-------------------------------
INT 7A - IBM 3270 Workstation Program API - RESOLVE A GATE NAME
	AH = 81h
	ES:DI -> 8-char blank-padded gate name
		"SESSMGR ", "KEYBOARD", "WSCTRL	 ", "MFIC    ", "PCPSM	 ",
		"3270EML ", "COPY    ", "XLATE	 ", "OIAM    ", "MEMORY	 ",
		"INDJQRY ", or "INDJASY "
Return: DX = gate ID
--------I-7A83-------------------------------
INT 7A - IBM 3270 Workstation Program API - GET COMPLETION RESULTS
	AH = 83h
	???
Return: ???
--------I-7AFDCB-----------------------------
INT 7A - IBM Personal Communications/3270 - INSTALLATION CHECK
	AX = FDCBh
Return: DX:AX -> PCS/3270 signature block if loaded (see below)

Format of signature block:
Offset	Size	Description
 04h	WORD	PCS/3270 signature (5741h)
 06h	WORD	version (0501h = PCS/3270 v1.0)
--------I-7AFE01-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL SEND/RECEIVE FUNCTION
	AX = FE01h
	???
Return: ???
SeeAlso: AX=FE02h
--------I-7AFE02-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL SEND/RECEIVE FUNCTION
	AX = FE02h
	???
Return: ???
SeeAlso: AX=FE01h
--------I-7AFF01-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL API INITIALIZATION
	AX = FF01h
	ES:DI -> API function handler routine
Return: CX = 1200h
SeeAlso: AX=FF02h,AX=FF03h
--------I-7AFF02-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL API TERMINATION
	AX = FF02h
Return: CX = 1200h
SeeAlso: AX=FF01h
--------I-7AFF03-----------------------------
INT 7A - IBM PC3270 EMUL PROG v3 - INTERNAL API INITIALIZATION
	AX = FF03h
	ES:DI -> send/receive function handler routine
Return: CX = 1200h
SeeAlso: AX=FF01h
--------I-7AFF04-----------------------------
INT 7A U - IBM PC3270 EMUL PROG v3 - INTERNAL ???
	AX = FF04h
	ES:DI -> ???
Return: CX = 1200h
--------f-7B---------------------------------
INT 7B - Btrieve API (single user)
	DS:DX -> 38-byte parameter record (see below)
Return: return code field set
Note:	Btrieve sets low byte of vector to 33h; this serves as the installation
	  check
SeeAlso: INT 2F/AX=AB01h,INT 7F/AX=0200h

Format of Btrieve parameter record:
Offset	Size	Description
 00h	DWORD	pointer to data buffer
 04h	WORD	data buffer length
 06h	DWORD	pointer to 90-byte record containing positioning info
		(should be same for all calls for same file)
 0Ah	DWORD	pointer to 38-byte FCB info buffer
		(should be same for all calls for same file)
 0Eh	WORD	function code (see below)
 10h	DWORD	pointer to file name/key buffer
 14h	BYTE	key length
 15h	BYTE	key number
 16h	DWORD	pointer to status code (see below)
 1Ah	WORD	interface code (version specific)
		6176h version 5.10

Values for function code:
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
 18h step_next
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
 23h step previous
 24h get next extended: get multiple records using a filter
 25h get previous extended: get multiple records using a filter
 26h step next extended: get multiple records using a filter
 27h step previous extended: get multiple records using a filter
 28h insert extended: insert one or more records
 31h ???
 add 50 (32h) to any "get" operation to just return the key data
 add 100 (64h) for a single-record wait lock (automatically released on next
		get)
 add 200 (C8h) for a single-record nowait lock (nowait lock returns error 54h
		or 55h if record already locked)
 add 300 (12Ch) for a multiple-record wait lock (not released until unlock
		called)
 add 400 (190h) for a multiple-record nowait lock (nowait lock returns error
		54h or 55h if record already locked)

Values for status code:
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
 3Ch reject count reached
 3Dh work space too small
 3Eh incorrect descriptor
 3Fh invalid extended insert
 40h filter limit reached
 41h incorrect field offset
 4Ah automatic transaction abort
 4Eh deadlock detected
 50h conflict
 51h lock error
 52h lost position
 53h read outside transaction
 54h record in use
 55h file in use
 56h file table full
 57h handle table full
 58h incompatible open mode
 5Ah redirected device table full
 5Bh server error
 5Ch transaction table full
 5Dh incompatible lock type
 5Eh permission error
 5Fh session no longer valid
 60h communications environment error
 61h data message too small
 62h internal transaction error
--------I-7B---------------------------------
INT 7B - Eicon Access API (3270/5250 gateways)
SeeAlso: INT 5C"NetBIOS"
--------A-7B---------------------------------
INT 7B CU - AutoCAD ADI INTERFACE
	AX = function
	    0000h output blank line
	    other ???
Return: ???
Note:	called by AutoCAD to perform its output
SeeAlso: INT 78"AutoCAD",INT 7A"AutoCAD"
--------E-7B---------------------------------
INT 7B - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ3
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 0B,INT 10/AH=FFh"GO32",INT 7A"GO32",INT 7C"GO32"
--------r-7C---------------------------------
INT 7C U - IBM REXX88PC command language
	???
--------E-7C---------------------------------
INT 7C - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ4
Program: GO32.EXE is a DOS extender included as part of the 80386 port of the
	  GNU C/C++ compiler by DJ Delorie and distributed as DJGPP
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 0C,INT 7B"GO32",INT 7D"GO32"
--------t-7D---------------------------------
INT 7D - [obsoleted proposal] - ALTERNATE MULTIPLEX INTERRUPT
Note:	this interface proposal has been moved to INT 2D; there are no known
	  implementations on INT 7D
SeeAlso: INT 2D, INT 2F
--------S-7D---------------------------------
INT 7D U - YTERM 1.4 - CLOCK SUPPORT
SeeAlso: INT 7E"YTERM"
--------E-7D---------------------------------
INT 7D - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ5
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 0D,INT 7C"GO32",INT 7E"GO32"
--------U-7D---------------------------------
INT 7D - HyperPAD v2.2 - API ACCESS
Note:	this vector is hooked but immediately passed on (without checking
	  whether the previous handler was 0000h:0000h).  The sole purpose of
	  this vector is to provide the address of the data area described
	  below.

Format of HyperPAD data area:
Offset	Size	Description
 -16h	DWORD	pointer to ??? FAR function
 -12h	DWORD	pointer to callback setting function
		[C calling conventions, (*callback)(int (_loadds far *)()) ]
 -0Eh 6 BYTEs	signature "BRC001"
 -08h	DWORD	pointer to previous INT 7D handler
 -04h	DWORD	pointer to ??? data
 00h		HyperPAD INT 7D handler
----------7D00-------------------------------
INT 7D - SCSILink - RESET SCSI BUS
	AH = 00h
Program: SCSILink is a TSR by Cross Products Ltd which allows its PC-hosted
	  cross assemblers and similar products to communicate with Cross
	  Products hardware debuggers
Desc:	reset all devices on the SCSI bus
Note:	the installation check is the signature "SCSILINK" immediately prior
	  to the interrupt handler
Index:	installation check;SCSILink
----------7D01-------------------------------
INT 7D - SCSILink - CONNECT TO TARGET
	AH = 01h
	AL = target ID
Return:	CF clear if successful
	CF set on error
	    AL = initiator error
	    AH = target error
Desc:	arbitrate the use of the bus and select the specified target device
----------7D02-------------------------------
INT 7D - SCSILink - SEND COMMAND
	AH = 02h
	ES:BX -> parameter block (see below)
Return: CF clear if successful
	CF set on error
	    AL = initiator error
	    AH = target error
Desc:	send the specified command block to the target device and perform any
	  related I/O

Format of parameter block:
Offset	Size	Description
 00h	DWORD	size of command block
 04h	DWORD	address of command block (see below)
 08h	DWORD	size of buffer
 0Ch	DWORD	address of buffer

Format of command block:
Offset	Size	Description
 00h		info not yet available
----------7D03-------------------------------
INT 7D - SCSILink - SET TIMEOUT
	AH = 03h
	AL = timeout selector (see below)
	BX = new value in 55ms ticks
Desc:	change an internal timeout value to allow communication with very
	  slow targets

Values for timeout selector:
 00h	time to wait for bus (default 18)
 01h	time to wait for new phase (default 5)
 02h	maximum time to send/receive block (default 18)
 03h	time to wait for reselect (default 180)
----------7D04-------------------------------
INT 7D - SCSILink - GET ERROR STRING
	AH = 04h
	AL = error number
Return: ES:BX -> ASCIZ error string for error number
----------7D05-------------------------------
INT 7D - SCSILink - GET ADDRESS
	AH = 05h
Return: AL = DMA channel
	AH = initiator ID
	BX = card address
Desc:	determine the current hardware configuration
----------7D06-------------------------------
INT 7D - SCSILink - PUT DATA
	AH = 06h
	CX = number of bytes to store (0001h-0100h)
	ES:BX -> data to be saved
Return: CF clear if successful
	CF set on error
	    AL = error code (01h = too much data)
Note:	the specified data is stored in SCSILink's PSP
SeeAlso: AH=07h
----------7D07-------------------------------
INT 7D - SCSILink - GET DATA
	AH = 07h
	CX = number of bytes to retrieve (0001h-0100h)
	ES:BX -> buffer for data
Return: CF clear if successful
	CF set on error
	    AL = error code (01h = too much data)
Note:	retrieve data previously stored with AH=06h
SeeAlso: AH=06h
----------7D08-------------------------------
INT 7D - SCSILink - TERMINATE SESSION
	AH = 08h
Desc:	indicate to any other programs that intercept INT 7D that the program
	  has finished with the link
Note:	the program should call this function even if a SCSI error caused its
	  termination
----------7D09-------------------------------
INT 7D - SCSILink - POLL REQUEST
	AH = 09h
	AL = target ID
Return: AL = status
	    FEh resident driver experienced SCSI error
	    FFh resident driver handleded event
Desc:	give any drivers chained onto INT 7D a chance to handle an exception
	  not specifically handled by the calling program
Notes:	this service exists so that resident disk servers, etc. can continue
	  running even while debuggers and profilers are active
	the resident driver assumes that a connection has been established and
	  attempts to leave the target connected
--------*-7E---------------------------------
INT 7E - RESERVED FOR DIP, Ltd. ROM LIBRARY
--------S-7E---------------------------------
INT 7E U - YTERM 1.4 - ???
SeeAlso: INT 7D"YTERM",INT 7F"YTERM"
--------E-7E---------------------------------
INT 7E - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ6
Program: GO32.EXE is a DOS extender included as part of the 80386 port of the
	  GNU C/C++ compiler by DJ Delorie and distributed as DJGPP
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the extender
SeeAlso: INT 0E,INT 7D"GO32",INT 7F"GO32"
--------V-7F---------------------------------
INT 7F - IBM XGA - ???
--------V-7F---------------------------------
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
Program: Halo88 is a suite of graphics routines
Note:	according to Stuart Kemp, the code appears to make no provisions for
	   chaining
--------N-7F---------------------------------
INT 7F - CONVERGENT TECHNOLOGIES ClusterShare CTOS ACCESS VECTOR
	AL = request ID
	    01h "Request"/"RequestDirect"
		ES:BX -> pRq
		DX ignored
	    04h "Wait"
		ES:BX -> ppMsgRet
		DX = exchange
	    05h "AllocExch"
		ES:BX -> pExchRet
	    06h "DeAllocExch"
		DX = exchange
	    07h "Check"
		ES:BX -> ppMsgRet
		DX = exchange
	CX = 4354h ('CT')
Return: AX = status
	    0000h successful
--------S-7F---------------------------------
INT 7F - Telebit ACS SERIAL I/O
	ES:SI-> parameter block
Return: CF set on error
	CF clear on success
Notes:	the signature "PDGATEWRKSTNIF" appears just prior to the interrupt
	  handler; this serves as the installation check
Index:	installation check;Telebit ACS Serial I/O

Format of Telebit ACS parameter block:
Offset	Size	Description
 00h	BYTE	command
		    3Ch status
		    3Dh connect
		    3Eh disconnect
		    3Fh read
		    40h data/command write
		    41h clear receive buffer
		    42h get configuration
		    43h get receiver status
		    44h raw write
		    45h search servers
		    46h set transmit buffer size
 01h	BYTE	gateway number
 02h	BYTE	reserved
 03h	BYTE	port
 04h 17 BYTES	auxiliary buffer
 15h	BYTE	session
 16h	WORD	count of bytes passed to API
 18h	DWORD	buffer pointer passed to/from API
 1Ch	WORD	count of bytes passed from API
 1Eh	BYTE	return code (see below)

Values for return code:
 00h - success
 01h - invalid session
 05h - servername invalid
 06h - netware fileserver bindery is locked
 07h communication server not active
 08h general failure in netware fileserver
 09h not logged into a fileserver
 10h connection table full
 11h no response from communication server
 12h connection attempt terminated abnormally
 13h connection refused - no sessions available
 14h gw_no/port already in use
 15h invalid connection response
 16h port invalid
 17h incorrect version in server response
 18h gw_no/port combination not configured
 19h initialization has not been completed
 20h no more sockets are available
 21h no active poolname
 23h FATAL internal interface error
 24h registration of host workstation failed - name is already in used
 25h registration of host workstation failed - workstation name table full
 26h registration of host workstation failed - only one session may be
	registered for dial-in
 FFh telebit acs api is busy - retry later
--------N-7F---------------------------------
INT 7F - Non-dedicated NetWare 2.x File Server - ENTER CONSOLE MODE
Notes:	the installation check consists of checking for the signature "Lynn"
	  in the four bytes preceding the interrupt handler; if present, the
	  current program is running as a DOS task on a non-dedicated NetWare
	  2.x file server.
	Before placing the server into "console" mode, it is recommended that
	  NetWare broadcast messages be disabled with INT 21/AX=DE00h.
SeeAlso: INT 21/AX=DE00h
Index:	installation check;non-dedicated NetWare server
--------S-7F---------------------------------
INT 7F U - YTERM - ???
SeeAlso: INT 7E"YTERM"
--------E-7F---------------------------------
INT 7F - DJGPP GO32.EXE DOS EXTENDER - RELOCATED IRQ7
Note:	this vector is overwritten when GO32 starts but is not restored by
	  early versions of the DOS extender
SeeAlso: INT 0F,INT 7E"GO32"
----------7F---------------------------------
INT 7F - Canon IXHND2 Scanner Interface
--------N-7F---------------------------------
INT 7F - Alloy 386/MultiWare (MW386), Novell-Type Network Executive (NTNX)
Notes:	the words at C800h:0000h and C800h:0002h will both be 584Eh if the
	  MW386 multitasking system is present (i.e. signature "NXNX")
	NTNX allows its API to be placed on a different interrupt than 7Fh at
	  load time.  To determine the actual vector used, open the device
	  "SPOOLER" with INT 21/AX=3D02h, place it in RAW mode with
	  INT 21/AX=4400h and INT 21/AX=4401h, then read one byte which will
	  be the actual interrupt number being used; the other interrupts may
	  be found with INT 7F/AH=09h/CL=03h
--------N-7F---------------------------------
INT 7F - Alloy NetWare Support Kit (ANSK) v2.2+ - INSTALLATION CHECK
Note:	a program may determine that it is running on an ANSK Slave by checking
	  the five bytes at F000h:0000h for the ASCIZ signature "ANSK"; this
	  address is RAM, and should not be written.  However, the above check
	  will not work on Slaves with <1MB RAM or those using the SLIM.SYS
	  device driver
--------N-7F00-------------------------------
INT 7F - Alloy NTNX, MW386 - SEMAPHORE LOCK AND WAIT
	AH = 00h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status
	    00h successful
	    01h invalid function
	    02h semaphore already locked
	    03h unable to lock semaphore
	    04h semaphore space exhausted
	    05h host/target PC did not respond (NTNX)
	AH = semaphore owner if status=02h
SeeAlso: AH=01h,AH=02h,AH=41h,INT 67/AH=00h
--------N-7F01-------------------------------
INT 7F - Alloy NTNX, MW386 - SEMAPHORE LOCK
	AH = 01h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status (see AH=00h)
	AH = semaphore owner if status=02h
SeeAlso: AH=00h,AH=02h,AH=41h
--------I-7F0104BX0000-----------------------
INT 7F - HLLAPI (IBM 3270 High-Level Language API)/LLAPI (Rabbit Low Level API)
	AX = 0104h (HLLAPI gate ID)
	BX = 0000h
	DS:SI -> parameter control block (see below)
Return: parameter control block updated
SeeAlso: AX=0105h,AX=ABCDh

Format of parameter control block:
Offset	Size	Description
 00h  3 BYTEs	signature = 'PCB'
 03h	BYTE	function number (see below)
 04h	WORD	segment of control string
 06h	WORD	offset of control string
 08h	WORD	length of control string, unless explicit end-of-str char set
 0Ah	BYTE	unused (IBM)
		ControlString[0] (Rabbit)
 0Bh	WORD	return code
 0Dh	WORD	maximum length of control string (IBM)
		unused (Rabbit)

Values for HLLAPI function number:
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
	(not implemented by Rabbit)
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
 5Ch	run a program (not implemented by Rabbit)
 5Dh	execute DOS command (not implemented by Rabbit)
 63h	change presentation space position to PC display row/col or vice versa
 FFh	Get info on DCA implementation

Values for LLAPI function number:
 80h	initialize LLAPI (internal call)
 83h	set Session ID (one-character ID)
 84h	read Session ID (one-character ID)
 85h	lock 327x keyboard
 86h	unlock 327x keyboard
 87h	wait for Clear to Send
 88h	type ASCII character
 89h	type 327x key
 8Ah	read keyboard lock state
 8Fh	force screen update
 90h	view session
 91h	relinquish (suspend foreground until background becomes idle)
 92h	poke screen character
 93h	poke translated character
 94h	peek screen character
 95h	peek translated character
 96h	set cursor position
 97h	send scan code (Rabbit only)
 98h	synchronize (returns after keystroke queue empty)
 99h	type PC key (Rabbit only)

Session Parameters for function 09h:
 ASCII		??? (Rabbit only)
 ATTRIB		return attributes in hex
 NOATTRIB	return attributes as blanks
 CONPHYS	make physical connection
 CONLOG		only make logical connection
 EAB		copy extended attribute bytes along with data 
 NOEAB		copy data only
 ESC=n		set escape character to "n" (default '@')
 EOT=n		set end of string character (default 00h)
 FPAUSE		full-duration pause
 FTNOWAIT	return immediately from functions 5Ah and 5Bh (Rabbit only)
 FTWAIT		wait for file transfer to complete (Rabbit only)
 IPAUSE		interruptible pause
 RABESC		??? (Rabbit only)
 NORABESC	??? (Rabbit only)
 SCANCODE	??? (Rabbit only)
 STRLEN		use explicit string lengths
 STREOT		use terminated strings
 SRCHALL	search entire presentation space
 SRCHFROM	search from specified offset
 SRCHFRWD	search forward from position 1
 SRCHBKWD	search backward from last position in presentation space
 TIMEOUT=n	??? (Rabbit only)
 TWAIT		wait specified time for keyboard ready
 LWAIT		wait until keyboard ready
 NWAIT		no wait
 TRON		enable tracing
 TROFF		disable tracing
 AUTORESET	send reset before sending keys with function 03h
 NORESET	don't send reset
 QUIET		don't display messages sent with INT 21/AH=09h
 NOQUIET	allow messages to be displayed
 TIMEOUT=n	set timeout in 30-second intervals, 0 = wait until ^Break
 XLATE		translate extended attribute bytes
 NOXLATE	don't translate
 NEWRET		use HLLAPI v3.0 return code conventions
 OLDRET		use HLLAPI v2.0 return code conventions
--------V-7F0105-----------------------------
INT 7F - HDILOAD.EXE - 8514/A VIDEO CONTROLLER INTERFACE
	AX = 0105h
Return: CF set on error
	CF clear if successful
	    CX:DX -> array of FAR pointers to entry points
Note:	most functions are invoked by pushing the DWORD parameter block pointer
	  and then performing a FAR call via the appropriate vector of the
	  entry point array
SeeAlso: AX=0104h,AX=ABCDh

Function numbers: (do FAR call via entry_points+4*function)
 08h	HOPEN
 10h	HINT
 13h	HLDPAL
 15h	HBBW
 17h	HBBR
 18h	HBBCHN
 1Dh	HQMODE
 22h	HCLOSE
 30h	HINIT
 31h	HSYNC
 39h	HSPAL
 3Ah	HRPAL 
--------N-7F02-------------------------------
INT 7F - Alloy NTNX, MW386 - RELEASE SEMAPHORE
	AH = 02h
	DS:DX -> ASCIZ semaphore name (max 64 bytes)
Return: AL = status
	    00h successful
	    01h invalid function
	    02h semaphore locked by other user
		AH = semaphore owner
	    03h unable to unlock semaphore
	    05h target PC did not respond
SeeAlso: AH=00h,AH=01h,AH=42h
--------f-7F0200-----------------------------
INT 7F - Btrieve Multi-User - GIVE UP TIME???
	AX = 0200h
SeeAlso: INT 2F/AX=AB01h,INT 2F/AX=AB02h,INT 7B"Btrieve"
--------N-7F03-------------------------------
INT 7F - Alloy ANSK, NTNX, MW386 - GET USER NUMBER
	AH = 03h
Return: AL = user number
	AH = machine number (MW386)
Note:	this function call is the recommended method for a CPU-bound process to
	  prevent its priority from being lowered
SeeAlso: AH=04h,AH=05h,AH=A1h
--------N-7F04-------------------------------
INT 7F - Alloy NTNX, MW386 - GET NUMBER OF USERS
	AH = 04h
Return: AL = total number of users on currrent machine (MW386)
	AL = number of slaves on system (NTNX)
SeeAlso: AH=03h
--------N-7F05-------------------------------
INT 7F - Alloy NTNX (Host) - LOCK/UNLOCK SYSTEM, SPOOLER CONTROL
	AH = 05h
	AL = function
	    00h lock system (disable slave services)
	    01h unlock system
	    02h enable spooler
	    03h disable spooler
	    04h enable slave timer update
	    05h disable slave timer update
	    06h enable form feeds
	    07h disable form feeds
SeeAlso: INT 17/AH=A4h
--------N-7F05-------------------------------
INT 7F - Alloy NTNX (Slave), MW386 - GET USER PARAMETERS
	AH = 05h
	DX:DI -> buffer for user information record (see below)
Notes:	MW386 provides this function for backward compatibility only, and sets
	  many of the fields to zero because they are meaningless under MW386
	this function has no effect when called by the host (user 0)
SeeAlso: AH=03h

Format of user information record:
Offset	Size	Description
 00h	WORD	segment of video RAM
 02h	WORD	segment of secondary copy of video RAM
 04h	WORD	offset of screen update flag (see INT 10/AH=8Bh)
		flag nonzero if update needed
 06h	WORD	video NMI enable port
		(not used by MW386, set to 0000h)
 08h	WORD	video NMI disable port
		(not used by MW386, set to 0000h)
 0Ah	BYTE	processor type
		00h 8088
		01h V20
		02h 8086
		03h V30
		06h 80386
 0Bh	WORD	multitasking flag (00h = single tasking, 01h = multitasking)
		(not used by MW386, set to 0000h)
 0Dh	WORD	offset of terminal driver
		(not used by MW386, set to 0000h)
 0Fh	BYTE	port for console I/O
		(not used by MW386, set to 0000h)
 10h	WORD	offset of processor communication busy flag
		bit 7 set when slave communicating with host
 12h	WORD	pointer to FAR NX system call
		(not used by MW386, set to 0000h)
 14h	WORD	offset of 16-byte user configuration record (see AH=38h)
 16h	WORD	offset of command/status word
 18h	WORD	offset of screen valid flag (see INT 10/AH=93h)
		nonzero if screen must be repainted
 1Ah	WORD	offset of screen repaint flag
 1Ch	WORD	pointer to NEAR NX system call
		(not used by MW386, set to 0000h)
 1Eh	WORD	offset for intercept flags
		(not used by MW386, set to 0000h)
		intercept flag = FFh if MS-DOS intercepts should be disabled
 20h	WORD	offset of terminal lock flag (see INT 10/AH=92h)
		lock flag = FFh if backgrnd screen updates should be suspended
 22h 26 BYTEs	reserved
--------N-7F06-------------------------------
INT 7F - Alloy NTNX (Host) - GET SHARED DRIVE INFO
	AH = 06h
	AL = drive number (1=A:, 2=B:, etc)
	ES:DI -> drive info record (see below)
Return: AX = status
	    0000h successful
		ES:DI buffer filled
	    0001h not shared drive

Format of drive info record:
Offset	Size	Description
 00h	WORD	segment of drive IO-REQUEST structure (MS-DOS DPB)
 02h	WORD	segment of allocation map (owner table)
		one byte per FAT entry, containing user ID owning that entry
 04h	WORD	segment of master FAT for drive (copy of FAT on disk)
 06h	WORD	pointer to configuration file
 08h	WORD	total number of clusters
 0Ah	WORD	bytes per sector
 0Ch	WORD	sectors per cluster
 0Eh	BYTE	FAT type (0Ch = 12-bit, 10h = 16-bit)
--------N-7F06-------------------------------
INT 7F - Alloy NTNX (Slave) - ALLOCATE FREE CLUSTER ON SHARED DRIVE
	AH = 06h
	DL = drive number (1=A:,2=B:,etc)
	CX = number of clusters to allocate
Return: AH = status
	    00h successful
		CX = number of clusters still free
	    10h invalid shared drive request
		CL = first and second shared drives
	    11h invalid cluster count (must be 01h-FFh)
--------N-7F07-------------------------------
INT 7F - Alloy NTNX, MW386 - GET LIST OF SHARED DRIVES
	AH = 07h
Return: ES:DI -> shared drive list (see below)
Note:	MW386 considers all fixed disks to be shared drives; only C and D will
	  be returned as shared

Format of shared drive list:
Offset	Size	Description
 00h	BYTE	string length
 01h	BYTE	number of shared drives
 02h  N BYTEs	one byte per shared drive
--------N-7F08-------------------------------
INT 7F - Alloy NTNX (Host) - GET INTERRUPT VECTORS
	AH = 08h
	CL = function
	    00h get original interrupt vector
	    01h get Network Executive interrrupt
	AL = interrupt number
	DX:SI -> DWORD to hold interrupt vector
Return: AL = status
	    00h successful
	    01h interrupt vector not used by network executive
	    02h invalid subfunction
Note:	the network executive uses interrupts 02h,08h,09h,0Fh,10h,13h,16h-19h,
	  1Ch,20h,28h,2Ah,2Fh,5Bh,67h,7Fh,ECh, and F0h-FFh
SeeAlso: AH=09h/CL=03h,INT 21/AH=35h
--------N-7F08--CL02-------------------------
INT 7F - Alloy NTNX - SET MESSAGE DISPLAY TIMEOUT
	AH = 08h
	CL = 02h
	DX = timeout in seconds
Return: AL = status
	    00h successful
	    02h invalid subfunction
--------T-7F09-------------------------------
INT 7F - MultiLink Advanced - SET TASK PRIORITY
	AH = 09h
	AL = priority (0-7)
Note:	the installation check consists of ensuring that the interrupt vector
	  is not pointing at segment 0000h, then checking whether the byte
	  at offset 0000h in the interrupt handler's segment is E9h
Index:	installation check;MultiLink Advanced
--------N-7F09-------------------------------
INT 7F - Alloy NTNX - ENABLE/DISABLE MUD FILE CHECKING
	AH = 09h
	CL = function
	    00h enable checking of RTNX.MUD file
	    01h disable RTNX.MUD checking
--------N-7F09--CL02-------------------------
INT 7F - Alloy NTNX - SWITCH HOST TO DEDICATED MODE
	AH = 09h
	CL = 02h
Note:	in dedicated mode, the host will only poll for I/O requests from the
	  slave processors, and not provide workstation services
--------N-7F09--CL03-------------------------
INT 7F - Alloy NTNX,MW386 - GET ALTERNATE INTERRUPT
	AH = 09h
	CL = 03h
	AL = default interrupt number (67h,7Fh,etc)
Return:	CL = actual interrupt which handles specified interrupt's calls
SeeAlso: AH=08h
--------N-7F0A--CL00-------------------------
INT 7F - Alloy NTNX - GET SYSTEM FLAGS
	AH = 0Ah
	CL = 00h
	ES:DI -> buffer for system flags (see below)
Return: ES:DI buffer filled
Notes:	on a slave, only the NX_Busy flag is returned
	all three flags are at fixed positions, so this function only needs to
	  be called once
	an interrupt handler should only perform DOS or device accesses when
	  all three flags are 00h

Format of system flags:
Offset	Size	Description
 00h	DWORD	pointer to NX_Busy flag (nonzero when communicating with users)
 04h	DWORD	pointer to device driver busy flag
 08h	DWORD	pointer to InTimer flag
--------N-7F0B--CL02-------------------------
INT 7F - Alloy NTNX (Host) - SET/RESET GRAPHICS DOS ON SLAVE
	AH = 0Bh
	CL = 02h
	AL = slave ID number
	CH = DOS to activate
	    00h graphics DOS
	    01h character DOS
Return: AL = status
	    00h successful
	    01h nothing done, proper DOS type already loaded
--------N-7F10--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - OPEN CHANNEL
	AH = 10h
	CL = 00h
	AL = channel number
	DX:DI -> channel buffer
Return: AL = status (00h-03h,0Dh) (see below)
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=01h,AH=10h/CL=04h,AH=14h/CL=02h

Values for status:
 00h successful
 01h busy
 02h channel range error (not 00h-3Fh)
 03h invalid subfunction
 0Ah channel not open
 0Ch channel already locked
 0Dh unable to open
--------N-7F10--CL01-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - CLOSE CHANNEL
	AH = 10h
	CL = 01h
	AL = channel number
Return: AL = status (00h-03h,0Ah) (see AH=10h/CL=00h)
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=00h,AH=10h/CL=05h
--------N-7F10--CL02-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - LOCK CHANNEL
	AH = 10h
	CL = 02h
	AL = channel number
Return: AL = status (00h-03h,0Ah,0Ch) (see AH=10h/CL=00h)
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=03h,AH=10h/CL=06h,AH=10h/CL=08h
--------N-7F10--CL03-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - UNLOCK CHANNEL
	AH = 10h
	CL = 03h
	AL = channel number
Return: AL = status (00h-03h,0Ah) (see AH=10h/CL=00h)
Notes:	should only be used on channels locked with AH=10h/CL=02h, not on those
	  locked by receipt of a datagram
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=02h,AH=10h/CL=04h,AH=10h/CL=09h
--------N-7F10--CL04-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - RELEASE BUFFER
	AH = 10h
	CL = 04h
	AL = channel number
Return: AL = status (00h-03h) (see AH=10h/CL=00h)
Notes:	unlocks buffer after received datagram has been processed
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=00h
--------N-7F10--CL05-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - CLOSE ALL CHANNELS
	AH = 10h
	CL = 05h
Return: AL = status (00h-03h) (see AH=10h/CL=00h)
Notes:	clears all pending datagrams and clears buffer pointers before closing
	  the channels
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=01h
--------N-7F10--CL06-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - LOCK ALL OPEN CHANNELS
	AH = 10h
	CL = 06h
Return: AL = status (00h-03h) (see AH=10h/CL=00h)
Note:	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=02h,AH=10h/CL=08h
--------N-7F10--CL07-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - UNLOCK ALL LOCKED IDLE CHANNELS
	AH = 10h
	CL = 07h
Return: AL = status (00h-03h) (see AH=10h/CL=00h)
Notes:	unlocks all locked channels which have no pending datagrams
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=03h,AH=10h/CL=09h
--------N-7F10--CL08-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - LOCK MULTIPLE CHANNELS
	AH = 10h
	CL = 08h
	DX = maximum channel number to lock
Return: AL = status (00h-03h) (see AH=10h/CL=00h)
Notes:	locks channels numbered 00h through the value in DX
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=02h,AH=10h/CL=06h,AH=10h/CL=09h
--------N-7F10--CL09-------------------------
INT 7F - Alloy NTNX, MW386 - CHANNEL CONTROL - UNLOCK MULTIPLE CHANNELS
	AH = 10h
	CL = 09h
	DX = maximum channel number to unlock
Return: AL = status (00h-03h) (see AH=10h/CL=00h)
Notes:	unlocks channels numbered 00h through the value in DX
	may not be invoked from within a hardware interrupt handler
SeeAlso: AH=10h/CL=03h,AH=10h/CL=07h,AH=10h/CL=08h
--------N-7F11-------------------------------
INT 7F - Alloy NTNX, MW386 - SEND DATAGRAM
	AH = 11h
	DX:SI -> request block (see below)
Return: AL = status (see below)
Note:	if wildcard channel FFh used, actual channel number will be filled in
SeeAlso: AH=12h

Values for status:
 00h successful
 01h busy
 02h channel range error (not 00h-3Fh)
 03h invalid subfunction
 0Ah packet too large (or <2 bytes if NTNX)
 0Bh can't send packet to itself
 0Ch invalid number of destinations
 0Dh destination channel number out of range
 0Eh destination user is busy
 0Fh destination user has locked channel
 10h channel not open
 11h no datagram server on destination (NTNX)

Format of request block:
Offset	Size	Description
 00h	DWORD	pointer to packet to send
 04h	WORD	packet size in bytes (1-4096)
 06h	BYTE	number of destinations for packet (max 1Fh)
 07h 31 BYTEs	destination user IDs (FFh = broadcast to all except sender)
 26h 31 BYTEs	destination channels (FFh = first available channel)
 45h 31 BYTEs	return destination statuses
--------N-7F12-------------------------------
INT 7F - Alloy NTNX, MW386 - ACKNOWLEDGE DATAGRAM
	AH = 12h
	AL = channel number being acknowledged
	DI:DX = 32-bit status to return to sender
Return: AL = status (see below)
Note:	also unlocks the channel, allowing the next datagram to be received
SeeAlso: AH=11h,AH=15h/CL=04h

Values for status:
 00h successful
 01h busy
 02h channel range error (not 00h-3Fh)
 03h invalid subfunction
 0Ah channel not open
 0Bh no message in channel
 0Ch destination slave busy--retry (NTNX)
 0Dh destination user not active
 0Eh destination slave not active (NTNX)
 0Fh destination disabled datagram service
--------N-7F13--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - RESET USER DATAGRAMS
	AH = 13h
	CL = 00h
Note:	clears all pending datagrams and removes all channels opened in NTNX
	  compatibility mode
--------N-7F14--CL00-------------------------
INT 7F - Alloy NTNX, MW386 -  SET RECEIVE ISR
	AH = 14h
	CL = 00h
	DX:DI -> application FAR receive service routine (see below)
Return: AL = status (00h-03h) (see AH=12h)
SeeAlso: AH=14h/CL=01h,AH=14h/CL=03h

Service routine called with:
	DH = sender ID
	DL = channel with datagram
	interrupts disabled
Return: AL = response code
	    00h leave buffer locked, set channel status, and repeat call later
	    01h release channel buffer
	    02h change buffer pointer to DX:DI
	AH,CX,DX,DI,SI may be destroyed
--------N-7F14--CL01-------------------------
INT 7F - Alloy NTNX, MW386 - SET ACKNOWLEDGE ISR
	AH = 14h
	CL = 01h
	DX:DI -> application FAR acknowledge service routine (see below)
Return: AL = status (00h-03h) (see AH=12h)
Note:	the service routine will be called as soon as an acknowledgment arrives
SeeAlso: AH=12h,AH=14h/CL=00h,AH=14h/CL=04h,AH=15/CL=04h

Service routine called with:
	DS:SI -> acknowledge structure (see AH=15h/CL=04h)
Return: AL = response code
	    00h application busy, network executive should call again later
	    01h acknowledge accepted
	AH,DX,SI may be destroyed
--------N-7F14--CL02-------------------------
INT 7F - Alloy NTNX, MW386 - SET CHANNEL BUFFER POINTER
	AH = 14h
	CL = 02h
	AL = channel number
	DX:DI -> receive buffer
Return: AL = status (00h-03h) (see AH=12h)
Note:	may be called from within a receive ISR or when a datagram is pending
SeeAlso: AH=10h/CL=00h,AH=14h/CL=00h
--------N-7F14--CL03-------------------------
INT 7F - Alloy NTNX, MW386 - GET RECEIVE ISR
	AH = 14h
	CL = 03h
Return: DX:DI -> current receive ISR
SeeAlso: AH=14h/CL=00h,AH=14h/CL=04h
--------N-7F14--CL04-------------------------
INT 7F - Alloy NTNX, MW386 - GET ACKNOWLEDGE ISR
	AH = 14h
	CL = 04h
Return: DX:DI -> current acknowledge ISR
SeeAlso: AH=14h/CL=01h,AH=14h/CL=03h
--------N-7F14--CL05-------------------------
INT 7F - Alloy NTNX (Host), MW386 - GET BUSY POINTER
	AH = 14h
	CL = 05h
	DX:DI -> buffer for busy structure (see below)
Return: DX:DI buffer filled

Format of busy structure:
Offset	Size	Description
 00h	DWORD	pointer to busy flag byte
 04h	WORD	fixed port address (FF00h)
--------N-7F15--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - GET CHANNEL STATUS
	AH = 15h
	CL = 00h
	AL = channel number
	DX:DI -> status structure (see below)
Return: AL = status (00h-03h) (see AH=12h)
SeeAlso: AH=15h/CL=01h

Format of status structure:
Offset	Size	Description
 00h	BYTE	channel status
		bit 0: channel open
		bit 1: channel buffer contains received data
		bit 7: channel locked
 01h	BYTE	sender ID
--------N-7F15--CL01-------------------------
INT 7F - Alloy NTNX, MW386 - GET NEXT FULL CHANNEL
	AH = 15h
	CL = 01h
	DX:DI -> full-channel structure
Return: AL = status
	    00h successful
	    01h busy
	    0Ah no datagrams available
Note:	MW386 v1.0 returns the lowest channel with a datagram; newer versions
	  and NTNX return the oldest datagram
SeeAlso: AH=15h/CL=00h

Format of full-channel structure:
Offset	Size	Description
 00h	BYTE	number of channel with oldest datagram
 01h	BYTE	sender ID
--------N-7F15--CL02-------------------------
INT 7F - Alloy NTNX, MW386 - GET MAXIMUM NUMBER OF CHANNELS
	AH = 15h
	CL = 02h
Return: AH = number of channels available (40h for MW386)
Note:	the application may always assume at least 32 channels available
SeeAlso: AH=15h/CL=03h
--------N-7F15--CL03-------------------------
INT 7F - Alloy NTNX, MW386 - GET MAXIMUM PACKET SIZE
	AH = 15h
	CL = 03h
	DX:DI -> WORD for return value
Return: buffer WORD filled with maximum packet size (4096 for MW386)
SeeAlso: AH=15h/CL=02h
--------N-7F15--CL04-------------------------
INT 7F - Alloy NTNX, MW386 - GET AND CLEAR ACKNOWLEDGE STATUS
	AH = 15h
	CL = 04h
	DX:DI -> status structure (see below)
Return: AL = status
	    00h successful
		DX:DI structure filled
	    01h busy
	    0Ah no acknowledgement has arrived
SeeAlso: AH=12h,AH=14h/CL=01h

Format of status structure:
Offset	Size	Description
 00h	BYTE	sender ID
 01h	BYTE	channel number
 02h  4 BYTEs	receiver status (see AH=12h)
--------N-7F16-------------------------------
INT 7F - Alloy NTNX, MW386 - DIRECT MEMORY TRANSFER
	AH = 16h
	DX:SI -> transfer structure (see below)
Return: AL = status
	    00h successful
	    0Ah source or destination out of range
	    0Bh transfer kernal busy--try again
Notes:	this call transfers memory contents directly between users; both source
	  and destination user IDs may differ from the caller's ID
	no segment wrap is allowed

Format of transfer structure:
Offset	Size	Description
 00h	WORD	bytes to transfer
 02h	BYTE	source ID
		FEh = caller
 03h	DWORD	source address
 07h	BYTE	destination ID
		FFh = all slaves except caller
		FEh = caller
 08h	DWORD	destination address
--------N-7F21-------------------------------
INT 7F - Alloy NTNX, MW386 - SEND MESSAGE OR COMMAND TO USER(S)
	AH = 21h
	AL = sender's user ID
	DS:DX -> control packet (see below)
Note:	messages or commands are ignored if disabled by the destination user
SeeAlso: AH=22h

Format of control packet:
Offset	Size	Description
 00h	BYTE	packet type
		00h message
		01h NTNX command
		02h MW386 command
 01h	BYTE	destination user ID or 'A' for all users
 02h 62 BYTEs	ASCIZ message (packet type 00h)
		BIOS keycodes terminated by NUL byte (type 01h) or word (02h)
Note:	a maximum of 16 keycodes will be processed for NTNX and MW386 commands
--------N-7F22-------------------------------
INT 7F - Alloy NTNX - GET MESSAGE
	AH = 22h
Return: pending messages displayed on user's screen
SeeAlso: AH=21h
--------N-7F24-------------------------------
INT 7F - Alloy NTNX, MW386 - ATTACH OR RELEASE DRIVE FOR LOW-LEVEL WRITE ACCESS
	AH = 24h
	CL = function
	    00h attach
	    01h release
	CH = drive (0=A:,1=B:,etc)
Return: AX = status
	    00h successful
	    01h invalid request
	    02h already attached
	    03h not attached
	    04h lock table full
Note:	only drives on the current machine may be attached
--------N-7F24-------------------------------
INT 7F - Alloy NTNX - ATTACH/RELEASE HOST PROCESSOR
	AH = 24h
	CL = function
	    02h attach host
	    03h release host
Return: AX = status
	    00h successful
	    01h invalid request
	    02h already attached
	    03h not attached
	    04h lock table full
Note:	the host processor may be attached in order to perform I/O via the host
--------N-7F25--CL00-------------------------
INT 7F - Alloy ANSK, NTNX, MW386 - GET NETWORK EXECUTIVE VERSION
	AH = 25h
	CL = 00h	    
Return: AH = version suffix letter
	CH = major version number
	CL = minor version number
SeeAlso: AH=25h/CL=01h
--------N-7F25--CL01-------------------------
INT 7F - Alloy ANSK, NTNX, MW386 - GET NETWORK EXECUTIVE TYPE
	AH = 25h
	CL = 01h
Return: CL = type
	    00h RTNX
	    01h ATNX
	    02h NTNX
	    03h BTNX
	    04h MW386
	    05h ANSK
SeeAlso: AH=25h/CL=00h
--------N-7F26--CL00-------------------------
INT 7F - Alloy NTNX, MW386 - GET NTNX FILE MODE
	AH = 26h
	CL = 00h
Return: AX = file mode bits (see below)
Note:	MW386 does not support file modes, and always returns AX=001Fh
SeeAlso: AH=26h,AH=26h/CL=06h

Bitfields for file mode bits:
 bit 0	directory protection enabled
 bit 1	extended open enabled
 bit 2	flush on every disk write
 bit 3	flush on every disk write in locked interval
 bit 4	flush on reads from simultaneously opened file
--------N-7F26-------------------------------
INT 7F - Alloy NTNX - SET FILE I/O CHECKING LEVEL
	AH = 26h
	CL = check type to set/reset
	    01h directory protection
	    02h extended open
	    03h flush on every disk write
	    04h flush on disk write if any lock set during write
	    05h flush on all reads if file written
	AL = new state (00h off, 01h on)
SeeAlso: AH=26h/CL=00h,AH=26h/CL=06h
--------N-7F26--CL06-------------------------
INT 7F - Alloy NTNX - CANCEL FLUSH ON WRITE
	AH = 26h
	CL = 06h
Note:	cancels flags set by AH=26h/CL=03h and AH=26h/CL=04h
SeeAlso: AH=26h/CL=00h
--------N-7F30-------------------------------
INT 7F - Alloy MW386 - GET PORT INFORMATION
	AH = 30h
	CX = MW386 port number
Return: AL = FFh if port not found
	   else	 driver unit number
	       BL = port mode
	       BH = port type
		   02h remote
	       DH = owner's machine ID
	       DL = owner's user ID
SeeAlso: INT 17/AH=8Bh
--------N-7F31-------------------------------
INT 7F - Alloy MW386 v1.x only - CHECK PORT ASSIGNMENT
	AH = 31h
	???
Return: ???
--------N-7F37-------------------------------
INT 7F - Alloy NTNX (Host) - GET SEMAPHORE TABLE
	AH = 37h
Return: ES:AX -> semaphore table
--------N-7F37-------------------------------
INT 7F - Alloy ANSK, NTNX (Slave) - DUMP STRING TO TERMINAL
	AH = 37h
	DS:DX -> ASCIZ string to display
Note:	if the string is empty, a terminal update will be forced
--------N-7F38-------------------------------
INT 7F - Alloy NTNX (Slave), MW386 - SET NEW TERMINAL DRIVER
	AH = 38h
	AL = new terminal driver number
	    FFh dummy driver
	    FEh current driver
	    FDh load new driver
		DS:SI -> new driver
SeeAlso: AH=39h
--------N-7F39-------------------------------
INT 7F - Alloy MW386 - SET TERMINAL DRIVER FOR ANOTHER USER
	AH = 39h
	AL = new terminal driver number
	DL = user number (FFh = caller)
	DH = machine number if DL <> FFh
Return: CF set if invalid user number
	CF clear if successful
Notes:	only available to supervisors
	the new driver number will not take effect until the user is rebooted
SeeAlso: AH=38h
--------N-7F3A-------------------------------
INT 7F - Alloy MW386 - GET TERMINAL PARAMETERS
	AH = 3Ah
	DL = user number (FFh = caller)
	DH = machine number
Return: CF clear if successful
	    AH = terminal driver number
	    AL = baud rate (00h = 38400, 01h = 19200, etc)
	    CL = parity (00h none, 01h even, 02h odd)
	    CH = handshaking (00h none, 01h XON/XOFF, 02h DTR/DSR, 03h XPC)
	CF set if invalid user number
SeeAlso: AH=3Bh
--------N-7F3B-------------------------------
INT 7F - Alloy MW386 - SET TERMINAL PARAMETERS
	AH = 3Bh
	AL = baud rate (00h = 38400, 01h = 19200, etc)
	CL = parity (00h none, 01h even, 02h odd)
	CH = handshaking (00h none, 01h XON/XOFF, 02h DTR/DSR, 03h XPC)
	DL = user number (FFh = caller)
	DH = machine number for user
Return: CF set if invalid user number
Notes:	only available to supervisors
	the new parameters will take effect immediately if the user's terminal
	  has not been started, else AH=3Dh must be called to post the changes
SeeAlso: AH=3Ah,AH=3Dh
--------N-7F3C-------------------------------
INT 7F - Alloy MW386 - ENABLE/DISABLE AUTOBAUD DETECT
	AH = 3Ch
	AL = new state
	     00h disabled, 01h enabled
	DL = user number (FFh = caller)
	DH = machine number for user
Return: CF set if invalid user number
Note:	only available to supervisors
SeeAlso: AH=3Dh
--------N-7F3D-------------------------------
INT 7F - Alloy MW386 - POST TERMINAL CONFIGURATION CHANGES
	AH = 3Dh
Note:	should be called whenever a program changes the terminal type or its
	  parameters
SeeAlso: AH=3Bh
--------N-7F41-------------------------------
INT 7F - Alloy NTNX - LOCK FILE FOR USER
	AH = 41h
	AL = user ID
	DS:DX -> ASCIZ filename
Return: AL = status
	    00h successful
	    01h invalid function
	    02h already locked
	    03h unable to lock
	    04h lock table full
Note:	requests exclusive read/write access to file
SeeAlso: AH=00h,AH=41h"MW386",AH=42h"NTNX"
--------N-7F41-------------------------------
INT 7F - Alloy MW386 - LOCK SEMAPHORE FOR USER
	AH = 41h
	AL = user ID
	DS:DX -> ASCIZ semaphore name
Return: AL = status
	    00h successful
	    01h invalid function
	    02h semaphore already locked
	    03h unable to lock semaphore
	    04h semaphore space exhausted
SeeAlso: AH=00h,AH=42h"MW386"
--------N-7F42-------------------------------
INT 7F - Alloy NTNX - UNLOCK FILE FOR USER
	AH = 42h
	AL = user ID
	DS:DX -> ASCIZ filename
Return: AL = status
	    00h successful
	    01h invalid function
	    02h already locked
	    03h unable to lock
	    04h lock table full
SeeAlso: AH=00h,AH=41h"NTNX",AH=42h"MW386"
--------N-7F42-------------------------------
INT 7F - Alloy MW386 - UNLOCK SEMAPHORE FOR USER
	AH = 42h
	AL = user ID
	DS:DX -> ASCIZ semaphore name
Return: AL = status
	    00h successful
	    01h invalid function
	    03h unable to unlock semaphore
SeeAlso: AH=02h,AH=41h"MW386",AH=42h"NTNX"
--------N-7F4E-------------------------------
INT 7F - Alloy MW386 v2+ - SET ERROR MODE
	AH = 4Eh
	AL = error mode flags
	    bit 0: display critical disk errors
	    bit 1: display sharing errors
	DX = 4E58h ("NX")
Return: AL = status
	    00h successful
SeeAlso: AH=4Fh
--------N-7F4F-------------------------------
INT 7F - Alloy MW386 v2+ - SET FCB MODE
	AH = 4Fh
	AL = FCB mode
	    02h read/write compatibility
	    42h read/write shared
	DX = 4E58h ("NX")
Return: AL = status
	    00h successful
--------N-7F81-------------------------------
INT 7F - Alloy NTNX - ATTACH DEVICE FOR USER
	AH = 81h
	AL = user ID
	DS:DX -> ASCIZ device name
SeeAlso: AH=82h
--------N-7F82-------------------------------
INT 7F - Alloy NTNX - RELEASE DEVICE FOR USER
	AH = 82h
	AL = user ID
	DS:DX -> ASCIZ device name
SeeAlso: AH=81h
--------N-7FA0-------------------------------
INT 7F - Alloy MW386 - GET USER NAME
	AH = A0h
	DL = user number (FFh = caller)
	DH = machine number for user
	ES:DI -> 17-byte buffer for ASCIZ user name
Return: CF set if invalid user number
SeeAlso: AH=03h,AH=A1h
--------N-7FA1-------------------------------
INT 7F - Alloy MW386 - GET MACHINE, USER, AND PROCESS NUMBER
	AH = A1h
Return: AL = process number
	DL = user number
	DH = machine number
SeeAlso: AH=03h,AH=A0h,AH=A2h
--------N-7FA2-------------------------------
INT 7F - Alloy MW386 - GET USER PRIVILEGE LEVEL
	AH = A2h
	DL = user number (FFh = caller)
	DH = machine number for user
Return: CF clear if successful
	    AL = privilege level
		00h supervisor
		01h high
		02h medium
		03h low
	CF set if invalid user number
SeeAlso: AH=A1h,AH=A3h
--------N-7FA3-------------------------------
INT 7F - Alloy MW386 - GET USER LOGIN STATE
	AH = A3h
	DL = user number
	DH = machine number for user
Return: CF clear if successful
	    AL = login state
		00h never logged in
		01h currently logged out
		03h currently logged in
	CF set if invalid user number or user not active
SeeAlso: AH=A2h
--------N-7FA4-------------------------------
INT 7F - Alloy MW386 - VERIFY USER PASSWORD
	AH = A4h
	DS:DX -> ASCIZ password (null-padded to 16 bytes)
Return: AL = 00h if accepted
	   else	 invalid password
--------N-7FA500-----------------------------
INT 7F - Alloy MW386 - GET USER STATUS
	AX = A500h
	DI = machine number and user number
Return: CF clear if successful
	    BX = user flags
	    	bit 5: allow messages
	    CL = scan code for task manager hotkey
	    CH = scan code for spooler hotkey
	    DL = scan code for task swapper hotkey
	    DH = modifier key status
	CF set if invalid user number
SeeAlso: AX=A501h
--------N-7FA501-----------------------------
INT 7F - Alloy MW386 - SET USER STATUS
	AX = A501h
	BX = user flags (see above)
	CL = scan code for task manager hotkey
	CH = scan code for spooler hotkey
	DL = scan code for task swapper hotkey
	DH = modifier key status
	DI = machine number and user number
Return: CF set if invalid user number
Note:	must have supervisor privilege to set another user's status
SeeAlso: AX=A500h
--------V-7FABCDBX0000-----------------------
INT 7F - IBM 8516 Touch Screen Device Driver - GET API ENTRY
	AX = ABCDh
	BX = 0000h
Return: AX = total number of functions available
	ES:BX -> entry point array
SeeAlso: AX=0104h,AX=0105h

Function numbers:
 00h	check initialization and reset
 14h	set user-defined subroutine
Notes:	each driver function takes two stack parameters using Pascal calling
	  conventions: address of parameter block and address of results buffer
	all pointers are FAR pointers
	on return, AX contains the status of the call:
	    AX = 0000h successful
		 0001h invalid input
		 0002h interface error
		 0003h unable to perform function

Format of parameter block for function 00h:
Offset	Size	Description
 00h	WORD	0000h (function number)
Note:	this function should be called before any other device driver functions

Format of results buffer for function 00h:
Offset	Size	Description
 00h	WORD	touch screen status
		0000h unavailable
		0001h uncalibrated
		FFFFh available
 02h	WORD	aux mouse status (0000h not present, FFFFh present)
Notes:	the following driver parameters will have been reset to zero:
	  touchdown counter, liftoff counter, position at last touch, position
	  at last lift, int call mask, select on count, select off count,
	  pos select on count, pos select off count.
	the following driver parameters will have been reset as listed:
	  mouse emulation mode: left on
	  thresholds: 46 on screen, 96 push harder, 80 push release
	  x, y hysteresis: 400
	  data repeat rate: 40/sec
	  select mechanism: push-harder - first-touch
	  coordinate origin: upper left corner
	  filter frequency: medium
	  data block mask: all enabled
	  click lock: on
--------N-7FB0-------------------------------
INT 7F - Alloy NTNX, MW386 - RELEASE ALL SEMAPHORES FOR USER
	AH = B0h
	AL = user number
	DS = code segment
Note:	MW386 ignores AL and DS; it releases all semaphores locked using INT 67
	  or INT 7F locking functions
SeeAlso: AH=B1h,AH=B2h,AH=B3h,AH=B4h
--------N-7FB1--SF00-------------------------
INT 7F - Alloy NTNX, MW386 - RELEASE NORMAL SEMAPHORES FOR USER
	AH = B1h subfn 00h
	AL = (bits 7-5) 000
	     (bits 4-0) user ID
Note:	MW386 ignores AL; it releases all semaphores locked using INT 67 or
	  INT 7F locking functions
SeeAlso: AH=B0h,AH=B2h,AH=B3h,AH=B4h
--------N-7FB2--SF01-------------------------
INT 7F - Alloy NTNX - RELEASE MESSAGES FOR USER
	AH = B2h subfn 01h
	AL = (bits 7-5) 001
	     (bits 4-0) user ID
SeeAlso: AH=B0h,AH=B1h,AH=B3h,AH=B4h
--------N-7FB3--SF02-------------------------
INT 7F - Alloy NTNX - RELEASE FILES FOR USER
	AH = B3h subfn 02h
	AL = (bits 7-5) 010
	     (bits 4-0) user ID
SeeAlso: AH=B0h,AH=B1h,AH=B2h,AH=B4h
--------N-7FB4-------------------------------
INT 7F - Alloy NTNX - RELEASE DEVICES FOR USER
	AH = B4h
	AL = user ID
SeeAlso: AH=B0h,AH=B1h,AH=B2h,AH=B3h
--------N-7FC3-------------------------------
INT 7F - Alloy MW386 - WRITE BYTE TO TERMINAL AUX PORT
	AH = C3h
	AL = byte to write
Return: CF clear if successful
	CF set on error
SeeAlso: AH=C6h
--------N-7FC5-------------------------------
INT 7F - Alloy MW386 - CHANGE CONSOLE MODE
	AH = C5h
	AL = new console mode
	    00h keyboard indirect
	    01h keyboard direct
	    02h data handshake enforced
	    03h no data handshake
Return: CF clear if successful
	    AL = prior console mode
	CF set on error (caller is not remote user)
Note:	modes 2 and 3 may be used for input through the console port; no video
	  output should be performed in these modes
--------N-7FC6-------------------------------
INT 7F - Alloy MW386 - WRITE BYTE TO CONSOLE PORT
	AH = C6h
	AL = byte to write
Return: CF clear if successful
	CF set on error (caller is not remote user)
Note:	any terminal driver data translation will be bypassed
SeeAlso: AH=C3h,AH=C7h
--------N-7FC7-------------------------------
INT 7F - Alloy MW386 - READ CONSOLE DATA BYTE
	AH = C7h
Return: CF clear if successful
	    AL = byte read
	CF set on error (no data available or caller is not remote user)
Note:	used to read data after placing console in mode 2 or 3 (see AH=C5h)
SeeAlso: AH=C5h,AH=C6h,AH=C8h
--------N-7FC8-------------------------------
INT 7F - Alloy MW386 - READ CONSOLE DATA INTO BUFFER
	AH = C8h
	AL = maximum bytes to read
	ES:DI -> buffer for console data
Return: CF clear if successful
	    CX = number of bytes read
	CF set on error (caller is not remote user)
SeeAlso: AH=C7h
--------N-7FCF-------------------------------
INT 7F - Alloy NTNX - REBOOT USER PROCESSOR
	AH = CFh
	DS:DX -> ASCIZ string containing user number to be reset
SeeAlso: AH=D6h
--------N-7FD6-------------------------------
INT 7F - Alloy MW386 - RESET NETWORK EXECUTIVE
	AH = D6h
	DS:DX -> reset packet (see below)
Return: never if succesful
Note:	all users will be shut down immediately if successful
SeeAlso: AH=CFh

Format of reset packet:
Offset	Size	Description
 00h	DWORD	reset code (60606060h)
 04h 16 BYTEs	ASCIZ supervisor password padded with nulls
--------N-7FD7-------------------------------
INT 7F - Alloy MW386 - POST EVENT
	AH = D7h
	AL = user number (if local event)
	DX = event number
--------N-7FD8-------------------------------
INT 7F - Alloy MW386 - FLUSH DISK BUFFERS
	AH = D8h
Return: CF set on error
Note:	forces all disk buffers to be written out immediately
SeeAlso: INT 21/AH=0Dh,INT 21/AX=5D01h,INT 2F/AX=1120h
--------N-7FDB-------------------------------
INT 7F - Alloy MW386 v2+ - GET MW386 INVOCATION DRIVE
	AH = DBh
Return: AL = drive from which MW386 was started (2=C:,3=D:,etc)
--------N-7FE0-------------------------------
INT 7F - Alloy MW386 - CREATE DOS TASK
	AH = E0h
	AL = memory size (00h=128K, 01h=256K, 02h=384K, 03h=512K, 04h=640K)
	DS:DX -> ASCIZ task name (max 16 bytes)
Return: CF clear if successful
	    AL = task create ID
	CF set on error
Note:	only foreground DOS tasks can use this function
SeeAlso: AH=E1h,AH=E2h,AH=E3h,AH=E6h,AH=E7h
--------N-7FE1-------------------------------
INT 7F - Alloy MW386 - GET DOS TASK PID FROM CREATE ID
	AH = E1h
	AL = create ID (from AH=E0h)
Return: AL = DOS process number
	CL = memory size (00h=128K, 01h=256K, 02h=384K, 03h=512K, 04h=640K)
Note:	this function should not be called immediately after creating a new
	  DOS task, since the new task is being initialized by a concurrent
	  process
SeeAlso: AH=E0h,AH=E2h
--------N-7FE2-------------------------------
INT 7F - Alloy MW386 - SWITCH TO NEW DOS TASK
	AH = E2h
	AL = DOS process number (from AH=E1h)
Return: CF set on error (invalid process number or caller not foreground task)
Notes:	specified task becomes the foreground task and current task is placed
	  in the background
	may only be called by a foreground task
SeeAlso: AH=E0h,AH=E1h
--------N-7FE3-------------------------------
INT 7F - Alloy MW386 - CHANGE NAME OF DOS TASK
	AH = E3h
---v1.x---
	AL = user number
---v2+---
	BH = user number
	BL = task number
---
	DS:DX -> ASCIZ task name
Return: CF set on error (invalid process number)
SeeAlso: AH=E0h,AH=E4h,AH=E5h
--------N-7FE4-------------------------------
INT 7F - Alloy MW386 - GET TASK NAME FROM PROCESS NUMBER
	AH = E4h
---v1.x---
	AL = user number
---v2+---
	BH = user number
	BL = task number
---
	ES:DI -> buffer for task name
Return: CF clear if successful
	    CL = memory size (00h=128K, 01h=256K, 02h=384K, 03h=512K, 04h=640K)
	    DX = task flags
		bit 7: MS-DOS process
	    ES:DI buffer filled
	CF set on error (invalid process number)
SeeAlso: AH=E3h,AH=E5h
--------N-7FE5-------------------------------
INT 7F - Alloy MW386 - GET PROCESS NUMBER FROM TASK NAME
	AH = E5h
	DS:DX -> ASCIZ task name
	BH = user number
Return: CF clear if successful
	    AL = DOS process number
	    CL = memory size (00h=128K, 01h=256K, 02h=384K, 03h=512K, 04h=640K)
	CF set on error (no match for name)
SeeAlso: AH=E3h,AH=E4h
--------N-7FE6-------------------------------
INT 7F - Alloy MW386 - GET NUMBER OF AVAILABLE USER TASKS
	AH = E6h
Return: AX = number of processes available to current user
SeeAlso: AH=E0h
--------N-7FE7-------------------------------
INT 7F - Alloy MW386 - REMOVE DOS TASK
	AH = E7h
	AL = DOS process number
Return: CF set on error (invalid process number or first process)
Note:	can only be called by a foreground task
SeeAlso: AH=E0h
--------N-7FE8-------------------------------
INT 7F - Alloy MW386 - DOS TASK DELAY
	AH = E8h
	CX = delay time in milliseconds
Note:	a delay of 0 may be used to surrender the current time slice
SeeAlso: INT 15/AX=1000h,INT 1A/AX=FF01h,INT 21/AH=EEh"DoubleDOS"
SeeAlso: INT 2F/AX=1680h
--------N-7FF0-------------------------------
INT 7F - Alloy MW386 - RESTRICT DIRECTORY TO GROUP
	AH = F0h
	AL = group number
	DS:DX -> ASCIZ directory name
Return: CF clear if successful
	    AX = status
		0002h directory not found
		0003h directory not found
		0005h directory in use, cannot be restricted
		02xxh restricted to group xxh
	CF set on error
Note:	the restriction on the directory may be removed by calling this
	  function with group 0, then using AH=F1h to assign the directory to
	  group 0
SeeAlso: AH=F1h,AH=F2h,AH=F3h
--------N-7FF1-------------------------------
INT 7F - Alloy MW386 - ASSIGN DIRECTORY TO GROUP
	AH = F1h
	AL = group number
	DS:DX -> ASCIZ directory name
Notes:	performs permanent assignment to a group; no immediate action is taken
	  unless the directory has been restricted with AH=F0h
	may be used to restrict a nonexistent directory
SeeAlso: AH=F0h
--------N-7FF2-------------------------------
INT 7F - Alloy MW386 - READ RESTRICTED DIRECTORY ENTRY
	AH = F2h
	CX = entry number
	ES:DI -> 64-byte buffer
Return: CF clear if successful
	    buffer filled with 63-byte directory info and 1-byte group number
	CF set on error (invalid entry)
SeeAlso: AH=F0h,AH=F3h
--------N-7FF3-------------------------------
INT 7F - Alloy MW386 - READ RESTRICTED DIRECTORY ENTRY FOR GROUP
	AH = F3h
	AL = group number
	CX = entry number
	ES:DI -> 64-byte buffer
Return: CF clear if successful
	    CX = next entry number
	    buffer filled with 63-byte directory info and 1-byte group number
	CF set on error (no more matching entries)
Note:	like AH=F2h, but only returns directories belonging to the specified
	  group
SeeAlso: AH=F2h
--------N-7FF8-------------------------------
INT 7F - Alloy MW386 - ASSIGN USER TO GROUP
	AH = F8h
	AL = group number
	DL = user number
	DH = machine number (currently 00h)
Return: CF clear if successful
	CF set on error (user already in maximum number of groups)
Note:	each user is allowed eight group assignments
SeeAlso: AH=F9h,AH=FAh
--------N-7FF9-------------------------------
INT 7F - Alloy MW386 - REMOVE USER FROM GROUP
	AH = F9h
	AL = group number
	DL = user number
	DH = machine number (currently 00h)
Return: CF set if failed
SeeAlso: AH=F8h,AH=FAh
--------N-7FFA-------------------------------
INT 7F - Alloy MW386 - GET USER GROUP LIST
	AH = FAh
	DL = user number
	DH = machine number (currently 00h)
	ES:DI -> 16-byte buffer for group list
Return: CX = number of groups
	ES:DI buffer filled with group numbers
SeeAlso: AH=F8h,AH=F9h
--------N-7FFB-------------------------------
INT 7F - Alloy MW386 - ASSIGN GROUP NAME
	AH = FBh
	CL = group number
	ES:DI -> ASCIZ group name (max 17 bytes)
SeeAlso: AH=FCh
--------N-7FFC-------------------------------
INT 7F - Alloy MW386 - GET GROUP NAME
	AH = FCh
	CL = group number
	ES:DI -> 17-byte buffer for ASCIZ name
Return: ES:DI buffer filled
Note:	if the group has not been named, "(unnamed)" is returned
SeeAlso: AH=FBh
----------80---------------------------------
INT 80 - Q-PRO4 - ???
--------r-80---------------------------------
INT 80 - reserved for BASIC
Note:	this vector and INT 81 through INT ED are modified but not restored by
	  Direct Access v4.0, and may be left dangling by other programs
	  written with the same version of compiled BASIC
SeeAlso: INT 81"BASIC"
--------s-80----BX0000-----------------------
INT 80 - SoundBlaster SBFM driver - GET VERSION
	BX = 0000h
Return: ???
Note:	SBFM installs at a free interrupt in the range 80h through BFh
SeeAlso: BX=0008h,INT 2F/AX=FBFBh
--------s-80----BX0001-----------------------
INT 80 - SoundBlaster SBFM driver - SET MUSIC STATUS BYTE ADDRESS
	BX = 0001h
	DX:AX -> music status byte
SeeAlso: BX=0000h,BX=0002h,BX=0003h
--------s-80----BX0002-----------------------
INT 80 - SoundBlaster SBFM driver - SET INSTRUMENT TABLE
	BX = 0002h
	CX = number of instruments
	DX:AX -> instrument table
SeeAlso: BX=0000h,BX=0001h,BX=0005h
--------s-80----BX0003-----------------------
INT 80 - SoundBlaster SBFM driver - SET SYSTEM CLOCK RATE
	BX = 0003h
	AX = clock rate divisor (1193180 / desired frequency in Hertz)
	    FFFFh to restore to 18.2 Hz
SeeAlso: BX=0000h,BX=0001h,BX=0004h
--------s-80----BX0004-----------------------
INT 80 - SoundBlaster SBFM driver - SET DRIVER CLOCK RATE
	BX = 0004h
	AX = driver clock rate divisor (1193180 / frequency in Hertz)
Note:	default frequency is 96 Hz
SeeAlso: BX=0000h,BX=0003h
--------s-80----BX0005-----------------------
INT 80 - SoundBlaster SBFM driver - TRANSPOSE MUSIC
	BX = 0005h
	AX = semi-tone offset
SeeAlso: BX=0000h,BX=0002h,BX=0006h
--------s-80----BX0006-----------------------
INT 80 - SoundBlaster SBFM driver - PLAY MUSIC
	BX = 0006h
	DX:AX -> music block
Return: AX = status
	    0000h successful
	    0001h music already active
SeeAlso: BX=0000h,BX=0007h,BX=000Ah,INT 1A/AX=FF04h
--------s-80----BX0007-----------------------
INT 80 - SoundBlaster SBFM driver - STOP MUSIC
	BX = 0007h
Return: AX = status
	    0000h successful
	    0001h music not active
SeeAlso: BX=0000h,BX=0006h,BX=0009h,INT 1A/AX=FF05h
--------s-80----BX0008-----------------------
INT 80 - SoundBlaster SBFM driver - RESET DRIVER
	BX = 0008h
Return: AX = status
	    0000h successful
	    0001h music is active
SeeAlso: BX=0000h
--------s-80----BX0009-----------------------
INT 80 - SoundBlaster SBFM driver - PAUSE MUSIC
	BX = 0009h
Return: AX = status
	    0000h successful
	    0001h no music active
SeeAlso: BX=0000h,BX=0007h,BX=000Ah,INT 1A/AX=FF01h
--------s-80----BX000A-----------------------
INT 80 - SoundBlaster SBFM driver - RESUME MUSIC
	BX = 000Ah
Return: AX = status
	    0000h successful
	    0001h no music paused
SeeAlso: BX=0000h,BX=0006h,BX=0009h
--------s-80----BX000B-----------------------
INT 80 - SoundBlaster SBFM driver - SET USER-DEF TRAP FOR SYSTEM-EXCLUSIVE CMDS
	BX = 000Bh
	DX:AX -> trap routine
SeeAlso: BX=0000h
--------N-8001-------------------------------
INT 80 - QPC Software PKTINT.COM - INITIALIZE
	AH = 01h
Return: AX = 0000h
	CX = FFFFh
	DX = FFFFh
Notes:	this interrupt is the WinQVTNet protected mode interface to Windows 3.0
	all buffer pointers are reset back to 0
--------N-8002-------------------------------
INT 80 - QPC Software PKTINT.COM - GET BUFFER ADDRESSES
	AH = 02h
	BX = extra bytes to allocate per packet
Return: AX = segment address of 10K buffer (for receives???)
	BX = segment address of 2K buffer (for sends???)
SeeAlso: AH=05h
--------N-8003-------------------------------
INT 80 - QPC Software PKTINT.COM - GET ENTRY POINT
	AH = 03h
Return: CX:DX -> receive call address
Note:	the returned address can be used in the packet driver calls since it
	  will be a valid address in all DOS boxes
SeeAlso: AH=06h
--------N-8004-------------------------------
INT 80 - QPC Software PKTINT.COM - ENABLE???
	AH = 04h
	BX = ???
Return: ???
SeeAlso: AH=01h
--------N-8005-------------------------------
INT 80 - QPC Software PKTINT.COM - GET RECEIVE STATISTICS
	AH = 05h
Return: AX = amount of buffer currently in use
	BX = current offset in buffer
	CX = number of times receive has been called
SeeAlso: AH=02h
--------N-8006-------------------------------
INT 80 - QPC Software PKTINT.COM - REMOVE RECEIVED PACKET
	AH = 06h
Return: BX = next packet offset
	CX = number of bytes still buffered
	DX = size of packet released back into buffer pool
SeeAlso: AH=03h
--------r-81---------------------------------
INT 81 - reserved for BASIC
Note:	this vector is modified but not restored by Direct Access v4.0, and
	  may be left dangling by other programs written with the same version
	  of compiled BASIC
SeeAlso: INT 80"BASIC",INT 82"BASIC"
--------N-81---------------------------------
INT 81 - IBM TOKEN RING ADAPTER - ???
SeeAlso: INT 82"TOKEN RING",INT 91"TOKEN RING"
--------r-82---------------------------------
INT 82 - reserved for BASIC
SeeAlso: INT 81"BASIC",INT 83"BASIC"
--------N-82---------------------------------
INT 82 - IBM TOKEN RING ADAPTER - ???
	AH = function
	    00h display message???
		DS:BX -> string
	???
Return: ???
SeeAlso: INT 81"TOKEN RING",INT 91"TOKEN RING"
--------r-83---------------------------------
INT 83 - reserved for BASIC
SeeAlso: INT 82"BASIC",INT 84"BASIC"
--------r-84---------------------------------
INT 84 - reserved for BASIC
SeeAlso: INT 83"BASIC",INT 85"BASIC"
--------r-85---------------------------------
INT 85 - reserved for BASIC
Note:	INT 80 through INT ED are modified but not restored by Direct Access
	  v4.0, and may be left dangling by other programs written with the
	  same version of compiled BASIC
SeeAlso: INT 84"BASIC",INT 86"BASIC"
--------N-86---------------------------------
INT 86 - NetBIOS - ORIGINAL INT 18
Note:	some implementations of NetBIOS reportedly relocate INT 18 here
SeeAlso: INT 18
--------r-86---------------------------------
INT 86 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 85"BASIC",INT 87"BASIC"
--------r-86---------------------------------
INT 86 - APL*PLUS/PC - Terminate APL session and return to DOS
SeeAlso: INT 21/AH=4Ch,INT 87"APL"
--------r-87---------------------------------
INT 87 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 86"BASIC",INT 88"BASIC"
--------r-87---------------------------------
INT 87 - APL*PLUS/PC - ???
SeeAlso: INT 86"APL",INT 88/AL=00h
--------r-88---------------------------------
INT 88 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 87"BASIC",INT 89"BASIC"
--------r-88--00-----------------------------
INT 88 - APL*PLUS/PC - CREATE OBJECT OF ARBITRARY RANK OR SHAPE
	AL = 00h
	BX = STPTR of the variable to be assigned
	ES:SI -> model of type, rank, and shape (see below)
Return: ES:DI -> first data byte of object
	DX:CX = number of elements in the object
SeeAlso: INT C8"APL"

Format of shape model:
Offset	Size	Description
 00h	BYTE	type
		01h character (2-byte dimension sizes)
		02h integer (2-byte dimension sizes)
		08h floating point (2-byte dimension sizes)
		11h character (4-byte dimension sizes)
		12h integer (4-byte dimension sizes)
		18h floating point (4-byte dimension sizes)
 01h	BYTE	rank
 02h	WORD/DWORD first dimension of shape
 N	WORD/DWORD second dimension of shape
	...
--------r-88--01-----------------------------
INT 88 - APL*PLUS/PC - CREATE CHARACTER SCALAR/VECTOR/MATRIX <64K IN SIZE
	AL = 01h
	AH = rank
	BX = STPTR of the variable to be assigned
	CX = first dimension (if any)
	DX = second dimension (if any)
Return: ES:DI -> object
	CX = number of elements in the object
Note:	each dimension must be 32767 or smaller
SeeAlso: AL=02h,AL=08h,INT C8"APL"
--------r-88--02-----------------------------
INT 88 - APL*PLUS/PC - CREATE INTEGER SCALAR/VECTOR/MATRIX <64K IN SIZE
	AL = 02h
	AH = rank
	BX = STPTR of the variable to be assigned
	CX = first dimension (if any)
	DX = second dimension (if any)
Return: ES:DI -> object
	CX = number of elements in the object
Note:	each dimension must be 32767 or smaller
SeeAlso: AL=01h,AL=08h,INT C8"APL"
--------r-88--08-----------------------------
INT 88 - APL*PLUS/PC - CREATE FLOATING POINT SCALAR/VECTOR/MATRIX <64K IN SIZE
	AL = 08h
	AH = rank
	BX = STPTR of the variable to be assigned
	CX = first dimension (if any)
	DX = second dimension (if any)
Return: ES:DI -> object
	CX = number of elements in the object
Note:	each dimension must be 32767 or smaller
SeeAlso: AL=01h,AL=02h,INT C8"APL"
--------r-88--F5-----------------------------
INT 88 - APL*PLUS/PC - FORCE OBJECT INTO REAL WORKSPACE FROM VIRTUAL
	AL = F5h
	BX = STPTR of object
SeeAlso: INT C8"APL"
--------r-88--F6-----------------------------
INT 88 - APL*PLUS/PC - MAKE NAME IMMUNE FROM OUTSWAPPING
	AL = F6h
	BX = STPTR of object
SeeAlso: AL=F7h,AL=F8h,INT C8"APL"
--------r-88--F7-----------------------------
INT 88 - APL*PLUS/PC - MAKE NAME ELIGIBLE FOR OUTSWAPPING
	AL = F7h
	BX = STPTR of object
SeeAlso: AL=F6h,AL=F8h,INT C8"APL"
--------r-88--F8-----------------------------
INT 88 - APL*PLUS/PC - REPORT WHETHER NAME IS ELIGIBLE FOR OUTSWAPPING
	AL = F8h
	BX = STPTR of object
Return: BX = name's status
	    0000h eligible
	    0001h not eligible
SeeAlso: AL=F6h,AL=F7h,INT C8"APL"
--------r-88--F9-----------------------------
INT 88 - APL*PLUS/PC - DETERMINE NAME STATUS
	AL = F9h
	ES:SI -> name
	CX = length of name
Return: CF set if name ill-formed or already in use
	    BX = STPTR if already in symbol table
	CF clear if name is available for use
	    BX = 0000h
Note:	does not force the name into the workspace
SeeAlso: AL=FEh,AL=FFh,INT C8"APL"
--------r-88--FC-----------------------------
INT 88 - APL*PLUS/PC - DETERMINE IF MEMORY AVAIL WITHOUT GARBAGE COLLECTION
	AL = FCh
	BX = amount of memory needed (paragraphs)
Return: CF clear if memory available
	CF set if a workspace compaction is required
SeeAlso: AL=FDh,INT C8"APL"
--------r-88--FD-----------------------------
INT 88 - APL*PLUS/PC - PERFORM GARBAGE COLLECTION AND RETURN AVAILABLE MEMORY
	AL = FDh
Return: BX = number of paragraphs available in workspace
SeeAlso: AL=FCh,INT C8"APL"
--------r-88--FE-----------------------------
INT 88 - APL*PLUS/PC - CREATE NAME
	AL = FEh
	ES:SI -> name
	CX = length of name
Return: BX = STPTR of name
	DX = interpreter's data segment
SeeAlso: AL=F9h,AL=FFh,INT C8"APL"
--------r-88--FF-----------------------------
INT 88 - APL*PLUS/PC - DETERMINE NAME STATUS
	AL = FFh
	ES:SI -> name
	CX = length of name
Return: CF set if name ill-formed or already in use
	    BX = STPTR if already in symbol table
	CF clear if name is available for use
	    BX = 0000h
Note:	forces the name into the workspace and makes it immune from outswapping
SeeAlso: AL=F9h,AL=FEh,INT C8"APL"
--------r-89---------------------------------
INT 89 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 88"BASIC",INT 8A"BASIC"
--------r-8A---------------------------------
INT 8A - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 89"BASIC",INT 8B"BASIC"
--------r-8A---------------------------------
INT 8A - APL*PLUS/PC - PRINT SCREEN
Note:	same as INT 05
SeeAlso: INT 05,INT 8C"APL",INT CA"APL"
--------r-8B---------------------------------
INT 8B - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT 8A"BASIC",INT 8C"BASIC"
--------r-8B---------------------------------
INT 8B - APL*PLUS/PC - BEEP
Note:	same as printing a ^G via INT 21/AH=02h
SeeAlso: INT 21/AH=02h,INT CB"APL"
--------r-8C---------------------------------
INT 8C - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-8C---------------------------------
INT 8C - APL*PLUS/PC - CLEAR SCREEN MEMORY
	AX = flag
	    0000h do not save display attributes
	    0001h save attributes
SeeAlso: INT CC"APL"
--------r-8D---------------------------------
INT 8D - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-8E---------------------------------
INT 8E - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-8F---------------------------------
INT 8F - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-90---------------------------------
INT 90 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-90---------------------------------
INT 90 - APL*PLUS/PC - USED BY PORT 10 PRINTER DRIVER
--------r-91---------------------------------
INT 91 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------N-91---------------------------------
INT 91 - IBM TOKEN RING ADAPTER - ???
SeeAlso: INT 81"TOKEN RING",INT 82"TOKEN RING",INT 93"TOKEN RING"
--------r-92---------------------------------
INT 92 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------N-92---------------------------------
INT 92 - Sangoma X.25 INTERFACE PROGRAM
	BX:DX -> control block
SeeAlso: INT 68"Sangoma"
--------e-92E1-------------------------------
INT 92 - Da Vinci eMail Dispatcher INTERFACE
	AH = E1h
	AL = function
	BX = stack count (number of words to push)
	CX:DX -> stack data (in word-reversed order ready to push)
Return: AX = status (see below)
Note:	preserves BP, DS, SI, DI; other registers may be destroyed

Values for status:
 0001h success
 FF97h "ERS_NOT_AVAILABLE"
 FF99h "ERS_TOO_MANY_NAMES"
 FF9Ah "ERS_BAD_NAME_PASSWORD"
 FFE3h "ERS_NAME_NOT_FOUND"
 FFF8h "ERS_USE_STRING" (call NetGetError to get error string)
 FFFFh "ERS_NO_SUCH_FILE"
--------e-92E100-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetInitStart"
	AX = E100h
	BX = size of parameter block in words (000Ah)
	CX:DX -> parameter block (see below)
Return: AX = 0001h success
Desc:	this function is used to initialize the dispatcher
SeeAlso: AX=E101h,AX=E103h

Format of parameter block:
Offset	Size	Description
 00h	WORD	segment of ???
 02h	WORD	offset of ???
 04h	WORD	high part of long ???
 06h	WORD	low part of long ???
 08h	WORD	high part of long ???
 0Ah	WORD	low part of long ???
 0Ch	WORD	high part of long ???
 0Eh	WORD	low part of long ???
 10h	WORD	high part of long ???
 12h	WORD	low part of long ???
--------e-92E101BX0000-----------------------
INT 92 - Da Vinci eMail Dispatcher - "NetInitCheck"
	AX = E101h
	BX = 0000h
	CX:DX ignored
Return: AX = 0001h success
SeeAlso: AX=E100h,AX=E180h
--------e-92E102BX0000-----------------------
INT 92 - Da Vinci eMail Dispatcher - "NetCheckDriver"
	AX = E102h
	BX = 0000h
	CX:DX ignored
Return: AX = 0001h success
Desc:	this function is used to determine if the dispatcher is loaded
SeeAlso: AX=E10Bh,AX=E180h
--------e-92E103BX0000-----------------------
INT 92 - Da Vinci eMail Dispatcher - "NetTerminate"
	AX = E103h
	BX = 0000h
	CX:DX ignored
Return: AX = status (see AH=E1h)
SeeAlso: AX=E100h
--------e-92E104-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetWhereIs"
	AX = E104h
	BX = size of parameter block in words (0006h)
	CX:DX -> parameter block (see below)
Return: AX = status (see AH=E1h)
Desc:	this function is used to verify node address for usernames
SeeAlso: AX=E180h

Format of parameter block:
Offset	Size	Description
 00h	WORD	segment of node address buffer
 02h	WORD	offset of node address buffer
 04h	WORD	segment of uppercase username
 06h	WORD	offset of uppercase username
 08h	WORD	segment of "DVSEMAIL"
 0Ah	WORD	offset of "DVSEMAIL"
--------e-92E105-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetOpen"
	AX = E105h
	BX = size of parameter block in words (0007h)
	CX:DX -> parameter block (see below)
Return: AX = 0000h Error
	AX = handle
Desc:	this function is used to open a submission channel
SeeAlso: AX=E10Ah,AX=E106h,AX=E108h

Format of parameter block:
Offset	Size	Description
 00h	WORD	operation (1 = read, 2 = write)
 02h	WORD	segment of uppercase To: username
 04h	WORD	offset of uppercase To: username
 06h	WORD	segment of "DVSEMAIL"
 08h	WORD	offset of "DVSEMAIL"
 0Ah	WORD	segment of node address
 0Ch	WORD	offset of node address
--------e-92E106BX0004-----------------------
INT 92 - Da Vinci eMail Dispatcher - "NetRead"
	AX = E106h
	BX = 0004h
	CX:DX -> parameter block
Return: AX = 0001h
SeeAlso: AX=E108h
--------e-92E107BX0002-----------------------
INT 92 - Da Vinci eMail Dispatcher - "NetGetError"
	AX = E107h
	BX = 0002h
	CX:DX -> parameter block
Return: AX = 0001h
SeeAlso: AX=E109h,AX=E180h
--------e-92E108-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetWrite"
	AX = E108h
	BX = size of parameter block in words (0004h)
	CX:DX -> parameter block (see below)
Return: AX = amount written
Desc:	This function is used to write transactions to the dispatcher.
	  The command block is written first and then another call is used
	  to write the associated data.
SeeAlso: AX=E106h

Format of parameter block:
Offset	Size	Description
 00h	WORD	buffer count
 02h	WORD	segment of command buffer
 04h	WORD	offset of command buffer
 06h	WORD	handle from NetOpen

Format of command buffer:
Offset	Size	Description
 00h	BYTE	command
		21h '!' Protocol commands for remote control
		41h 'A' Authorization protocol element
		42h 'B' Return(back) routing information
		    Associated data is the From: username
		43h 'C' Carbon Copy list
		    Associated data is a comma delimitted list of usernames
		44h 'D' Distribution list
		    Associated data is a comma delimitted list of usernames
		45h 'E' Mail end marker
		    No associated data
		48h 'H' Mail message header
		    Associated data is a message header buffer
		4Dh 'M' Mail message
		    Associated data is the body of the message
		4Fh 'O' Object
		50h 'P' Paperclip attachment
		52h 'R' Routing information
		    Associated data is the To: username
		53h 'S' Subject
		    Associated data is the subject of the message
		54h 'T' Trail of Reply/Forwards
 01h	BYTE	subcommand
 02h	DWORD	length of associated data

Format of message header buffer:
Offset	Size	Description
 00h 30 BYTEs	subject line
 1Eh 24 BYTEs	To
 36h 24 BYTEs	From
 4Eh	DWORD	Time
		BYTE	00h
		BYTE	hour
		BYTE	minute
		BYTE	second
 52h	DWORD	Date
		BYTE	00h
		BYTE	year
		BYTE	month
		BYTE	day
 56h	DWORD	serial number (00000000h)
 5Ah	WORD	mail types (see below)
 5Ch	WORD	special types (0)

Bitfields for mail types:
 bit 7	blind carbon copy
 bit 6	carbon copy
 bit 5	priority
 bit 4	confidential
 bit 3	certified
 bit 2	bulk
 bits 1-0 class (first, second, third, bulk)
--------e-92E109-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetErrorFix" (UNUSED)
	AX = E109h
	BX = size of parameter block in words (0001h)
	CX:DX -> parameter block (see below)
Return: AX = FF97h (ERS_NOT_AVAILABLE)
SeeAlso: AX=E107h,AX=E180h

Format of parameter block:
Offset	Size	Description
 00h	WORD	???
--------e-92E10A-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetClose"
	AX = E10Ah
	BX = size of parameter block in words (0001h)
	CX:DX -> parameter block (see below)
Return: AX = 0001h
Desc:	this function is used to close a dispatcher handle
SeeAlso: AX=E105h

Format of parameter block:
Offset	Size	Description
 00h	WORD	handle from NetOpen
--------e-92E10B-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetCheckQueue"
	AX = E10Bh
	BX = size of parameter block in words (0004h)
	CX:DX -> parameter block (see below)
Return: AX = 0001h
SeeAlso: AX=E102h,AX=E10Ch

Format of parameter block:
Offset	Size	Description
 00h	WORD	segment of 24-byte username buffer
 02h	WORD	offset of 24-byte username buffer
 04h	WORD	segment of 24-byte protocol buffer
 06h	WORD	offset of 24-byte protocol buffer
--------e-92E10C-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetReadQueue"
	AX = E10Ch
	BX = size of parameter block in words (0002h)
	CX:DX -> parameter block (see below)
Return: AX = 0001h
SeeAlso: AX=E10Bh

Format of parameter block:
Offset	Size	Description
 00h	WORD	Segment of 128 byte node address buffer
 02h	WORD	Offset of 128 byte node address buffer
--------e-92E10D-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetSubmitName"
	AX = E10Dh
	BX = size of parameter block in words (0006h)
	CX:DX -> parameter block (see below)
Return: AX = status (see AH=E1h)
Desc:	this function is used to verify username/password
SeeAlso: AX=E10Eh

Format of parameter block:
Offset	Size	Description
 00h	WORD	segment of uppercase password string
 02h	WORD	offset of uppercase password string
 04h	WORD	segment of uppercase username string
 06h	WORD	offset of uppercase username string
 08h	WORD	segment of "DVSEMAIL"
 0Ah	WORD	offset of "DVSEMAIL"
--------e-92E10E-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetRemoveName"
	AX = E10Eh
	BX = size of parameter block in words (0004h)
	CX:DX -> parameter block (see below)
Return: AX = 0001h
Desc:	this function is used to remove a username
SeeAlso: AX=E10Dh

Format of parameter block:
Offset	Type	Description
 00h	WORD	segment of uppercase username
 02h	WORD	offset of uppercase username
 04h	WORD	segment of "DVSEMAIL"
 06h	WORD	offset of "DVSEMAIL"
--------e-92E10FBX0000-----------------------
INT 92 - Da Vinci eMail Dispatcher - IS ANYONE THERE? QUERY
	AX = E10Fh
	BX = 0000h
	CX:DX ignored
Return: AX = 0001h
SeeAlso: AX=E180h
--------e-92E110-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetGetAltRoute"
	AX = E110h
	BX = size of parameter block in words (0006h)
	CX:DX -> parameter block (see below)
Return: AX = 0001h
SeeAlso: AX=E111h,AX=E113h

Format of parameter block:
Offset	Size	Description
 00h  6 WORDs	???
--------e-92E111-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetDeleteAltRoutes"
	AX = E111h
	BX = size of parameter block in words (0004h)
	CX:DX -> parameter block (see below)
Return: AX = 0001h
SeeAlso: AX=E110h,AX=E113h

Format of parameter block:
Offset	Size	Description
 00h  4 WORDs	???
--------e-92E112-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetChangePassword"
	AX = E112h
	BX = size of parameter block in words (0008h)
	CX:DX -> parameter block (see below)
Return: AX = 0001h
SeeAlso: AX=E180h

Format of parameter block:
Offset	Size	Description
 00h  8 WORDs	???
--------e-92E113-----------------------------
INT 92 - Da Vinci eMail Dispatcher - "NetSetAltRoute"
	AX = E113h
	BX = size of parameter block in words (0008h)
	CX:DX -> parameter block (see below)
Return: AX = 0001h
SeeAlso: AX=E110h,AX=E111h

Format of parameter block:
Offset	Size	Description
 00h  8 WORDs	???
--------e-92E175-----------------------------
INT 92 - Da Vinci eMail Dispatcher - BECOME MICRO TSR
	AX = E175h
Return: AX = 0012h
	BX = PSP
SeeAlso: AX=E180h
--------e-92E180-----------------------------
INT 92 - Da Vinci eMail Dispatcher - INSTALLATION CHECK
	AX = E180h
Return: AX = 0012h if installed
	ES:DX -> '$'-terminated driver information string
SeeAlso: AX=E102h,AX=E105h,AX=E10Fh,AX=E175h
--------r-93---------------------------------
INT 93 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------N-93---------------------------------
INT 93 - IBM TOKEN RING ADAPTER - ???
SeeAlso: INT 81"TOKEN RING",INT 91"TOKEN RING"
--------r-94---------------------------------
INT 94 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-95---------------------------------
INT 95 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-95---------------------------------
INT 95 - APL*PLUS/PC - DETERMINE R= SPACE
Note:	use only when the R= option is invoked on entering APL
--------r-96---------------------------------
INT 96 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-97---------------------------------
INT 97 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-98---------------------------------
INT 98 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-99---------------------------------
INT 99 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-9A---------------------------------
INT 9A - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-9B---------------------------------
INT 9B - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-9C---------------------------------
INT 9C - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-9D---------------------------------
INT 9D - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-9E---------------------------------
INT 9E - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-9F---------------------------------
INT 9F - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-A0---------------------------------
INT A0 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-A0---------------------------------
INT A0 - APL*PLUS/PC - USED BY APL/GSS*CGI GRAPHICS INTERFACE
SeeAlso: INT 59
--------r-A1---------------------------------
INT A1 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-A2---------------------------------
INT A2 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-A3---------------------------------
INT A3 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-A4---------------------------------
INT A4 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------U-A4---------------------------------
INT A4 U - Right Hand Man - API
	AH = function number (v3.3 supports functions 00h-52h)
Return: CF set on error
	CF clear if successful
Program: Right Hand Man is a TSR desk-top utility originally by Red E Products
	  which has evolved into Futurus Team
Note:	this interrupt is only hooked while popped up
SeeAlso: INT 2F/AX=A4E0h
--------r-A5---------------------------------
INT A5 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-A6---------------------------------
INT A6 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-A7---------------------------------
INT A7 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-A8---------------------------------
INT A8 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-A9---------------------------------
INT A9 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-AA---------------------------------
INT AA - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-AB---------------------------------
INT AB - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-AC---------------------------------
INT AC - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-AD---------------------------------
INT AD - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-AE---------------------------------
INT AE - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-AF---------------------------------
INT AF - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-B0---------------------------------
INT B0 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-B1---------------------------------
INT B1 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-B2---------------------------------
INT B2 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-B3---------------------------------
INT B3 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------U-B370-------------------------------
INT B3 - ZIPKEY - GET VERSION
	AH = 70h
Return: AH = major version
	AL = minor version
	CL = number of states and territories in current database
	DH = year of current database - 1900
	DL = month of current database's file date
Return: AX destroyed
Program: ZIPKEY is a resident ZIPCODE database by Eric Isaacson
Note:	if installed, the string "ZIPKEY" is present at offset 75h in the
	  interrupt handler's segment, and the byte at 7Bh contains the API
	  version number (00h for v1.x, 01h for v2.0)
--------U-B371-------------------------------
INT B3 - ZIPKEY - CONVERT TWO-LETTER ABBREVIATION TO STATE CODE
	AH = 71h
	BX = abbreviation, in either case (first letter in BL)
Return: CF set on error
	    AL = FFh
	CF clear if successful
	    AL = ZIPKEY state code
SeeAlso: AH=72h
--------U-B372-------------------------------
INT B3 - ZIPKEY - CONVERT STATE CODE TO TWO-LETTER ABBREVIATION
	AH = 72h
	BL = ZIPKEY state code
Return: CF set on error
	    AX destroyed
	CF clear if successful
	    AX = abbreviation, in upper case
SeeAlso: AH=71h,AH=73h
--------U-B373-------------------------------
INT B3 - ZIPKEY - CONVERT STATE CODE TO STATE NAME
	AH = 73h
	BL = ZIPKEY state code
	ES:DI -> buffer for name
Return: CF set on error
	    AX destroyed
	CF clear if successful
	    ES:DI points one byte beyond end of name
SeeAlso: AH=72h
--------U-B374-------------------------------
INT B3 - ZIPKEY - CONVERT ZIPCODE TO ASCII DIGITS
	AH = 74h
	DX = zipcode region (0-999)
	CH = last two digits of zipcode (0-99)
	ES:DI -> buffer
Return: CF set on error
	    AX destroyed
	CF clear if successful
	    ES:DI points one byte beyond end of digit string
--------U-B375-------------------------------
INT B3 - ZIPKEY - LOOK UP STATE CODE FOR ZIPCODE
	AH = 75h
	DX = zipcode region (0-999)
	CH = last two digits of zipcode (0-99)
Return: CF set on error (zipcode not found)
	    AL = suggested state code, FFh if none
	CF clear if successful
	    AL = ZIPKEY state code
	    BX = area code (v2.0+)
SeeAlso: AH=76h,AH=79h
--------U-B376-------------------------------
INT B3 - ZIPKEY - LOOK UP CITY AND STATE FOR ZIPCODE
	AH = 76h
	DX = zipcode region (0-999)
	CH = last two digits of zipcode (0-99)
	ES:DI -> buffer for name
Return: CF set on error
	    AL = suggested state code, FFh if none
	    ES:DI buffer filled with suggested city name
	CF clear if successful
	    AL = ZIPKEY state code
	    BX = area code (v2.0+)
	    ES:DI points one byte beyond end of name
SeeAlso: AH=75h,AH=78h,AH=7Eh
--------U-B377-------------------------------
INT B3 - ZIPKEY - PLAY BACK EXIT KEY FOR ENTRY WITH GIVEN ZIPCODE
	AH = 77h
	DX = zipcode region (0-999)
	CH = last two digits of zipcode (0-99)
	BX = 16-bit BIOS keycode for a defined ZIPKEY alternate exit key
Return: CF set on error
	    AX destroyed
	CF clear if successful	
	    zipcode specification as defined by the BX keystroke is placed in
	      keyboard buffer, as if the user had popped up ZIPKEY and exited
	      by pressing the key specified by BX
--------U-B378-------------------------------
INT B3 - ZIPKEY - LOOK UP ZIPCODES FOR A GIVEN STATE AND CITY
	AH = 78h
	BL = ZIPKEY state code
	DS:SI -> city name, terminated with 0Dh if complete name, 00h if prefix
Return: BH = number of matching entries (set to 51 if more than 50)
	DX = zipcode region of first match (0-999)
	CL = last two digits of first zipcode in the range (0-99)
	CH = last two digits of last zipcode in the range (0-99)
	AX destroyed
SeeAlso: AH=79h,AH=7Ah
--------U-B379-------------------------------
INT B3 - ZIPKEY - LOOK UP ZIPCODES FOR A GIVEN CITY
	AH = 79h
	BL = ZIPKEY state code of first state to search
	DS:SI -> city name, terminated with 0Dh if complete name, 00h if prefix
Return:	AL = ZIPKEY state code of first matching state
	BH = number of matching entries (set to 51 if more than 50)
	DX = zipcode region of first match (0-999)
	CL = last two digits of first zipcode in first range (0-99)
	CH = last two digits of last zipcode in first range (0-99)
Note:	to find all matching cities, repeat search with BL set to one more than
	  the returned AL
SeeAlso: AH=78h,AH=7Ah
--------U-B37A-------------------------------
INT B3 - ZIPKEY - FETCH AN ENTRY FROM A PREVIOUS LOOKUP
	AH = 7Ah
	BL = case number (0 to one less than value returned in BH by lookup)
Return: AL = ZIPKEY state code
	DX = zipcode region (0-999)
	CL = last two digits of first zipcode in the range (0-99)
	CH = last two digits of last zipcode in the range (0-99)
SeeAlso: AH=78h,AH=79h
--------U-B37B-------------------------------
INT B3 - ZIPKEY - GET VALUES NEEDED TO SAVE ZIPKEY CONTEXT
	AH = 7Bh
Return: BL = maximum number of characters for a city name
	BH = ZIPKEY state code for last city-name search
	    FFh if none
	CX:DX = internal code identifying last city search
	AX destroyed
SeeAlso: AH=7Ch
--------U-B37C-------------------------------
INT B3 - ZIPKEY - RESTORE ZIPKEY CONTEXT
	AH = 7Ch
	BL = maximum number of characters for a city name
	BH = ZIPKEY state code for last city-name search
	    FFh if none
	CX:DX = internal code returned by AH=7Bh
Return: CF set on error
	CF clear if successful
	AX destroyed
SeeAlso: AH=7Bh
--------U-B37D-------------------------------
INT B3 - ZIPKEY - REQUEST POP UP
	AH = 7Dh
	BL = index number to simulate pressing a hotkey
	    FFh for immediate popup with no playback on return
Return: CF set on error
	    AL = FDh already busy with another request
	       = FEh illegal function
	CF clear if successful
	    AX destroyed
	    window popped up and was closed by the user
SeeAlso: AH=70h
--------U-B37E-------------------------------
INT B3 - ZIPKEY - GET NAME OF PRIMARY CITY FOR A ZIPCODE REGION
	AH = 7Eh
	DX = zipcode region (0-999)
	ES:DI -> buffer for name
Return: CF set on error
	    AL = FFh region does not exist
	CF clear if successful
	    AL = ZIPKEY state code
	    ES:DI points one byte beyond end of name
SeeAlso: AH=76h
--------U-B37F-------------------------------
INT B3 - ZIPKEY - ENABLE/DISABLE HOTKEYS
	AH = 7Fh
	BL = function
	    00h turn off hotkeys
	    01h turn on hotkeys
	    02h return hotkey status
	    03h toggle hotkey status
Return: AL = hotkey status
	    00h off
	    01h on
--------U-B380-------------------------------
INT B3 - ZIPKEY v2.0+ - DETERMINE STATE FOR AREA CODE
	AH = 80h
	BX = telephone area code (decimal)
Return: CF clear if successful
	    AL = ZIPKEY state code
	    DX = first ZIP region for state (03E8h if Canada)
	    CX = number of ZIP regions in state
	CF set on error
	    AL = FFh
	    DX = 03E9h
--------r-B4---------------------------------
INT B4 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
----------B4---------------------------------
INT B4 - STACKMAN - REQUEST NEW STACK
Return: SS:SP -> new stack
Note:	the installation check consists of testing for the string "STACKXXX" at
	  offset 0Ah from the interrupt handler
SeeAlso: INT 2F/AX=C9FFh,INT B5"STACKMAN"
Index:	installation check;STACKMAN
--------r-B5---------------------------------
INT B5 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
----------B5---------------------------------
INT B5 - STACKMAN - RESTORE ORIGINAL STACK
	SS:SP -> stack returned by INT B4
Return: SS:SP restored to value before INT B4
SeeAlso: INT 2F/AX=C9FFh,INT B4"STACKMAN"
--------r-B6---------------------------------
INT B6 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-B7---------------------------------
INT B7 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-B8---------------------------------
INT B8 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-B9---------------------------------
INT B9 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-BA---------------------------------
INT BA - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-BB---------------------------------
INT BB - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-BC---------------------------------
INT BC - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-BD---------------------------------
INT BD - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-BE---------------------------------
INT BE - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------Q-BE---------------------------------
INT BE - DESQview/X - ???
Note:	points at an IRET
SeeAlso: INT 15/AX=BFDEh/BX=0006h,INT 63"DESQview"
--------r-BF---------------------------------
INT BF - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-C0---------------------------------
INT C0 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-C1---------------------------------
INT C1 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-C2---------------------------------
INT C2 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-C3---------------------------------
INT C3 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-C4---------------------------------
INT C4 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-C5---------------------------------
INT C5 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-C6---------------------------------
INT C6 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-C6---------------------------------
INT C6 - APL*PLUS/PC - IDENTICAL TO INT 86
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 86"APL"
--------r-C7---------------------------------
INT C7 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-C7---------------------------------
INT C7 - APL*PLUS/PC - ???
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 87"APL"
--------r-C8---------------------------------
INT C8 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-C8---------------------------------
INT C8 - APL*PLUS/PC - IDENTICAL TO INT 88
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 88"APL"
--------r-C9---------------------------------
INT C9 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-C9---------------------------------
INT C9 - APL*PLUS/PC - ???
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 89"APL"
--------r-CA---------------------------------
INT CA - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-CA---------------------------------
INT CA - APL*PLUS/PC - PRINT SCREEN
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 8A"APL"
--------r-CB---------------------------------
INT CB - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-CB---------------------------------
INT CB - APL*PLUS/PC - BEEP
Notes:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
	same as printing a ^G via INT 21/AH=02h
SeeAlso: INT 8B"APL"
--------r-CC---------------------------------
INT CC - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-CC---------------------------------
INT CC - APL*PLUS/PC - CLEAR SCREEN MEMORY
	AX = flag
	    0000h do not save display attributes
	    0001h save attributes
Note:	STSC moved its interrupts from 86h-8Ch to C6h-CCh, but did not delete
	  the older interrupts
SeeAlso: INT 8C"APL"
--------r-CD---------------------------------
INT CD - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-CD---------------------------------
INT CD - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-CE---------------------------------
INT CE - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-CE---------------------------------
INT CE - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-CF---------------------------------
INT CF - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-CF---------------------------------
INT CF - APL*PLUS/PC - DEFAULT LOW-RESOLUTION TIMER FOR QUAD MF FUNCTION
SeeAlso: INT E0"APL"
--------r-D0---------------------------------
INT D0 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-D0---------------------------------
INT D0 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------U-D0---------------------------------
INT D0 - [not a vector!] - NJFRERAM SIGNATURE VECTOR
Program: NJFRERAM is a resident free-memory display utility by Mike "Nifty
	  James" Blaszczak
Note:	if NJFRERAM is installed, this vector points at the signature "NJ"
Index:	installation check;NJFRERAM
--------r-D1---------------------------------
INT D1 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-D1---------------------------------
INT D1 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-D2---------------------------------
INT D2 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-D2---------------------------------
INT D2 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-D3---------------------------------
INT D3 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-D3---------------------------------
INT D3 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-D4---------------------------------
INT D4 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-D4---------------------------------
INT D4 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------O-D4---------------------------------
INT D4 - PC-MOS/386 - API
--------r-D5---------------------------------
INT D5 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-D5---------------------------------
INT D5 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-D6---------------------------------
INT D6 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-D6---------------------------------
INT D6 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-D7---------------------------------
INT D7 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-D7---------------------------------
INT D7 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-D8---------------------------------
INT D8 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-D8---------------------------------
INT D8 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-D9---------------------------------
INT D9 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-D9---------------------------------
INT D9 - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-DA---------------------------------
INT DA - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-DA---------------------------------
INT DA - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-DB---------------------------------
INT DB - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-DB---------------------------------
INT DB - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------u-DC---------------------------------
INT DC - PC/370 v4.1- - API
SeeAlso: INT 60"PC/370"
--------r-DC---------------------------------
INT DC - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-DC---------------------------------
INT DC - STSC APL*PLUS/PC - MAY BE USED IN FUTURE RELEASES
--------r-DD---------------------------------
INT DD - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-DD---------------------------------
INT DD - STSC APL*PLUS/PC v9.0 - PLACE KEYSTROKE EVENTS IN INPUT BUFFER
	BX = where to place keystrokes
	    FFFFh insert before current buffer contents
	    0000h replace current contents
	    0001h insert after current contents
	CX = number of keystroke events to insert
	ES:SI -> data to be placed into buffer (list of WORD key codes)
	    4000h + N = normal ASCII keystroke N (N = 00h to FFh)
	    4100h + N = extended ASCII keystroke N (N = 03h to 84h)
SeeAlso: INT 16/AH=05h
--------r-DE---------------------------------
INT DE - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-DE---------------------------------
INT DE - APL*PLUS/PC - ???
Note:	appears to be the same as INT 16
--------b-DF---------------------------------
INT DF - Victor 9000 - SuperBIOS
--------r-DF---------------------------------
INT DF - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-DF---------------------------------
INT DF - APL*PLUS/PC - SAME AS INT 10
SeeAlso: INT 10
--------r-E0---------------------------------
INT E0 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-E0---------------------------------
INT E0 - APL*PLUS/PC - RESTIME HIGH-RESOLUTION TIMER FOR QUAD MF FUNCTION
SeeAlso: INT CF"APL"
--------v-E0---------------------------------
INT E0 - VIRUS - "Micro-128" - ???
Note:	Micro-128 also overwrites the upper half of the interrupt table
SeeAlso: INT 70"VIRUS"
--------O-E0---------------------------------
INT E0 - CP/M-86, Concurrent CP/M, DR Multiuser DOS - FUNCTION CALLS
	CL = function number
	DS,DX = parameters
Return: as appropriate for function
Notes:	several functions are covered in more detail in following entries
	most of these calls are also supported by Digital Research's DOS Plus
	  v2.1; the unsupported functions are 26h,29h-2Bh,3Ah,3Dh-62h,71h-8Ch,
	  90h-92h,94h-97h,9Bh-ABh, and AEh-FFh
SeeAlso: INT 21/AX=4459h,INT 21/AH=E0h"DOS Plus"

Values for function number:
 00h	terminate calling process (see also INT 21/AH=00h)
 01h	read a character
 02h	write character to default console (see also INT 21/AH=02h)
 03h	read character from default AUX (see also INT 21/AH=03h)
 04h	write character to default AUX (see also INT 21/AH=04h)
 05h	write character to default list device (see also INT 21/AH=05h)
 06h	perform raw I/O on default console (see also INT 21/AH=06h)
 07h	return default AUX input status
 08h	return default AUX output status
 09h	write string to default console (see also INT 21/AH=09h)
 0Ah	read string from default console (see also INT 21/AH=0Ah)
 0Bh	return default console input status (see also INT 21/AH=0Bh)
 0Ch	get BDOS release ID
 0Dh	reset all disk drives (see also INT 21/AH=0Dh)
 0Eh	set default drive (see also INT 21/AH=0Eh)
 0Fh	open file via FCB (see also INT 21/AH=0Fh)
 10h	close file via FCB (see also INT 21/AH=10h)
 11h	search for first matching file with FCB (see also INT 21/AH=11h)
 12h	search for next matching file with FCB (see also INT 21/AH=12h)
 13h	delete file via FCB (see also INT 21/AH=13h)
 14h	sequential read via FCB (see also INT 21/AH=14h)
 15h	sequential write via FCB (see also INT 21/AH=15h)
 16h	create file via FCB (see also INT 21/AH=16h)
 17h	rename file via FCB (see also INT 21/AH=17h)
 18h	get bit map of logged drives
 19h	get default drive (see also INT 21/AH=19h)
 1Ah	set DMA address offset
 1Bh	get default disk allocation vector (see also INT 21/AH=1Bh)
 1Ch	set default drive to read-only
 1Dh	get bit map of read-only drives
 1Eh	set file attributes via FCB (see also INT 21/AX=4301h)
 1Fh	get address of disk parameter block (see also INT 21/AH=1Fh)
 20h	get/set default user number
 21h	read random record via FCB (see also INT 21/AH=21h)
 22h	write random record via FCB (see also INT 21/AH=22h)
 23h	compute file size with FCB (see also INT 21/AH=23h)
 24h	get FCB random record number (see also INT 21/AH=24h)
 25h	reset specified drives
 26h	access specified drives (not in DR DOS Plus v2.1)
 27h	free specified drives
 28h	write random with FCB, zero fill (see also also INT 21/AH=28h)
 2Ah	lock records in FCB file (see also INT 21/AH=5Ch)
 2Bh	unlock records in FCB file (see also INT 21/AH=5Ch)
 2Ch	set BDOS multisector count
 2Dh	set BDOS error mode
 2Eh	get free space on disk
 2Fh	load, initialize, and jump to process (see also INT 21/AH=4Bh)
 30h	flush write-deferred buffers
 31h	get/set system variable (DOS Plus v2.1)
 32h	call BIOS (XIOS) character routine (see below)
 33h	set DMA address segment
 34h	get DMA buffer address
 35h	CP/M-86 allocate maximum memory
 36h	allocate maximum memory at specified segment
 37h	CP/M-86 allocate memory segment (see also INT 21/AH=48h)
 38h	allocate memory at specified segment
 39h	CP/M-86 free specified memory segment (see also INT 21/AH=49h)
 3Ah	CP/M-86 free all memory (not in DOS Plus v2.1)
 3Bh	load .CMD file into memory
 3Ch	(DOS Plus v2.1) call RSX program
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
 53h	get current time (see also INT 21/AH=2Ch)
 54h	set current time (see also INT 21/AH=2Dh)
 55h	get binary system date (see also INT 21/AH=2Ah)
 56h	set system date (see also INT 21/AH=2Bh)
 57h	allocate system flag
 58h	deallocate system flag
 59h	reserve memory in global area
 5Ah	lock physical drive
 5Bh	unlock physical drive
 5Ch	search path for executable file
 5Dh	load and execute command (see also INT 21/AH=4Bh)
 5Eh	get/set process exit code
 5Fh	set country information
 60h	get country information
 63h	truncate FCB file (see also INT 21/AH=28h)
 64h	create/update directory label
 65h	get directory label
 66h	get FCB date stamp and password mode
 67h	write extended FCB
 68h	set system date and time
 69h	get system date and time in binary
 6Ah	establish password for file access
 6Bh	get OS serial number
 6Ch	(DOS Plus v2.1) get/set program return code
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
 8Eh	call process dispatcher (yield CPU)
 8Fh	terminate calling process (same as function 00h)
 90h	create a process
 91h	set calling process' priority
 92h	attach to default console
 93h	detach from default console
 95h	assign default console to process
 96h	interpret and execute commandline
 97h	resident procedure library
 98h	parse ASCII string into FCB (see also INT 21/AH=29h)
 99h	return default console
 9Ah	get address of system data (SYSDAT)
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
 ADh	(DOS Plus v2.1) write block to default AUX
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
 BDh	(DR Multiuser DOS) delay
 FFh	return 80386 to native mode

Values for DOS Plus v2.1 XIOS functions:
 00h	terminate program
 01h	???
 02h	check for console input status
 03h	read character from console
 04h	write character to console
 05h	write character to list device
 06h	write character to auxiliary device
 07h	read cahracter from auxiliary device
 0Fh	get list device status
 10h-14h reserved
 15h	device initialization
 16h	check console output status
 17h-7Fh reserved
---BBC Acorn---
 80h	get XIOS version
 81h	get Tube semaphore
 82h	release Tube semaphore
 83h	select text/graphics
 84h	update B&W graphics rectangle
 85h	update color graphics rectangle
 86h	get/release/update mouse
 87h	get system error info
 88h	entry in CLOCK called by WatchDog RSP
 89h	BBC OSBYTE function
 8Ah	BBC OSWORD function

DR Multiuser DOS Error Return Codes:
 00h no error
 01h system call not implmented
 02h illegal system call number
 03h cannot find memory
 04h illegal flag number
 05h flag overrun
 06h flag underrun
 07h no unused Queue Descriptors
 08h no free queue buffer
 09h cannot find queue
 0Ah queue in use
 0Ch no free Process Descriptors
 0Dh no queue access
 0Eh empty queue
 0Fh full queue
 10h CLI queue missing
 11h no 8087 in system
 12h no unused Memory Descriptors
 13h illegal console number
 14h no Process Descriptor match
 15h no console match
 16h no CLI process
 17h illegal disk number
 18h illegal filename
 19h illegal filetype
 1Ah character not ready
 1Bh illegal Memory Descriptor
 1Ch bad return from BDOS load
 1Dh bad return from BDOS read
 1Eh bad return from BDOS open
 1Fh null command
 20h not owner of resource
 21h no CSEG in load file
 22h process Descriptor exists on Thread Root
 23h could not terminate process
 24h cannot attach to process
 25h illegal list device number
 26h illegal password
 28h external termination occurred
 29h fixup error upon load
 2Ah flag set ignored
 2Bh illegal auxilliary device number
--------O-E0----CL03-------------------------
INT E0 - DR Multiuser DOS - "A_READ" - READ CHARACTER FROM AUX DEVICE
	CL = 03h
Return:	AL = ASCII character
Notes:	A_READ reads the next 8-bit character from the logical auxilliary
	  input device (AUXn:); control is not returned to the calling
	  process until a character has been read. 
	if another process owns AUX, this call blocks until the device becomes
	  available
SeeAlso: INT 21/AH=03h,INT E0/CL=04h,INT E0/CL=07h,INT E0/CL=A5h,INT E0/CL=ACh
--------O-E0----CL04-------------------------
INT E0 - DR Multiuser DOS - "A_WRITE" - WRITE CHARACTER TO AUX DEVICE
	CL = 04h
	DL = ASCII character
Return:	nothing
Note:	if another process owns AUX, this call blocks until the device becomes
	  available
SeeAlso: INT 21/AH=04h,INT E0/CL=03h,INT E0/CL=08h,INT E0/CL=A5h,INT E0/CL=ADh
--------O-E0----CL07-------------------------
INT E0 - DR Multiuser DOS - "A_STATIN" - GET INPUT STATUS OF AUX DEVICE 
	CL = 07h
Return:	AL = status
	    00h not ready
	    FFh character available
SeeAlso: INT E0/CL=03h,INT E0/CL=08h
--------O-E0----CL08-------------------------
INT E0 - DR Multiuser DOS - "A_STATOUT" - GET OUTPUT STATUS OF AUX DEVICE
	CL = 08h
Return:	AL = status
	    00h not ready
	    FFh ready for output
SeeAlso: INT E0/CL=04h,INT E0/CL=07h
--------O-E0----CL59-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "S_MEMORY" - RESERVE MEMORY IN GLOBAL AREA
	CL = 59h
	DX = size in bytes
Return: AX = FFFFh if failed
	AX = other if successful
	    ES:BX -> reserved memory
--------O-E0----CL86-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "Q_MAKE" - CREATE MESSAGE QUEUE
	CL = 86h
	DS:DX -> queue descriptor (see below)
Return: AX = status
	    0000h success
	    FFFFh failure
	CX = error code
SeeAlso: INT E0/CL=87h

Format of queue descriptor:
Offset	Size	Description
 00h  2 WORDs	internal use, initialize to zeros
 04h	WORD	flags
 06h  8 BYTEs	queue name
 0Eh	WORD	length of message
 10h	WORD	number of messages
 12h  4 WORDs	internal use, initialize to zeros
 1Ah	WORD	offset in system area of buffer for messages
--------O-E0----CL87-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "Q_OPEN" - OPEN MESSAGE QUEUE
	CL = 87h
	DS:DX -> queue parameter block (see below)
Return: AX = status
	    0000h success
	    FFFFh failure
	CX = error code
SeeAlso: INT E0/CL=86h,INT E0/CL=89h

Format of queue parameter block:
Offset	Size	Description
 00h	WORD	internal use, initialize to zero
 02h	WORD	queue ID (set by INT E0/CL=87h)
 04h	WORD	internal use, initialize to zero
 06h	WORD	offset of queue message buffer
 08h  8 BYTEs	queue name
--------O-E0----CL89-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "Q_READ" - READ MESSAGE QUEUE
	CL = 89h
	DS:DX -> queue parameter block (see INT E0/CL=87h)
Return: AX = status
	    0000h success
	    FFFFh failure
	CX = error code
SeeAlso: INT E0/CL=87h,INT E0/CL=8Ah,INT E0/CL=8Bh
--------O-E0----CL8A-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "Q_CREAD" - CONDITIONALLY READ MSG QUEUE
	CL = 8Ah
	DS:DX -> queue parameter block (see INT E0/CL=87h)
Return: AX = status
	    0000h success
	    FFFFh failure
	CX = error code
SeeAlso: INT E0/CL=87h,INT E0/CL=89h,INT E0/CL=8Ch
--------O-E0----CL8B-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "Q_WRITE" - WRITE MESSAGE QUEUE
	CL = 8Bh
	DS:DX -> queue parameter block (see INT E0/CL=87h)
Return: AX = status
	    0000h success
	    FFFFh failure
	CX = error code
SeeAlso: INT E0/CL=89h,INT E0/CL=8Ch
--------O-E0----CL8C-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "Q_CWRITE" - CONDITIONALLY WRITE MSG QUEUE
	CL = 8Ch
	DS:DX -> queue parameter block (see INT E0/CL=87h)
Return: AX = status
	    0000h success
	    FFFFh failure
	CX = error code
SeeAlso: INT E0/CL=8Ah,INT E0/CL=8Bh
--------O-E0----CL8E-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "P_DISPATCH" - CALL DISPATCHER
	CL = 8Eh
	DX = FFFFh (optional) to force dispatch
Return: nothing
Note:	if DX=FFFFh, a dispatch is forced even if no other process is ready
SeeAlso: INT E0/CL=91h
--------O-E0----CL91-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "P_PRIORITY" - SET PROCESS PRIORITY
	CL = 91h
	DL = new priority (00h highest to FFh lowest)
Note:	sets priority of calling process; transient processes are initialized
	  to priority C8h
SeeAlso: INT E0/CL=8Eh
--------O-E0----CL93-------------------------
INT E0 - ConcCP/M,DR Multiuser DOS - "C_DETACH" - DETACH FROM DEFAULT CONSOLE
	CL = 93h
Return: AX = status
	    0000h successfully detached
	    FFFFh detach failed
--------O-E0----CLA5-------------------------
INT E0 - DR Multiuser DOS - "A_ATTACH" - ATTACH AUX DEVICE
	CL = A5h
Desc:	attaches the default auxiliary device to the calling process unless
	  it is already attached to another process, in which case the call
	  blocks until the device becomes available
Note:	this call should be used before attempting to read or write from
	  the AUX device; however, the I/O calls internally call this function
	  to ensure device ownership
SeeAlso: INT E0/CL=03h,INT E0/CL=04h,INT E0/CL=A6h,INT E0/CL=A7h,INT E0/CL=A8h
SeeAlso: INT E0/CL=ACh,INT E0/CL=ADh,INT E0/CL=B0h
--------O-E0----CLA6-------------------------
INT E0 - DR Multiuser DOS - "A_DETACH" - DETACH FROM AUX DEVICE
	CL = A6h
Return: AX = status
	    0000h successfully detached
	    FFFFh detach failed
	CX = error code
SeeAlso: INT E0/CL=A5h,INT E0/CL=A7h
--------O-E0----CLA7-------------------------
INT E0 - DR Multiuser DOS - "A_CATTACH" - CONDITIONALLY ATTACH TO AUX DEVICE
	CL = A7h
Return: AX = status
	    0000h attached
	    FFFFh unable to attach
Desc:	attaches the default auxiliary device to the calling process if it is
	  available
Note:	does not block if the device is already in use
SeeAlso: INT E0/CL=A5h,INT E0/CL=A6h,INT E0/CL=A8h,INT E0/CL=B0h
--------O-E0----CLA8-------------------------
INT E0 - DR Multiuser DOS - "A_SET" - SET DEFAULT AUX DEVICE NUMBER
	CL = A8h
	DL = auxiliary device number
Return: AX = status
	    0000h successful
	    FFFFh failed
	CX = error code
SeeAlso: INT E0/CL=A5h,INT E0/CL=A9h
--------O-E0----CLA9-------------------------
INT E0 - DR Multiuser DOS - "A_GET" - GET DEFAULT AUX DEVICE NUMBER
	CL = A9h
Return: AL = current default auxiliary device number
SeeAlso: INT E0/CL=A8h
--------O-E0----CLAC-------------------------
INT E0 - DR Multiuser DOS - "A_READBLK" - READ STRING FROM AUX DEVICE
	CL = ACh
	DS:DX -> character control block (CHCB) (see below)
Return: AX = number of characters read
Desc:	read characters from the default auxiliary (AUXn:) device into a buffer
	  until the buffer is full or the device is no longer ready
Notes:	if the device is initially not ready, blocks until at least one
	  character has been read
	if another process owns AUX, this call blocks until the device becomes
	  available
SeeAlso: INT E0/CL=03h,INT E0/CL=A5h,INT E0/CL=ADh

Format of character control block (CHCB):
Offset	Size	Description
 00h	DWORD	pointer to character buffer
 04h	WORD	length of character buffer
--------O-E0----CLAD-------------------------
INT E0 - DR Multiuser DOS - "A_WRITEBLK" - WRITE STRING TO AUX DEVICE
	CL = ADh
	DS:DX -> character control block (see INT E0/CL=ACh)
Return: AX = number of characters written
Note:	does not return until at least one character has been written
SeeAlso: INT E0/CL=04h,INT E0/CL=A5h,INT E0/CL=ACh
--------O-E0----CLB0-------------------------
INT E0 - DR Multiuser DOS - "A_CONFIG" - GET/SET AUX DEVICE PARAMETERS
	CL = B0h
	DX:DX -> AUX device parameter block (see below)
Return: AX = status
	    0000h successful
		parameter block updated
	    FFFFh failed
		CX = error code
SeeAlso: INT E0/CL=A5h,INT E0/CL=B1h

Format of AUX device parameter block:
Offset	Size	Description
 00h	BYTE	function (00h get, 01h set)
 01h	BYTE	baud rate (see below) FFh = don't change/unknown
 02h	BYTE	parity (see below)
 03h	BYTE	stop bits (00h one, 01h 1.5, 02h two, FFh unknown/don't change)
 04h	BYTE	data bits (05h-08h or FFh unknown/don't change)
 05h	BYTE	handshake (00h none, 01h DTS/DSR, 02h RTS/CTS, 04h XON/XOFF,
		FFh unknown/don't change)
 06h	BYTE	XON character, FFh unknown/don't change
 07h	BYTE	XOFF character, FFh unknown/don't change

Values for parity:
 00h none
 01h odd
 02h none
 03h even
 04h stick parity bit
 FFh don't change/unknown

Values for baud rate:
 00h = 50 baud
 01h = 62.5 baud
 02h = 75 baud
 03h = 110 baud
 04h = 134.5 baud
 05h = 150 baud
 06h = 200 baud
 07h = 300 baud
 08h = 600 baud
 09h = 1200 baud
 0Ah = 1800 baud
 0Bh = 2000 baud
 0Ch = 2400 baud
 0Dh = 3600 baud
 0Eh = 4800 baud
 0Fh = 7200 baud
 10h = 9600 baud
 11h = 19200 baud
 12h = 38400 baud
 13h = 56000 baud
 14h = 76800 baud
 15h = 115200 baud
--------O-E0----CLB1-------------------------
INT E0 - DR Multiuser DOS - "A_CONTROL" - GET/SET AUX CONTROL PARAMETERS
	CL = B1h
	DS:DX -> AUX device control block (see below)
Return: AX = status
	    0000h successful
		control block updated
	    FFFFh failed
		CX = error code
SeeAlso: INT E0/CL=B0h,INT E0/CL=B2h

Format of AUX device control block:
Offset	Size	Description
 00h	BYTE	function (00h get, 01h set)
 01h	BYTE	DTR state (00h low, 01h high, FFh unknown/don't change)
 02h	BYTE	RTS state (00h low, 01h high, FFh unknown/don't change)
 03h	BYTE	DSR state (00h low, 01h high, FFh unknown/don't change)
 04h	BYTE	CTS state (00h low, 01h high, FFh unknown/don't change)
 05h	BYTE	DCD state (00h low, 01h high, FFh unknown/don't change)
 06h	BYTE	RI state (00h inactive, 01h active, FFh unknown/don't change)
--------O-E0----CLB2-------------------------
INT E0 - DR Multiuser DOS - "A_BREAK" - SEND BREAK TO AUX DEVICE
	CL = B2h
	DX = duration of break in system ticks (0001h-FFFFh)
Return: AX = status
	    0000h successful
		break signal completed
	    FFFFh failed
		CX = error code
Note:	if the AUX device is currently owned by another process, this call will
	  block until the device becomes available
SeeAlso: INT E0/CL=A5h,INT E0/CL=B1h
--------O-E0----CLBD-------------------------
INT E0 - DR Multiuser DOS - "P_DELAY" - DELAY EXECUTION
	CL = BDh
	DX = delay in system ticks
Return: after the delay elapses
Notes:	the length of a system tick is installation-dependent (typically
	  1/50 or 1/60 second); the length may be determined by reading the
	  TICKSPERSEC value from the system data segment
	the actual delay before the process is rescheduled to run may be up to
	  one tick longer than requested; the delay between rescheduling and
	  actual execution cannot be predicted if higher-priority processes
	  are awaiting a turn at the CPU
SeeAlso: INT 15/AH=86h,INT 1A/AX=FF01h,INT 2F/AX=1224h,INT 62/AX=0096h
--------r-E1---------------------------------
INT E1 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------N-E1---------------------------------
INT E1 - PC Cluster Disk Server Information
SeeAlso: INT E2
--------r-E2---------------------------------
INT E2 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------N-E2---------------------------------
INT E2 - PC Cluster Program
--------r-E3---------------------------------
INT E3 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-E40005-----------------------------
INT E4 - Logitech Modula v2.0 - MonitorEntry
	AX = 0005h
	BX = priority
SeeAlso: AX=0006h
--------r-E40006-----------------------------
INT E4 - Logitech Modula v2.0 - MonitorExit
	AX = 0006h
SeeAlso: AX=0005h
--------r-E4---------------------------------
INT E4 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-E5---------------------------------
INT E5 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-E6---------------------------------
INT E6 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-E7---------------------------------
INT E7 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-E8---------------------------------
INT E8 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-E9---------------------------------
INT E9 - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-EA---------------------------------
INT EA - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-EB---------------------------------
INT EB - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------r-EC---------------------------------
INT EC - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC
	BASIC.COM/BASICA.COM do not restore vector on termination
--------N-EC---------------------------------
INT EC - used by Alloy NTNX
--------r-EC---------------------------------
INT EC - Exact - RUNTIME INTERFACE MULTIPLEXOR
	AX = function number (0000h to 0140h)
	STACK:	DWORD address to return to
		any arguments required by function
Return: STACK:	return address popped, but otherwise unchanged
Desc:	this is the interface from applications to the runtime system by Exact
	  Automatisering B.V. of the Netherlands.  By using this interrupt,
	  it can provide DLL-style capabilities under MS-DOS.
Note:	the interrupt handler removes the return address and flags placed on
	  the stack by the INT EC, then jumps to the appropriate function
--------r-ED---------------------------------
INT ED - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
	INT 80 through INT ED are modified but not restored by Direct Access
	  v4.0, and may be left dangling by other programs written with the
	  same version of compiled BASIC
SeeAlso: INT EC"BASIC",INT EE"BASIC"
--------r-EE---------------------------------
INT EE - IBM ROM BASIC - used while in interpreter
Notes:	called by ROM BASIC, but pointed at IRET by BASIC.COM/BASICA.COM
	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT ED"BASIC",INT EE"BASIC"
--------r-EF---------------------------------
INT EF - BASIC - ORIGINAL INT 09 VECTOR
Note:	BASIC.COM/BASICA.COM do not restore vector on termination
SeeAlso: INT EE"BASIC",INT F0"BASIC"
--------O-EF----CX0473-----------------------
INT EF - GEM - INTERFACE
	CX = 0473h
	DS:DX -> GEM parameter block
--------r-F0---------------------------------
INT F0 - BASICA.COM, GWBASIC, compiled BASIC - ORIGINAL INT 08 VECTOR
Note:	BASICA.COM does not restore vector on termination
SeeAlso: INT EF"BASIC"
--------*-F1---------------------------------
INT F1 - reserved for user interrupt
--------s-F1---------------------------------
INT F1 - SPEECH.COM - CONVERT TEXT STRING TO SPEECH
	DS:BX -> '$'-terminated text string
Program: SPEECH.COM is a resident text-to-speech converter by Douglas Sisco
--------s-F1---------------------------------
INT F1 - Andy C. McGuire SPEECH.COM/SAY.COM
SeeAlso: INT F2"SPEECH"
--------U-F1---------------------------------
INT F1 - AQUEDUCT, PIPELINE - GET DATA AREA ADDRESS
Return: AX:BX -> data area
Program: AQUEDUCT and PIPELINE are TSRs by James W. Birdsall to connect COM1
	  and COM2 in software
Note:	The installation check consists of testing for the following signature
	  immediately preceding the interrupt handler: "JWBtvv" where 't' is
	  either "A" for AQUEDUCT or "P" for PIPELINE and "vv" is a two-digit
	  version number
Index:	installation check;AQUEDUCT|installation check;PIPELINE
--------*-F2---------------------------------
INT F2 - reserved for user interrupt
--------s-F2---------------------------------
INT F2 - Andy C. McGuire SPEECH.COM/SAY.COM
SeeAlso: INT F1"SPEECH"
----------F2---------------------------------
INT F2 - ICCTSR 1.0 - ImageCapture COLOR Developer's Kit - API
	AH = function
	    01h power up
	    02h power down
	    03h set controls
	    04h capture image
	    05h display image
	    06h read file
	    07h write file
	    08h write array
	    09h read pixel
	    0Ah write pixel
	    0Bh check if VGA present
	    0Ch set video mode
	    0Dh check for keystroke
	    0Eh delay
	???
Return: ???
Program: ImageCapture is a product of International Computers
SeeAlso: INT F3"ICCTSR"
--------*-F3---------------------------------
INT F3 - reserved for user interrupt
--------s-F3---------------------------------
INT F3 - SoundBlaster - POINTER TO ECHO VALUE
Note:	this is not a vector, but a pointer to a DWORD containing the echo
	  value selected with SET-ECHO.EXE
SeeAlso: INT 2F/AX=FBFBh
----------F3---------------------------------
INT F3 - ICCTSR 1.0 - HANDSHAKE ID VECTOR
Program: ImageCapture is a product of International Computers
SeeAlso: INT F2"ICCTSR"
--------*-F4---------------------------------
INT F4 - reserved for user interrupt
--------T-F4---------------------------------
INT F4 - DoubleDOS - GIVE UP REST OF CURRENT CLOCK TICK AND ALL OF NEXT TICK
SeeAlso: INT 21/AH=EEh"DoubleDOS",INT FE"DoubleDOS"
--------*-F5---------------------------------
INT F5 - reserved for user interrupt
--------T-F5---------------------------------
INT F5 - DoubleDOS - ???
--------*-F6---------------------------------
INT F6 - reserved for user interrupt
--------T-F6---------------------------------
INT F6 - DoubleDOS - ???
--------*-F7---------------------------------
INT F7 - reserved for user interrupt
--------T-F7---------------------------------
INT F7 - DoubleDOS - ???
----------F700-------------------------------
INT F7 - FSBBS 2.0 - CONFIGURATION RECORD
	AH = 00h
	AL = function
	    00h get configuration record
		Return: DS:DX -> configuration record
	    01h set configuration record
	    02h get path for option
		DS:DX -> option name
		Return: DS:DX -> path
	    03h determine whether configuration record set
		Return: AX = status
			    0000h set
			    0001h not yet set
	    04h get link state
		Return: AX = state
			    0000h unlinked
			    0001h linked
Notes:	this information is preliminary and still subject to change
	all of the INT F7 calls for FSBBS are used for interprogram
	  communication between the BBS kernel and the programs it spawns
SeeAlso: AH=01h
----------F701-------------------------------
INT F7 - FSBBS 2.0 - USER RECORD
	AH = 01h
	AL = function
	    00h get user record for user currently online
		Return: DS:DX -> user record
	    01h set user record
		DS:DX -> user record
SeeAlso: AH=00h,AH=02h
----------F702-------------------------------
INT F7 - FSBBS 2.0 - GET ACCOUNT NAME
	AH = 02h
Return: DS:DX -> 8-character blank-padded account name
SeeAlso: AH=01h
----------F703-------------------------------
INT F7 - FSBBS 2.0 - TERMINAL NUMBER
	AH = 03h
	AL = function
	    00h get terminal index number
		Return: DX = index number
	    01h set terminal index number
		DX = terminal index
----------F704-------------------------------
INT F7 - FSBBS 2.0 - PASSDATA BUFFER
	AH = 04h
	AL = function
	    00h get PassData buffer contents
		DS:DX -> buffer for PassData contents
	    01h set PassData contents
		DS:DX -> buffer containing new PassData
		CH = length of data in buffer
----------F705-------------------------------
INT F7 - FSBBS 2.0 - TIMER FUNCTIONS
	AH = 05h
	AL = function
	    00h get time remaining
		Return: DX = number of minutes remaining
	    01h get current time
		Return: DS:DX -> 8-character time string
	    02h increment time
		DX = number of additional minutes
	    03h decrement time
		DX = number of minutes
SeeAlso: AH=06h
----------F706-------------------------------
INT F7 - FSBBS 2.0 - FUNCTION AVAILABILITY
	AH = 06h
	AL = function
	    00h determine whether function is available
		DX = index of function
	    01h set function availability
		DX = index of function
		???
SeeAlso: AH=05h,AH=07h
----------F707-------------------------------
INT F7 - FSBBS 2.0 - DUMP FUNCTIONS
	AH = 07h
	AL = function
	    00h get current dump mode
		Return: DL = mode
	    01h set dump mode
		DL = mode
SeeAlso: AH=06h
--------*-F8---------------------------------
INT F8 - reserved for user interrupt
--------h-F8---------------------------------
INT F8 - TANDY??? - 100 HZ INTERRUPT
SeeAlso: INT FA"USART"
--------T-F8---------------------------------
INT F8 - DoubleDOS - ???
--------*-F9---------------------------------
INT F9 - reserved for user interrupt
--------T-F9---------------------------------
INT F9 - DoubleDOS - ???
--------*-FA---------------------------------
INT FA - reserved for user interrupt
--------h-FA---------------------------------
INT FA - TANDY??? - SERIAL PORT USART INTERRUPT
SeeAlso: INT F8"100 HZ",INT FB"USART"
--------T-FA---------------------------------
INT FA - DoubleDOS - TURN OFF TIMESHARING
SeeAlso: INT 21/AH=EAh"DoubleDOS",INT FB"DoubleDOS"
--------*-FB---------------------------------
INT FB - reserved for user interrupt
--------h-FB---------------------------------
INT FB - TANDY??? - KEYBOARD USART RECEIVE INTERRUPT
SeeAlso: INT FA"USART"
--------T-FB---------------------------------
INT FB - DoubleDOS - TURN ON TIMESHARING
SeeAlso: INT 21/AH=EBh"DoubleDOS",INT FA"DoubleDOS"
--------*-FC---------------------------------
INT FC - reserved for user interrupt
--------T-FC---------------------------------
INT FC - DoubleDOS - GET CURRENT SCREEN BUFFER ADDRESS
Return: ES = segment of display buffer
Desc:	determine the address of the virtual screen to which the program
	  should write instead of the actual video memory, so that the
	  multitasked programs do not interfere with each other's output
Note:	the display buffer may be moved if multitasking is enabled
SeeAlso: INT 21/AH=ECh"DoubleDOS",INT FB"DoubleDOS"
--------*-FD---------------------------------
INT FD - reserved for user interrupt
--------T-FD---------------------------------
INT FD - DoubleDOS - ???
----------FE---------------------------------
INT FE - AT/XT286/PS50+ - destroyed by return from protected mode
Note:	the ROM BIOS uses 0030h:0100h as the initial stack on startup, which
	  is the last fourth of the interrupt vector table.  If the processor
	  is returned to real mode via a hardware reset (the only possibility
	  on an 80286, though there are a number of ways of generating one),
	  then the BIOS startup code stacks three words on its scratch stack
	  before determining that a return to real mode has been requested.
	  As a result, INT FE and INT FF are corrupted.
SeeAlso: INT FF"XT286"
--------T-FE---------------------------------
INT FE - DoubleDOS - GIVE UP TIME
	AL = number of 55ms time slices to give away
Return: after other program (if active) has run
SeeAlso: INT 21/AH=EEh"DoubleDOS",INT F4"DoubleDOS"
--------G-FE---------------------------------
INT FE - Turbo Debugger 8086 v2.5+ - OVERLAY MANAGER
SeeAlso: INT 3F
----------FF---------------------------------
INT FF - AT/XT286/PS50+ - destroyed by return from protected mode
Note:	(see INT FE"XT286")
SeeAlso: INT FE"XT286"
--------b-FF---------------------------------
INT FF - Z100 - WARM BOOT
SeeAlso: INT 40"Z100"
--------Q-FF---------------------------------
INT FF U - QEMM-386.SYS v6.0+ - internal
Note:	requires that a byte in the conventional-memory stub be set to the
	  desired function number (00h through 0Ch)
---------------------------------------------
Please redistribute the following files unmodified as a group, in a pair of
archives named INTER34A and INTER34B (preferably the original authenticated
PKZIP archives):
	INTERRUP.1ST	the read-me file, containing credits, availability info
	INTERRUP.A	INT 00 through INT 14
	INTERRUP.B	INT 15 through INT 1A
	INTERRUP.C	INT 1B through INT 21/5E
	INTERRUP.D	INT 21/5F through INT 27
	INTERRUP.E	INT 28 through INT 2F/BF
	INTERRUP.F	INT 2F/C0 through INT 4F
	INTERRUP.G	INT 50 through INT 67
	INTERRUP.H	INT 68 through INT FF
	INTERRUP.PRI	a brief introduction to interrupts
	INTPRINT.COM	a simple formatter that also generates a list summary
	INTPRINT.DOC	instructions for INTPRINT
	GLOSSARY.LST	a glossary of terms, abbreviations, and acronyms
	MEMORY.LST	format of the BIOS data area
	COMBINE.BAT	combine the piece of the list into a single file
The following files should be distributed in an archive called INTER34C:
	INT.COM		invoke interrupts from commandline
	INT2HLP.BAT	Perl script to convert list into QuickHelp database
	INT2GUID.*	convert list into TurboPower GUIDE or POPHELP database
	INT2QH.*	program to convert list into QuickHelp database
	INTERVUE.EXE	indexed interrupt list browser
	INTHELP.*	convert list into TurboPower GUIDE database
	INTLIST.E	Epsilon extension for handling list
	INTLIST.ICO	Windows icon for INTERVUE
	INTPRINT.C	source code for INTPRINT
	RB2NG.*		convert list into Norton Guides database
This compilation is Copyright (c) 1989,1990,1991,1992,1993 Ralf Brown
---------------------------------------------
ARPA: ralf@cs.cmu.edu
UUCP: {ucbvax,harvard}!cs.cmu.edu!ralf
BIT:  ralf%cs.cmu.edu@carnegie
FIDO: Ralf Brown 1:129/26.1
	or post a message to me in the DR_DEBUG echo (I probably won't see it
	unless you address it to me)
CIS:  >INTERNET:ralf@cs.cmu.edu
