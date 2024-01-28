Interrupt List, part 7 of 15
Copyright (c) 1989,1990,1991,1992,1993,1994,1995,1996 Ralf Brown
--------E-21E3-------------------------------
INT 21 - OS/286, OS/386 - ISSUE REAL INTERRUPT
	AH = E3h
	AL = interrupt number
	???
Return: ???
Note:	protected mode only???
SeeAlso: AH=E1h"OS/286",INT 31/AX=0300h
--------T-21E3-------------------------------
INT 21 - DoubleDOS - ADD CHARACTER TO KEYBOARD BUFFER OF CURRENT JOB
	AH = E3h
	AL = character
Return: AL = status
	    00h successful
	    01h buffer full (128 characters)
SeeAlso: AH=E1h"DoubleDOS",AH=E2h"DoubleDOS",AH=E8h"DoubleDOS"
SeeAlso: AH=F3h"DoubleDOS"
--------N-21E3-------------------------------
INT 21 - Novell NetWare - CONNECTION CONTROL
	AH = E3h
	DS:SI -> request buffer (see #1179)
	ES:DI -> reply buffer (see #1180)
Return: AL = status
	    00h successful
	    else error code
Note:	supported by NetWare 4.0+, Advanced NetWare 1.0+, and Alloy NTNX
SeeAlso: AH=E3h/SF=0Ah,AH=E3h/SF=32h,AH=E3h/SF=64h,AH=E3h/SF=C8h

Format of NetWare request buffer:
Offset	Size	Description	(Table 1179)
 00h	WORD	length of following data
 02h	BYTE	subfunction number (see also AH=E3h/SF=01h,AH=E3h/SF=02h)
		00h login
		03h map object to number
		04h map number to object
		05h get station's logged information
		06h get station's root mask (obsolete)
		07h map group name to number
		08h map number to group name
		09h get memberset M of group G
	var	depends on subfunction
Notes:	the above subfunctions are not described in _NetWare_System_Calls--DOS_
	see separate entries below for other subfunctions
SeeAlso: #1180,#1181,#1184

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1180)
 00h	WORD	(call) length of following buffer space for results
	var	depends on subfunction
SeeAlso: #1179

Format of NetWare object property:
Offset	Size	Description	(Table 1181)
 00h 1-16 BYTEs property name (see also #1182)
  N	BYTE	flags
		bit 0: property is dynamic
		bit 1: property is a set rather than an item
 N+1	BYTE	security levels (see #1183)
	???

(Table 1182)
Values for names of well-known NetWare properties:
 ACCOUNT_BALANCE
 ACCOUNT_SERVERS
 GROUP_MEMBERS
 GROUPS_I'M_IN
 IDENTIFICATION		user's name
 LOGIN_CONTROL
 NET_ADDRESS
 OPERATORS
 PASSWORD
 SECURITY_EQUALS

(Table 1183)
Values for NetWare security levels:
 00h	"anyone" everyone may access
 01h	"logged" only logged-in clients may access
 02h	"object" only clients logged-in with object's name, type, and password
 03h	"supervisor" only clients logged-in with supervisor privileges
 04h	"NetWare" only NetWare may access
Note:	the above values are stored in a nybble; the high half-byte is write
	  access and the low half-byte is read access

(Table 1184)
Values for NetWare object type:
 0000h	unknown
 0001h	user
 0002h	user group
 0003h	print queue
 0004h	file server
 0005h	job server
 0006h	gateway
 0007h	print server
 0008h	archive queue
 0009h	archive server
 000Ah	job queue
 000Bh	administration
 0021h	NAS SNA gateway
 0026h	remote bridge server
 0027h	TCPIP gateway
 002Dh	time synchronization server
 002Eh	archive server dynamic SAP
 0047h	advertising print server
 0053h	print queue uwer
 0048h-8000h reserved
 FFFFh	wild (used only for finding objects)
--------N-21E3--SF01-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - CHANGE USER PASSWORD (OLD)
	AH = E3h subfn 01h
	DS:SI -> request buffer (see #1185)
	ES:DI -> reply buffer (see #1189)
Return: AL = status
	    00h successful
	    else error code
Note:	supported by NetWare 4.0+, Advanced NetWare 1.0+, and Alloy NTNX
SeeAlso: AH=E3h/SF=0Ah,AH=E3h/SF=32h,AH=E3h/SF=64h,AH=E3h/SF=C8h

Format of NetWare "Change User Password (old)" request packet:
Offset	Size	Description	(Table 1185)
 00h	WORD	length of following data
 02h	BYTE	01h (subfunction "Change User Password (old)")
 03h	BYTE	length of user name
 04h  N BYTEs	user name
	BYTE	length of old password
      N BYTEs	old password
	BYTE	length of new password
      N BYTEs	new password
SeeAlso: #1189
--------N-21E3--SF02-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - CHANGE USER PASSWORD (OLD)
	AH = E3h subfn 02h
	DS:SI -> request buffer (see #1186)
	ES:DI -> reply buffer (see #1187)
Return: AL = status
	    00h successful
	    else error code
Note:	supported by NetWare 4.0+, Advanced NetWare 1.0+, and Alloy NTNX
SeeAlso: AH=E3h/SF=01h,AH=E3h/SF=03h,AH=E3h/SF=0Ah

Format of NetWare "Get User Connection List (old)" request packet:
Offset	Size	Description	(Table 1186)
 00h	WORD	length of following data
 02h	BYTE	02h (subfunction "Get User Connection List (old)")
 03h	BYTE	length of user name
 04h  N BYTEs	user name
SeeAlso: #1187,#1458

Format of NetWare "Get User Connection List (old)" reply packet:
Offset	Size	Description	(Table 1187)
 00h	WORD	(call) length of following buffer
 02h	BYTE	length of connection list
 03h	BYTE	number of bytes in connection list
 04h  N BYTEs	list of connection numbers in use by user
SeeAlso: #1186,#1458
--------N-21E3--SF0A-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - ENTER LOGIN AREA
	AH = E3h subfn 0Ah
	DS:SI -> request buffer (see #1188)
	ES:DI -> reply buffer (see #1189)
Return: AL = status
	    00h successful
Desc:	change the login directory for the calling workstation
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=D7h,AH=E3h/SF=14h

Format of NetWare "Enter Login Area" request buffer:
Offset	Size	Description	(Table 1188)
 00h	WORD	length of following data (max 102h)
 02h	BYTE	0Ah (subfunction "Enter Login Area")
 03h	BYTE	number of local drives
 04h	BYTE	length of subdirectory name (00h-FFh)
 05h  N BYTEs	name of subdirectory under SYS:LOGIN where to find the login
		  utility
SeeAlso: #1189

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1189)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1185,#1188,#1192
--------N-21E3--SF0C-------------------------
INT 21 U - Novell NetWare - VERIFY NETWORK SERIAL NUMBER
	AH = E3h subfn 0Ch
	DS:SI -> request buffer (see #1190)
	ES:DI -> reply buffer (see #1191)
Return: AL = status
	    00h successful
Note:	if the network serial number to be verified is correct, the reply
	  buffer will contain the corresponding application number
SeeAlso: AH=E3h/SF=12h,AX=F217h/SF=0Ch

Format of NetWare "Verify Network Serial Number" request buffer:
Offset	Size	Description	(Table 1190)
 00h	WORD	0005h (length of following data)
 02h	BYTE	0Ch (subfunction "Verify Network Serial Number")
 03h	DWORD	(big-endian) network serial number to verify
SeeAlso: #1191,#1459

Format of NetWare "Verify Network Serial Number" reply buffer:
Offset	Size	Description	(Table 1191)
 00h	WORD	(call) 0002h (size of following results buffer)
 02h	WORD	(big-endian) application number
SeeAlso: #1190,#1459
--------N-21E3--SF0D-------------------------
INT 21 - Novell NetWare - MESSAGE SERVICES - LOG NETWORK MESSAGE
	AH = E3h subfn 0Dh
	DS:SI -> request buffer (see #1192)
	ES:DI -> reply buffer (see #1189)
Return: AL = status
	    00h successful
Desc:	append a line to the default file server's NET$LOG.MSG file
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E1h/SF=09h

Format of NetWare "Log Network Message" request buffer:
Offset	Size	Description	(Table 1192)
 00h	WORD	length of following data (max 52h)
 02h	BYTE	0Dh (subfunction "Log Network Message")
 03h	BYTE	length of message (01h-50h)
 04h  N BYTEs	message (no control characters or characters > 7Eh)
SeeAlso: #1189
--------N-21E3--SF0E-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET DISK UTILIZATION
	AH = E3h subfn 0Eh
	DS:SI -> request buffer (see #1194)
	ES:DI -> reply buffer (see #1195)
Return: AL = status (00h,98h,F2h) (see #1193)
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must have bindery object read privileges
SeeAlso: AH=E3h/SF=11h,AH=E3h/SF=D6h,AH=E3h/SF=D9h,AH=E3h/SF=E6h,AH=E3h/SF=E9h
SeeAlso: AX=F217h/SF=0Eh

(Table 1193)
Values for NetWare function status:
 00h	successful
 98h	nonexistent volume
 F2h	not permitted to read object
SeeAlso: #1160,#1196

Format of NetWare "Get Disk Utilization" request buffer:
Offset	Size	Description	(Table 1194)
 00h	WORD	0005h (length of following data)
 02h	BYTE	0Eh (subfunction "Get Disk Utilization")
 03h	BYTE	volume number (00h-1Fh)
 04h	DWORD	(big-endian) object ID
SeeAlso: #1195,#1460

Format of NetWare "Get Disk Utilization" reply buffer:
Offset	Size	Description	(Table 1195)
 00h	WORD	(call) 000Bh (size of following results buffer)
 02h	BYTE	volume number (00h-1Fh)
 03h	DWORD	(big-endian) object ID
 07h	WORD	(big-endian) directories used by object
 09h	WORD	(big-endian) files created by object
 0Bh	WORD	(big-endian) disk blocks used by object-created files
SeeAlso: #1194,#1460
--------N-21E3--SF0F-------------------------
INT 21 - Novell NetWare - FILE SERVICES - SCAN FILE INFORMATION
	AH = E3h subfn 0Fh
	DS:SI -> request buffer (see #1197)
	ES:DI -> reply buffer (see #1198)
Return: AL = status (see #1196)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=B6h,AH=E3h/SF=10h,AX=F217h/SF=0Fh

(Table 1196)
Values for NetWare function status:
 00h	successful
 89h	not permitted to search directory
 FFh	no more matching files
SeeAlso: #1193,#1214

Format of NetWare "Scan File Information" request buffer:
Offset	Size	Description	(Table 1197)
 00h	WORD	length of following data (max 105h)
 02h	BYTE	0Fh (subfunction "Scan File Information")
 03h	WORD	(big-endian) sequence number
		FFFFh on first call
 05h	BYTE	directory handle or 00h
 06h	BYTE	search attributes (see #0731 at AX=4301h)
 07h	BYTE	length of filespec
 08h  N BYTEs	ASCIZ uppercase filespec
SeeAlso: #1198,#1461

Format of NetWare "Scan File Information" reply buffer:
Offset	Size	Description	(Table 1198)
 00h	WORD	(call) 005Eh (size of following results buffer)
 02h	WORD	next sequence number (place in request buffer for next call)
 04h 14 BYTEs	ASCIZ filename
 12h	BYTE	file attributes (see #0731 at AX=4301h)
 13h	BYTE	extended file attributes (see #1098 at AH=B6h)
 14h	DWORD	(big-endian) file size in bytes
 18h	WORD	(big-endian) file's creation date (see #0972 at AX=5700h)
 1Ah	WORD	(big-endian) date of last access (see #0971 at AX=5700h)
 1Ch	DWORD	(big-endian) date and time of last update (see #1140)
 20h	DWORD	(big-endian) object ID of owner
 24h	DWORD	(big-endian) date and time last archived (see #1140)
 28h 55 BYTEs	reserved
Note:	the official documentation erroneously lists the field at offset 04h as
	  15 bytes and thus shifts the remaining fields by one byte
SeeAlso: #1197,#1461
--------N-21E3--SF10-------------------------
INT 21 - Novell NetWare - FILE SERVICES - SET FILE INFORMATION
	AH = E3h subfn 10h
	DS:SI -> request buffer (see #1199)
	ES:DI -> reply buffer (see #1200)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the caller must have modify privileges on the directory containing the
	  file
SeeAlso: AH=B6h,AH=E3h/SF=0Fh,AX=F217h/SF=10h

Format of NetWare "Set File Information" request buffer:
Offset	Size	Description	(Table 1199)
 00h	WORD	length of following data (max 151h)
 02h	BYTE	10h (subfunction "Set File Information")
 03h	BYTE	file attributes (see #0731 at AX=4301h)
 04h	BYTE	extended file attributes (see #1098 at AH=B6h)
 05h  4 BYTEs	reserved
 09h	WORD	(big-endian) file's creation date (see #0972 at AX=5700h)
 0Bh	WORD	(big-endian) date of last access (see #0971 at AX=5700h)
 0Dh	DWORD	(big-endian) date and time of last update (see #1140)
 11h	DWORD	(big-endian) object ID of owner
 15h	DWORD	(big-endian) date and time last archived (see #1140)
 19h 56 BYTEs	reserved
 51h	BYTE	directory handle or 00h
 52h	BYTE	search attributes (see #0731 at AX=4301h)
 53h	BYTE	length of filename
 54h  N BYTEs	filename
SeeAlso: #1200

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1200)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1199
--------N-21E3--SF11-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER INFORMATION
	AH = E3h subfn 11h
	DS:SI -> request buffer (see #1201)
	ES:DI -> reply buffer (see #1202)
Return: AL = status
	    00h successful
Desc:	determine the version of software installed on the file server and
	  how it is configured
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=0Eh,AE3h/SF=12h,AH=E3h/SF=CDh,AH=E3h/SF=D3h,AH=E3h/SF=E7h
SeeAlso: AH=E7h,AX=F217h/SF=11h

Format of NetWare "Get File Server Information" request buffer:
Offset	Size	Description	(Table 1201)
 00h	WORD	0001h (length of following data)
 02h	BYTE	11h (subfunction "Get File Server Information")
SeeAlso: #1202,#1462 at AX=F217h/SF=11h

Format of NetWare "Get File Server Information" reply buffer:
Offset	Size	Description	(Table 1202)
 00h	WORD	(call) 0080h (size of following results buffer)
 02h 48 BYTEs	server's name
 32h	BYTE	NetWare version
 33h	BYTE	NetWare subversion (0-99)
 34h	WORD	(big-endian) number of connections supported
		NetWare 4.01 reportedly returns maximum simulataneously-used
		  connections
 36h	WORD	(big-endian) number of connections in use
 38h	WORD	(big-endian) maximum connected volumes
---Advanced NetWare 2.1+ ---
 3Ah	BYTE	operating system revision number
 3Bh	BYTE	fault tolerance (SFT) level
 3Ch	BYTE	TTS level
 3Dh	WORD	(big-endian) maximum simultaneously-used connections
		NetWare 4.01 reportedly returns number of connections in use
 3Fh	BYTE	accounting version
 40h	BYTE	VAP version
 41h	BYTE	queueing version
 42h	BYTE	print server version
 43h	BYTE	virtual console version
 44h	BYTE	security restrictions level
 45h	BYTE	internetwork bridge version
 46h 60 BYTEs	reserved
SeeAlso: #1201,#1462
--------N-21E3--SF12-------------------------
INT 21 - Novell NetWare - GET NETWORK SERIAL NUMBER
	AH = E3h subfn 12h
	AL = 00h
	BX = CX = DX = 0000h
	DS:SI -> request buffer (see #1203)
	ES:DI -> reply buffer (see #1204)
Return: AL = status
	    00h successful
Desc:	return the serial number and application number for the software
	  installed on the file server
Notes:	this function is supported by Advanced NetWare 2.1+
	reportedly, the workstation crashes if AL,BX,CX, and DX are not all
	  zero
SeeAlso: AH=E3h/SF=0Ch,AH=E3h/SF=11h,AX=F217h/SF=12h

Format of NetWare "Get Serial Number" request buffer:
offset	 size	description	(Table 1203)
 00h	 WORD	0001h (length of following data)
 02h	 BYTE	12h (subfunction "Get Serial Number")
SeeAlso: #1204,#1463

Format of NetWare "Get Serial Number" reply buffer:
offset	 size	description	(Table 1204)
 00h	 WORD	(call) 0006h (size of following results buffer)
 02h   4 BYTEs	(big-endian) NetWare server serial number
 06h   2 BYTEs	(big-endian) NetWare application serial number
SeeAlso: #1203,#1463
--------N-21E3--SF13-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - GET INTERNET ADDRESS (OLD)
	AH = E3h subfn 13h
	DS:SI -> request buffer (see #1205)
	ES:DI -> reply buffer (see #1206)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=DCh"NetWare",AH=E3h/SF=16h,AH=EEh"NetWare",AX=F217h/SF=13h

Format of NetWare "Get Internet Address (old)" request buffer:
Offset	Size	Description	(Table 1205)
 00h	WORD	0002h (length of following data)
 02h	BYTE	13h (subfunction "Get Internet Address")
 03h	BYTE	logical connection number (01h-64h)
SeeAlso: #1206,#1464

Format of NetWare "Get Internet Address (old)" reply buffer:
Offset	Size	Description	(Table 1206)
 00h	WORD	(call) 000Ch (length of following results buffer)
 02h  4 BYTEs	network number
 06h  6 BYTEs	physical node address
 0Ch  2 BYTEs	socket number
SeeAlso: #1205,#1464 at AX=F217h/SF=13h
--------N-21E3--SF14-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - LOGIN TO FILE SERVER
	AH = E3h subfn 14h
	DS:SI -> request buffer (see #1207)
	ES:DI -> reply buffer (see #1208)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=D7h"NetWare",AH=F1h"NetWare",AX=F217h/SF=14h

Format of NetWare "Login to File Server" request buffer:
Offset	Size	Description	(Table 1207)
 00h	WORD	length of following data (max B3h)
 02h	BYTE	14h (subfunction "Login To File Server")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
	BYTE	length of password
      N BYTEs	password
SeeAlso: #1208

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1208)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1207
--------N-21E3--SF15-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - GET OBJECT CONNECTION LIST(OLD)
	AH = E3h subfn 15h
	DS:SI -> request buffer (see #1209)
	ES:DI -> reply buffer (see #1210)
Return: AL = status
	    00h successful
Desc:	this function retrieves a list indicating the connection numbers under
	  which a bindery object is logged into the default file server
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=DCh"NetWare",AH=E3h/SF=16h,AX=F217h/SF=15h

Format of NetWare "Get Object Connection Numbers" request buffer:
Offset	Size	Description	(Table 1209)
 00h	WORD	length of following data (max 33h)
 02h	BYTE	15h (subfunction "Get Object Connection Numbers")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
SeeAlso: #1210,#1465

Format of NetWare "Get Object Connection Numbers" reply buffer:
Offset	Size	Description	(Table 1210)
 00h	WORD	(call) length of following results buffer (max 65h)
 02h	BYTE	number of connections
 03h  N BYTEs	connection list
SeeAlso: #1209,#1465
--------N-21E3--SF16-------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - GET CONNECTION INFORMATION
	AH = E3h subfn 16h
	DS:SI -> request buffer (see #1211)
	ES:DI -> reply buffer (see #1212)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=D7h,AH=DCh"NetWare",AH=E3h/SF=14h

Format of NetWare "Get Connection Information" request buffer:
Offset	Size	Description	(Table 1211)
 00h	WORD	0002h (length of following data)
 02h	BYTE	16h (subfunction "Get Connection Information")
 03h	BYTE	logical connection number (01h-64h)

Format of NetWare "Get Connection Information" reply buffer:
Offset	Size	Description	(Table 1212)
 00h	WORD	(call) 003Eh (length of following results buffer)
 02h	DWORD	(big-endian) object ID for object logged in on the connection
		00000000h if no object logged in
 06h	WORD	(big-endian) type of object
 08h 48 BYTEs	name of object
 38h  7 BYTEs	login time (see #1213)
Note:	much of the Novell documentation incorrectly states the reply buffer
	  length as 3Fh instead of 40h, which corresponds to a results length
	  of 3Dh (61) bytes instead of the correct 3Eh (62) bytes

Format of NetWare login time:
Offset	Size	Description	(Table 1213)
 00h	BYTE	year (80-99 = 1980-1999, 00-79 = 2000-2079)
 01h	BYTE	month (1-12)
 02h	BYTE	day (1-31)
 03h	BYTE	hour (0-23)
 04h	BYTE	minute (0-59)
 05h	BYTE	second (0-59)
 06h	BYTE	day of week (0 = Sunday)
--------N-21E3--SF32-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CREATE BINDERY OBJECT
	AH = E3h subfn 32h
	DS:SI -> request buffer (see #1215)
	ES:DI -> reply buffer (see #1216)
Return: AL = status (see #1214)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=33h,AH=E3h/SF=34h,AH=E3h/SF=38h,AH=E3h/SF=39h
SeeAlso: AX=F217h/SF=32h

(Table 1214)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 EEh	object already exists
 EFh	invalid name
 F0h	wildcard not allowed
 F1h	invalid bindery security level
 F3h	not permitted to rename object
 F4h	not permitted to delete objects
 F5h	not permitted to create objects
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure
SeeAlso: #1196,#1221

Format of NetWare "Create Bindery Object" request buffer:
Offset	Size	Description	(Table 1215)
 00h	WORD	length of following data (max 35h)
 02h	BYTE	32h (subfunction "Create Bindery Object")
 03h	BYTE	object flag (00h static, 01h dynamic)
 04h	BYTE	object security levels
 05h	WORD	(big-endian) type of object
 07h	BYTE	length of object's name
 08h  N BYTEs	object's name
SeeAlso: #1216

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1216)
 00h	WORD	0000h (no data returned)
SeeAlso: #1215,#1217,#1218
--------N-21E3--SF33-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - DELETE BINDERY OBJECT
	AH = E3h subfn 33h
	DS:SI -> request buffer (see #1217)
	ES:DI -> reply buffer (see #1216)
Return: AL = status (see #1214)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=34h,AX=F217h/SF=33h

Format of NetWare "Delete Bindery Object" request buffer:
Offset	Size	Description	(Table 1217)
 00h	WORD	length of following data (max 33h)
 02h	BYTE	33h (subfunction "Delete Bindery Object")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
SeeAlso: #1216
--------N-21E3--SF34-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - RENAME BINDERY OBJECT
	AH = E3h subfn 34h
	DS:SI -> request buffer (see #1218)
	ES:DI -> reply buffer (see #1216)
Return: AL = status (see #1214)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=33h,AX=F217h/SF=34h

Format of NetWare "Rename Bindery Object" request buffer:
Offset	Size	Description	(Table 1218)
 00h	WORD	length of following data (max 63h)
 02h	BYTE	34h (subfunction "Rename Bindery Object")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
	BYTE	length of new name (01h-2Fh)
      N BYTEs	new name
SeeAlso: #1216
--------N-21E3--SF35-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - GET BINDERY OBJECT ID
	AH = E3h subfn 35h
	DS:SI -> request buffer (see #1219)
	ES:DI -> reply buffer (see #1220)
Return: AL = status (00h,96h,FCh,FEh,FFh) (see #1221)
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the requesting workstation must be logged into the file server with
	  read access to the bindery object
SeeAlso: AH=E3h/SF=36h,AH=E3h/SF=44h,AX=F217h/SF=35h

Format of NetWare "Get Bindery Object ID" request buffer:
Offset	Size	Description	(Table 1219)
 00h	WORD	length of following data (max 33h)
 02h	BYTE	35h (subfunction "Get Bindery Object ID")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name
 06h  N BYTEs	object's name
SeeAlso: #1220,#1480

Format of NetWare "Get Bindery Object ID" reply buffer:
Offset	Size	Description	(Table 1220)
 00h	WORD	(call) 0036h (length of following buffer space)
 02h	DWORD	(big-endian) object ID
 06h	WORD	(big-endian) type of object
 08h 48 BYTEs	object name
SeeAlso: #1219,#1480 at AX=F217h/SF=35h
--------N-21E3--SF36-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - GET BINDERY OBJECT NAME
	AH = E3h subfn 36h
	DS:SI -> request buffer (see #1222)
	ES:DI -> reply buffer (see #1223)
Return: AL = status (see #1221)
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the requesting workstation must be logged into the file server with
	  read access to the bindery object
SeeAlso: AH=E3h/SF=35h,AH=E3h/SF=44h,AX=F217h/SF=36h

(Table 1221)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 EFh	invalid name
 F0h	wildcard not allowed
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure
SeeAlso: #1214,#1227

Format of NetWare "Get Bindery Object Name" request buffer:
Offset	Size	Description	(Table 1222)
 00h	WORD	0005h (length of following data)
 02h	BYTE	36h (subfunction "Get Bindery Object Name")
 03h	DWORD	(big-endian) object ID
SeeAlso: #1223,#1481 at AX=F217h/SF=36h

Format of NetWare "Get Bindery Object Name" reply buffer:
Offset	Size	Description	(Table 1223)
 00h	WORD	(call) 0036h (length of following buffer space)
 02h	DWORD	(big-endian) object ID
 06h	WORD	(big-endian) type of object
 08h 48 BYTEs	object name
SeeAlso: #1222,#1481
--------N-21E3--SF37-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - SCAN BINDERY OBJECT
	AH = E3h subfn 37h
	DS:SI -> request buffer (see #1224)
	ES:DI -> reply buffer (see #1225)
Return: AL = status (see #1221)
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the requesting workstation must be logged into the file server with
	  read access to the bindery object
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=33h,AH=E3h/SF=38h,AH=E3h/SF=3Ch
SeeAlso: AX=F217h/SF=37h

Format of NetWare "Scan Bindery Object" request buffer:
Offset	Size	Description	(Table 1224)
 00h	WORD	length of following data (max 37h)
 02h	BYTE	37h (subfunction "Scan Bindery Object")
 03h	DWORD	(big-endian) last object ID
 07h	WORD	(big-endian) type of object
 09h	BYTE	length of object's name
 0Ah  N BYTEs	object's name
SeeAlso: #1225,#1482

Format of NetWare "Scan Bindery Object" reply buffer:
Offset	Size	Description	(Table 1225)
 00h	WORD	(call) 0039h (length of following buffer space)
 02h	DWORD	(big-endian) object ID
		FFFFFFFFh for first call
 06h	WORD	(big-endian) type of object
 08h 48 BYTEs	object name (counted string)
 38h	BYTE	object flag (00h static, 01h dynamic)
 39h	BYTE	object's security levels
 3Ah	BYTE	object properties flag (00h no, FFh yes)
SeeAlso: #1224,#1482
--------N-21E3--SF38-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CHANGE BINDERY OBJECT SECURITY
	AH = E3h subfn 38h
	DS:SI -> request buffer (see #1226)
	ES:DI -> reply buffer (see #1229)
Return: AL = status (00h,96h,F0h,F1h,FBh,FCh,FEh,FFh) (see #1227)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=3Bh,AX=F217h/SF=38h

Format of NetWare "Change Bindery Object Security" request buffer:
Offset	Size	Description	(Table 1226)
 00h	WORD	length of following data (max 34h)
 02h	BYTE	38h (subfunction "Change Bindery Object Security")
 03h	BYTE	new security levels
 04h	WORD	(big-endian) type of object
 06h	BYTE	length of object's name (01h-2Fh)
 07h  N BYTEs	object name
Note:	the object type may not be WILD (FFFFh)
SeeAlso: #1229
--------N-21E3--SF39-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CREATE PROPERTY
	AH = E3h subfn 39h
	DS:SI -> request buffer (see #1228)
	ES:DI -> reply buffer (see #1229)
Return: AL = status (see #1227)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=3Bh,AX=F217h/SF=39h

(Table 1227)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 EDh	property already exists
 EFh	invalid name
 F0h	wildcard not allowed
 F1h	invalid bindery security level
 F6h	not permitted to delete properties
 F7h	not permitted to create properties
 FBh	no such property
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure
SeeAlso: #1221,#1231

Format of NetWare "Create Property" request buffer:
Offset	Size	Description	(Table 1228)
 00h	WORD	length of following data (max 45h)
 02h	BYTE	39h (subfunction "Create Property")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
	BYTE	property flags
	BYTE	property security levels
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property's name
SeeAlso: #1229

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1229)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1226,#1229,#1230
--------N-21E3--SF3A-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - DELETE PROPERTY
	AH = E3h subfn 3Ah
	DS:SI -> request buffer (see #1230)
	ES:DI -> reply buffer (see #1229)
Return: AL = status (see #1227)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=32h,AH=E3h/SF=39h,AX=F217h/SF=3Ah

Format of NetWare "Delete Property" request buffer:
Offset	Size	Description	(Table 1230)
 00h	WORD	length of following data (max 43h)
 02h	BYTE	3Ah (subfunction "Delete Property")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object's name
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property's name
SeeAlso: #1229
--------N-21E3--SF3B-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CHANGE PROPERTY SECURITY
	AH = E3h subfn 3Bh
	DS:SI -> request buffer (see #1232)
	ES:DI -> reply buffer (see #1229)
Return: AL = status (see #1231)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=38h,AX=F217h/SF=3Bh

(Table 1231)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 F0h	wildcard not allowed
 F1h	invalid bindery security level
 FBh	no such property
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure
SeeAlso: #1227,#1235

Format of NetWare "Change Property Security" request buffer:
Offset	Size	Description	(Table 1232)
 00h	WORD	length of following data (max 44h)
 02h	BYTE	3Bh (subfunction "Change Property Security")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	new property security levels
	BYTE	length of property's name
      N BYTEs	property name
Note:	the object type may not be WILD (FFFFh)
--------N-21E3--SF3C-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - SCAN PROPERTY
	AH = E3h subfn 3Ch
	DS:SI -> request buffer (see #1233)
	ES:DI -> reply buffer (see #1234)
Return: AL = status (00h,96h,F1h,FBh,FCh,FEh,FFh) (see #1231)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=37h,AH=E3h/SF=3Bh,AX=F217h/SF=3Ch

Format of NetWare "Scan Property" request buffer:
Offset	Size	Description	(Table 1233)
 00h	WORD	length of following data (max 47h)
 02h	BYTE	3Ch (subfunction "Scan Property")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	DWORD	(big-endian) sequence number
		FFFFFFFFh for first call
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property's name
SeeAlso: #1234,#1483

Format of NetWare "Scan Property" reply buffer:
Offset	Size	Description	(Table 1234)
 00h	WORD	(call) 0018h (length of following results buffer)
 02h 16 BYTEs	property name
 12h	BYTE	property flags
 13h	BYTE	property security levels
 14h	DWORD	(big-endian) sequence number
 18h	BYTE	property value flag (00h no, FFh yes)
 19h	BYTE	more properties (00h no, FFh yes)
SeeAlso: #1233,#1483
--------N-21E3--SF3D-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - READ PROPERTY VALUE
	AH = E3h subfn 3Dh
	DS:SI -> request buffer (see #1236)
	ES:DI -> reply buffer (see #1237)
Return: AL = status (see #1235)
Desc:	retrieve one 128-byte segment of the specified property's value
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=39h,AH=E3h/SF=3Ch,AH=E3h/SF=3Eh,AX=F217h/SF=3Dh

(Table 1235)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 E8h	not item property
 ECh	no such segment
 F0h	wildcard not allowed
 F1h	invalid bindery security level
 F8h	not permitted to write property
 F9h	not permitted to read property
 FBh	no such property
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure
SeeAlso: #1231,#1240

Format of NetWare "Read Property Value" request buffer:
Offset	Size	Description	(Table 1236)
 00h	WORD	length of following data (max 44h)
 02h	BYTE	3Dh (subfunction "Read Property Value")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	segment number (01h on first call, increment until done)
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property name
SeeAlso: #1237,#1484

Format of NetWare "Read Property Value" reply buffer:
Offset	Size	Description	(Table 1237)
 00h	WORD	(call) 0082h (length of following results buffer)
 02h 128 BYTEs	property's value
 82h	BYTE	more segments (00h no, FFh yes)
 83h	BYTE	property's flags
SeeAlso: #1236,#1484
--------N-21E3--SF3E-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - WRITE PROPERTY VALUE
	AH = E3h subfn 3Eh
	DS:SI -> request buffer (see #1238)
	ES:DI -> reply buffer (see #1239)
Return: AL = status (see #1235)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=39h,AH=E3h/SF=3Ch,AH=E3h/SF=3Dh,AX=F217h/SF=3Eh

Format of NetWare "Write Property Value" request buffer:
Offset	Size	Description	(Table 1238)
 00h	WORD	length of following data (max C5h)
 02h	BYTE	3Eh (subfunction "Write Property Value")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	segment number (01h on first call, increment until done)
	BYTE	erase remaining segments (00h no, FFh yes)
	BYTE	length of property's name (01h-0Fh)
      N BYTEs	property name
    128 BYTEs	property value segment
SeeAlso: #1239

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1239)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1238,#1241
--------N-21E3--SF3F-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - VERIFY BINDERY OBJECT PASSWORD
	AH = E3h subfn 3Fh
	DS:SI -> request buffer (see #1241)
	ES:DI -> reply buffer (see #1239)
Return: AL = status (see #1240)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=40h,AX=F217h/SF=3Fh

(Table 1240)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 F0h	wildcard not allowed
 FBh	no such property
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure: no such object, bad password, no password for object,
	  or invalid old password
SeeAlso: #1235,#1244

Format of NetWare "Verify Bindery Object Password" request buffer:
Offset	Size	Description	(Table 1241)
 00h	WORD	length of following data (max 133h)
 02h	BYTE	3Fh (subfunction "Verify Bindery Object Password")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	length of password (00h-7Fh)
      N BYTEs	password
SeeAlso: #1239
--------N-21E3--SF40-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CHANGE BINDERY OBJECT PASSWORD
	AH = E3h subfn 40h
	DS:SI -> request buffer (see #1242)
	ES:DI -> reply buffer (see #1243)
Return: AL = status (see #1240)
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=3Fh,AH=E3h/SF=41h,AX=F217h/SF=40h

Format of NetWare "Change Bindery Object Password" request buffer:
Offset	Size	Description	(Table 1242)
 00h	WORD	length of following data (max 133h)
 02h	BYTE	40h (subfunction "Change Bindery Object Password")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name (01h-2Fh)
 06h  N BYTEs	object name
	BYTE	length of old password (00h-7Fh)
      N BYTEs	old password
	BYTE	length of new password (00h-7Fh)
      N BYTEs	new password
SeeAlso: #1243,#1491

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1243)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1242,#1245
--------N-21E3--SF41-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - ADD BINDERY OBJECT TO SET
	AH = E3h subfn 41h
	DS:SI -> request buffer (see #1245)
	ES:DI -> reply buffer (see #1243)
Return: AL = status (see #1244)
Desc:	add the specified object to an object's group property
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=40h,AH=E3h/SF=42h,AH=E3h/SF=43h,AX=F217h/SF=41h

(Table 1244)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 E9h	member already exists
 EAh	member does not exist
 EBh	not a group property
 F0h	wildcard not allowed
 F8h	can't write property
 F9h	not permitted to read property
 FBh	no such property
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure
SeeAlso: #1240,#1255

Format of NetWare "Add Bindery Object to Set" request buffer:
Offset	Size	Description	(Table 1245)
 00h	WORD	length of following data (max 75h)
 02h	BYTE	41h (subfunction "Add Bindery Object to Set")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name
 06h  N BYTEs	object name
	BYTE	length of property name (01h-0Fh)
      N BYTEs	property name
	WORD	(big-endian) type of member object
	BYTE	length of member object's name
      N BYTEs	member object's name
SeeAlso: #1243
--------N-21E3--SF42-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - DELETE BINDERY OBJECT FROM SET
	AH = E3h subfn 42h
	DS:SI -> request buffer (see #1246)
	ES:DI -> reply buffer (see #1247)
Return: AL = status (see #1244)
Desc:	delete the specified object from a set property
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=40h,AH=E3h/SF=42h,AH=E3h/SF=43h,AX=F217h/SF=42h

Format of NetWare "Delete Bindery Object from Set" request buffer:
Offset	Size	Description	(Table 1246)
 00h	WORD	length of following data (max 75h)
 02h	BYTE	42h (subfunction "Delete Bindery Object from Set")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name
 06h  N BYTEs	object name
	BYTE	length of property name (01h-0Fh)
      N BYTEs	property name
	WORD	(big-endian) type of member object
	BYTE	length of member object's name
      N BYTEs	member object's name
SeeAlso: #1247

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1247)
 00h	WORD	(call) 0000h (no data returned)
SeeAlso: #1246,#1248,#1249,#1250
--------N-21E3--SF43-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - IS BINDERY OBJECT IN SET
	AH = E3h subfn 43h
	DS:SI -> request buffer (see #1248)
	ES:DI -> reply buffer (see #1247)
Return: AL = status (see #1244)
Desc:	determine whether the specified object is a member of the given set
	  property
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the caller must have read access to the property
SeeAlso: AH=E3h/SF=41h,AH=E3h/SF=42h,AX=F217h/SF=43h

Format of NetWare "Is Bindery Object in Set?" request buffer:
Offset	Size	Description	(Table 1248)
 00h	WORD	length of following data (max 75h)
 02h	BYTE	43h (subfunction "Is Bindery Object In Set")
 03h	WORD	(big-endian) type of object
 05h	BYTE	length of object's name
 06h  N BYTEs	object's name
	BYTE	length of property's name
      N BYTEs	property's name
	WORD	(big-endian) type of member object
	BYTE	length of member object's name
      N BYTEs	member object's name
SeeAlso: #1247
--------N-21E3--SF44-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - CLOSE BINDERY
	AH = E3h subfn 44h
	DS:SI -> request buffer (see #1249)
	ES:DI -> reply buffer (see #1247)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E3h/SF=45h,AX=F217h/SF=44h

Format of NetWare "Close Bindery" request buffer:
Offset	Size	Description	(Table 1249)
 00h	WORD	0001h (length of following data)
 02h	BYTE	44h (subfunction "Close Bindery")
SeeAlso: #1247,#1250
--------N-21E3--SF45-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - OPEN BINDERY
	AH = E3h subfn 45h
	DS:SI -> request buffer (see #1250)
	ES:DI -> reply buffer (see #1247)
Return: AL = status
	    00h successful
Notes:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
	the bindery may only be opened by the supervisor or an object with
	  equivalent privileges
SeeAlso: AH=E3h/SF=44h,AX=F217h/SF=45h

Format of NetWare "Open Bindery" request buffer:
Offset	Size	Description	(Table 1250)
 00h	WORD	0001h (length of following data)
 02h	BYTE	45h (subfunction "Open Bindery")
SeeAlso: #1247,#1249
--------N-21E3--SF46-------------------------
INT 21 - Novell NetWare - BINDERY SERVICES - GET BINDERY ACCESS LEVEL
	AH = E3h subfn 46h
	DS:SI -> request buffer (see #1251)
	ES:DI -> reply buffer (see #1252)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AX=F217h/SF=46h

Format of NetWare "Get Bindery Access Level" request buffer:
Offset	Size	Description	(Table 1251)
 00h	WORD	0001h (length of following data)
 02h	BYTE	46h (subfunction "Get Bindery Access Level")
SeeAlso: #1252,#1485

Format of NetWare "Get Bindery Access Level" reply buffer:
Offset	Size	Description	(Table 1252)
 00h	WORD	0005h (length of following buffer)
 02h	BYTE	security levels
 03h	DWORD	(big-endian) object ID
SeeAlso: #1251,#1485
--------N-21E3--SF47-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - SCAN BINDERY OBJ TRUSTEE PATHS
	AH = E3h subfn 47h
	DS:SI -> request buffer (see #1253)
	ES:DI -> reply buffer (see #1254)
Return: AL = status (00h,96h,F0h,F1h,FCh,FEh,FFh) (see #1255)
Desc:	iterate through the directories to which an object is a trustee
Note:	this function is supported by Advanced NetWare 1.0+ and Alloy NTNX
SeeAlso: AH=E2h/SF=0Ch,AH=E2h/SF=0Dh,AH=E2h/SF=0Eh,AX=F217h/SF=47h

Format of NetWare "Scan Bindery Object Trustee Paths" request buffer:
Offset	Size	Description	(Table 1253)
 00h	WORD	0008h (length of following data)
 02h	BYTE	47h (subfunction "Scan Bindery Object Trustee Paths")
 03h	BYTE	volume number (00h-1Fh)
 04h	WORD	(big-endian) last sequence number (FFFFh on first call)
 06h	DWORD	(big-endian) object ID
SeeAlso: #1254,#1486

Format of NetWare "Scan Bindery Object Trustee Paths" reply buffer:
Offset	Size	Description	(Table 1254)
 00h	WORD	(call) length of following results buffer (max 107h)
 02h	WORD	(big-endian) next sequence number
 04h	DWORD	(big-endian) object ID
 08h	BYTE	trustee directory rights (see #1143 at AH=E2h/SF=03h)
 09h	BYTE	length of trustee path
 0Ah  N BYTEs	trustee path
SeeAlso: #1253,#1486
--------N-21E3--SF64-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CREATE QUEUE
	AH = E3h subfn 64h
	DS:SI -> request buffer (see #1256)
	ES:DI -> reply buffer (see #1257)
Return: AL = status (00h,96h,99h,9Bh,9Ch,EDh-F1h,F5h,F7h,FCh,FEh,FFh)
	      (see #1255)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation with supervisor privileges
SeeAlso: AH=E3h/SF=65h,AH=E3h/SF=66h,AH=E3h/SF=68h,AH=E3h/SF=6Bh
SeeAlso: AX=F217h/SF=64h

(Table 1255)
Values for NetWare function status:
 00h	successful
 96h	server out of memory
 99h	directory full
 9Bh	invalid directory handle
 9Ch	invalid path
 D0h	queue error
 D1h	no such queue
 D2h	no server for queue
 D3h	no queue rights
 D4h	queue full
 D5h	no queue job
 D6h	no job rights
 D7h	queue servicing error
 D8h	queue not active
 D9h	station is not a server
 DAh	queue halted
 DBh	too many queue servers
 EDh	property already exists
 EEh	object already exists
 EFh	invalid name
 F0h	wildcard not allowed
 F1h	invalid bindery security level
 F5h	not permitted to create object
 F7h	not permitted to create property
 FCh	no such object
 FEh	server bindery locked
 FFh	bindery failure
SeeAlso: #1244,#1296,#2085 at INT 2F/AX=7A20h/BX=0000h

Format of NetWare "Create Queue" request buffer:
Offset	Size	Description	(Table 1256)
 00h	WORD	length of following data (max ABh)
 02h	BYTE	64h (subfunction "Create Queue")
 03h	WORD	(big-endian) queue type
 05h	BYTE	length of queue's name (01h-2Fh)
 06h  N BYTEs	queue's name
	BYTE	directory handle or 00h
	BYTE	length of path name (01h-76h)
      N BYTEs	path name of directory in which to create queue subdirectory
SeeAlso: #1257,#1494

Format of NetWare "Create Queue" reply buffer:
Offset	Size	Description	(Table 1257)
 00h	WORD	(call) 0004h (size of following results buffer)
 02h	DWORD	(big-endian) object ID of queue
SeeAlso: #1256,#1494
--------N-21E3--SF65-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - DESTROY QUEUE
	AH = E3h subfn 65h
	DS:SI -> request buffer (see #1258)
	ES:DI -> reply buffer (see #1263)
Return: AL = status (00h,96h,9Ch,D0h,D1h,FFh) (see also AH=E3h/SF=64h)
	    FFh hardware failure
Desc:	abort all active jobs, detach all job servers, remove all job entries,
	  delete all job files, remove the queue object and its properties
	  from the bindery, and delete the queue's subdirectory
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must have SUPERVISOR privileges
SeeAlso: AH=E3h/SF=64h,AH=E3h/SF=66h,AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=70h
SeeAlso: AX=F217h/SF=65h

Format of NetWare "Destroy Queue" request buffer:
Offset	Size	Description	(Table 1258)
 00h	WORD	0005h (length of following data)
 02h	BYTE	65h (subfunction "Destroy Queue")
 03h	DWORD	(big-endian) object ID of queue
SeeAlso: #1263
--------N-21E3--SF66-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - READ QUEUE CURRENT STATUS (OLD)
	AH = E3h subfn 66h
	DS:SI -> request buffer (see #1259)
	ES:DI -> reply buffer (see #1260)
Return: AL = status (00h,96h,9Ch,D1h-D3h,F1h,FCh,FEh,FFh) (see #1255)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USERS or Q_OPERATORS properties
SeeAlso: AH=E3h/SF=64h,AH=E3h/SF=67h,AH=E3h/SF=6Fh,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=66h

Format of NetWare "Read Queue Current Status (old)" request buffer:
Offset	Size	Description	(Table 1259)
 00h	WORD	0005h (length of following data)
 02h	BYTE	66h (subfunction "Read Queue Current Status")
 03h	DWORD	(big-endian) object ID of queue
SeeAlso: #1260,#1495 at AX=F217h/SF=66h

Format of NetWare "Read Queue Current Status (old)" reply buffer:
Offset	Size	Description	(Table 1260)
 00h	WORD	(call) 0085h (size of following results)
 02h	DWORD	(big-endian) object ID of queue
 06h	BYTE	status of queue (see #1261)
 07h	BYTE	number of jobs in queue (00h-FAh)
 08h	BYTE	number of servers attached to queue (00h-19h)
 09h 25 DWORDs	list of object IDs of attached servers
 6Dh 25 BYTEs	list of attached servers' stations
 86h	BYTE	(call) maximum number of servers to return
SeeAlso: #1259,#1495 at AX=F217h/SF=66h

Bitfields for NetWare queue status:
Bit(s)	Description	(Table 1261)
 0	operator disabled addition of new jobs
 1	operator refuses additional job servers attaching
 2	operator disabled job servicing
SeeAlso: #1260,#1262
--------N-21E3--SF67-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - SET QUEUE CURRENT STATUS (OLD)
	AH = E3h subfn 67h
	DS:SI -> request buffer (see #1262)
	ES:DI -> reply buffer (see #1263)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D3h,FEh,FFh) (see #1255)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must have operator privileges
SeeAlso: AH=E3h/SF=64h,AH=E3h/SF=66h,AH=E3h/SF=6Fh,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=67h

Format of NetWare "Set Queue Current Status (old)" request buffer:
Offset	Size	Description	(Table 1262)
 00h	WORD	0006h (length of following data)
 02h	BYTE	67h (subfunction "Set Queue Current Status")
 03h	DWORD	(big-endian) object ID of queue
 07h	BYTE	queue status (see #1261)
SeeAlso: #1263

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1263)
 00h	WORD	(call) 0000h (no results returned)
--------N-21E3--SF68-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CREATE QUEUE JOB AND FILE
	AH = E3h subfn 68h
	DS:SI -> request buffer (see #1264)
	ES:DI -> reply buffer (see #1266)
Return: AL = status (00h,96h,99h,9Ch,D0h-D4h,DAh,EDh,EFh-F1h,F7h,FCh,FEh,FFh)
		(see #1255)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USER property
SeeAlso: AX=B807h,AH=E0h"SPOOLING",AH=E3h/SF=69h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh
SeeAlso: AX=F217h/SF=68h

Format of NetWare "Create Queue Job and File" request buffer:
Offset	Size	Description	(Table 1264)
 00h	WORD	0107h (length of following data)
 02h	BYTE	68h (subfunction "Close File and Start Queue Job")
 03h	DWORD	(big-endian) object ID of queue
 07h 256 BYTEs	job structure (see #1265)
SeeAlso: #1266,#1496

Format of NetWare old-style job structure:
Offset	Size	Description	(Table 1265)
 00h	BYTE	client station
 01h	BYTE	client task number
 02h	DWORD	(big-endian) object ID of client
 06h	DWORD	(big-endian) object ID of target server
		FFFFFFFh if any server acceptable
 0Ah  6 BYTEs	target execution time (year,month,day,hour,minute,second)
		FFFFFFFFFFFFh to execute as soon as possible
 10h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 16h	WORD	(big-endian) job number
 18h	WORD	(big-endian) job type
 1Ah	BYTE	job position
 1Bh	BYTE	job control flags (see #1274)
 1Ch 14 BYTEs	ASCIZ job file name
 2Ah  6 BYTEs	job file handle
 30h	BYTE	server station
 31h	BYTE	server task number
 32h	DWORD	(big-endian) object ID of server
 36h 50 BYTEs	ASCIZ job description string
 68h 152 BYTEs	client record area
SeeAlso: #1264,#1506

Format of NetWare "Create Queue Job and File" reply buffer:
Offset	Size	Description	(Table 1266)
 00h	WORD	(call) 0036h (size of following results buffer)
 02h	BYTE	client station
 03h	BYTE	client task number
 04h	DWORD	(big-endian) object ID of client
 08h	DWORD	(big-endian) object ID of target server
 0Ch  6 BYTEs	target execution time (year,month,day,hour,minute,second)
 12h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 18h	WORD	(big-endian) job number
 1Ah	WORD	(big-endian) job type
 1Ch	BYTE	job position
 1Dh	BYTE	job control flags (see #1274)
 1Eh 14 BYTEs	ASCIZ job file name
 2Ch  6 BYTEs	job file handle
 32h	BYTE	server station
 33h	BYTE	server task number
 34h	DWORD	(big-endian) object ID of server or 00000000h
SeeAlso: #1264,#1496
--------N-21E3--SF69-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CLOSE FILE AND START QUEUE JOB (OLD)
	AH = E3h subfn 69h
	DS:SI -> request buffer (see #1267)
	ES:DI -> reply buffer (see #1268)
Return: AL = status (00h,96h,D0h,D1h,D3h,D5h,D6h,FEh,FFh) (see #1255)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on the workstation which created the job
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh,AX=F217h/SF=69h

Format of NetWare "Close File and Start Queue Job (old)" request buffer:
Offset	Size	Description	(Table 1267)
 00h	WORD	0007h (length of following data)
 02h	BYTE	69h (subfunction "Close File and Start Queue Job")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
SeeAlso: #1268

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1268)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1267,#1269
--------N-21E3--SF6A-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - REMOVE JOB FROM QUEUE (OLD)
	AH = E3h subfn 6Ah
	DS:SI -> request buffer (see #1269)
	ES:DI -> reply buffer (see #1268)
Return: AL = status (00h,96h,D0h,D1h,D5h,D6h,FEh,FFh) (see #1255)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must have created the job or be an operator
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh,AX=F217h/SF=6Ah

Format of NetWare "Remove Job From Queue (old)" request buffer:
Offset	Size	Description	(Table 1269)
 00h	WORD	0007h (length of following data)
 02h	BYTE	6Ah (subfunction "Remove Job From Queue (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
--------N-21E3--SF6B-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - GET QUEUE JOB LIST (OLD)
	AH = E3h subfn 6Bh
	DS:SI -> request buffer (see #1270)
	ES:DI -> reply buffer (see #1271)
Return: AL = status (00h,96h,9Ch,D0h-D3h,FCh,FEh,FFh) (see #1255)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the Q_USERS or Q_OPERATORS properties
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh,AX=F217h/SF=6Bh

Format of NetWare "Get Queue Job List (old)" request buffer:
Offset	Size	Description	(Table 1270)
 00h	WORD	0005h (length of following data)
 02h	BYTE	6Bh (subfunction "Get Queue Job List (old)")
 03h	DWORD	(big-endian) object ID of queue
SeeAlso: #1271

Format of NetWare "Get Queue Job List (old)" reply buffer:
Offset	Size	Description	(Table 1271)
 00h	WORD	(call) size of following results buffer (max 1F6h)
 02h	WORD	(big-endian) job count
 04h  N WORDs	(big-endian) list of job numbers by position in queue
	WORD	maximum job numbers
SeeAlso: #1270
--------N-21E3--SF6C-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - READ QUEUE JOB ENTRY (OLD)
	AH = E3h subfn 6Ch
	DS:SI -> request buffer (see #1272)
	ES:DI -> reply buffer (see #1273)
Return: AL = status (00h,96h,D0h-D3h,D5h,FCh,FEh,FFh) (see #1255)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the Q_USERS, Q_OPERATORS, or Q_SERVERS properties
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Eh,AX=F217h/SF=6Ch

Format of NetWare "Read Queue Job Entry (old)" request buffer:
Offset	Size	Description	(Table 1272)
 00h	WORD	0007h (length of following data)
 02h	BYTE	6Ch (subfunction "Read Queue Job Entry (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
SeeAlso: #1273

Format of NetWare "Read Queue Job Entry (old)" reply buffer:
Offset	Size	Description	(Table 1273)
 00h	WORD	(call) 0100h (size of following results)
 02h	BYTE	client station number
 03h	BYTE	client task number
 04h	DWORD	object ID of client
 08h	DWORD	(big-endian) object ID of target server
		FFFFFFFFh if any server acceptable
 0Ch  6 BYTEs	target execution time (year,month,day,hour,minute,second)
		FFFFFFFFFFFFh if serviced as soon as possible
 12h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 18h	WORD	(big-endian) job number
 1Ah	WORD	(big-endian) job type
 1Ch	BYTE	job position
 1Dh	BYTE	job control flags (see #1274)
 1Eh 14 BYTEs	ASCIZ job filename
 2Ch  6 BYTEs	job file handle
 32h	BYTE	server station
 33h	BYTE	server task number
 34h	DWORD	object ID of server
 38h 50 BYTEs	ASCIZ job description string
 6Ah 152 BYTEs	client record area
SeeAlso: #1272

Bitfields for NetWare job control flags:
Bit(s)	Description	(Table 1274)
 3	job will be serviced automatically if connection broken
 4	job remains in queue after server aborts job
 5	client has not filled associated job file
 6	User Hold--job advances, but cannot be serviced until this is
	  cleared by user or operator
 7	Operator Hold--job advances, but cannot be serviced until this is
	  cleared by an operator
SeeAlso: #1273
--------N-21E3--SF6D-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CHANGE QUEUE JOB ENTRY (OLD)
	AH = E3h subfn 6Dh
	DS:SI -> request buffer (see #1275)
	ES:DI -> reply buffer (see #1277)
Return: AL = status (00h,96h,D0h,D1h,D5h,D7h,FEh,FFh) (see #1255)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be an operator or the user who created the job
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Ch,AH=E3h/SF=6Eh
SeeAlso: AX=F217h/SF=6Dh

Format of NetWare "Change Queue Job Entry" request buffer:
Offset	Size	Description	(Table 1275)
 00h	WORD	0105h (length of following data)
 02h	BYTE	6Dh (subfunction "Change Queue Job Entry")
 03h	DWORD	(big-endian) object ID of queue
 07h 256 BYTEs	job structure (see #1265)
SeeAlso: #1277
--------N-21E3--SF6E-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CHANGE QUEUE JOB POSITION
	AH = E3h subfn 6Eh
	DS:SI -> request buffer (see #1276)
	ES:DI -> reply buffer (see #1277)
Return: AL = status (00h,96h,D0h,D1h,D5h,D6h,FEh,FFh) (see #1255)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be an operator
	if the specified position is greater than the number of jobs in the
	  queue, the job is placed at the end of the queue
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ah,AH=E3h/SF=6Ch,AH=E3h/SF=6Dh
SeeAlso: AX=F217h/SF=6Eh

Format of NetWare "Change Queue Job Position" request buffer:
Offset	Size	Description	(Table 1276)
 00h	WORD	0008h (length of following data)
 02h	BYTE	6Eh (subfunction "Change Queue Job Position")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
 09h	BYTE	new position in queue
		(01h = first, FAh [250] = last position in full queue)
SeeAlso: #1277

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1277)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1275,#1276,#1278
--------N-21E3--SF6F-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - ATTACH QUEUE SERVER TO QUEUE
	AH = E3h subfn 6Fh
	DS:SI -> request buffer (see #1278)
	ES:DI -> reply buffer (see #1277)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D3h,DAh,DBh,FEh,FFh)
		(see also AH=E3h/SF=64h)
	    FFh bindery failure, or no such property, or no such member
Desc:	attach the calling job server to the specified queue
Notes:	this function is supported by Advanced NetWare 2.1+
	a queue may have up to 25 job servers attached
	the calling workstation must be security-equivalent to a member of the
	  queue's Q_SERVERS property
SeeAlso: AH=E3h/SF=70h,AH=E3h/SF=71h,AH=E3h/SF=72h,AH=E3h/SF=73h,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=6Fh

Format of NetWare "Attach Queue Server to Queue" request buffer:
Offset	Size	Description	(Table 1278)
 00h	WORD	0005h (length of following data)
 02h	BYTE	6Fh (subfunction "Attach Queue Server To Queue")
 03h	DWORD	(big-endian) object ID of queue
SeeAlso: #1277,#1279
--------N-21E3--SF70-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - DETACH QUEUE SERVER FROM QUEUE
	AH = E3h subfn 70h
	DS:SI -> request buffer (see #1279)
	ES:DI -> reply buffer (see #1277)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D2h,FEh,FFh) (see #1255)
Desc:	remove the calling job server from the specified queue's list of
	  servers
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must have previously attached itself to the queue
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=72h,AH=E3h/SF=73h,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=70h

Format of NetWare "Detach Queue Server From Queue" request buffer:
Offset	Size	Description	(Table 1279)
 00h	WORD	0005h (length of following data)
 02h	BYTE	70h (subfunction "Detach Queue Server From Queue")
 03h	DWORD	(big-endian) object ID of queue
SeeAlso: #1277,#1278
--------N-21E3--SF71-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - SERVICE QUEUE JOB AND OPEN FILE
	AH = E3h subfn 71h
	DS:SI -> request buffer (see #1280)
	ES:DI -> reply buffer (see #1266)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D3h,D5h,D9h,DAh,FEh,FFh)
		(see #1255)
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USERS, Q_OPERATORS, or Q_SERVERS properties
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=72h,AH=E3h/SF=73h,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=71h

Format of NetWare "Service Queue Job and Open File" request buffer:
Offset	Size	Description	(Table 1280)
 00h	WORD	0007h (length of following data)
 02h	BYTE	71h (subfunction "Service Queue Job and Open File")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) target job type
		FFFFh any
SeeAlso: #1266,#1281
--------N-21E3--SF72-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - FINISH SERVICING QUEUE JOB AND FILE
	AH = E3h subfn 72h
	DS:SI -> request buffer (see #1281)
	ES:DI -> reply buffer (see #1283)
Return: AL = status (00h,96h,D0h,D1h,D6h) (see #1255)
Desc:	inform the Queue Management System (QMS) that the queue server has
	  completed a job
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must be a job server which has previously obtained a job
	  for servicing
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=71h,AH=E3h/SF=73h,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=72h

Format of NetWare "Finish Servicing Queue Job and File (old)" request buffer:
Offset	Size	Description	(Table 1281)
 00h	WORD	000Bh (length of following data)
 02h	BYTE	72h (subfunction "Finish Servicing Queue Job and File (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
 09h	DWORD	(big-endian) charge
SeeAlso: #1283,#1280,#1292
--------N-21E3--SF73-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - ABORT SERVICING QUEUE JOB AND FILE
	AH = E3h subfn 73h
	DS:SI -> request buffer (see #1282)
	ES:DI -> reply buffer (see #1283)
Return: AL = status (00h,96h,D0h,D1h,D6h,D9h) (see #1255)
Desc:	inform the Queue Management System (QMS) that the queue server is
	  unable to service a previously-accepted job
Notes:	this function is supported by Advanced NetWare 2.1+
	this is an old version of the call (see AH=E3h/SF=84h)
	only a job server which previously accepted a job for servicing may
	  call this function
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=71h,AH=E3h/SF=72h,AH=E3h/SF=76h,AH=E3h/SF=84h
SeeAlso: AX=F217h/SF=73h

Format of NetWare "Abort Servicing Queue Job and File (old)" request buffer:
Offset	Size	Description	(Table 1282)
 00h	WORD	0007h (length of following data)
 02h	BYTE	73h (subfunction "Abort Servicing Queue Job and File (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
SeeAlso: #1283,#1281

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1283)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1281,#1282,#1284,#1285
--------N-21E3--SF74-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - CHANGE TO CLIENT RIGHTS (OLD)
	AH = E3h subfn 74h
	DS:SI -> request buffer (see #1284)
	ES:DI -> reply buffer (see #1283)
Return: AL = status (00h,96h,D0h,D1h,D5h,D9h) (see #1255)
Desc:	temporarily assume the login identity of the client submitting the
	  job being serviced
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be a job server which has obtained a job for servicing
SeeAlso: AH=E3h/SF=75h,AX=F217h/SF=74h

Format of NetWare "Change to Client Rights (old)" request buffer:
Offset	Size	Description	(Table 1284)
 00h	WORD	0007h (length of following data)
 02h	BYTE	74h (subfunction "Change To Client Rights (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
SeeAlso: #1283,#1285
--------N-21E3--SF75-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - RESTORE QUEUE SERVER RIGHTS
	AH = E3h subfn 75h
	DS:SI -> request buffer (see #1285)
	ES:DI -> reply buffer (see #1283)
Return: AL = status (00h,96h,9Ch,D0h,D1h,D3h,D5h,D9h,DAh,FEh,FFh) (see #1255)
Desc:	restore server's own identity after assuming the login identity of the
	  client submitting the job being serviced
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be a job server which has previously changed its identity
SeeAlso: AH=E3h/SF=74h,AX=F217h/SF=75h

Format of NetWare "Restore Queue Server Rights" request buffer:
Offset	Size	Description	(Table 1285)
 00h	WORD	0001h (length of following data)
 02h	BYTE	75h (subfunction "Change To Client Rights")
SeeAlso: #1283,#1284
--------N-21E3--SF76-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - READ QUEUE SERVER CURRENT STATUS OLD
	AH = E3h subfn 76h
	DS:SI -> request buffer (see #1286)
	ES:DI -> reply buffer (see #1287)
Return: AL = status (00h,96h,9Ch,D1h-D3h,F1h,FCh,FEh,FFh) (see #1255)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the Q_USERS or Q_OPERATORS properties
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ch,AH=E3h/SF=6Fh,AH=E3h/SF=77h,AH=E3h/SF=78h
SeeAlso: AX=F217h/SF=76h

Format of NetWare "Read Queue Server Current Status (old)" request buffer:
Offset	Size	Description	(Table 1286)
 00h	WORD	000Ah (length of following data)
 02h	BYTE	76h (subfunction "Read Queue Server Current Status (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	DWORD	(big-endian) object ID of server
 0Bh	BYTE	server station
SeeAlso: #1287

Format of NetWare "Read Queue Server Current Status (old)" reply buffer:
Offset	Size	Description	(Table 1287)
 00h	WORD	(call) 0040h (size of following results)
 02h 64 BYTEs	server status record (format depends on server)
		first four bytes should contain estimated "price" for an
		  average job
SeeAlso: #1286,#1499
--------N-21E3--SF77-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - SET QUEUE SERVER CURRENT STATUS
	AH = E3h subfn 77h
	DS:SI -> request buffer (see #1288)
	ES:DI -> reply buffer (see #1289)
Return: AL = status (00h,96h,9Ch,D0h,D1h,FEh,FFh) (see #1255)
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be a job server which has attached itself to the queue
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ch,AH=E3h/SF=6Fh,AH=E3h/SF=76h,AH=E3h/SF=78h
SeeAlso: AX=F217h/SF=77h

Format of NetWare "Set Queue Server Current Status" request buffer:
Offset	Size	Description	(Table 1288)
 00h	WORD	0045h (length of following data)
 02h	BYTE	77h (subfunction "Set Queue Server Current Status")
 03h	DWORD	(big-endian) object ID of queue
 07h 64 BYTEs	server status record (format depends on server)
		first four bytes should contain estimated "price" for an
		  average job
SeeAlso: #1289

Format of NetWare "Set Queue Server Current Status" reply buffer:
Offset	Size	Description	(Table 1289)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1288
--------N-21E3--SF78-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - GET QUEUE JOB'S FILE SIZE (OLD)
	AH = E3h subfn 78h
	DS:SI -> request buffer (see #1290)
	ES:DI -> reply buffer (see #1291)
Return: AL = status (see also #1255)
	    00h successful
Notes:	this function is supported by Advanced NetWare 2.1+
	caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USERS, Q_OPERATORS, or Q_SERVERS properties
SeeAlso: AH=E3h/SF=68h,AH=E3h/SF=6Ch,AH=E3h/SF=71h,AX=F217h/SF=78h

Format of NetWare "Get Queue Job's File Size (old)" request buffer:
Offset	Size	Description	(Table 1290)
 00h	WORD	0007h (length of following data)
 02h	BYTE	78h (subfunction "Get Queue Job's File Size (old)")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
SeeAlso: #1291,#1500 at AX=F217h/SF=78h

Format of NetWare "Get Queue Job's File Size (old)" reply buffer:
Offset	Size	Description	(Table 1291)
 00h	WORD	(call) 000Ah (size of following results)
 02h	DWORD	(big-endian) object ID of queue
 06h	WORD	(big-endian) job number
 08h	DWORD	(big-endian) size of job file in bytes
SeeAlso: #1290,#1500 at AX=F217h/SF=78h
--------N-21E3--SF83-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - FINISH SERVICING QUEUE JOB
	AH = E3h subfn 83h
	DS:SI -> request buffer (see #1292)
	ES:DI -> reply buffer (see #1293)
Return: AL = status (00h,96h,D0h,D1h,D6h,D9h) (see #1255)
Desc:	inform the Queue Management System (QMS) that the queue server has
	 completed servicing a previously-accepted job
Notes:	this function is supported by Advanced NetWare 3.1+
	this variant of Abort Servicing Queue Job allows use of the high
	  connection byte in the NCP packet header, unlike AH=E3h/SF=73h
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=71h,AH=E3h/SF=72h,AH=E3h/SF=73h,AH=E3h/SF=84h
SeeAlso: AX=F217h/SF=83h

Format of NetWare "Finish Servicing Queue Job" request buffer:
Offset	Size	Description	(Table 1292)
 00h	WORD	0007h (length of following data)
 02h	BYTE	84h (subfunction "Abort Servicing Queue Job")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
 09h	DWORD	(big-endian) charge for job
SeeAlso: #1293,#1281

Format of NetWare "Finish Servicing Queue Job" reply buffer:
Offset	Size	Description	(Table 1293)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1292
--------N-21E3--SF84-------------------------
INT 21 - Novell NetWare - QUEUE SERVICES - ABORT SERVICING QUEUE JOB
	AH = E3h subfn 84h
	DS:SI -> request buffer (see #1294)
	ES:DI -> reply buffer (see #1295)
Return: AL = status (00h,96h,D0h,D1h,D6h,D9h) (see #1255)
Desc:	inform the Queue Management System (QMS) that the queue server is
	  unable to service a previously-accepted job
Notes:	this function is supported by Advanced NetWare 3.1+
	this variant of Abort Servicing Queue Job allows use of the high
	  connection byte in the NCP packet header, unlike AH=E3h/SF=73h
SeeAlso: AH=E3h/SF=6Fh,AH=E3h/SF=71h,AH=E3h/SF=72h,AH=E3h/SF=73h,AH=E3h/SF=76h
SeeAlso: AX=F217h/SF=84h

Format of NetWare "Abort Servicing Queue Job" request buffer:
Offset	Size	Description	(Table 1294)
 00h	WORD	0007h (length of following data)
 02h	BYTE	84h (subfunction "Abort Servicing Queue Job")
 03h	DWORD	(big-endian) object ID of queue
 07h	WORD	(big-endian) job number
SeeAlso: #1295

Format of NetWare "Abort Servicing Queue Job" reply buffer:
Offset	Size	Description	(Table 1295)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1294
--------N-21E3--SF96-------------------------
INT 21 - Novell NetWare - ACCOUNTING SERVICES - GET ACCOUNT STATUS
	AH = E3h subfn 96h
	DS:SI -> request buffer (see #1297)
	ES:DI -> reply buffer (see #1298)
Return: AL = status (00h,C0h,C1h) (see #1296)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=97h,AH=E3h/SF=98h,AH=E3h/SF=99h,AX=F217h/SF=96h

(Table 1296)
Values for NetWare function status:
 00h	successful
 C0h	no account privileges
 C1h	no account balance
 C2h	credit limit exceeded
 C3h	too many holds on account
SeeAlso: #1255,#1306

Format of NetWare "Get Account Status" request buffer:
Offset	Size	Description	(Table 1297)
 00h	WORD	length of following data (max 33h)
 02h	BYTE	96h (subfunction "Get Account Status")
 03h	WORD	(big-endian) type of bindery object
 05h	BYTE	length of object name (01h to 2Fh)
 06h  N BYTEs	object name
SeeAlso: #1298,#1520 at AX=F217h/SF=96h

Format of NetWare "Get Account Status" reply buffer:
Offset	Size	Description	(Table 1298)
 00h	WORD	(call) length of following buffer space
 02h	DWORD	(big-endian) account balance
 06h	DWORD	(big-endian) credit limit
		signed number indicating lowest allowable account balance
 0Ah 120 BYTEs	reserved
 82h	DWORD	(big-endian) object ID, server 1
 86h	DWORD	(big-endian) hold amount, server 1
	...
 F8h	DWORD	(big-endian) object ID, server 16
 FCh	DWORD	(big-endian) hold amount, server 16
Note:	the reply buffer lists the servers which have placed holds on a portion
	  of the account balance, and the amount reserved by each
SeeAlso: #1297,#1520 at AX=F217h/SF=96h
--------N-21E3--SF97-------------------------
INT 21 - Novell NetWare - ACCOUNTING SERVICES - SUBMIT ACCOUNT CHARGE
	AH = E3h subfn 97h
	DS:SI -> request buffer (see #1299)
	ES:DI -> reply buffer (see #1301)
Return: AL = status (00h,C0h-C2h) (see #1296)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=96h,AH=E3h/SF=98h,AX=F217h/SF=97h

Format of NetWare "Submit Account Charge" request buffer:
Offset	Size	Description	(Table 1299)
 00h	WORD	length of following data (max 13Fh)
 02h	BYTE	97h (subfunction "Submit Account Charge")
 03h	WORD	(big-endian) service type
 05h	DWORD	(big-endian) amount to be charged to account
 09h	DWORD	(big-endian) amount of prior hold to be cancelled
 0Dh	WORD	(big-endian) type of bindery object
 0Fh	WORD	(big-endian) type of comment
		8000h-FFFFh reserved for experimental use
 11h	BYTE	length of object's name
 12h  N BYTEs	object name
	BYTE	length of comment
      N BYTEs	comment
SeeAlso: #1301
--------N-21E3--SF98-------------------------
INT 21 - Novell NetWare - ACCOUNTING SERVICES - SUBMIT ACCOUNT HOLD
	AH = E3h subfn 98h
	DS:SI -> request buffer (see #1300)
	ES:DI -> reply buffer (see #1301)
Return: AL = status (00h,C0h-C3h) (see #1296)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=96h,AH=E3h/SF=97h,AX=F217h/SF=98h

Format of NetWare "Submit Account Hold" request buffer:
Offset	Size	Description	(Table 1300)
 00h	WORD	length of following data (max 37h)
 02h	BYTE	98h (subfunction "Submit Account Hold")
 03h	DWORD	(big-endian) amount of account balance to reserve
 07h	WORD	(big-endian) type of bindery object
 09h	BYTE	length of object's name
 0Ah  N BYTEs	object name
SeeAlso: #1301

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1301)
 00h	WORD	0000h (no data returned)
SeeAlso: #1299,#1300,#1302,#1303
--------N-21E3--SF99-------------------------
INT 21 - Novell NetWare - ACCOUNTING SERVICES - SUBMIT ACCOUNT NOTE
	AH = E3h subfn 99h
	DS:SI -> request buffer (see #1302)
	ES:DI -> reply buffer (see #1301)
Return: AL = status (00h,C0h) (see #1296)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=96h,AX=F217h/SF=99h

Format of NetWare "Submit Account Note" request buffer:
Offset	Size	Description	(Table 1302)
 00h	WORD	length of following data (max 137h)
 02h	BYTE	99h (subfunction "Submit Account Note")
 03h	WORD	(big-endian) type of service
 05h	WORD	(big-endian) type of bindery object
 07h	WORD	(big-endian) type of comment
		8000h-FFFFh reserved for experimental use
 09h	BYTE	length of object's name
 0Ah  N BYTEs	object name
	BYTE	length of comment
      N BYTEs	comment
SeeAlso: #1301
--------N-21E3--SFC8-------------------------
INT 21 - Novell NetWare - FILE SERVER - CHECK CONSOLE PRIVILEGES
	AH = E3h subfn C8h
	DS:SI -> request buffer (see #1303)
	ES:DI -> reply buffer (see #1301)
Return: AL = status (00h,C6h) (see #1306)
Desc:	determine whether the caller is a console operator
Notes:	this function is supported by Advanced NetWare 2.1+
	NetWare determines console privileges by checking the file server's
	  OPERATOR property for the caller's object ID
SeeAlso: AH=E3h/SF=C9h,AH=E3h/SF=D1h,AX=F217h/SF=C8h

Format of NetWare "Check Console Privileges" request buffer:
Offset	Size	Description	(Table 1303)
 00h	WORD	0001h (length of following data)
 02h	BYTE	C8h (subfunction "Check Console Privileges")
SeeAlso: #1301
--------N-21E3--SFC9-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER DESCRIPTION STRINGS
	AH = E3h subfn C9h
	DS:SI -> request buffer (see #1304)
	ES:DI -> reply buffer (see #1305)
Return: AL = status
	    00h successful
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must be attached to the file server
SeeAlso: AH=E3h/SF=11h,AH=E3h/SF=CDh,AH=E3h/SF=E8h,AX=F217h/SF=C9h

Format of NetWare "Get File Server Description Strings" request buffer:
Offset	Size	Description	(Table 1304)
 00h	WORD	0001h (length of following data)
 02h	BYTE	C9h (subfunction "Get File Server Description Strings")
SeeAlso: #1305,#1521 at AX=F217h/SF=C9h

Format of NetWare "Get File Server Description Strings" reply buffer:
Offset	Size	Description	(Table 1305)
 00h	WORD	(call) 0200h (size of following results buffer)
 02h	var	ASCIZ name of company distributing this copy of NetWare
	var	ASCIZ version and revision
      9 BYTEs	ASCIZ revision date (mm/dd/yy)
	var	ASCIZ copyright notice
SeeAlso: #1304,#1521 at AX=F217h/SF=C9h
--------N-21E3--SFCA-------------------------
INT 21 - Novell NetWare - FILE SERVER - SET FILE SERVER DATE AND TIME
	AH = E3h subfn CAh
	DS:SI -> request buffer (see #1307)
	ES:DI -> reply buffer (see #1309)
Return: AL = status (00h,C6h) (see #1306)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=2Bh,AH=2Dh,AH=E3h/SF=C8h,AH=E7h,AX=F217h/SF=CAh,AX=F214h

(Table 1306)
Values for NetWare function status:
 00h	successful
 C6h	no console rights
SeeAlso: #1296,#1320

Format of NetWare "Set File Server Date and Time" request buffer:
Offset	Size	Description	(Table 1307)
 00h	WORD	0007h (length of following data)
 02h	BYTE	CAh (subfunction "Set File Server Date And Time")
 03h	BYTE	year (00-79 = 2000-2079, 80-99 = 1980-1999)
 04h	BYTE	month (1-12)
 05h	BYTE	day (1-31)
 06h	BYTE	hour (0-23)
 07h	BYTE	minute
 08h	BYTE	second
SeeAlso: #1309,#1402 at AX=F214h
--------N-21E3--SFCB-------------------------
INT 21 - Novell NetWare - FILE SERVER - DISABLE FILE SERVER LOGIN
	AH = E3h subfn CBh
	DS:SI -> request buffer (see #1308)
	ES:DI -> reply buffer (see #1309)
Return: AL = status (00h,C6h) (see #1306)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CCh,AH=E3h/SF=D3h,AX=F217h/SF=CBh

Format of NetWare "Disable File Server Login" request buffer:
Offset	Size	Description	(Table 1308)
 00h	WORD	0001h (length of following data)
 02h	BYTE	CBh (subfunction "Disable File Server Login")
SeeAlso: #1309,#1310

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1309)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1307,#1308,#1310
--------N-21E3--SFCC-------------------------
INT 21 - Novell NetWare - FILE SERVER - ENABLE FILE SERVER LOGIN
	AH = E3h subfn CCh
	DS:SI -> request buffer (see #1310)
	ES:DI -> reply buffer (see #1309)
Return: AL = status (00h,C6h) (see #1306)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CBh,AX=F217h/SF=CCh

Format of NetWare "Enable File Server Login" request buffer:
Offset	Size	Description	(Table 1310)
 00h	WORD	0001h (length of following data)
 02h	BYTE	CCh (subfunction "Enable File Server Login")
SeeAlso: #1309
--------N-21E3--SFCD-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER LOGIN STATUS
	AH = E3h subfn CDh
	DS:SI -> request buffer (see #1311)
	ES:DI -> reply buffer (see #1312)
Return: AL = status (00h,C6h) (see #1306)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CBh,AH=E3h/SF=CCh

Format of NetWare "Get File Server Login Status" request buffer:
Offset	Size	Description	(Table 1311)
 00h	WORD	0001h (length of following data)
 02h	BYTE	CDh (subfunction "Get File Server Login Status")
SeeAlso: #1312,#1522 at AX=F217h/SF=CDh

Format of NetWare "Get File Server Login Status" reply buffer:
Offset	Size	Description	(Table 1312)
 00h	WORD	(call) 0001h (size of following results buffer)
 02h	BYTE	login state (00h disabled, 01h enabled)
SeeAlso: #1311,#1522 at AX=F217h/SF=CDh
--------N-21E3--SFCE-------------------------
INT 21 - Novell NetWare - FILE SERVICES - PURGE ALL ERASED FILES
	AH = E3h subfn CEh
	DS:SI -> request buffer (see #1313)
	ES:DI -> reply buffer (see #1315)
Return: AL = status (00h,C6h) (see #1306)
Desc:	all files marked for deletion on the file server are purged, regardless
	  of which workstation actually erased them
Notes:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
	the calling workstation must have console operator privileges
SeeAlso: AH=13h,AH=E2h/SF=10h,AH=E3h/SF=C8h,AX=F217h/SF=CEh,AX=F244h

Format of NetWare "Purge All Erased Files" request buffer:
Offset	Size	Description	(Table 1313)
 00h	WORD	0001h (length of following data)
 02h	BYTE	CEh (subfunction "Purge All Erased Files")
SeeAlso: #1315
--------N-21E3--SFCF-------------------------
INT 21 - Novell NetWare - FILE SERVER - DISABLE TRANSACTION TRACKING
	AH = E3h subfn CFh
	DS:SI -> request buffer (see #1314)
	ES:DI -> reply buffer (see #1315)
Return: AL = status (00h,C6h) (see #1306)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D0h

Format of NetWare "Disable Transaction Tracking" request buffer:
Offset	Size	Description	(Table 1314)
 00h	WORD	0001h (length of following data)
 02h	BYTE	CFh (subfunction "Disable Transaction Tracking")
SeeAlso: #1315,#1316

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1315)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1313,#1314,#1316
--------N-21E3--SFD0-------------------------
INT 21 - Novell NetWare - FILE SERVER - ENABLE TRANSACTION TRACKING
	AH = E3h subfn D0h
	DS:SI -> request buffer (see #1316)
	ES:DI -> reply buffer (see #1315)
Return: AL = status (00h,C6h) (see #1320)
Desc:	restart transaction tracking after being stopped either explicitly by
	  AH=E3h/SF=CFh or automatically due to a full transaction volume
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CFh,AX=F217h/SF=D0h

Format of NetWare "Enable Transaction Tracking" request buffer:
Offset	Size	Description	(Table 1316)
 00h	WORD	0001h (length of following data)
 02h	BYTE	D0h (subfunction "Enable Transaction Tracking")
SeeAlso: #1315,#1314
--------N-21E3--SFD1-------------------------
INT 21 - Novell NetWare - FILE SERVER - SEND CONSOLE BROADCAST
	AH = E3h subfn D1h
	DS:SI -> request buffer (see #1317)
	ES:DI -> reply buffer (see #1319)
Return: AL = status (00h,C6h) (see #1320)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
	the broadcast message will not be received by workstations which have
	  disabled broadcasts with AH=E1h/SF=02h
SeeAlso: AH=E1h/SF=02h,AH=E1h/SF=09h,AH=E3h/SF=C8h,AH=E3h/SF=D3h
SeeAlso: AX=F217h/SF=D1h

Format of NetWare "Send Console Broadcast" request buffer:
Offset	Size	Description	(Table 1317)
 00h	WORD	length of following data (max A2h)
 02h	BYTE	D1h (subfunction "Send Console Broadcast")
 03h	BYTE	number of connections to receive message
		00h = all, else specific list below
 04h  N BYTEs	connection list
	BYTE	length of message (max 3Ch)
      N BYTEs	message
SeeAlso: #1319
--------N-21E3--SFD2-------------------------
INT 21 - Novell NetWare - FILE SERVER - CLEAR CONNECTION NUMBER
	AH = E3h subfn D2h
	DS:SI -> request buffer (see #1318)
	ES:DI -> reply buffer (see #1319)
Return: AL = status (00h,C6h) (see #1320)
Desc:	close the open files and release all file locks for a connection,
	  abort transactions if a TTS file server, and detach from the file
	  server
Notes:	this function is supported by Advanced NetWare 2.1+
	the caller must have SUPERVISOR privileges
SeeAlso: AH=E3h/SF=C9h,AH=E3h/SF=D1h,AX=F217h/SF=D2h,AX=F217h/SF=FEh

Format of NetWare "Clear Connection Number" request buffer:
Offset	Size	Description	(Table 1318)
 00h	WORD	0002h (length of following data)
 02h	BYTE	D2h (subfunction "Clear Connection Number")
 03h	BYTE	connection number
SeeAlso: #1319,#1573

Format of NetWare reply buffer:
Offset	Size	Description	(Table 1319)
 00h	WORD	(call) 0000h (no results returned)
SeeAlso: #1317,#1318,#1321
--------N-21E3--SFD3-------------------------
INT 21 - Novell NetWare - FILE SERVER - DOWN FILE SERVER
	AH = E3h subfn D3h
	DS:SI -> request buffer (see #1321)
	ES:DI -> reply buffer (see #1319)
Return: AL = status (00h,C6h,FFh) (see #1320)
Desc:	take down the file server
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have SUPERVISOR privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CBh,AH=E3h/SF=CFh,AH=E3h/SF=D1h

(Table 1320)
Values for NetWare function status:
 00h	successful
 C6h	no console rights
 FFh	files open
SeeAlso: #1306,#1348

Format of NetWare "Down File Server" request buffer:
Offset	Size	Description	(Table 1321)
 00h	WORD	0002h (length of following data)
 02h	BYTE	D3h (subfunction "Down File Server")
 03h	BYTE	flag: force down even if files open if nonzero
SeeAlso: #1319
--------N-21E3--SFD4-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SYSTEM STATISTICS
	AH = E3h subfn D4h
	DS:SI -> request buffer (see #1322)
	ES:DI -> reply buffer (see #1323)
Return: AL = status (00h,C6h) (see #1320)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=0Eh,AH=E3h/SF=C8h,AH=E3h/SF=D9h,AH=E3h/SF=E7h,AH=E3h/SF=E8h
SeeAlso: AX=F217h/SF=D4h

Format of NetWare "Get File System Statistics" request buffer:
Offset	Size	Description	(Table 1322)
 00h	WORD	0001h (length of following data)
 02h	BYTE	D4h (subfunction "Get File System Statistics")
SeeAlso: #1323,#1523 at AX=F217h/SF=D4h

Format of NetWare "Get File System Statistics" reply buffer:
Offset	Size	Description	(Table 1323)
 00h	WORD	(call) 0028h (size of following results buffer)
 02h	DWORD	clock ticks since system started
 06h	WORD	maximum open files set by configuration
 08h	WORD	maximum files open concurrently
 0Ah	WORD	current number of open files
 0Ch	DWORD	total files opened
 10h	DWORD	total file read requests
 14h	DWORD	total file write requests
 18h	WORD	current changed FATs
 1Ah	WORD	total changed FATs
 1Ch	WORD	number of FAT write errors
 1Eh	WORD	number of fatal FAT write errors
 20h	WORD	number of FAT scan errors
 22h	WORD	maximum concurrently-indexed files
 24h	WORD	current number of indexed files
 26h	WORD	number of attached indexed files
 28h	WORD	number of indexed files available
Note:	all fields except the first are big-endian
SeeAlso: #1322,#1523 at AX=F217h/SF=D4h
--------N-21E3--SFD5-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET TRANSACTION TRACKING STATISTICS
	AH = E3h subfn D5h
	DS:SI -> request buffer (see #1324)
	ES:DI -> reply buffer (see #1325)
Return: AL = status (00h,C6h) (see #1320)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=CFh,AH=E3h/SF=D0h,AH=E3h/SF=E8h
SeeAlso: AX=F217h/SF=D5h

Format of NetWare "Get Transaction Tracking Statistics" request buffer:
Offset	Size	Description	(Table 1324)
 00h	WORD	0001h (length of following data)
 02h	BYTE	D5h (subfunction "TTS Get Statistics")
SeeAlso: #1325,#1524 at AX=F217h/SF=D5h

Format of NetWare "Get Transaction Tracking Statistics" reply buffer:
Offset	Size	Description	(Table 1325)
 00h	WORD	(call) length of following results buffer (max 1BCh)
 02h	DWORD	(big-endian) clock ticks since system started
 06h	BYTE	transaction tracking supported if nonzero
		(all following fields are invalid if zero)
 07h	BYTE	transaction tracking enabled
 08h	WORD	(big-endian) transaction volume number
 0Ah	WORD	(big-endian) maximum simultaneous transactions configured
 0Ch	WORD	(big-endian) maximum simultaneous transactions since startup
 0Eh	WORD	(big-endian) current transactions in progress
 10h	DWORD	(big-endian) total transactions performed
 14h	DWORD	(big-endian) total write transactions
 18h	DWORD	(big-endian) total transactions backed out
 1Ch	WORD	(big-endian) number of unfilled backout requests
 1Eh	WORD	(big-endian) disk blocks used for transaction tracking
 20h	DWORD	(big-endian) blocks allocated for tracked-file FATs
 24h	DWORD	(big-endian) number of file size changes during a transaction
 28h	DWORD	(big-endian) number of file truncations during a transaction
 2Ch	BYTE	number of records following
 2Dh	Active Transaction Records [array]
	Offset	Size	Description
	 00h	BYTE	logical connection number
	 01h	BYTE	task number
SeeAlso: #1324,#1524 at AX=F217h/SF=D5h
--------N-21E3--SFD6-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET DISK CACHE STATISTICS
	AH = E3h subfn D6h
	DS:SI -> request buffer (see #1326)
	ES:DI -> reply buffer (see #1327)
Return: AL = status (00h,C6h) (see #1320)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D5h,AH=E3h/SF=D8h,AH=E3h/SF=D9h,AH=E3h/SF=E6h
SeeAlso: AX=F217h/SF=D6h

Format of NetWare "Get Disk Cache Statistics" request buffer:
Offset	Size	Description	(Table 1326)
 00h	WORD	0001h (length of following data)
 02h	BYTE	D6h (subfunction "Get Disk Cache Statistics")
SeeAlso: #1327,#1525 at AX=F217h/SF=D6h

Format of NetWare "Get Disk Cache Statistics" reply buffer:
Offset	Size	Description	(Table 1327)
 00h	WORD	(call) 004Eh (length of following results buffer)
 02h	DWORD	clock ticks since system started
 06h	WORD	number of cache buffers
 08h	WORD	size of cache buffer in bytes
 0Ah	WORD	number of dirty cache buffers
 0Ch	DWORD	number of cache read requests
 10h	DWORD	number of cache write requests
 14h	DWORD	number of cache hits
 18h	DWORD	number of cache misses
 1Ch	DWORD	number of physical read requests
 20h	DWORD	number of physical write requests
 24h	WORD	number of physical read errors
 26h	WORD	number of physical write errors
 28h	DWORD	cache get requests
 2Ch	DWORD	cache full write requests
 30h	DWORD	cache partial write requests
 34h	DWORD	background dirty writes
 38h	DWORD	background aged writes
 3Ch	DWORD	total cache writes
 40h	DWORD	number of cache allocations
 44h	WORD	thrashing count
 46h	WORD	number of times LRU block was dirty
 48h	WORD	number of reads on cache blocks not yet filled by writes
 4Ah	WORD	number of times a fragmented write occurred
 4Ch	WORD	number of cache hits on unavailable block
 4Eh	WORD	number of times a cache block was scrapped
Note:	all fields except the first are big-endian
SeeAlso: #1326,#1525 at AX=F217h/SF=D6h
--------N-21E3--SFD7-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET DRIVE MAPPING TABLE
	AH = E3h subfn D7h
	DS:SI -> request buffer (see #1328)
	ES:DI -> reply buffer (see #1329)
Return: AL = status (00h,C6h) (see #1320)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D6h,AH=E3h/SF=D9h,AH=E3h/SF=E6h,AH=E3h/SF=E9h
SeeAlso: AX=F217h/SF=D7h

Format of NetWare "Get Drive Mapping Table" request buffer:
Offset	Size	Description	(Table 1328)
 00h	WORD	0001h (length of following data)
 02h	BYTE	D7h (subfunction "Get Drive Mapping Table")
SeeAlso: #1329,#1526 at AX=F217h/SF=D7h

Format of NetWare "Get Drive Mapping Table" reply buffer:
Offset	Size	Description	(Table 1329)
 00h	WORD	(call) 00ECh (length of following results buffer)
 02h	DWORD	(big-endian) clock tick elapsed since system started
 06h	BYTE	fault tolerance (SFT) level
 07h	BYTE	number of logical drives attached to server
 08h	BYTE	number of physical drives attached to server
 09h  5 BYTEs	disk channel types (00h none, 01h XT, 02h AT, 03h SCSI,
		  04h disk coprocessor drive, 32h-FFh value-added drive types)
 0Eh	WORD	(big-endian) number of outstanding controller commands
 10h 32 BYTEs	drive mapping table (FFh = no such drive)
 30h 32 BYTEs	drive mirror table (secondary physical drive, FFh = none)
 50h 32 BYTEs	dead mirror table (last drive mapped to, FFh if never mirrored)
 70h	BYTE	physical drive being remirrored (FFh = none)
 71h	BYTE	reserved
 72h	DWORD	(big-endian) remirrored block
 76h 60 BYTEs	SFT error table (internal error counters)
SeeAlso: #1328,#1526 at AX=F217h/SF=D7h
--------N-21E3--SFD8-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET PHYSICAL DISK STATISTICS
	AH = E3h subfn D8h
	DS:SI -> request buffer (see #1330)
	ES:DI -> reply buffer (see #1331)
Return: AL = status (00h,C6h) (see #1320)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D9h,AH=E3h/SF=E9h,AX=F217h/SF=D8h

Format of NetWare "Get Physical Disk Statistics" request buffer:
Offset	Size	Description	(Table 1330)
 00h	WORD	0002h (length of following data)
 02h	BYTE	D8h (subfunction "Get Physical Disk Statistics")
 03h	BYTE	physical disk number
SeeAlso: #1331,#1527 at AX=F217h/SF=D8h

Format of NetWare "Get Physical Disk Statistics" reply buffer:
Offset	Size	Description	(Table 1331)
 00h	WORD	(call) 005Dh (size of following results record)
 02h	DWORD	(big-endian) clock ticks since system started
 06h	BYTE	physical disk channel
 07h	BYTE	flag: drive removable if nonzero
 08h	BYTE	physical drive type
 09h	BYTE	drive number within controller
 0Ah	BYTE	controller number
 0Bh	BYTE	controller type
 0Ch	DWORD	(big-endian) size of drive in 4K disk blocks
 10h	WORD	(big-endian) number of cylinders on drive
 12h	BYTE	number of heads
 13h	BYTE	number of sectors per track
 14h 64 BYTEs	ASCIZ drive make and model
 54h	WORD	(big-endian) number of I/O errors
 56h	DWORD	(big-endian) start of Hot Fix table
 5Ah	WORD	(big-endian) size of Hot Fix table
 5Ch	WORD	(big-endian) number of Hot Fix blocks available
 5Eh	BYTE	flag: Hot Fix disabled if nonzero
SeeAlso: #1330,#1527 at AX=F217h/SF=D8h
--------N-21E3--SFD9-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET DISK CHANNEL STATISTICS
	AH = E3h subfn D9h
	DS:SI -> request buffer (see #1332)
	ES:DI -> reply buffer (see #1333)
Return: AL = status (00h,C6h) (see #1320)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=D8h,AH=E3h/SF=E6h,AH=E3h/SF=E9h
SeeAlso: AX=F217h/SF=D9h

Format of NetWare "Get Disk Channel Statistics" request buffer:
Offset	Size	Description	(Table 1332)
 00h	WORD	0002h (length of following data)
 02h	BYTE	D9h (subfunction "Get Disk Channel Statistics")
 03h	BYTE	channel number
SeeAlso: #1333,#1528 at AX=F217h/SF=D9h

Format of NetWare "Get Disk Channel Statistics" reply buffer:
Offset	Size	Description	(Table 1333)
 00h	WORD	(call) 00A8h (size of following results record)
 02h	DWORD	(big-endian) clock ticks since system started
 06h	WORD	(big-endian) channel run state (see #1334)
 08h	WORD	(big-endian) channel synchronization state (see #1335)
 0Ah	BYTE	driver type
 0Bh	BYTE	major version of driver
 0Ch	BYTE	minor version of driver
 0Dh 65 BYTEs	ASCIZ driver description
 4Eh	WORD	(big-endian) first I/O address used
 50h	WORD	(big-endian) length of first I/O address
 52h	WORD	(big-endian) second I/O address used
 54h	WORD	(big-endian) length of second I/O address
 56h  3 BYTEs	first shared memory address
 59h  2 BYTEs	length of first shared memory address
 5Bh  3 BYTEs	second shared memory address
 5Eh  2 BYTEs	length of second shared memory address
 60h	BYTE	first interrupt number in-use flag
 61h	BYTE	first interrupt number used
 62h	BYTE	second interrupt number in-use flag
 63h	BYTE	second interrupt number used
 64h	BYTE	first DMA channel in-use flag
 65h	BYTE	first DMA channel used
 66h	BYTE	second DMA channel in-use flag
 67h	BYTE	second DMA channel used
 68h	BYTE	flags
 69h	BYTE	reserved
 6Ah 80 BYTEs	ASCIZ configuration description
SeeAlso: #1332,#1528 at AX=F217h/SF=D9h

(Table 1334)
Values for channel run state:
 0000h	running
 0001h	being stopped
 0002h	stopped
 0003h	nonfunctional
SeeAlso: #1333,#1335

(Table 1335)
Values for channel synchronization state:
 0000h	not in use
 0002h	used by NetWare, no other requests
 0004h	used by NetWare, other requests
 0006h	in use, not needed by NetWare
 0008h	in use, needed by NetWare
 000Ah	channel released, NetWare should use it
SeeAlso: #1333,#1334
--------N-21E3--SFDA-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTION'S TASK INFORMATION
	AH = E3h subfn DAh
	DS:SI -> request buffer (see #1336)
	ES:DI -> reply buffer (see #1337)
Return: AL = status (00h,C6h) (see #1348)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DBh,AH=E3h/SF=DFh,AH=E3h/SF=E1h,AH=E3h/SF=E5h
SeeAlso: AX=F217h/SF=DAh

Format of NetWare "Get Connection's Task Information" request buffer:
Offset	Size	Description	(Table 1336)
 00h	WORD	0003h (length of following data)
 02h	BYTE	DAh (subfunction "Get Connection's Task Information")
 03h	WORD	(big-endian) logical connection number
SeeAlso: #1337,#1529 at AX=F217h/SF=DAh

Format of NetWare "Get Connection's Task Information" reply buffer:
Offset	Size	Description	(Table 1337)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	BYTE	lock status of connection (see #1338)
 03h	var	Lock Status Information (see #1339)
 N	BYTE	number of records following
 N+1	Active Task Information Records [array]
	Offset	Size	Description
	 00h	BYTE	task number (01h-FFh)
	 01h	BYTE	task state
			01h in TTS explicit transaction
			02h in TTS implicit transaction
			04h shared fileset lock active
SeeAlso: #1336,#1529 at AX=F217h/SF=DAh

(Table 1338)
Values for lock status of connection:
 00h	no locks
 01h	waiting on physical record lock
 02h	waiting on file lock
 03h	waiting on logical record lock
 04h	waiting on semaphore
SeeAlso: #1337,#1339

Format of Lock Status Information:
Offset	Size	Description	(Table 1339)
---lock status 00h---
 no fields
---lock status 01h---
 00h	BYTE	number of waiting task
 01h	DWORD	start address
 05h	DWORD	end address
 09h	BYTE	volume number
 0Ah	WORD	directory entry number
 0Ch 14 BYTEs	ASCIZ filename
---lock status 02h---
 00h	BYTE	number of waiting task
 01h	BYTE	volume number
 02h	WORD	directory entry number
 04h 14 BYTEs	ASCIZ filename
---lock status 03h---
 00h	BYTE	number of waiting task
 01h	BYTE	length of record name
 02h  N BYTEs	ASCIZ record name
---lock status 04h---
 00h	BYTE	number of waiting task
 01h	BYTE	length of semaphore's name
 02h  N BYTEs	ASCIZ semaphore name
SeeAlso: #1337,#1338
--------N-21E3--SFDB-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTION'S OPEN FILES (OLD)
	AH = E3h subfn DBh
	DS:SI -> request buffer (see #1340)
	ES:DI -> reply buffer (see #1341)
Return: AL = status (00h,C6h) (see #1348)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E2h/SF=1Ah,AH=E3h/SF=C8h,AH=E3h/SF=DAh,AH=E3h/SF=DCh,AH=E3h/SF=DFh
SeeAlso: AH=E3h/SF=E1h,AX=F217h/SF=DBh

Format of NetWare "Get Connection's Open Files (old)" request buffer:
Offset	Size	Description	(Table 1340)
 00h	WORD	0005h (length of following data)
 02h	BYTE	DBh (subfunction "Get Connection's Open Files")
 03h	WORD	(big-endian) logical connection number
 05h	WORD	(big-endian) last record seen (0000h on first call)
SeeAlso: #1341,#1530 at AX=F217h/SF=DBh

Format of NetWare "Get Connection's Open Files (old)" reply buffer:
Offset	Size	Description	(Table 1341)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" field on next call)
		0000h if no more records
 04h	BYTE	number of records following
 05h	var	array of File Information Records (see #1342)
SeeAlso: #1340,#1530 at AX=F217h/SF=DBh

Format of NetWare File Information Record:
Offset	Size	Description	(Table 1342)
 00h	BYTE	task number
 01h	BYTE	lock flags (see #1343)
 02h	BYTE	access flags (see #1344)
 03h	BYTE	lock type
		00h no lock
		FEh file lock
		FFh locked by Begin Share File Set
 04h	BYTE	volume number (00h-1Fh)
 05h	WORD	(big-endian) directory entry number
 07h 14 BYTEs	ASCIZ filename
SeeAlso: #1341

Bitfields for lock flags:
Bit(s)	Description	(Table 1343)
 0	file is locked
 1	file opened Shareable
 2	logged
 3	file opened Normal
 6	TTS holding lock
 7	Transaction Flag set on file
SeeAlso: #1342,#1344

Bitfields for access flags:
Bit(s)	Description	(Table 1344)
 0	file open for reading by calling station
 1	file open for writing by calling station
 2	deny reads by other stations
 3	deny writes by other stations
 4	file detached
 5	TTS Holding Detach
 6	TTS Holding Open
SeeAlso: #1342,#1343
--------N-21E3--SFDC-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTIONS USING A FILE
	AH = E3h subfn DCh
	DS:SI -> request buffer (see #1345)
	ES:DI -> reply buffer (see #1346)
Return: AL = status (00h,C6h) (see #1348)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DAh,AH=E3h/SF=DBh,AH=E3h/SF=DFh,AH=E3h/SF=E1h
SeeAlso: AX=F217h/SF=DCh

Format of NetWare "Get Connections Using a File" request buffer:
Offset	Size	Description	(Table 1345)
 00h	WORD	length of following data (max 104h)
 02h	BYTE	DCh (subfunction "Get Connections Using a File")
 03h	WORD	(big-endian) last record (0000h on first call)
 05h	BYTE	directory handle
 06h	BYTE	length of file path
 07h  N BYTEs	ASCIZ file path
SeeAlso: #1346,#1531 at AX=F217h/SF=DCh

Format of NetWare "Get Connections Using a File" reply buffer:
Offset	Size	Description	(Table 1346)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	(big-endian) count of tasks which have opened or logged file
 04h	WORD	(big-endian) count of tasks which have opened file
 06h	WORD	(big-endian) count of opens for reading
 08h	WORD	(big-endian) count of opens for writing
 0Ah	WORD	(big-endian) deny read count
 0Ch	WORD	(big-endian) deny write count
 0Eh	WORD	next request record (place in "last record" field on next call)
		0000h if no more records
 10h	BYTE	locked flag
		00h not locked exclusively
		else locked exclusively
 11h	BYTE	number of records following
 12h	var	array of File Usage Information Records (see #1347)
SeeAlso: #1345,#1531 at AX=F217h/SF=DCh

Format of NetWare File Usage Information Record:
Offset	Size	Description	(Table 1347)
 00h	WORD	(big-endian) logical connection number
 02h	BYTE	task number
 03h	BYTE	lock flags (see #1343)
 04h	BYTE	access flags (see #1344)
 05h	BYTE	lock type
		00h no lock
		FEh file lock
		FFh locked by Begin Share File Set
--------N-21E3--SFDD-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET PHYSICAL RECORD LOCKS BY CONN&FILE
	AH = E3h subfn DDh
	DS:SI -> request buffer (see #1349)
	ES:DI -> reply buffer (see #1350)
Return: AL = status (00h,C6h,FFh) (see #1348)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DEh,AH=E3h/SF=DFh,AX=F217h/SF=DDh

(Table 1348)
Values for NetWare function status:
 00h	successful
 C6h	no console rights
 FFh	file not open
SeeAlso: #1320,#1370

Format of NetWare "Get Phys Record Locks by Conn and File" request buffer:
Offset	Size	Description	(Table 1349)
 00h	WORD	0016h (length of following data)
 02h	BYTE	DDh (subfunction "Get Physical Record Locks by Connection and
		  File")
 03h	WORD	(big-endian) logical connection number
 05h	WORD	(big-endian) last record seen (0000h on first call)
 07h	BYTE	volume number (00h-1Fh)
 08h	WORD	(big-endian) directory handle
 0Ah 14 BYTEs	ASCIZ filename
SeeAlso: #1350,#1532 at AX=F217h/SF=DDh

Format of NetWare "Get Phys Record Locks by Conn and File" reply buffer:
Offset	Size	Description	(Table 1350)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" on next call)
		0000h if no more records
 04h	BYTE	number of physical record locks
 05h	BYTE	number of records following
 06h	var	array of Physical Record Lock Info records (see #1351)
SeeAlso: #1349,#1532 at AX=F217h/SF=DDh

Format of NetWare Physical Record Lock Info:
Offset	Size	Description	(Table 1351)
 00h	BYTE	task number
 01h	BYTE	lock status (see #1352)
 02h	DWORD	(big-endian) starting offset of record in file
 06h	DWORD	(big-endian) ending offset of record in file
SeeAlso: #1350

Bitfields for lock status:
Bit(s)	Description	(Table 1352)
 0	exclusive lock
 1	shareable lock
 2	logged
 6	lock held by TTS
SeeAlso: #1351
--------N-21E3--SFDE-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET PHYSICAL RECORD LOCKS BY FILE
	AH = E3h subfn DEh
	DS:SI -> request buffer (see #1353)
	ES:DI -> reply buffer (see #1354)
Return: AL = status (00h,C6h,FFh) (see #1348)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DDh,AH=E3h/SF=DFh,AX=F217h/SF=DEh

Format of NetWare "Get Physical Record Locks by File" request buffer:
Offset	Size	Description	(Table 1353)
 00h	WORD	length of following data (max 104h)
 02h	BYTE	DEh (subfunction "Get Physical Record Locks by File")
 03h	WORD	(big-endian) last record seen (0000h on first call)
 05h	BYTE	directory handle
 06h	BYTE	length of filename
 07h  N BYTEs	ASCIZ filename
SeeAlso: #1354,#1533 at AX=F217h/SF=DEh

Format of NetWare "Get Physical Record Locks by File" reply buffer:
Offset	Size	Description	(Table 1354)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" on next call)
		0000h if no more records
 04h	BYTE	number of physical record locks
 05h	BYTE	number of records following
 06h	var	array of Physical Record Lock Info records (see #1355)
SeeAlso: #1353,#1533 at AX=F217h/SF=DEh

Format of NetWare Physical Record Lock Info:
Offset	Size	Description	(Table 1355)
 00h	WORD	(big-endian) number of tasks logging record
 02h	WORD	(big-endian) number of tasks with shareable lock
 04h	DWORD	(big-endian) starting offset of record in file
 08h	DWORD	(big-endian) ending offset of record in file
 0Ch	WORD	(big-endian) logical connection number
 0Eh	BYTE	task number
 0Fh	BYTE	lock type
		00h none
		FEh file lock
		FFh Begin Share File Set lock
SeeAlso: #1354
--------N-21E3--SFDF-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET LOGICAL RECORDS BY CONNECTION
	AH = E3h subfn DFh
	DS:SI -> request buffer (see #1356)
	ES:DI -> reply buffer (see #1357)
Return: AL = status (00h,C6h) (see #1348)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DDh,AH=E3h/SF=E0h,AH=E3h/SF=E2h
SeeAlso: AX=F217h/SF=DFh

Format of NetWare "Get Logical Records by Connection" request buffer:
Offset	Size	Description	(Table 1356)
 00h	WORD	0005h (length of following data)
 02h	BYTE	DFh (subfunction "Get Logical Records By Connection")
 03h	WORD	(big-endian) logical connection number
 05h	WORD	(big-endian) last record seen (0000h on first call)
SeeAlso: #1357,#1534 at AX=F217h/SF=DFh

Format of NetWare "Get Logical Records by Connection" reply buffer:
Offset	Size	Description	(Table 1357)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" field on next call)
		0000h if no more locked records
 04h	BYTE	number of records following
 05h	var	array of Logical Lock Information Records (see #1358)
SeeAlso: #1356,#1534 at AX=F217h/SF=DFh

Format of NetWare Logical Lock Information Record:
Offset	Size	Description	(Table 1358)
 00h	BYTE	task number
 01h	BYTE	lock status (see #1352)
 02h	BYTE	length of logical lock's name
 03h  N BYTEs	logical lock's name
SeeAlso: #1357
--------N-21E3--SFE0-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET LOGICAL RECORD INFORMATION
	AH = E3h subfn E0h
	DS:SI -> request buffer (see #1359)
	ES:DI -> reply buffer (see #1360)
Return: AL = status (00h,C6h) (see #1348)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DDh,AH=E3h/SF=DFh,AH=E3h/SF=E2h
SeeAlso: AX=F217h/SF=E0h

Format of NetWare "Get Logical Record Information" request buffer:
Offset	Size	Description	(Table 1359)
 00h	WORD	length of following data (max 67h)
 02h	BYTE	E0h (subfunction "Get Logical Record Information")
 03h	WORD	(big-endian) last record seen (0000h on first call)
 05h	BYTE	length of logical record's name
 06h  N BYTEs	logical record's name
SeeAlso: #1360,#1535 at AH=E3h/SF=E0h

Format of NetWare "Get Logical Record Information" reply buffer:
Offset	Size	Description	(Table 1360)
 00h	WORD	(call) size of following results record (max 200h)
 02h	WORD	(big-endian) number of logical connections logging the record
 04h	WORD	(big-endian) number of logical connections with shareable lock
 06h	WORD	(big-endian) next request record (place in "last record" field
		  on next call)
 08h	BYTE	locked exclusively if nonzero
 09h	BYTE	number of records following
 0Ah	var	array of Task Information Records (see #1361)
SeeAlso: #1359,#1535 at AH=E3h/SF=E0h

Format of NetWare Task Information Record:
Offset	Size	Description	(Table 1361)
 00h	WORD	(big-endian) logical connection number
 02h	BYTE	task number
 03h	BYTE	lock status (see #1352)
SeeAlso: #1360
--------N-21E3--SFE1-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTION'S SEMAPHORES
	AH = E3h subfn E1h
	DS:SI -> request buffer (see #1362)
	ES:DI -> reply buffer (see #1363)
Return: AL = status (00h,C6h) (see #1348)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DBh,AH=E3h/SF=DFh,AH=E3h/SF=E2h
SeeAlso: AX=F217h/SF=E1h

Format of NetWare "Get Connection's Semaphores" request buffer:
Offset	Size	Description	(Table 1362)
 00h	WORD	0005h (length of following data)
 02h	BYTE	E1h (subfunction "Get Connection's Semaphores")
 03h	WORD	(big-endian) logical connection number
 05h	WORD	(big-endian) last record seen (0000h on first call)
SeeAlso: #1363,#1536 at AX=F217h/SF=E1h

Format of NetWare "Get Connection's Semaphores" reply buffer:
Offset	Size	Description	(Table 1363)
 00h	WORD	(call) size of following results record (max 1FEh)
 02h	WORD	next request record (place in "last record" field on next call)
 04h	BYTE	number of records following
 05h	var	array of Semaphore Information Records (see #1364)
SeeAlso: #1362,#1536 at AX=F217h/SF=E1h

Format of NetWare Semaphore Information Record:
Offset	Size	Description	(Table 1364)
 00h	WORD	(big-endian) open count
 02h	BYTE	semaphore value (-128 to 127)
 03h	BYTE	task number
 04h	BYTE	lock type
 05h	BYTE	length of semaphore's name
 06h  N BYTEs	semaphore's name
     14 BYTEs	filename
SeeAlso: #1363
--------N-21E3--SFE2-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET SEMAPHORE INFORMATION
	AH = E3h subfn E2h
	DS:SI -> request buffer (see #1365)
	ES:DI -> reply buffer (see #1366)
Return: AL = status (00h,C6h) (see #1370)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=E1h,AX=F217h/SF=E2h

Format of NetWare "Get Semaphore Information" request buffer:
Offset	Size	Description	(Table 1365)
 00h	WORD	length of following data (max 83h)
 02h	BYTE	E2h (subfunction "Get LAN Driver's Configuration Information")
 03h	WORD	(big-endian) last record seen (0000h on first call)
 05h	BYTE	length of semaphore's name (01h-7Fh)
 06h  N BYTEs	semaphore's name
SeeAlso: #1366,#1537 at AX=F217h/SF=E2h

Format of NetWare "Get Semaphore Information" reply buffer:
Offset	Size	Description	(Table 1366)
 00h	WORD	(call) size of following results buffer (max 1FEh)
 02h	WORD	next request record (place in "last record" on next call)
		0000h if no more
 04h	WORD	(big-endian) number of logical connections opening semaphore
 06h	BYTE	semaphore value (-127 to 128)
 07h	BYTE	number of records following
 08h	var	array of Semaphore Information records (see #1367)
SeeAlso: #1366,#1537 at AX=F217h/SF=E2h

Format of NetWare Semaphore Information:
Offset	Size	Description	(Table 1367)
 00h	WORD	(big-endian) logical connection number
 02h	BYTE	task number
SeeAlso: #1366
--------N-21E3--SFE3-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET LAN DRIVER'S CONFIGURATION INFO
	AH = E3h subfn E3h
	DS:SI -> request buffer (see #1368)
	ES:DI -> reply buffer (see #1369)
Return: AL = status (00h,C6h) (see #1370)
Notes:	this function is supported by Advanced NetWare 2.1+
	the calling workstation must have console operator privileges
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=E7h,AH=E3h/SF=E8h,AX=F217h/SF=E3h

Format of NetWare "Get LAN Driver's Configuration Info" request buffer:
Offset	Size	Description	(Table 1368)
 00h	WORD	0002h (length of following data)
 02h	BYTE	E3h (subfunction "Get LAN Driver's Configuration Information")
 03h	BYTE	LAN board (00h-03h)
SeeAlso: #1369,#1538 at AX=F217h/SF=E3h

Format of NetWare "Get LAN Driver's Configuration Info" reply buffer:
Offset	Size	Description	(Table 1369)
 00h	WORD	(call) 00ACh (size of following results buffer)
 02h  4 BYTEs	network number
 06h  6 BYTEs	node number
 0Ch	BYTE	LAN driver installed (00h no--remaining fields invalid)
 0Dh	BYTE	option number selected at configuration time
 0Eh 160 BYTEs	configuration text
		ASCIZ hardware type
		ASCIZ hardware settings
SeeAlso: #1368,#1538 at AX=F217h/SF=E3h
--------N-21E3--SFE5-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET CONNECTION'S USAGE STATISTICS
	AH = E3h subfn E5h
	DS:SI -> request buffer (see #1371)
	ES:DI -> reply buffer (see #1372)
Return: AL = status (00h,C6h) (see #1370)
Notes:	this function is supported by Advanced NetWare 2.1+
	one must have console operator privileges to get statistics for logical
	  connections other than one's own
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=DAh,AH=E3h/SF=DBh,AH=E3h/SF=E1h
SeeAlso: AX=F217h/SF=E5h

(Table 1370)
Values for NetWare function status:
 00h	successful
 C6h	no console rights
SeeAlso: #1348,#1390

Format of NetWare "Get Connection's Usage Statistics" request buffer:
Offset	Size	Description	(Table 1371)
 00h	WORD	0003h (length of following data)
 02h	BYTE	E5h (subfunction "Get Connection's Usage Statistics")
 03h	WORD	(big-endian) logical connection number
SeeAlso: #1372,#1539 at AX=F217h/SF=E5h

Format of NetWare "Get Connection's Usage Statistics" reply buffer:
Offset	Size	Description	(Table 1372)
 00h	WORD	(call) 0014h (size of following results record)
 02h	DWORD	(big-endian) clock ticks since server started
 06h  6 BYTEs	bytes read
 0Ch  6 BYTEs	bytes written
 12h	DWORD	(big-endian) total request packets
SeeAlso: #1371,#1539 at AX=F217h/SF=E5h
--------N-21E3--SFE6-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET BINDERY OBJECT DISK SPACE LEFT
	AH = E3h subfn E6h
	DS:SI -> request buffer (see #1373)
	ES:DI -> reply buffer (see #1374)
Return: AL = status (00h,C6h) (see #1370)
Notes:	this function is supported by Advanced NetWare 2.1+
	one must have console operator privileges to get the free space for
	  other bindery objects
SeeAlso: AH=E3h/SF=C8h,AH=E3h/SF=E8h,AH=E3h/SF=E9h

Format of NetWare "Get Bindery Object Disk Space Left" request buffer:
Offset	Size	Description	(Table 1373)
 00h	WORD	0005h (length of following data)
 02h	BYTE	E6h (subfunction "Get Bindery Object Disk Space Left")
 03h	DWORD	(big-endian) object ID
SeeAlso: #1374,#1540 at AX=F217h/SF=E6h

Format of NetWare "Get Bindery Object Disk Space Left" reply buffer:
Offset	Size	Description	(Table 1374)
 00h	WORD	(call) 000Fh (size of following results buffer)
 02h	DWORD	(big-endian) clock ticks elapsed since server started
 06h	DWORD	(big-endian) object ID
 0Ah	DWORD	(big-endian) 4K disk blocks available to user
 0Eh	BYTE	restrictions (00h enforced, FFh not enforced)
SeeAlso: #1373,#1540 at AX=F217h/SF=E6h
--------N-21E3--SFE7-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER LAN I/O STATISTICS
	AH = E3h subfn E7h
	DS:SI -> request buffer (see #1375)
	ES:DI -> reply buffer (see #1376)
Return: AL = status
	    00h successful
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=0Eh,AH=E3h/SF=11h,AH=E3h/SF=D3h,AH=E3h/SF=E8h,AH=E7h
SeeAlso: AX=F217h/SF=E7h

Format of NetWare "Get File Server LAN I/O Statistics" request buffer:
Offset	Size	Description	(Table 1375)
 00h	WORD	0001h (length of following data)
 02h	BYTE	E7h (subfunction "Get File Server LAN I/O Statistics")
SeeAlso: #1376,#1541 at AX=F217h/SF=E7h

Format of NetWare "Get File Server LAN I/O Statistics" reply buffer:
Offset	Size	Description	(Table 1376)
 00h	WORD	(call) 0042h (size of following results buffer)
 02h	DWORD	clock ticks since system started
 06h	WORD	total routing buffers
 08h	WORD	maximum routing buffers used
 0Ah	WORD	current routing buffers used
 0Ch	DWORD	total file service packets
 10h	WORD	number of file service packets buffered
 12h	WORD	number of invalid connection packets
 14h	WORD	packets with bad logical connection numbers
 16h	WORD	number of packets received during processing
 18h	WORD	number of requests reprocessed
 1Ah	WORD	packets with bad sequence numbers
 1Ch	WORD	number of duplicate replies sent
 1Eh	WORD	number of acknowledgements sent
 20h	WORD	number of packets with bad request types
 22h	WORD	requests to attach to ws for which a request is being processed
 24h	WORD	requests to attach from ws which is already attaching
 26h	WORD	number of forged detach requests
 28h	WORD	detach requests with bad connection number
 2Ah	WORD	requests to detach from ws for which requests pending
 2Ch	WORD	number of cancelled replies
 2Eh	WORD	packets discarded due to excessive hop count
 30h	WORD	packets discarded due to unknown net
 32h	WORD	incoming packets discarded for lack of DGroup buffer
 34h	WORD	outgoing packets discarded due to lack of buffer
 36h	WORD	received packets destined for B,C, or D side drivers
 38h	DWORD	number of NetBIOS packets propagated through net
 3Ch	DWORD	total number of non-file-service packets
 40h	DWORD	total number of routed packets
Note:	all fields except the first are big-endian
SeeAlso: #1376,#1541 at AX=F217h/SF=E7h
--------N-21E3--SFE8-------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER MISC INFORMATION
	AH = E3h subfn E8h
	DS:SI -> request buffer (see #1377)
	ES:DI -> reply buffer (see #1378)
Return: AL = status (00h,C6h) (see #1370)
Note:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=E3h/SF=0Eh,AH=E3h/SF=11h,AH=E3h/SF=CDh,AH=E3h/SF=E7h
SeeAlso: AX=F217h/SF=E8h

Format of NetWare "Get File Server Misc Information" request buffer:
Offset	Size	Description	(Table 1377)
 00h	WORD	0001h (length of following data)
 02h	BYTE	E8h (subfunction "Get File Server Misc Information")
SeeAlso: #1378,#1542 at AX=F217h/SF=E8h

Format of NetWare "Get File Server Misc Information" reply buffer:
Offset	Size	Description	(Table 1378)
 00h	WORD	(call) size of following results buffer (max 0048h)
 02h	DWORD	(big-endian) clock ticks since system started
 06h	BYTE	CPU type
		00h Motorola 68000
		01h Intel 8086, 8088, or V20
		02h Intel 80286+
 07h	BYTE	reserved
 08h	BYTE	number of service processes in server
 09h	BYTE	server utilization in percent
 0Ah	WORD	(big-endian) maximum bindery objects set by configuration
		0000h = unlimited
 0Ch	WORD	(big-endian) maximum number of bindery objects used
 0Eh	WORD	(big-endian) current number of bindery objects in use
 10h	WORD	(big-endian) total server memory in KB
 12h	WORD	(big-endian) wasted server memory in KB
		normally 0000h
 14h	WORD	number of records following (01h-03h)
 16h	var	array of Dynamic Memory Information records (see #1379)
SeeAlso: #1377,#1542 at AX=F217h/SF=E8h

Format of NetWare Dynamic Memory Information:
Offset	Size	Description	(Table 1379)
 00h	DWORD	(big-endian) total dynamic space
 04h	DWORD	(big-endian) maximum dynamic space used
 08h	DWORD	(big-endian) current dynamic space usage
--------N-21E3--SFE9-------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET VOLUME INFORMATION
	AH = E3h subfn E9h
	DS:SI -> request buffer (see #1380)
	ES:DI -> reply buffer (see #1381)
Return: AL = status
	    00h successful
Notes:	this function is supported by Advanced NetWare 2.1+
SeeAlso: AH=DAh,AH=E2h/SF=15h,AX=F217h/SF=E9h

Format of NetWare "Get Volume Information" request buffer:
Offset	Size	Description	(Table 1380)
 00h	WORD	0002h (length of following data)
 02h	BYTE	E9h (subfunction "Get Volume Information")
 03h	BYTE	directory handle
SeeAlso: #1381,#1543 at AX=F217h/SF=E9h

Format of NetWare "Get Volume Information" reply buffer:
Offset	Size	Description	(Table 1381)
 00h	WORD	(call) 0028h (length of following results buffer)
 02h	DWORD	(big-endian) elapsed system time
 06h	BYTE	volume number
 07h	BYTE	logical drive number
 08h	WORD	(big-endian) sectors per block
 0Ah	WORD	(big-endian) starting block
 0Ch	WORD	(big-endian) total blocks on volume
 0Eh	WORD	(big-endian) blocks available on volume
 10h	WORD	(big-endian) total directory slots
 12h	WORD	(big-endian) directory slots available
 14h	WORD	(big-endian) maximum directory entries actually used
 16h	BYTE	flag: volume hashed if nonzero
 17h	BYTE	flag: volume cached if nonzero
 18h	BYTE	flag: volume removable if nonzero
 19h	BYTE	flag: volume mounted if nonzero
 1Ah 16 BYTEs	NUL-padded volume name
SeeAlso: #1380,#1543 at AX=F217h/SF=E9h
--------N-21E4-------------------------------
INT 21 O - Novell NetWare - SET FILE ATTRIBUTES (FCB)
	AH = E4h
	CL = file attributes (see #1382)
	DX:DX -> FCB (see #0662 at AH=0Fh)
Return: AL = error code
Note:	this function was added in NetWare 4.0, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
SeeAlso: AX=4301h

Bitfields for NetWare file attributes:
Bit(s)	Description	(Table 1382)
 0	read only
 1	hidden
 2	system
 7	shareable
--------v-21E4-------------------------------
INT 21 - VIRUS - "Anarkia" - INSTALLATION CHECK
	AH = E4h
Return: AH = 04h if resident
SeeAlso: AH=E1h"VIRUS",AH=E7h"VIRUS"
--------T-21E400-----------------------------
INT 21 - DoubleDOS - INSTALLATION CHECK/PROGRAM STATUS
	AX = E400h
Return: AL = program status
	    00h if DoubleDOS not present
	    01h if running in visible DoubleDOS partition
	    02h if running in the invisible DoubleDOS partition
SeeAlso: AH=E5h"DoubleDOS",AX=F400h
--------E-21E400-----------------------------
INT 21 - OS/286, OS/386 - CHAIN TO REAL-MODE HANDLER
	AX = E400h
	???
Return: ???
Note:	protected mode only???
--------E-21E402-----------------------------
INT 21 - OS/286, OS/386 - SET PROTECTED-MODE TASK GATE
	AX = E402h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=E403h
--------E-21E403-----------------------------
INT 21 - OS/286, OS/386 - REMOVE PROTECTED-MODE TASK GATE
	AX = E403h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=E402h
--------N-21E5-------------------------------
INT 21 O - Novell NetWare - UPDATE FILE SIZE (FCB)
	AH = E5h
	DS:DX -> FCB (see #0662 at AH=0Fh)
Return: AL = (unreliable) return code
Notes:	this function was added in NetWare 4.0, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
	on success, NetWare sets AL to zero; on errors it restores AL
--------T-21E5-------------------------------
INT 21 - DoubleDOS - OTHER PROGRAM STATUS
	AH = E5h
Return: AL = status
	    00h no program in other partition
	    01h program in other partition is running
	    02h program in other partition is suspended
SeeAlso: AX=E400h"DoubleDOS",AH=F5h"DoubleDOS"
--------E-21E500-----------------------------
INT 21 - OS/286, OS/386 - HEAP MANAGEMENT STRATEGY
	AX = E500h
	???
Return: ???
SeeAlso: AX=E501h
--------E-21E501-----------------------------
INT 21 - OS/286, OS/386 - FORCE HEAP COMPACTION
	AX = E501h
	???
Return: ???
SeeAlso: AX=E500h
--------N-21E6-------------------------------
INT 21 O - Novell NetWare - COPY FILE TO FILE (FCB)
	AH = E6h
	CX:DX = number of bytes to copy
	DS:SI -> opened source FCB
	ES:DI -> opened destination FCB
Return: AL = error code
	CX = ???
	DX = ???
Note:	this function was added in NetWare 4.0, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
--------E-21E6-------------------------------
INT 21 P - OS/286, OS/386 - ISSUE REAL PROCEDURE SIGNAL FROM PROTECTED MODE
	AH = E6h
	???
Return: ???
SeeAlso: AH=E2h"OS/286"
--------N-21E7-------------------------------
INT 21 - Novell NetWare - FILE SERVER - GET FILE SERVER DATE AND TIME
	AH = E7h
	DS:DX -> date/time buffer (see #1383)
Return: AL = error code
	    00h successful
	    FFh unsuccessful
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+,
	  Alloy NTNX, and Banyan VINES
SeeAlso: AH=2Ah,AH=2Ch,AX=5FC0h,AH=E3h/SF=CAh,AX=F214h

Format of NetWare date/time buffer:
Offset	Size	Description	(Table 1383)
 00h	BYTE	year (80-99 = 1980-1999, 0-79 = 2000-2079)
 01h	BYTE	month (1=Jan)
 02h	BYTE	day
 03h	BYTE	hours
 04h	BYTE	minutes
 05h	BYTE	seconds
 06h	BYTE	day of week (0 = Sunday) (Novell and NTNX only)
SeeAlso: #1402
--------E-21E7-------------------------------
INT 21 - OS/286, OS/386 - CREATE CODE SEGMENT
	AH = E7h
	???
Return: ???
SeeAlso: AH=E8h"OS/286",AH=E9h"OS/286",AH=EAh"OS/286"
--------v-21E7-------------------------------
INT 21 - VIRUS - "Spyer"/"Kiev" - INSTALLATION CHECK
	AH = E7h
Return: AH = 78h if resident
SeeAlso: AH=E4h"VIRUS",AX=EC59h
--------N-21E8-------------------------------
INT 21 O - Novell NetWare, Alloy NTNX - SET FCB RE-OPEN MODE
	AH = E8h
	DL = mode
	    00h no automatic re-open
	    01h auto re-open
Return: AL = error code
Desc:	provided backward compatibility with a bug in CP/M and early DOS vers
Note:	this function was added in NetWare 4.6, but was removed some time prior
	  to Advanced NetWare 2.15, and is no longer listed in current Novell
	  documentation
--------E-21E8-------------------------------
INT 21 - OS/286, OS/386 - SEGMENT CREATION
	AH = E8h
	AL = type
	    00h data segment
	    01h data window/alias
	    02h real segment
	    03h real window/alias
		CX:DX = size in bytes
		SI:BX -> start of desired memory block
		Return:	AX = selector
	    06h shareable segment
	???
Return: ???
SeeAlso: AH=E7h"OS/286",AH=E9h"OS/286"
--------T-21E8-------------------------------
INT 21 - DoubleDOS - SET/RESET KEYBOARD CONTROL FLAGS
	AH = E8h
	AL = program for which to set flags (00h this program, 01h other)
	DX = keyboard control flags (see #1384)
Return: DX = previous flags
Notes:	disabling Ctrl-PrtSc will allow the program to intercept the keystroke;
	  disabling any of the other keystrokes disables them completely
	identical to AH=F8h
SeeAlso: AH=E1h"DoubleDOS",AH=E2h"DoubleDOS",AH=E3h"DoubleDOS"
SeeAlso: AH=F8h"DoubleDOS"

Bitfields for DoubleDOS keyboard control flags:
Bit(s)	Description	(Table 1384)
 0	menu
 1	exchange
 2	entire keyboard enable/disable
 3	Ctrl-C
 4	Ctrl-PrtSc
 5	Alt/Erase
 6	Ctrl-Break
 7	Ctrl-NumLock
 8	shift-PrtSc
 9-13	undefined
 14	cancel key (clear keyboard buffer)
 15	suspend key
Note:	setting a enables the corresponding key or operatin, clearing a
	  disables it
--------E-21E9-------------------------------
INT 21 P - OS/286, OS/386 - CHANGE SEGMENTS
	AH = E9h
	AL = function
	    01h change code segment parameters
	    02h change data segment parameters
	    05h adjust segment limit
	    06h change segment base address
	???
Return: ???
SeeAlso: AH=E7h"OS/286",AH=E8h"OS/286",AH=EAh"OS/286",AH=EDh"OS/286"
SeeAlso: INT 31/AX=0007h,INT 31/AX=0008h
--------T-21E9-------------------------------
INT 21 - DoubleDOS - SET TIMESHARING PRIORITY
	AH = E9h
	AL = new priority (see #1385)
Return: AL = priority setting if AL=05h on entry
Note:	identical to AH=F9h
SeeAlso: AH=EAh"DoubleDOS",AH=EBh"DoubleDOS",AH=F9h"DoubleDOS"

(Table 1385)
Values for DoubleDOS timesharing priority:
 00h	visible program gets 70%, invisible gets 30% (default)
 01h	visible program gets 50%, invisible gets 50%
 02h	visible program gets 30%, invisible gets 70%
 03h	Top program gets 70%, bottom program gets 30%
 04h	Top program gets 30%, bottom program gets 70%
 05h	get current priority
--------N-21E900-----------------------------
INT 21 - Novell NetWare - DIRECTORY SERVICES - GET DIRECTORY HANDLE
	AX = E900h
	DX = drive number to check (0 = A:, ..., 25 = Z:, 26 ... 31)
Return: AL = directory handle
	AH = flags (drive not mapped if none set)
	    bit 0: permanent handle
	    bit 1: temporary handle
	    bit 7: mapped to local drive
Note:	this function is supported by NetWare 4.0+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E2h/SF=00h,AH=E2h/SF=01h,AH=E2h/SF=0Ah
--------v-21E900-----------------------------
INT 21 - VIRUS - "Dark End" - INSTALLATION CHECK
	AX = E900h
Return: AX = 1234h if resident
SeeAlso: AX=DEFEh"VIRUS",AX=EC27h"VIRUS"
--------N-21E905-----------------------------
INT 21 - Novell NetWare shell 3.01 - MAP A FAKE ROOT DIRECTORY
	AX = E905h
	BL = drive number (0=default, 1=A:, ...)
	DS:DX -> ASCIZ path for fake root (may include server name or be empty)
Return: CF set on error
	    AL = error code (03h,0Fh,11h) (see #0980 at AH=59h)
	CF clear if successful
Note:	if drive is not currently mapped, a drive mapping will be created
SeeAlso: AX=E906h
--------N-21E906-----------------------------
INT 21 - Novell NetWare shell 3.01 - DELETE FAKE ROOT DIRECTORY
	AX = E906h
	BL = drive number (0=default, 1=A:, ...)
Return: AL = completion code
Note:	drive remains mapped
SeeAlso: AX=E905h
--------N-21E907-----------------------------
INT 21 - Novell NetWare shell 3.01 - GET RELATIVE DRIVE DEPTH
	AX = E907h
	BL = drive number (0=default, 1=A:, ...)
Return: AL = number of directories below the fake root
	    FFh if no fake root assigned
SeeAlso: AX=E905h
--------N-21E908BL00-------------------------
INT 21 - Novell NetWare shell 3.01 - SET SHOW DOTS
	AX = E908h
	BL = 00h	don't return '.' or '..' during directory scans
	   = nonzero	directory scans will return '.' or '..' entries
Return: BL = previous show-dots setting
--------N-21E909-----------------------------
INT 21 - Novell NetWare - NetWare shell - CONVERT DOS FILE HANDLE TO NETWARE
	AX = E909h
	BX = DOS file handle
Return: AX = 0000h if successful
	    BX:CX:DX = NetWare file handle
Notes:	this function is partially a reverse of "AttachHandle" (AH=B4h)
	many NetWare 3.x functions use a four-byte file handle, which appears
	  to be the high four bytes of the six-byte NetWare handle
SeeAlso: AH=B4h"NetWare"
--------N-21EA-------------------------------
INT 21 - Novell NetWare, Alloy NTNX - RETURN SHELL VERSION
	AH = EAh
	AL = return version environment string
	    00h		don't return string
	    nonzero	get environment string
		ES:DI -> 40-byte buffer for string
		Return: buffer filled with three null-terminated entries:
			major operating system
			version
			hardware type
Return: AH = operating system (00h = MS-DOS)
	AL = hardware type
	    00h IBM PC
	    01h Victor 9000
	BH = major shell version
	BL = minor shell version
	CH = (v3.01+) shell type
	    00h conventional memory
	    01h expanded memory
	    02h extended memory
	CL = shell revision number
Note:	this function is supported by NetWare 4.6 and Advanced NetWare 1.0+
--------T-21EA-------------------------------
INT 21 - DoubleDOS - TURN OFF TASK SWITCHING
	AH = EAh
Return: task switching turned off
SeeAlso: AH=E9h"DoubleDOS",AH=EBh"DoubleDOS",AH=FAh"DoubleDOS"
SeeAlso: INT FA"DoubleDOS"
--------E-21EA-------------------------------
INT 21 - OS/286, OS/386 - ALLOCATE HUGE SEGMENT
	AH = EAh
	???
Return: ???
Note:	protected mode only???
SeeAlso: AH=E7h"OS/286",AH=E8h"OS/286",AH=E9h"OS/286"
--------N-21EB-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - LOG FILE
	AH = EBh
	DS:DX -> ASCIZ filename
	if function C6h lock mode 01h:
	    AL = flags
		00h log file only
		01h lock as well as log file
		    BP = lock timeout in timer ticks (1/18 second)
			0000h = don't wait if file already locked
Return: AL = status (see #1386)
Desc:	add the location and size of the specified file to the log table and
	  optionally lock the file
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=BCh"NetWare",AH=CAh,AH=D0h,AH=ECh"NetWare",AH=EDh"NetWare"

(Table 1386)
Values for NetWare status:
 00h	successful
 96h	no dynamic memory for file
 FEh	timed out
 FFh	failed
--------T-21EB-------------------------------
INT 21 - DoubleDOS - TURN ON TASK SWITCHING
	AH = EBh
Return: task switching turned on
SeeAlso: AH=E9h"DoubleDOS",AH=EAh"DoubleDOS",AH=FBh"DoubleDOS"
SeeAlso: INT FB"DoubleDOS"
--------E-21EB00-----------------------------
INT 21 - OS/386 VMM - GET A PAGE TABLE ENTRY BY LINEAR ADDRESS
	AX = EB00h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB02h,AX=EB04h,INT 31/AX=0506h
--------E-21EB02-----------------------------
INT 21 - OS/386 VMM - GET A PAGE TABLE ENTRY BY 16-BIT SEGMENT:OFFSET
	AX = EB02h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB00h,AX=EB04h
--------E-21EB03-----------------------------
INT 21 - OS/386 VMM - FREE MAPPED PAGES
	AX = EB03h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB05h,INT 31/AX=0801h
--------E-21EB04-----------------------------
INT 21 - OS/386 VMM - GET A PAGE TABLE ENTRY BY 32-BIT SEGMENT:OFFSET
	AX = EB04h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB00h,AX=EB02h
--------E-21EB05-----------------------------
INT 21 - OS/386 VMM - MAP PAGES
	AX = EB05h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB03h,INT 31/AX=0800h
--------E-21EB06-----------------------------
INT 21 - OS/386 VMM - LOCK PAGES IN MEMORY
	AX = EB06h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB07h,INT 31/AX=0600h
--------E-21EB07-----------------------------
INT 21 - OS/386 VMM - UNLOCK MEMORY PAGES
	AX = EB07h
	???
Return: ???
Note:	protected mode only???
SeeAlso: AX=EB06h,INT 31/AX=0601h
--------N-21EC-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - RELEASE FILE
	AH = ECh
	DS:DX -> ASCIZ filename
Return: AL = status
	    00h successful
	    FFh file not found
Desc:	unlock the specified file but retain it in the log table
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=CDh,AH=EBh"NetWare",AH=EDh"NetWare"
--------T-21EC-------------------------------
INT 21 - DoubleDOS - GET VIRTUAL SCREEN ADDRESS
	AH = ECh
Return: ES = segment of virtual screen
Desc:	determine the address of the virtual screen to which the program
	  should write instead of the actual video memory, so that the
	  multitasked programs do not interfere with each other's output
Notes:	screen address can change if task-switching is on!
	identical to AH=FCh
SeeAlso: INT 10/AH=FEh,AH=FCh"DoubleDOS",INT FC"DoubleDOS"
--------E-21EC-------------------------------
INT 21 - OS/286, OS/386 - BLOCK TRANSFER
	AH = ECh
	???
Return: ???
--------v-21EC27-----------------------------
INT 21 - VIRUS - "Halloween.1839" - INSTALLATION CHECK
	AX = EC27h
Return: AX = 4A52h ("JR") if resident
SeeAlso: AH=E7h"VIRUS",AX=E900h"VIRUS",AX=EC59h"VIRUS"
--------v-21EC59-----------------------------
INT 21 - VIRUS - "Terror" - INSTALLATION CHECK
	AX = EC59h
Return: BP = EC59h if resident
SeeAlso: AX=EC27h"VIRUS",AH=EEh"VIRUS"
--------N-21ED-------------------------------
INT 21 - Novell NetWare - SYNCHRONIZATION SERVICES - CLEAR FILE
	AH = EDh
	DS:DX -> ASCIZ filename
Return: AL = status
	    00h successful
	    FFh no files found
Desc:	unlock the file and remove it from the log table
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=CBh"NetWare",AH=CEh,AH=CFh,AH=EBh"NetWare",AH=ECh"NetWare"
--------E-21ED-------------------------------
INT 21 - OS/286, OS/386 - GET SEGMENT OR WINDOW DESCRIPTOR
	AH = EDh
	???
Return: ???
Note:	protected mode only???
SeeAlso: AH=E9h"OS/286"
--------N-21EE-------------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - GET PHYSICAL STATION ADDRESS
	AH = EEh
Return: CX:BX:AX = six-byte physical address
Note:	this function is supported by NetWare 4.6+, Advanced NetWare 1.0+, and
	  Alloy NTNX
SeeAlso: AH=E3h/SF=13h
--------T-21EE-------------------------------
INT 21 - DoubleDOS - GIVE AWAY TIME TO OTHER TASKS
	AH = EEh
	AL = number of 55ms time slices to give away
Return: returns after giving away time slices
SeeAlso: AH=FEh"DoubleDOS",INT FE"DoubleDOS"
--------v-21EE-------------------------------
INT 21 - VIRUS - "Jerusalem-G", "Pregnant" - INSTALLATION CHECK
	AH = EEh
Return: AX = 0300h if "Jerusalem-G" resident
	AL = 05h if "Pregnant" resident
SeeAlso: AH=DDh"VIRUS",AX=EC59h,AH=EFh"VIRUS"
--------v-21EF-------------------------------
INT 21 - VIRUS - "Mabuhay"/"June 12th" - INSTALLATION CHECK
	AH = EFh
Return: AX = 025Bh if resident
SeeAlso: AX=EC27h"VIRUS",AH=EEh"VIRUS",AH=F0h"VIRUS"
--------N-21EF00-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET DRIVE HANDLE TABLE
	AX = EF00h
Return: ES:SI -> network shell's 32-byte drive handle table
	AX = 0000h
Notes:	this function is supported by Advanced NetWare 1.0+
	each byte in the drive handle table contains the directory handle for
	  the corresponding drive, or 00h if not mapped to a directory
SeeAlso: AX=EF01h,AX=EF02h,AX=EF03h,AX=EF04h
--------N-21EF01-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET DRIVE FLAG TABLE
	AX = EF01h
Return: ES:SI -> network shell's 32-byte drive flag table (see #1387)
	AX = 0000h
Notes:	this function is supported by Advanced NetWare 1.0+
	each byte in the drive flag table corresponds to a drive
SeeAlso: AX=EF00h,AX=EF02h,AX=EF03h

(Table 1387)
Values in NetWare drive flag table:
 00h	drive is not mapped
 01h	permanent network drive
 02h	temporary network drive
 80h	mapped to local drive
 81h	local drive used as permanent network drive
 82h	local drive used as temporary network drive
--------N-21EF02-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET DRIVE CONNECTION ID TABLE
	AX = EF02h
Return: ES:SI -> network shell's 32-byte drive conection ID table
	AX = 0000h
Notes:	this function is supported by Advanced NetWare 1.0+
	each byte in the connection ID table corresponds to a drive and
	  contains either the connection ID (1-8) of the server for that drive
	  or 00h if the drive is not mapped to a file server
SeeAlso: AX=EF01h,AX=EF03h,AX=F002h
--------N-21EF03-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET CONNECTION ID TABLE
	AX = EF03h
Return: ES:SI -> network shell's connection ID table (see #1388)
	AX = 0000h
Note:	this function is supported by Advanced NetWare 1.0+
SeeAlso: AX=EF00h,AX=EF02h,AX=EF04h,AX=F002h

Format of NetWare connection ID table [one entry of eight-element array]:
Offset	Size	Description	(Table 1388)
 00h	BYTE	in-use flag
		E0h AES temporary
		F8h IPX in critical section
		FAh processing
		FBh holding
		FCh AES waiting
		FDh waiting
		FEh receiving
		FFh sending
 01h	BYTE	order number assigned to server (1-8)
 02h	DWORD	(big-endian) file server's network address
 06h  6 BYTEs	(big-endian) file server's node address
 0Ch	WORD	(big-endian) socket number
 0Eh	WORD	(big-endian) base receive timeout in clock ticks
 10h  6 BYTEs	(big-endian) preferred routing node
 16h	BYTE	packet sequence number
 17h	BYTE	connection number (FFh = no connection)
 18h	BYTE	connection status (00h if active)
 19h	WORD	(big-endian) maximum receive timeout in clock ticks
 1Bh	WORD	connection number (if > FAh)
 1Dh	BYTE	major version of NetWare
 1Eh	BYTE	minor version of NetWare
 1Fh	BYTE	server flags
		bit 0: server is burst enabled
--------N-21EF04-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET FILE SERVER NAME TABLE
	AX = EF04h
Return: ES:SI -> network shell's file server name table (see #1389)
	AX = 0000h
Note:	this function is supported by Advanced NetWare 1.0+
SeeAlso: AX=EF03h

Format of file server name table:
Offset	Size	Description	(Table 1389)
 00h 48 BYTEs	ASCIZ server name for first entry in connection ID table
 30h 48 BYTEs	ASCIZ server name for second entry in connection ID table
	...
150h 48 BYTEs	ASCIZ server name for eighth entry in connection ID table
--------T-21F0-------------------------------
INT 21 - DoubleDOS - MENU CONTROL
	AH = F0h
	AL = subfunction
	    01h exchange tasks
	    73h resume invisible job if suspended
	    74h kill other job
	    75h suspend invisible job
Note:	identical to AH=E0h
SeeAlso: AH=E0h"DoubleDOS"
--------v-21F0-------------------------------
INT 21 - VIRUS - "Frere Jacques" - INSTALLATION CHECK
	AH = F0h
Return: AX = 0300h if resident
SeeAlso: AH=EEh"VIRUS",AH=F1h"VIRUS"
--------N-21F000-----------------------------
INT 21 - Novell NetWare - WORKSTATION - SET PREFERRED CONNECTION ID
	AX = F000h
	DL = connection ID of prefered file server (1-8) or 00h for none
Notes:	this function is supported by Advanced NetWare 1.0+
	the preferred connection ID is set to 00h by the shell on EOJ
SeeAlso: AH=D6h,AX=EF03h,AX=F001h,AX=F002h,AX=F005h
--------N-21F001-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET PREFERRED CONNECTION ID
	AX = F001h
Return: AL = connection ID of preferred file server (1-8), 00h if not set
Notes:	this function is supported by Advanced NetWare 1.0+
	the preferred connection ID is set to 00h by the shell on EOJ
SeeAlso: AH=D6h,AX=EF03h,AX=F000h,AX=F002h,AX=F005h
--------N-21F002-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET DEFAULT CONNECTION ID
	AX = F002h
Return: AL = connection ID of current default file server (1-8) (see AX=EF03h)
Note:	this function is supported by Advanced NetWare 1.0+
SeeAlso: AX=EF03h,AX=F000h,AX=F004h
--------N-21F003-----------------------------
INT 21 - Novell NetWare - PRINT SERVICES - GET LPT CAPTURE STATUS
	AX = F003h
Return: AH = status
	    00h not active
	    FFh active
		AL = connection ID (01h-08h)
Note:	this function is supported by Advanced NetWare 1.0+
SeeAlso: AX=B800h,AX=B804h,AH=DFh/DL=00h,AH=DFh/DL=04h
--------N-21F004-----------------------------
INT 21 - Novell NetWare - WORKSTATION - SET PRIMARY CONNECTION ID
	AX = F004h
	DL = connection ID of primary file server (1-8) or 00h for none
Note:	this function is supported by Advanced NetWare 2.0+
SeeAlso: AH=D6h,AX=EF03h,AX=F000h,AX=F002h,AX=F005h
--------N-21F005-----------------------------
INT 21 - Novell NetWare - WORKSTATION - GET PRIMARY CONNECTION ID
	AX = F005h
Return: AL = connection ID of primary file server (1-8), 00h if not set
Notes:	this function is supported by Advanced NetWare 2.0+
	by default, the primary file server is the one from which the login
	  script executed; it is set to 00h if the workstation is not logged in
	  and when it detaches from its primary file server
SeeAlso: AH=D6h,AX=EF03h,AX=F000h,AX=F002h,AX=F004h
--------N-21F1-------------------------------
INT 21 - Novell NetWare - CONNECTION SERVICES - FILE SERVER CONNECTION
	AH = F1h
	AL = subfunction
	    00h attach to file server
		DL = preferred file server (01h-08h)
	    01h detach from file server
		DL = connection ID
	    02h logout from file server
		DL = connection ID
Return: AL = status (see #1390)
Note:	these functions are supported by Advanced NetWare 1.0+
SeeAlso: AH=D7h"NetWare",AH=E3h/SF=14h

(Table 1390)
Values for NetWare function status:
 00h	successful
 F8h	already attached to server
 F9h	connection table full
 FAh	no more server slots
 FCh	unknown file server
 FEh	server bindery locked
 FFh	no response from server, or connection does not exist
SeeAlso: #1370,#1646
--------T-21F1-------------------------------
INT 21 - DoubleDOS - CLEAR KEYBOARD BUFFER FOR CURRENT JOB
	AH = F1h
SeeAlso: AH=E1h"DoubleDOS",AH=F2h"DoubleDOS",AH=F3h"DoubleDOS"
SeeAlso: AH=F8h"DoubleDOS"
--------v-21F1-------------------------------
INT 21 - VIRUS - "F1-337" - ???
	AH = F1h
	???
Return: ???
SeeAlso: AH=F0h"VIRUS",AX=F1E9h
--------v-21F1E9-----------------------------
INT 21 - VIRUS - "Tremor" - INSTALLATION CHECK
	AX = F1E9h
Return: AX = installation state
	    CADEh installed, and calling program is infected
	    F100h not installed (normal DOS return value)
	    else  installed, but calling program is not infected
SeeAlso: AH=F1h"VIRUS",AX=F2AAh
--------!---Section--------------------------
