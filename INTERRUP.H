Interrupt List, part 8 of 15
Copyright (c) 1989,1990,1991,1992,1993,1994,1995,1996 Ralf Brown
--------N-21F2-------------------------------
INT 21 u - Novell NetWare v3.01+ shell interface - MULTIPLEXOR
	AH = F2h
	AL = function (see #1391)
	    (subfunction stored in various places in the request packet,
	    depending on function number; see individual entries)
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	    (0000h if no reply packet)
	DS:SI -> request packet fragment list (see #1413)
	ES:DI -> reply packet fragment list (see #1413)
	    (ignored if DX=0000h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled as appropriate for function
Note:	this is a multiplexor providing a "raw" interface to the underlying
	  NetWare Core Protocol.  Many functions which were accessed via a
	  separate AH function in older versions can also be accessed here,
	  but some NetWare 3.x calls appear to be available only here.
SeeAlso: AX=F244h,AX=F268h/SF=3Dh

(Table 1391)
Values for NetWare Core Protocol functions:
Fnc/Subfn	Description
01h	File Set Lock
02h	File Release Lock
03h	Log File (old)					(see AX=F203h)
04h	Lock File Set (old)				(see AX=F204h)
05h	Release File				(see AH=CCh,AH=ECh"NetWare")
06h	Release File Set				(see AH=CDh"NetWare")
07h	Clear File					(see AH=CEh,AX=F207h)
08h	Clear File Set					(see AX=F208h)
09h	Log Logical Record (old)			(see AH=D0h"NetWare")
0Ah	Lock Logical Record Set (old)			(see AX=F20Ah)
0Bh	Clear Logical Record				(see AX=F20Bh)
0Ch	Release Logical Record				(see AH=D2h"NetWare")
0Dh	Release Logical Record Set			(see AH=D3h"NetWare")
0Eh	Clear Logical Record Set			(see AX=F20Eh)
0Fh	Allocate Resource				(see AH=D8h"NetWare")
10h	Deallocate Resource				(see AH=D9h"NetWare")
11h/xxh	print spooling					(see AX=E0xxh"NetWare")
11h/06h Get Printer Status
11h/0Ah	Get Printer Queue
12h	Get Volume Info with Number			(see AH=DAh"NetWare")
13h	Get Station Number				(see AH=DCh"NetWare")
14h	Get File Server Date and Time (NW v2.2+)	(see AH=E7h"NetWare")
15h/01h Get Broadcast Message (old)			(see AX=F215h/SF=01h)
15h/02h Disable Broadcasts				(see AX=F215h/SF=02h)
15h/03h Enable Broadcasts				(see AX=F215h/SF=03h)
15h/08h Check Pipe Status		(see AH=E1h/SF=08h,AX=F215h/SF=08h)
15h/09h Broadcast to Console		(see AH=E1h/SF=09h,AX=F215h/SF=09h)
15h/0Bh Get Broadcast Message				(see AX=F215h/SF=0Bh)
16h/00h Set Directory Handle				(see AX=F216h/SF=00h)
16h/01h Get Directory Path				(see AX=F216h/SF=01h)
16h/02h Scan Directory Information			(see AX=F216h/SF=02h)
16h/03h	Get Effective Directory Rights (old)		(see AX=F216h/SF=03h)
16h/04h Modify Maximum Rights Mask			(see AX=F216h/SF=04h)
16h/05h Get Volume Number				(see AX=F216h/SF=05h)
16h/06h Get Volume Name					(see AX=F216h/SF=06h)
16h/0Ah Create Directory				(see AX=F216h/SF=0Ah)
16h/0Bh Delete Directory				(see AX=F216h/SF=0Bh)
16h/0Ch Scan Directory for Trustees			(see AX=F216h/SF=0Ch)
16h/0Dh Add Trustee to Directory			(see AX=F216h/SF=0Dh)
16h/0Eh Delete Trustee from Directory			(see AX=F216h/SF=0Eh)
16h/0Fh	Rename Directory				(see AX=F216h/SF=0Fh)
16h/10h Purge Erased Files (old)			(see AX=F216h/SF=10h)
16h/11h Recover Erased File (old)			(see AX=F216h/SF=11h)
16h/12h Alloc Permanent Directory Handle		(see AX=F216h/SF=12h)
16h/13h Alloc Temporary Directory Handle		(see AX=F216h/SF=13h)
16h/14h Deallocate Directory Handle			(see AX=F216h/SF=14h)
16h/15h Get Volume Info with Handle			(see AX=F216h/SF=15h)
16h/16h Alloc Special Temporary Directory Handle	(see AX=F216h/SF=16h)
16h/19h Set Directory Information			(see AX=F216h/SF=19h)
16h/1Ah Get Path Name of Volume-Directory Number Pair	(see AX=F216h/SF=1Ah)
16h/1Bh	Scan Salvageable Files (old)			(see AX=F216h/SF=1Bh)
16h/1Ch	Recover Salvageable File (old)			(see AX=F216h/SF=1Ch)
16h/1Dh	Purge Salvageable File (old)			(see AX=F216h/SF=1Dh)
16h/1Eh	Scan a Directory				(see AX=F216h/SF=1Eh)
16h/1Fh	Get Directory Entry				(see AX=F216h/SF=1Fh)
16h/20h	Scan Volume's User Disk Restrictions		(see AX=F216h/SF=20h)
16h/21h	Add User Disk Space Restriction			(see AX=F216h/SF=21h)
16h/22h	Remove User Disk Space Restrictions		(see AX=F216h/SF=22h)
16h/23h	Scan Directory Space Restrictions		(see AX=F216h/SF=23h)
16h/24h	Set Directory Disk Space Restriction		(see AX=F216h/SF=24h)
16h/25h	Set Directory File Information			(see AX=F216h/SF=25h)
16h/26h	Scan File or Directory For Extended Trustees	(see AX=F216h/SF=26h)
16h/27h	Add Extended Trustee to Directory or File	(see AX=F216h/SF=27h)
16h/28h	Scan Directory Disk Space			(see AX=F216h/SF=28h)
16h/29h	Get Object Disk Usage and Restrictions		(see AX=F216h/SF=29h)
16h/2Ah	Get Effective Rights				(see AX=F216h/SF=2Ah)
16h/2Bh	Remove Extended Trustee from Dir or File	(see AX=F216h/SF=2Bh)
16h/2Ch	Get Volume Usage				(see AX=F216h/SF=2Ch)
16h/2Dh	Get Directory Information			(see AX=F216h/SF=2Dh)
16h/2Eh	Rename or Move					(see AX=F216h/SF=2Eh)
16h/2Fh	Get Name Space Information			(see AX=F216h/SF=2Fh)
16h/30h	Get Name Space Directory Entry			(see AX=F216h/SF=30h)
16h/31h	Open Data Stream				(see AX=F216h/SF=31h)
16h/32h	Get Object Effective Rights			(see AX=F216h/SF=32h)
16h/33h	Get Extended Volume Info			(see AX=F216h/SF=33h)
17h/01h Change User Password (old)			(see AX=F217h/SF=01h)
17h/02h Get User Connection List (old)			(see AX=F217h/SF=02h)
17h/0Ch Verify Serialization				(see AX=F217h/SF=0Ch)
17h/0Eh Get Disk Utilization				(see AX=F217h/SF=0Eh)
17h/0Fh Scan File Information				(see AX=F217h/SF=0Fh)
17h/10h Set File Information				(see AX=F217h/SF=10h)
17h/11h Get File Server Information			(see AX=F217h/SF=11h)
17h/12h Get Network Serial Number			(see AX=F217h/SF=12h)
17h/13h Get Internet Address (old)			(see AX=F217h/SF=13h)
17h/14h Login Object					(see AX=F217h/SF=14h)
17h/15h Get Object Connection List (old)		(see AX=F217h/SF=15h)
17h/16h	Get Connection Information (old)		(see AX=F217h/SF=1Ch)
17h/17h	Get Encryption Key				(see AX=F217h/SF=17h)
17h/18h	Login Object Encrypted				(see AX=F217h/SF=18h)
17h/1Ah Get Internet Address				(see AX=F217h/SF=1Ah)
17h/1Bh Get Object Connection List			(see AX=F217h/SF=1Bh)
17h/1Ch	Get Connection Information			(see AX=F217h/SF=1Ch)
17h/1Fh	Get Connection List from Object			(see AX=F217h/SF=1Fh)
17h/32h Create Bindery Object				(see AX=F217h/SF=32h)
17h/33h Delete Bindery Object				(see AX=F217h/SF=33h)
17h/34h Rename Bindery Object				(see AX=F217h/SF=34h)
17h/35h Get Bindery Object ID				(see AX=F217h/SF=35h)
17h/36h Get Bindery Object Name				(see AX=F217h/SF=36h)
17h/37h Scan Bindery Object				(see AX=F217h/SF=37h)
17h/38h Change Bindery Object Security			(see AX=F217h/SF=38h)
17h/39h Create Property					(see AX=F217h/SF=39h)
17h/3Ah Delete Property					(see AX=F217h/SF=3Ah)
17h/3Bh Change Property Security			(see AX=F217h/SF=3Bh)
17h/3Ch Scan Property					(see AX=F217h/SF=3Ch)
17h/3Dh Read Property Value				(see AX=F217h/SF=3Dh)
17h/3Eh Write Property Value				(see AX=F217h/SF=3Eh)
17h/3Fh Verify Bindery Object Password			(see AX=F217h/SF=3Fh)
17h/40h Change Bindery Object Password			(see AX=F217h/SF=40h)
17h/41h Add Bindery Object to Set			(see AX=F217h/SF=41h)
17h/42h Delete Bindery Object from Set			(see AX=F217h/SF=42h)
17h/43h Is Bindery Object in Set			(see AX=F217h/SF=43h)
17h/44h Close Bindery					(see AX=F217h/SF=44h)
17h/45h Open Bindery					(see AX=F217h/SF=45h)
17h/46h Get Bindery Access Level			(see AX=F217h/SF=46h)
17h/47h Scan Bindery Object Trustee Paths		(see AX=F217h/SF=47h)
17h/48h	Get Bindery Object Access Level			(see AX=F217h/SF=48h)
17h/49h	Is Station a Manager?				(see AX=F217h/SF=49h)
17h/4Ah	Keyed Verify Bindery Object Password		(see AX=F217h/SF=4Ah)
17h/4Bh	Keyed Change Bindery Object Password		(see AX=F217h/SF=4Bh)
17h/4Ch	List Relations of an Object			(see AX=F217h/SF=4Ch)
17h/64h Create Queue					(see AX=F217h/SF=64h)
17h/65h Destroy Queue					(see AX=F217h/SF=65h)
17h/66h Read Queue Current Status (old)			(see AX=F217h/SF=66h)
17h/67h Set Queue Current Status (old)			(see AX=F217h/SF=67h)
17h/68h Create Queue Job and File (old)			(see AX=F217h/SF=68h)
17h/69h Close File and Start Queue Job (old)		(see AX=F217h/SF=69h)
17h/6Ah Remove Job From Queue (old)			(see AX=F217h/SF=6Ah)
17h/6Bh Get Queue Job List (old)			(see AX=F217h/SF=6Bh)
17h/6Ch Read Queue Job Entry (old)			(see AX=F217h/SF=6Ch)
17h/6Dh Change Queue Job Entry (old)			(see AX=F217h/SF=6Dh)
17h/6Eh Change Queue Job Position			(see AX=F217h/SF=6Eh)
17h/6Fh Attach Queue Server to Queue			(see AX=F217h/SF=6Fh)
17h/70h Detach Queue Server from Queue			(see AX=F217h/SF=70h)
17h/72h Finish Servicing Queue Job (old)		(see AX=F217h/SF=72h)
17h/74h Change to Client Rights (old)			(see AX=F217h/SF=74h)
17h/75h Restore Queue Server Rights			(see AX=F217h/SF=75h)
17h/76h Read Queue Server Current Status (old)		(see AX=F217h/SF=76h)
17h/77h Set Queue Server Current Status			(see AX=F217h/SF=77h)
17h/78h Get Queue Job File Size (old)			(see AX=F217h/SF=78h)
17h/79h Create Queue Job and File			(see AX=F217h/SF=79h)
17h/7Ah Read Queue Job Entry				(see AX=F217h/SF=7Ah)
17h/7Bh Change Queue Job Entry				(see AX=F217h/SF=7Bh)
17h/7Dh Read Queue Current Status			(see AX=F217h/SF=7Dh)
17h/7Eh Set Queue Current Status			(see AX=F217h/SF=7Eh)
17h/7Fh Close File and Start Queue Job			(see AX=F217h/SF=7Fh)
17h/80h Remove Job From Queue				(see AX=F217h/SF=80h)
17h/81h Get Queue Job List				(see AX=F217h/SF=81h)
17h/82h Change Job Priority				(see AX=F217h/SF=82h)
17h/83h Finish Servicing Queue Job			(see AX=F217h/SF=83h)
17h/85h Change to Client Rights				(see AX=F217h/SF=85h)
17h/86h Read Queue Server Current Status		(see AX=F217h/SF=86h)
17h/87h Get Queue Job File Size				(see AX=F217h/SF=87h)
17h/96h Get Account Status				(see AX=F217h/SF=96h)
17h/97h Submit Account Charge				(see AX=F217h/SF=97h)
17h/98h Submit Account Hold				(see AX=F217h/SF=98h)
17h/99h Submit Account Note				(see AX=F217h/SF=99h)
17h/C8h Check Console Privileges			(see AX=F217h/SF=C8h)
17h/C9h Get File Server Description Strings		(see AX=F217h/SF=C9h)
17h/CAh Set File Server Date and Time			(see AX=F217h/SF=CAh)
17h/CBh Disable File Server Login			(see AX=F217h/SF=CBh)
17h/CCh Enable File Server Login			(see AX=F217h/SF=CCh)
17h/CDh Get File Server Login Status			(see AX=F217h/SF=CDh)
17h/CEh Purge All Erased Files				(see AX=F217h/SF=CEh)
17h/CFh Disable Transaction Tracking			(see AX=F217h/SF=CFh)
17h/D0h Enable Transaction Tracking			(see AX=F217h/SF=D0h)
17h/D2h Clear Connection Number (Logout Station)	(see AX=F217h/SF=D2h)
17h/D3h Down File Server				(see AX=F217h/SF=D3h)
17h/D4h Get File System Statistics			(see AX=F217h/SF=D4h)
17h/D5h Get Transaction Tracking Statistics		(see AX=F217h/SF=D5h)
17h/D6h Get Disk Cache Statistics			(see AX=F217h/SF=D6h)
17h/D7h Get Drive Mapping Table				(see AX=F217h/SF=D7h)
17h/D8h Get Physical Disk Statistics			(see AX=F217h/SF=D8h)
17h/D9h Get Disk Channel Statistics			(see AX=F217h/SF=D9h)
17h/DAh Get Connection's Task Information (NW v2.2)	(see AX=F217h/SF=DAh)
17h/DBh Get Connection's Open Files (old) (NW v2.2)	(see AX=F217h/SF=DBh)
17h/DCh Get Connections Using a File (NW v2.2)		(see AX=F217h/SF=DCh)
17h/DDh Get Physical Record Locks by Connection and File (old)
17h/DEh	Get Physical Record Locks by File (old)		(see AX=F217h/SF=DEh)
17h/DFh Get Logical Records by Connection (old)		(see AX=F217h/SF=DFh)
17h/E0h Get Logical Record Information (old)		(see AX=F217h/SF=E0h)
17h/E1h Get Connection's Semaphores (old)		(see AX=F217h/SF=E1h)
17h/E2h Get Semaphore Information (old)			(see AX=F217h/SF=E2h)
17h/E3h Get LAN Driver's Configuration Information	(see AX=F217h/SF=E3h)
17h/E5h Get Connection's Usage Statistics (NW v2.2)	(see AX=F217h/SF=E5h)
17h/E6h Get Object's Remaining Disk Space		(see AX=F217h/SF=E6h)
17h/E7h Get File Server LAN I/O Statistics		(see AX=F217h/SF=E7h)
17h/E8h Get File Server Misc Information		(see AX=F217h/SF=E8h)
17h/E9h Get Volume Information				(see AX=F217h/SF=E9h)
17h/EAh Get Connection's Task Information (NW v3.11+)	(see AX=F217h/SF=EAh)
17h/EBh	Get Connection's Open Files (NW v3.11+)		(see AX=F217h/SF=EBh)
17h/ECh	Get Connections Using a File (NW v3.11+)	(see AX=F217h/SF=ECh)
17h/EDh Get Physical Record Locks by Connection and File (see AX=F217h/SF=EDh)
17h/EEh	Get Physical Record Locks by File		(see AX=F217h/SF=EEh)
17h/EFh Get Logical Records by Connection		(see AX=F217h/SF=EFh)
17h/F0h Get Logical Record Information			(see AX=F217h/SF=F0h)
17h/F1h Get Connection's Semaphores			(see AX=F217h/SF=F1h)
17h/F2h Get Semaphore Information			(see AX=F217h/SF=F2h)
17h/F3h Map Directory Number to Path			(see AX=F217h/SF=F3h)
17h/F4h	Convert Path to Directory Entry			(see AX=F217h/SF=F4h)
17h/F5h Get File Server Extended Misc Information	(see AX=F217h/SF=F5h)
17h/F6h Get Volume Extended Information			(see AX=F217h/SF=F6h)
17h/FEh Clear Connection Number Greater than 250	(see AX=F217h/SF=FEh)
18h	End of Job					(see AH=D6h"NetWare")
19h	Logout (old)					(see AH=D7h"NetWare")
1Ah	Log Physical Record (old)			(see AH=BCh"NetWare")
1Bh	Lock Physical Record Set (old)			(see AX=F21Bh)
1Ch	Release Physical Record				(see AH=BDh"NetWare")
1Dh	Release Physical Record Set			(see AH=C3h"NetWare")
1Eh	Clear Physical Record				(see AX=F21Eh)
1Fh	Clear Physical Record Set			(see AX=F21Fh)
20h/xxh	semaphore services				(see AX=C5xxh"NetWare")
20h/00h Open Semaphore (old)
20h/01h Examine Semaphore (old)
20h/02h Wait on Semaphore (old)
20h/03h Signal Semaphore (old)
20h/04h Close Semaphore (old)
21h	Negotiate Buffer Size
22h/00h	TTS Is Available				(see AX=C702h"NetWare")
22h/01h	TTS Begin Transaction				(see AX=C700h"NetWare")
22h/02h	TTS End Transaction				(see AX=C701h"NetWare")
22h/03h	TTS Abort Transaction				(see AX=C703h"NetWare")
22h/04h	TTS Transaction Status				(see AX=C704h"NetWare")
22h/05h	TTS Get Application Thresholds			(see AX=C705h"NetWare")
22h/06h	TTS Set Application Thresholds			(see AX=C706h"NetWare")
22h/07h	TTS Get Workstation Thresholds			(see AX=C707h"NetWare")
22h/08h	TTS Set Workstation Thresholds			(see AX=C708h"NetWare")
22h/09h	TTS Get Control Flags
22h/0Ah	TTS Set Control Flags
23h/01h	AFP Create Directory				(see AX=F223h/SF=01h)
23h/02h	AFP Create File					(see AX=F223h/SF=02h)
23h/03h	AFP Delete					(see AX=F223h/SF=03h)
23h/04h	AFP Get Entry ID From Name			(see AX=F223h/SF=04h)
23h/05h	AFP Get File Information			(see AX=F223h/SF=05h)
23h/06h	AFP Get Entry ID From NetWare Handle		(see AX=F223h/SF=06h)
23h/07h	AFP Rename					(see AX=F223h/SF=07h)
23h/08h	AFP Open File Fork				(see AX=F223h/SF=08h)
23h/09h	AFP Set File Information			(see AX=F223h/SF=09h)
23h/0Ah	AFP Scan File Information			(see AX=F223h/SF=0Ah)
23h/0Bh	AFP Alloc Temporary Dir Handle			(see AX=F223h/SF=0Bh)
23h/0Ch	AFP Get Entry ID From Path Name			(see AX=F223h/SF=0Ch)
23h/0Dh AFP 2.0 Create Directory			(see AX=F223h/SF=0Dh)
23h/0Eh AFP 2.0 Create File				(see AX=F223h/SF=0Eh)
23h/10h AFP 2.0 Set File Information			(see AX=F223h/SF=10h)
23h/11h AFP 2.0 Scan File Information			(see AX=F223h/SF=11h)
23h/12h AFP Get DOS Name from Entry ID			(see AX=F223h/SF=12h)
23h/13h AFP Get Macintosh Info on Deleted File		(see AX=F223h/SF=13h)
3Dh	Commit File
3Eh	File Search Initialize (FindFirst)		(see AX=F23Eh)
3Fh	File Search Continue (FindNext)			(see AX=F23Fh)
40h	Search File
42h	Close File					(see AX=F242h)
43h	File Create					(see AX=F243h)
44h	File Erase					(see AX=F244h)
45h	File Rename
46h	Set File Attributes
47h	Get File Size					(see AX=F247h)
48h	File Read
49h	File Write
4Ah	File Server Copy				(see AX=F24Ah)
4Bh	Set File Time and Date
4Ch	File Open
4Dh	Create New File					(see AX=F24Dh)
4Eh	Allow Task Access to File			(see AX=F24Eh)
4Fh	Set Extended File Attributes			(see AH=B6h"NetWare")
54h	Open Create File				(see also AX=6C00h)
55h	Get Sparse File Data Block Bit Map
56h/xx	extended attribute services (OS/2)
56h/01h	Close Extended Attribute Handle			(see AX=F256h/SF=01h)
56h/02h	Write Extended Attribute			(see AX=F256h/SF=02h)
56h/03h	Read Extended Attribute				(see AX=F256h/SF=03h)
56h/04h	Enumerate Extended Attributes			(see AX=F256h/SF=04h)
56h/05h	Duplicate Extended Attributes			(see AX=F256h/SF=05h)
57h/01h	Open/Create File or Subdirectory		(see AX=F257h/SF=01h)
57h/02h	Initialize Search, continue with 57h/03h	(see AX=F257h/SF=02h)
57h/03h	Scan NS Entry Info				(see AX=F257h/SF=03h)
57h/04h	Rename or Move File or Subdirectory		(see AX=F257h/SF=04h)
57h/05h	Scan File or Subdirectory for Trustees		(see AX=F257h/SF=05h)
57h/06h	Obtain File or Subdirectory Information		(see AX=F257h/SF=06h)
57h/07h	Modify File or Subdirectory DOS Information	(see AX=F257h/SF=07h)
57h/08h	Delete File/Directory				(see AX=F257h/SF=08h)
57h/09h	Set Short Directory Handle			(see AX=F257h/SF=09h)
57h/0Ah	Add Trustee Set					(see AX=F257h/SF=0Ah)
57h/0Bh	Delete Trustee					(see AX=F257h/SF=0Bh)
57h/0Ch	Allocate Short Directory Handle			(see AX=F257h/SF=0Ch)
57h/10h Scan Salvageable Files				(see AX=F257h/SF=10h)
57h/11h Recover Salvageable File			(see AX=F257h/SF=11h)
57h/12h Purge Salvageable File				(see AX=F257h/SF=12h)
57h/13h	Get NS Information				(see AX=F257h/SF=13h)
57h/15h	Get Path String from Short Directory Handle	(see AX=F257h/SF=15h)
57h/16h	Generate Directory Base and Volume Number	(see AX=F257h/SF=16h)
57h/17h	Get Name Space Info				(see AX=F257h/SF=17h)
57h/18h Get Name Spaces Loaded				(see AX=F257h/SF=18h)
57h/19h	Write Name Space Info				(see AX=F257h/SF=19h)
57h/1Ah	Read Extended Name Space Info			(see AX=F257h/SF=1Ah)
57h/1Bh	Write Extended Name Space Info			(see AX=F257h/SF=1Bh)
57h/1Ch	Get NS Full Path String				(see AX=F257h/SF=1Ch)
57h/1Dh	Get Effective Directory Rights			(see AX=F257h/SF=1Dh)
58h/01h	Get Volume Audit Statistics			(see AX=F258h/SF=01h)
58h/02h	Add Audit Property				(see AX=F258h/SF=02h)
58h/03h	Login as Volume Auditor				(see AX=F258h/SF=03h)
58h/04h Change Auditor Password				(see AX=F258h/SF=04h)
58h/05h Check Audit Access				(see AX=F258h/SF=05h)
58h/06h	Remove Audit Property				(see AX=F258h/SF=06h)
58h/07h	Disable Auditing on Volume			(see AX=F258h/SF=07h)
58h/08h	Enable Auditing on Volume			(see AX=F258h/SF=08h)
58h/09h	Is User Audited?				(see AX=F258h/SF=09h)
58h/0Ah	Read Auditing Bit Map				(see AX=F258h/SF=0Ah)
58h/0Bh	Read Audit Config Header			(see AX=F258h/SF=0Bh)
58h/0Dh	Logout as Volume Auditor			(see AX=F258h/SF=0Dh)
58h/0Eh	Reset Auditing File				(see AX=F258h/SF=0Eh)
58h/0Fh	Reset Audit History File			(see AX=F258h/SF=0Fh)
58h/10h	Write Auditing Bit Map				(see AX=F258h/SF=10h)
58h/11h	Write Audit Config Header			(see AX=F258h/SF=11h)
58h/13h	Get Auditing Flags				(see AX=F258h/SF=13h)
58h/14h	Close Old Auditing File				(see AX=F258h/SF=14h)
58h/15h	Delete Old Auditing File			(see AX=F258h/SF=15h)
58h/16h	Check Audit Level Two Access			(see AX=F258h/SF=16h)
5Ah/01h	Get DM (Data Migration) Info			(see AX=F25Ah/SF=01h)
5Ah/80h Move File Data to DM				(see AX=F25Ah/SF=80h)
5Ah/81h DM File Information				(see AX=F25Ah/SF=81h)
5Ah/82h Volume DM Status				(see AX=F25Ah/SF=82h)
5Ah/83h Get Migration or Status Information		(see AX=F25Ah/SF=83h)
5Ah/84h DM Support Module Information			(see AX=F25Ah/SF=84h)
5Ah/85h Move File Data from DM				(see AX=F25Ah/SF=85h)
5Ah/86h Get or Set Default Support Module		(see AX=F25Ah/SF=86h)
61h	Negotiate LIP Buffer, packet signing, and IPX checksums
65h	Packet Burst Connection
68h/xxh NetWare 4.x directory services (subfn at DS:[SI+11h])
68h/01h NDS resolve name				(see AX=F268h/SF=01h)
68h/03h	NDS read property				(see AX=F268h/SF=02h)
68h/04h NDS Get Bindery Context				(see AX=F268h/SF=04h)
68h/05h NDS Monitor Connection				(see AX=F268h/SF=05h)
68h/16h NDS List Partitions				(see AX=F268h/SF=16h)
68h/35h NDS get server address				(see AX=F268h/SF=35h)
68h/36h NDS set keys					(see AX=F268h/SF=36h)
68h/39h NDS begin login					(see AX=F268h/SF=39h)
68h/3Ah NDS finish login				(see AX=F268h/SF=3Ah)
68h/3Bh NDS begin authenticate				(see AX=F268h/SF=3Bh)
68h/3Ch NDS finish authenticate				(see AX=F268h/SF=3Ch)
68h/3Dh NDS Logout					(see AX=F268h/SF=3Dh)
68h/C8h Get DS Auditing Statistics			(see AX=F268h/SF=C8h)
69h	Log File					(see AX=F269h)
6Ah	Lock File Set					(see AX=F26Ah)
6Bh	Log Logical Record	!!!APIREF09 line 1430
6Ch	Lock Logical Record Set				(see AX=F26Ch)
6Dh	Log Physical Record
6Eh	Lock Physical Record Set			(see AX=F26Eh)
6Fh/00h Open Semaphore					(see AX=F26Fh/SF=00h)
6Fh/01h Close Semaphore					(see AX=F26Fh/SF=01h)
6Fh/02h Wait on Semaphore				(see AX=F26Fh/SF=02h)
6Fh/03h Signal Semaphore				(see AX=F26Fh/SF=03h)
6Fh/04h Examine Semaphore				(see AX=F26Fh/SF=04h)
72h	NetWare 4.x Time Services			(see AX=F272h)
7Bh/01h	Get Cache Information				(see AX=F27Bh/SF=01h)
7Bh/02h	Get File Server Information			(see AX=F27Bh/SF=02h)
7Bh/03h	Get NetWare File Systems Information		(see AX=F27Bh/SF=03h)
7Bh/04h	Get User Information				(see AX=F27Bh/SF=04h)
7Bh/05h	Get Packet Burst Information			(see AX=F27Bh/SF=05h)
7Bh/06h	Get IPX/SPX Information				(see AX=F27Bh/SF=06h)
7Bh/07h	Get Garbage Collection Information		(see AX=F27Bh/SF=07h)
7Bh/08h	Get CPU Information				(see AX=F27Bh/SF=08h)
7Bh/09h	Get Volume Switch Information			(see AX=F27Bh/SF=09h)
7Bh/0Ah	Get NLM Loaded List				(see AX=F27Bh/SF=0Ah)
7Bh/0Bh	Get NLM Information				(see AX=F27Bh/SF=0Bh)
7Bh/0Ch	Get Directory Cache Information			(see AX=F27Bh/SF=0Ch)
7Bh/0Dh	Get OS Version Information			(see AX=F27Bh/SF=0Dh)
7Bh/0Eh	Get Active Connection List by Type		(see AX=F27Bh/SF=0Eh)
7Bh/0Fh	Get NLM's Resource Tag List			(see AX=F27Bh/SF=0Fh)
7Bh/14h	Get Active LAN Board List			(see AX=F27Bh/SF=14h)
7Bh/15h	Get LAN Configuration Information		(see AX=F27Bh/SF=15h)
7Bh/16h	Get LAN Common Counters Information		(see AX=F27Bh/SF=16h)
7Bh/17h	Get LAN Custom Counters Information		(see AX=F27Bh/SF=17h)
7Bh/18h	Get LAN Config Strings				(see AX=F27Bh/SF=18h)
7Bh/19h	Get LSL Information				(see AX=F27Bh/SF=19h)
7Bh/1Ah	Get LSL Logical Board Statistics		(see AX=F27Bh/SF=1Ah)
7Bh/1Eh	Get Media Manager Object Information		(see AX=F27Bh/SF=1Eh)
7Bh/1Fh	Get Media Manager Object List			(see AX=F27Bh/SF=1Fh)
7Bh/20h	Get Media Manager Object Children List		(see AX=F27Bh/SF=20h)
7Bh/21h	Get Volume Segment List				(see AX=F27Bh/SF=21h)
7Bh/28h	Get Active Protocol Stacks			(see AX=F27Bh/SF=28h)
7Bh/29h	Get Protocol Stack Configuration Information	(see AX=F27Bh/SF=29h)
7Bh/2Ah	Get Protocol Stack Statistics Information	(see AX=F27Bh/SF=2Ah)
7Bh/2Bh	Get Protocol Stack Custom Information		(see AX=F27Bh/SF=2Bh)
7Bh/2Ch	Get Protocol Stack Numbers By Media Number	(see AX=F27Bh/SF=2Ch)
7Bh/2Dh	Get Protocol Stack Numbers By LAN Board Number	(see AX=F27Bh/SF=2Dh)
7Bh/2Eh	Get Media Name by Media Number			(see AX=F27Bh/SF=2Eh)
7Bh/2Fh	Get Loaded Media Number List			(see AX=F27Bh/SF=2Fh)
7Bh/32h	Get General Router and SAP Information		(see AX=F27Bh/SF=32h)
7Bh/33h	Get Network Router Information			(see AX=F27Bh/SF=33h)
7Bh/34h	Get Network Routers Information			(see AX=F27Bh/SF=34h)
7Bh/35h	Get Known Networks Information			(see AX=F27Bh/SF=35h)
7Bh/36h	Get Server Information				(see AX=F27Bh/SF=36h)
7Bh/38h	Get Known Servers Information			(see AX=F27Bh/SF=38h)
7Bh/3Ch	Get Server Set Commands Information		(see AX=F27Bh/SF=3Ch)
7Bh/3Dh	Get Server Set Categories			(see AX=F27Bh/SF=3Dh)
Note:	the subfunction is stored at DS:SI for AL=56h,57h, DS:SI+2 for
	  AL=15h-17h,23h
--------T-21F2-------------------------------
INT 21 - DoubleDOS - SEND CHARACTER TO KEYBOARD BUFFER OF OTHER JOB
	AH = F2h
	AL = character
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	    00h successful
	    01h buffer full (128 characters)
SeeAlso: AH=E2h"DoubleDOS",AH=F1h"DoubleDOS",AH=F3h"DoubleDOS"
SeeAlso: AH=F8h"DoubleDOS"
--------N-21F203-----------------------------
INT 21 - Novell NetWare - LOG FILE (OLD)
	AX = F203h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1766 at AX=F269h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F204h,AX=F269h,AH=EBh"NetWare"
--------N-21F204-----------------------------
INT 21 - Novell NetWare - LOCK FILE SET (OLD)
	AX = F204h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1392)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F203h,AX=F26Ah,AH=CBh"NetWare"

Format of NetWare "Lock File Set (old)" request packet:
Offset	Size	Description	(Table 1392)
 00h	WORD	lock timeout in clock ticks (0000h = don't wait)
--------N-21F207-----------------------------
INT 21 - Novell NetWare - CLEAR FILE
	AX = F207h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1393)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=CEh,AH=EDh"NetWare",AH=F2h"NetWare",AX=F208h

Format of NetWare "Clear File" request packet:
Offset	Size	Description	(Table 1393)
 00h	BYTE	directory handle
 01h	BYTE	length of filename
 02h  N BYTEs	filename
SeeAlso: #1394
--------N-21F208-----------------------------
INT 21 - Novell NetWare - CLEAR FILE SET
	AX = F208h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1394)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=CFh"NetWare",AH=F2h"NetWare",AX=F207h

Format of NetWare "Clear File Set" request packet:
Offset	Size	Description	(Table 1394)
 00h	BYTE	lock flag (nonzero to lock)
SeeAlso: #1393
--------N-21F20A-----------------------------
INT 21 - Novell NetWare - LOCK LOGICAL RECORD SET (OLD)
	AX = F20Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1768 at AX=F26Ch)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F204h,AX=F26Ch,AH=D1h"NetWare"
--------N-21F20B-----------------------------
INT 21 - Novell NetWare - CLEAR LOGICAL RECORD
	AX = F20Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1395)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=D4h"NetWare",AH=F2h"NetWare",AX=F207h,AX=F20Eh

Format of NetWare "Clear Logical Record" request packet:
Offset	Size	Description	(Table 1395)
 00h	BYTE	length of record name (max 128)
 01h  N BYTEs	logical record name
SeeAlso: #1396
--------N-21F20E-----------------------------
INT 21 - Novell NetWare - CLEAR LOGICAL RECORD SET
	AX = F20Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1396)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=D5h"NetWare",AH=F2h"NetWare",AX=F207h,AX=F20Bh

Format of NetWare "Clear Logical Record Set" request packet:
Offset	Size	Description	(Table 1396)
 00h	BYTE	lock flag
SeeAlso: #1395
--------N-21F211SF06-------------------------
INT 21 - Novell NetWare - GET PRINTER STATUS
	AX = F211h subfn 06h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1397)
	ES:DI -> reply packet fragment list (see #1413,#1398)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=E0h"NetWare",AH=F2h"Novell",AX=F211h/SF=0Ah

Format of NetWare "Get Printer Status" request packet:
Offset	Size	Description	(Table 1397)
 00h	WORD	length of following data
 02h	BYTE	06h (subfunction "Get Printer Status")
 03h	BYTE	target printer number (00h-04h)
SeeAlso: #1398,#1108

Format of NetWare "Get Printer Status" reply packet:
Offset	Size	Description	(Table 1398)
 00h	BYTE	flag: printer halted if FFh
 01h	BYTE	flag: printer off-line if FFh
 02h	BYTE	current form type
 03h	BYTE	redirected printer number
SeeAlso: #1397
--------N-21F211SF0A-------------------------
INT 21 - Novell NetWare - GET PRINTER QUEUE
	AX = F211h subfn 0Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1399)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F211h/SF=06h

Format of NetWare "Get Printer Queue" request packet:
Offset	Size	Description	(Table 1399)
 00h	WORD	length of following data
 02h	BYTE	0Ah (subfunction "Get Printer Queue")
	???
--------N-21F212-----------------------------
INT 21 - Novell NetWare - GET VOLUME INFO WITH NUMBER
	AX = F212h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1400)
	ES:DI -> reply packet fragment list (see #1413,#1401)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=15h,AX=F217h/SF=E9h

Format of NetWare "Get Volume Info with Number" request packet:
Offset	Size	Description	(Table 1400)
 00h	BYTE	volume number
SeeAlso: #1401

Format of NetWare "Get Volume Info with Number" reply packet:
Offset	Size	Description	(Table 1401)
 00h	WORD	sectors per cluster
 02h	WORD	total clusters in volume
 04h	WORD	free clusters
 06h	WORD	total directory entries for volume (FFFFh if not relevant)
 08h	WORD	available directory entries (FFFFh if not relevant)
 0Ah 16 BYTEs	volume name
 1Ah	WORD	removability
		0000h fixed media
		FFFFh removable
SeeAlso: #1400
--------N-21F214BX0000-----------------------
INT 21 - Novell NetWare - GET FILE SERVER DATE AND TIME
	AX = F214h
	BX = 0000h (no request packet)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	ES:DI -> reply packet fragment list (see #1413,#1402)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"NetWare",AH=E3h/SF=CAh,AH=E7h"NetWare"

Format of NetWare "Get File Server Date and Time" reply packet:
Offset	Size	Description	(Table 1402)
 00h	BYTE	year-1900 (80-179)
 01h	BYTE	month (1-12)
 02h	BYTE	day (1-31)
 03h	BYTE	hour
 04h	BYTE	minute
 05h	BYTE	second
 06h	BYTE	day of week
SeeAlso: #1307 at AH=E3h/SF=CAh,#1383 at AH=E7h
--------N-21F215SF01-------------------------
INT 21 - Novell NetWare - GET BROADCAST MESSAGE (OLD)
	AX = F215h subfn 01h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1116 at AH=E1h/SF=01h)
	ES:DI -> reply packet fragment list (see #1413,#1403)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E1h/SF=01h,AX=F215h/SF=02h,AX=F215h/SF=0Bh

Format of NetWare "Get Broadcast Message (Old)" reply packet:
Offset	Size	Description	(Table 1403)
 00h	BYTE	length of message (00h-37h)
		00h if no broadcast messages pending
 01h  N BYTEs	message (no control characters or characters > 7Eh)
SeeAlso: #1115,#1116
--------N-21F215SF02-------------------------
INT 21 - Novell NetWare - DISABLE BROADCASTS
	AX = F215h subfn 02h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1117 at AH=E1h/SF=02h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E1h/SF=02h,AX=F215h/SF=01h,AX=F215h/SF=03h
--------N-21F215SF03-------------------------
INT 21 - Novell NetWare - ENABLE BROADCASTS
	AX = F215h subfn 03h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1118 at AH=E1h/SF=03h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E1h/SF=03h,AX=F215h/SF=01h,AX=F215h/SF=02h
--------N-21F215SF08-------------------------
INT 21 - Novell NetWare - CHECK PIPE STATUS
	AX = F215h subfn 08h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1129 at INT 21/AH=E1h/SF=08h)
	ES:DI -> reply packet fragment list (see #1413,#1404)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E1h/SF=08h,AX=F215h/SF=09h

Format of NetWare "Check Pipe Status" reply packet:
Offset	Size	Description	(Table 1404)
 00h	BYTE	number of connections
 01h  N BYTEs	list of pipe statuses
		00h open
		FEh incomplete
		FFh closed
SeeAlso: #1129,#1130
--------N-21F215SF09-------------------------
INT 21 - Novell NetWare - BROADCAST TO CONSOLE
	AX = F215h subfn 09h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply buffer)
	DS:SI -> request packet fragment list
		(see #1413,#1131 at INT 21/AH=E1h/SF=09h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
Note:	requires Access Control rights to the target directory or its parent
SeeAlso: AH=E1h/SF=09h,AH=F2h"NetWare",AX=F215h/SF=08h
--------N-21F215SF0B-------------------------
INT 21 - Novell NetWare - GET BROADCAST MESSAGE
	AX = F215h subfn 0Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1405)
	ES:DI -> reply packet fragment list (see #1413,#1406)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E1h/SF=01h,AX=F215h/SF=01h

Format of NetWare "Get Broadcast Message" request packet:
Offset	Size	Description	(Table 1405)
 00h	WORD	length of following data
 02h	BYTE	0Bh (subfunction "Get Broadcast Message")
SeeAlso: #1406,#1115

Format of NetWare "Get Broadcast Message" reply packet:
Offset	Size	Description	(Table 1406)
 00h	BYTE	length of message
 01h  N BYTEs	message
SeeAlso: #1405,#1116
--------N-21F216SF00-------------------------
INT 21 - Novell NetWare - SET DIRECTORY HANDLE
	AX = F216h subfn 00h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1134 at AH=E2h/SF=00h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=00h,AX=F216h/SF=01h
--------N-21F216SF01-------------------------
INT 21 - Novell NetWare - GET DIRECTORY PATH
	AX = F216h subfn 01h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1136 at AH=E2h/SF=01h)
	ES:DI -> reply packet fragment list (see #1413,#1137)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=01h,AX=F216h/SF=00h
--------N-21F216SF02-------------------------
INT 21 - Novell NetWare - SCAN DIRECTORY INFORMATION
	AX = F216h subfn 02h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1138 at AH=E2h/SF=02h)
	ES:DI -> reply packet fragment list (see #1413,#1407)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=02h,AX=F216h/SF=01h,AX=F216h/SF=03h

Format of NetWare "Scan Directory Information" reply packet:
Offset	Size	Description	(Table 1407)
 00h 16 BYTEs	subdirectory name
 10h	DWORD	(big-endian) date and time of creation (see #1140)
 14h	DWORD	(big-endian) object ID of owner
 18h	BYTE	maximum directory rights (see #1143)
 19h	BYTE	unused
 1Ah	WORD	(big-endian) subdirectory number
SeeAlso: #1138,#1139 at AH=E2h/SF=02h
--------N-21F216SF03-------------------------
INT 21 - Novell NetWare - GET EFFECTIVE DIRECTORY RIGHTS (OLD)
	AX = F216h subfn 03h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1141 at AH=E2h/SF=03h)
	ES:DI -> reply packet fragment list (see #1413,#1408)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=E2h/SF=03h,AX=F216h/SF=02h,AX=F216h/SF=04h,AX=F257h/SF=1Dh

Format of NetWare "Get Effective Directory Rights (old)" reply buffer:
Offset	Size	Description	(Table 1408)
 00h	BYTE	effective directory rights (see #1143 at AH=E2h/SF=03h)
SeeAlso: #1141,#1142 at AH=E2h/SF=03h
--------N-21F216SF04-------------------------
INT 21 - Novell NetWare - MODIFY MAXIMUM RIGHTS MASK
	AX = F216h subfn 04h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1144 at AH=E2h/SF=04h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=04h,AX=F216h/SF=03h,AX=F216h/SF=05h
--------N-21F216SF05-------------------------
INT 21 - Novell NetWare - GET VOLUME NUMBER
	AX = F216h subfn 05h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1146 at AH=E2h/SF=05h)
	ES:DI -> reply packet fragment list (see #1413,#1409)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=05h,AX=F216h/SF=02h,AX=F216h/SF=06h

Format of NetWare "Get Volume Number" reply packet:
Offset	Size	Description	(Table 1409)
 00h	BYTE	volume number
SeeAlso: #1146 at AH=E2h/SF=05h
--------N-21F216SF06-------------------------
INT 21 - Novell NetWare - GET VOLUME NAME
	AX = F216h subfn 06h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1148 at AH=E2h/SF=06h)
	ES:DI -> reply packet fragment list (see #1413,#1410)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=06h,AX=F216h/SF=05h,AX=F216h/SF=0Ah

Format of NetWare "Get Volume Name" reply packet:
Offset	Size	Description	(Table 1410)
SeeAlso: #1148,#1149 at AH=E2h/SF=06h
--------N-21F216SF0A-------------------------
INT 21 - Novell NetWare - CREATE DIRECTORY
	AX = F216h subfn 0Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1150 at AH=E2h/SF=0Ah)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=39h,AH=F2h"Novell",AH=E2h/SF=0Ah,AX=F216h/SF=0Bh
--------N-21F216SF0B-------------------------
INT 21 - Novell NetWare - DELETE DIRECTORY
	AX = F216h subfn 0Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1152 at AH=E2h/SF=0Bh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=3Ah,AH=F2h"Novell",AH=E2h/SF=0Bh,AX=F216h/SF=0Ah
--------N-21F216SF0C-------------------------
INT 21 - Novell NetWare - SCAN DIRECTORY FOR TRUSTEES
	AX = F216h subfn 0Ch
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1153 at AH=E2h/SF=0Ch)
	ES:DI -> reply packet fragment list (see #1413,#1411)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=0Ch,AX=F216h/SF=0Dh

Format of NetWare "Scan Directory For Trustees" reply packet:
Offset	Size	Description	(Table 1411)
 02h 16 BYTEs	directory name
 12h  4 BYTEs	date and time of creation
 16h	DWORD	(big-endian) object ID of owner
 1Ah  5 DWORDs	(big-endian) object IDs of Trustees 0 through 4
		00000000h = end of group
 2Eh  5 BYTEs	directory rights for Trustees 0 through 4 (see #1143)
SeeAlso: #1153 at AH=E2h/SF=0Ch
--------N-21F216SF0D-------------------------
INT 21 - Novell NetWare - ADD TRUSTEE TO DIRECTORY
	AX = F216h subfn 0Dh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1155 at AH=E2h/SF=0Dh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
Note:	requires Access Control rights to the target directory or its parent
SeeAlso: AH=F2h"NetWare",AH=E2h/SF=0Dh,AX=F216h/SF=0Ch,AX=F216h/SF=0Eh
--------N-21F216SF0E-------------------------
INT 21 - Novell NetWare - DELETE TRUSTEE FROM DIRECTORY
	AX = F216h subfn 0Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1156 at AH=E2h/SF=0Eh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=0Eh,AX=F216h/SF=0Ch,AX=F216h/SF=0Dh
--------N-21F216SF0F-------------------------
INT 21 - Novell NetWare - RENAME DIRECTORY
	AX = F216h subfn 0Fh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1158 at AH=E2h/SF=0Fh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=0Fh,AX=F216h/SF=0Ah
--------N-21F216SF10-------------------------
INT 21 - Novell NetWare - PURGE ERASED FILES (OLD)
	AX = F216h subfn 10h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1159 at AH=E2h/SF=10h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=10h,AX=F216h/SF=11h
--------N-21F216SF11-------------------------
INT 21 - Novell NetWare - RECOVER ERASED FILE (OLD)
	AX = F216h subfn 11h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1161 at AH=E2h/SF=11h)
	ES:DI -> reply packet fragment list (see #1413,#1412)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=11h,AX=F216h/SF=10h

Format of NetWare "Recover Erased File (Old)" reply packet:
Offset	Size	Description	(Table 1412)
 02h 15 BYTEs	ASCIZ name of erased file
 11h 15 BYTEs	ASCIZ name under which file was restored
SeeAlso: #1161,#1162 at AH=E2h/SF=11h
--------N-21F216SF12-------------------------
INT 21 - Novell NetWare - ALLOCATE PERMANENT DIRECTORY HANDLE
	AX = F216h subfn 12h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1163 at AH=E2h/SF=12h)
	ES:DI -> reply packet fragment list (see #1413,#1414)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=16h,AH=E2h/SF=12h

Format of NetWare IPX fragment list entry:
Offset	Size	Description	(Table 1413)
 00h	DWORD	-> fragment data
 04h	WORD	size of fragment in bytes

Format of NetWare "Allocate Permanent Directory Handle" reply packet:
Offset	Size	Description	(Table 1414)
 00h	BYTE	new directory handle
 01h	BYTE	access rights
SeeAlso: #1163,#1167,#1413
--------N-21F216SF13-------------------------
INT 21 - Novell NetWare - ALLOCATE TEMPORARY DIRECTORY HANDLE
	AX = F216h subfn 13h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1165 at AH=E2h/SF=13h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=12h,AX=F216h/SF=16h,AH=E2h/SF=13h
--------N-21F216SF14-------------------------
INT 21 - Novell NetWare - DEALLOCATE DIRECTORY HANDLE
	AX = F216h subfn 14h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1166 at AH=E2h/SF=14h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=14h,AX=F216h/SF=13h,AX=F216h/SF=16h
--------N-21F216SF15-------------------------
INT 21 - Novell NetWare - GET VOLUME INFO WITH HANDLE
	AX = F216h subfn 15h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1168 at AH=E2h/SF=15h)
	ES:DI -> reply packet fragment list (see #1413,#1415)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=15h,AX=F212h,AX=F216h/SF=13h

Format of NetWare "Get Volume Info With Handle" reply packet:
Offset	Size	Description	(Table 1415)
 00h	WORD	(big-endian) sectors per block
 02h	WORD	(big-endian) total blocks on volume
 04h	WORD	(big-endian) blocks available on volume
 06h	WORD	(big-endian) total directory slots
 08h	WORD	(big-endian) directory slots available
 0Ah 16 BYTEs	NUL-padded volume name
 1Ah	WORD	(big-endian) flag: volume removable if nonzero
SeeAlso: #1168 at AH=E2h/SF=15h
--------N-21F216SF16-------------------------
INT 21 - Novell NetWare v2+ - ALLOCATE SPECIAL TEMPORARY DIRECTORY HANDLE
	AX = F216h subfn 16h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1170 at AH=E2h/SF=16h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=12h,AX=F216h/SF=13h,AH=E2h/SF=16h
--------N-21F216SF17-------------------------
INT 21 - Novell NetWare - SAVE DIRECTORY HANDLE
	AX = F216h subfn 17h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1171 at AH=E2h/SF=1Ah)
	ES:DI -> reply packet fragment list (see #1413,#1416)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=17h,AX=F216h/SF=18h

Format of NetWare "Save Directory Handle" reply packet:
Offset	Size	Description	(Table 1416)
 00h 16 BYTEs	save buffer
SeeAlso: #1171,#1172,#1417
--------N-21F216SF18-------------------------
INT 21 - Novell NetWare - RESTORE DIRECTORY HANDLE
	AX = F216h subfn 18h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1173 at AH=E2h/SF=1Ah)
	ES:DI -> reply packet fragment list (see #1413,#1417)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=18h,AX=F216h/SF=17h

Format of NetWare "Restore Directory Handle" reply packet:
Offset	Size	Description	(Table 1417)
 00h	BYTE	new directory handle
 01h	BYTE	effective rights (see #1143)
SeeAlso: #1174,#1416
--------N-21F216SF19-------------------------
INT 21 - Novell NetWare - SET DIRECTORY INFORMATION
	AX = F216h subfn 19h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1175 at AH=E2h/SF=19h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=19h,AX=F216h/SF=17h
--------N-21F216SF1A-------------------------
INT 21 - Novell NetWare - GET PATH NAME OF VOLUME-DIRECTORY NUMBER PAIR
	AX = F216h subfn 1Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1177 at AH=E2h/SF=1Ah)
	ES:DI -> reply packet fragment list (see #1413,#1418)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=1Ah,AX=F216h/SF=0Eh

Format of NetWare "Get Path Name Of Volume-Dir Number Pair" reply packet:
Offset	Size	Description	(Table 1418)
 00h 256 BYTEs	path
SeeAlso: #1177,#1178 at AH=E2h/SF=1Ah
--------N-21F216SF1B-------------------------
INT 21 - Novell NetWare - SCAN SALVAGEABLE FILES (OLD)
	AX = F216h subfn 1Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1419)
	ES:DI -> reply packet fragment list (see #1413,#1420)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Ch,AX=F216h/SF=1Dh,AX=F257h/SF=10h

Format of NetWare "Scan Salvageable Files (Old)" request packet:
Offset	Size	Description	(Table 1419)
 00h	WORD	length of following data
 02h	BYTE	1Bh (subfunction "Scan Salvageable Files (Old)")
 03h	BYTE	directory handle
 04h	DWORD	last sequence number (set to FFFFFFFFh before first call)
SeeAlso: #1420,#1693

Format of NetWare "Scan Salvageable Files (Old)" reply packet:
Offset	Size	Description	(Table 1420)
 00h	DWORD	next sequence number
 04h	WORD	subdirectory
 06h	DWORD	attributes
 0Ah	BYTE	unique ID
 0Bh	BYTE	flags
 0Ch	BYTE	name space
 0Dh	BYTE	length of filename
 0Eh 14 BYTEs	filename
 1Ah	DWORD	creation date and time
 1Eh	DWORD	owner ID
 22h	DWORD	last-backup date and time
 26h	DWORD	last-backup ID
 2Ah	DWORD	last-modified date and time
 2Eh	WORD	???
 30h	DWORD	last-modified ID
 34h	DWORD	file size
 38h 44 BYTEs	reserved
 62h	WORD	inherited rights mask
 64h	WORD	last-access date
 66h	DWORD	deleted file's time
 6Ah	DWORD	deletion date and time
 6Eh	DWORD	ID of deletor
 72h 16 BYTEs	reserved
SeeAlso: #1419,#1694
--------N-21F216SF1C-------------------------
INT 21 - Novell NetWare - RECOVER SALVAGEABLE FILE (OLD)
	AX = F216h subfn 1Ch
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1421)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Bh,AX=F216h/SF=1Dh,AX=F257h/SF=11h

Format of NetWare "Recover Salvageable File (Old)" request packet:
Offset	Size	Description	(Table 1421)
 00h	WORD	length of following data
 02h	BYTE	1Ch (subfunction "Recover Salvageable File (Old)")
 03h	BYTE	directory handle
 04h	DWORD	sequence number (set to ? before first call)
 08h	BYTE	length of filename
 09h  N BYTEs	filename in DOS format
	BYTE	length of new name for recovered file
      N BYTEs	recovered filename in NetWare VOLUME:DIRECTORY/.../FILE format
SeeAlso: #1695
--------N-21F216SF1D-------------------------
INT 21 - Novell NetWare - PURGE SALVAGEABLE FILE (OLD)
	AX = F216h subfn 1Dh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1422)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Bh,AX=F216h/SF=1Ch,AX=F257h/SF=12h

Format of NetWare "Purge Salvageable File (old)" request packet:
Offset	Size	Description	(Table 1422)
 00h	WORD	length of following data
 02h	BYTE	1Dh (subfunction "Purge Salvageable File (Old)")
 03h	BYTE	directory handle
 04h	DWORD	directory entry
 08h	DWORD	sequence number from Scan Salvageable Files
--------N-21F216SF1E-------------------------
INT 21 - Novell NetWare - SCAN A DIRECTORY
	AX = F216h subfn 1Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1423)
	ES:DI -> reply packet fragment list (see #1413,#1424)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=02h,AX=F216h/SF=1Fh

Format of NetWare "Scan A Directory" request packet:
Offset	Size	Description	(Table 1423)
 00h	WORD	length of following data
 02h	BYTE	1Eh (subfunction "Scan A Directory")
 03h	BYTE	directory handle
 04h	BYTE	search attributes
 05h	DWORD	sequence number
 09h	BYTE	length of search filespec
 0Ah  N BYTEs	search filespec
SeeAlso: #1424

Format of NetWare "Scan A Directory" reply packet:
Offset	Size	Description	(Table 1424)
 00h	DWORD	sequence number (copy into next request packet)
 04h	DWORD	subdirectory
 08h	DWORD	attributes
 0Ch	BYTE	unique ID
 0Dh	BYTE	flags
 0Eh	BYTE	name space
 0Fh	BYTE	length of filename
---DOS file---
 10h 12 BYTEs	DOS filename
 1Ch	DWORD	creation date and time
 20h	DWORD	owner ID
 24h	DWORD	last-archived date and time
 28h	DWORD	last-archived ID
 2Ch	DWORD	last-updated date and time
 30h	DWORD	last-updated ID
 34h	DWORD	file size
 38h 44 BYTEs	reserved
 64h	WORD	inherited rights mask
 66h	WORD	last-accessed date
 68h 28 BYTEs	reserved
---DOS subdirectory---
 10h 12 BYTEs	DOS directory name
 1Ch	DWORD	creation date and time
 20h	DWORD	owner ID
 24h	DWORD	last-archived date and time
 28h	DWORD	last-archived ID
 2Ch	DWORD	last-updated date and time
 30h	DWORD	next trustee entry
 34h 48 BYTEs	reserved
 64h	DWORD	maximum space
 68h	WORD	inherited rights mask
 6Ah 26 BYTEs	unused
SeeAlso: #1423
--------N-21F216SF1F-------------------------
INT 21 - Novell NetWare - GET DIRECTORY ENTRY
	AX = F216h subfn 1Fh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1425)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Eh

Format of NetWare "Get Directory Entry" request packet:
Offset	Size	Description	(Table 1425)
 00h	WORD	length of following data
 02h	BYTE	1Fh (subfunction "Get Directory Entry")
	???
--------N-21F216SF20-------------------------
INT 21 - Novell NetWare - SCAN VOLUME'S USER DISK RESTRICTIONS
	AX = F216h subfn 20h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1426)
	ES:DI -> reply packet fragment list (see #1413,#1427)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=23h,AX=F216h/SF=29h

Format of NetWare "Scan Volume's User Disk Restrictions" request packet:
Offset	Size	Description	(Table 1426)
 00h	WORD	length of following data
 02h	BYTE	20h (subfunction "Scan Volume's User Disk Restrictions")
 03h	BYTE	volume number
 04h	DWORD	sequence number (set to 00000000h before first call)
SeeAlso: #1427

Format of NetWare "Scan Volume's User Disk Restrictions" reply packet:
Offset	Size	Description	(Table 1427)
 00h	BYTE	number of entries returned (max 12)
 01h 2N DWORDs	restriction entries [array]
		Offset	Size	Description
		 00h	DWORD	object ID
		 04h	DWORD	maximum usage allowed (in 4K blocks)
SeeAlso: #1426
--------N-21F216SF21-------------------------
INT 21 - Novell NetWare v3+ - ADD USER DISK SPACE RESTRICTION
	AX = F216h subfn 21h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1428)
	ES:DI -> reply buffer (ignored)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AX=F216h/SF=20h,AX=F216h/SF=22h,AX=F216h/SF=24h

Format of NetWare "Add User Disk Space Restriction" request buffer:
Offset	Size	Description	(Table 1428)
 00h	WORD	000Ah (length of following data)
 02h	BYTE	21h (subfunction "Add User Disk Space Restriction")
 03h	BYTE	volume number
 04h	DWORD	(big-endian) object ID
 08h	DWORD	(big-endian) disk space limit in 4K blocks
		00000000h to 40000000h
--------N-21F216SF22-------------------------
INT 21 - Novell NetWare - REMOVE USER DISK SPACE RESTRICTIONS
	AX = F216h subfn 22h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1429)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=20h,AX=F216h/SF=21h,AX=F216h/SF=23h

Format of NetWare "Remove User Disk Space Restrictions" request packet:
Offset	Size	Description	(Table 1429)
 00h	WORD	length of following data
 02h	BYTE	22h (subfunction "Remove User Disk Space Restrictions")
	???
--------N-21F216SF23-------------------------
INT 21 - Novell NetWare - SCAN DIRECTORY SPACE RESTRICTIONS
	AX = F216h subfn 23h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1430)
	ES:DI -> reply packet fragment list (see #1413,#1431)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=20h,AX=F216h/SF=21h,AX=F216h/SF=22h

Format of NetWare "Scan Directory Space Restrictions" request packet:
Offset	Size	Description	(Table 1430)
 00h	WORD	length of following data
 02h	BYTE	23h (subfunction "Scan Directory Space Restrictions")
 03h	BYTE	directory handle
SeeAlso: #1431

Format of NetWare "Scan Directory Space Restrictions" reply packet:
Offset	Size	Description	(Table 1431)
 00h	BYTE	number of entries returned
 01h 10N BYTEs	restrictions [array]
		Offset	Size	Description
		 00h	WORD	depth of directory from root
		 02h	DWORD	maximum space allowed for files in directory
		 04h	DWORD	current space used by files in directory
SeeAlso: #1430
--------N-21F216SF24-------------------------
INT 21 - Novell NetWare v3+ - SET DIRECTORY DISK SPACE RESTRICTION
	AX = F216h subfn 24h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1432)
	ES:DI -> reply buffer (ignored)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AX=F216h/SF=21h,AX=F216h/SF=22h,AX=F216h/SF=23h,AX=F216h/SF=25h

Format of NetWare "Set Directory Disk Space Restriction" request buffer:
Offset	Size	Description	(Table 1432)
 00h	WORD	0006h (length of following data)
 02h	BYTE	24h (subfunction "Set Directory Disk Space Restriction")
 03h	BYTE	directory handle
 04h	DWORD	(big-endian) disk space limit in 4K blocks
		00000000h to remove restriction, negative to set to 0 blocks
--------N-21F216SF25-------------------------
INT 21 - Novell NetWare - SET DIRECTORY/FILE INFORMATION
	AX = F216h subfn 25h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1433)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=02h

Format of NetWare "Set Directory/File Information" request packet:
Offset	Size	Description	(Table 1433)
 00h	WORD	length of following data
 02h	BYTE	25h (subfunction "Set Directory/File Information")
 03h	BYTE	directory handle
 04h	BYTE	search attributes
 05h	DWORD	sequence number
 09h	DWORD	change bits
 0Dh	DWORD	directory number
 11h	DWORD	attributes
 15h	BYTE	unique ID
 16h	BYTE	flags
 17h	BYTE	name space (see #1683)
 18h	BYTE	length of directory/file name
 19h 12 BYTEs	directory/file name
 25h	DWORD	creation date and time
 29h	DWORD	(big-endian) owner ID
 2Dh	DWORD	last-backup date and time
 31h	DWORD	(big-endian) last-backup ID
 35h	DWORD	last-modification date and time
 39h	DWORD	(big-endian) last-modification ID
 3Dh	DWORD	file size
 41h	DWORD	data fork first FAT
 45h	DWORD	next trustee entry
 49h 36 BYTEs	reserved
 6Dh	WORD	inherited rights mask
 6Fh	WORD	last-access date
 71h 20 BYTEs	reserved
 85h	DWORD	primary entry
 89h	DWORD	name list
--------N-21F216SF26-------------------------
INT 21 - Novell NetWare v3+ - SCAN FILE OR DIRECTORY FOR EXTENDED TRUSTEES
	AX = F216h subfn 26h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1434)
	ES:DI -> reply packet fragment list (see #1413,#1435)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
Desc:	get up to 20 extended trustee entries per call for a file or directory

Format of NetWare "Scan File/Directory for Extended Trustees" request buffer:
Offset	Size	Description	(Table 1434)
 00h	WORD	length of following data
 02h	BYTE	26h (subfunc "Scan File or Directory For Extended Trustees")
 03h	BYTE	directory handle
 04h	BYTE	sequence number
		00h for first call, increment by number of returned entries
 05h	BYTE	length of path
 06h  N BYTEs	pathname
SeeAlso: #1434

Format of NetWare "Scan File/Directory for Extended Trustees" reply buffer:
Offset	Size	Description	(Table 1435)
 00h	BYTE	number of entries returned (max 20)
 01h 20 DWORDs	(big-endian) list of object IDs
 51h 20 WORDs	list of associated trustee rights
SeeAlso: #1435
--------N-21F216SF27-------------------------
INT 21 - Novell NetWare v3+ - ADD EXTENDED TRUSTEE TO DIRECTORY OR FILE
	AX = F216h subfn 27h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1436)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)

Format of NetWare "Add Extended Trustee to Directory or File" request buffer:
Offset	Size	Description	(Table 1436)
 00h	WORD	length of following data
 02h	BYTE	27h (subfunction "Add Extended Trustee to Directory or File")
 03h	BYTE	directory handle
 04h	DWORD	(big-endian) object ID
 08h	WORD	trustee rights (see #1437)
 0Ah	BYTE	path length
 0Bh  N BYTEs	path name

Bitfields for NetWare trustee rights:
Bit(s)	Description	(Table 1437)
 0	read
 1	write
 3	create
 4	delete
 5	access
 6	file
 7	modify
 8	supervisor
--------N-21F216SF28-------------------------
INT 21 - Novell NetWare - SCAN DIRECTORY DISK SPACE
	AX = F216h subfn 28h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1438)
	ES:DI -> reply packet fragment list (see #1413,#1439)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=02h,AX=F216h/SF=20h

Format of NetWare "Scan Directory Disk Space" request packet:
Offset	Size	Description	(Table 1438)
 00h	WORD	length of following data
 02h	BYTE	28h (subfunction "Scan Directory Disk Space")
 03h	BYTE	directory handle
 04h	BYTE	search attributes
 05h	DWORD	sequence number (set to FFFFFFFFh before first call)
 09h	BYTE	length of filespec
 0Ah  N BYTEs	search filespec
SeeAlso: #1439

Format of NetWare "Scan Directory Disk Space" reply packet:
Offset	Size	Description	(Table 1439)
 00h	DWORD	next sequence number
 04h	DWORD	(big-endian) subdirectory number
 08h	DWORD	(big-endian) attributes
 0Ch	BYTE	unique ID
 0Dh	BYTE	flags
 0Eh	BYTE	name space (see #1683)
 0Fh	BYTE	length of name
 10h 12 BYTEs	name
 1Ch	DWORD	creation date and time
 20h	DWORD	owner ID
 24h	DWORD	date and time last backed up
 28h	DWORD	last-backup ID
 2Ch	DWORD	date and time last modified
 30h	DWORD	last-modification ID
 34h	DWORD	data fork size
 38h	DWORD	data fork first FAT
 3Ch	DWORD	next trustee entry
 40h 36 BYTEs	reserved
 64h	WORD	inherited rights mask
 66h	WORD	last-access date
 68h	DWORD	deleted file date and time
 6Ch	DWORD	date and time file was deleted
 70h	DWORD	deleted ID
 74h  8 BYTEs	undefined
 7Ch	DWORD	primary entry
 80h	DWORD	name list
 84h	DWORD	other file fork size
SeeAlso: #1438
--------N-21F216SF29-------------------------
INT 21 - Novell NetWare v3+ - GET OBJECT DISK USAGE AND RESTRICTIONS
	AX = F216h subfn 29h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1440)
	ES:DI -> reply packet fragment list (see #1413,#1441)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
Note:	this function returns successfully, showing no restriction, if an
	  invalid object ID is specified
SeeAlso: AX=F216h/SF=24h,AX=F216h/SF=33h

Format of NetWare "Get Object Disk Restrictions" request buffer:
Offset	Size	Description	(Table 1440)
 00h	WORD	0006h (length of following data)
 02h	BYTE	21h (subfunction "Get Object Disk Restrictions")
 03h	BYTE	volume number
 04h	DWORD	(big-endian) object ID
SeeAlso: #1441

Format of NetWare "Get Object Disk Restrictions" reply buffer:
Offset	Size	Description	(Table 1441)
 00h	DWORD	disk space limit
 04h	DWORD	disk space currently in use by object
SeeAlso: #1440
--------N-21F216SF2A-------------------------
INT 21 - Novell NetWare - GET EFFECTIVE RIGHTS
	AX = F216h subfn 2Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1442)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=32h

Format of NetWare "Get Effective Rights" request packet:
Offset	Size	Description	(Table 1442)
 00h	WORD	length of following data
 02h	BYTE	2Ah (subfunction "Get Effective Rights")
	???
--------N-21F216SF2B-------------------------
INT 21 - Novell NetWare - REMOVE EXTENDED TRUSTEE FROM DIR OR FILE
	AX = F216h subfn 2Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1443)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=26h,AX=F216h/SF=27h

Format of NetWare "Remove Extended Trustee From Dir Or File" request packet:
Offset	Size	Description	(Table 1443)
 00h	WORD	length of following data
 02h	BYTE	2Bh (subfunction "Remove Extended Trustee From Dir Or File")
 03h	BYTE	directory handle
 04h	DWORD	trustee's object ID
 08h	BYTE	unused
 09h	BYTE	length of pathname
 0Ah  N BYTEs	directory path in form VOLUME:DIRECTORY/.../DIRECTORY
--------N-21F216SF2C-------------------------
INT 21 - Novell NetWare - GET VOLUME USAGE
	AX = F216h subfn 2Ch
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1444)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=20h,AX=F216h/SF=29h

Format of NetWare "Get Volume Usage" request packet:
Offset	Size	Description	(Table 1444)
 00h	WORD	length of following data
 02h	BYTE	2Ch (subfunction "Get Volume Usage")
	???
--------N-21F216SF2D-------------------------
INT 21 - Novell NetWare - GET DIRECTORY INFORMATION
	AX = F216h subfn 2Dh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1445)
	ES:DI -> reply packet fragment list (see #1413,#1446)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=2Ch,AX=F216h/SF=2Eh

Format of NetWare "Get Directory Information" request packet:
Offset	Size	Description	(Table 1445)
 00h	WORD	length of following data
 02h	BYTE	2Dh (subfunction "Get Directory Information")
 03h	BYTE	directory handle
SeeAlso: #1446

Format of NetWare "Get Directory Information" reply packet:
Offset	Size	Description	(Table 1446)
 00h	DWORD	total blocks
 04h	DWORD	available blocks
 08h	DWORD	total number of directory entries
 0Ch	DWORD	number of available directory entries
 10h  4 BYTEs	reserved
 14h	BYTE	sectors per block
 15h	BYTE	length of volume name
 16h  N BYTEs	volume name
SeeAlso: #1445
--------N-21F216SF2E-------------------------
INT 21 - Novell NetWare - RENAME OR MOVE
	AX = F216h subfn 2Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1447)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=34h,AX=F223h/SF=07h,AX=F245h

Format of NetWare "Rename Or Move" request packet:
Offset	Size	Description	(Table 1447)
 00h	WORD	length of following data
 02h	BYTE	2Eh (subfunction "Rename Or Move")
 03h	BYTE	source directory handle
 04h	BYTE	search attributes
 05h	BYTE	source path component count
 06h  N BYTEs	source path
	BYTE	destination directory handle
	BYTE	destination path component count
      N BYTEs	destination path
--------N-21F216SF2F-------------------------
INT 21 - Novell NetWare - GET NAME SPACE INFORMATION
	AX = F216h subfn 2Fh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1448)
	ES:DI -> reply packet fragment list (see #1413,#1449)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=30h,AX=F257h/SF=18h

Format of NetWare "Get Name Space Information" request packet:
Offset	Size	Description	(Table 1448)
 00h	WORD	length of following data
 02h	BYTE	2Fh (subfunction "Get Name Space Information")
 03h	BYTE	volume number
SeeAlso: #1449

Format of NetWare "Get Name Space Information" request packet:
Offset	Size	Description	(Table 1449)
 00h	BYTE	length of namespace name
 01h  N BYTEs	name of namespace
	BYTE	number of data streams
	var	data stream information [one entry per data stream]
		Offset	Size	Description
		 00h	BYTE	associated name space
		 01h	BYTE	length of data stream name
		 02h  N BYTEs	data stream name
	BYTE	number of loaded name spaces
	BYTE	bitmap of loaded name spaces
      N BYTEs	list of name spaces being used
	BYTE	index number
SeeAlso: #1448
--------N-21F216SF30-------------------------
INT 21 - Novell NetWare - GET NAME SPACE DIRECTORY ENTRY
	AX = F216h subfn 30h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1450)
	ES:DI -> reply packet fragment list (see #1413,#1451)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=2Fh

Format of NetWare "Get Name Space Directory Entry" request packet:
Offset	Size	Description	(Table 1450)
 00h	WORD	length of following data
 02h	BYTE	30h (subfunction "Get Name Space Directory Entry")
 03h	BYTE	volume number
 04h	DWORD	sequence number (set to 00000000h before first call)
 08h	BYTE	name space (see #1683)
SeeAlso: #1451

Format of NetWare "Get Name Space Directory Entry" request packet:
Offset	Size	Description	(Table 1451)
 00h	DWORD	next sequence number
 04h	DWORD	subdirectory
 08h	DWORD	attributes
 0Ch	BYTE	unique ID
 0Dh	BYTE	flags
 0Eh	BYTE	name space (see #1683)
 0Fh	BYTE	length of name
 10h 12 BYTEs	filename
 1Ch	DWORD	creation date and time
 20h	DWORD	(big-endian) owner ID
 24h	DWORD	last-backup date and time
 28h	DWORD	(big-endian) last-backup ID
 2Ch	DWORD	last-modification date and time
---DOS file---
 30h	DWORD	(big-endian) last-modification ID
 34h	DWORD	file size
 38h 44 BYTEs	reserved
 64h	WORD	inherited rights mask
 66h	WORD	last-access date
 68h 28 BYTEs	reserved
---DOS subdirectory---
 30h	DWORD	next trustee entry
 34h 48 BYTEs	reserved
 64h	WORD	maximum space
 66h	WORD	inherited rights mask
 68h 26 BYTEs	reserved
---Macintosh subdirectory---
 10h 32 BYTEs	Mac filename
 30h	DWORD	resource fork
 34h	DWORD	resource fork size
 38h 32 BYTEs	Finder information
 58h  6 BYTEs	ProDOS information
 5Eh 38 BYTEs	reserved
SeeAlso: #1450
--------N-21F216SF31-------------------------
INT 21 - Novell NetWare - OPEN DATA STREAM
	AX = F216h subfn 31h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1452)
	ES:DI -> reply packet fragment list (see #1413,#1453)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=30h

Format of NetWare "Open Data Stream" request packet:
Offset	Size	Description	(Table 1452)
 00h	WORD	length of following data
 02h	BYTE	31h (subfunction "Open Data Stream")
 03h	BYTE	data stream
 04h	BYTE	directory handle
 05h	BYTE	file attributes
 06h	BYTE	open rights
 07h	BYTE	length of filename
 08h  N BYTEs	filename (8.3)
SeeAlso: #1453

Format of NetWare "Open Data Stream" reply packet:
Offset	Size	Description	(Table 1453)
 00h	DWORD	file handle
SeeAlso: #1452
--------N-21F216SF32-------------------------
INT 21 - Novell NetWare v2.2+ - GET OBJECT EFFECTIVE RIGHTS
	AX = F216h subfn 32h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1454)
	ES:DI -> reply buffer (see #1455)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F216h/SF=29h

Format of NetWare "Get Object Effective Rights" request buffer:
Offset	Size	Description	(Table 1454)
 00h	WORD	length of following data
 02h	BYTE	32h (subfunction "Get Object Effective Rights")
 03h	DWORD	object ID
 07h	BYTE	directory handle
 08h	var	counted path string
SeeAlso: #1455

Format of NetWare "Get Object Effective Rights" reply buffer:
Offset	Size	Description	(Table 1455)
 00h	WORD	object's effective rights
 02h  6 BYTEs	reserved
SeeAlso: #1454
--------N-21F216SF33-------------------------
INT 21 - Novell NetWare v2.2+ - GET EXTENDED VOLUME INFORMATION
	AX = F216h subfn 33h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1456)
	ES:DI -> reply buffer (see #1457)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F216h/SF=29h

Format of NetWare "Get Extended Volume Information" request buffer:
Offset	Size	Description	(Table 1456)
 00h	WORD	length of following data
 02h	BYTE	33h (subfunction "Get Extended Volume Information")
---v2.2---
 03h	BYTE	volume ID
---v4.x---
 03h	DWORD	volume number
SeeAlso: #1457

Format of NetWare "Get Extended Volume Information" reply buffer:
Offset	Size	Description	(Table 1457)
 00h	WORD	length of returned data
 02h	DWORD	volume type
 06h	DWORD	status flag bits
		bit 0: suballocation
		bit 1: compressoin
		bit 2: migration
		bit 3: auditing
 0Ah	DWORD	sector size
 0Eh	DWORD	sectors per cluster
 12h	DWORD	total clusters in volume
 16h	DWORD	free clusters
 1Ah	DWORD	freeable suballocated clusters
 1Eh	DWORD	freeable in-limbo sectors
 22h	DWORD	non-freeable in-limbo sectors
 26h	DWORD	non-freeable available suballocated sectors
 2Ah	DWORD	unuable suballocated sectors
 2Eh	DWORD	total suballocated clusters
 32h	DWORD	number of data streams
 36h	DWORD	number of in-limbo data streams
 3Ah	DWORD	age of oldest deleted file in clock ticks
 3Eh	DWORD	number of compressed data streams
 42h	DWORD	number of compressed in-limbo data streams
 46h	DWORD	number of uncompressable data streams
 4Ah	DWORD	number of precompressed sectors
 4Eh	DWORD	number of compressed sectors
 52h	DWORD	number of migrated files
 56h	DWORD	number of migrated sectors
 5Ah	DWORD	number of clusters used by FAT
 5Eh	DWORD	number of clusters used by directories
 62h	DWORD	number of clusters used by extended directories
 66h	DWORD	total number of directory entries
 6Ah	DWORD	number of unused directory entries
 6Eh	DWORD	total number of extended directory extants
 72h	DWORD	number of unused extended directory extants
 76h	DWORD	number of extended attributes defined (see AX=F256h/SF=04h)
 7Ah	DWORD	number of extended-attribute extants used
 7Eh	DWORD	object ID for Directory Services
 82h	DWORD	date and time volume last modified
 86h	var	counted volume name string
SeeAlso: #1456
--------N-21F217SF01-------------------------
INT 21 - Novell NetWare - CHANGE USER PASSWORD (OLD)
	AX = F217h subfn 01h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1185 at AH=E3h/SF=01h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
Note:	this function requires an object of type USER, unlike the newer
	  password changing function AX=F217h/SF=40h
SeeAlso: AH=F2h"Novell",AH=E3h/SF=01h,AX=F217h/SF=02h,AX=F217h/SF=40h
--------N-21F217SF02-------------------------
INT 21 - Novell NetWare - GET USER CONNECTION LIST (OLD)
	AX = F217h subfn 02h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1186 at AH=E3h/SF=02h)
	ES:DI -> reply packet fragment list (see #1413,#1458)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=02h,AX=F217h/SF=01h,AX=F217h/SF=0Ch

Format of NetWare "Get User Connection List (old)" reply packet:
Offset	Size	Description	(Table 1458)
 00h	BYTE	length of connection list
 01h	BYTE	number of bytes in connection list
 02h  N BYTEs	list of connection numbers in use by user
SeeAlso: #1186
--------N-21F217SF0C-------------------------
INT 21 - Novell NetWare - VERIFY SERIALIZATION
	AX = F217h subfn 0Ch
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1190 at AH=E3h/SF=0Ch)
	ES:DI -> reply packet fragment list (see #1413,#1459)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=0Ch,AX=F217h/SF=12h

Format of NetWare "Verify Serialization" reply packet:
Offset	Size	Description	(Table 1459)
 00h	WORD	server application number
SeeAlso: #1190
--------N-21F217SF0E-------------------------
INT 21 - Novell NetWare - GET DISK UTILIZATION
	AX = F217h subfn 0Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1194 at AH=E3h/SF=0Eh)
	ES:DI -> reply packet fragment list (see #1413,#1460)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=0Eh,AX=F217h/SF=D6h

Format of NetWare "Get Disk Utilization" reply packet:
Offset	Size	Description	(Table 1460)
 00h	BYTE	volume number (00h-1Fh)
 01h	DWORD	(big-endian) object ID
 05h	WORD	(big-endian) directories used by object
 07h	WORD	(big-endian) files created by object
 09h	WORD	(big-endian) disk blocks used by object-created files
SeeAlso: #1194 at AH=E3h/SF=0Eh
--------N-21F217SF0F-------------------------
INT 21 - Novell NetWare - SCAN FILE INFORMATION
	AX = F217h subfn 0Fh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1197 at AH=E3h/SF=0Fh)
	ES:DI -> reply packet fragment list (see #1413,#1461)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=0Fh,AX=F217h/SF=10h

Format of NetWare "Scan File Information" reply packet:
Offset	Size	Description	(Table 1461)
 00h	WORD	next sequence number (place in request buffer for next call)
 02h 14 BYTEs	ASCIZ filename
 10h	BYTE	file attributes (see #0731 at AX=4301h)
 11h	BYTE	extended file attributes (see #1098 at AH=B6h)
 12h	DWORD	(big-endian) file size in bytes
 16h	WORD	(big-endian) file's creation date (see #0972 at AX=5700h)
 18h	WORD	(big-endian) date of last access (see #0971 at AX=5700h)
 1Ah	DWORD	(big-endian) date and time of last update (see #1140)
 1Eh	DWORD	(big-endian) object ID of owner
 22h	DWORD	(big-endian) date and time last archived (see #1140)
 26h 55 BYTEs	reserved
SeeAlso: #1197 at AH=E3h/SF=0Fh
--------N-21F217SF10-------------------------
INT 21 - Novell NetWare - SET FILE INFORMATION
	AX = F217h subfn 10h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1199 at AH=E3h/SF=10h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=10h,AX=F217h/SF=0Fh
--------N-21F217SF11-------------------------
INT 21 - Novell NetWare - GET FILE SERVER INFORMATION
	AX = F217h subfn 11h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1201 at AH=E3h/SF=11h)
	ES:DI -> reply packet fragment list (see #1413,#1462)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=11h,AX=F217h/SF=F1h

Format of NetWare "Get File Server Information" reply packet:
Offset	Size	Description	(Table 1462)
 00h 48 BYTEs	server's name
 30h	BYTE	NetWare version
 31h	BYTE	NetWare subversion (0-99)
 32h	WORD	(big-endian) number of connections supported
		NetWare 4.01 reportedly returns maximum simulataneously-used
		  connections
 34h	WORD	(big-endian) number of connections in use
 36h	WORD	(big-endian) maximum connected volumes
---Advanced NetWare 2.1+ ---
 38h	BYTE	operating system revision number
 39h	BYTE	fault tolerance (SFT) level
 3Ah	BYTE	TTS level
 3Bh	WORD	(big-endian) maximum simultaneously-used connections
		NetWare 4.01 reportedly returns number of connections in use
 3Dh	BYTE	accounting version
 3Eh	BYTE	VAP version
 3Fh	BYTE	queueing version
 40h	BYTE	print server version
 41h	BYTE	virtual console version
 42h	BYTE	security restrictions level
 43h	BYTE	internetwork bridge version
 44h 60 BYTEs	reserved
SeeAlso: #1201
--------N-21F217SF12-------------------------
INT 21 - Novell NetWare - GET NETWORK SERIAL NUMBER
	AX = F217h subfn 12h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1203 at AH=E3h/SF=12h)
	ES:DI -> reply packet fragment list (see #1413,#1463)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=12h,AX=F217h/SF=0Ch

Format of NetWare "Get Network Serial Number" reply packet:
Offset	Size	Description	(Table 1463)
 00h   4 BYTEs	(big-endian) NetWare server serial number
 04h   2 BYTEs	(big-endian) NetWare application serial number
SeeAlso: #1203 at AH=E3h/SF=12h
--------N-21F217SF13-------------------------
INT 21 - Novell NetWare - GET INTERNET ADDRESS (OLD)
	AX = F217h subfn 13h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1205 at AH=E3h/SF=13h)
	ES:DI -> reply packet fragment list (see #1413,#1464)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=13h,AX=F217h/SF=1Ah

Format of NetWare "Get Internet Address (old)" reply packet:
Offset	Size	Description	(Table 1464)
 00h  4 BYTEs	network number
 04h  6 BYTEs	physical node address
 0Ah  2 BYTEs	socket number
SeeAlso: #1205 at AH=E3h/SF=13h,#1470
--------N-21F217SF14-------------------------
INT 21 - Novell NetWare - LOGIN OBJECT
	AX = F217h subfn 14h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1207 at AH=E3h/SF=14h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=14h,AX=F216h/SF=18h,AX=F217h/SF=CCh
SeeAlso: AX=F258h/SF=03h,AX=F268h/SF=39h
--------N-21F217SF15-------------------------
INT 21 - Novell NetWare - GET OBJECT CONNECTION LIST (OLD)
	AX = F217h subfn 15h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1209 at AH=E3h/SF=15h)
	ES:DI -> reply packet fragment list (see #1413,#1465)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=15h,AX=F217h/SF=1Bh

Format of NetWare "Get Object Connection List (old)" reply packet:
Offset	Size	Description	(Table 1465)
 00h	BYTE	number of connections
 01h  N BYTEs	connection list
SeeAlso: #1209
--------N-21F217SF16-------------------------
INT 21 - Novell NetWare - GET CONNECTION INFORMATION (OLD)
	AX = F217h subfn 16h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1466)
	ES:DI -> reply packet fragment list (see #1413,#1467)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F217h/SF=1Ch,AX=F217h/SF=1Fh

Format of NetWare "Get Connection Information (old)" request packet:
Offset	Size	Description	(Table 1466)
 00h	WORD	0002h (length of following data)
 02h	BYTE	16h (subfunction "Get Connection Information (old)")
 03h	BYTE	target connection number
Note:	connection numbers greater than the maximum supported by the server
	  can cause ABENDs
SeeAlso: #1467

Format of NetWare "Get Connection Information (old)" reply packet:
Offset	Size	Description	(Table 1467)
 00h	DWORD	(big-endian) unique user ID, 00000000h if no one logged in
 04h	WORD	(big-endian) user type
 06h 48 BYTEs	user name
 36h  7 BYTEs	login time (see #1383)
 3Dh	BYTE	reserved
SeeAlso: #1466
--------N-21F217SF17-------------------------
INT 21 - Novell NetWare - GET ENCRYPTION KEY
	AX = F217h subfn 17h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1468)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=18h,AX=F217h/SF=4Ah,AX=F217h/SF=4Bh

Format of NetWare "Get Encryption Key" request packet:
Offset	Size	Description	(Table 1468)
 00h	WORD	length of following data
 02h	BYTE	17h (subfunction "Get Encryption Key")
	???
--------N-21F217SF18-------------------------
INT 21 - Novell NetWare - LOGIN OBJECT ENCRYPTED
	AX = F217h subfn 18h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1469)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=14h,AX=F217h/SF=17h

Format of NetWare "Login Object Encrypted" request packet:
Offset	Size	Description	(Table 1469)
 00h	WORD	length of following data
 02h	BYTE	18h (subfunction "Login Object Encrypted")
	???
--------N-21F217SF1A-------------------------
INT 21 - Novell NetWare - GET INTERNET ADDRESS
	AX = F217h subfn 1Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1470)
	ES:DI -> reply packet fragment list (see #1413,#1471)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=13h

Format of NetWare "Get Internet Address" request packet:
Offset	Size	Description	(Table 1470)
 00h	WORD	length of following data
 02h	BYTE	1Ah (subfunction "Get Internet Address")
 03h	DWORD	target connection ID
SeeAlso: #1471

Format of NetWare "Get Internet Address" request packet:
Offset	Size	Description	(Table 1471)
 00h  4 BYTEs	network number
 04h  6 BYTEs	physical node address
 0Ah  2 BYTEs	socket number
 0Ch	BYTE	connection type
		00h not in use
		02h NCP
		03h AFP
SeeAlso: #1470
--------N-21F217SF1B-------------------------
INT 21 - Novell NetWare - GET OBJECT CONNECTION LIST
	AX = F217h subfn 1Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1472)
	ES:DI -> reply packet fragment list (see #1413,#1473)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=15h

Format of NetWare "Get Object Connection List" request packet:
Offset	Size	Description	(Table 1472)
 00h	WORD	length of following data
 02h	BYTE	1Bh (subfunction "Get Object Connection List")
 03h	DWORD	search connection number
		set to highest connection number returned by previous call, or
		  00000000h before first call
 07h	WORD	object type
 09h	BYTE	length of object's name
 0Ah  N BYTEs	object name
SeeAlso: #1473

Format of NetWare "Get Object Connection List" reply packet:
Offset	Size	Description	(Table 1473)
 00h	BYTE	length of connection number list
 01h  N WORDs	array of server connection numbers
SeeAlso: #1472
--------N-21F217SF1C-------------------------
INT 21 - Novell NetWare v3+ - GET CONNECTION INFORMATION
	AX = F217h subfn 1Ch
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1474)
	ES:DI -> reply packet fragment list (see #1413,#1475)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F217h/SF=16h,AX=F217h/SF=1Fh

Format of NetWare "Get Connection Information" request packet:
Offset	Size	Description	(Table 1474)
 00h	WORD	0005h (length of following data)
 02h	BYTE	1Ch (subfunction "Get Connection Information")
 03h	DWORD	target connection number
Note:	connection numbers greater than the maximum supported by the server
	  can cause ABENDs
SeeAlso: #1475,#1466

Format of NetWare "Get Connection Information" reply packet:
Offset	Size	Description	(Table 1475)
 00h	DWORD	(big-endian) unique user ID, 00000000h if no one logged in
 04h	WORD	(big-endian) user type
 06h 48 BYTEs	user name
 36h  7 BYTEs	login time (see #1383)
 3Dh	BYTE	reserved
SeeAlso: #1474,#1467
--------N-21F217SF1D-------------------------
INT 21 - Novell NetWare v4 - CHANGE CONNECTION STATE
	AX = F217h subfn 1Dh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1476)
	ES:DI -> reply buffer
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Change Connection State" requst buffer:
Offset	Size	Description	(Table 1476)
 00h	WORD	length of following data
 02h	BYTE	1Dh (subfunction "Change Connection State")
 03h	DWORD	new state
--------N-21F217SF1E-------------------------
INT 21 - Novell NetWare v4 - SET WATCHDOG DELAY INTERVAL
	AX = F217h subfn 1Eh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1477)
	ES:DI -> reply buffer
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Set Watchdog Delay Interval" request buffer:
Offset	Size	Description	(Table 1477)
 00h	WORD	length of following data
 02h	BYTE	1Eh (subfunction "Set Watchdog Delay Interval")
 03h	DWORD	interval in minutes
--------N-21F217SF1F-------------------------
INT 21 - Novell NetWare v4 - GET CONNECTION LIST
	AX = F217h subfn 1Fh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1478)
	ES:DI -> reply buffer (see #1479)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get Connection List" request buffer:
Offset	Size	Description	(Table 1478)
 00h	WORD	length of following data
 02h	BYTE	1Fh (subfunction "Get Connection List")
 03h	DWORD	object ID
 07h	DWORD	??? (initialize to FFFFFFFFh before first call)
SeeAlso: #1479

Format of NetWare "Get Connection List" reply buffer:
Offset	Size	Description	(Table 1479)
 00h	WORD	number of connections following (max 50)
 02h 50 DWORDs	connection numbers
SeeAlso: #1478
--------N-21F217SF32-------------------------
INT 21 - Novell NetWare - CREATE BINDERY OBJECT
	AX = F217h subfn 32h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1215 at AH=E3h/SF=32h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=32h,AX=F217h/SF=33h,AX=F217h/SF=34h
--------N-21F217SF33-------------------------
INT 21 - Novell NetWare - DELETE BINDERY OBJECT
	AX = F217h subfn 33h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1217 at AH=E3h/SF=33h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=33h,AX=F217h/SF=32h,AX=F217h/SF=34h
--------N-21F217SF34-------------------------
INT 21 - Novell NetWare - RENAME BINDERY OBJECT
	AX = F217h subfn 34h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1218 at AH=E3h/SF=34h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=34h,AX=F217h/SF=32h,AX=F217h/SF=33h
--------N-21F217SF35-------------------------
INT 21 - Novell NetWare - GET BINDERY OBJECT ID
	AX = F217h subfn 35h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1219 at AH=E3h/SF=35h)
	ES:DI -> reply packet fragment list (see #1413,#1480)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=35h,AX=F217h/SF=36h,AX=F217h/SF=45h

Format of NetWare "Get Bindery Object ID" reply packet:
Offset	Size	Description	(Table 1480)
 00h	DWORD	(big-endian) object ID
 04h	WORD	(big-endian) type of object
 06h 48 BYTEs	object name
SeeAlso: #1219 at AH=E3h/SF=35h
--------N-21F217SF36-------------------------
INT 21 - Novell NetWare - GET BINDERY OBJECT NAME
	AX = F217h subfn 36h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1222 at AH=E3h/SF=36h)
	ES:DI -> reply packet fragment list (see #1413,#1481)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=36h,AX=F217h/SF=35h,AX=F217h/SF=37h

Format of NetWare "Get Bindery Object Name" reply packet:
Offset	Size	Description	(Table 1481)
 00h	DWORD	(big-endian) object ID
 04h	WORD	(big-endian) type of object
 06h 48 BYTEs	object name
SeeAlso: #1222 at AH=E3h/SF=36h
--------N-21F217SF37-------------------------
INT 21 - Novell NetWare - SCAN BINDERY OBJECT
	AX = F217h subfn 37h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1224 at AH=E3h/SF=37h)
	ES:DI -> reply packet fragment list (see #1413,#1482)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=37h,AX=F217h/SF=3Ch

Format of NetWare "Scan Bindery Object" reply packet:
Offset	Size	Description	(Table 1482)
 00h
SeeAlso: #1224
--------N-21F217SF38-------------------------
INT 21 - Novell NetWare - CHANGE BINDERY OBJECT SECURITY
	AX = F217h subfn 38h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply buffer)
	DS:SI -> request packet fragment list
		(see #1413,#1226 at AH=E3h/SF=38h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=38h,AX=F217h/SF=32h
--------N-21F217SF39-------------------------
INT 21 - Novell NetWare - CREATE PROPERTY
	AX = F217h subfn 39h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1228 at AH=E3h/SF=39h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=39h,AX=F217h/SF=3Ah
--------N-21F217SF3A-------------------------
INT 21 - Novell NetWare - DELETE PROPERTY
	AX = F217h subfn 3Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1230 at AH=E3h/SF=3Ah)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=3Ah,AX=F217h/SF=39h,AX=F217h/SF=3Bh
--------N-21F217SF3B-------------------------
INT 21 - Novell NetWare - CHANGE PROPERTY SECURITY
	AX = F217h subfn 3Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply buffer)
	DS:SI -> request packet fragment list
		(see #1413,#1232 at AH=E3h/SF=3Bh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=3Bh
--------N-21F217SF3C-------------------------
INT 21 - Novell NetWare - SCAN PROPERTY
	AX = F217h subfn 3Ch
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1233 at AH=E3h/SF=3Ch)
	ES:DI -> reply packet fragment list (see #1413,#1483)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=3Ch,AX=F217h/SF=39h,AX=F217h/SF=3Dh

Format of NetWare "Scan Property" reply packet:
Offset	Size	Description	(Table 1483)
 00h
SeeAlso: #1233
--------N-21F217SF3D-------------------------
INT 21 - Novell NetWare - READ PROPERTY VALUE
	AX = F217h subfn 3Dh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1236 at AH=E3h/SF=3Dh)
	ES:DI -> reply packet fragment list (see #1413,#1484)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=3Dh,AX=F217h/SF=39h,AX=F217h/SF=3Eh

Format of NetWare "Read Property Value" request packet:
Offset	Size	Description	(Table 1484)
 00h
SeeAlso: #1236
--------N-21F217SF3E-------------------------
INT 21 - Novell NetWare - WRITE PROPERTY VALUE
	AX = F217h subfn 3Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1238 at AH=E3h/SF=3Eh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=3Eh,AX=F217h/SF=39h,AX=F217h/SF=3Dh
--------N-21F217SF3F-------------------------
INT 21 - Novell NetWare - VERIFY BINDERY OBJECT PASSWORD
	AX = F217h subfn 3Fh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1241 at AH=E3h/SF=3Fh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=3Fh,AX=F217h/SF=40h
--------N-21F217SF40-------------------------
INT 21 - Novell NetWare - CHANGE BINDERY OBJECT PASSWORD
	AX = F217h subfn 40h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply buffer)
	DS:SI -> request packet fragment list
		(see #1413,#1242 at AH=E3h/SF=40h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=40h,AX=F217h/SF=3Fh
--------N-21F217SF41-------------------------
INT 21 - Novell NetWare v2.2+ - ADD OBJECT TO SET
	AX = F217h subfn 41h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1245 at AH=E3h/SF=41h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
Desc:	add a member to an object's group property
SeeAlso: AH=F2h"Novell",AH=E3h/SF=41h,AX=F217h/SF=42h,AX=F217h/SF=43h
--------N-21F217SF42-------------------------
INT 21 - Novell NetWare - DELETE BINDERY OBJECT FROM SET
	AX = F217h subfn 42h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1246 at AH=E3h/SF=42h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=42h,AX=F217h/SF=41h,AX=F217h/SF=43h
--------N-21F217SF43-------------------------
INT 21 - Novell NetWare - IS BINDERY OBJECT IN SET?
	AX = F217h subfn 43h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment
		list (see #1413,#1248 at AH=E3h/SF=43h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=43h,AX=F217h/SF=41h,,AX=F217h/SF=42h
--------N-21F217SF44-------------------------
INT 21 - Novell NetWare - CLOSE BINDERY
	AX = F217h subfn 44h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1249 at AH=E3h/SF=44h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=44h,AX=F217h/SF=45h
--------N-21F217SF45-------------------------
INT 21 - Novell NetWare - OPEN BINDERY
	AX = F217h subfn 45h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1250 at AH=E3h/SF=45h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=45h,AX=F217h/SF=44h
--------N-21F217SF46-------------------------
INT 21 - Novell NetWare - GET BINDERY ACCESS LEVEL
	AX = F217h subfn 46h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1251 at AH=E3h/SF=46h)
	ES:DI -> reply packet fragment list (see #1413,#1485)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=46h,AX=F217h/SF=45h

Format of NetWare "Get Bindery Access Level" reply packet:
Offset	Size	Description	(Table 1485)
 00h	BYTE	security levels
 01h	DWORD	(big-endian) object ID
SeeAlso: #1251,#1252 at AH=E3h/SF=46h
--------N-21F217SF47-------------------------
INT 21 - Novell NetWare - SCAN BINDERY OBJECT TRUSTEE PATHS
	AX = F217h subfn 47h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1253 at AH=E3h/SF=47h)
	ES:DI -> reply packet fragment list (see #1413,#1486)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=47h,AX=F216h/SF=0Ch,AX=F217h/SF=48h

Format of NetWare "Scan Bindery Object Trustee Paths" reply packet:
Offset	Size	Description	(Table 1486)
 00h	WORD	(big-endian) next sequence number
 02h	DWORD	(big-endian) object ID
 06h	BYTE	trustee directory rights (see #1143 at AH=E2h/SF=03h)
 07h	BYTE	length of trustee path
 08h  N BYTEs	trustee path
SeeAlso: #1253,#1254 at AH=E3h/SF=47h
--------N-21F217SF48-------------------------
INT 21 - Novell NetWare - GET BINDERY OBJECT ACCESS LEVEL
	AX = F217h subfn 48h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1256 at AH=E3h/SF=48h)
	ES:DI -> reply packet fragment list (see #1413,#1488)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=45h,AX=F217h/SF=46h

Format of NetWare "Get Bindery Object Access Level" request packet:
Offset	Size	Description	(Table 1487)
 00h	WORD	length of following data (max ABh)
 02h	BYTE	48h (subfunction "Get Bindery Object Access Level")
 03h	DWORD	object ID
SeeAlso: #1488

Format of NetWare "Get Bindery Object Access Level" reply packet:
Offset	Size	Description	(Table 1488)
 00h	BYTE	object access level
SeeAlso: #1487
--------N-21F217SF49-------------------------
INT 21 - Novell NetWare - IS STATION A MANAGER?
	AX = F217h subfn 49h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1489)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=43h

Format of NetWare "Is Station A Manager?" request packet:
Offset	Size	Description	(Table 1489)
 00h	WORD	length of following data
 02h	BYTE	49h (subfunction "Is Station A Manager?")
 03h	DWORD	object ID
--------N-21F217SF4A-------------------------
INT 21 - Novell NetWare - KEYED VERIFY BINDERY OBJECT PASSWORD
	AX = F217h subfn 4Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1490)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=4Bh

Format of NetWare "Keyed Verify Bindery Object Password" request packet:
Offset	Size	Description	(Table 1490)
 00h	WORD	length of following data
 02h	BYTE	4Ah (subfunction "Keyed Verify Bindery Object Password")
 03h  8 BYTEs	key
 0Bh	WORD	type
 0Dh	BYTE	length of object's name
 0Eh  N BYTEs	object name
SeeAlso: #1491
--------N-21F217SF4B-------------------------
INT 21 - Novell NetWare - KEYED CHANGE BINDERY OBJECT PASSWORD
	AX = F217h subfn 4Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1491)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=4Ah

Format of NetWare "Keyed Change Bindery Object Password" request packet:
Offset	Size	Description	(Table 1491)
 00h	WORD	length of following data
 02h	BYTE	4Bh (subfunction "Keyed Change Bindery Object Password")
 03h  8 BYTEs	key
 0Bh	WORD	type
 0Dh	BYTE	length of object name
 0Eh  N BYTEs	object name
	BYTE	length of new password
      N BYTEs	new password
SeeAlso: #1242
--------N-21F217SF4C-------------------------
INT 21 - Novell NetWare - LIST RELATIONS OF AN OBJECT
	AX = F217h subfn 4Ch
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1492)
	ES:DI -> reply packet fragment list (see #1413,#1493)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=39h

Format of NetWare "List Relations Of An Object" request packet:
Offset	Size	Description	(Table 1492)
 00h	WORD	length of following data
 02h	BYTE	4Ch (subfunction "List Relations Of An Object")
 03h	DWORD	last bindery ID seen (set to FFFFFFFFh on first call)
 07h	WORD	object type
 09h	BYTE	length of object's name
 0Ah  N BYTEs	object's name
	BYTE	length of property name
      N BYTEs	property name
SeeAlso: #1493

Format of NetWare "List Relations Of An Object" reply packet:
Offset	Size	Description	(Table 1493)
 00h	WORD	number of relations returned
 02h	var	relations
SeeAlso: #1492
--------N-21F217SF64-------------------------
INT 21 - Novell NetWare v2.1+ - CREATE QUEUE
	AX = F217h subfn 64h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1256 at AH=E3h/SF=64h)
	ES:DI -> reply packet fragment list (see #1413,#1494)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=64h,AX=F217h/SF=65h,AX=F217h/SF=66h

Format of NetWare "Create Queue" reply packet:
Offset	Size	Description	(Table 1494)
 00h	DWORD	(big-endian) object ID of queue
SeeAlso: #1256,#1257
--------N-21F217SF65-------------------------
INT 21 - Novell NetWare v2.1+ - DESTROY QUEUE
	AX = F217h subfn 65h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1258 at AH=E3h/SF=65h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=65h,AX=F217h/SF=64h,AX=F217h/SF=66h
--------N-21F217SF66-------------------------
INT 21 - Novell NetWare v2.1+ - READ QUEUE CURRENT STATUS (OLD)
	AX = F217h subfn 66h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1259 at AH=E3h/SF=66h)
	ES:DI -> reply packet fragment list (see #1413,#1495)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=66h,AX=F217h/SF=64h,AX=F217h/SF=67h

Format of NetWare "Read Queue Current Status (Old)" reply packet:
Offset	Size	Description	(Table 1495)
 00h	DWORD	(big-endian) object ID of queue
 04h	BYTE	status of queue (see #1261)
 05h	BYTE	number of jobs in queue (00h-FAh)
 06h	BYTE	number of servers attached to queue (00h-19h)
 07h 25 DWORDs	list of object IDs of attached servers
 6Bh 25 BYTEs	list of attached servers' stations
 84h	BYTE	(call) maximum number of servers to return
SeeAlso: #1259,#1260 at AH=E3h/SF=66h
--------N-21F217SF67-------------------------
INT 21 - Novell NetWare v2.1+ - SET QUEUE CURRENT STATUS (OLD)
	AX = F217h subfn 67h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
		(see #1413,#1262 at AH=E3h/SF=67h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=67h,AX=F217h/SF=66h,AX=F217h/SF=68h
--------N-21F217SF68-------------------------
INT 21 - Novell NetWare v2.1+ - CREATE QUEUE JOB AND FILE (OLD)
	AX = F217h subfn 68h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
		(see #1413,#1264 at AH=E3h/SF=68h)
	ES:DI -> reply packet fragment list (see #1413,#1496)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=68h,AX=F217h/SF=67h,AX=F217h/SF=69h

Format of NetWare "Create Queue Job And File (Old)" reply packet:
Offset	Size	Description	(Table 1496)
 00h	BYTE	client station
 01h	BYTE	client task number
 02h	DWORD	(big-endian) object ID of client
 06h	DWORD	(big-endian) object ID of target server
 0Ah  6 BYTEs	target execution time (year,month,day,hour,minute,second)
 10h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 16h	WORD	(big-endian) job number
 18h	WORD	(big-endian) job type
 1Ah	BYTE	job position
 1Bh	BYTE	job control flags (see #1274)
 1Ch 14 BYTEs	ASCIZ job file name
 2Ah  6 BYTEs	job file handle
 30h	BYTE	server station
 31h	BYTE	server task number
 32h	DWORD	(big-endian) object ID of server or 00000000h
SeeAlso: #1264,#1266
--------N-21F217SF69-------------------------
INT 21 - Novell NetWare v2.1+ - CLOSE FILE AND START QUEUE JOB (OLD)
	AX = F217h subfn 69h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1267 at AH=E3h/SF=69h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=69h,AX=F217h/SF=6Ah,AX=F217h/SF=7Fh
--------N-21F217SF6A-------------------------
INT 21 - Novell NetWare v2.1+ - REMOVE JOB FROM QUEUE (OLD)
	AX = F217h subfn 6Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1269 at AH=E3h/SF=6Ah)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=6Ah,AX=F217h/SF=68h,AX=F217h/SF=69h
--------N-21F217SF6B-------------------------
INT 21 - Novell NetWare v2.1+ - GET QUEUE JOB LIST (OLD)
	AX = F217h subfn 6Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1270 at AH=E3h/SF=6Bh)
	ES:DI -> reply packet fragment list (see #1413,#1497)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=6Bh,AX=F217h/SF=6Ah,AX=F217h/SF=6Ch
SeeAlso: AX=F217h/SF=81h

Format of NetWare "Get Queue Job List (old)" reply packet:
Offset	Size	Description	(Table 1497)
 00h	WORD	(big-endian) job count
 02h  N WORDs	(big-endian) list of job numbers by position in queue
SeeAlso: #1270,#1271 at AH=E3h/SF=6Bh
--------N-21F217SF6C-------------------------
INT 21 - Novell NetWare v2.1+ - READ QUEUE JOB ENTRY (OLD)
	AX = F217h subfn 6Ch
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1272 at AH=E3h/SF=6Ch)
	ES:DI -> reply packet fragment list (see #1413,#1498)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=6Ch,AX=F217h/SF=6Bh,AX=F217h/SF=6Dh

Format of NetWare "Read Queue Job Entry (old)" reply packet:
Offset	Size	Description	(Table 1498)
 00h	BYTE	client station number
 01h	BYTE	client task number
 02h	DWORD	object ID of client
 06h	DWORD	(big-endian) object ID of target server
		FFFFFFFFh if any server acceptable
 0Ah  6 BYTEs	target execution time (year,month,day,hour,minute,second)
		FFFFFFFFFFFFh if serviced as soon as possible
 10h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 16h	WORD	(big-endian) job number
 18h	WORD	(big-endian) job type
 1Ah	BYTE	job position
 1Bh	BYTE	job control flags (see #1274)
 1Ch 14 BYTEs	ASCIZ job filename
 2Ah  6 BYTEs	job file handle
 30h	BYTE	server station
 31h	BYTE	server task number
 32h	DWORD	object ID of server
 36h 50 BYTEs	ASCIZ job description string
 68h 152 BYTEs	client record area
SeeAlso: #1272,#1273
--------N-21F217SF6D-------------------------
INT 21 - Novell NetWare v2.1+ - CHANGE QUEUE JOB ENTRY (OLD)
	AX = F217h subfn 6Dh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1275 at AH=E3h/SF=6Dh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=7Bh,AH=E3h/SF=6Dh,AX=F217h/SF=6Ch
--------N-21F217SF6E-------------------------
INT 21 - Novell NetWare v2.1+ - CHANGE QUEUE JOB POSITION
	AX = F217h subfn 6Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1276 at AH=E3h/SF=6Eh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AX=F217h/SF=6Dh,AH=E3h/SF=6Eh
--------N-21F217SF6F-------------------------
INT 21 - Novell NetWare v2.1+ - ATTACH QUEUE SERVER TO QUEUE
	AX = F217h subfn 6Fh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1278 at AH=E3h/SF=6Fh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=6Fh,AX=F217h/SF=D2h
--------N-21F217SF70-------------------------
INT 21 - Novell NetWare v2.1+ - DETACH QUEUE SERVER FROM QUEUE
	AX = F217h subfn 70h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	     (see #1413,#1279 at AH=E3h/SF=70h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=70h,AX=F217h/SF=6Fh
--------N-21F217SF71-------------------------
INT 21 - Novell NetWare v2.1+ - SERVICE QUEUE JOB AND OPEN FILE
	AX = F217h subfn 71h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	     (see #1413,#1280 at AH=E3h/SF=70h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
Notes:	the caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USERS, Q_OPERATORS, or Q_SERVERS properties
SeeAlso: AH=E3h/SF=71h,AX=F217h/SF=70h,AX=F217h/SF=72h
--------N-21F217SF72-------------------------
INT 21 - Novell NetWare v2.1+ - FINISH SERVICING QUEUE JOB (OLD)
	AX = F217h subfn 72h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1281 at AH=E3h/SF=72h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=72h,AX=F217h/SF=71h,AX=F217h/SF=73h
SeeAlso: AX=F217h/SF=83h
--------N-21F217SF73-------------------------
INT 21 - Novell NetWare v2.1+ - ABORT SERVICING QUEUE JOB (OLD)
	AX = F217h subfn 73h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1282 at AH=E3h/SF=73h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=73h,AX=F217h/SF=72h,AX=F217h/SF=84h
--------N-21F217SF74-------------------------
INT 21 - Novell NetWare v2.1+ - CHANGE TO CLIENT RIGHTS (OLD)
	AX = F217h subfn 74h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1284 at AH=E3h/SF=74h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
Desc:	temporarily assume the login identity of the client submitting the
	  job being serviced
SeeAlso: AH=F2h"NetWare",AH=E3h/SF=74h,AX=F217h/SF=85h
--------N-21F217SF75-------------------------
INT 21 - Novell NetWare v2.1+ - RESTORE QUEUE SERVER RIGHTS
	AX = F217h subfn 75h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1285 at AH=E3h/SF=75h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=75h,AX=F217h/SF=74h
--------N-21F217SF76-------------------------
INT 21 - Novell NetWare - READ QUEUE SERVER CURRENT STATUS (OLD)
	AX = F217h subfn 76h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1286 at AH=E3h/SF=76h)
	ES:DI -> reply packet fragment list (see #1413,#1499)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=76h,AX=F217h/SF=74h,AX=F217h/SF=77h

Format of NetWare "Read Queue Server Current Status (old)" reply packet:
Offset	Size	Description	(Table 1499)
 00h 64 BYTEs	server status record (format depends on server)
		first four bytes should contain estimated "price" for an
		  average job
SeeAlso: #1286,#1287 at AH=E3h/SF=76h
--------N-21F217SF77-------------------------
INT 21 - Novell NetWare - SET QUEUE SERVER CURRENT STATUS
	AX = F217h subfn 77h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1288 at AH=E3h/SF=77h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=77h,AX=F217h/SF=76h
--------N-21F217SF78-------------------------
INT 21 - Novell NetWare - GET QUEUE JOB FILE SIZE (OLD)
	AX = F217h subfn 78h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	       (see #1413,#1290 at AH=E3h/SF=78h)
	ES:DI -> reply packet fragment list (see #1413,#1500)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=78h,AX=F217h/SF=71h,AX=F217h/SF=79h

Format of NetWare "Get Queue Job File Size (old)" reply packet:
Offset	Size	Description	(Table 1500)
 00h	DWORD	(big-endian) object ID of queue
 04h	WORD	(big-endian) job number
 06h	DWORD	(big-endian) size of job file in bytes
SeeAlso: #1290,#1291 at AH=E3h/SF=78h
--------N-21F217SF79-------------------------
INT 21 - Novell NetWare - CREATE QUEUE JOB AND FILE
	AX = F217h subfn 79h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1501)
	ES:DI -> reply packet fragment list (see #1413,#1502)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=7Ah,AX=F217h/SF=7Bh

Format of NetWare "Create Queue Job And File" request packet:
Offset	Size	Description	(Table 1501)
 00h	WORD	length of following data
 02h	BYTE	79h (subfunction "Create Queue Job And File")
 03h	DWORD	queue ID
 07h 280 BYTEs	queue job structure (see #1506)
SeeAlso: #1502,#1503,#1505

Format of NetWare "Create Queue Job And File" reply packet:
Offset	Size	Description	(Table 1502)
 00h 10 BYTEs	reserved for future use
 0Ah	DWORD	client station
 0Eh	DWORD	client task
 12h	DWORD	client ID
 16h	DWORD	target server ID
 1Ah  6 BYTEs	target execution time year,month,day,hour,minute,second
		(FFFFFFFFFFFFh = first opportunity)
 20h  6 BYTEs	job entry time
		(set by queue manager)
 26h	DWORD	job number (1-999) assigned by queue manager
 2Ah	WORD	job type
 2Ch	WORD	position of job in queue (0001h = first, etc.)
 2Eh	WORD	job control flags (see #1274 at AH=E3h/SF=6Ch)
 30h 14 BYTEs	ASCIZ job file name
 3Eh	DWORD	job file handle	(set by queue manager)
 42h	DWORD	server station (set by queue manager)
 46h	DWORD	server task number (set by queue manager)
 4Ah	DWORD	server object ID (set by queue manager)
SeeAlso: #1501,#1506
--------N-21F217SF7A-------------------------
INT 21 - Novell NetWare - READ QUEUE JOB ENTRY
	AX = F217h subfn 7Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1503)
	ES:DI -> reply packet fragment list (see #1413,#1504)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=79h,AX=F217h/SF=7Bh

Format of NetWare "Read Queue Job Entry" request packet:
Offset	Size	Description	(Table 1503)
 00h	WORD	length of following data
 02h	BYTE	7Ah (subfunction "Read Queue Job Entry")
 03h	DWORD	queue ID
 07h	DWORD	job entry number
SeeAlso: #1504,#1501,#1505

Format of NetWare "Read Queue Job Entry" reply packet:
Offset	Size	Description	(Table 1504)
 00h 280 BYTEs	job structure (see #1506)
SeeAlso: #1503
--------N-21F217SF7B-------------------------
INT 21 - Novell NetWare v2.1+ - CHANGE QUEUE JOB ENTRY
	AX = F217h subfn 7Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1505)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=6Dh,AX=F217h/SF=79h,AX=F217h/SF=7Dh

Format of NetWare "Change Queue Job Entry" request packet:
Offset	Size	Description	(Table 1505)
 00h	WORD	length of following data
 02h	BYTE	7Bh (subfunction "Change Queue Job Entry")
 03h	DWORD	queue ID
 07h 280 BYTEs	job structure (see #1506)
SeeAlso: #1501,#1503

Format of NetWare v3.11+ job structure:
Offset	Size	Description	(Table 1506)
 00h	WORD	record-in-use flag
 02h	DWORD	-> previous record
 06h	DWORD	-> next record
 0Ah	DWORD	client station connection number
 0Eh	DWORD	client task number
		(set by queue manager)
 12h	DWORD	client object ID
 16h	DWORD	target server object ID
 1Ah  6 BYTEs	target execution time year,month,day,hour,minute,second
		(FFFFFFFFFFFFh = first opportunity)
 20h  6 BYTEs	job entry time
		(set by queue manager)
 26h	DWORD	job number (1-999) assigned by queue manager
 2Ah	WORD	job type
 2Ch	WORD	position of job in queue (0001h = first, etc.)
 2Eh	WORD	job control flags (see #1274 at AH=E3h/SF=6Ch)
 30h 14 BYTEs	ASCIZ job file name
 3Eh	DWORD	job file handle	(set by queue manager)
 42h	DWORD	server station (set by queue manager)
 46h	DWORD	server task number (set by queue manager)
 4Ah	DWORD	server object ID (set by queue manager)
 4Eh 50 BYTEs	ASCIZ job description string
 80h 152 BYTEs	client record area
SeeAlso: #1505,#1265
--------N-21F217SF7D-------------------------
INT 21 - Novell NetWare - READ QUEUE CURRENT STATUS
	AX = F217h subfn 7Dh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1507)
	ES:DI -> reply packet fragment list (see #1413,#1508)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=66h,AX=F217h/SF=79h,AX=F217h/SF=7Bh
SeeAlso: AX=F217h/SF=7Eh

Format of NetWare "Read Queue Current Status" request packet:
Offset	Size	Description	(Table 1507)
 00h	WORD	length of following data
 02h	BYTE	7Dh (subfunction "Read Queue Current Status")
 03h	DWORD	(big-endian) object ID of queue
SeeAlso: #1508,#1509

Format of NetWare "Read Queue Current Status" reply packet:
Offset	Size	Description	(Table 1508)
 00h	DWORD	queue ID
 04h	DWORD	queue status
		bit 0: no more jobs can be added
		bit 1: no more queue servers can be attached
		bit 2: attached queu servers can not service queue jobs
 08h	DWORD	current number of jobs in queue
 0Ch	DWORD	number of servers attached to queue
 10h  N DWORDs	attached server IDs
SeeAlso: #1507,#1260 at AH=E3h/SF=66h
--------N-21F217SF7E-------------------------
INT 21 - Novell NetWare - SET QUEUE CURRENT STATUS
	AX = F217h subfn 7Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1509)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=7Dh

Format of NetWare "Set Queue Current Status" request packet:
Offset	Size	Description	(Table 1509)
 00h	WORD	length of following data
 02h	BYTE	7Eh (subfunction "Set Queue Current Status")
 03h	DWORD	queue ID
 07h	DWORD	queue status
		bit 0: no more jobs can be added
		bit 1: no more queue servers can be attached
		bit 2: attached queu servers can not service queue jobs
SeeAlso: #1507
--------N-21F217SF7F-------------------------
INT 21 - Novell NetWare - CLOSE FILE AND START QUEUE JOB
	AX = F217h subfn 7Fh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1510)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=69h,AX=F217h/SF=80h,AX=F217h/SF=81h

Format of NetWare "Close File And Start Queue Job" request packet:
Offset	Size	Description	(Table 1510)
 00h	WORD	length of following data
 02h	BYTE	7Fh (subfunction "Close File And Start Queue Job")
 03h	DWORD	queue ID
 07h	DWORD	job number
--------N-21F217SF80-------------------------
INT 21 - Novell NetWare - REMOVE JOB FROM QUEUE
	AX = F217h subfn 80h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1511)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=6Ah,AX=F217h/SF=7Fh

Format of NetWare "Remove Job From Queue" request packet:
Offset	Size	Description	(Table 1511)
 00h	WORD	length of following data
 02h	BYTE	80h (subfunction "Remove Job From Queue")
 03h	DWORD	queue ID
 07h	DWORD	job number (returned when job was added to queue)
--------N-21F217SF81-------------------------
INT 21 - Novell NetWare - GET QUEUE JOB LIST
	AX = F217h subfn 81h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1512)
	ES:DI -> reply packet fragment list (see #1413,#1513)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=6Bh

Format of NetWare "Get Queue Job List" request packet:
Offset	Size	Description	(Table 1512)
 00h	WORD	length of following data
 02h	BYTE	81h (subfunction "Get Queue Job List")
 03h	DWORD	queue ID
 07h	DWORD	address of next job in queue
SeeAlso: #1513

Format of NetWare "Get Queue Job List" reply packet:
Offset	Size	Description	(Table 1513)
 00h	DWORD	total jobs in queue
 04h	DWORD	length of job number list (max 125)
 08h  N DWORDs	list of job numbers in queue
SeeAlso: #1512
--------N-21F217SF82-------------------------
INT 21 - Novell NetWare v2.1+ - CHANGE JOB PRIORITY
	AX = F217h subfn 82h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply buffer)
	DS:SI -> request packet fragment list (see #1413,#1514)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell"

Format of NetWare "Change Job Priority" request packet:
Offset	Size	Description	(Table 1514)
 00h	WORD	length of following data
 02h	BYTE	82h (subfunction "Change Job Priority")
 03h	DWORD	queue ID
 07h	DWORD	job number
 0Bh	DWORD	priority
--------N-21F217SF83-------------------------
INT 21 - Novell NetWare v3.1+ - FINISH SERVICING QUEUE JOB
	AX = F217h subfn 83h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1292 at AH=E3h/SF=83h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=83h,AX=F217h/SF=72h,AX=F217h/SF=84h
--------N-21F217SF84-------------------------
INT 21 - Novell NetWare v3.1+ - ABORT SERVICING QUEUE JOB
	AX = F217h subfn 84h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1294 at AH=E3h/SF=84h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
Desc:	inform the Queue Management System (QMS) that the queue server is
	  unable to service a previously-accepted job
SeeAlso: AH=F2h"Novell",AH=E3h/SF=84h,AX=F217h/SF=73h,AX=F217h/SF=83h
--------N-21F217SF85-------------------------
INT 21 - Novell NetWare v3.1+ - CHANGE TO CLIENT RIGHTS
	AX = F217h subfn 85h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1515)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
Desc:	temporarily assume the login identity of the client submitting the
	  job being serviced
SeeAlso: AH=F2h"NetWare",AH=E3h/SF=74h,AX=F217h/SF=74h

Format of NetWare "Change to Client Rights" request packet:
Offset	Size	Description	(Table 1515)
 00h	WORD	length of following data
 02h	BYTE	85h (subfunction "Change to Client Rights")
 03h	DWORD	queue object ID
 07h	DWORD	job number
SeeAlso: #1284
--------N-21F217SF86-------------------------
INT 21 - Novell NetWare v3.1+ - READ QUEUE SERVER CURRENT STATUS
	AX = F217h subfn 86h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1516)
	ES:DI -> reply packet fragment list (see #1413,#1517)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=76h,AX=F217h/SF=77h,AX=F217h/SF=7Dh

Format of NetWare "Read Queue Server Current Status" request packet:
Offset	Size	Description	(Table 1516)
 00h	WORD	length of following data
 02h	BYTE	86h (subfunction "Read Queue Server Current Status")
 03h	DWORD	queue ID
 07h	DWORD	server ID
 0Bh	DWORD	connection ID
SeeAlso: #1517

Format of NetWare "Read Queue Server Current Status" request packet:
Offset	Size	Description	(Table 1517)
 00h 64 BYTEs	server status record
SeeAlso: #1516
--------N-21F217SF87-------------------------
INT 21 - Novell NetWare v3.1+ - GET QUEUE JOB FILE SIZE
	AX = F217h subfn 87h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1518)
	ES:DI -> reply packet fragment list (see #1413,#1519)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=78h

Format of NetWare "Get Queue Job File Size" request packet:
Offset	Size	Description	(Table 1518)
 00h	WORD	length of following data
 02h	BYTE	87h (subfunction "Get Queue Job File Size")
	???
SeeAlso: #1519

Format of NetWare "Get Queue Job File Size" request packet:
Offset	Size	Description	(Table 1519)
 00h	???
SeeAlso: #1518
--------N-21F217SF96-------------------------
INT 21 - Novell NetWare - GET ACCOUNT STATUS
	AX = F217h subfn 96h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1297 at AH=E3h/SF=96h)
	ES:DI -> reply packet fragment list (see #1413,#1520)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=96h,AH=F217h/SF=97h,AX=F217h/SF=98h

Format of NetWare "Get Account Status" reply packet:
Offset	Size	Description	(Table 1520)
 00h	DWORD	(big-endian) account balance
 04h	DWORD	(big-endian) credit limit
		signed number indicating lowest allowable account balance
 06h 120 BYTEs	reserved
 80h	DWORD	(big-endian) object ID, server 1
 84h	DWORD	(big-endian) hold amount, server 1
	...
 F6h	DWORD	(big-endian) object ID, server 16
 FAh	DWORD	(big-endian) hold amount, server 16
Note:	the reply buffer lists the servers which have placed holds on a portion
	  of the account balance, and the amount reserved by each
SeeAlso: #1297,#1298 at AH=E3h/SF=96h
--------N-21F217SF97-------------------------
INT 21 - Novell NetWare - SUBMIT ACCOUNT CHARGE
	AX = F217h subfn 97h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	       (see #1413,#1299 at AH=E3h/SF=97h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=97h,AX=F217h/SF=96h,AX=F217h/SF=98h
--------N-21F217SF98-------------------------
INT 21 - Novell NetWare - SUBMIT ACCOUNT HOLD
	AX = F217h subfn 98h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1300 at AH=E3h/SF=98h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=98h,AX=F217h/SF=97h,AX=F217h/SF=99h
--------N-21F217SF99-------------------------
INT 21 - Novell NetWare - SUBMIT ACCOUNT NOTE
	AX = F217h subfn 99h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1302 at AH=E3h/SF=99h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=99h,AX=F217h/SF=96h,AX=F217h/SF=98h
--------N-21F217SFC8-------------------------
INT 21 - Novell NetWare - CHECK CONSOLE PRIVILEGES
	AX = F217h subfn C8h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1303 at AH=E3h/SF=C8h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=C8h,AX=F217h/SF=C9h,AX=F217h/SF=D1h
--------N-21F217SFC9-------------------------
INT 21 - Novell NetWare - GET FILE SERVER DESCRIPTION STRINGS
	AX = F217h subfn C9h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1304 at AH=E3h/SF=C9h)
	ES:DI -> reply packet fragment list (see #1413,#1521)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=C9h,AX=F217h/SF=C8h,AX=F217h/SF=CAh

Format of NetWare "Get File Server Description Strings" reply packet:
Offset	Size	Description	(Table 1521)
 00h	var	ASCIZ name of company distributing this copy of NetWare
	var	ASCIZ version and revision
      9 BYTEs	ASCIZ revision date (mm/dd/yy)
	var	ASCIZ copyright notice
SeeAlso: #1304,#1305 at AH=E3h/SF=C9h
--------N-21F217SFCA-------------------------
INT 21 - Novell NetWare - SET FILE SERVER DATE AND TIME
	AX = F217h subfn CAh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1307 at AH=E3h/SF=CAh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=CAh,AX=F217h/SF=C8h,AX=F217h/SF=CBh
--------N-21F217SFCB-------------------------
INT 21 - Novell NetWare - DISABLE FILE SERVER LOGIN
	AX = F217h subfn CBh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1308 at AH=E3h/SF=CBh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=CBh,AX=F217h/SF=C8h,AX=F217h/SF=CCh
--------N-21F217SFCC-------------------------
INT 21 - Novell NetWare - ENABLE FILE SERVER LOGIN
	AX = F217h subfn CCh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1310 at AH=E3h/SF=CCh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=CCh,AX=F217h/SF=C8h,AX=F217h/SF=CBh
--------N-21F217SFCD-------------------------
INT 21 - Novell NetWare - GET FILE SERVER LOGIN STATUS
	AX = F217h subfn CDh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1311 at AH=E3h/SF=CDh)
	ES:DI -> reply packet fragment list (see #1413,#1522)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=CDh,AX=F217h/SF=CBh,AX=F217h/SF=CCh

Format of NetWare "Get File Server Login Status" reply packet:
Offset	Size	Description	(Table 1522)
 00h	BYTE	login state (00h disabled, 01h enabled)
SeeAlso: #1311,#1312 at AH=E3h/SF=CDh
--------N-21F217SFCE-------------------------
INT 21 - Novell NetWare - PURGE ALL ERASED FILES
	AX = F217h subfn CEh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1313 at AH=E3h/SF=CEh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=CEh,AX=F244h
--------N-21F217SFCF-------------------------
INT 21 - Novell NetWare - DISABLE TRANSACTION TRACKING
	AX = F217h subfn CFh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1314)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=CFh,AX=F217h/SF=D0h
--------N-21F217SFD0-------------------------
INT 21 - Novell NetWare - ENABLE TRANSACTION TRACKING
	AX = F217h subfn D0h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1316 at AH=E3h/SF=D0h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D0h,AX=F217h/SF=CFh
--------N-21F217SFD1-------------------------
INT 21 - Novell NetWare - SEND CONSOLE BROADCAST
	AX = F217h subfn D1h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1317 at AH=E3h/SF=D1h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D1h,AX=F217h/SF=D2h
--------N-21F217SFD2-------------------------
INT 21 - Novell NetWare v3+ - CLEAR CONNECTION NUMBER (LOGOUT STATION)
	AX = F217h subfn D2h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1318 at AH=E3h/SF=D2h)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D2h,AX=F217h/SF=D1h,AX=F217h/SF=FEh
--------N-21F217SFD3-------------------------
INT 21 - Novell NetWare - DOWN FILE SERVER
	AX = F217h subfn D3h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list
	      (see #1413,#1321 at AH=E3h/SF=D3h)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D3h,AX=F217h/SF=D2h
--------N-21F217SFD4-------------------------
INT 21 - Novell NetWare - GET FILE SYSTEM STATISTICS
	AX = F217h subfn D4h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1322 at AH=E3h/SF=D4h)
	ES:DI -> reply packet fragment list (see #1413,#1523)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D4h,AX=F217h/SF=D6h,AX=F217h/SF=D9h

Format of NetWare "Get File System Statistics" reply packet:
Offset	Size	Description	(Table 1523)
 00h	DWORD	clock ticks since system started
 04h	WORD	maximum open files set by configuration
 06h	WORD	maximum files open concurrently
 08h	WORD	current number of open files
 0Ah	DWORD	total files opened
 0Eh	DWORD	total file read requests
 12h	DWORD	total file write requests
 16h	WORD	current changed FATs
 18h	WORD	total changed FATs
 1Ah	WORD	number of FAT write errors
 1Ch	WORD	number of fatal FAT write errors
 1Eh	WORD	number of FAT scan errors
 20h	WORD	maximum concurrently-indexed files
 22h	WORD	current number of indexed files
 24h	WORD	number of attached indexed files
 26h	WORD	number of indexed files available
Note:	all fields are big-endian
SeeAlso: #1322,#1323 at AH=E3h/SF=D4h
--------N-21F217SFD5-------------------------
INT 21 - Novell NetWare - GET TRANSACTION TRACKING STATISTICS
	AX = F217h subfn D5h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1324 at AH=E3h/SF=D5h)
	ES:DI -> reply packet fragment list (see #1413,#1524)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D5h,AX=F217h/SF=D0h

Format of NetWare "Get Transaction Tracking Statistics" reply packet:
Offset	Size	Description	(Table 1524)
 00h	DWORD	(big-endian) clock ticks since system started
 04h	BYTE	transaction tracking supported if nonzero
		(all following fields are invalid if zero)
 05h	BYTE	transaction tracking enabled
 06h	WORD	(big-endian) transaction volume number
 08h	WORD	(big-endian) maximum simultaneous transactions configured
 0Ah	WORD	(big-endian) maximum simultaneous transactions since startup
 0Ch	WORD	(big-endian) current transactions in progress
 0Eh	DWORD	(big-endian) total transactions performed
 12h	DWORD	(big-endian) total write transactions
 16h	DWORD	(big-endian) total transactions backed out
 1Ah	WORD	(big-endian) number of unfilled backout requests
 1Ch	WORD	(big-endian) disk blocks used for transaction tracking
 1Eh	DWORD	(big-endian) blocks allocated for tracked-file FATs
 22h	DWORD	(big-endian) number of file size changes during a transaction
 26h	DWORD	(big-endian) number of file truncations during a transaction
 2Ah	BYTE	number of records following
 2Bh	Active Transaction Records [array]
	Offset	Size	Description
	 00h	BYTE	logical connection number
	 01h	BYTE	task number
SeeAlso: #1324,#1325 at AH=E3h/SF=D5h
--------N-21F217SFD6-------------------------
INT 21 - Novell NetWare - GET DISK CACHE STATISTICS
	AX = F217h subfn D6h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1326 at AH=E3h/SF=D6h)
	ES:DI -> reply packet fragment list (see #1413,#1525)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D6h,AX=F217h/SF=D5h,AX=F217h/SF=D8h

Format of NetWare "Get Disk Cache Statistics" reply packet:
Offset	Size	Description	(Table 1525)
 00h	DWORD	clock ticks since system started
 04h	WORD	number of cache buffers
 06h	WORD	size of cache buffer in bytes
 08h	WORD	number of dirty cache buffers
 0Ah	DWORD	number of cache read requests
 0Eh	DWORD	number of cache write requests
 12h	DWORD	number of cache hits
 16h	DWORD	number of cache misses
 1Ah	DWORD	number of physical read requests
 1Eh	DWORD	number of physical write requests
 22h	WORD	number of physical read errors
 24h	WORD	number of physical write errors
 26h	DWORD	cache get requests
 2Ah	DWORD	cache full write requests
 2Eh	DWORD	cache partial write requests
 32h	DWORD	background dirty writes
 36h	DWORD	background aged writes
 3Ah	DWORD	total cache writes
 3Eh	DWORD	number of cache allocations
 42h	WORD	thrashing count
 44h	WORD	number of times LRU block was dirty
 46h	WORD	number of reads on cache blocks not yet filled by writes
 48h	WORD	number of times a fragmented write occurred
 4Ah	WORD	number of cache hits on unavailable block
 4Ch	WORD	number of times a cache block was scrapped
Note:	all fields are big-endian
SeeAlso: #1326,#1327 at AH=E3h/SF=D6h
--------N-21F217SFD7-------------------------
INT 21 - Novell NetWare - GET DRIVE MAPPING TABLE
	AX = F217h subfn D7h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1328 at AH=E3h/SF=D7h)
	ES:DI -> reply packet fragment list (see #1413,#1526)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AX=EF00h,AX=EF01h,AX=EF02h,AH=F2h"Novell",AH=E3h/SF=D7h

Format of NetWare "Get Drive Mapping Table" reply packet:
Offset	Size	Description	(Table 1526)
 00h	DWORD	(big-endian) clock tick elapsed since system started
 04h	BYTE	fault tolerance (SFT) level
 05h	BYTE	number of logical drives attached to server
 06h	BYTE	number of physical drives attached to server
 07h  5 BYTEs	disk channel types (00h none, 01h XT, 02h AT, 03h SCSI,
		  04h disk coprocessor drive, 32h-FFh value-added drive types)
 0Ch	WORD	(big-endian) number of outstanding controller commands
 0Eh 32 BYTEs	drive mapping table (FFh = no such drive)
 2Eh 32 BYTEs	drive mirror table (secondary physical drive, FFh = none)
 4Eh 32 BYTEs	dead mirror table (last drive mapped to, FFh if never mirrored)
 6Eh	BYTE	physical drive being remirrored (FFh = none)
 6Fh	BYTE	reserved
 70h	DWORD	(big-endian) remirrored block
 74h 60 BYTEs	SFT error table (internal error counters)
SeeAlso: #1328,#1329 at AH=E3h/SF=D7h
--------N-21F217SFD8-------------------------
INT 21 - Novell NetWare - GET PHYSICAL DISK STATISTICS
	AX = F217h subfn D8h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1330 at AH=E3h/SF=D8h)
	ES:DI -> reply packet fragment list (see #1413,#1527)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D8h,AX=F217h/SF=D9h

Format of NetWare "Get Physical Disk Statistics" request packet:
Offset	Size	Description	(Table 1527)
 00h	DWORD	(big-endian) clock ticks since system started
 04h	BYTE	physical disk channel
 05h	BYTE	flag: drive removable if nonzero
 06h	BYTE	physical drive type
 07h	BYTE	drive number within controller
 08h	BYTE	controller number
 09h	BYTE	controller type
 0Ah	DWORD	(big-endian) size of drive in 4K disk blocks
 0Eh	WORD	(big-endian) number of cylinders on drive
 10h	BYTE	number of heads
 11h	BYTE	number of sectors per track
 12h 64 BYTEs	ASCIZ drive make and model
 52h	WORD	(big-endian) number of I/O errors
 56h	DWORD	(big-endian) start of Hot Fix table
 58h	WORD	(big-endian) size of Hot Fix table
 5Ah	WORD	(big-endian) number of Hot Fix blocks available
 5Ch	BYTE	flag: Hot Fix disabled if nonzero
SeeAlso: #1330,#1331 at AH=E3h/SF=D8h
--------N-21F217SFD9-------------------------
INT 21 - Novell NetWare - GET DISK CHANNEL STATISTICS
	AX = F217h subfn D9h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1332 at AH=E3h/SF=D9h)
	ES:DI -> reply packet fragment list (see #1413,#1528)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D9h,AX=F217h/SF=D8h

Format of NetWare "Get Disk Channel Statistics" reply packet:
Offset	Size	Description	(Table 1528)
 00h	DWORD	(big-endian) clock ticks since system started
 04h	WORD	(big-endian) channel run state (see #1334)
 06h	WORD	(big-endian) channel synchronization state (see #1335)
 08h	BYTE	driver type
 09h	BYTE	major version of driver
 0Ah	BYTE	minor version of driver
 0Bh 65 BYTEs	ASCIZ driver description
 4Ch	WORD	(big-endian) first I/O address used
 4Eh	WORD	(big-endian) length of first I/O address
 50h	WORD	(big-endian) second I/O address used
 52h	WORD	(big-endian) length of second I/O address
 54h  3 BYTEs	first shared memory address
 57h  2 BYTEs	length of first shared memory address
 59h  3 BYTEs	second shared memory address
 5Ch  2 BYTEs	length of second shared memory address
 5Eh	BYTE	first interrupt number in-use flag
 5Fh	BYTE	first interrupt number used
 60h	BYTE	second interrupt number in-use flag
 61h	BYTE	second interrupt number used
 62h	BYTE	first DMA channel in-use flag
 63h	BYTE	first DMA channel used
 64h	BYTE	second DMA channel in-use flag
 65h	BYTE	second DMA channel used
 66h	BYTE	flags
 67h	BYTE	reserved
 68h 80 BYTEs	ASCIZ configuration description
SeeAlso: #1332,#1333 at AH=E3h/SF=D9h
--------N-21F217SFDA-------------------------
INT 21 - Novell NetWare v2.2+ - GET CONNECTION'S TASK INFORMATION
	AX = F217h subfn DAh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1336 at AH=E3h/SF=DAh)
	ES:DI -> reply packet fragment list (see #1413,#1529)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=DAh,AX=F217h/SF=EAh

Format of NetWare "Get Connection's Task Information" reply packet:
Offset	Size	Description	(Table 1529)
 00h	BYTE	lock status of connection (see #1338)
 01h	var	Lock Status Information (see #1339)
 N	BYTE	number of records following
 N+1	Active Task Information Records [array]
	Offset	Size	Description
	 00h	BYTE	task number (01h-FFh)
	 01h	BYTE	task state
			00h normal task
			01h in TTS explicit transaction
			02h in TTS implicit transaction
			04h shared fileset lock active
SeeAlso: #1544,#1336,#1337 at AH=E3h/SF=DAh
--------N-21F217SFDB-------------------------
INT 21 - Novell NetWare v2.2+ - GET CONNECTION'S OPEN FILES (OLD)
	AX = F217h subfn DBh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1340 at AH=E3h/SF=DBh)
	ES:DI -> reply packet fragment list (see #1413,#1530)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=DBh,AX=F217h/SF=EBh

Format of NetWare "Get Connection's Open Files (old)" reply packet:
Offset	Size	Description	(Table 1530)
 00h	WORD	next request record (place in "last record" field on next call)
		0000h if no more records
 02h	BYTE	number of records following
 03h	var	array of File Information Records (see #1342 at AH=E3h/SF=DBh)
SeeAlso: #1340,#1341 at AH=E3h/SF=DBh
--------N-21F217SFDC-------------------------
INT 21 - Novell NetWare v2.2+ - GET CONNECTIONS USING A FILE (OLD)
	AX = F217h subfn DCh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1345 at AH=E3h/SF=DCh)
	ES:DI -> reply packet fragment list (see #1413,#1531)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=DCh,AX=F217h/SF=ECh

Format of NetWare "Get Connections Using A File (old)" reply packet:
Offset	Size	Description	(Table 1531)
 00h	WORD	(big-endian) count of tasks which have opened or logged file
 02h	WORD	(big-endian) count of tasks which have opened file
 04h	WORD	(big-endian) count of opens for reading
 06h	WORD	(big-endian) count of opens for writing
 08h	WORD	(big-endian) deny read count
 0Ah	WORD	(big-endian) deny write count
 0Ch	WORD	next request record (place in "last record" field on next call)
		0000h if no more records
 0Eh	BYTE	locked flag
		00h not locked exclusively
		else locked exclusively
 0Fh	BYTE	number of records following
 10h	var	array of File Usage Information Records
		  (see #1347 at AH=E3h/SF=DCh)
SeeAlso: #1345,#1346 at AH=E3h/SF=DCh
--------N-21F217SFDD-------------------------
INT 21 - Novell NetWare - GET PHYSICAL RECORD LOCKS BY CONNECTN AND FILE (OLD)
	AX = F217h subfn DDh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1349 at AH=E3h/SF=DDh)
	ES:DI -> reply packet fragment list (see #1413,#1532)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=DDh,AX=F217h/SF=DEh,AX=F217h/SF=EDh

Format of NetWare "Get Phys Record Locks By Conn & File (old)" reply packet:
Offset	Size	Description	(Table 1532)
 00h	WORD	next request record (place in "last record" on next call)
		0000h if no more records
 02h	BYTE	number of physical record locks
 03h	BYTE	number of records following
 04h	var	array of Physical Record Lock Info records
		  (see #1351 at AH=E3h/SF=DDh)
SeeAlso: #1349,#1350 at AH=E3h/SF=DDh
--------N-21F217SFDE-------------------------
INT 21 - Novell NetWare - GET PHYSICAL RECORD LOCKS BY FILE (OLD)
	AX = F217h subfn DEh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1353 at AH=E3h/SF=DEh)
	ES:DI -> reply packet fragment list (see #1413,#1533)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=DEh,AX=F217h/SF=EEh

Format of NetWare "Get Physical Record Locks By File (old)" reply packet:
Offset	Size	Description	(Table 1533)
 00h	WORD	next request record (place in "last record" on next call)
		0000h if no more records
 02h	BYTE	number of physical record locks
 03h	BYTE	number of records following
 04h	var	array of Physical Record Lock Info records (see #1355)
SeeAlso: #1353,#1354 at AH=E3h/SF=DEh
--------N-21F217SFDF-------------------------
INT 21 - Novell NetWare - GET LOGICAL RECORDS BY CONNECTION (OLD)
	AX = F217h subfn DFh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1356 at AH=E3h/SF=DFh)
	ES:DI -> reply packet fragment list (see #1413,#1534)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=DFh,AX=F217h/SF=EFh

Format of NetWare "Get Logical Records By Connection (old)" reply packet:
Offset	Size	Description	(Table 1534)
 00h	WORD	next request record (place in "last record" field on next call)
		0000h if no more locked records
 02h	BYTE	number of records following
 03h	var	array of Logical Lock Information Records
		  (see #1358 at AH=E3h/SF=DFh)
SeeAlso: #1356,#1357 at AH=E3h/SF=DFh
--------N-21F217SFE0-------------------------
INT 21 - Novell NetWare - GET LOGICAL RECORD INFORMATION (OLD)
	AX = F217h subfn E0h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1359 at AH=E3h/SF=E0h)
	ES:DI -> reply packet fragment list (see #1413,#1535)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E0h,AX=F217h/SF=F0h

Format of NetWare "Get Logical Record Information (Old)" reply packet:
Offset	Size	Description	(Table 1535)
 00h	WORD	(big-endian) number of logical connections logging the record
 02h	WORD	(big-endian) number of logical connections with shareable lock
 04h	WORD	(big-endian) next request record (place in "last record" field
		  on next call)
 06h	BYTE	locked exclusively if nonzero
 07h	BYTE	number of records following
 08h	var	array of Task Information Records (see #1361 at AH=E3h/SF=E0h)
SeeAlso: #1359,#1360 at AH=E3h/SF=E0h
--------N-21F217SFE1-------------------------
INT 21 - Novell NetWare - GET CONNECTION'S SEMAPHORES (OLD)
	AX = F217h subfn E1h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1362 at AH=E3h/SF=E1h)
	ES:DI -> reply packet fragment list (see #1413,#1536)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E1h,AX=F217h/SF=F1h

Format of NetWare "Get Connection's Semaphores (old)" reply packet:
Offset	Size	Description	(Table 1536)
 00h	WORD	next request record (place in "last record" field on next call)
 02h	BYTE	number of records following
 03h	var	array of Semaphore Information Records
		  (see #1364 at AH=E3h/SF=E1h)
SeeAlso: #1362,#1363 at AH=E3h/SF=E1h
--------N-21F217SFE2-------------------------
INT 21 - Novell NetWare - GET SEMAPHORE INFORMATION (OLD)
	AX = F217h subfn E2h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1365 at AH=E3h/SF=E2h)
	ES:DI -> reply packet fragment list (see #1413,#1537)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E2h,AX=F217h/SF=F2h

Format of NetWare "Get Semaphore Information (old)" reply packet:
Offset	Size	Description	(Table 1537)
 00h	WORD	next request record (place in "last record" on next call)
		0000h if no more
 02h	WORD	(big-endian) number of logical connections opening semaphore
 04h	BYTE	semaphore value (-127 to 128)
 05h	BYTE	number of records following
 06h	var	array of Semaphore Information records (see #1367)
SeeAlso: #1365,#1366 at AH=E3h/SF=E2h
--------N-21F217SFE3-------------------------
INT 21 - Novell NetWare - GET LAN DRIVER'S CONFIGURATION INFORMATION
	AX = F217h subfn E3h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1368 at AH=E3h/SF=E3h)
	ES:DI -> reply packet fragment list (see #1413,#1538)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E3h,AX=F217h/SF=E7h,AX=F217h/SF=E8h

Format of NetWare "Get Lan Driver's Configuration Information" reply packet:
Offset	Size	Description	(Table 1538)
 00h  4 BYTEs	network number
 04h  6 BYTEs	node number
 0Ah	BYTE	LAN driver installed (00h no--remaining fields invalid)
 0Bh	BYTE	option number selected at configuration time
 0Ch 160 BYTEs	configuration text
		ASCIZ hardware type
		ASCIZ hardware settings
SeeAlso: #1368,#1369 at AH=E3h/SF=E3h
--------N-21F217SFE5-------------------------
INT 21 - Novell NetWare - GET CONNECTION'S USAGE STATISTICS
	AX = F217h subfn E5h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1371 at AH=E3h/SF=E5h)
	ES:DI -> reply packet fragment list (see #1413,#1539)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E5h,AX=F217h/SF=EAh

Format of NetWare "Get Connection's Usage Statistics" reply packet:
Offset	Size	Description	(Table 1539)
 00h	DWORD	(big-endian) clock ticks since server started
 04h  6 BYTEs	bytes read
 0Ah  6 BYTEs	bytes written
 10h	DWORD	(big-endian) total request packets
SeeAlso: #1371,#1372 at AH=E3h/SF=E5h
--------N-21F217SFE6-------------------------
INT 21 - Novell NetWare - GET OBJECT'S REMAINING DISK SPACE
	AX = F217h subfn E6h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1373 at AH=E3h/SF=E6h)
	ES:DI -> reply packet fragment list (see #1413,#1540)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E6h,AX=F216h/SF=20h,AX=F216h/SF=23h

Format of NetWare "Get Object's Remaining Disk Space" reply packet:
Offset	Size	Description	(Table 1540)
 00h	DWORD	(big-endian) clock ticks elapsed since server started
 04h	DWORD	(big-endian) object ID
 08h	DWORD	(big-endian) 4K disk blocks available to user
 0Ch	BYTE	restrictions (00h enforced, FFh not enforced)
SeeAlso: #1373,#1374 at AH=E3h/SF=E6h
--------N-21F217SFE7-------------------------
INT 21 - Novell NetWare - GET FILE SERVER LAN I/O STATISTICS
	AX = F217h subfn E7h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1375 at AH=E3h/SF=E7h)
	ES:DI -> reply packet fragment list (see #1413,#1541)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E7h,AX=F217h/SF=11h,AX=F217h/SF=F5h

Format of NetWare "Get File Server Lan I/O Statistics" reply packet:
Offset	Size	Description	(Table 1541)
 00h	DWORD	clock ticks since system started
 04h	WORD	total routing buffers
 06h	WORD	maximum routing buffers used
 08h	WORD	current routing buffers used
 0Ah	DWORD	total file service packets
 0Eh	WORD	number of file service packets buffered
 10h	WORD	number of invalid connection packets
 12h	WORD	packets with bad logical connection numbers
 14h	WORD	number of packets received during processing
 16h	WORD	number of requests reprocessed
 18h	WORD	packets with bad sequence numbers
 1Ah	WORD	number of duplicate replies sent
 1Ch	WORD	number of acknowledgements sent
 1Eh	WORD	number of packets with bad request types
 20h	WORD	requests to attach to ws for which a request is being processed
 22h	WORD	requests to attach from ws which is already attaching
 24h	WORD	number of forged detach requests
 26h	WORD	detach requests with bad connection number
 28h	WORD	requests to detach from ws for which requests pending
 2Ah	WORD	number of cancelled replies
 2Ch	WORD	packets discarded due to excessive hop count
 2Eh	WORD	packets discarded due to unknown net
 30h	WORD	incoming packets discarded for lack of DGroup buffer
 32h	WORD	outgoing packets discarded due to lack of buffer
 34h	WORD	received packets destined for B,C, or D side drivers
 36h	DWORD	number of NetBIOS packets propagated through net
 3Ah	DWORD	total number of non-file-service packets
 3Eh	DWORD	total number of routed packets
Note:	all fields are big-endian
SeeAlso: #1375,#1376 at AH=E3h/SF=E7h
--------N-21F217SFE8-------------------------
INT 21 - Novell NetWare - GET FILE SERVER MISC INFORMATION
	AX = F217h subfn E8h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1377 at AH=E3h/SF=E8h)
	ES:DI -> reply packet fragment list (see #1413,#1542)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E8h,AX=F217h/SF=11h,AX=F217h/SF=F5h

Format of NetWare "Get File Server Misc Information" reply packet:
Offset	Size	Description	(Table 1542)
 00h	DWORD	(big-endian) clock ticks since system started
 04h	BYTE	CPU type
		00h Motorola 68000
		01h Intel 8086, 8088, or V20
		02h Intel 80286+
 05h	BYTE	reserved
 06h	BYTE	number of service processes in server
 07h	BYTE	server utilization in percent
 08h	WORD	(big-endian) maximum bindery objects set by configuration
		0000h = unlimited
 0Ah	WORD	(big-endian) maximum number of bindery objects used
 0Ch	WORD	(big-endian) current number of bindery objects in use
 0Eh	WORD	(big-endian) total server memory in KB
 10h	WORD	(big-endian) wasted server memory in KB
		normally 0000h
 12h	WORD	number of records following (01h-03h)
 14h	var	array of Dynamic Memory Information records (see #1379)
SeeAlso: #1377,#1378 at AH=E3h/SF=E8h
--------N-21F217SFE9-------------------------
INT 21 - Novell NetWare - GET VOLUME INFORMATION
	AX = F217h subfn E9h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list
	      (see #1413,#1380 at AH=E3h/SF=E9h)
	ES:DI -> reply packet fragment list (see #1413,#1543)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E9h,AX=F212h,AX=F216h/SF=15h

Format of NetWare "Get Volume Information" reply packet:
Offset	Size	Description	(Table 1543)
 00h	DWORD	(big-endian) elapsed system time
 04h	BYTE	volume number
 05h	BYTE	logical drive number
 06h	WORD	(big-endian) sectors per block
 08h	WORD	(big-endian) starting block
 0Ah	WORD	(big-endian) total blocks on volume
 0Ch	WORD	(big-endian) blocks available on volume
 0Eh	WORD	(big-endian) total directory slots
 10h	WORD	(big-endian) directory slots available
 12h	WORD	(big-endian) maximum directory entries actually used
 14h	BYTE	flag: volume hashed if nonzero
 15h	BYTE	flag: volume cached if nonzero
 16h	BYTE	flag: volume removable if nonzero
 17h	BYTE	flag: volume mounted if nonzero
 18h 16 BYTEs	NUL-padded volume name
SeeAlso: #1380,#1381 at AH=E3h/SF=E9h
--------N-21F217SFEA-------------------------
INT 21 - Novell NetWare v3.11+ - GET CONNECTION'S TASK INFORMATION
	AX = F217h subfn EAh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1544)
	ES:DI -> reply packet fragment list (see #1413,#1529)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=DAh

Format of NetWare "Get Connection's Task Information" request packet:
Offset	Size	Description	(Table 1544)
 00h	WORD	length of following data
 02h	BYTE	EAh (subfunction "Get Connection's Task Information")
 03h	WORD	connection number
SeeAlso: #1529,#1336 at AH=E3h/SF=DAh
--------N-21F217SFEB-------------------------
INT 21 - Novell NetWare v3+ - GET CONNECTION'S OPEN FILES
	AX = F217h subfn EBh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1545)
	ES:DI -> reply packet fragment list (see #1413,#1546)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F217h/SF=DBh

Format of NetWare "Get Connection's Open Files" request buffer:
Offset	Size	Description	(Table 1545)
 00h	WORD	0005h (length of following data)
 02h	BYTE	EBh (subfunction "Get Connection's Open Files")
 03h	WORD	target connection number
 05h	WORD	last record seen (set to 0000h for first call)
Note:	connection numbers greater than the maximum supported by the server
	  can cause ABENDs
SeeAlso: #1546

Format of NetWare "Get Connection's Open Files" reply buffer:
Offset	Size	Description	(Table 1546)
 00h	WORD	next request record
 02h	WORD	number of records returned (max 28)
 04h 29N BYTEs	array of connection records (see #1547)
SeeAlso: #1545

Format of NetWare connection record:
Offset	Size	Description	(Table 1547)
 00h	WORD	task number
 02h	BYTE	lock type
 03h	BYTE	access control
 04h	BYTE	lock flag
 05h	BYTE	volume number
 06h	DWORD	parent directory entry number
 0Ah	DWORD	directory entry number
 0Eh	BYTE	fork count
 0Fh	BYTE	data stream type / name space (see #1683)
 10h	BYTE	file name length
 11h 12 BYTEs	file name
SeeAlso: #1546
--------N-21F217SFEC-------------------------
INT 21 - Novell NetWare v3+ - GET CONNECTIONS USING A FILE
	AX = F217h subfn ECh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1548)
	ES:DI -> reply buffer (see #1549)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F217h/SF=DCh

Format of NetWare "Get Connections Using a File" request buffer:
Offset	Size	Description	(Table 1548)
 00h	WORD	0009h (length of following data)
 02h	BYTE	ECh (subfunction "Get Connections Using a File")
 03h	BYTE	data stream type
 04h	BYTE	volume number
 05h	DWORD	directory entry number
 09h	WORD	last record seen (0000h for first call)
SeeAlso: #1549

Format of NetWare "Get Connections Using a File" reply buffer:
Offset	Size	Description	(Table 1549)
 00h	WORD	next request record
 02h	WORD	use count
 04h	WORD	open count
 06h	WORD	number of times open for reading
 08h	WORD	number of times open for writing
 0Ah	WORD	Deny Read count
 0Ch	WORD	Deny Write count
 0Eh	BYTE	flag: locked
 0Fh	BYTE	fork count
 10h	WORD	number of records returned (max 70)
 12h 7N BYTEs	returned records (see #1550)
SeeAlso: #1548

Format of returned record:
Offset	Size	Description	(Table 1550)
 00h	WORD	connection number
 02h	WORD	task number
 04h	BYTE	lock type
 05h	BYTE	access flag
 06h	BYTE	lock flag
SeeAlso: #1549
--------N-21F217SFED-------------------------
INT 21 - Novell NetWare v3+ - GET PHYSICAL RECORD LOCKS BY CONNECTION AND FILE
	AX = F217h subfn EDh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1551)
	ES:DI -> reply packet fragment list (see #1413,#1552)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=DDh,AX=F217h/SF=EEh

Format of NetWare "Get Phys Record Locks By Conn And File" request packet:
Offset	Size	Description	(Table 1551)
 00h	WORD	length of following data
 02h	BYTE	EDh (subfunction "Get Physical Record Locks By Connection
		  And File")
 03h	WORD	target connection number
 05h	BYTE	last record seen (set to 00h before first call)
 06h	BYTE	volume number
 07h	DWORD	directory entry number
 0Bh  N BYTEs	filename
SeeAlso: #1552

Format of NetWare "Get Physical Record Locks By Connect And File" reply packet:
Offset	Size	Description	(Table 1552)
 00h	WORD	next record (place in last-seen field on next call)
 02h	WORD	number of locks returned
 04h 11N BYTEs	lock records
		Offset	Size	Description
		 00h	WORD	(big-endian) task number
		 02h	BYTE	lock status
		 03h	DWORD	(big-endian) record start offset
		 07h	DWORD	(big-endian) record end offset
SeeAlso: #1551
--------N-21F217SFEE-------------------------
INT 21 - Novell NetWare v3+ - GET PHYSICAL RECORD LOCKS BY FILE
	AX = F217h subfn EEh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1553)
	ES:DI -> reply packet fragment list (see #1413,#1554)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F217h/SF=DEh

Format of NetWare "Get Physical Record Locks by File" request buffer:
Offset	Size	Description	(Table 1553)
 00h	WORD	0009h (length of following data)
 02h	BYTE	EEh (subfunction "Get Physical Record Locks by File")
 03h	BYTE	data stream number
 04h	BYTE	volume number
 05h	DWORD	directory entry number
 09h	WORD	last record seen (0000h for first call)
SeeAlso: #1554

Format of NetWare "Get Physical Record Locks by File" reply buffer:
Offset	Size	Description	(Table 1554)
 00h	WORD	next request record
 02h	WORD	number of locks
 04h 17N BYTEs	array of lock records, one per lock (see #1555)
SeeAlso: #1553

Format of NetWare lock record:
Offset	Size	Description	(Table 1555)
 00h	WORD	logged count
 02h	WORD	number of shareable locks
 04h	DWORD	start offset of record
 08h	DWORD	end offset of record
 0Ch	WORD	logical connection number
 0Eh	WORD	task number
 10h	BYTE	lock type
SeeAlso: #1554
--------N-21F217SFEF-------------------------
INT 21 - Novell NetWare v3+ - GET LOGICAL RECORDS BY CONNECTION
	AX = F217h subfn EFh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1556)
	ES:DI -> reply packet fragment list (see #1413,#1557)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=DFh

Format of NetWare "Get Logical Records By Connection" request packet:
Offset	Size	Description	(Table 1556)
 00h	WORD	length of following data
 02h	BYTE	EFh (subfunction "Get Logical Records By Connection")
 03h	WORD	target connection number
 05h	WORD	last record seen (set to 0000h before first call)
SeeAlso: #1557

Format of NetWare "Get Logical Records By Connection" request packet:
Offset	Size	Description	(Table 1557)
 00h	WORD	next record (place in last-seen field on next call)
 02h	WORD	number of records returned
 04h		Logical Lock Information records (see #1358 at AH=E3h/SF=DFh)
SeeAlso: #1556
--------N-21F217SFF0-------------------------
INT 21 - Novell NetWare v3+ - GET LOGICAL RECORD INFORMATION
	AX = F217h subfn F0h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1558)
	ES:DI -> reply packet fragment list (see #1413,#1559)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=E0h,AX=F217h/SF=EFh

Format of NetWare "Get Logical Record Information" request packet:
Offset	Size	Description	(Table 1558)
 00h	WORD	length of following data
 02h	BYTE	F0h (subfunction "Get Logical Record Information")
 03h	WORD	last record seen
 05h	BYTE	length of logical record name
 06h  N BYTEs	logical record name (case-sensitive)
SeeAlso: #1559

Format of NetWare "Get Logical Record Information" request packet:
Offset	Size	Description	(Table 1559)
 00h	WORD	number of connections logging record
 02h	WORD	number of shareable locks
 04h	BYTE	flag: locked exclusively if nonzero
 05h	WORD	next request record (place in last-seen field on next call)
 07h	BYTE	number of records returned
 08h		logical record information records [array]
		Offset	Size	Description
		 00h	WORD	connection number
		 02h	BYTE	task number
		 03h	BYTE	lock status
SeeAlso: #1558
--------N-21F217SFF1-------------------------
INT 21 - Novell NetWare v3+ - GET CONNECTION'S SEMAPHORES
	AX = F217h subfn F1h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1560)
	ES:DI -> reply packet fragment list (see #1413,#1561)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=E1h

Format of NetWare "Get Connection's Semaphores" request packet:
Offset	Size	Description	(Table 1560)
 00h	WORD	length of following data
 02h	BYTE	F1h (subfunction "Get Connection's Semaphores")
 03h	WORD	connection number
 05h	WORD	last record seen (set to 0000h before first call)
SeeAlso: #1561

Format of NetWare "Get Connection's Semaphores" reply packet:
Offset	Size	Description	(Table 1561)
 00h	WORD	next record (place in last-seen field on next call)
 02h	WORD	number of semaphores returned
 04h	BYTEs	semaphore information records [packed array] (see #1562)
SeeAlso: #1560

Format of NetWare semaphore information record:
Offset	Size	Description	(Table 1562)
 00h	WORD	semaphore's current value
 02h	WORD	number of connections using semaphore
 04h	WORD	task number
 06h	BYTE	length of semaphore's name
 07h  N BYTEs	semaphore name
SeeAlso: #1561
--------N-21F217SFF2-------------------------
INT 21 - Novell NetWare v3+ - GET SEMAPHORE INFORMATION
	AX = F217h subfn F2h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1563)
	ES:DI -> reply packet fragment list (see #1413,#1564)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F217h/SF=E2h

Format of NetWare "Get Semaphore Information" request buffer:
Offset	Size	Description	(Table 1563)
 00h	WORD	length of following data (max 84h)
 02h	BYTE	F2h (subfunction "Get Semaphore Information")
 03h	WORD	last record seen (0000h on first call)
 05h	BYTE	length of semaphore name (max 128)
 06h  N BYTEs	semaphore name
SeeAlso: #1564

Format of NetWare "Get Semaphore Information" reply buffer:
Offset	Size	Description	(Table 1564)
 00h	WORD	next request record
 02h	WORD	open count
 04h	BYTE	value of semaphore
 05h	WORD	number of records returned
 07h 2N WORDs	list of logical connection number/task number pairs
SeeAlso: #1563
--------N-21F217SFF3-------------------------
INT 21 - Novell NetWare v3+ - MAP DIRECTORY NUMBER TO PATH
	AX = F217h subfn F3h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1565)
	ES:DI -> reply packet fragment list (see #1413,#1566)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F217h/SF=F4h

Format of NetWare "Map Directory Number to Path" request buffer:
Offset	Size	Description	(Table 1565)
 00h	WORD	0007h (length of following data)
 02h	BYTE	F3h (subfunction "Map Directory Number to Path")
 03h	BYTE	volume number
 04h	DWORD	directory entry number
 08h	BYTE	name space type
SeeAlso: #1566

Format of NetWare "Map Directory Number to Path" reply buffer:
Offset	Size	Description	(Table 1566)
 00h	BYTE	directory path length
 01h  N BYTEs	directory path (NetWare style, separated by length descriptors
		  rather than slashes or backslashes)
SeeAlso: #1565
--------N-21F217SFF4-------------------------
INT 21 - Novell NetWare v3+ - CONVERT PATH TO DIRECTORY ENTRY
	AX = F217h subfn F4h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1567)
	ES:DI -> reply packet fragment list (see #1413,#1568)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F217h/SF=F3h

Format of NetWare "Convert Path to Directory Entry" request packet:
Offset	Size	Description	(Table 1567)
 00h	WORD	length of following data
 02h	BYTE	F4h (subfunction "Convert Path to Directory Entry")
 03h	BYTE	directory handle or 00h for none
 04h	BYTE	length of directory path
 05h  N BYTEs	directory path (must be fully qualified if no handle specified)
SeeAlso: #1568

Format of NetWare "Convert Path to Directory Entry" reply packet:
Offset	Size	Description	(Table 1568)
 00h	BYTE	volume number
 01h	DWORD	directory entry number
SeeAlso: #1567
--------N-21F217SFF5-------------------------
INT 21 - Novell NetWare - GET FILE SERVER EXTENDED MISC INFORMATION
	AX = F217h subfn F5h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1569)
	ES:DI -> reply packet fragment list (see #1413,#1570)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=11h,AX=F217h/SF=C9h,AX=F217h/SF=E8h

Format of NetWare "Get File Server Extended Misc Information" request packet:
Offset	Size	Description	(Table 1569)
 00h	WORD	length of following data
 02h	BYTE	F5h (subfunction "Get File Server Extended Misc Information")
 03h	BYTE	length of reply buffer
SeeAlso: #1570

Format of NetWare "Get File Server Extended Misc Information" reply packet:
Offset	Size	Description	(Table 1570)
 00h	DWORD	system interval marker
		(up-time in clock ticks, wraps to 0 on reaching FFFFFFFFh)
 04h	BYTE	processor type
		00h Motorola 680x0
		01h Intel 8088/8086
		02h 80286
 05h	BYTE	reserved for future use
 06h	BYTE	number of service processes
 07h	BYTE	server utilization percentage
 08h	WORD	maximum bindery objects set by configuration
 0Ah	WORD	actual maximum bindery objects
 0Ch	WORD	current number of bindery objects
 0Eh	WORD	(big-endian) total server memory
 10h	WORD	(big-endian) wasted server memory
 12h	WORD	(big-endian) number of dynamic memory areas
 14h	DWORD	(big-endian) total space in dynamic memory area
 18h	DWORD	maximum dynamic space used
 1Ch	DWORD	dynamic space currently used
SeeAlso: #1569
--------N-21F217SFF6-------------------------
INT 21 - Novell NetWare - GET VOLUME EXTENDED INFORMATION
	AX = F217h subfn F6h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1571)
	ES:DI -> reply packet fragment list (see #1413,#1572)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=E8h

Format of NetWare "Get Volume Extended Information" request packet:
Offset	Size	Description	(Table 1571)
 00h	WORD	length of following data
 02h	BYTE	F6h (subfunction "Get Volume Extended Information")
 03h	BYTE	volume number
 04h	BYTE	size of reply buffer
SeeAlso: #1572

Format of NetWare "Get Volume Extended Information" reply packet:
Offset	Size	Description	(Table 1572)
 00h	DWORD	system interval
		(up-time in clock ticks, wraps to 0 on reaching FFFFFFFFh)
 04h	BYTE	volume number
 05h	BYTE	logical drive number
 06h	WORD	number of 512-byte sectors per disk block
 08h	DWORD	starting block number of volume
 0Ch	WORD	total number of disk blocks
 0Eh	WORD	number of free disk blocks
 10h	WORD	total number of directory entries
 12h	WORD	number of available directory entries
 14h	WORD	maximum directory entries ever used
 16h	BYTE	flag: volume is hashed in memory if nonzero
 17h	BYTE	flag: volume is cached if nonzero
 18h	BYTE	flag: volume is removable if nonzero
 19h	BYTE	flag: volume is mounted if nonzero
 1Ah 16 BYTEs	volume name (null-padded)
SeeAlso: #1571
--------N-21F217SFFE-------------------------
INT 21 - Novell NetWare v4 - CLEAR CONNECTION NUMBER GREATER THAN 250
	AX = F217h subfn FEh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1573)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=E3h/SF=D2h,AX=F217h/SF=D2h

Format of NetWare "Clear Connection Number" request buffer:
Offset	Size	Description	(Table 1573)
 00h	WORD	length of following data
 02h	BYTE	FEh (subfunction "Clear Connection Number")
 03h	DWORD	connection number
SeeAlso: #1318
--------N-21F21B-----------------------------
INT 21 - Novell NetWare - LOCK PHYSICAL RECORD SET (OLD)
	AX = F21Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1769 at AX=F26Eh)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F21Ah,AX=F26Eh,AH=C2h"NetWare"
--------N-21F21E-----------------------------
INT 21 - Novell NetWare - CLEAR PHYSICAL RECORD
	AX = F21Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1574)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=5Ch,AH=BEh"NetWare",AH=F2"Novell",AX=F20Bh,AX=F21Fh

Format of NetWare "Clear Physical Record" request packet:
Offset	Size	Description	(Table 1574)
 00h	BYTE	reserved for future use
 01h  6 BYTEs	NetWare file handle
 07h	DWORD	starting offset of locked region
 0Bh	DWORD	length of locked region
SeeAlso: #1575
--------N-21F21F-----------------------------
INT 21 - Novell NetWare - CLEAR PHYSICAL RECORD SET
	AX = F21Fh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1575)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=5Ch,AH=C4h"NetWare",AH=F2"Novell",AX=F20Eh,AX=F21Eh

Format of NetWare "Clear Physical Record Set" request packet:
Offset	Size	Description	(Table 1575)
 00h	BYTE	lock flag (00h = not locked)
SeeAlso: #1574
--------N-21F220SF00-------------------------
INT 21 - Novell NetWare - OPEN SEMAPHORE (OLD)
	AX = F220h subfn 00h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1576)
	ES:DI -> reply packet fragment list (see #1413,#1577)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C500h,AX=F220h/SF=01h,AX=F220h/SF=03h

Format of NetWare "Open Semaphore (old)" request packet:
Offset	Size	Description	(Table 1576)
 00h	BYTE	00h (subfunction "Open Semaphore (old)")
 01h	BYTE	initial value of semaphore ( >= 0)
 02h	BYTE	length of semaphore's name (max 512)
 03h  N BYTEs	semaphore name
SeeAlso: #1577,#1578

Format of NetWare "Open Semaphore (old)" reply packet:
Offset	Size	Description	(Table 1577)
 00h	DWORD	semaphore handle
 04h	BYTE	number of processes using semaphore (including caller)
SeeAlso: #1576,#1579
--------N-21F220SF01-------------------------
INT 21 - Novell NetWare - EXAMINE SEMAPHORE (OLD)
	AX = F220h subfn 01h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1578)
	ES:DI -> reply packet fragment list (see #1413,#1579)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C501h,AX=F220h/SF=00h,AX=F220h/SF=03h

Format of NetWare "Close Semaphore (old)" request packet:
Offset	Size	Description	(Table 1578)
 00h	BYTE	01h (subfunction "Examine Semaphore (old)")
 01h	DWORD	semaphore handle
SeeAlso: #1579,#1576

Format of NetWare "Close Semaphore (old)" request packet:
Offset	Size	Description	(Table 1579)
 00h	BYTE	current semaphore value
 01h	BYTE	number of processes using semaphore (including caller)
SeeAlso: #1578,#1577
--------N-21F220SF02-------------------------
INT 21 - Novell NetWare - WAIT ON SEMAPHORE (OLD)
	AX = F220h subfn 02h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1580)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C502h,AX=F220h/SF=00h,AX=F220h/SF=03h

Format of NetWare "Wait on Semaphore (old)" request packet:
Offset	Size	Description	(Table 1580)
 00h	BYTE	02h (subfunction "Wait on Semaphore (old)")
 01h	DWORD	semaphore handle
 05h	WORD	timeout in 1/18s (0000h = return immediately)
SeeAlso: #1578,#1581
--------N-21F220SF03-------------------------
INT 21 - Novell NetWare - SIGNAL SEMAPHORE (OLD)
	AX = F220h subfn 03h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1581)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C503h,AX=F220h/SF=02h,AX=F200h/SF=04h

Format of NetWare "Signal Semaphore (old)" request packet:
Offset	Size	Description	(Table 1581)
 00h	BYTE	03h (subfunction "Signal Semaphore (old)")
 01h	DWORD	semaphore handle
SeeAlso: #1580,#1582
--------N-21F220SF04-------------------------
INT 21 - Novell NetWare - CLOSE SEMAPHORE (OLD)
	AX = F220h subfn 04h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1582)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C504h,AX=F220h/SF=00h,AX=F220h/SF=01h
SeeAlso: AX=F26Fh/SF=01h

Format of NetWare "Close Semaphore (old)" request packet:
Offset	Size	Description	(Table 1582)
 00h	BYTE	04h (subfunction "Close Semaphore (old)")
 01h	DWORD	semaphore handle
SeeAlso: #1581,#1772
--------N-21F222SF00-------------------------
INT 21 - Novell NetWare - TTS IS AVAILABLE
	AX = F222h subfn 00h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1583)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C702h,AX=F222h/SF=01h,AX=F220h/SF=05h

Format of NetWare "TTS Is Available" request packet:
Offset	Size	Description	(Table 1583)
 00h	BYTE	00h (subfunction "TTS Is Available")
--------N-21F222SF01-------------------------
INT 21 - Novell NetWare - TTS BEGIN TRANSACTION
	AX = F222h subfn 01h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1584)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C700h,AX=F222h/SF=02h,AX=F222h/SF=03h

Format of NetWare "TTS Begin Transaction" request packet:
Offset	Size	Description	(Table 1584)
 00h	BYTE	01h (subfunction "TTS Begin Transaction")
SeeAlso: #1585,#1587
--------N-21F222SF02-------------------------
INT 21 - Novell NetWare - TTS END TRANSACTION
	AX = F222h subfn 02h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1585)
	ES:DI -> reply packet fragment list (see #1413,#1586)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C701h,AX=F222h/SF=01h,AX=F222h/SF=04h

Format of NetWare "TTS End Transaction" request packet:
Offset	Size	Description	(Table 1585)
 00h	BYTE	02h (subfunction "TTS End Transaction")
SeeAlso: #1586,#1584

Format of NetWare "TTS End Transaction" reply packet:
Offset	Size	Description	(Table 1586)
 00h	DWORD	transaction number
SeeAlso: #1585,#1588
--------N-21F222SF03-------------------------
INT 21 - Novell NetWare - TTS ABORT TRANSACTION
	AX = F222h subfn 03h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1587)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C703h,AX=F220h/SF=01h,AX=F220h/SF=02h
SeeAlso: AX=F220h/SF=04h

Format of NetWare "TTS Abort Transaction" request packet:
Offset	Size	Description	(Table 1587)
 00h	BYTE	03h (subfunction "TTS Abort Transaction")
SeeAlso: #1584,#1585
--------N-21F222SF04-------------------------
INT 21 - Novell NetWare - TTS TRANSACTION STATUS
	AX = F222h subfn 04h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1588)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C704h,AX=F222h/SF=02h,AX=F222h/SF=03h

Format of NetWare "TTS Transaction Status" request packet:
Offset	Size	Description	(Table 1588)
 00h	BYTE	04h (subfunction "TTS Transaction Status")
 01h	DWORD	transaction number
SeeAlso: #1585,#1586
--------N-21F222SF05-------------------------
INT 21 - Novell NetWare - TTS GET APPLICATION THRESHOLDS
	AX = F222h subfn 05h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1589)
	ES:DI -> reply packet fragment list (see #1413,#1590)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C705h,AX=F222h/SF=06h,AX=F222h/SF=07h

Format of NetWare "TTS Get Application Thresholds" request packet:
Offset	Size	Description	(Table 1589)
 00h	BYTE	05h (subfunction "TTS Get Application Thresholds")
SeeAlso: #1590,#1591

Format of NetWare "TTS Get Application Thresholds" request packet:
Offset	Size	Description	(Table 1590)
 00h	BYTE	logical lock threshold
 01h	BYTE	physical lock threshold
SeeAlso: #1589,#1591
--------N-21F222SF06-------------------------
INT 21 - Novell NetWare - TTS SET APPLICATION THRESHOLDS
	AX = F222h subfn 06h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1591)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C706h,AX=F222h/SF=05h,AX=F222h/SF=08h

Format of NetWare "TTS Set Application Thresholds" request packet:
Offset	Size	Description	(Table 1591)
 00h	BYTE	06h (subfunction "TTS Set Application Thresholds")
 01h	BYTE	logical lock threshold before implicit transaction started
 02h	BYTE	physical lock threshold before implicit transaction started
SeeAlso: #1590,#1594
--------N-21F222SF07-------------------------
INT 21 - Novell NetWare - TTS GET WORKSTATION THRESHOLDS
	AX = F222h subfn 07h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1592)
	ES:DI -> reply packet fragment list (see #1413,#1593)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C707h,AX=F222h/SF=05h,AX=F222h/SF=08h

Format of NetWare "TTS Get Workstation Thresholds" request packet:
Offset	Size	Description	(Table 1592)
 00h	BYTE	07h (subfunction "TTS Get Workstation Thresholds")
SeeAlso: #1593

Format of NetWare "TTS Get Workstation Thresholds" reply packet:
Offset	Size	Description	(Table 1593)
 00h	BYTE	logical lock threshold
 01h	BYTE	physical lock threshold
SeeAlso: #1592
--------N-21F222SF08-------------------------
INT 21 - Novell NetWare - TTS SET WORKSTATION THRESHOLDS
	AX = F222h subfn 08h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1594)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C708h,AX=F222h/SF=06h,AX=F222h/SF=07h

Format of NetWare "TTS Set Workstation Thresholds" request packet:
Offset	Size	Description	(Table 1594)
 00h	BYTE	08h (subfunction "TTS Set Workstation Thresholds")
 01h	BYTE	logical lock threshold before implicit transaction started
 02h	BYTE	physical lock threshold before implicit transaction started
SeeAlso: #1591
--------N-21F222SF09-------------------------
INT 21 - Novell NetWare - TTS GET CONTROL FLAGS
	AX = F222h subfn 09h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1595)
	ES:DI -> reply packet fragment list (see #1413,#1596)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C702h,AX=F222h/SF=07h,AX=F222h/SF=0Ah

Format of NetWare "TTS Get Transaction Bits" request packet:
Offset	Size	Description	(Table 1595)
 00h	BYTE	09h (subfunction "TTS Get Transaction Bits")
SeeAlso: #1596

Format of NetWare "TTS Get Transaction Bits" reply packet:
Offset	Size	Description	(Table 1596)
 00h	BYTE	TTS control flags
		bit 0: forced (automatic) record locking enabled
		bits 1-7: reserved
SeeAlso: #1595
--------N-21F222SF0A-------------------------
INT 21 - Novell NetWare - TTS SET CONTROL FLAGS
	AX = F222h subfn 0Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1597)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C702h,AX=F222h/SF=08h,AX=F222h/SF=09h

Format of NetWare "TTS Set Transaction Bits" request packet:
Offset	Size	Description	(Table 1597)
 00h	BYTE	0Ah (subfunction "TTS Set Transaction Bits")
 01h	BYTE	TTS control flags
		bit 0: forced (automatic) record locking enabled
		bits 1-7: reserved
--------N-21F223SF01-------------------------
INT 21 - Novell NetWare v2+ - AFP CREATE DIRECTORY
	AX = F223h subfn 01h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1598)
	ES:DI -> reply packet fragment list (see #1413,#1599)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=02h,AX=F223h/SF=0Dh

Format of NetWare "AFP Create Directory" request packet:
Offset	Size	Description	(Table 1598)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	01h (subfunction "AFP Create Directory")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	reserved for future use
 09h 32 BYTEs	Finder information
 29h	BYTE	path length
 2Ah  N BYTEs	AFP-style directory pathname (relative to AFP entry ID)
SeeAlso: #1599,#1600,#1626

Format of NetWare "AFP Create Directory" reply packet:
Offset	Size	Description	(Table 1599)
 00h	DWORD	new directory ID
SeeAlso: #1598,#1627
--------N-21F223SF02-------------------------
INT 21 - Novell NetWare v2+ - AFP CREATE FILE
	AX = F223h subfn 02h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1600)
	ES:DI -> reply packet fragment list (see #1413,#1601)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=02h,AX=F223h/SF=03h,AX=F223h/SF=0Dh

Format of NetWare "AFP Create File" request packet:
Offset	Size	Description	(Table 1600)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	01h (subfunction "AFP Create Directory")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	flag: delete existing file? (00h no, 01h yes)
 09h 32 BYTEs	Finder information
 29h	BYTE	path length
 2Ah  N BYTEs	AFP-style directory pathname (relative to AFP entry ID)
SeeAlso: #1598,#1601,#1602,#1628

Format of NetWare "AFP Create File" reply packet:
Offset	Size	Description	(Table 1601)
 00h	DWORD	new file's AFP entry ID
SeeAlso: #1600,#1629
--------N-21F223SF03-------------------------
INT 21 - Novell NetWare v2+ - AFP DELETE FILE
	AX = F223h subfn 03h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1602)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
Note:	directories may be deleted if they are empty
SeeAlso: AH=F2h"Novell",AX=F223h/SF=02h,AX=F223h/SF=0Dh

Format of NetWare "AFP Delete File" request packet:
Offset	Size	Description	(Table 1602)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	03h (subfunction "AFP Delete File")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	path length
 09h  N BYTEs	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #1600
--------N-21F223SF04-------------------------
INT 21 - Novell NetWare v2+ - AFP GET ENTRY ID FROM FILENAME
	AX = F223h subfn 04h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1603)
	ES:DI -> reply packet fragment list (see #1413,#1604)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=06h,AX=F223h/SF=0Ch,AX=F223h/SF=12h

Format of NetWare "AFP Get Entry ID from Name" request packet:
Offset	Size	Description	(Table 1603)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	04h (subfunction "AFP Get Entry ID from Name")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	path length
 09h  N BYTEs	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #1604,#1610

Format of NetWare "AFP Get Entry ID from Name" reply packet:
Offset	Size	Description	(Table 1604)
 00h	DWORD	AFP entry ID corresponding to specified file/directory
SeeAlso: #1603,#1611
--------N-21F223SF05-------------------------
INT 21 - Novell NetWare v2+ - AFP GET FILE INFORMATION
	AX = F223h subfn 05h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1605)
	ES:DI -> reply packet fragment list (see #1413,#1607)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=04h,AX=F223h/SF=09h,AX=F223h/SF=13h

Format of NetWare "AFP Get File Information" request packet:
Offset	Size	Description	(Table 1605)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	05h (subfunction "AFP Get File Information")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	WORD	request bitmap
 0Ah	BYTE	path length
 0Bh  N BYTEs	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #1607

Bitfields for NetWare AFP request bitmap:
Bit(s)	Description	(Table 1606)
 0	return AFP entry ID
 1	return data fork length
 2	return resource fork length
 3	return number of contained files/subdirectories
 4	return owner ID
 5	return short name
 6	return access rights
 7	??? (unused?)
 8	return attributes
 9	return parent directory ID
 10	return creation date
 11	return last-access date
 12	return last-modified date and time
 13	return last-backup date and time
 14	return Finder information
 15	return long name
SeeAlso: #1605,#1632,#1633

Format of NetWare "AFP Get File Information" reply packet:
Offset	Size	Description	(Table 1607)
 00h	DWORD	AFP entry ID for specified file
 04h	DWORD	AFP entry ID for specified file's parent directory
 08h	WORD	directory/file attributes (see #1608)
 0Ah	DWORD	length of data fork
 0Eh	DWORD	length of resource fork
 12h	WORD	total files and subdirectories contained within entry
		always 0000h if entry is a file
 14h	WORD	creation date in AFP format
 16h	WORD	last-access date in AFP format
 18h	WORD	last-modified date in AFP format
 1Ah	WORD	last-modified time in AFP format
 1Ch	WORD	last-backup date in AFP format
 1Eh	WORD	last-backup time in AFP format
 20h 32 BYTEs	Finder information
 40h 32 BYTEs	long filename
 60h	DWORD	NetWare object ID of owner
 64h 12 BYTEs	short filename (MS-DOS 8.3 format)
 70h	WORD	access privileges (see #1609)
SeeAlso: #1605,#1634

Bitfields for NetWare AFP file/directory attributes:
Bit(s)	Description	(Table 1608)
 0	search mode
 1	search mode
 2	search mode
 3	(undefined)
 4	transaction
 5	index
 6	read audit
 7	write audit
 8	read-only
 9	hidden
 10	system
 11	execute-only
 12	subdirectory
 13	archive
 14	(undefined)
 15	shareable file
SeeAlso: #1607,#1618,#1633

Bitfields for NetWare AFP access privileges:
Bit(s)	Description	(Table 1609)
 8	read (files)
 9	write (files)
 10	open (files)
 11	create (files)
 12	delete (files)
 13	parental (directories): create/delete/rename subdirectories
 14	search (directories)
 15	modify file status flags
SeeAlso: #1607,#1633,#1623
--------N-21F223SF06-------------------------
INT 21 - Novell NetWare v2+ - AFP GET ENTRY ID FROM NETWARE HANDLE
	AX = F223h subfn 06h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1610)
	ES:DI -> reply packet fragment list (see #1413,#1611)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=04h,AX=F223h/SF=0Ch,AX=F223h/SF=12h

Format of NetWare "AFP Get Entry ID from NetWare Handle" request packet:
Offset	Size	Description	(Table 1610)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	06h (subfunction "AFP Get Entry ID from NetWare Handle")
 03h  6 BYTEs	NetWare file handle
SeeAlso: #1611,#1603

Format of NetWare "AFP Get Entry ID from NetWare Handle" reply packet:
Offset	Size	Description	(Table 1611)
 00h	BYTE	volume number
 01h	DWORD	AFP entry ID corresponding to same file as NetWare handle
 05h	BYTE	fork indicator (00h data fork, 01h resource fork)
SeeAlso: #1610,#1604
--------N-21F223SF07-------------------------
INT 21 - Novell NetWare v2+ - AFP RENAME
	AX = F223h subfn 07h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1612)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=01h,AX=F223h/SF=03h,AX=F223h/SF=08h

Format of NetWare "AFP Rename" request packet:
Offset	Size	Description	(Table 1612)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	07h (subfunction "AFP Rename")
 03h	BYTE	volume number
 04h	DWORD	source AFP entry ID
 08h	DWORD	destination AFP entry ID
 0Ch	BYTE	source path length
 0Dh  N BYTEs	AFP-style source path (relative to source AFP entry ID)
	BYTE	destination path length
      N BYTEs	AFP-style destination path (relative to destination entry ID)
Note:	the file may be moved from one directory to another without being
	  renamed by setting the destination path to the empty string
--------N-21F223SF08-------------------------
INT 21 - Novell NetWare v2+ - AFP OPEN FILE FORK
	AX = F223h subfn 08h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1613)
	ES:DI -> reply packet fragment list (see #1413,#1614)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=01h,AX=F223h/SF=05h,AX=F223h/SF=09h

Format of NetWare "AFP Open File Fork" request packet:
Offset	Size	Description	(Table 1613)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	08h (subfunction "AFP Open File Fork")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	fork indicator (00h = data fork, 01h = resource fork)
 09h	BYTE	access mode
		bit 0: read
		bit 1: write
		bit 2: deny read access to others
		bit 3: deny write access to others
		bit 4: compatibility mode (should be set)
 0Ah	BYTE	path length
 0Bh  N BYTEs	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #1614

Format of NetWare "AFP Open File Fork" reply packet:
Offset	Size	Description	(Table 1614)
 00h	DWORD	AFP entry ID for newly-opened file fork
 04h	DWORD	length of opened fork
 08h  6 BYTEs	NetWare file handle
SeeAlso: #1613
--------N-21F223SF09-------------------------
INT 21 - Novell NetWare v2+ - AFP SET FILE INFORMATION
	AX = F223h subfn 09h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1615)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=05h,AX=F223h/SF=0Ah,AX=F223h/SF=13h

Format of NetWare "AFP Set File Information" request packet:
Offset	Size	Description	(Table 1615)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	09h (subfunction "AFP Set File Information")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	WORD	request bitmap (see #1616)
 0Ah	WORD	directory/file attributes (see #1631)
 0Ch	WORD	creation date in AFP format
 0Eh	WORD	last-access date in AFP format
 10h	WORD	last-modified date in AFP format
 12h	WORD	last-modified time in AFP format
 14h	WORD	last-backup date in AFP format
 16h	WORD	last-backup time in AFP format
 18h 32 BYTEs	Finder information
 38h	BYTE	path length
 39h  N BYTEs	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #1630

Bitfields for NetWare AFP request bitmap:
Bit(s)	Description	(Table 1616)
 8	set attributes
 10	set creation date
 11	set last-access date
 12	set last-modified date
 13	set last-backup date
 14	set Finder information
SeeAlso: #1615,#1630
--------N-21F223SF0A-------------------------
INT 21 - Novell NetWare v2+ - AFP SCAN FILE INFORMATION
	AX = F223h subfn 0Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1617)
	ES:DI -> reply packet fragment list (see #1413,#1619)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=01h,AX=F223h/SF=03h,AX=F223h/SF=08h

Format of NetWare "AFP Scan File Information" request packet:
Offset	Size	Description	(Table 1617)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	0Ah (subfunction "AFP Scan File Information")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	DWORD	AFP last-seen ID (from previous call)
		FFFFFFFFh on first call
 0Ch	WORD	number of entries to return (max. 4)
 0Eh	WORD	search bitmap (see #1618)
 10h	WORD	request bitmap (see #1606)
 12h	BYTE	path length
 13h  N BYTEs	AFS-style directory path (relative to AFP entry ID)
SeeAlso: #1619,#1632

Bitfields for NetWare AFP search bitmap:
Bit(s)	Description	(Table 1618)
 8	hidden files and directories
 9	system files and directories
 10	subdirectories
 11	files
SeeAlso: #1617,#1632,#1606,#1608

Format of NetWare "AFP Scan File Information" reply packet:
Offset	Size	Description	(Table 1619)
 00h	WORD	number of entries returned
 02h 120N BYTEs	file information records (see #1620)
SeeAlso: #1617

Format of NetWare AFP file information:
Offset	Size	Description	(Table 1620)
 00h	DWORD	AFP entry ID
 04h	DWORD	parent directory's AFP entry ID
 08h	WORD	directory/file attributes (see #1608)
 0Ah	DWORD	length of data fork
 0Eh	DWORD	length of resource fork
 12h	WORD	total files and subdirectories contained within entry
		always 0000h if entry is a file
 14h	WORD	creation date in AFP format
 16h	WORD	last-access date in AFP format
 18h	WORD	last-modified date in AFP format
 1Ah	WORD	last-modified time in AFP format
 1Ch	WORD	last-backup date in AFP format
 1Eh	WORD	last-backup time in AFP format
 20h 32 BYTEs	Finder information
 40h 32 BYTEs	long filename
 60h	DWORD	NetWare object ID of owner
 64h 12 BYTEs	short filename (MS-DOS 8.3 format)
 70h	WORD	access privileges (see #1609)
SeeAlso: #1619
--------N-21F223SF0B-------------------------
INT 21 - Novell NetWare v2+ - AFP ALLOCATE TEMPORARY DIRECTORY HANDLE
	AX = F223h subfn 0Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1621)
	ES:DI -> reply packet fragment list (see #1413,#1622)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=0Dh

Format of NetWare "AFP Alloc Temporary Directory Handle" request packet:
Offset	Size	Description	(Table 1621)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	0Bh (subfunction "AFT Alloc Temporary Directory Handle")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	path length
 09h  N BYTEs	AFP-style pathname
SeeAlso: #1622

Format of NetWare "AFP Alloc Temporary Directory Handle" request packet:
Offset	Size	Description	(Table 1622)
 00h	BYTE	directory handle
 01h	BYTE	NetWare access rights (see #1623)
SeeAlso: #1621

Bitfields for NetWare AFP access rights:
Bit(s)	Description	(Table 1623)
 0	read
 1	write
 2	open
 3	create
 4	delete
 5	parental: create/delete/rename subdirectories
 6	search
 7	modify file status flags
SeeAlso: #1622,#1609
--------N-21F223SF0C-------------------------
INT 21 - Novell NetWare v2+ - AFP GET ENTRY ID FROM PATHNAME
	AX = F223h subfn 0Ch
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1624)
	ES:DI -> reply packet fragment list (see #1413,#1625)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=04h,AX=F223h/SF=06h,AX=F223h/SF=12h

Format of NetWare "AFP Get Entry ID from Path Name" request packet:
Offset	Size	Description	(Table 1624)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	0Ch (subfunction "AFP Get Entry ID from Path Name")
 03h	BYTE	NetWare directory handle
 04h	BYTE	path length
 05h  N BYTEs	pathname
SeeAlso: #1625

Format of NetWare "AFP Get Entry ID from Path Name" reply packet:
Offset	Size	Description	(Table 1625)
 00h	DWORD	AFP entry ID corresponding to specified file
SeeAlso: #1624
--------N-21F223SF0D-------------------------
INT 21 - Novell NetWare v2+ - AFP 2.0 CREATE DIRECTORY
	AX = F223h subfn 0Dh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1626)
	ES:DI -> reply packet fragment list (see #1413,#1627)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=01h,AX=F223h/SF=0Fh

Format of NetWare "AFP 2.0 Create Directory" request buffer:
Offset	Size	Description	(Table 1626)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	0Dh (subfunction "AFP 2.0 Create Directory")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	reserved for future use
 09h 32	BYTEs	Finder information
 29h  6 BYTEs	ProDOS information
 2Fh	BYTE	path length
 30h	var	AFS-style directory path (relative to AFP entry)
SeeAlso: #1627,#1598

Format of NetWare "AFP 2.0 Create Directory" reply buffer:
Offset	Size	Description	(Table 1627)
 00h	DWORD	new directory ID
SeeAlso: #1626,#1599
--------N-21F223SF0E-------------------------
INT 21 - Novell NetWare v2+ - AFP 2.0 CREATE FILE
	AX = F223h subfn 0Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1628)
	ES:DI -> reply packet fragment list (see #1413,#1629)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=0Dh

Format of NetWare "AFP 2.0 Create File" request packet:
Offset	Size	Description	(Table 1628)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	0Eh (function "AFP 2.0 Create File")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	flag: delete existing file? (00h no, 01h yes)
 09h 32 BYTEs	Finder information
 29h  6 BYTEs	ProDOS information
 2Fh	BYTE	path length
 30h	var	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #1629,#1600

Format of NetWare "AFP 2.0 Create File" reply packet:
Offset	Size	Description	(Table 1629)
 00h	DWORD	new file ID
SeeAlso: #1628,#1601
--------N-21F223SF10-------------------------
INT 21 - Novell NetWare v2+ - AFP 2.0 SET FILE INFORMATION
	AX = F223h subfn 10h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1630)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=09h,AX=F223h/SF=11h

Format of NetWare "AFP 2.0 Set File Information" request packet:
Offset	Size	Description	(Table 1630)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	10h (subfunction "AFS 2.0 Set File Information")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	WORD	request bitmap (see #1616)
 0Ah	WORD	directory/file attributes (see #1631)
 0Ch	WORD	creation date in AFP format
 0Eh	WORD	last-access date in AFP format
 10h	WORD	last-modified date in AFP format
 12h	WORD	last-modified time in AFP format
 14h	WORD	last-backup date in AFP format
 16h	WORD	last-backup time in AFP format
 18h 32 BYTEs	Finder information
 38h  6 BYTEs	ProDOS information
 3Eh	BYTE	path length
 3Fh  N BYTEs	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #1615

Bitfields for NetWare AFP directory/file attributes:
Bit(s)	Description	(Table 1631)
 0	read-only
 1	hidden
 2	system
 3	execute-only
 4	subdirectory
 5	archive
 7	shareable file
SeeAlso: #1630
--------N-21F223SF11-------------------------
INT 21 - Novell NetWare v2+ - AFP 2.0 SCAN FILE INFORMATION
	AX = F223h subfn 11h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1632)
	ES:DI -> reply packet fragment list (see #1413,#1633)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=0Dh,AX=F223h/SF=10h

Format of NetWare "AFP 2.0 Scan File Information" request packet:
Offset	Size	Description	(Table 1632)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	11h (subfunction "AFP 2.0 Scan File Information")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	DWORD	AFP last-seen ID (from previous call)
		FFFFFFFFh on first call
 0Ch	WORD	number of entries to return (max. 4)
 0Eh	WORD	search bitmap (see #1618)
 10h	WORD	request bitmap (see #1606)
 12h	BYTE	path length
 13h  N BYTEs	AFS-style directory path (relative to AFP entry ID)
SeeAlso: #1633

Format of NetWare "AFP 2.0 Scan File Information" reply packet:
Offset	Size	Description	(Table 1633)
 00h	WORD	number of entries returned
 02h 120N BYTEs	file information records (see #1634)
SeeAlso: #1632

Format of NetWare AFP 2.0 file information:
Offset	Size	Description	(Table 1634)
 00h	DWORD	AFP entry ID
 04h	DWORD	parent directory's AFP entry ID
 08h	WORD	directory/file attributes (see #1608)
 0Ah	DWORD	length of data fork
 0Eh	DWORD	length of resource fork
 12h	WORD	total files and subdirectories contained within entry
		always 0000h if entry is a file
 14h	WORD	creation date in AFP format
 16h	WORD	last-access date in AFP format
 18h	WORD	last-modified date in AFP format
 1Ah	WORD	last-modified time in AFP format
 1Ch	WORD	last-backup date in AFP format
 1Eh	WORD	last-backup time in AFP format
 20h 32 BYTEs	Finder information
 40h 32 BYTEs	long filename
 60h	DWORD	NetWare object ID of owner
 64h 12 BYTEs	short filename (MS-DOS 8.3 format)
 70h	WORD	access privileges (see #1609)
 72h  6 BYTEs	ProDOS information
SeeAlso: #1633,#1606,#1607
--------N-21F223SF12-------------------------
INT 21 - Novell NetWare v2+ - AFP GET DOS FILENAME FROM ENTRY ID
	AX = F223h subfn 12h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1635)
	ES:DI -> reply packet fragment list (see #1413,#1636)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=04h,AX=F223h/SF=06h

Format of NetWare "AFP Get DOS Name from Entry ID" request packet:
Offset	Size	Description	(Table 1635)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	12h (subfunction "AFP Get DOS Name From Entry ID")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
SeeAlso: #1636

Format of NetWare "AFP Get DOS Name from Entry ID" reply packet:
Offset	Size	Description	(Table 1636)
 00h	BYTE	length of DOS pathname
 01h  N BYTEs	pathname corresponding to AFP entry ID
SeeAlso: #1635
--------N-21F223SF13-------------------------
INT 21 - Novell NetWare v2+ - AFP GET MACINTOSH INFORMATION ON DELETED FILE
	AX = F223h subfn 13h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1637)
	ES:DI -> reply packet fragment list (see #1413,#1638)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=04h,AX=F223h/SF=05h,AX=F223h/SF=09h

Format of NetWare "AFP Get Macintosh Info on Deleted File" request packet:
Offset	Size	Description	(Table 1637)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	13h (subfunction "AFP Get Macintosh Info on Deleted File")
 03h	BYTE	volume number
 04h	DWORD	server's DOS directory entry index
SeeAlso: #1638

Format of NetWare "AFP Get Macintosh Info on Deleted File" reply packet:
Offset	Size	Description	(Table 1638)
 00h 32 BYTEs	Finder information
 20h  6 BYTEs	ProDOS information
 26h	DWORD	size of resource fork
 2Ah	BYTE	length of filename
 2Bh  N BYTEs	filename
SeeAlso: #1637
--------N-21F23D-----------------------------
INT 21 - Novell NetWare - COMMIT FILE
	AX = F23Dh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1643)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=3Eh,AH=F2h"Novell",AX=F23Eh,AX=F243h
--------N-21F23E-----------------------------
INT 21 - Novell NetWare - FILE SEARCH INITIALIZE (FindFirst)
	AX = F23Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1639)
	ES:DI -> reply packet fragment list (see #1413,#1640)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=4Eh,AH=F2h"Novell",AX=F23Fh,AX=F240h

Format of NetWare "File Search Initialize" request packet:
Offset	Size	Description	(Table 1639)
 00h	BYTE	directory handle
 01h	BYTE	length of directory path
 02h  N BYTEs	path of directory to search, in VOLUME:DIRECTORY/... format
SeeAlso: #1640,#1641

Format of NetWare "File Search Initialize" reply packet:
Offset	Size	Description	(Table 1640)
 00h	BYTE	volume number
 01h	WORD	directory ID
 03h	WORD	search sequence number
 05h	BYTE	directory access rights
SeeAlso: #1639,#1642
--------N-21F23F-----------------------------
INT 21 - Novell NetWare - FILE SEARCH CONTINUE (FindNext)
	AX = F23Fh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1641)
	ES:DI -> reply packet fragment list (see #1413,#1642)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=4Eh,AH=F2h"Novell",AX=F23Eh,AX=F240h

Format of NetWare "File Search Continue" request packet:
Offset	Size	Description	(Table 1641)
 00h	BYTE	volume number
 02h	WORD	directory ID from File Search Initialize
 04h	WORD	search sequence (set to FFFFh before first call)
 06h	BYTE	search attributes
 07h	BYTE	length of search directory path
 08h  N BYTEs	name of search directory in VOLUME:DIRECTORY/.../DIR format
SeeAlso: #1642

Format of NetWare "File Search Continue" reply packet:
Offset	Size	Description	(Table 1642)
 00h	WORD	next search sequence
 02h	WORD	directory ID from File Search Initialize
 04h	WORD	reserved for future use
 06h 14 BYTEs	filename
 14h	BYTE	file attributes
 15h	BYTE	file mode
 16h	DWORD	file length
 2Ah	WORD	creation date
 2Ch	WORD	last-access date
 2Eh	WORD	last-modification date
 30h	WORD	last-modification time
SeeAlso: #1641
--------N-21F242-----------------------------
INT 21 - Novell NetWare - CLOSE FILE
	AX = F242h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1643)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=3Eh,AH=F2h"Novell",AX=F23Eh,AX=F243h,AX=F24Ah

Format of NetWare "Commit/Close File" request packet:
Offset	Size	Description	(Table 1643)
 00h	BYTE	reserved (0)
 01h  6 BYTEs	NetWare file handle
--------N-21F243-----------------------------
INT 21 - Novell NetWare - CREATE FILE
	AX = F243h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1644)
	ES:DI -> reply packet fragment list (see #1413,#1645)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=3Ch,AH=F2h"Novell",AX=F23Eh,AX=F242h,AX=F24Ah,AX=F24Dh

Format of NetWare "Create File" request packet:
Offset	Size	Description	(Table 1644)
 00h	BYTE	directory handle
 01h	BYTE	file attributes
 02h	BYTE	length of filename
 03h  N BYTEs	filename in DOS format
SeeAlso: #1645

Format of NetWare "Create File" reply packet:
Offset	Size	Description	(Table 1645)
 00h  6 BYTEs	NetWare file handle
 06h	WORD	reserved
 08h 14 BYTEs	DOS-format filename
 16h	BYTE	file attributes
 17h	BYTE	file execute type
 18h	DWORD	file length
 1Ch	WORD	creation date
 1Eh	WORD	last-access date
 20h	WORD	last-modification date
 22h	WORD	last-modification time
SeeAlso: #1644
--------N-21F244-----------------------------
INT 21 - Novell NetWare - FILE SERVICES - ERASE FILE
	AX = F244h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1647)
Return: AL = status (see #1646)
Note:	this function only marks the file for deletion; use AH=E2h/SF=CEh to
	  actually delete all marked files
SeeAlso: AH=13h,AH=41h,AH=E2h/SF=0Bh,AH=E3h/SF=CEh

(Table 1646)
Values for NetWare function status:
 00h	successful
 98h	nonexistent volume
 9Bh	invaid directory handle
 9Ch	invalid path
 FFh	no files found
SeeAlso: #1390,#2085 at INT 2F/AX=7A20h/BX=0000h

Format of NetWare "Erase Files" request packet:
Offset	Size	Description	(Table 1647)
 00h	BYTE	directory handle
 01h	BYTE	search attributes (see #0731 at AX=4301h)
 02h	BYTE	length of filespec
 03h  N BYTEs	ASCIZ filespec (may include wildcards)
--------N-21F247-----------------------------
INT 21 - Novell NetWare - GET CURRENT FILE SIZE
	AX = F247h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1648)
	ES:DI -> reply packet fragment list (see #1413,#1649)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=42h,AH=F2h"Novell",AX=F23Eh,AX=F242h,AX=F24Ah,AX=F24Dh

Format of NetWare "Get Current Size of File" request packet:
Offset	Size	Description	(Table 1648)
 00h	BYTE	reserved for future use
 01h  6 BYTEs	NetWare file handle
SeeAlso: #1649

Format of NetWare "Get Current Size of File" reply packet:
Offset	Size	Description	(Table 1649)
 00h	DWORD	current size of file
SeeAlso: #1648
--------N-21F24A-----------------------------
INT 21 - Novell NetWare - COPY FROM ONE FILE TO ANOTHER
	AX = F24Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1650)
	ES:DI -> reply packet fragment list (see #1413,#1651)
Return: AX = status (see #1646)
Note:	this function only marks the file for deletion; use AH=E2h/SF=CEh to
	  actually delete all marked files
SeeAlso: AH=F2h"Novell",AX=F243h,AX=F248h,AH=F3h"NetWare"

Format of NetWare "Copy from One File to Another" request packet:
Offset	Size	Description	(Table 1650)
 00h	BYTE	reserved for future use
 01h  6 BYTEs	source NetWare file handle
 07h  6 BYTEs	destination NetWare file handle
 0Dh	DWORD	source file offset
 11h	DWORD	destination file offset
 15h	DWORD	number of bytes to copy
SeeAlso: #1651

Format of NetWare "Copy from One File to Another" reply packet:
Offset	Size	Description	(Table 1651)
 00h	DWORD	number of bytes actually copied
SeeAlso: #1650
--------N-21F24D-----------------------------
INT 21 - Novell NetWare - CREATE NEW FILE
	AX = F24Dh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1652)
	ES:DI -> reply packet fragment list (see #1413,#1653)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AX=6C00h,AH=F2h"Novell",AX=F23Eh,AX=F242h,AX=F243h

Format of NetWare "Create New File" request packet:
Offset	Size	Description	(Table 1652)
 00h	BYTE	directory handle
 01h	BYTE	file attributes
 02h	BYTE	length of filename
 03h  N BYTEs	filename in DOS format
SeeAlso: #1653

Format of NetWare "Create New File" reply packet:
Offset	Size	Description	(Table 1653)
 00h  6 BYTEs	NetWare file handle
 06h	WORD	reserved
 08h 14 BYTEs	DOS-format filename
 16h	BYTE	file attributes
 17h	BYTE	file execute type
 18h	DWORD	file length
 1Ch	WORD	creation date
 1Eh	WORD	last-access date
 20h	WORD	last-modification date
 22h	WORD	last-modification time
SeeAlso: #1652
--------N-21F24E-----------------------------
INT 21 - Novell NetWare v2+ - ALLOW TASK ACCESS TO FILE
	AX = F24Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1654)
	ES:DI -> reply packet fragment list (see #1413,#1655)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
Desc:	allow calling task to gain access to an already-open file belonging
	  to another task of the same client
Note:	the caller receives the same access rights as the owning task, and
	  must use the returned new handle to access the file
SeeAlso: AH=F2h"NetWare",AX=F244h

Format of NetWare "Allow Task Access to File" request packet:
Offset	Size	Description	(Table 1654)
 00h	BYTE	reserved for future use
 01h  6 BYTEs	NetWare file handle
SeeAlso: #1655

Format of NetWare "Allow Task Access to File" reply packet:
Offset	Size	Description	(Table 1655)
 00h  6 BYTEs	new file handle
SeeAlso: #1654
--------N-21F256SF01-------------------------
INT 21 - Novell NetWare - CLOSE EXTENDED ATTRIBUTE HANDLE
	AX = F256h subfn 01h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1656)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F256h/SF=02h,AX=F256h/SF=04h,AX=F256h/SF=05h

Format of NetWare "Close Extended Attribute Handle" request packet:
Offset	Size	Description	(Table 1656)
 00h	BYTE	01h (subfunction "Close Extended Attribute Handle")
 01h	WORD	reserved for future use
 03h	DWORD	extended attribute handle
--------N-21F256SF02-------------------------
INT 21 - Novell NetWare - WRITE EXTENDED ATTRIBUTE
	AX = F256h subfn 02h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1657)
	ES:DI -> reply packet fragment list (see #1413,#1658)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F256h/SF=01h,AX=F256h/SF=03h,AX=F256h/SF=05h

Format of NetWare "Write Extended Attribute" request packet:
Offset	Size	Description	(Table 1657)
 00h	BYTE	02h (subfunction "Write Extended Attribute")
 01h	WORD	flags (see #1668)
 03h  8 BYTEs	extended attribute handle structure (see #1669)
 0Bh	DWORD	write size
 0Fh	DWORD	write position
 13h	DWORD	access flag
 17h	WORD	length of value
 19h	WORD	key length
 1Bh  N BYTEs	key
      N BYTEs	value
SeeAlso: #1657,#1659

Format of NetWare "Write Extended Attribute" reply packet:
Offset	Size	Description	(Table 1658)
 00h	DWORD	error code
 04h	DWORD	number of bytes written
 08h	DWORD	new extended attribute handle
SeeAlso: #1657
--------N-21F256SF03-------------------------
INT 21 - Novell NetWare - READ EXTENDED ATTRIBUTE
	AX = F256h subfn 03h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1659)
	ES:DI -> reply packet fragment list (see #1413,#1660)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F256h/SF=01h,AX=F256h/SF=04h,AX=F256h/SF=05h

Format of NetWare "Read Extended Attribute" request packet:
Offset	Size	Description	(Table 1659)
 00h	BYTE	03h (subfunction "Read Extended Attribute")
 01h	WORD	flags (see #1668)
 03h  8 BYTEs	extended attribute handle structure (see #1669)
 0Bh	DWORD	read position
 0Fh	DWORD	inspect size
 13h	WORD	key length
 15h  N BYTEs	key
SeeAlso: #1660,#1657

Format of NetWare "Read Extended Attribute" reply packet:
Offset	Size	Description	(Table 1660)
 00h	DWORD	error code
 04h	DWORD	total extended attribute value length
 08h	DWORD	new extended attribute handle
 0Ch	DWORD	access flag
 10h	WORD	value length
 12h  N BYTEs	EA value
SeeAlso: #1659
--------N-21F256SF04-------------------------
INT 21 - Novell NetWare - ENUMERATE EXTENDED ATTRIBUTES
	AX = F256h subfn 04h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1661)
	ES:DI -> reply packet fragment list (see #1413,#1662)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F256h/SF=01h,AX=F256h/SF=02h,AX=F256h/SF=05h

Format of NetWare "Enumerate Extended Attributes" request packet:
Offset	Size	Description	(Table 1661)
 00h	BYTE	04h (subfunction "Enumerate Extended Attributes")
 01h	WORD	flags (see #1668)
 03h  8 BYTEs	extended attribute handle structure (see #1669)
 0Bh	DWORD	inspect size
 0Fh	WORD	enumeration sequence
 11h	WORD	key length
 13h  N BYTEs	key
SeeAlso: #1662

Format of NetWare "Enumerate Extended Attributes" reply packet:
Offset	Size	Description	(Table 1662)
 00h	DWORD	error code
 04h	DWORD	total extended attributes
 08h	DWORD	total extended attribute data size
 0Ch	DWORD	total extended attribute key size
 10h	DWORD	new extended attribute handle
---information level 0---
 14h  2 WORDs	reserved
---information level 1---
 14h	WORD	number of enumerated extended attribute structures
 16h	var	EA structure level 1
---information level 6---
 14h	WORD	reserved
 16h	var	EA structure level 6
---information level 7---
 14h	WORD	number of enumerated extended attribute structures
 16h	var	EA structure level 7
SeeAlso: #1661

Format of NetWare Extended Attribute structure level 1:
Offset	Size	Description	(Table 1663)
 00h	DWORD	length of EA value
 04h	WORD	length of EA key
 06h	DWORD	access flag
 0Ah  N BYTEs	key
SeeAlso: #1662,#1664,#1665

Format of NetWare Extended Attribute structure level 6:
Offset	Size	Description	(Table 1664)
 00h	DWORD	length of EA value
 04h	WORD	length of EA key
 06h	DWORD	access flag
 0Ah	DWORD	key extents
 0Eh	DWORD	value extents
 12h  N BYTEs	key
SeeAlso: #1662,#1663,#1665

Format of NetWare Extended Attribute structure level 7:
Offset	Size	Description	(Table 1665)
 00h	BYTE	key length
 01h  N BYTEs	key
	BYTE	00h
SeeAlso: #1662,#1663,#1664
--------N-21F256SF05-------------------------
INT 21 - Novell NetWare - DUPLICATE EXTENDED ATTRIBUTES
	AX = F256h subfn 05h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1666)
	ES:DI -> reply packet fragment list (see #1413,#1667)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F256h/SF=01h,AX=F256h/SF=02h,AX=F256h/SF=04h

Format of NetWare "Duplicate Extended Attributes" request packet:
Offset	Size	Description	(Table 1666)
 00h	BYTE	05h (subfunction "Duplicate Extended Attributes")
 01h	WORD	source flags (see #1668)
 03h	WORD	destination flags (see #1668)
 05h  8 BYTEs	source extended attribute structure (see #1669)
 0Dh  8 BYTEs	destination extended attribute structure (see #1669)
SeeAlso: #1667

Format of NetWare "Duplicate Extended Attributes" reply packet:
Offset	Size	Description	(Table 1667)
 00h	DWORD	number duplicated
 04h	DWORD	data size duplicated
 08h	DWORD	key size duplicated
SeeAlso: #1666

Bitfields for NetWare extended attribute flags:
Bit(s)	Description	(Table 1668)
 1-0	extended attribute handle structure type
	00 volume number and directory entry number
	01 NetWare file handle
	10 extended attribute handle
	11 not used
 2	close handle on error
 6-4	information level (0,1,6,7)
 7	not used
SeeAlso: #1666,#1669

Format of NetWare extended attribute structure:
Offset	Size	Description	(Table 1669)
---type 0---
 00h	DWORD	volume number
 04h	DWORD	directory entry number
---type 1---
 00h	DWORD	NetWare file handle
 04h  4 BYTEs	unused
---type 2---
 00h	DWORD	extended attribute handle
 04h  4 BYTEs	unused
SeeAlso: #1668
--------N-21F257SF01-------------------------
INT 21 - Novell NetWare - OPEN/CREATE FILE OR SUBDIRECTORY
	AX = F257h subfn 01h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1670)
	ES:DI -> reply packet fragment list (see #1413,#1671)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=6C00h,AX=F257h/SF=02h,AX=F257h/SF=04h

Format of NetWare "Open/Create File or Subdirectory" request packet:
Offset	Size	Description	(Table 1670)
 00h	BYTE	01h (subfunction "Open/Create File or Subdirectory")
 01h	BYTE	name space (see #1683)
 02h	BYTE	open/create mode
 03h	WORD	search attributes
 05h	DWORD	return information mask
 09h	DWORD	create attributes
 0Dh	WORD	desired access rights (see #1673)
 0Fh		NetWare handle/path structure
SeeAlso: #1671

Format of NetWare "Open/Create File or Subdirectory" reply packet:
Offset	Size	Description	(Table 1671)
 00h	DWORD	file handle
 04h	BYTE	open/create action
		00h open
		01h replace
		03h create
 05h	BYTE	reserved
SeeAlso: #1670 

Format of NetWare Handle/Path structure:
Offset	Size	Description	(Table 1672)
 00h	BYTE	volume number
 01h	DWORD	directory base or short handle
 05h	BYTE	handle flag
		00h short directory handle
		01h directory base
		FFh no handle
 06h	BYTE	path component count
 07h  N BYTEs	path component

Bitfields for NetWare desired access rights:
Bit(s)	Description	(Table 1673)
 0	read-only mode
 1	write-only
 2	deny read
 3	deny write
 4	compatibility mode
 6	write-through mode
SeeAlso: #1670
--------N-21F257SF02-------------------------
INT 21 - Novell NetWare - INITIALIZE SEARCH
	AX = F257h subfn 02h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1674)
	ES:DI -> reply packet fragment list (see #1413,#1675)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=4Eh,AH=F2h"Novell",AX=F257h/SF=01h,AX=F257h/SF=03h

Format of NetWare "Initialize Search" request packet:
Offset	Size	Description	(Table 1674)
 00h	BYTE	02h (subfunction "Initialize Search")
 01h	BYTE	name space (see #1683)
 02h	BYTE	reserved for future use
 03h		NetWare Handle/Path structure (see #1672)
SeeAlso: #1675

Format of NetWare "Initialize Search" reply packet:
Offset	Size	Description	(Table 1675)
 00h  9 BYTEs	search sequence
		BYTE	volume number
		DWORD	directory number
		DWORD	current directory number
SeeAlso: #1674
--------N-21F257SF03-------------------------
INT 21 - Novell NetWare - SCAN NAMESPACE ENTRY INFO
	AX = F257h subfn 03h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1676)
	ES:DI -> reply packet fragment list (see #1413,#1677)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=04h,AX=F257h/SF=05h

Format of NetWare "Search for File or Subdirectory" request packet:
Offset	Size	Description	(Table 1676)
 00h	BYTE	03h (subfunction "Search for File or Subdirectory")
	???
SeeAlso: #1677

Format of NetWare "Search for File or Subdirectory" reply packet:
Offset	Size	Description	(Table 1677)
 00h	???
SeeAlso: #1676
--------N-21F257SF04-------------------------
INT 21 - Novell NetWare - RENAME OR MOVE FILE OR SUBDIRECTORY
	AX = F257h subfn 04h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1678)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=56h,AH=F2h"Novell",AX=F257h/SF=02h,AX=F257h/SF=03h,AX=F257h/SF=05h

Format of NetWare "Rename or Move File or Subdirectory" request packet:
Offset	Size	Description	(Table 1678)
 00h	BYTE	04h (subfunction "Rename or Move File or Subdirectory")
 01h	BYTE	name space (see #1683)
 02h	BYTE	rename flags
		bit 0: rename successful
		bit 1: compatibility mode
 03h	WORD	search attributes
 05h		source NetWare Handle Path
		destination NetWare Handle Path
--------N-21F257SF05-------------------------
INT 21 - Novell NetWare - SCAN FILE OR SUBDIRECTORY FOR TRUSTEES
	AX = F257h subfn 05h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1679)
	ES:DI -> reply packet fragment list (see #1413,#1680)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=04h,AX=F257h/SF=06h

Format of NetWare "Scan File or Subdirectory for Trustees" request packet:
Offset	Size	Description	(Table 1679)
 00h	BYTE	05h (subfunction "Scan File or Subdirectory for Trustees")
 01h	BYTE	name space (see #1683)
 02h	BYTE	reserved for future use
 03h	DWORD	scan sequence (set to 00000000h before first call)
 07h		NetWare Handle/Path structure (see #1672)
SeeAlso: #1680

Format of NetWare "Scan File or Subdirectory for Trustees" reply packet:
Offset	Size	Description	(Table 1680)
 00h	DWORD	next scan sequence or FFFFFFFFh if no more
 04h	WORD	number of trustee object IDs returned
 06h		trustee structure
SeeAlso: #1679
--------N-21F257SF06-------------------------
INT 21 - Novell NetWare v3+ - GET INFORMATION ABOUT FILE OR DIRECTORY
	AX = F257h subfn 06h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1681)
	ES:DI -> reply packet fragment list (see #1413,#1684)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F257h/SF=02h,AX=F257h/SF=05h,AX=F257h/SF=07h

Format of NetWare "Get NS Entry Info" request buffer:
Offset	Size	Description	(Table 1681)
 00h	BYTE	06h (subfunction "Get NS Entry Info")
 01h	BYTE	name space (see #1683)
 02h	BYTE	destination name space
 03h	WORD	search attributes
 05h	DWORD	return information mask (see #1682)
 09h	BYTE	volume number
 0Ah	DWORD	directory base
 0Eh	BYTE	handle flag
		00h first byte of dir base is dir handle; ignore volume number
		01h dir base = unique ID, volume number set
		FFh volume number and dir base ignored, volume part of path
 0Fh	BYTE	number of path components
 10h  N BYTEs	list of path components (each a counted string)
SeeAlso: #1684

Bitfields for return information mask:
Bit(s)	Description	(Table 1682)
 0	include filename
 1	data stream space allocated info
 2	attributes info
 3	data stream size info
 4	total space allocated for all data streams
 5	extended attributes info
 6	archive info
 7	modify info
 8	create info
 9	name space info
 10	directory info
 11	rights info

(Table 1683)
Values for NetWare name space:
 00h	DOS
 01h	Macintosh
 02h	NFS
 03h	FTAM
 04h	OS/2
SeeAlso: #1681,#1688

Format of NetWare "Get NS Entry Info" reply buffer:
Offset	Size	Description	(Table 1684)
 00h 72 BYTEs	reserved
 48h	DWORD	creator's name space number
 4Ch 257 BYTEs	reserved
SeeAlso: #1681
--------N-21F257SF07-------------------------
INT 21 - Novell NetWare - MODIFY FILE OR SUBDIRECTORY DOS INFORMATION
	AX = F257h subfn 07h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1685)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=04h,AX=F257h/SF=08h

Format of NetWare "Modify File or Subdirectory DOS Information" request packet:
Offset	Size	Description	(Table 1685)
 00h	BYTE	07h (subfunction "Modify File or Subdirectory DOS Information")
 01h	BYTE	name space (see #1683)
 02h	BYTE	reserved for future use
 03h	WORD	search attributes
 05h	DWORD	modify DOS mask
 09h		Modify DOS information structure
--------N-21F257SF08-------------------------
INT 21 - Novell NetWare - DELETE FILE/DIRECTORY
	AX = F257h subfn 08h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1686)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=01h,AX=F257h/SF=07h

Format of NetWare "Delete File/Directory" request packet:
Offset	Size	Description	(Table 1686)
 00h	BYTE	08h (subfunction "Delete File/Directory")
	???
--------N-21F257SF09-------------------------
INT 21 - Novell NetWare - SET SHORT DIRECTORY HANDLE
	AX = F257h subfn 09h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1687)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=0Ch

Format of NetWare "Set Short Directory Handle" request packet:
Offset	Size	Description	(Table 1687)
 00h	BYTE	09h (subfunction "Set Short Directory Handle")
 01h	BYTE	name space (see #1683)
 02h	BYTE	data stream
 03h	BYTE	destination directory handle
 04h	BYTE	reserved for future use
 05h		NetWare Handle/Path structure (see #1672)
--------N-21F257SF0A-------------------------
INT 21 - Novell NetWare v3+ - ADD TRUSTEE SET TO FILE OR SUBDIRECTORY
	AX = F257h subfn 0Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1688)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F257h/SF=0Bh

Format of NetWare "Add Trustee Set" request packet:
Offset	Size	Description	(Table 1688)
 00h	BYTE	0Ah (subfunction "Add Trustee Set to File or Subdirectory")
 01h	BYTE	name space (see #1683)
 02h  2 BYTEs	reserved
 04h	WORD	trustee rights (see #1437)
 06h	WORD	object ID count
 08h		NetWare Handle/Path structure (see #1672)
      6 BYTEs	trustee structure (see #1689)

Format of NetWare trustee structure:
Offset	Size	Description	(Table 1689)
 00h	DWORD	object ID
 04h	WORD	trustee rights
SeeAlso: #1688
--------N-21F257SF0B-------------------------
INT 21 - Novell NetWare - DELETE TRUSTEE
	AX = F257h subfn 0Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1690)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=0Ah

Format of NetWare "Delete Trustee" request packet:
Offset	Size	Description	(Table 1690)
 00h	BYTE	0Bh (subfunction "Delete Trustee")
	???
--------N-21F257SF0C-------------------------
INT 21 - Novell NetWare v2+ - ALLOCATE SHORT DIRECTORY HANDLE
	AX = F257h subfn 0Ch
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1691)
	ES:DI -> reply packet fragment list (see #1413,#1692)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
Note:	unlike "Alloc Permanent Directory Handle", this function does not
	  automatically map a drive
SeeAlso: AH=F2h"Novell",AX=F223h/SF=04h,AX=F223h/SF=05h,AX=F223h/SF=09h

Format of NetWare "Allocate Short Directory Handle" request packet:
Offset	Size	Description	(Table 1691)
 00h	BYTE	0Ch (subfunction "Allocate Short Directory Handle")
 01h	BYTE	name space (see #1683)
 02h  2 BYTEs	reserved for future use
 04h	WORD	allocation mode
		bits 1-0: 00 permanent handle
			  01 temporary handle
			  10 special temporary handle
			  11 reserved
 06h		NetWare Handle/Path structure (see #1672)
SeeAlso: #1692

Format of NetWare "Allocate Short Directory Handle" reply packet:
Offset	Size	Description	(Table 1692)
 00h	BYTE	new directory handle
 01h	BYTE	volume number
 02h	DWORD	reserved for future use
SeeAlso: #1691
--------N-21F257SF10-------------------------
INT 21 - Novell NetWare - SCAN SALVAGEABLE FILES
	AX = F257h subfn 10h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1693)
	ES:DI -> reply packet fragment list (see #1413,#1694)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Bh,AX=F257h/SF=11h,AX=F257h/SF=12h

Format of NetWare "Scan Salvageable Files" request packet:
Offset	Size	Description	(Table 1693)
 00h	BYTE	10h (subfunction "Scan Salvageable Files")
 01h	BYTE	name space
 02h	BYTE	data stream
 03h	DWORD	return information mask
 07h	DWORD	last sequence (set to FFFFFFFFh before first call)
 0Bh		NetWare Handle/Path structure (see #1672)
SeeAlso: #1694,#1419

Format of NetWare "Scan Salvageable Files" reply packet:
Offset	Size	Description	(Table 1694)
 00h	DWORD	next sequence number
 04h	WORD	deletion time
 06h	WORD	deletion date
 08h	DWORD	ID of deletor
 0Ch	DWORD	volume number
 10h	DWORD	directory entry number
 14h		NetWare Information Structure
SeeAlso: #1693,#1420
--------N-21F257SF11-------------------------
INT 21 - Novell NetWare - RECOVER SALVAGEABLE FILE
	AX = F257h subfn 11h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1695)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Ch,AX=F257h/SF=10h,AX=F257h/SF=12h

Format of NetWare "Recover Salvageable File" request packet:
Offset	Size	Description	(Table 1695)
 00h	BYTE	11h (subfunction "Recover Salvageable File")
 01h	BYTE	name space
 02h	BYTE	reserved for future use
 03h	DWORD	sequence number
 07h	DWORD	volume number
 0Bh	DWORD	scan directory base
 0Fh	BYTE	new file name length
 10h  N BYTEs	new file name
SeeAlso: #1696,#1421
--------N-21F257SF12-------------------------
INT 21 - Novell NetWare - PURGE SALVAGEABLE FILE
	AX = F257h subfn 12h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1696)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Dh,AX=F257h/SF=10h,AX=F257h/SF=11h

Format of NetWare "Purge Salvageable File" request packet:
Offset	Size	Description	(Table 1696)
 00h	BYTE	12h (subfunction "Purge Salvageable File")
 01h	BYTE	name space
 02h	BYTE	reserved
 03h	DWORD	sequence number
 07h	DWORD	volume number
 0Bh	DWORD	directory entry number
SeeAlso: #1695
--------N-21F257SF13-------------------------
INT 21 - Novell NetWare - GET NAMESPACE INFORMATION
	AX = F257h subfn 13h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1697)
	ES:DI -> reply packet fragment list (see #1413,#1698)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=12h,AX=F257h/SF=15h

Format of NetWare "Get Namespace Information" request packet:
Offset	Size	Description	(Table 1697)
 00h	BYTE	13h (subfunction "Get Namespace Information")
 01h	BYTE	source name space (see #1683)
 02h	BYTE	destination name space
 03h	BYTE	reserved for future use
 04h	BYTE	volume number
 05h	DWORD	directory base
 09h	DWORD	namespace information mask
SeeAlso: #1698

Format of NetWare "Get Namespace Information" reply packet:
Offset	Size	Description	(Table 1698)
 00h	var	namespace-specific information
SeeAlso: #1697
--------N-21F257SF15-------------------------
INT 21 - Novell NetWare - GET PATH STRING FROM SHORT DIRECTORY HANDLE
	AX = F257h subfn 15h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1699)
	ES:DI -> reply packet fragment list (see #1413,#1700)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=13h,AX=F257h/SF=16h

Format of NetWare "Get Path String from Short Directory Handle" request packet:
Offset	Size	Description	(Table 1699)
 00h	BYTE	15h (subfunction "Get Path String from Short Directory Handle")
 01h	BYTE	name space (see #1683)
 02h	BYTE	short directory handle
SeeAlso: #1700

Format of NetWare "Get Path String from Short Directory Handle" reply packet:
Offset	Size	Description	(Table 1700)
 00h	BYTE	length of path
 01h  N BYTEs	full directory path
SeeAlso: #1699
--------N-21F257SF16-------------------------
INT 21 - Novell NetWare - GENERATE DIRECTORY BASE AND VOLUME NUMBER
	AX = F257h subfn 16h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1701)
	ES:DI -> reply packet fragment list (see #1413,#1702)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=15h,AX=F257h/SF=17h

Format of NetWare "Generate Directory Base and Volume Number" request packet:
Offset	Size	Description	(Table 1701)
 00h	BYTE	16h (subfunction "Generate Directory Base and Volume Number")
 01h	BYTE	name space (#2802)
 02h  3 BYTEs	reserved for future use
 05h		NetWare Handle/Path structure (see #1672)
SeeAlso: #1702

Format of NetWare "Generate Directory Base and Volume Number" reply packet:
Offset	Size	Description	(Table 1702)
 00h	DWORD	namespace directory base
 04h	DWORD	DOS directory base
 08h	BYTE	volume number
SeeAlso: #1701
--------N-21F257SF17-------------------------
INT 21 - Novell NetWare - GET NAME SPACE INFORMATION FORMAT
	AX = F257h subfn 17h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1703)
	ES:DI -> reply packet fragment list (see #1413,#1704)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=18h,AX=F257h/SF=19h

Format of NetWare "Get Name Space Information Format" request packet:
Offset	Size	Description	(Table 1703)
 00h	BYTE	17h (subfunction "Get Name Space Information Format")
 01h	BYTE	name space (see #1683)
 02h	BYTE	volume number
SeeAlso: #1704

Format of NetWare "Get Name Space Information Format" reply packet:
Offset	Size	Description	(Table 1704)
 00h	DWORD	fixed bitmask
 04h	DWORD	variable bitmask
 08h	DWORD	huge bitmask
 0Ch	WORD	fixed bits defined
 0Eh	WORD	variable bits defined
 10h	WORD	huge bits defined
 12h 128 BYTEs	field lengths
SeeAlso: #1703
--------N-21F257SF18-------------------------
INT 21 - Novell NetWare - GET NAME SPACES LOADED
	AX = F257h subfn 18h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1705)
	ES:DI -> reply packet fragment list (see #1413,#1706)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=17h,AX=F257h/SF=19h,AX=F257h/SF=1Ah
SeeAlso: AX=F216h/SF=2Fh

Format of NetWare "Get Name Spaces Loaded" request packet:
Offset	Size	Description	(Table 1705)
 00h	BYTE	18h (subfunction "Get Name Spaces Loaded")
 01h  2 BYTEs	reserved for future use
 03h	BYTE	volume number
SeeAlso: #1706

Format of NetWare "Get Name Spaces Loaded" reply packet:
Offset	Size	Description	(Table 1706)
 00h	WORD	number of namespace elements
 02h	WORD	number of namespace elements loaded
 04h  N BYTEs	loaded name spaces (each byte contains number of one loaded 
		  name space)
SeeAlso: #1705
--------N-21F257SF19-------------------------
INT 21 - Novell NetWare - WRITE NAME SPACE INFO
	AX = F257h subfn 19h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1707)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=17h,AX=F257h/SF=18h

Format of NetWare "Write Name Space Info" request packet:
Offset	Size	Description	(Table 1707)
 00h	BYTE	19h (subfunction "Write Name Space Info")
 01h	BYTE	source name space (see #1683)
 02h	BYTE	destination name space
 03h	BYTE	volume number
 04h	DWORD	directory entry number
 08h	DWORD	namespace information bitmask
 0Ch 512 BYTEs	namespace-specific informatin
--------N-21F257SF1A-------------------------
INT 21 - Novell NetWare - READ EXTENDED NAME SPACE INFO
	AX = F257h subfn 1Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1708)
	ES:DI -> reply packet fragment list (see #1413,#1709)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=18h,AX=F257h/SF=19h,AX=F257h/SF=1Bh

Format of NetWare "Read Extended Name Space Info" request packet:
Offset	Size	Description	(Table 1708)
 00h	BYTE	1Ah (subfunction "Read Extended Name Space Info")
 01h	BYTE	name space (see #1683)
 02h	BYTE	volume number
 03h	DWORD	directory base
 07h	DWORD	huge mask
 0Bh 16 BYTEs	huge state information
SeeAlso: #1709

Format of NetWare "Read Extended Name Space Info" reply packet:
Offset	Size	Description	(Table 1709)
 00h 16 BYTEs	next huge state information
 10h	DWORD	huge data length
 14h  N BYTEs	huge data
SeeAlso: #1708
--------N-21F257SF1B-------------------------
INT 21 - Novell NetWare - WRITE EXTENDED NAME SPACE INFO
	AX = F257h subfn 1Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1710)
	ES:DI -> reply packet fragment list (see #1413,#1711)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=17h,AX=F257h/SF=18h,AX=F257h/SF=1Ah

Format of NetWare "Write Extended Name Space Info" request packet:
Offset	Size	Description	(Table 1710)
 00h	BYTE	1Bh (subfunction "Write Extended Name Space Info")
 01h	BYTE	name space (see #1683)
 02h	BYTE	volume number
 03h	DWORD	directory entry number
 07h	DWORD	huge mask
 0Bh 16 BYTEs	huge state information
 1Bh	DWORD	huge data length
 1Fh  N BYTEs	huge data
SeeAlso: #1711

Format of NetWare "Write Extended Name Space Info" request packet:
Offset	Size	Description	(Table 1711)
 00h 16 BYTEs	next huge state information
 10h	DWORD	huge data used
SeeAlso: #1710
--------N-21F257SF1C-------------------------
INT 21 - Novell NetWare - GET NS FULL PATH STRING
	AX = F257h subfn 1Ch
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1712)
	ES:DI -> reply packet fragment list (see #1413,#1713)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
Note:	this call returns the path in reverse order (root directory last)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=03h,AX=F257h/SF=15h

Format of NetWare "Get NS Full Path String" request packet:
Offset	Size	Description	(Table 1712)
 00h	BYTE	1Ch (subfunction "Get NS Full Path String")
 01h	BYTE	source name space
 02h	BYTE	destination name space
 03h 10	BYTEs	path cookie (see #1714)
 04h		NetWare Handle/Path structure (see #1672)
SeeAlso: #1713

Format of NetWare "Get NS Full Path String" reply packet:
Offset	Size	Description	(Table 1713)
 00h 10 BYTEs	next path cookie (see #1714)
 0Ah	WORD	size of path component(s) in packet
 0Ch	WORD	number of path components in packet
 0Eh		path components
SeeAlso: #1712

Format of NetWare path cookie:
Offset	Size	Description	(Table 1714)
 00h	WORD	flags
		bit 0: last component is a filename
 02h	DWORD	cookie1
 06h	DWORD	cookie2
Note:	"cookie1" and "cookie2" are to be set to FFFFFFFFh initially; if
	  "cookie2" is FFFFFFFFh on return, all path components have been
	  transferred
SeeAlso: #1712,#1713
--------N-21F257SF1D-------------------------
INT 21 - Novell NetWare - GET EFFECTIVE DIRECTORY RIGHTS
	AX = F257h subfn 1Dh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1715)
	ES:DI -> reply packet fragment list (see #1413,#1716)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AX=F216h/SF=03h,AX=F257h/SF=06h,AX=F257h/SF=0Ch,AX=F257h/SF=15h

Format of NetWare "Get Effective Directory Rights" request packet:
Offset	Size	Description	(Table 1715)
 00h	BYTE	1Dh (subfunction "Get Effective Directory Rights")
 01h	BYTE	name space (see #1683)
 02h	BYTE	destination name space (see #1683)
 03h	WORD	search attributes
 05h	DWORD	return information mask
 09h		NetWare Handle/Path structure (see #1672)
SeeAlso: #1716

Format of NetWare "Get Effective Directory Rights" reply packet:
Offset	Size	Description	(Table 1716)
 00h	WORD	caller's effective rights
 02h		NetWare Information Structure
SeeAlso: #1715
--------N-21F258SF01-------------------------
INT 21 - Novell NetWare v4+ - GET VOLUME AUDITING STATISTICS
	AX = F258h subfn 01h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1717)
	ES:DI -> reply packet fragment list (see #1413,#1718)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F268h/SF=C8h

Format of NetWare "Get Volume Auditing Statistics" request buffer:
Offset	Size	Description	(Table 1717)
 00h	BYTE	01h (function "Get Volume Auditing Statistics")
 01h	DWORD	volume
SeeAlso: #1718

Format of NetWare "Get Volume Auditing Statistics" reply buffer:
Offset	Size	Description	(Table 1718)
 00h	WORD	auditing version (date)
 02h	WORD	audit file version (date)
 04h	DWORD	auditing enabled flag
 08h	DWORD	audit file's size
 0Ch	DWORD	audit configuration file's size
 10h	DWORD	maximum audit file size
 14h	DWORD	audit file size threshold
 18h	DWORD	number of audit records
 1Ch	DWORD	number of history records
SeeAlso: #1717,#1765
--------N-21F258SF02-------------------------
INT 21 - Novell NetWare - ADD AUDIT PROPERTY
	AX = F258h subfn 02h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1719)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=39h,AX=F258h/SF=06h,AX=F258h/SF=08h

Format of NetWare "Add Audit Property" request packet:
Offset	Size	Description	(Table 1719)
 00h	BYTE	02h (subfunction "Add Audit Property")
	???
--------N-21F258SF03-------------------------
INT 21 - Novell NetWare - LOGIN AS VOLUME AUDITOR
	AX = F258h subfn 03h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1720)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=04h,AX=F258h/SF=0Dh

Format of NetWare "Login As Volume Auditor" request packet:
Offset	Size	Description	(Table 1720)
 00h	BYTE	03h (subfunction "Login As Volume Auditor")
	???
--------N-21F258SF04-------------------------
INT 21 - Novell NetWare - CHANGE AUDITOR PASSWORD
	AX = F258h subfn 04h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1721)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=03h

Format of NetWare "Change Auditor Password" request packet:
Offset	Size	Description	(Table 1721)
 00h	BYTE	04h (subfunction "Change Auditor Password")
	???
--------N-21F258SF05-------------------------
INT 21 - Novell NetWare - CHECK AUDIT ACCESS
	AX = F258h subfn 05h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1722)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=02h,AX=F258h/SF=08h

Format of NetWare "Check Audit Access" request packet:
Offset	Size	Description	(Table 1722)
 00h	BYTE	05h (subfunction "Check Audit Access")
	???
--------N-21F258SF06-------------------------
INT 21 - Novell NetWare - REMOVE AUDIT PROPERTY
	AX = F258h subfn 06h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1723)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=02h,AX=F258h/SF=05h

Format of NetWare "Remove Audit Property" request packet:
Offset	Size	Description	(Table 1723)
 00h	BYTE	06h (subfunction "Remove Audit Property")
	???
--------N-21F258SF07-------------------------
INT 21 - Novell NetWare - DISABLE AUDITING ON VOLUME
	AX = F258h subfn 07h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1724)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=08h,AX=F258h/SF=09h

Format of NetWare "Disable Auditing on Volume" request packet:
Offset	Size	Description	(Table 1724)
 00h	BYTE	07h (subfunction "Disable Auditing on Volume")
	???
--------N-21F258SF08-------------------------
INT 21 - Novell NetWare - ENABLE AUDITING ON VOLUME
	AX = F258h subfn 08h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1725)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=07h,AX=F258h/SF=09h

Format of NetWare "Enable Auditing on Volume" request packet:
Offset	Size	Description	(Table 1725)
 00h	BYTE	08h (subfunction "Enable Auditing on Volume")
	???
--------N-21F258SF09-------------------------
INT 21 - Novell NetWare - IS USER AUDITED?
	AX = F258h subfn 09h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1726)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=07h,AX=F258h/SF=08h

Format of NetWare "Is User Audited?" request packet:
Offset	Size	Description	(Table 1726)
 00h	BYTE	09h (subfunction "Is User Audited?")
	???
--------N-21F258SF0A-------------------------
INT 21 - Novell NetWare - READ AUDITING BITMAP
	AX = F258h subfn 0Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1727)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=0Bh,AX=F258h/SF=10h

Format of NetWare "Read Auditing Bitmap" request packet:
Offset	Size	Description	(Table 1727)
 00h	BYTE	0Ah (subfunction "Read Auditing Bitmap")
	???
--------N-21F258SF0B-------------------------
INT 21 - Novell NetWare - READ AUDIT CONFIG HEADER
	AX = F258h subfn 0Bh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1728)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=0Ah,AX=F258h/SF=11h

Format of NetWare "Read Audit Configuration Header" request packet:
Offset	Size	Description	(Table 1728)
 00h	BYTE	0Bh (subfunction "Read Audit Configuration Header")
	???
--------N-21F258SF0D-------------------------
INT 21 - Novell NetWare - LOGOUT AS VOLUME AUDITOR
	AX = F258h subfn 0Dh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1729)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=03h

Format of NetWare "Logout as Volume Auditor" request packet:
Offset	Size	Description	(Table 1729)
 00h	BYTE	0Dh (subfunction "Logout as Volume Auditor")
	???
--------N-21F258SF0E-------------------------
INT 21 - Novell NetWare - RESET AUDITING FILE
	AX = F258h subfn 0Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1730)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=0Ah,AX=F258h/SF=0Fh

Format of NetWare "Reset Auditing File" request packet:
Offset	Size	Description	(Table 1730)
 00h	BYTE	0Eh (subfunction "Reset Auditing File")
	???
--------N-21F258SF0F-------------------------
INT 21 - Novell NetWare - RESET AUDIT HISTORY FILE
	AX = F258h subfn 0Fh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1731)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=0Eh

Format of NetWare "Reset Audit History File" request packet:
Offset	Size	Description	(Table 1731)
 00h	BYTE	0Fh (subfunction "Reset Audit History File")
	???
--------N-21F258SF10-------------------------
INT 21 - Novell NetWare - WRITE AUDITING BITMAP
	AX = F258h subfn 10h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1732)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=0Ah,AX=F258h/SF=11h

Format of NetWare "Write Auditing Bitmap" request packet:
Offset	Size	Description	(Table 1732)
 00h	BYTE	10h (subfunction "Write Auditing Bitmap")
	???
--------N-21F258SF11-------------------------
INT 21 - Novell NetWare - WRITE AUDIT CONFIG HEADER
	AX = F258h subfn 11h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1733)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=0Bh,AX=F258h/SF=10h

Format of NetWare "Write Audit Configuration Header" request packet:
Offset	Size	Description	(Table 1733)
 00h	BYTE	11h (subfunction "Write Audit Configuration Header")
	???
--------N-21F258SF13-------------------------
INT 21 - Novell NetWare - GET AUDITING FLAGS
	AX = F258h subfn 13h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1734)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=05h

Format of NetWare "Get Auditing Flags" request packet:
Offset	Size	Description	(Table 1734)
 00h	BYTE	13h (subfunction "Get Auditing Flags")
	???
--------N-21F258SF14-------------------------
INT 21 - Novell NetWare - CLOSE OLD AUDITING FILE
	AX = F258h subfn 14h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1735)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=15h

Format of NetWare "Close Old Auditing File" request packet:
Offset	Size	Description	(Table 1735)
 00h	BYTE	14h (subfunction "Close Old Auditing File")
	???
--------N-21F258SF15-------------------------
INT 21 - Novell NetWare - DELETE OLD AUDITING FILE
	AX = F258h subfn 15h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1736)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=14h

Format of NetWare "Delete Old Auditing File" request packet:
Offset	Size	Description	(Table 1736)
 00h	BYTE	15h (subfunction "Delete Old Auditing File")
	???
--------N-21F258SF16-------------------------
INT 21 - Novell NetWare - CHECK AUDIT LEVEL TWO ACCESS
	AX = F258h subfn 16h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1737)
	ES:DI -> reply packet fragment list (see #1413)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=05h

Format of NetWare "Check Audit Level Two Access" request packet:
Offset	Size	Description	(Table 1737)
 00h	BYTE	16h (subfunction "Check Audit Level Two Access")
	???
--------N-21F25ASF01-------------------------
INT 21 - Novell NetWare - GET DATA MIGRATION INFO
	AX = F25Ah subfn 01h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1738)
	ES:DI -> reply packet fragment list (see #1413,#1739)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=80h,AX=F25Ah/SF=86h

Format of NetWare "Get Data Migration Information" request packet:
Offset	Size	Description	(Table 1738)
 00h	WORD	length of following data
 02h	BYTE	01h (subfunction "Get Data Migration Information")
SeeAlso: #1739

Format of NetWare "Get Data Migration Information" reply packet:
Offset	Size	Description	(Table 1739)
 00h	???
SeeAlso: #1738
--------N-21F25ASF80-------------------------
INT 21 - Novell NetWare - MOVE FILE DATA TO DATA MIGRATION
	AX = F25Ah subfn 80h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1740)
	ES:DI -> reply packet fragment list (see #1413,#1741)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=82h,AX=F25Ah/SF=85h

Format of NetWare "Move File Data to Data Migration" request packet:
Offset	Size	Description	(Table 1740)
 00h	WORD	length of following data
 02h	BYTE	80h (subfunction "Move File Data to Data Migration")
 03h	DWORD	volume number
 07h	DWORD	directory entry number
 0Bh	DWORD	name space (see #1683)
 0Fh	DWORD	support module ID
 13h	DWORD	save key flag
		00000010h to save key when file is demigrated
SeeAlso: #1741

Format of NetWare "Move File Data to Data Migration" reply packet:
Offset	Size	Description	(Table 1741)
 00h	DWORD	volume-unique ID
SeeAlso: #1740
--------N-21F25ASF81-------------------------
INT 21 - Novell NetWare - DATA MIGRATION FILE INFORMATION
	AX = F25Ah subfn 81h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1742)
	ES:DI -> reply packet fragment list (see #1413,#1743)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=80h,AX=F25Ah/SF=82h,AX=F25Ah/SF=83h

Format of NetWare "Data Migration File Information" request packet:
Offset	Size	Description	(Table 1742)
 00h	WORD	length of following data
 02h	BYTE	81h (subfunction "Data Migration File Information")
 03h	DWORD	volume number
 07h	DWORD	directory entry number
 0Bh	DWORD	name space (see #1683)
SeeAlso: #1743

Format of NetWare "Data Migration File Information" reply packet:
Offset	Size	Description	(Table 1743)
 00h	DWORD	support module ID
 04h	DWORD	estimate restoration time
 08h	DWORD	bitmask of supported data streams
SeeAlso: #1742
--------N-21F25ASF82-------------------------
INT 21 - Novell NetWare - VOLUME DATA MIGRATION STATUS
	AX = F25Ah subfn 82h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1744)
	ES:DI -> reply packet fragment list (see #1413,#1745)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=01h,AX=F25Ah/SF=83h,AX=F25Ah/SF=84h

Format of NetWare "Volume Data Migration Status" request packet:
Offset	Size	Description	(Table 1744)
 00h	WORD	length of following data
 02h	BYTE	82h (subfunction "Volume Data Migration Status")
 03h	DWORD	volume number
 07h	DWORD	support module ID
SeeAlso: #1745

Format of NetWare "Volume Data Migration Status" request packet:
Offset	Size	Description	(Table 1745)
 00h	DWORD	number of migrated files
 04h	DWORD	total size required to restore all migrated files
 08h	DWORD	total space used on migration device
 0Ch	DWORD	limbo space (demigrated files with save-key flag set)
 10h	DWORD	total space including limbo space
 14h	DWORD	number of files in limbo
SeeAlso: #1744
--------N-21F25ASF83-------------------------
INT 21 - Novell NetWare - GET MIGRATION OR STATUS INFORMATION
	AX = F25Ah subfn 83h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1746)
	ES:DI -> reply packet fragment list (see #1413,#1747)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=82h,AX=F25Ah/SF=84h,AX=F25Ah/SF=85h

Format of NetWare "Get Migration or Status Information" request packet:
Offset	Size	Description	(Table 1746)
 00h	WORD	length of following data
 02h	BYTE	83h (subfunction "Get Migration or Status Information")
SeeAlso: #1747

Format of NetWare "Get Migration or Status Information" request packet:
Offset	Size	Description	(Table 1747)
 00h	DWORD	presence flag
		FFFFFFFFh if Data Migration NLM is loaded and running
 04h	DWORD	major version
 08h	DWORD	minor version
 0Ch	DWORD	flag: has support module registered with Data Migrator?
SeeAlso: #1746
--------N-21F25ASF84-------------------------
INT 21 - Novell NetWare - DATA MIGRATION SUPPORT MODULE INFORMATION
	AX = F25Ah subfn 84h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1748)
	ES:DI -> reply packet fragment list (see #1413,#1749)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=82h,AX=F25Ah/SF=83h,AX=F25Ah/SF=86h

Format of NetWare "Data Migration Support Module Information" request packet:
Offset	Size	Description	(Table 1748)
 00h	WORD	length of following data
 02h	BYTE	84h (subfunction "Data Migration Support Module Information")
 03h	DWORD	information level
		0000h get data migration NLM info
		0001h get loaded support modules
		0002h get name of support module
 07h	DWORD	support module ID
SeeAlso: #1749

Format of NetWare "Data Migration Support Module Information" request packet:
Offset	Size	Description	(Table 1749)
---information level 0---
 00h	DWORD	read/write access status
 04h	DWORD	length of Specific Device Information block (max 384)
 08h	DWORD	space available on support module
 0Ch	DWORD	amount of space used
 10h	BYTE	length of support module's name
 11h 14 BYTEs	support module name
 1Fh 128 BYTEs	support module information
---information level 1---
 00h	DWORD	number of support modules
 04h 32 BYTEs	support module IDs
---information level 2---
 00h	BYTE	length of module name
 01h 32 BYTEs	support module name
SeeAlso: #1748
--------N-21F25ASF85-------------------------
INT 21 - Novell NetWare - MOVE FILE DATA FROM DATA MIGRATION
	AX = F25Ah subfn 85h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1750)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=80h,AX=F25Ah/SF=83h,AX=F25Ah/SF=86h

Format of NetWare "Move File Data From Data Migration" request packet:
Offset	Size	Description	(Table 1750)
 00h	WORD	length of following data
 02h	BYTE	85h (subfunction "Move File Data from Data Migration")
 03h	DWORD	volume number
 07h	DWORD	directory entry number
 0Bh	DWORD	name space (see #1683)
SeeAlso: #1741
--------N-21F25ASF86-------------------------
INT 21 - Novell NetWare - GET OR SET DEFAULT SUPPORT MODULE
	AX = F25Ah subfn 86h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1751)
	ES:DI -> reply packet fragment list (see #1413,#1752)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=01h,AX=F25Ah/SF=80h,AX=F25Ah/SF=84h

Format of NetWare "Get or Set Default Support Module" request packet:
Offset	Size	Description	(Table 1751)
 00h	WORD	length of following data
 02h	BYTE	86h (subfunction "Get or Set Default Support Module")
 03h	DWORD	direction
		00h get default support module
		01h set default support module
 07h	DWORD	new module ID if setting
SeeAlso: #1752

Format of NetWare "Get or Set Default Support Module" request packet:
Offset	Size	Description	(Table 1752)
 00h	DWORD	support module ID
SeeAlso: #1751
--------N-21F268SF01-------------------------
INT 21 - Novell NetWare v4+ - GET TREE NAME
	AX = F268h subfn 01h
	CX = length of request buffer in bytes (0001h)
	DX = length of reply buffer in bytes (0064h)
	DS:SI -> request buffer (see #1753)
	ES:DI -> reply buffer (see #1754)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F268h/SF=04h

Format of NetWare "Get Tree Name" request buffer:
Offset	Size	Description	(Table 1753)
 00h	BYTE	01h (subfunction "Get Tree Name")

Format of NetWare "Get Tree Name" reply buffer:
Offset	Size	Description	(Table 1754)
 00h	DWORD	Ping version
 04h	DWORD	length of tree name
 08h 32 BYTEs	tree name, padded with underscores ('_')
 28h 60 BYTEs	???
--------N-21F268SF04-------------------------
INT 21 - Novell NetWare v4+ - GET BINDERY CONTEXT
	AX = F268h subfn 04h
	CX = length of request buffer in bytes (0001h)
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1755)
	ES:DI -> reply buffer (see #1756)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F268h/SF=01h,AX=F268h/SF=C8h

Format of NetWare "Get Bindery Context" request buffer:
Offset	Size	Description	(Table 1755)
 00h	BYTE	04h (subfunction "Get Bindery Context")

Format of NetWare "Get Bindery Context" reply buffer:
Offset	Size	Description	(Table 1756)
 00h	DWORD	length (max 200)
 04h  N WORDs	Unicode bindery context string
--------N-21F268SF05-------------------------
INT 21 - Novell NetWare v4+ - MONITOR NDS CONNECTION
	AX = F268h subfn 05h
	CX = length of request buffer in bytes (0001h)
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1757)
	ES:DI -> reply buffer (unused???)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)

Format of NetWare "Monitor NDS Connection" request buffer:
Offset	Size	Description	(Table 1757)
 00h	BYTE	05h (subfunction "Monitor NDS Connection"
--------N-21F268SF16-------------------------
INT 21 - Novell NetWare v4+ - NDS LIST PARTITIONS
	AX = F268h subfn 16h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1758)
	ES:DI -> reply buffer (see #1759)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
Note:	the length specified in CX must be exactly 13 bytes more than the
	  length field at offset 09h in the request buffer for this function
	  to be successful
SeeAlso: AX=F268h/SF=35h

Format of NetWare "NDS List Partitions" request buffer:
Offset	Size	Description	(Table 1758)
 00h	BYTE	02h
 01h	DWORD	??? (FFFFFFFFh)
 05h	DWORD	??? (00000202h)
 09h	DWORD	length (00000018h)
 0Dh	DWORD	??? (00000000h)
 11h	DWORD	function (00000016h) (subfunction "NDS List Partitions")
 15h	DWORD	??? (00000400h)
 19h	DWORD	API version (00000000h)
 1Dh	DWORD	??? (00000000h)
 21h	DWORD	iteration (FFFFFFFFh)
SeeAlso: #1759,#1760

Format of NetWare "NDS List Partitions" reply buffer:
Offset	Size	Description	(Table 1759)
 00h	DWORD	length
 04h	DWORD	???
 08h	DWORD	return code
 0Ch	DWORD	iteration
 10h 1000 BYTEs	returned data
SeeAlso: #1758
--------N-21F268SF35-------------------------
INT 21 - Novell NetWare v4+ - NDS GET SERVER NAME AND ADDRESS
	AX = F268h subfn 35h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1760)
	ES:DI -> reply buffer (see #1761)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
Note:	the length specified in CX must be exactly 13 bytes more than the
	  length field at offset 09h in the request buffer for this function
	  to be successful
SeeAlso: AX=F268h/SF=16h

Format of NetWare "NDS Get Server Name and Address" request buffer:
Offset	Size	Description	(Table 1760)
 00h	BYTE	02h
 01h	DWORD	??? (FFFFFFFFh)
 05h	DWORD	??? (00000202h)
 09h	DWORD	length (0000000Ch)
 0Dh	DWORD	??? (00000000h)
 11h	DWORD	function (00000035h) (subfunc "NDS Get Server Name and Addr")
 15h	DWORD	??? (00000400h)
SeeAlso: #1758,#1761

Format of NetWare "NDS Get Server Name and Address" reply buffer:
Offset	Size	Description	(Table 1761)
 00h	DWORD	length
 04h	DWORD	???
 08h	DWORD	return code
 0Ch	DWORD	length of name
 10h  N WORDs	Unicode server name string
	var	padding
	DWORD	??? (00000001h)
	DWORD	??? (00000000h)
	DWORD	??? (0000000Ch)
     12 BYTEs	server's IPX address
SeeAlso: #1760
--------N-21F268SF3D-------------------------
INT 21 - Novell NetWare v4+ - NDS LOGOUT
	AX = F268h subfn 3Dh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1762)
	ES:DI -> reply buffer (see #1763)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "NDS Logout" request buffer:
Offset	Size	Description	(Table 1762)
 00h	BYTE	02h
 01h	DWORD	??? (FFFFFFFFh)
 05h	DWORD	??? (00000202h)
 09h	DWORD	length (0000000Ch)
 0Dh	DWORD	??? (00000000h)
 11h	DWORD	function (0000003Dh) (subfunction "NDS Logout")
 15h	DWORD	??? (00000000h)
SeeAlso: #1763

Format of NetWare "NDS Logout" reply buffer:
Offset	Size	Description	(Table 1763)
 00h	DWORD	length
 04h	DWORD	???
 08h	DWORD	return code
SeeAlso: #1762
--------N-21F268SFC8-------------------------
INT 21 - Novell NetWare v4+ - GET DS AUDITING STATISTICS
	AX = F268h subfn C8h
	CX = length of request buffer in bytes (0001h)
	DX = length of reply buffer in bytes (0020h)
	DS:SI -> request buffer (see #1764)
	ES:DI -> reply buffer (see #1765)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F258h/SF=01h,AX=F268h/SF=01h,AX=F268h/SF=04h

Format of NetWare "Get DS Auditing Statistics" request buffer:
Offset	Size	Description	(Table 1764)
 00h	BYTE	C8h (subfunction "Get DS Auditing Statistics")
SeeAlso: #1765

Format of NetWare "Get DS Auditing Statistics" reply buffer:
Offset	Size	Description	(Table 1765)
 00h	WORD	auditing version (date)
 02h	WORD	audit file version (date)
 04h	DWORD	auditing enabled flag
 08h	DWORD	audit file's size
 0Ch	DWORD	audit configuration file's size
 10h	DWORD	maximum audit file size
 14h	DWORD	audit file size threshold
 18h	DWORD	number of audit records
 1Ch	DWORD	number of history records
SeeAlso: #1718,#1764
--------N-21F269-----------------------------
INT 21 - Novell NetWare - LOG FILE
	AX = F269h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1766)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F203h,AX=F26Ah,AH=EBh"NetWare"

Format of NetWare "Log File" request packet:
Offset	Size	Description	(Table 1766)
 00h	BYTE	directory handle
 01h	BYTE	lock flag
		00h log only
		01h log and lock
 02h	WORD	lock timeout in clock ticks (0000h = don't wait)
 04h	BYTE	length of filename
 05h  N BYTEs	filename
--------N-21F26A-----------------------------
INT 21 - Novell NetWare - LOCK FILE SET
	AX = F26Ah
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1767)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F204h,AX=F269h,AH=CBh"NetWare"

Format of NetWare "Lock File Set" request packet:
Offset	Size	Description	(Table 1767)
 00h	WORD	lock timeout in clock ticks (0000h = don't wait)
--------N-21F26C-----------------------------
INT 21 - Novell NetWare - LOCK LOGICAL RECORD SET
	AX = F26Ch
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1768)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F20Ah,AX=F26Ah,AH=CBh"NetWare"

Format of NetWare "Lock Logical Record Set" request packet:
Offset	Size	Description	(Table 1768)
 00h	BYTE	lock flag
		00h shareable lock
		01h exclusive lock
 01h	WORD	lock timeout in clock ticks (0000h = don't wait)
--------N-21F26E-----------------------------
INT 21 - Novell NetWare - LOCK PHYSICAL RECORD SET
	AX = F26Eh
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1769)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F21Bh,AX=F26Ch,AH=C2h"NetWare"

Format of NetWare "Lock Physical Record Set" request packet:
Offset	Size	Description	(Table 1769)
 00h	BYTE	lock flag
		00h exclusive lock
		02h shareable lock
 01h	WORD	lock timeout in clock ticks (0000h = don't wait)
--------N-21F26FSF00-------------------------
INT 21 - Novell NetWare - OPEN SEMAPHORE
	AX = F26Fh subfn 00h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1770)
	ES:DI -> reply packet fragment list (see #1413,#1771)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F26Fh/SF=01h,AX=F26Fh/SF=02h

Format of NetWare "Open Semaphore" request packet:
Offset	Size	Description	(Table 1770)
 00h	BYTE	00h (subfunction "Open Semaphore")
 01h	BYTE	initial semaphore value
 02h	BYTE	length of semaphore's name
 03h  N BYTEs	semaphore name
SeeAlso: #1771

Format of NetWare "Open Semaphore" request packet:
Offset	Size	Description	(Table 1771)
 00h	DWORD	semaphore handle
 04h	BYTE	number of clients using semaphore (including caller)
SeeAlso: #1770
--------N-21F26FSF01-------------------------
INT 21 - Novell NetWare - CLOSE SEMAPHORE
	AX = F26Fh subfn 01h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1772)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F26Fh/SF=00h,AX=F26Fh/SF=03h,AX=F220h/SF=04h

Format of NetWare "Close Semaphore" request packet:
Offset	Size	Description	(Table 1772)
 00h	BYTE	01h (subfunction "Close Semaphore")
 01h	DWORD	semaphore handle
SeeAlso: #1582
--------N-21F26FSF02-------------------------
INT 21 - Novell NetWare - WAIT ON SEMAPHORE
	AX = F26Fh subfn 02h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1773)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F26Fh/SF=00h,AX=F26Fh/SF=04h

Format of NetWare "Wait on Semaphore" request packet:
Offset	Size	Description	(Table 1773)
 00h	BYTE	02h (subfunction "Wait on Semaphore")
 01h	DWORD	semaphore handle
 05h	WORD	timeout in clock ticks (0000h = no wait)
--------N-21F26FSF03-------------------------
INT 21 - Novell NetWare - SIGNAL SEMAPHORE
	AX = F26Fh subfn 03h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = 0000h (no reply packet)
	DS:SI -> request packet fragment list (see #1413,#1774)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F26Fh/SF=02h,AX=F26Fh/SF=04h

Format of NetWare "Signal Semaphore" request packet:
Offset	Size	Description	(Table 1774)
 00h	BYTE	03h (subfunction "Signal Semaphore")
 01h	DWORD	semaphore handle
--------N-21F26FSF04-------------------------
INT 21 - Novell NetWare - EXAMINE SEMAPHORE
	AX = F26Fh subfn 04h
	BX = number of fragments in request packet (max 5)
	CX = connection handle
	DX = number of fragments in reply packet (max 5)
	DS:SI -> request packet fragment list (see #1413,#1775)
	ES:DI -> reply packet fragment list (see #1413,#1776)
Return: AX = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F26Fh/SF=02h,AX=F26Fh/SF=03h

Format of NetWare "Examine Semaphore" request packet:
Offset	Size	Description	(Table 1775)
 00h	BYTE	04h (subfunction "Examine Semaphore")
 01h	DWORD	semaphore handle
SeeAlso: #1776

Format of NetWare "Examine Semaphore" reply packet:
Offset	Size	Description	(Table 1776)
 00h	BYTE	semaphore's current value
 01h	BYTE	number of clients using semaphore
SeeAlso: #1775
--------N-21F272-----------------------------
INT 21 - Novell NetWare v4+ - GET FILE SERVER UTC TIME
	AX = F272h
	CX = length of request buffer in bytes (0003h)
	DX = length of reply buffer in bytes (0064h)
	DS:SI -> request buffer (see #1777)
	ES:DI -> reply buffer (see #1778)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get File Server UTC Time" request buffer:
Offset	Size	Description	(Table 1777)
 00h	BYTE	??? (00h)
 01h	BYTE	??? (01h)
 02h	BYTE	??? (01h)
SeeAlso: #1778

Format of NetWare "Get File Server UTC Time" reply buffer:
Offset	Size	Description	(Table 1778)
 00h	DWORD	seconds
 04h	DWORD	???
 04h	DWORD	??? (00000204h)
 04h	DWORD	??? (00000000h)
 04h	DWORD	??? (00000000h)
 04h	DWORD	??? (FFFFFFFFh)
 04h	DWORD	??? (00000000h)
SeeAlso: #1777
--------N-21F27BSF01-------------------------
INT 21 - Novell NetWare v4+ - GET CACHE INFORMATION
	AX = F27Bh subfn 01h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1779)
	ES:DI -> reply buffer (see #1780)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=02h

Format of NetWare "Get Cache Information" request buffer:
Offset	Size	Description	(Table 1779)
 00h	WORD	0001h (length of following data)
 02h	BYTE	01h (subfunction "Get Cache Information")
SeeAlso: #1780

Format of NetWare "Get Cache Information" reply buffer:
Offset	Size	Description	(Table 1780)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	"readExistingBlockCount"
 0Ch	DWORD	"readExistingWriteWaitCount"
 10h	DWORD	"readExistingPartialReadCount"
 14h	DWORD	"readExistingReadErrorCount"
 18h	DWORD	"writeBlockCount"
 1Ch	DWORD	"writeEntireBlockCount"
 20h	DWORD	"getDiskCount"
 24h	DWORD	"getDiskNeedToAllocCount"
 28h	DWORD	"getDiskSomeoneBeatMeCount"
 2Ch	DWORD	"getDiskPartialReadCount"
 30h	DWORD	"getDiskReadErrorCount"
 34h	DWORD	"getAsyncDiskCount"
 38h	DWORD	"getAsyncDiskNeedToAlloc"
 3Ch	DWORD	"getAsyncDiskSomeoneBeatMe"
 40h	DWORD	"errorDoingAsyncReadCount"
 44h	DWORD	"getDiskNoReadCount"
 48h	DWORD	"getDiskNoReadAllocCount"
 4Ch	DWORD	"getDiskNoReadSomeoneBeatMeCount"
 50h	DWORD	"diskWriteCount"
 54h	DWORD	"diskWriteAllocCount"
 58h	DWORD	"diskWriteSomeoneBeatMeCount"
 5Ch	DWORD	"writeErrorCount"
 60h	DWORD	"waitOnSemaphoreCount"
 64h	DWORD	"allocBlockWaitForSomeoneCount"
 68h	DWORD	"allocBlockCount"
 6Ch	DWORD	"allocBlockWaitCount"
 70h	DWORD	original number of cache buffers
 74h	DWORD	current number of cache buffers
 78h	DWORD	cache dirty-block threshold
 7Ch	DWORD	"waitNodeCount"
 80h	DWORD	"waitNodeAllocFailureCount"
 84h	DWORD	"moveCacheNodeCount"
 88h	DWORD	"moveCacheNodeFromAvailCount"
 8Ch	DWORD	"accelerateCacheNodeWriteCount"
 90h	DWORD	"removeCacheNodeCount"
 94h	DWORD	"removeCacheNodeFromAvailCount"
 98h	DWORD	number of cache checks
 9Ch	DWORD	number of cache hits
 A0h	DWORD	number of dirty-cache checks
 A4h	DWORD	number of dirty-cache hits
 A8h	DWORD	"cacheUsedWhileChecking"
 ACh	DWORD	"waitForDirtyBlocksDecreaseCount"
 B0h	DWORD	"allocBlockFromAvailCount"
 B4h	DWORD	"allocBlockFromLRUCount"
 B8h	DWORD	"allocBlockAlreadyWaiting"
 BCh	DWORD	"LRUSittingTime"
 C0h	DWORD	maximum byte count
 C4h	DWORD	minimum number of cache buffers
 C8h	DWORD	minimum cache report threshold
 D0h	DWORD	"allocWaitingCount"
 D4h	DWORD	number of dirty cache blocks
 D8h	DWORD	"cacheDirtyWaitTime"
 DCh	DWORD	"maxDirtyTime"
 E0h	DWORD	number of directory cache buffers
 E4h	DWORD	"cacheByteToBlockShiftFactor"
SeeAlso: #1779
--------N-21F27BSF02-------------------------
INT 21 - Novell NetWare v4+ - GET SERVER INFORMATION
	AX = F27Bh subfn 02h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1781)
	ES:DI -> reply buffer (see #1782)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=01h

Format of NetWare "Get Server Information" request buffer:
Offset	Size	Description	(Table 1781)
 00h	WORD	0001h (length of following data)
 02h	BYTE	02h (subfunction "Get Server Information")
SeeAlso: #1782

Format of NetWare "Get Server Information" reply buffer:
Offset	Size	Description	(Table 1782)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	current NCP stations in use
 0Ch	DWORD	peak NCP stations in use
 10h	DWORD	total NCP requests
 14h	DWORD	server utilization
 18h	DWORD	number of cancelled replies
 1Ch	DWORD	"writeHeldOffCount"
 20h	DWORD	"writeHeldOffWithDuplicateRequest"
 24h	DWORD	number of invalid request types
 28h	DWORD	"beingAbortedCount"
 2Ch	DWORD	"alreadyDoingReallocCount"
 30h	DWORD	"deAllocInvalidSlotCount"
 34h	DWORD	"deAllocBeingProcessedCount"
 38h	DWORD	"deAllocForgedPacketCount"
 3Ch	DWORD	"startStationErrorCount"
 40h	DWORD	number of invalid slot numbers
 44h	DWORD	"beingProcessedCount"
 48h	DWORD	number of forged packets
 4Ch	DWORD	number still transmitting
 50h	DWORD	"reExecuteRequestCount"
 54h	DWORD	number of invalid sequence numbers
 58h	DWORD	"duplicateIsBeingSentAlreadyCnt"
 5Ch	DWORD	number of positive acknowledgements sent
 60h	DWORD	number of duplicate replies sent
 64h	DWORD	number of times out of memory for station control
 68h	DWORD	number of times out of available connections
 6Ch	DWORD	"reallocSlotCount"
 70h	DWORD	"reallocSlotCameTooSoonCount"
 74h	WORD	number of times maximum hop count exceeded
 76h	WORD	number of unknown networks
 78h	WORD	"NoSpaceForService"
 7Ah	WORD	number of times out of receive buffers
 7Ch	WORD	"notMyNetwork"
 7Eh	DWORD	number of NetBIOS packets propagated
 82h	DWORD	total number of packets serviced
 86h	DWORD	total number of packets routed 
SeeAlso: #1781
--------N-21F27BSF04-------------------------
INT 21 - Novell NetWare v4+ - GET USER INFORMATION
	AX = F27Bh subfn 04h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1783)
	ES:DI -> reply buffer (see #1784)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get User Information" request buffer:
Offset	Size	Description	(Table 1783)
 00h	WORD	0005h (length of following data)
 02h	BYTE	04h (subfunction "Get User Information")
 03h	DWORD	connection number
SeeAlso: #1784

Format of NetWare "Get User Information" reply buffer:
Offset	Size	Description	(Table 1784)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	connection number
 0Ch	DWORD	use count
 10h	BYTE	connection service type
 11h  7 BYTEs	login time
 18h	DWORD	status
 1Ch	DWORD	expiration time
 20h	DWORD	object type
 24h	BYTE	transaction flag
 25h	BYTE	logical lock threshold
 26h	BYTE	record lock threshold
 27h	BYTE	file write flags
 28h	BYTE	file write state
 29h	BYTE	(filler)
 2Ah	WORD	file lock count
 2Ch	WORD	record lock count
 2Eh  6 BYTEs	total number of bytes read
 34h  6 BYTEs	total number of bytes written
 3Ah	DWORD	total requests
 3Eh	DWORD	held requests
 42h  6 BYTEs	held bytes read
 48h  6 BYTEs	held bytes written
 4Eh	BYTE	length of user name
 4Fh  N BYTEs	user name
SeeAlso: #1783
--------N-21F27BSF06-------------------------
INT 21 - Novell NetWare v4+ - GET IPX/SPX Information
	AX = F27Bh subfn 06h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1785)
	ES:DI -> reply buffer (see #1786)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get IPX/SPX Information" request buffer:
Offset	Size	Description	(Table 1785)
 00h	WORD	0001h (length of following data)
 02h	BYTE	06h (subfunction "Get IPX/SPX Information")
SeeAlso: #1786

Format of NetWare "Get IPX/SPX Information" reply buffer:
Offset	Size	Description	(Table 1786)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	number of IPX packets sent
 0Ch	WORD	number of malformed IPX packets
 0Eh	DWORD	number of IPX Get-ECB requests
 12h	DWORD	number of failed IPX Get-ECB requests
 16h	DWORD	number of IPX AES events
 1Ah	WORD	number of postponed IPX AES events
 1Ch	WORD	maximum number of sockets (from configuration)
 1Eh	WORD	maximum number of open sockets
 20h	WORD	number of failed IPX socket opens
 22h	DWORD	number of IPX "listen" ECBs
 24h	WORD	number of failed IPX EBC cancels
 26h	WORD	number of failed IPX Get-Local-Target requests
 28h	WORD	maximum number of SPX connections (from configuration)
 2Ah	WORD	maximum number of SPX connections used
 2Ch	WORD	number of SPX Establish-Connection requests
 2Eh	WORD	number of failed SPX Establish-Connection requests
 30h	WORD	total number of SPX "listen-connect" requests
 32h	WORD	number of failed SPX "listen-connect" requests
 34h	DWORD	number of SPX sends
 38h	DWORD	number of SPX "window-choke"s
 3Ch	WORD	number of bad SPX sends
 3Eh	WORD	number of failed SPX sends
 40h	WORD	number of aborted SPX connections
 42h	DWORD	number of SPX packet listens
 46h	WORD	number of bad SPX packet listens
 48h	DWORD	number of incoming SPX packets
 4Ch	WORD	number of bad incoming SPX packets
 4Eh	WORD	number of supressed SPX packets
 50h	WORD	"SPXNoSesListenECBCount"
 52h	WORD	"SPXWatchDogDestSesCount"
SeeAlso: #1785
--------N-21F27BSF08-------------------------
INT 21 - Novell NetWare v4+ - GET CPU INFORMATION
	AX = F27Bh subfn 08h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1787)
	ES:DI -> reply buffer (see #1788)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get CPU Information" request buffer:
Offset	Size	Description	(Table 1787)
 00h	WORD	0005h (length of following data)
 02h	BYTE	08h (subfunction "Get CPU Information")
 03h	DWORD	CPU number
SeeAlso: #1788

Format of NetWare "Get CPU Information" reply buffer:
Offset	Size	Description	(Table 1788)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	number of CPUs
 0Ch	DWORD	page table owner flag
 10h	DWORD	CPU type flag
 14h	DWORD	coprocessor flag
 18h	DWORD	bus type flag
 1Ch	DWORD	I/O engine flag
 20h	DWORD	filesystem engine flag
 24h	DWORD	non-dedicated flag
 28h 201 BYTEs	counted string: CPU string;number of coprocessors;bus string
SeeAlso: #1787
--------N-21F27BSF09-------------------------
INT 21 - Novell NetWare v4+ - GET VOLUME SWITCH INFORMATION
	AX = F27Bh subfn 09h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1789)
	ES:DI -> reply buffer (see #1790)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get Volume Switch Information" request buffer:
Offset	Size	Description	(Table 1789)
 00h	WORD	0005h (length of following data)
 02h	BYTE	09h (subfunction "Get Volume Switch Information")
 03h	DWORD	starting item number
SeeAlso: #1790

Format of NetWare "Get Volume Switch Information" reply buffer:
Offset	Size	Description	(Table 1790)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	total LFS counters
 0Ch	DWORD	current LFS counters
 10h	DWORD	"readFile"
 14h	DWORD	"writeFile"
 18h	DWORD	"deleteFile"
 1Ch	DWORD	"renMove"
 20h	DWORD	"openFile"
 24h	DWORD	"createFile"
 28h	DWORD	"createAndOpenFile"
 2Ch	DWORD	"closeFile"
 30h	DWORD	"scanDeleteFile"
 34h	DWORD	"salvageFile"
 38h	DWORD	"purgeFile"
 3Ch	DWORD	"migrateFile"
 40h	DWORD	"deMigrateFile"
 44h	DWORD	"createDir"
 48h	DWORD	"deleteDir"
 4Ch	DWORD	"directoryScans"
 50h	DWORD	"mapPathToDirNum"
 54h	DWORD	"modifyDirEntry"
 58h	DWORD	"getAccessRights"
 5Ch	DWORD	"getAccessRightsFromIDs"
 60h	DWORD	"mapDirNumToPath"
 64h	DWORD	"getEntryFromPathStrBase"
 68h	DWORD	"getOtherNSEntry"
 6Ch	DWORD	"getExtDirInfo"
 70h	DWORD	"getParentDirNum"
 74h	DWORD	"addTrusteeR"
 78h	DWORD	"scanTrusteeR"
 7Ch	DWORD	"delTrusteeR"
 80h	DWORD	"purgeTrust"
 84h	DWORD	"findNextTrustRef"
 88h	DWORD	"scanUserRestNodes"
 8Ch	DWORD	"addUserRest"
 90h	DWORD	"deleteUserRest"
 94h	DWORD	"rtnDirSpaceRest"
 98h	DWORD	"getActualAvailDskSp"
 9Ch	DWORD	"cntOwnedFilesAndDirs"
 A0h	DWORD	"migFileInfo"
 A4h	DWORD	"volMigInfo"
 A8h	DWORD	"readMigFileData"
 ACh	DWORD	"getVolusageStats"
 B0h	DWORD	"getActualVolUsageStats"
 B4h	DWORD	"getDirUsageStats"
 B8h	DWORD	"NMFileReadsCount"
 BCh	DWORD	"NMFileWritesCount"
 C0h	DWORD	"mapPathToDirNumOrPhantom"
 C4h	DWORD	"stationsHasAccessRgtsGntedBelow"
 C8h	DWORD	"gtDataSteamLensFromPathStrBase"
 CCh	DWORD	"checkAndGetDirectoryEntry"
 D0h	DWORD	"getDeletedEntry"
 D4h	DWORD	"getOriginalNameSpace"
 D8h	DWORD	"getActualFileSize"
 DCh	DWORD	"verifyNameSpaceNumber"
 E0h	DWORD	"verifyDataStreamNumber"
 E4h	DWORD	"checkVolumeNumber"
 E8h	DWORD	"commitFile"
 ECh	DWORD	"VMGetDirectoryEntry"
 F0h	DWORD	"createDMFileEntry"
 F4h	DWORD	"renameNameSpaceEntry"
 F8h	DWORD	"logFile"
 FCh	DWORD	"releaseFile"
100h	DWORD	"clearFile"
104h	DWORD	"setVolumeFlag"
108h	DWORD	"clearVolumeFlag"
10Ch	DWORD	"getOriginalInfo"
110h	DWORD	"createMigratedDir"
114h	DWORD	"F3OpenCreate"
118h	DWORD	"F3InitFileSearch"
11Ch	DWORD	"F3ContinueFileSearch"
120h	DWORD	"F3RenameFile"
124h	DWORD	"F3ScanForTrustees"
128h	DWORD	"F3ObtainFileInfo"
12Ch	DWORD	"F3ModifyInfo"
130h	DWORD	"F3EraseFile"
134h	DWORD	"F3SetDirHandle"
138h	DWORD	"F3AddTrustees"
13Ch	DWORD	"F3DeleteTrustees"
140h	DWORD	"F3AllocDirHandle"
144h	DWORD	"F3ScanSalvagedFiles"
148h	DWORD	"F3RecoverSalvagedFiles"
14Ch	DWORD	"F3PurgeSalvageableFile"
150h	DWORD	"F3GetNSSpecificInfo"
154h	DWORD	"F3ModifyNSSpecificInfo"
158h	DWORD	"F3SearchSet"
15Ch	DWORD	"F3GetDirBase"
160h	DWORD	"F3QueryNameSpaceInfo"
164h	DWORD	"F3GetNameSpaceList"
168h	DWORD	"F3GetHugeInfo"
16Ch	DWORD	"F3SetHugeInfo"
170h	DWORD	"F3GetFullPathString"
174h	DWORD	"F3GetEffectiveDirectoryRights"
SeeAlso: #1789
--------N-21F27BSF0A-------------------------
INT 21 - Novell NetWare v4+ - GET LOADED NLMs
	AX = F27Bh subfn 0Ah
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1791)
	ES:DI -> reply buffer (see #1792)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get NLMs Loaded" request buffer:
Offset	Size	Description	(Table 1791)
 00h	WORD	0005h (length of following data)
 02h	BYTE	0Ah (subfunction "Get NLMs Loaded")
 03h	DWORD	first NLM number to report
SeeAlso: #1792

Format of NetWare "Get NLMs Loaded" reply buffer:
Offset	Size	Description	(Table 1792)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	total number of NLMs
 0Ch	DWORD	number of NLM numbers following (max 50)
 10h 50 DWORDs	NLM numbers
SeeAlso: #1791
--------N-21F27BSF0B-------------------------
INT 21 - Novell NetWare v4+ - GET NLM INFORMATION
	AX = F27Bh subfn 0Bh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1793)
	ES:DI -> reply buffer (see #1794)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get NLM Information" request buffer:
Offset	Size	Description	(Table 1793)
 00h	WORD	0005h (length of following data)
 02h	BYTE	0Bh (subfunction "Get NLM Information")
 03h	DWORD	NLM number
SeeAlso: #1794

Format of NetWare "Get NLM Information" reply buffer:
Offset	Size	Description	(Table 1794)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	identification number
 0Ch	DWORD	flags
 10h	DWORD	NLM type (see #1795)
 14h	DWORD	parent identifier
 18h	DWORD	major version	
 1Ch	DWORD	minor version
 20h	DWORD	revision
 24h	DWORD	year
 28h	DWORD	month
 2Ch	DWORD	day
 30h	DWORD	bytes available for allocation
 34h	DWORD	"allocFreeCount"
 38h	DWORD	last garbage collection
 3Ch	DWORD	message language
 40h	DWORD	number of referenced public identifiers
 44h 200 BYTEs	NLM strings: filename, NLM name, copyright
SeeAlso: #1793

(Table 1795)
Values for NetWare NLM type:
 0001h	LAN
 0002h	DSK
 0003h	NAM
 0004h	utility NLM
 0005h	MSL
 0006h	operating system NLM
 0007h	paged NLM
 0008h	HAM
 0009h	CDM
 000Ah	file system NLM
 000Bh	real mode NLM
 000Ch	hidden NLM
SeeAlso: #1794
--------N-21F27BSF0D-------------------------
INT 21 - Novell NetWare v4+ - GET OS VERSION INFORMATION
	AX = F27Bh subfn 0Dh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1796)
	ES:DI -> reply buffer (see #1797)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get OS Version Information" request buffer:
Offset	Size	Description	(Table 1796)
 00h	WORD	0001h (length of following data)
 02h	BYTE	0Dh (subfunction "Get OS Version Information")
SeeAlso: #1797

Format of NetWare "Get OS Version Information" reply buffer:
Offset	Size	Description	(Table 1797)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	BYTE	operating system major version
 09h	BYTE	operating system minor version
 0Ah	BYTE	operating system revision number
 0Bh	BYTE	accounting version
 0Ch	BYTE	VAP version
 0Dh	BYTE	queueing version
 0Eh	BYTE	security restrictions level
 0Fh	BYTE	bridging support
 10h	DWORD	maximum number of volumes
 14h	DWORD	number of connection slots
 18h	DWORD	maximum number of logged-in connections
 1Ch	DWORD	maximum number of name spaces
 20h	DWORD	maximum number of LANs
 24h	DWORD	maximum number of media types
 28h	DWORD	maximum number of protocols
 2Ch	DWORD	maximum subdirectory tree depth
 30h	DWORD	maximum number of data streams
 34h	DWORD	maximum number of spooled printers
 38h	DWORD	serial number
 3Ch	WORD	application number
SeeAlso: #1796
--------N-21F27BSF14-------------------------
INT 21 - Novell NetWare v4+ - GET ACTIVE LAN BOARD LIST
	AX = F27Bh subfn 14h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1798)
	ES:DI -> reply buffer (see #1799)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get Active LAN Board List" request buffer:
Offset	Size	Description	(Table 1798)
 00h	WORD	0005h (length of following data)
 02h	BYTE	14h (subfunction "Get Active LAN Board List")
 03h	DWORD	start number
SeeAlso: #1799

Format of NetWare "Get Active LAN Board List" reply buffer:
Offset	Size	Description	(Table 1799)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	maximum number of LANs
 0Ch	DWORD	number of LAN board numbers returned
 10h 50 DWORDs	board numbers
SeeAlso: #1798
--------N-21F27BSF15-------------------------
INT 21 - Novell NetWare v4+ - GET LAN CONFIGURATION
	AX = F27Bh subfn 15h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1800)
	ES:DI -> reply buffer (see #1801)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=16h

Format of NetWare "Get LAN Configuration" request buffer:
Offset	Size	Description	(Table 1800)
 00h	WORD	0005h (length of following data)
 02h	BYTE	15h (subfunction "Get LAN Configuration")
 03h	DWORD	LAN board number
SeeAlso: #1801

Format of NetWare "Get LAN Configuration" reply buffer:
Offset	Size	Description	(Table 1801)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	BYTE	driver configuration major version
 09h	BYTE	driver configuration minor version
 0Ah  6 BYTEs	driver node address
 10h	WORD	driver mode flags
 12h	WORD	driver board number
 14h	WORD	driver board instance
 16h	DWORD	driver maximum size
 1Ah	DWORD	driver maximum receive size
 1Eh	DWORD	driver receive size
 22h  3 DWORDs	reserved
 2Eh	WORD	driver card ID
 30h	WORD	driver transport time
 32h	DWORD	driver source routing
 36h	WORD	driver line speed
 38h	WORD	driver reserved
 3Ah	BYTE	driver major version
 3Bh	BYTE	driver minor version
 3Ch	WORD	driver flags
 3Eh	WORD	driver send retries
 40h	DWORD	driver link
 44h	WORD	driver sharing flags
 46h	WORD	driver slot
 48h  4 WORDs	driver I/O port and lengths
 50h	DWORD	driver memory decode 0
 54h	WORD	driver length 0
 56h	DWORD	driver memory decode 1
 5Ah	WORD	driver length 1
 5Ch  2 BYTEs	driver's interrupts
 5Eh  2 BYTEs	driver's DMA usage
 60h 18 BYTEs	driver's logical name
 72h 14 BYTEs	driver I/O reserved
 80h 128 BYTEs	driver card name
100h 40 BYTEs	driver media type
128h 180 BYTEs	driver custom variables
SeeAlso: #1800
--------N-21F27BSF16-------------------------
INT 21 - Novell NetWare v4+ - GET LAN COMMON COUNTERS
	AX = F27Bh subfn 16h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1802)
	ES:DI -> reply buffer (see #1803)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=15h

Format of NetWare "Get LAN Common Counters" request buffer:
Offset	Size	Description	(Table 1802)
 00h	WORD	0009h (length of following data)
 02h	BYTE	16h (subfunction "Get LAN Common Counters")
 03h	DWORD	LAN board number
 07h	DWORD	starting block number (set to 00000000h for first call)
SeeAlso: #1803

Format of NetWare "Get LAN Common Counters" reply buffer:
Offset	Size	Description	(Table 1803)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	BYTE	statistics major version
 09h	BYTE	statistics minor version
 0Ah	DWORD	number of generic counters
 0Eh	DWORD	number of counter blocks
 12h	DWORD	number of custom variables
 16h	DWORD	next counter block number
 1Ah	DWORD	"notSupportedMask"
 1Eh	DWORD	total number of packets tranmitted
 22h	DWORD	total number of packets received
 26h	DWORD	number of times no ECBs were available
 2Ah	DWORD	number of transmitted packets which were too large
 2Eh	DWORD	number of transmitted packets which were too small
 32h	DWORD	number of packet receive overflows
 36h	DWORD	number of received packets which were too large
 3Ah	DWORD	number of received packets which were too small
 3Eh	DWORD	number of miscellaneous transmitted-packet errors
 42h	DWORD	number of miscellaneous received-packet errors
 46h	DWORD	number of times transmission retried
 4Ah	DWORD	number of checksum errors
 4Eh	DWORD	number of hardware receive mismatches
 52h 50 BYTEs	reserved
SeeAlso: #1802
--------N-21F27BSF29-------------------------
INT 21 - Novell NetWare v4+ - GET PROTOCOL STACK BY BOARD
	AX = F27Bh subfn 29h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1804)
	ES:DI -> reply buffer (see #1805)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get Protocol Stack by Board" request buffer:
Offset	Size	Description	(Table 1804)
 00h	WORD	0005h (length of following data)
 02h	BYTE	29h (subfunction "Get Protocol Stack by Board")
 03h	DWORD	LAN board number
SeeAlso: #1805

Format of NetWare "Get Protocol Stack by Board" reply buffer:
Offset	Size	Description	(Table 1805)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	WORD	number of stacks listed (max 50)
 0Ah 50 DWORDs	protocol identifiers
SeeAlso: #1804
--------N-21F27BSF33-------------------------
INT 21 - Novell NetWare v4+ - GET ROUTER INFO
	AX = F27Bh subfn 33h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1806)
	ES:DI -> reply buffer (see #1807)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=35h

Format of NetWare "Get Router Info" request buffer:
Offset	Size	Description	(Table 1806)
 00h	WORD	0005h (length of following data)
 02h	BYTE	33h (function "Get Router Info")
 03h	DWORD	network number
SeeAlso: #1807

Format of NetWare "Get Router Info" reply buffer:
Offset	Size	Description	(Table 1807)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	network number
 0Ch	WORD	hops to net
 0Eh	WORD	network status
 10h	WORD	time to net
SeeAlso: #1806,#1808
--------N-21F27BSF35-------------------------
INT 21 - Novell NetWare v4+ - GET KNOWN NETWORKS INFO
	AX = F27Bh subfn 35h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1808)
	ES:DI -> reply buffer (see #1809)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=33h,AX=F27Bh/SF=38h

Format of NetWare "Get Router Info" request buffer:
Offset	Size	Description	(Table 1808)
 00h	WORD	0005h (length of following data)
 02h	BYTE	35h (function "Get Known Networks Info")
 03h	DWORD	start number (00000000h)
SeeAlso: #1809

Format of NetWare "Get Router Info" reply buffer:
Offset	Size	Description	(Table 1809)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	number of records following (max 20)
 0Ch	var	array of network info records
		Offset	Size	Description
		 00h	WORD	network number
		 04h	WORD	hops to net
		 06h	WORD	network status
		 08h	WORD	time to net
SeeAlso: #1806,#1808
--------N-21F27BSF38-------------------------
INT 21 - Novell NetWare v4+ - GET KNOWN SERVERS INFO
	AX = F27Bh subfn 38h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1810)
	ES:DI -> reply buffer (see #1811)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=35h

Format of NetWare "Get Known Servers" request buffer:
Offset	Size	Description	(Table 1810)
 00h	WORD	0009h (length of following data)
 02h	BYTE	38h (function "Get Known Servers")
 03h	DWORD	start number
 07h	DWORD	server type
SeeAlso: #1811

Format of NetWare "Get Known Servers" reply buffer:
Offset	Size	Description	(Table 1811)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	number of records following (max 20)
 0Ch	var	server record(s)
		Offset	Size	Description
		 00h	DWORD	network number
		 04h  6 BYTEs	node number
		 0Ah	WORD	socket number
		 0Ch	WORD	hops to server
		 0Eh 48 BYTEs	object name
SeeAlso: #1810
--------N-21F27BSF3C-------------------------
INT 21 - Novell NetWare v4+ - GET SERVER SET COMMANDS INFO
	AX = F27Bh subfn 3Ch
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1812)
	ES:DI -> reply buffer (see #1813)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get Server Set Commands Info" request packet:
Offset	Size	Description	(Table 1812)
 00h	WORD	0005h (length of following data)
 02h	BYTE	3Ch (subfunction "Get Server Set Commands Info")
 03h	DWORD	start sequence number
SeeAlso: #1813

Format of NetWare "Get Server Set Commands Info" packet:
Offset	Size	Description	(Table 1813)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	number of set commands
 0Ch	DWORD	next sequence number
 10h	DWORD	set command type
 14h	DWORD	set command category
 18h	DWORD	set command flags
 1Ch	BYTE	length of set command name
 1Dh  N BYTEs	set command name
	BYTE	number of set command values
      N BYTEs	set command values
SeeAlso: #1812
--------N-21F27BSF3D-------------------------
INT 21 - Novell NetWare v4+ - GET SERVER SET CATEGORIES
	AX = F27Bh subfn 3Dh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #1814)
	ES:DI -> reply buffer (see #1815)
Return: AL = status (see #2085 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get Server Set Categories" request packet:
Offset	Size	Description	(Table 1814)
 00h	WORD	0005h (length of following data)
 02h	BYTE	3Dh (subfunction "Get Server Set Categories")
 03h	DWORD	start sequence number
SeeAlso: #1815

Format of NetWare "Get Server Set Categories" reply packet:
Offset	Size	Description	(Table 1815)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	number of set categories
 0Ch	DWORD	next sequence number
 10h	BYTE	length of category name
 11h  N BYTEs	category name
SeeAlso: #1814
--------v-21F2AA-----------------------------
INT 21 - VIRUS - "PcVrsDs" - INSTALLATION CHECK
	AX = F2AAh
Return: AH = AAh if resident
SeeAlso: AH=F1h"VIRUS",AH=F3h"VIRUS"
--------N-21F3-------------------------------
INT 21 - Novell NetWare - FILE SERVICES - FILE SERVER FILE COPY
	AH = F3h
	ES:DI -> request buffer (see #1816)
Return: AL = status/error code
	CX:DX = number of bytes copied
Notes:	this function is supported by Advanced NetWare 2.0+
	both source and destination must be on the same file server
SeeAlso: AH=3Ch,AH=3Fh

Format of NetWare "File Server File Copy" request buffer:
Offset	Size	Description	(Table 1816)
 00h	WORD	source file handle (as returned by AH=3Ch or AH=3Dh)
 02h	WORD	destination file handle
 04h	DWORD	starting offset in source
 08h	DWORD	starting offset in destination
 0Ch	DWORD	number of bytes to copy
--------T-21F3-------------------------------
INT 21 - DoubleDOS - ADD CHARACTER TO KEYBOARD BUFFER OF CURRENT JOB
	AH = F3h
	AL = character
Return: AL = 00h successful
	     01h buffer full (128 characters)
SeeAlso: AH=E3h"DoubleDOS",AH=F1h"DoubleDOS",AH=F2h"DoubleDOS"
SeeAlso: AH=F8h"DoubleDOS"
--------v-21F3-------------------------------
INT 21 - VIRUS - "Carfield" - INSTALLATION CHECK
	AH = F3h
Return: AX = 0400h if resident
SeeAlso: AH=D5h"Carfield",AX=F2AAh,AH=F7h"VIRUS"
--------T-21F400-----------------------------
INT 21 - DoubleDOS - INSTALLATION CHECK/PROGRAM STATUS
	AX = F400h
Return: AL = program status
	    00h if DoubleDOS not present
	    01h if running in visible DoubleDOS partition
	    02h if running in the invisible DoubleDOS partition
SeeAlso: AX=E400h,AH=F5h"DoubleDOS"
--------T-21F5-------------------------------
INT 21 - DoubleDOS - OTHER PROGRAM STATUS
	AH = F5h
Return: AL = program status
	    00h no program in other partition
	    01h program in other partition is running
	    02h program in other partition is suspended
SeeAlso: AH=E5h"DoubleDOS",AX=F400h"DoubleDOS"
--------v-21F7-------------------------------
INT 21 - VIRUS - "GP1" - INSTALLATION CHECK
	AH = F7h
Return: AX = 0300h if resident
SeeAlso: AH=F0h"VIRUS",AH=F9h"VIRUS"
--------D-21F8-------------------------------
INT 21 - DOS v2.11-2.13 - SET OEM INT 21 HANDLER
	AH = F8h
	DS:DX -> OEM INT 21 handler for functions F9h to FFh
		 FFFFh:FFFFh disables OEM handler
Notes:	this function is known to be supported by Toshiba T1000 ROM MS-DOS
	  v2.11, Sanyo MS-DOS v2.11, and TI Professional Computer DOS v2.13
	calls to AH=F9h through AH=FFH will return AL=00h if no handler set
	handler is called with all registers exactly as set by caller, and
	  should exit with IRET
SeeAlso: AH=F9h"OEM"
--------T-21F8-------------------------------
INT 21 - DoubleDOS - SET/RESET KEYBOARD CONTROL FLAGS
	AH = F8h
	AL = program for which to set flags
	    00h this program
	    01h other program
	DX = keyboard control flags (see #1384 at AH=E8h"DoubleDOS")
Return: DX = previous flags
Notes:	disabling Ctrl-PrtSc will allow the program to intercept the keystroke;
	  disabling any of the other keystrokes disables them completely
	this function is identical to AH=E8h
SeeAlso: AH=E8h"DoubleDOS",AH=F1h"DoubleDOS",AH=F2h"DoubleDOS"
SeeAlso: AH=F3h"DoubleDOS"
--------D-21F9-------------------------------
INT 21 - DOS v2.11-2.13 - OEM FUNCTION
	AH = F9h
Return: AL = 00h if no OEM function handler installed (see AH=F8h"OEM")
SeeAlso: AH=F8h"OEM",AH=FAh"OEM"
--------T-21F9-------------------------------
INT 21 - DoubleDOS - SET TIMESHARING PRIORITY
	AH = F9h
	AL = priority
	    00h visible program gets 70%, invisible gets 30% (default)
	    01h visible program gets 50%, invisible gets 50%
	    02h visible program gets 30%, invisible gets 70%
	    03h Top program gets 70%, bottom program gets 30%
	    04h Top program gets 30%, bottom program gets 70%
	    05h get current priority
		Return: AL = priority setting
Note:	identical to AH=E9h
SeeAlso: AH=E9h"DoubleDOS",AH=FAh"DoubleDOS",AH=FBh"DoubleDOS"
--------v-21F9-------------------------------
INT 21 - VIRUS - "Satans-Bug" - INSTALLATION CHECK
	AH = F9h
Return: AX = AC0Ah if resident
SeeAlso: AH=F7h"VIRUS",AH=FBh"VIRUS",AX=FEDCh"VIRUS"
--------D-21FA-------------------------------
INT 21 - DOS v2.11-2.13 - OEM FUNCTION
	AH = FAh
Return: AL = 00h if no OEM function handler installed (see AH=F8h"OEM")
SeeAlso: AH=F8h"OEM",AH=F9h"OEM",AH=FBh"OEM"
--------T-21FA-------------------------------
INT 21 - DoubleDOS - TURN OFF TASK SWITCHING
	AH = FAh
Return: task switching turned off
SeeAlso: AH=EAh"DoubleDOS",AH=F9h"DoubleDOS",AH=FBh"DoubleDOS"
SeeAlso: INT FA"DoubleDOS"
--------v-21FA-------------------------------
INT 21 - VIRUS - "Cinderella 2" - INSTALLATION CHECK
	AH = FAh
Return: AH = F9h if resident
SeeAlso: AH=F0h"VIRUS",AX=FBA0h"VIRUS"
--------v-21FA--DX5945-----------------------
INT 21 U - PC Tools v7+ VDEFEND, VSAFE, VWATCH - API
	AH = FAh
	DX = 5945h
	AL = function (00h-02h for VDEFEND, 00h-07h for VSAFE and VWATCH)
Return: varies by function
Note:	this API is identical to the API on INT 13/AH=FAh and INT 16/AH=FAh,
	  so it is listed in its entirety only under INT 16/AX=FA00h and
	  following
SeeAlso: INT 13/AX=FA00h,INT 16/AX=FA00h
--------D-21FB-------------------------------
INT 21 - DOS v2.11-2.13 - OEM FUNCTION
	AH = FBh
Return: AL = 00h if no OEM function handler installed (see AH=F8h"OEM")
SeeAlso: AH=F8h"OEM",AH=FAh"OEM",AH=FCh"OEM"
--------T-21FB-------------------------------
INT 21 - DoubleDOS - TURN ON TASK SWITCHING
	AH = FBh
Return: task switching turned on
SeeAlso: AH=EBh"DoubleDOS",AH=F9h"DoubleDOS",AH=FAh"DoubleDOS"
SeeAlso: INT FB"DoubleDOS"
--------v-21FB-------------------------------
INT 21 - VIRUS - "Cinderella" - INSTALLATION CHECK
	AH = FBh
Return: AH = 00h if resident
SeeAlso: AH=F9h"VIRUS",AH=FAh"VIRUS",AX=FB0Ah
--------v-21FB0A-----------------------------
INT 21 - VIRUS - "dBASE" - INSTALLATION CHECK
	AX = FB0Ah
Return: AX = 0AFBh if resident
SeeAlso: AH=FBh"VIRUS",AX=FBA0h"VIRUS",AH=FCh"VIRUS"
--------v-21FBA0-----------------------------
INT 21 - VIRUS - "Groove" - INSTALLATION CHECK
	AX = FBA0h
Return: AX = 0ABFh if resident
SeeAlso: AX=FB0Ah"VIRUS",AH=FCh"VIRUS"
--------D-21FC-------------------------------
INT 21 - DOS v2.11-2.13 - OEM FUNCTION
	AH = FCh
Return: AL = 00h if no OEM function handler installed (see AH=F8h"OEM")
SeeAlso: AH=F8h"OEM",AH=FBh"OEM",AH=FDh"OEM"
--------T-21FC-------------------------------
INT 21 - DoubleDOS - GET VIRTUAL SCREEN ADDRESS
	AH = FCh
Return: ES = segment of virtual screen
Desc:	Determine the address of the virtual screen to which the program
	  should write instead of the actual video memory, so that the
	  multitasked programs do not interfere with each other's output.
Notes:	screen address can change if task-switching is on!
	identical to AH=ECh
SeeAlso: AH=ECh"DoubleDOS",INT FC"DoubleDOS"
--------v-21FC-------------------------------
INT 21 - VIRUS - "Troi" - INSTALLATION CHECK
	AH = FCh
Return: AL = A5h if resident
SeeAlso: AX=FBA0h"VIRUS",AX=FC03h"VIRUS",AH=FDh"VIRUS"
--------v-21FC03-----------------------------
INT 21 - VIRUS - "Invisible" - INSTALLATION CHECK
	AX = FC03h
Return: AX = 03FCh if resident
SeeAlso: AH=FCh"VIRUS",AH=FDh"VIRUS"
--------D-21FD-------------------------------
INT 21 - DOS v2.11-2.13 - OEM FUNCTION
	AH = FDh
Return: AL = 00h if no OEM function handler installed (see AH=F8h"OEM")
SeeAlso: AH=F8h"OEM",AH=FCh"OEM",AH=FEh"OEM"
--------v-21FD-------------------------------
INT 21 - VIRUS - "Border" - INSTALLATION CHECK
	AH = FDh
Return: AH = 13h if resident
SeeAlso: AH=FCh"VIRUS",AX=FDACh"VIRUS",AH=FEh"VIRUS"
--------s-21FD12BX3457-----------------------
INT 21 - Gravis UltraSound - MegaEm/MEGA_EM - INSTALLATION CHECK
	AX = FD12h
	BX = 3457h
Return: AX = 5678h if installed
	BX = 1235h if v1.x or v2.x installed
	    CL = interrupt vector used by MegaEm (default 81h)
	BX = 1237h if v3.x installed
	    CL = interrupt vector used by MegaEm (default 81h)
	    DX = version number
Program: MegaEm is a protected-mode SoundBlaster, SoundCanvas, and MT-32
	  emulator for the Gravis UltraSound
SeeAlso: INT 2F/AX=CD00h/BX=464Fh,INT 7E/AX=00FEh"SBOS"
--------v-21FDAC-----------------------------
INT 21 - VIRUS - "Delwin" - INSTALLATION CHECK
	AX = FDACh
Return: AX = 02E3h if resident
SeeAlso: AH=FDh"VIRUS",AH=FEh"VIRUS"
--------D-21FE-------------------------------
INT 21 - DOS v2.11-2.13 - OEM FUNCTION
	AH = FEh
Return: AL = 00h if no OEM function handler installed (see AH=F8h"OEM")
SeeAlso: AH=F8h"OEM",AH=FDh"OEM",AH=FFh"OEM"
--------T-21FE-------------------------------
INT 21 - DoubleDOS - GIVE AWAY TIME TO OTHER TASKS
	AH = FEh
	AL = number of 55ms time slices to give away
Return: returns after giving away time slices
SeeAlso: AH=EEh"DoubleDOS",INT FE"DoubleDOS"
--------v-21FE-------------------------------
INT 21 - VIRUS - "483" - INSTALLATION CHECK
	AH = FEh
Return: AH = 00h if resident
SeeAlso: AX=FDACh"VIRUS",AX=FE01h
--------v-21FE01-----------------------------
INT 21 - VIRUS - "Flip" - INSTALLATION CHECK
	AX = FE01h
Return: AX = 01FEh if resident
SeeAlso: AH=FEh"VIRUS",AX=FE02h
--------v-21FE02-----------------------------
INT 21 - VIRUS - "2468"/"Tequila" - INSTALLATION CHECK
	AX = FE02h
Return: AX = 01FDh if resident
SeeAlso: AX=FE01h,AX=FE03h,AX=FEDCh"VIRUS"
--------v-21FE03-----------------------------
INT 21 - VIRUS - "2468"/"Tequila" - DISPLAY VIRUS MESSAGE
	AX = FE03h
SeeAlso: AX=FE02h,AX=FEADh
--------v-21FEAD------------------------
INT 21 - VIRUS - "Shifting Objective" - INSTALLATION CHECK
	AX = FEADh
Return:	AX = D00Dh if resident
SeeAlso: AX=FE03h,AX=FEDCh"VIRUS"
--------d-21FEDC-----------------------------
INT 21 - PCMag PCMANAGE/DCOMPRES - INSTALLATION CHECK
	AX = FEDCh
Return: AX = CDEFh if installed
Program: the PCMANAGE/DCOMPRES combination from PC Magazine permits
	  infrequently-used files to be compressed to save space and
	  transparently expanded when accessed
SeeAlso: AH=DCh,INT 2D/AL=10h"dLite"
--------v-21FEDC-----------------------------
INT 21 - VIRUS - "Black Monday" - INSTALLATION CHECK
	AX = FEDCh
Return: AL = DCh if resident
SeeAlso: AX=FE02h,AX=FEFEh
--------v-21FEFE-----------------------------
INT 21 - VIRUS - "CIDER" - INSTALLATION CHECK
	AX = FEFEh
Return: SI = 1994h if resident
SeeAlso: AX=FEDCh"VIRUS",AH=FFh"VIRUS"
--------!---Section--------------------------
