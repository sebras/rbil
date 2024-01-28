Interrupt List, part 5 of 16
Copyright (c) 1989,1990,1991,1992,1993,1994,1995,1996,1997 Ralf Brown
--------X-1AB000-----------------------------
INT 1A U - HP 100LX/200LX - PCMCIA - ???
	AX = B000h
	ES:BX -> parameter block ???
Return: CF clear if ???
	CF set if ???
Note:	called by HP 100LX/200LX PCMCIA client CIC100.EXE
--------d-1AB001CX4D52-----------------------
INT 1A - Microsoft Real-Time Compression Interface (MRCI) - ROM-BASED SERVER
	AX = B001h
	CX = 4D52h ("MR")
	DX = 4349h ("CI")
Return: CX = 4943h ("IC") if installed
	DX = 524Dh ("RM") if installed
	    ES:DI -> MRCINFO structure (see #0649)
Note:	this call is functionally identical to INT 2F/AX=4A12h, which should
	  be called first, as this call is used for the first, ROM-based
	  MRCI server, while the other call is used for RAM-based servers
	  which may be partially or entirely replacing a prior server
SeeAlso: INT 2F/AX=4A12h

Format of MRCINFO structure:
Offset	Size	Description	(Table 0649)
 00h  4 BYTEs	vendor signature
		"MSFT" Microsoft
 04h	WORD	server version (high=major)
 06h	WORD	MRCI specification version
 08h	DWORD	address of server entry point (see #0651)
 0Ch	WORD	bit flags: server capabilities (see #0650)
 0Eh	WORD	bit flags: hardware assisted capabilities (see #0650)
 10h	WORD	maximum block size supported by server (at least 8192 bytes)

Bitfields for MRCI capabilities:
Bit(s)	Description	(Table 0650)
 0	standard compress
 1	standard decompress
 2	update compress
 3	MaxCompress (not present in initial public release)
 4	reserved
 5	incremental decompress
 6	MRCI 2.0 standard compress
 7	MRCI 2.0 standard decompress
 8-14	reserved
 15	this structure is in ROM and can't be modified
	(server capabilities only)

(Table 0651)
Call MRCI entry point with:
	DS:SI -> MRCREQUEST structure (see #0652)
	CX = type of client (0000h application, 0001h file system)
	AX = operation
	    0001h perform standard compression
	    0002h perform standard decompression
	    0004h perform update compression
	    0008h perform MaxCompress
	    0020h perform incremental decompression
	    0040h perform MRCI 2.0 standard compression
	    0080h perform MRCI 2.0 standard decompression
	AX = FFFFh clear flags
	    BX = bitmask of flags to clear (set bits in BX are flags to clear)
Return: AX = status
	    0000h successful
	    0001h invalid function
	    0002h server busy, try again
	    0003h destination buffer too small
	    0004h incompressible data
	    0005h bad compressed data format
	BP destroyed (MS-DOS 6.2)
Note:	MRCI driver may chain to a previous driver

Format of MRCREQUEST structure:
Offset	Size	Description	(Table 0652)
 00h	DWORD	pointer to source buffer
 04h	WORD	size of source buffer (0000h = 64K)
 06h	WORD	(UpdateCompress only)
		(call) offset in source buffer of beginning of changed data
		(ret) offset in destination buffer of beginning of changed
			  compressed data
 08h	DWORD	pointer to destination buffer
		must contain original compressed data for UpdateCompress
 0Ch	WORD	size of destination buffer (0000h = 64K)
		any compression: size of buffer for compressed data
		standard decompression: number of bytes to be decompressed
		incremental decompression: number of byte to decompress now
		(ret) actual size of resulting data
 0Eh	WORD	client compressed data storage allocation size
 10h	DWORD	incremental decompression state data
		set to 00000000h before first incremental decompression call
Notes:	the source and destination buffers may not overlap
	the source and destination buffer sizes should normally be the same
	application should not update the contents of the MRCREQUEST structure
	  between incremental decompression calls
--------X-1AB101-----------------------------
INT 1A - PCI BIOS v2.0c+ - INSTALLATION CHECK
	AX = B101h
	EDI = 00000000h
Return: AH = 00h if installed
	    CF clear
	    EDX = 20494350h (' ICP')
	    EDI = physical address of protected-mode entry point (see #0655)
	    AL = PCI hardware characteristics (see #0654)
	    BH = PCI interface level major version (BCD)
	    BL = PCI interface level minor version (BCD)
	    CL = number of last PCI bus in system
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	some BIOSes do not change EDI, so applications looking for the
	  protected-mode entry point should set EDI to 00000000h before
	  calling this function
SeeAlso: AX=B181h

(Table 0653)
Values for PCI BIOS v2.0c+ status codes:
 00h	successful
 81h	unsupported function
 83h	bad vendor ID
 86h	device not found
 87h	bad PCI register number

Bitfields for PCI hardware characteristics:
Bit(s)	Description	(Table 0654)
 0	configuration space access mechanism 1 supported
 1	configuration space access mechanism 2 supported
 2-3	reserved
 4	Special Cycle generation mechanism 1 supported
 5	Special Cycle generation mechanism 2 supported
 6-7	reserved

(Table 0655)
Call protected-mode entry point with:
	registers as for real/V86-mode INT call
	CS = ring 0 descriptor with access to full address space
Return: as for real/V86-mode call
--------X-1AB102-----------------------------
INT 1A - PCI BIOS v2.0c+ - FIND PCI DEVICE
	AX = B102h
	CX = device ID (see #0659,#0665,#0666,#0793,#0795)
	DX = vendor ID (see #0656)
	SI = device index (0-n)
Return: CF clear if successful
	CF set on error
	AH = status (00h,83h,86h) (see #0653)
	    00h successful
		BH = bus number
		BL = device/function number (bits 7-3 device, bits 2-0 func)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	device ID FFFFh may be reserved as a wildcard in future implementations
	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
	all devices sharing a single vendor ID and device ID may be enumerated
	  by incrementing SI from 0 until error 86h is returned
SeeAlso: AX=B182h

(Table 0656)
Values for PCI vendor ID:
 003Dh	Martin-Marietta Corporation
 0E11h	Compaq (see #0657)
 1000h	Symbios Logic Inc (formerly NCR) (see #0658)
 1002h	ATI (see #0659)
 1003h	ULSI Systems
 1004h	VLSI Technologies (see #0660)
 1005h	Avance Logics (ADL) (see #0661)
 1006h	Reply Group
 1007h	Netframe Systems Inc.
 1008h	Epson
 100Ah	Phoenix Technologies
 100Bh	National Semiconductor (see #0662)
 100Ch	Tseng Labs (see #0663) (also ID 10BEh)
 100Dh	AST Research
 100Eh	Weitek (see #0664)
 1010h	Video Logic Ltd
 1011h	DEC (see #0665)
 1012h	Micronics Computers
 1013h	Cirrus Logic (see #0666,#0028)
 1014h	IBM (see #0667)
 1015h	LSI Logic Corp. of Canada
 1016h	ICL Personal Systems
 1017h	SPEA Software AG
 1018h	Unisys
 1019h	EliteGroup Computer Sys
 101Ah	NCR/AT&T GIS
 101Bh	Vitesse Semiconductor
 101Ch	Western Digital (see #0668)
 101Eh	AMI (see #0669)
 101Fh	Picturetel
 1020h	Hitachi Computer Electronics
 1021h	Oki Electric Industry
 1022h	Advanced Micro Devices (see #0670)
 1023h	Trident Microsystems (see #0671)
 1024h	Zenith Data Systems
 1025h	Acer
 1028h	Dell Computer Corporation
 1029h	Siemens Nixdorf
 102Ah	LSI Logic, Headland Division (see #0672)
 102Bh	Matrox (see #0673)
 102Ch	Chips & Technologies (see #0674)
 102Dh	Wyse Technologies
 102Eh	Olivetti Advanced Technology
 102Fh	Toshiba America (see #0675)
 1030h	TMC Research
 1031h	Miro / Micro Computer Products AG (see #0676)
 1032h	Compaq
 1033h	NEC Corporation (see #0677)
 1034h	Burndy Corporation
 1035h	Computers and Communications Research Lab
 1036h	Future Domain (see #0678)
 1037h	Hitachi Micro Systems
 1038h	AMP Incorporated
 1039h	Silicon Integrated System (SIS) (see #0679)
 103Ah	Seiko Epson Corporation
 103Bh	Tatung Corp. of America
 103Ch	Hewlett-Packard (see #0680)
 103Eh	Solliday
 103Fh	Logic Modeling
 1040h	Kubota Pacific
 1041h	Computrend
 1042h	PC Technology (see #0681,#0826) (see also PORT 03F0h"PCTech")
 1043h	Asustek
 1044h	Distributed Processing Technology (DPT) (see #0682)
 1045h	OPTi (see #0683)
 1046h	IPC Corporation, Ltd.
 1047h	Genoa Systems Corp.
 1048h	Elsa GmbH
 1049h	Fountain Technology
 104Ah	SGS Thomson Microelectric (see #0684)
 104Bh	BusLogic (see #0685)
 104Ch	Texas Instruments (see #0686)
 104Dh	Sony Corporation
 104Eh	Oak Technology (see #0687)
 104Fh	Co-Time Computer Ltd.
 1050h	Winbond (see #0688)
 1051h	Anigma Corp.
 1052h	Young Micro Systems
 1054h	Hitachi, Ltd. (see #0689)
 1055h	EFAR Microsystems (see #0690)
 1056h	ICL
 1057h	Motorola (see #0691)
 1058h	Electronics and Telecommunications Research
 1059h	Teknor Microsystems
 105Ah	Promise Technology (see #0692)
 105Bh	Foxconn International
 105Ch	Wipro Infotech Ltd.
 105Dh	Number 9 Computer Company (see #0693)
 105Eh	VTech Engineering Canada, Ltd.
 105Fh	Infotronic America, Inc.
 1060h	United Microelectronics (UMC) (see #0694)
 1061h	8x8 (X Tech) (see #0695)
 1062h	Maspar Computer Copr.
 1063h	Ocean Office Automation
 1064h	Alcatel Cit
 1065h	Texas Microsystems
 1066h	PicoPower Technology (see #0696)
 1067h	Mitsubishi Electronics
 1068h	Diversified Technology
 1069h	Mylex Corporation (see #0697)
 106Ah	Aten Research
 106Bh	Apple Computer
 106Ch	Hyundai Electronics America
 106Dh	Sequent
 106Eh	DFI Inc.
 106Fh	City Gate Development, Ltd.
 1070h	Daewoo Telecom Ltd.
 1071h	Mitac
 1072h	GIT Co., Ltd.
 1073h	Yamaha Corporation (see #0698)
 1074h	NexGen Microsystems (see #0699)
 1075h	Advanced Integration Research
 1076h	Chaintech Computer Co. Ltd.
 1077h	Q Logic (see #0700)
 1078h	Cyrix Corporation
 1079h	I-Bus
 107Ah	Networth
 107Bh	Gateway 2000
 107Ch	Goldstar Co. Ltd.
 107Dh	Leadtek Research (see #0701)
 107Eh	Interphase Corporation (see #0702)
 107Fh	Data Technology Corporation (DTC) (see #0703)
 1080h	Contaq Microsystems (see #0704)
 1081h	Supermac Technology
 1082h	EFA Corporation of America
 1083h	Forex Computer Corporation (see #0705)
 1084h	Parador
 1085h	Tulip Computers Int'l BV
 1086h	J. Bond Computer Systems
 1087h	Cache Computer
 1088h	Microcomputer Systems (M) Son
 1089h	Data General Corporation
 108Ah	Bit3 Computer (see #0706)
 108Ch	Elonex PLC (Oakleigh Systems, Inc)
 108Dh	Olicom (see #0707)
 108Eh	Sun Microsystems
 108Fh	Systemsoft Corporation
 1090h	Encore Computer Corporation
 1091h	Intergraph Corporation (see #0708)
 1092h	Diamond Computer Systems
 1093h	National Instruments (see #0709)
 1094h	First International Computers (FIC)
 1095h	CMD Technology, Inc. (see #0710)
 1096h	Alacron
 1097h	Appian Technology (see #0711)
 1098h	Vision / Quantum Designs Ltd (see #0712)
 1099h	Samsung Electronics Co. Ltd.
 109Ah	Packard Bell
 109Bh	Gemlight Computer Ltd.
 109Ch	Megachips Corporation
 109Dh	Zida Technologies
 109Eh	Brooktree Corporation (see #0713)
 109Fh	Trigem Computer Inc.
 10A0h	Meidensha Corporation
 10A1h	Juko Electronics Inc. Ltd.
 10A2h	Quantum Corporation
 10A3h	Everex Systems Inc.
 10A4h	Globe Manufacturing Sales
 10A5h	Racal Interlan
 10A6h	Informtech Industrial Ltd.
 10A7h	Benchmarq Microelectronics
 10A8h	Sierra Semiconductor (see #0714)
 10A9h	Silicon Graphics
 10AAh	ACC Microelectronics (see #0715)
 10ABh	Digicom
 10ACh	Honeywell IASD
 10ADh	Symphony Labs (see #0716)
 10AEh	Cornerstone Technology
 10AFh	Microcomputer Systems
 10B0h	CardExpert Technology
 10B1h	Cabletron Systems, Inc.
 10B2h	Raytheon Company
 10B3h	Databook Inc
 10B4h	STB Systems
 10B5h	PLX Technology (see #0717)
 10B6h	Madge Networks (see #0718)
 10B7h	3com Corporation (see #0719)
 10B8h	Standard Microsystems Corporation (SMC) (see #0720)
 10B9h	Acer Labs Inc. (see #0721)
 10BAh	Mitsubishi Electronics Corp.
 10BBh	Dapha Electronics Corporation
 10BCh	Advanced Logic Research Inc. (ALR)
 10BDh	Surecom Technology (see #0722)
 10BEh	Tseng Labs International Corp. (see #0663)
 10BFh	Most Inc.
 10C0h	Boca Research Inc.
 10C1h	ICM Corp. Ltd.
 10C2h	Auspex Systems Inc.
 10C3h	Samsung Semiconductors
 10C4h	Award Software International Inc.
 10C5h	Xerox Corporation
 10C6h	Rambus Inc.
 10C7h	Media Vision
 10C8h	Neomagic Corporation (see #0723)
 10C9h	DataExpert Corporation
 10CAh	Fujitsu
 10CBh	Omron Corporation
 10CCh	Mentor Arc Inc.
 10CDh	Advanced System Products (see #0724)
 10CEh	Radius Inc.
 10CFh	Citicorp TTI (see #0725)
 10D0h	Fujitsu Limited
 10D1h	Future+ Systems
 10D2h	Molex Incorporated
 10D3h	Jabil Circuit Inc.
 10D4h	Hualon Microelectronics
 10D5h	Autologic Inc.
 10D6h	Cetia
 10D7h	BCM Advanced Research
 10D8h	Advanced Peripherals Labs
 10D9h	Macronix International Co. Ltd
 10DAh	Thomas-Conrad Corporation
 10DBh	Rohm Research
 10DCh	CERN/ECP/EDU (see #0726)
 10DDh	Evans & Sutherland (see #0727)
 10DEh	NVidia Corporation
 10DFh	Emulex Corporation (see #0728)
 10E0h	Integrated Micro Solutions (IMS) (see #0729)
 10E1h	TekRAM Technology Corporation Ltd. (see #0730)
 10E2h	Aptix Corporation
 10E3h	Newbridge Microsystems (see #0731)
 10E4h	Tandem Computers
 10E5h	Micro Industries
 10E6h	Gainbery Computer Products Inc.
 10E7h	Vadem
 10E8h	Applied Micro Circuits Corp. (see #0732)
 10E9h	Alps Electronic Corp. Ltd.
 10EAh	Integraphics Systems (see #0733)
 10EBh	Artist Graphics (see #0734)
 10ECh	Realtek Semiconductor (see #0735)
 10EDh	ASCII Corporation (see #0736)
 10EEh	Xilinx Corporation
 10EFh	Racore Computer Products
 10F0h	Peritek Corporation
 10F1h	Tyan Computer
 10F2h	Achme Computer Inc.
 10F3h	Alaris Inc.
 10F4h	S-MOS Systems
 10F5h	NKK Corporation (see #0737)
 10F6h	Creative Electronic Systems SA
 10F7h	Matsushita Electric Industrial Corp. Ltd.
 10F8h	Altos India Ltd.
 10F9h	PC Direct
 10FAh	Truevision (see #0738)
 10FBh	Thesys Microelectronics
 10FCh	I/O Data Device Inc.
 10FDh	Soyo Technology Corp. Ltd.
 10FEh	Fast Electronic GmbH
 10FFh	N-Cube
 1100h	Jazz Multimedia
 1101h	Initio Corporation (see #0739)
 1102h	Creative Labs
 1103h	Triones Technologies Inc.
 1104h	Rasterops
 1105h	Sigma Designs, Inc.
 1106h	VIA Technologies (see #0740)
 1107h	Stratus Computer
 1108h	Proteon Inc. (see #0741)
 1109h	Cogent Data Technologies (see #0742)
 110Ah	Siemens AG / Siemens Nixdorf AG (see #0743)
 110Bh	Xenon Microsystems
 110Ch	Mini-Max Technology Inc.
 110Dh	ZNyX Corporation
 110Eh	CPU Technology
 110Fh	Ross Technology
 1110h	Powerhouse Systems
 1111h	Santa Cruz Operation (SCO)
 1112h	Rockwell / RNS division of Meret Communications Inc. (see #0744)
 1113h	Accton Technology Corporation
 1114h	Atmel Corporation
 1115h	DuPont Pixel Systems
 1116h	Data Translation
 1117h	Datacube Inc. (see #0745)
 1118h	Berg Electronics
 1119h	Vortex Computersysteme GmbH (see #0746)
 111Ah	Efficient Networks, Inc. (see #0747)
 111Bh	Teledyne Electronic Systems
 111Ch	Tricord Systems, Inc.
 111Dh	Integrated Device Technology
 111Eh	Eldec Corporation
 111Fh	Precision Digital Images
 1120h	EMC Corporation
 1121h	Zilog
 1122h	Multi-tech Systems, Inc.
 1124h	Leutron Vision AG
 1125h	Eurocore
 1126h	Vigra
 1127h	FORE Systems (see #0748)
 1128h	???
 1129h	Firmworks
 112Ah	Hermes Electronics Co.
 112Bh	Linotype - Hell AG
 112Dh	Ravicad
 112Eh	Infomedia MicroElectronics Inc (see #0749)
 112Fh	Imaging Technology (see #0750)
 1130h	Computervision
 1131h	Philips Semiconductors
 1132h	Mitel Corp
 1133h	Eicon Technology Corporation
 1134h	Mercury Computer Systems Inc (see #0751)
 1135h	Fuji Xerox Co Ltd (see #0752)
 1136h	Momentum Data Systems
 1137h	Cisco Systems Inc
 1138h	Ziatech Corporation (see #0753)
 1139h	Dynamic Pictures Inc (see #0754)
 113Ah	FWB Inc
 113Ch	Cyclone Microsystems (PLX) (see #0755)
 113Dh	Leading Edge Products Inc
 113Eh	Sanyo Electric Co
 113Fh	Equinox Systems
 1140h	Intervoice Inc
 1141h	Crest Microsystem Inc (see #0756)
 1142h	Alliance Semiconductor Corp (see #0757)
 1143h	Netpower, Inc.
 1144h	Cincinnati Milacron (see #0758)
 1145h	Workbit Corp
 1146h	Force Computers
 1147h	Interface Corp.
 1148h	Schneider & Koch Co. (see #0759)
 1149h	Win System Corporation
 114Ah	VMIC (see #0760)
 114Bh	Canopus Co.
 114Ch	Annabooks
 114Dh	IC Corporation
 114Eh	Nikon Systems Inc
 114Fh	Digi International / Stargate (see #0761)
 1150h	Thinking Machines Corp.
 1151h	JAE Electronics Inc.
 1152h	Megatek
 1153h	Land Win Electronic Corp.
 1154h	Melco Inc.
 1155h	Pine Technology Ltd.
 1156h	Periscope Engineering
 1157h	Avsys Corporation
 1158h	Voarx R&D Inc. (see #0762)
 1159h	MuTech (see #0763)
 115Ah	Harleguin Ltd.
 115Bh	Parallax Graphics
 115Ch	???
 115Dh	Xircom
 115Eh	Peer Protocols Inc.
 115Fh	???
 1160h	Megasoft Inc.
 1161h	PFU Ltd. (see #0764)
 1162h	OA Laboratory Co Ltd.
 1163h	Creative Labs (see #0765)
 1164h	Advanced Peripherals Tech
 1165h	Imagraph Corporation (see #0766)
 1166h	Pequr Technology Inc.
 1167h	Mutoh Industries, Inc.
 1168h	Thine Electronics Inc
 1169h	???
 116Ah	Polaris Communications
 116Bh	Connectware Inc
 116Ch	???
 116Dh	???
 116Eh	???
 116Fh	Workstation Technology
 1170h	Inventec Corporation
 1171h	Loughborough Sound Images
 1172h	Altera Corporation
 1173h	Adobe Systems
 1174h	Bridgeport Machines
 1175h	Mitron Computer Inc.
 1176h	SBE
 1177h	Silicon Engineering
 1178h	Alfa Inc (see #0767)
 1179h	Toshiba America Info Systems
 117Ah	A-Trend Technology
 117Bh	???
 117Ch	Atto Technology
 117Dh	???
 117Eh	T/R Systems
 117Fh	???
 1180h	Ricoh Co Ltd
 1181h	Telmatics International
 1182h	???
 1183h	Fujikura Ltd
 1184h	Forks Inc
 1185h	Dataworld
 1186h	D-Link System Inc
 1187h	Advanced Technology Laboratories
 1188h	Shima Seiki Manufacturing Ltd.
 1189h	Matsushita Electronics (see #0768)
 118Ah	Hilevel Technology
 118Bh	???
 118Ch	Corollary Inc (see #0769)
 118Dh	BitFlow Inc (see #0770)
 118Eh	Hermstedt GmbH
 118Fh	???
 1190h	???
 1191h	Artop Electric (see #0771)
 1192h	Densan Co. Ltd
 1193h	Zeitnet Inc. (see #0772)
 1194h	Toucan Technology
 1195h	Ratoc System Inc
 1196h	Hytec Electronics Ltd
 1197h	Gage Applied Sciences Inc.
 1198h	Lambda Systems Inc
 1199h	Digital Communications Associates Inc,
 119Ah	Mind Share Inc.
 119Bh	Omega Micro Inc.
 119Ch	Information Technology Inst.
 119Dh	Bug Sapporo Japan
 119Eh	Fujitsu
 119Fh	Bull Hn Information Systems
 11A0h	Convex Computer Corporation
 11A1h	Hamamatsu Photonics K.K.
 11A2h	Sierra Research and Technology
 11A4h	Barco
 11A5h	MicroUnity Systems Engineering, Inc.
 11A6h	Pure Data
 11A7h	Power Computing Corp.
 11A9h	InnoSys Inc. (see #0773)
 11AAh	Actel
 11ABh	Galileo Technology Ltd. (see #0774)
 11ACh	Canon Information Systems
 11ADh	Lite-On Communications Inc
 11AEh	Scitex Corporation Ltd
 11AFh	Pro-Log Corporation
 11B0h	V3 Semiconductor Inc. (see #0775)
 11B1h	Apricot Computers
 11B2h	Eastman Kodak
 11B3h	Barr Systems Inc.
 11B4h	Leitch Technology International
 11B5h	Radstone Technology Plc
 11B6h	United Video Corp
 11B7h	Motorola
 11B8h	Xpoint Technologies Inc
 11B9h	Pathlight Technology Inc. (see #0776)
 11BAh	Videotron Corp
 11BBh	Pyramid Technology
 11BCh	Network Peripherals Inc
 11BDh	Pinnacle Systems Inc.
 11BEh	International Microcircuits Inc
 11C3h	NEC Corporation
 11C4h	Document Technologies Ind.
 11C5h	Shiva Corporatin
 11C7h	D.C.M. Data Systems
 11C8h	Dolphin Interconnect Solutions (see #0777)
 11C9h	MAGMA
 11CAh	LSI Systems Inc
 11CBh	Specialix Research Ltd. (see #0778)
 11CCh	Michels & Kleberhoff Computer GmbH
 11CDh	HAL Computer Systems Inc.
 11DEh	Zoran Corporation
 11DFh	New Wave PDG
 11E0h	???
 11E1h	GEC Plessey Semi Inc.
 11E2h	Samsung Information Systems Americ
 11E3h	Quicklogic Corporation
 11E4h	Second Wave Inc.
 11E5h	IIX Consulting
 11E6h	Mitsui-Zosen System Research
 11E7h	???
 11E8h	Digital Processing Systems Inc.
 11E9h	???
 11EAh	Elsag Bailey
 11EBh	Formation Inc.
 11ECh	Coreco Inc.
 11EDh	Mediamatics
 11EEh	Dome Imaging Systems Inc.
 11EFh	Nicolet Technologies B.V.
 11F0h	Compu-Shack GmbH
 11F1h	Symbios Logic Inc.
 11F2h	Picture Tel Japan K.K.
 11F3h	Keithley Metrabyte
 11F4h	Kinetic Systems Corporation
 11F5h	Computing Devices International
 11F6h	Powermatic Data Systems Ltd.
 11F6h	Compex USA, Inc. (see #0779)
 11F7h	Scientific Atlanta
 11F8h	PMC-Sierra Inc. (see #0780)
 11FEh	RP ??? (see #0781)
 120Eh	Cyclades (see #0782)
 1220h	Ariel Corporation (see #0783)
 122Dh	Aztech Systems Ltd
 1239h	The 3DO Company
 124Dh	Stallion Technologies
 1254h	Linear Systems Ltd.
 125Ch	Aurora Technologies, Inc.
 1275h	Network Appliance
 127Ah	Rockwell Semiconductor Systems
 1296h	Kofax Image Products
 12C5h	Picture Elements, Inc. (see #0784)
 1C1Ch	Symphony (see #0785)
 1DE1h	TekRAM (see #0786)
 3D3Dh	3DLabs (see #0787)
 4005h	Avance Logic, Inc. (see #0788)
 4B10h	Buslogic Inc. (see #0789)
 5333h	S3 (see also #0790)
 5700h	Netpower
 6374h	c't Magazin fuer Computertechnik (see #0791)
 8008h	Quancom Electronic GmbH (see #0792)
 8086h	Intel (see also #0793)
 8800h	Trigem Computer (see #0794)
 8E0Eh	Computone Corporation
 9004h	Adaptec (see #0795)
 907Fh	Atronics (see #0796)
 EDD8h	Ark Logic Inc (see #0797)
Note:	this list, as well as the following per-vendor tables, is somewhat
	  out-of-date.	The current version of the listing can be found in
	  PCICFG.DAT, part of the PCICFG program distributed with the interrupt
	  list.	 (Any volunteers to update this copy?)
SeeAlso: #0798

(Table 0657)
Values for Compaq PCI device code:
 0001h	EISA Bridge
 0002h	ISA Bridge
 1000h	Triflex/PCI CPU Bridge
 2000h	Triflex/PCI CPU Bridge
 3032h	QVision
 3033h	QVision 1280/p
 3034h	QVision 1280
 4000h	Triflex/PCI CPU Bridge
 F130h	ThunderLAN
SeeAlso: #0656

(Table 0658)
Values for Symbios Logic (formerly NCR) PCI device code:
 0001h	PCI revision ID:
	00-0Fh 53C810 (fast SCSI)
	10-1Fh 53C810A (fast SCSI)
	20-2Fh 53C810ALV (fast SCSI)
 0002h	53C820 (fast wide SCSI)
 0003h	PCI revision ID:
	00-0Fh 53C825 (fast wide SCSI)
	10-1Fh 53C825A (Ultra wide SCSI)
 0004h	53C815 (fast SCSI)
 0005h	53C810AP (fast SCSI)
 0006h	PCI revision ID:
	00-0Fh 53C860 (Ultra SCSI)
	10-1Fh 53C860LV (Ultra SCSI)
 000Fh	53C875 (Ultra wide SCSI)
SeeAlso: #0656

(Table 0659)
Values for ATI PCI device code:
 4158h	68800AX (Mach32)
 4354h	215CT222
 4358h	210888CX
 4758h	210888GX (Mach64)
SeeAlso: #0656

(Table 0660)
Values for VLSI Technologies PCI device code:
 0005h	82C592 CPU Bridge
 0006h	82C593 ISA Bridge
 0007h	82C594 Wildcat System Ctrlr
 0008h	VL82C597 Wildcat ISA Bridge
 0009h	82C597
 000Ch	82C541
 000Dh	82C543
 0101h	82C532
 0102h	82C534
 0104h	82C535
 0105h	82C147
 0200h	82C975 RISC GUI Accelerator
 0280h	82C925 RISC GUI Accelerator
SeeAlso: #0656

(Table 0661)
Values for Avance Logic, Inc. (Avance Logics) PCI device code:
 2301h	ALG2301 GUI accelerator
 2302h	ALG2302 GUI accelerator
SeeAlso: #0656,INT 10/AX=4F70h

(Table 0662)
Values for National Semiconductor PCI device code:
 0001h	DP83810 Ethernet
 D001h	NS87410 EIDE controller
SeeAlso: #0656

(Table 0663)
Values for Tseng Labs PCI device code:
 3202h	ET4000/W32p-2
 3205h	ET4000/W32p-B
 3206h	ET4000/W32p-C
 3207h	ET4000/W32p-D
 3208h	ET6000
SeeAlso: #0656

(Table 0664)
Values for Weitek PCI device code:
 9000h	Power9000???
 9001h	Power9001
 9100h	Power9100
SeeAlso: #0656

(Table 0665)
Values for DEC PCI device code:
 0001h	DC21050	DEC BRD PCI-PCI bridge
 0002h	DC21040	Tulip
 0009h	DC21140	Tulip Fast
 000Fh	DEFPA	FDDI
 0014h	DC21041	Tulip Plus
 0016h	DGLPB	ATM
 0019h	DC21143 PCI/Cardbus Ethernet
 0024h	21151	PCI-PCI Bridge
SeeAlso: #0656

(Table 0666)
Values for Cirrus Logic PCI device code:
 00A0h	Cirrus 5430
 00A4h	Cirrus 5434-4
 00A8h	Cirrus 5434-8
 00A8h	Cirrus 5434-8
 00ACh	Cirrus 5436
 00B8h	Cirrus GD5446
 1100h	Cirrus 6729
 1200h	Cirrus 7542
 1202h	Cirrus 7543
 1204h	Cirrus 7541
SeeAlso: #0656

(Table 0667)
Values for IBM PCI device code:
 0002h	MCA Bridge
 0005h	Alta Lite CPU Bridge
 0007h	Alta MP CPU Bridge
 000Ah	ISA Bridge
 0017h	CPU Bridge
 0018h	Auto LANStreamer
 001Bh	GXT-150P Graphics Adapter
 001Dh	82G2675
 0020h	MCA Bridge
 0022h	PCI-PCI Bridge
 0036h	Miami/PCI  32-bit LocalBus Bridge
 0047h	???
 0048h	???
 004Ah	???
 004Bh	???
 004Ch	???
 004Dh	???
 004Eh	???
 004Fh	???
 0050h	???
 0051h	???
 0052h	???
 0053h	???
 0055h	???
 0059h	???
 005Ah	???
 005Bh	???
SeeAlso: #0656

(Table 0668)
Values for Western Digital PCI device code:
 0193h	WD33C193A 8-bit SCSI
 0196h	SCSI Bridge
 0197h	WD33C197A 16-bit SCSI
 0296h	WD33C296A 16-bit SCSI
 3193h	WD7193 Fast SCSI-II
 3197h	WD7197 Fast-Wide SCSI-II
 3296h	WD7197
 4296h	WD33C296 Wide Fast-20 Bridge
 C24Ah	90C?
SeeAlso: #0656

(Table 0669)
Values for AMI PCI device code:
 9010h	MegaRAID
 9030h	??? IDE Controller
 9031h	??? IDE Controller
 9032h	??? IDE/SCSI Controller
 9033h	??? SCSI Controller
 9040h	??? Multimedia card
SeeAlso: #0656

(Table 0670)
Values for Advanced Micro Devices (AMD) PCI device code:
 2000h	Am79C970 (Lance)
	Am79C970A (PCnet-PCI II, PCI revision ID is 1xh)
	Am79C971 (PCnet-FAST, PCI revision ID is 2xh)
 2020h	Am53c974 SCSI (see #0823)
 2040h	Am79C974 Ethernet/SCSI
SeeAlso: #0656

(Table 0671)
Values for Trident PCI device code:
 9320h	??? 32-bit GUI accelerator
 9350h	??? 32-bit GUI accelerator
 9360h	??? Flat-Panel controller
 9420h	Trident 9420
 9440h	Trident 9440
 9460h	Trident 9460
 9660h	Trident 9660
 9682h	??? Multimedia accelerator
SeeAlso: #0656

(Table 0672)
Values for LSI Logic PCI device code:
 0000h	Hydra (Pentium chipset)
 0010h	Aspen (486 chipset)
SeeAlso: #0656

(Table 0673)
Values for Matrox PCI device code:
 0518h	MGA-II (Ultima)
 0519h	Millenium (2064W)
 0D10h	MGA-I (Impression)
SeeAlso: #0656

(Table 0674)
Values for Chips & Technologies PCI device code:
 00B8h	C&T 64310 GUI Accelerator
 00D0h	C&T 65545 Flat Panel/CRT VGA
 00D8h	F65545
 00DCh	F65548
SeeAlso: #0656

(Table 0675)
Values for Toshiba America PCI device code:
 0009h	r4x00 Bridge
SeeAlso: #0656

(Table 0676)
Values for Miro / Micro Computer Products AG PCI device code:
 5601h	36050
 5607h	video in/out w/ MPEG
SeeAlso: #0656

(Table 0677)
Values for NEC Corporation PCI device code:
 0001h	PCI-to-486 Bridge
 0002h	PCI-to-VL98 Bridge
 0003h	ATM LAN controller
 0004h	r4000PCI Bridge
 0005h	PCI-to-486 Bridge
 0006h	GUI Accelerator
 0007h	PCI-to-UXbus Bridge
 0008h	GUI Accelerator
 0009h	PC-98 Graphics Controller
SeeAlso: #0656

(Table 0678)
Values for Future Domain PCI device code:
 0000h	TMC-36C70 / TMC-18C30 (fast SCSI)
SeeAlso: #0656

(Table 0679)
Values for Silicon Integrated System (SIS) PCI device code:
 0001h	SiS6201
 0002h	SiS6202
 0006h	SI 85C501/2
 0008h	SI 85C503/5513
 0205h	SiS6205
 0406h	SiS501
 0496h	SiS496
 0596h	Pentium chipset
 0601h	SiS601
 3602h	IDE controller
 5401h	486 chipset
 5511h	SiS5511 Pentium chipset
 5513h	SiS5513 EIDE controller
 5581h	Pentium chipset
 5582h	ISA Bridge
 5596h	Pentium chipset
 6204h	video decoder/MPEG
 6205h	PCI VGA controller
SeeAlso: #0656

(Table 0680)
Values for Hewlett-Packard PCI device code:
 1030h	J2585A DeskDirect 10/100 PCI NIC
 1040h	J2973A DeskDirect 10BaseT PCI NIC
 1041h	J2585B DeskDirect 10/100 PCI NIC
 1042h	J2970A DeskDirect 10BaseT/2 PCI NIC
 2910h	E2910A PCI-bus exerciser
 2925h	E2925A PCI-bus exerciser
SeeAlso: #0656

(Table 0681)
Values for PC Technology PCI device code:
 1000h	RZ1000
 1001h	RZ1001
SeeAlso: #0656

(Table 0682)
Values for Distributed Processing Technology (DPT) PCI device code:
 A400h	2124A/9X EATA SmartCache/RAID SCSI
SeeAlso: #0656

(Table 0683)
Values for OPTi PCI device code:
 A0F8h	82C750 (Vendetta) USB controller
 C557h	82C557
 C558h	82C558
 C567h	82C750 (Vendetta, device 0)
 C568h	82C750 (Vendetta, device 1)
 C621h	82C621 IDE controller
 C822h	82C822
 C824h	82C824 FireFox PC-Card controller
 C825h	82C825 FireBridge II
SeeAlso: #0656

(Table 0684)
Values for SGS Thomson Microelectronics PCI device code:
 0008h	SGS 2000
 0009h	SGS 1764
SeeAlso: #0656

(Table 0685)
Values for BusLogic PCI device code:
 0140h	MultiMaster NC
 1040h	MultiMaster
 8130h	FlashPoint
SeeAlso: #0656

(Table 0686)
Values for Texas Instruments PCI device code:
 0500h	100 Mbit LAN controller
 0508h	tms380c2x
 1000h	TI PCI Eagle i/f
 A001h	TDC1570	 64-bit ATM sar
 A100h	TDC1561	 32-bit ATM sar
 AC10h	PCI1050	 PCCard controller
 AC11h	PCI1053	 PCCard controller
 AC12h	PCI1130	 PCCard controller
SeeAlso: #0656

(Table 0687)
Values for Oak Technology PCI device code:
 0107h	OTI-0107 (Spitfire)
SeeAlso: #0656

(Table 0688)
Values for Winbond PCI device code:
 0000h	??? Ethernet controller
 0001h	83769
 0105h	82C105
SeeAlso: #0656

(Table 0689)
Values for Hitachi Ltd. PCI device code:
 0001h	PCI Bridge
 0002h	PCI-bus controller
SeeAlso: #0656

(Table 0690)
Values for EFAR Microsystems PCI device code:
 0810h	486 Bridge
 0922h	Pentium/P54C Bridge
 0926h	ISA Bridge
SeeAlso: #0656

(Table 0691)
Values for Motorola PCI device code:
 0001h	MPC105 PowerPC chipset
SeeAlso: #0656

(Table 0692)
Values for Promise Technology PCI device code:
 5300h	Promise 5300
SeeAlso: #0656

(Table 0693)
Values for Number 9 Computer Company PCI device code:
 2309h	Imagine 128
 2339h	Imagine 128-2
SeeAlso: #0656

(Table 0694)
Values for United Microelectronics (UMC) PCI device code:
 0001h	UM82C881 (486 chipset)
 0002h	UM82C776 (ISA Bridge)
 0101h	UM8673F
 0881h	UM8881 (486 chipset)
 0886h	UM8886F (ISA Bridge)
 0891h	UM8891A
 1001h	UM886A (dual IDE controller)
 673Ah	UM8886BF
 8710h	UM8710 VGA controller
 886Ah	UM8886A
 8881h	UM8881F
 8886h	UM8886F
 8891h	UM8891 (Pentium chipset)
 9017h	UM9017F
 E881h	UM8881 (486 chipset)
 E886h	UM8886N
 E891h	UM8891N
SeeAlso: #0656

(Table 0695)
Values for 8x8 (X Tech) PCI device code:
 0001h	AGX-016
 0002h	IIT3204/3501 MPEG decoder
SeeAlso: #0656

(Table 0696)
Values for PicoPower PCI device code:
 0000h	PT80C826 VL Bridge
 0001h	Vesuvius V1-LS System Controller
 0002h	Vesuvius V3-LS ISA Bridge
 8002h	Vesuvius V3-LS ISA Bridge
SeeAlso: #0656

(Table 0697)
Values for Mylex Corporation PCI device code:
 0001h	DAC960P Wide SCSI + RAID
SeeAlso: #0656

(Table 0698)
Values for Yamaha Corporation PCI device code:
 0001h	?? 3D graphics controller
 0002h	YGV615	RPA3 3D graphics controller
SeeAlso: #0656

(Table 0699)
Values for NexGen Microsystems PCI device code:
 4E78h	NexGen 82C501
SeeAlso: #0656

(Table 0700)
Values for Q Logic PCI device code:
 1020h	ISP1020 Fast-Wide SCSI
 1022h	ISP1022 Fast-Wide SCSI
SeeAlso: #0656

(Table 0701)
Values for Leadtek Research PCI device code:
 0000h	LeadTek 805
SeeAlso: #0656

(Table 0702)
Values for Interphase PCI device code:
 0001h	ATM interface
 0002h	100 vg amylan controller
SeeAlso: #0656

(Table 0703)
Values for Data Technology Corporation (DTC) PCI device code:
 0802h	SL82C105  EIDE Controller
SeeAlso: #0656

(Table 0704)
Values for Contaq Microsystems PCI device code:
 0600h	Contaq 82C599
SeeAlso: #0656

(Table 0705)
Values for Forex Computer Corporation PCI device code:
 0001h	FR710  EIDE Controller
 0613h	??? Host Bridge
SeeAlso: #0656

(Table 0706)
Values for Bit3 Computer PCI device code:
 0001h	Model 617  PCI-VME Bus Adapter
SeeAlso: #0656

(Table 0707)
Values for Olicom PCI device code:
 0001h	??? Ethernet Controller
SeeAlso: #0656

(Table 0708)
Values for Intergraph Corporation PCI device code:
 0020h	3D graphics processor
 0021h	3D graphics processor w/texture
 0040h	3D graphics frame buffer
 0041h	3D graphics frame buffer
 0060h	proprietary bus bridge
 0720h	Motion JPEG codec
SeeAlso: #0656

(Table 0709)
Values for National Instruments PCI device code:
 C801h	PCI-GPIB
SeeAlso: #0656

(Table 0710)
Values for CMD Technology, Inc. PCI device code:
 0640h	CMD 640
 0642h	IDE controller with RAID-1
 0646h	CMD 646 EIDE
 0650h	PBC0650A Fast SCSI-II
SeeAlso: #0656

(Table 0711)
Values for Appian Technology:
 0038h	??? EIDE Controller
SeeAlso: #0656

(Table 0712)
Values for Vision / Quantum Designs Ltd. PCI device code:
 0001h	QD8500
 0002h	QD8580
SeeAlso: #0656

(Table 0713)
Values for Brooktree Corporation PCI device code:
 0350h	BT848  TV/PCI with DMA Push
 2115h	BtV 2115 Mediastream Controller
 2125h	BtV 2125 Mediastream Controller
 8230h	???
SeeAlso: #0656

(Table 0714)
Values for Sierra Semiconductor PCI device code:
 0000h	STB 64-bit GUI accelerator
SeeAlso: #0656

(Table 0715)
Values for ACC Microelectronics PCI device code:
 0000h	ACC 2056
SeeAlso: #0656

(Table 0716)
Values for Symphony Labs PCI device code:
 0001h	83769
 0103h	sl82c103 PCI-IDE Controller
 0105h	82C105 bus-master PCI-IDE controller
SeeAlso: #0656

(Table 0717)
Values for PLX Technology PCI device code:
 9036h	PCI9036 interface chip
 9060h	PCI9060xx interface chip
SeeAlso: #0656

(Table 0718)
Values for Madge Networks PCI device code:
 0001h	Smart 16/4 Ringnode
 1000h	Collage 25 ATM adapter
 1001h	Collage 155 ATM adapter
SeeAlso: #0656

(Table 0719)
Values for 3com Corporation PCI device code:
 5900h	3C590
 5950h	3C595TX
 5951h	3C595T4
 5952h	3C595MII
 8811h	token ring
 9000h	3C900-TPO Fast Etherlink
 9001h	3C900-COMBO Fast Etherlink
 9050h	3C905-TX Fast Etherlink 10/100
SeeAlso: #0656

(Table 0720)
Values for Standard Microsystems Corporation (SMC) PCI device code:
 1000h	37C665 floppy disk controller
 1001h	37C922 floppy disk controller
SeeAlso: #0656

(Table 0721)
Values for Acer Labs Inc. PCI device code:
 1435h	M1435 VL Bridge
 1445h	ALI M1445 VL bridge + EIDE
 1449h	ALI M1449 ISA bridge
 1451h	ALI M1451 Pentium chipset
 1461h	ALI M1461 P54C chipset
 1489h	ALI M1489
 1511h	ALI M1511
 1513h	ALI M1513
 3141h	M3141 GUI accelerator VRAM
 3143h	M3143 GUI accelerator VRAM/DAC
 3145h	M3145 GUI accelerator VRAM
 3147h	M3147 GUI accelerator VRAM/DAC
 3149h	M3149 GUI accelerator VRAM
 3151h	M3151 GUI accelerator VRAM
 5212h	M4803
 5215h	ALI MS4803 EIDE controller
 5217h	m5217 I/O
 5219h	m5219 I/O
 5235h	m5225 I/O
SeeAlso: #0656

(Table 0722)
Values for Surecom Technology PCI device code:
 5240h	IDE Controller
 5241h	PCMCIA Bridge
 5242h	general-purpose controller
 5243h	Bus controller
 5244h	Floppy-disk controller
SeeAlso: #0656

(Table 0723)
Values for Neomagic Corporation:
 0000h	graphics controller
SeeAlso: #0656

(Table 0724)
Values for Advanced System Products PCI device code:
 1100h	ABP940 revision A??? SCSI
 1200h	ABP940 revision B??? Fast SCSI-2
 1300h	Fast-Wide SCSI controller
SeeAlso: #0656

(Table 0725)
Values for Citicorp TTI PCI device code:
 2001h	mb86605 Wide SCSI-2
SeeAlso: #0656

(Table 0726)
Values for CENR/ECP/EDU PCI device code:
 0001h	SPSB PMC
 0002h	SPSB PCI
 10DCh	ATT 2C15-3 FPGA
SeeAlso: #0656

(Table 0727)
Values for Evans & Sutherland PCI device code:
 0001h	3D graphics processor
SeeAlso: #0656

(Table 0728)
Values for Emulex Corporation PCI device code:
 1AE5h	Fibre Channel Host Adapter
SeeAlso: #0656

(Table 0729)
Values for Integrated Micro Solutions PCI device code:
 5026h	IMS5026/27/28 VL Bridge
 5028h	ISA Bridge
 8849h	IMS 8849
 8853h	ATM network card
 9128h	IMS9129 GUI accelerator
SeeAlso: #0656

(Table 0730)
Values for TekRAM Technology Corporation Ltd. PCI device code:
 690Ch	TekRAM 690c
SeeAlso: #0656

(Table 0731)
Values for Newbridge Microsystems PCI device code:
 0000h	CA91C042 VMEbus Bridge
SeeAlso: #0656

(Table 0732)
Values for Applied Micro Circuits Corp. PCI device code:
 4750h	S5933 PCI controller
 8043h	MyriNet
SeeAlso: #0656

(Table 0733)
Values for Integraphics Systems PCI device code:
 1680h	1680
SeeAlso: #0656

(Table 0734)
Values for Artist Graphics PCI device code:
 0101h	3GA 64-bit graphics processor
SeeAlso: #0656

(Table 0735)
Values for Realtek Semiconductor PCI device code:
 8029h	Realtek 8029
SeeAlso: #0656

(Table 0736)
Values for ASCII Corporation PCI device code:
 7310h	V7310 VGA Video Overlay
SeeAlso: #0656

(Table 0737)
Values for NKK Corporation PCI device code:
 A001h	NDR4000	  NR4600 Bridge
SeeAlso: #0656

(Table 0738)
Values for Truevision PCI device code:
 0000h	??? GUI Accelerator
 0001h	??? GUI Accelerator
 0002h	??? GUI Accelerator
 0003h	??? GUI Accelerator
 0004h	??? GUI Accelerator
 0005h	??? GUI Accelerator
 0006h	??? GUI Accelerator
 0007h	??? GUI Accelerator
 0008h	??? GUI Accelerator
 0009h	??? GUI Accelerator
 0010h	??? GUI Accelerator
 0011h	??? GUI Accelerator
 0012h	??? GUI Accelerator
 0013h	??? GUI Accelerator
 0014h	??? GUI Accelerator
 0015h	??? GUI Accelerator
SeeAlso: #0656

(Table 0739)
Values for Initio Corporation PCI device code:
 9100h	320P
 9400h	Fast-Wide SCSI
 9700h	Fast-Wide SCSI
SeeAlso: #0656

(Table 0740)
Values for VIA Technologies PCI device code:
 0505h	VIA 82C505
 0561h	VIA 82C561
 0571h	AMD-645 Peripheral Bus Controller, function 1 (see #0844)
 0576h	VIA 82C576
 0586h	AMD-645 Peripheral Bus Controller, function 0 (see #0845)
 0595h	AMD-640 System Controller (see #0846)
 1000h	82C570MV P54 Controller
 1106h	82C570MV ISA Bridge + IDE
 1571h	VIA 82C416
 3038h	AMD-645 Peripheral Bus Controller, function 2 (see #0847)
 3040h	AMD-645 Peripheral Bus Controller, function 3 (see #0848)
SeeAlso: #0656

(Table 0741)
Values for Proteon Inc. PCI device code:
 0100h	p1690plus-AA  Token Ring
 0101h	p1690plus-AB 2-port Token Ring
SeeAlso: #0656

(Table 0742)
Values for Cogent Data Technologies PCI device code:
 1400h	EM110TX PCI Fast Ethernet
SeeAlso: #0656

(Table 0743)
Values for Siemens Nixdorf PCI device code:
 6120h	SZB6120 Multimedia Adapter
SeeAlso: #0656

(Table 0744)
Values for Rockwell PCI device code:
 2200h	FDDI adapter
 2300h	Fast Ethernet adapter
 2340h	four-port Fast Ethernet
 2400h	ATM adapter
SeeAlso: #0656

(Table 0745)
Values for Datacube Inc. PCI device code:
 9500h	MAX-LC SuperVGA
 9501h	MAX-LC image processing
SeeAlso: #0656

(Table 0746)
Values for Vortex Computersysteme GmbH PCI device code:
 0000h	GDT60x0 SCSI RAID
 0001h	GDT6000B SCSI RAID
 0002h	GDT6x10 SCSI RAID
 0003h	GDT6x20 two-channel SCSI RAID
 0004h	GDT6530 three-channel SCSI RAID
 0005h	GDT6550 five-channel SCSI RAID
 0006h	GDT6x17
 0007h	GDT6x27
 0008h	GDT6537
 0009h	GDT6557
 000Ah	GDT6x15
 000Bh	GDT6x25
 000Ch	GDT6535
 000Dh	GDT6555
SeeAlso: #0656

(Table 0747)
Values for Efficient Networks, Inc. PCI device code:
 0000h	155P-MF1 ATM FPGA
 0002h	ATM ASIC
SeeAlso: #0656

(Table 0748)
Values for FORE Systems PCI device code:
 0210h	PCA200PC
 0300h	PCA200E
SeeAlso: #0656

(Table 0749)
Values for Infomedia MicroElectronics PCI device code:
 0000h	EIDE/HD and IDE/CD-ROM controller
 000Bh	EIDE/HD and IDE/CD-ROM controller
SeeAlso: #0656

(Table 0750)
Values for Imaging Technology PCI device code:
 0000h	ICPCI
 0001h	video frame grabber/processor
SeeAlso: #0656

(Table 0751)
Values for Mercury Computer Systems PCI device code:
 0001h	Raceway Bridge
SeeAlso: #0656

(Table 0752)
Values for Fuji Xerox Co Ltd. PCI device code:
 0001h	Printer Controller
SeeAlso: #0656

(Table 0753)
Values for Ziatech Corporation PCI device code:
 8905h	8905 STD-32 Bridge
SeeAlso: #0656

(Table 0754)
Values for Dynamic Pictures Inc. PCI device code:
 0001h	VGA-compatible 3D graphics
SeeAlso: #0656

(Table 0755)
Values for Cyclone Microsystems (PLX Technology???) PCI device code:
 0001h	PLX 9060
 0911h	PCI 911	 i960Jx Intelligent I/O
 0912h	PCI 912	 i960Cx Intelligent I/O
 0913h	PCI 913	 i960Hx Intelligent I/O
SeeAlso: #0656

(Table 0756)
Values for Crest Microsystem PCI device code:
 0001h	EIDE/ATAPI super adapter
SeeAlso: #0656

(Table 0757)
Values for Alliance Semiconductor Corp. PCI device code:
 3210h	Pro Motion 3210
 6410h	GUI Accelerator
 6412h	GUI Accelerator
 6420h	GUI Accelerator
 6422h	Pro Video
 6424h	GUI Accelerator
 6426h	GUI Accelerator
SeeAlso: #0656

(Table 0758)
Values for Cincinnati Milacron PCI device code:
 0001h	Noservo Controller
SeeAlso: #0656

(Table 0759)
Values for Schneider & Koch Co. PCI device code:
 4000h	FDDI adapter
SeeAlso: #0656

(Table 0760)
Values for VMIC PCI device code:
 7587h	VME
SeeAlso: #0656

(Table 0761)
Values for Digi International / Stargate PCI device code:
 0003h	RightSwitch
SeeAlso: #0656

(Table 0762)
Values for Voarx R&D Inc. PCI device code:
 3011h	Tokenet/vg 1001/10m anylan
 9050h	Lanfleet/Truevalue
SeeAlso: #0656

(Table 0763)
Values for MuTech PCI device code:
 0001h	MV1000
SeeAlso: #0656

(Table 0764)
Values for PFU Ltd. PCI device code:
 0001h	Host Bridge
SeeAlso: #0656

(Table 0765)
Values for Creative Labs (vendor ID 1163h) PCI device code:
 0001h	3D Blaster
SeeAlso: #0656

(Table 0766)
Values for Imagraph Corporation PCI device code:
 0001h	Motion JPEG record/play w/ audio
SeeAlso: #0656

(Table 0767)
Values for Alfa Inc. PCI device code:
 AFA1h	Fast Ethernet
SeeAlso: #0656

(Table 0768)
Values for Matsushita Electronics PCI device code:
 1592h	???
SeeAlso: #0656

(Table 0769)
Values for Corollary Inc. PCI device code:
 0014h	PCIB  C-bus II to PCI bridge chip
SeeAlso: #0656

(Table 0770)
Values for BitFlow Inc. PCI device code:
 0001h	Raptor-PCI frame grabber
SeeAlso: #0656

(Table 0771)
Values for Artop Electric PCI device code:
 0001h	IDE controller
 0002h	IDE controller
 0003h	SCSI-2 cache controller
 0004h	ATP8400 ASIC cache accelerator
 8001h	SCSI-2 cache controller
 8002h	SCSI-2 controller
SeeAlso: #0656

(Table 0772)
Values for Zeitnet Inc. PCI device code:
 0001h	Zeitnet 1221
 0002h	Zeitnet 1225
SeeAlso: #0656

(Table 0773)
Values for InnoSys Inc. PCI device code:
 4240h	AMCC S5933Q Intelligent Serial Card
SeeAlso: #0656

(Table 0774)
Values for Galileo Technology PCI device code:
 0146h	GT-64010 System Controller for R46xx CPU
 4801h	GT-48001 8-port switched Ethernet ctrlr
SeeAlso: #0656

(Table 0775)
Values for V3 Semiconductor Inc. PCI device code:
 0292h	V292PBC	 Am29030/40 Bridge
 0960h	V96xPBC	 i960 Bridge
 C960h	V96DPC	 i960 dual PCI Bridge
SeeAlso: #0656

(Table 0776)
Values for Pathlight Technology PCI device code:
 C0EDh	SSA Controller
SeeAlso: #0656

(Table 0777)
Values for Dolphin Interconnect Solutions PCI device code:
 0658h	PSB  PCI-SCI Bridge
SeeAlso: #0656

(Table 0778)
Values for Specialix Research Ltd. PCI device code:
 2000h	PCI-9050 Target Interface
 4000h	Specialix XIO (SUPI-1 Target Interface)
 8000h	Specialix RIO (T255 Bridge)
SeeAlso: #0656

(Table 0779)
Values for Compex USA, Inc. PCI device code:
 1401h	ReadyLINK RL2000 10MBit NIC
SeeAlso: #0656

(Table 0780)
Values for PMC-Sierra Inc. PCI device code:
 7375h	PM7375 LASAR-155 ATM SAR
SeeAlso: #0656

(Table 0781)
Values for RP PCI device code:
 0001h	RP8OCTA
 0002h	RP8INTF
 0003h	RP16INTF
 0004h	RP32INTF
SeeAlso: #0656

(Table 0782)
Values for Cyclades PCI device code:
 0100h	Cyclom Y Lo multiport serial card
 0101h	Cyclom Y Hi
 0200h	Cyclom Z Lo multiport serial card
 0201h	Cyclom Z Hi
SeeAlso: #0656

(Table 0783)
Values for Ariel Corporation PCI device code:
 1220h	AMCC 5933  TMS320C80 DSP/Imaging Board
SeeAlso: #0656

(Table 0784)
Values for Picture Elements PCI device code:
 0081h	PCIVST	PCI Thresholding Engine
SeeAlso: #0656

(Table 0785)
Values for Symphony PCI device code:
 0001h	Symphony 82C101 IDE controller
SeeAlso: #0656

(Table 0786)
Values for TekRAM PCI device code:
 DC29h	DC290 / DC290M EIDE controller
SeeAlso: #0656

(Table 0787)
Values for 3DLabs PCI device code:
 0004h	3C0SX GUI Accelerator
SeeAlso: #0656

(Table 0788)
Values for Avance Logic, Inc. PCI device code:
 2301h	AVL2301 GUI Accelerator
 2303h	AVG2302 GUI Accelerator
SeeAlso: #0656

(Table 0789)
Values for BusLogic Inc. PCI device code:
 3080h	??? SCSI-ti
 4010h	??? Fast-Wide SCSI-2
SeeAlso: #0656

(Table 0790)
Values for S3 PCI device code:
 5631h	86C325 ViRGE 3D GUI Accelerator
 8800h	Vision 866
 8801h	Vision 964
 8810h	S3 Trio32
 8811h	S3 Trio32, Trio64, or Trio64V+
 8812h	S3 Trio64UV+
 8813h	S3 Trio64? v3
 888xh	S3 868
 88Bxh	S3 928
 88C0h	S3 864-1
 88C1h	S3 864-2
 88C2h	S3 864-3
 88C3h	S3 864-4
 88D0h	S3 964-1
 88D1h	S3 964-2
 88D2h	S3 964-3
 88D3h	S3 964-4
 88F0h	S3 968
 88F1h	S3 968-2
 88F2h	S3 968-3
 88F3h	S3 968-3
 8901h	S3 775 Trio64V2
SeeAlso: #0656,#0793

(Table 0791)
Values for c't Magazin fÅr Computer PCI device code:
 6773h	GPPCI  PCI interface
SeeAlso: #0656

(Table 0792)
Values for Quancom Electronic PCI device code:
 0010h	PCI-WDOG1 Watchdog
 0011h	PWDOG2 Watchdog2/PCI
SeeAlso: #0656

(Table 0793)
Values for Intel PCI device code:
 0482h	82375EB/SB PCI-EISA Bridge (see #0850)
 0483h	82424 Cache Controller (see #0859)
 0484h	82378/82379 Bus Interface (Mercury/Saturn/Neptune chipsets) (see #0860)
 0486h	82425EX/82430
 04A3h	82434 LX (Mercury) / NX (Neptune) (see #0851)
 0960h	i960 RP Microprocessor/Bridge
 1221h	82092AA PCMCIA Bridge
 1222h	82092AA IDE Controller
 1223h	Intel SAA7116
 1226h	82596
 1227h	82865
 1228h	EtherExpress Pro/100 Smart
 1229h	82557 Fast Ethernet (see #0925)
 122Dh	82437FX (Triton)
 122Eh	82371FB ISA Bridge (Triton)
 1230h	82338 IDE controller / 82371FB IDE function (Triton)
 1234h	82371MX
 1235h	82437MX
 1237h	82441FX (see #0927)
 1239h	82371FB IDE Interface (Triton)
 123Ch	82380AB Mobile PCI-to-ISA Bridge (see #0886)
 124Bh	82380FB Mobile PCI-to-PCI Bridge (see #3709)
 1250h	82439HX (430HX chipset) (see #0888)
 1960h	80960RP i960RP Microprocessor
 7000h	82371SB ISA Bridge (see #0911)
 7010h	82371SB IDE controller (see #0912)
 7020h	82371SB (see #0913)
 7030h	82437VX (430VX chipset) (see #0892)
 7100h	82439TX (430TX chipset) (see #0889)
 7110h	82371AB PIIX4 ISA Bridge
 84C4h	82450KX/GX PCI Bridge (Orion) (see #0938)
 84C5h	82450KX/GX Memory Ctrlr (Orion)
SeeAlso: #0656,#0790

(Table 0794)
Values for Trigem Computer PCI device code:
 2008h	video assistant
SeeAlso: #0656

(Table 0795)
Values for Adaptec PCI device code:
 1078h	AIC-7810C RAID Coprocessor
 5078h	x940 Fast-Wide SCSI-II Ctrlr
 5578h	AHA-2830P SCSI Controller
 7078h	AHA-294x/AIC-7870P Fast-Wide SCSI-II
 7178h	AHA-2940 Fast-Wide SCSI-II
 7278h	x940 two-channel Fast-Wide SCSI
 7378h	AHA-3985 4-channel RAID SCSI
 7478h	AHA-2944 SCSI
 7810h	AIC-7810 memory control IC
 7850h	AIC-7850 SCSI IC
 7855h	AHA-2930 SCSI
 7870h	AIC-7870 SCSI IC
 7871h	AHA-2940
 7872h	AHA-3940
 7873h	AHA-3980
 7874h	AHA-2944 Differential SCSI
 7880h	AIC-7880 Fast-20 SCSI
 8078h	Adaptec 7880
 8178h	Adaptec 2940UW
 8278h	AHA-3940U/UW
 8378h	Adaptec 7883
 8478h	Adaptec 7884
SeeAlso: #0656

(Table 0796)
Values for Atronics PCI device code:
 2015h	Atronics 2015
SeeAlso: #0656

(Table 0797)
Values for Ark Logic Inc. PCI device code:
 A091h	ARK 1000PV ??? Stingray
 A099h	ARK 2000PV ??? Stingray
 A0A1h	ark2000mt 64-bit GUI Accel w/DCI
SeeAlso: #0656
--------X-1AB103-----------------------------
INT 1A - PCI BIOS v2.0c+ - FIND PCI CLASS CODE
	AX = B103h
	ECX = class code (see also #F059,#0798)
	    bits 31-24 unused
	    bits 23-16 class
	    bits 15-8  subclass
	    bits 7-0   programming interface
	SI = device index (0-n)
Return: CF clear if successful
	CF set on error
	AH = status (00h,86h) (see #0653)
	    00h successful
		BH = bus number
		BL = device/function number (bits 7-3 device, bits 2-0 func)
	    86h device not found
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
	all devices sharing the same Class Code may be enumerated by
	  incrementing SI from 0 until error 86h is returned
SeeAlso: AX=B183h
--------X-1AB106-----------------------------
INT 1A - PCI BIOS v2.0c+ - PCI BUS-SPECIFIC OPERATIONS
	AX = B106h
	BL = bus number
	EDX = Special Cycle data
Return: CF clear if successful
	CF set on error
	AH = status (00h,81h) (see #0653)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Note:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
SeeAlso: AX=B186h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB108-----------------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION BYTE
	AX = B108h
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	BH = bus number
	DI = register number (0000h-00FFh) (see #0798)
Return: CF clear if successful
	    CL = byte read
	CF set on error
	AH = status (00h,87h) (see #0653)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B109h,AX=B10Ah,AX=B188h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB109-----------------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION WORD
	AX = B109h
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	BH = bus number
	DI = register number (0000h-00FFh, must be multiple of 2) (see #0798)
Return: CF clear if successful
	    CX = word read
	CF set on error
	AH = status (00h,87h) (see #0653)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B108h,AX=B10Ah,AX=B189h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10A-----------------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD
	AX = B10Ah
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh, must be multiple of 4) (see #0798)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #0653)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B108h,AX=B109h,AX=B10Ah/SF=8086h,AX=B18Ah,INT 2F/AX=1684h/BX=304Ch

Format of PCI Configuration Data:
Offset	Size	Description	(Table 0798)
 00h	WORD	vendor ID (read-only) (see #0656 at AX=B102h)
		FFFFh returned if requested device non-existent
 02h	WORD	device ID (read-only)
 04h	WORD	command register (see #0799)
 06h	WORD	status register (see #0800)
 08h	BYTE	revision ID
 09h  3 BYTEs	class code
		bits 7-0: programming interface
		bits 15-8: sub-class
		bits 23-16: class code (see also #F059)
 0Ch	BYTE	cache line size
 0Dh	BYTE	latency timer
 0Eh	BYTE	header type
		bits 6-0: header format
			00h other
			01h PCI-to-PCI bridge
			02h PCI-to-CardBus bridge
		bit 7: multi-function device
 0Fh	BYTE	Built-In Self-Test result (see #0801)
---header type 00h---
 10h	DWORD	base address 0 (see #0802)
		(OpenHCI) base address of host controller registers (see #0827)
 14h	DWORD	base address 1
 18h	DWORD	base address 2
 1Ch	DWORD	base address 3
 20h	DWORD	base address 4
 24h	DWORD	base address 5
 28h	DWORD	CardBus CIS pointer (read-only) (see #0809)
 2Ch	WORD	subsystem vendor ID or 0000h
 2Eh	WORD	subsystem ID or 0000h
 30h	DWORD	expansion ROM base address (see #0803)
 34h	BYTE	offset of capabilities list within configuration space (R/O)
		(only valid if status register bit 4 set) (see #0804)
 35h  3 BYTEs	reserved
 38h	DWORD	reserved
 3Ch	BYTE	interrupt line
		00h = none, 01h = IRQ1 to 0Fh = IRQ15
 3Dh	BYTE	interrupt pin (read-only)
		(00h = none, else indicates INTA# to INTD#)
 3Eh	BYTE	minimum time bus master needs PCI bus ownership, in 250ns units
		(read-only)
 3Fh	BYTE	maximum latency, in 250ns units (bus masters only) (read-only)
 40h 48 DWORDs	varies by device (see #0821,#0822,#0851,#0879)
---header type 01h---
 10h	DWORD	base address 0 (see #0802)
 14h	DWORD	base address 1
 18h	BYTE	primary bus number (for bus closer to host processor)
 19h	BYTE	secondary bus number (for bus further from host processor)
 1Ah	BYTE	subordinate bus number
 1Bh	BYTE	secondary latency timer
 1Ch	BYTE	I/O base (see #0819)
 1Dh	BYTE	I/O limit (see #0819)
 1Eh	WORD	secondary status
 20h	WORD	memory base (see #0820)
 22h	WORD	memory limit
 24h	WORD	prefetchable memory base
 26h	WORD	prefetchable memory limit
 28h	DWORD	prefetchable base, upper 32 bits
 2Ch	DWORD	prefetchable limit, upper 32 bits
 30h	WORD	I/O base, upper 16 bits
 32h	WORD	I/O limit, upper 16 bits
 34h	DWORD	reserved
 38h	DWORD	expansion ROM base address
 3Ch	BYTE	interrupt line
 3Dh	BYTE	interrupt pin (read-only)
 3Eh	WORD	bridge control
 40h 48 DWORDs	varies by device (see #0821,#0822,#0851,#0879)
---header type 02h---
 10h	DWORD	CardBus Socket/ExCa base address (see #0810)
		bits 31-12: start address of socket interface register block
			  in 4K blocks
		bits 11-0: reserved (0)
 14h	BYTE	offset of capabilities list within configuration space (R/O)
		(only valid if status register bit 4 set) (see #0804)
 15h	BYTE	reserved
 16h	WORD	secondary status
 18h	BYTE	PCI bus number
 19h	BYTE	CardBus bus number
 1Ah	BYTE	subordinate bus number
 1Bh	BYTE	CardBus latency timer
 1Ch	DWORD	memory base address 0
 20h	DWORD	memory limit 0
 24h	DWORD	memory base address 1
 28h	DWORD	memory limit 1
 2Ch	WORD	I/O base address 0
 2Eh	WORD	I/O base address 0 high word (optional)
 30h	WORD	I/O limit 0
 32h	WORD	I/O limit 0 high word (optional)
 34h	WORD	I/O base address 1
 36h	WORD	I/O base address 1 high word (optional)
 38h	WORD	I/O limit 1
 3Ah	WORD	I/O limit 1 high word (optional)
 3Ch	BYTE	interrupt line
 3Dh	BYTE	interrupt pin (read-only) (no interrupt used if 00h)
 3Eh	WORD	bridge control
 40h	WORD	subsystem vendor ID
 42h	WORD	subsystem device ID
 44h	DWORD	16-bit PC Card legacy mode base address (for accessing ExCa
		  registers)
 48h 14 DWORDs	reserved
 80h 32 DWORDs	varies by device (see #0821,#0822,#0851,#0879)

Bitfields for PCI Configuration Command Register:
Bit(s)	Description	(Table 0799)
 0	I/O access enabled
 1	memory access enabled
 2	bus master enable
 3	special cycle recognition enabled
 4	memory write and invalidate enabled
 5	VGA palette snoop enabled
 6	parity error response enabled
 7	wait cycles enabled
 8	system error (SERR# line) enabled
 9	fast back-to-back transactions enabled
 15-10	reserved
SeeAlso: #0798,#0800

Format of PCI Configuration Status Register:
Bit(s)	Description	(Table 0800)
 3-0	reserved (0)
 4	new capabilities list is present (first entry pointed at by byte at
	  34h or 14h)
 5	capable of running at 66 MHz
 6	UDF supported
 7	capable of fast back-to-back transactions
 8	data parity error reported
 10-9	device select timing
	00 fast
	01 medium
	10 slow
	11 reserved
 11	signaled target abort
 12	received target abort
 13	received master abort
 14	signaled system error (device is asserting SERR# line)
 15	detected parity error (set even if parity error reporting is disabled)
Note:	bits 12, 13 and 15 are cleared by writing a 1 into the corresponding
	  bit
SeeAlso: #0798,#0799

Bitfields for PCI Configuration Built-In Self-Test register:
Bit(s)	Description	(Table 0801)
 3-0	completion code (0000 = successful)
 5-4	reserved
 6	start BIST (set to one to start, cleared automatically on completion)
 7	BIST-capable
Notes:	this register is hardwired to 00h if no BIST capability
	software should timeout the BIST after two seconds
SeeAlso: #0798

Bitfields for PCI Configuration Base Address:
Bit(s)	Description	(Table 0802)
 0	address type (0 = memory space, 1 = I/O space)
---memory address---
 2-1	address type
	00 anywhere in first 4GB
	01 below 1MB
	10 anywhere in 64-bit address space
	11 reserved
 3	prefetchable
 31-4	bits 31-4 of base memory address if addressable in first 1MB or 4GB
 63-4	bits 63-4 of base memory address if addressable in 64-bit memory
	(bits 63-32 are stored in the following base address DWORD)
---I/O address---
 1	reserved
 31-2	bits 31-2 of base I/O port
SeeAlso: #0798,#0827

Bitfields for PCI Configuration Expansion ROM Address:
Bit(s)	Description	(Table 0803)
 0	address decode enable (ROM address is valid)
 10-1	reserved
 31-11	bits 31-11 of ROM's starting physical address
SeeAlso: #0798

Format of PCI Capabilities List:
Offset	Size	Description	(Table 0804)
 00h	BYTE	capability identifier
		01h PCI Power Managment
 01h	BYTE	offset of next item (within configuration space) or 00h
      N	BYTEs	varies by capability type
---PCI Power Management---
 02h	WORD	power managment capabilities (see #0805) (read-only)
 04h	WORD	power managment capabilities status register (see #0806)
 06h	BYTE	PMCSR bridge support extensions (see #0807)
 07h	BYTE	(optional) read-only data register (see #0808)
Note:	this information is from the v0.93 draft of the specification and is
	  subject to change
SeeAlso: #0798,#0800

Bitfields for PCI Power Management Capabilities:
Bit(s)	Description	(Table 0805)
 15	reserved (0)
 14-12	PME# support
	bit 12: PME# can be asserted from power state D0
	bit 13: PME# can be asserted from power state D1
	bit 14: PME# can be asserted from power state D2
 11	reserved (0)
 10	D2 power state supported
 9	D1 power state supported
 8	full-speed clock is required in state D0 for proper operation
	(if clear, device may be run at reduced clock except when actually
	  being accessed)
 7-6	dynamic clock control support
	00 not bridge, no dynamic clock control, or secondary bus' clock is
	      is tied to primary bus' clock
	01 bridge is capable of dynamic clock control
	10 reserved
	11 secondary bus has independent clock, but dynamic clock not supported
 5	device-specific initialization is required
 4-3	reserved (0)
 2-0	specification version
	001 = v1.0; four bytes of power management registers
Note:	this information is from the v0.93 draft of the specification and is
	  subject to change
SeeAlso: #0804,#0806,#0807

Bitfields for PCI Power Management Capabilities Status Register:
Bit(s)	Description	(Table 0806)
 15	PME status: if set, PME# is (or would be) asserted
	writing a 1 to this bit clears it
 14-13	(read-only) scale factor to apply to contents of Data register
	00 unknown (or unimplemented data)
	01 x0.1
	10 x0.01
	11 x0.001
 12-9	(read-write) data select (see #0808)
 8	(read-write) enable PME# assertion
 7-5	reserved (0)
 4	(read-write) enable dynamic data reporting
	when set, PME# is asserted whenever the value in the Data register
	  changes significantly
 3-2	reserved (0)
 1-0	(read-write) current power state
	00 = D0
	...
	11 = D3
Note:	this information is from the v0.93 draft of the specification and is
	  subject to change
SeeAlso: #0804,#0805,#0807

Bitfields for PCI Power Management PMCSR bridge support extension:
Bit(s)	Description	(Table 0807)
 7	(read-only) Bus Power Control Enable
 6	(read-only) Bus Power State B3 supported
 5	(read-only) Bus Power State B2 supported
 4	dynamic clock control enable
 3-0	reserved (0)
Note:	this information is from the v0.93 draft of the specification and is
	  subject to change
SeeAlso: #0804,#0805,#0806

(Table 0808)
Values for PCI Power Management Data Select:
 00h	D0-state power consumed in watts (+20%/-10%)
 01h	D1-state power consumed in watts (+20%/-10%)
 02h	D2-state power consumed in watts (+20%/-10%)
 03h	D3-state power consumed in watts (+20%/-10%)
 04h	D0-state power dissipated into chassis in watts
 05h	D1-state power dissipated into chassis in watts
 06h	D2-state power dissipated into chassis in watts
 07h	D3-state power dissipated into chassis in watts
 08h-0Fh reserved
SeeAlso: #0806

Bitfields for PCI Configuration CardBus CIS Pointer:
Bit(s)	Description	(Table 0809)
 2-0	address space
	000 in device's device-specific configuration space
	001 in memory pointed to by base address register 0
	...
	110 in memory pointed to by base address register 5
	111 in device's expansion ROM
 27-3	offset within address space defined by bits 2-0
 31-28	ROM image number
SeeAlso: #0798

Format of CardBus Socket/ExCA socket interface register space:
Offset	Size	Description	(Table 0810)
 00h	DWORD	Socket Event Register (see #0812)
 04h	DWORD	Socket Mask Register (see #0813)
 08h	DWORD	Socket Present State Register (see #0814)
 0Ch	DWORD	Socket Force Event Register (see #0815)
 10h	DWORD	Socket Control Register (see #0816)
 14h  3 DWORDs	reserved
 20h	DWORD	Socket Power Management Register
 90h	BYTE	(TI PCI1130) Retry Status Register
 91h	BYTE	(TI PCI1130) Card Control Register (see #0817)
 92h	BYTE	(TI PCI1130) Device Control Register (see #0818)
 93h	BYTE	(TI PCI1130) Buffer Control Register
800h 64+ BYTEs	ExCa Socket Interface Registers (see #0811)

Format of ExCa memory-mapped registers:
Offset	Size	Description	(Table 0811)
 00h	BYTE	identification and revision register
 01h	BYTE	interface status register
 02h	BYTE	power control register
 03h	BYTE	interrupt and general control
 04h	BYTE	card status change
 05h	BYTE	card status change interrupt configuration
 06h	BYTE	address window enable
 07h	BYTE	I/O window control register
 08h	WORD	I/O window 0 start address
 0Ah	WORD	I/O window 0 end address
 0Ch	WORD	I/O window 1 start address
 0Eh	WORD	I/O window 1 end address
 10h	WORD	memory window 0 start address
 12h	WORD	memory window 0 end address
 14h	WORD	memory window 0 offset address
 16h  2 BYTEs	user-defined
 18h	WORD	memory window 1 start address
 1Ah	WORD	memory window 1 end address
 1Ch	WORD	memory window 1 offset address
 1Eh	BYTE	user-defined
 1Fh	BYTE	reserved
 20h	WORD	memory window 2 start address
 22h	WORD	memory window 2 end address
 24h	WORD	memory window 2 offset address
 26h  2 BYTEs	user-defined
 28h	WORD	memory window 3 start address
 2Ah	WORD	memory window 3 end address
 2Ch	WORD	memory window 3 offset address
 2Eh  2 BYTEs	user-defined
 30h	WORD	memory window 4 start address
 32h	WORD	memory window 4 end address
 34h	WORD	memory window 4 offset address
 36h 10 BYTEs	user-defined
---optional---
 40h	BYTE	memory window 0 start address high byte
 41h	BYTE	memory window 1 start address high byte
 42h	BYTE	memory window 2 start address high byte
 43h	BYTE	memory window 3 start address high byte
 44h	BYTE	memory window 4 start address high byte
 45h-7FFh	user-defined
SeeAlso: #0810

Bitfields for CardBus Socket Event Register:
Bit(s)	Description	(Table 0812)
 0	CSTSCHG pin asserted (status change)
 1	CCD1# (card detect 1) changed state
 2	CCD2# (card detect 2) changed state
 3	interface power cycle completed
31-4	reserved (0)
Note:	the bits in this register are set by the bridge, and cleared by writing
	  a one into the bits one wishes to clear
SeeAlso: #0810,#0813,#0815

Bitfields for CardBus Socket Event Mask Register:
Bit(s)	Description	(Table 0813)
 0	write-protect (enable status-change interrupt on WriteProtect switch)
 1	ready mask (allow status-change interrupt on Ready line change)
 3-2	battery condition (allow status-change int on battery-condition change)
 4	general wakeup enabled
 5	binary audio mode enabled on CAUDIO pin
 6	Pulse Width Modulation enabled on CAUDIO pin
	(CAUDIO state undefined if both bits 5 and 6 set)
 13-7	reserved (0)
 14	Wakeup mask (enable wakeup events via status-change pin)
 15	enable card interrupts via CINT# pin and wakeup events
 31-16	reserved
SeeAlso: #0810,#0812,#0814

Bitfields for CardBus Socket Present State Register:
Bit(s)	Description	(Table 0814)
 0	CSTSCHG pin asserted (status change)
 1	CCD1# (card detect 1) changed state
 2	CCD2# (card detect 2) changed state
 3	interface power cycle completed
 4	16-bit PC card inserted
 5	CardBus card inserted
 6	card's interrupt pin asserted
 7	card inserted but type can not be determined
 8	data may have been lost due to abrupt card removal
 9	attempted to apply Vcc voltage not supported by the card
 10	card can accept Vcc = 5.0 volts
 11	card can accept Vcc = 3.3 volts
 12	card can accept Vcc = X.X volts
 13	card can accept Vcc = Y.Y volts
 27-14	reserved (0)
 28	socket can accept Vcc = 5.0 volts
 29	socket can accept Vcc = 3.3 volts
 30	socket can accept Vcc = X.X volts
 31	socket can accept Vcc = Y.Y volts
Note:	bits 0-3 may be cleared by writing a 1 into the respective bits
SeeAlso: #0810,#0812,#0813,#0816

Bitfields for CardBus Socket Force Event Register:
Bit(s)	Description	(Table 0815)
 0	write-protect
 1	ready
 2	battery voltage detect 2
 3	battery voltage detect 1
 4	general wakeup
 14-5	reserved (0)
 15	enable card interrupts via CINT# pin
 31-16	reserved
Note:	this register can simulate events by forcing the values of some of the
	  bits in the Event Mask Register; any bit of this register which is
	  set to 1 forces the corresponding bit in the Mask Register to 1,
	  while bits set to 0 leave the corresponding bit unchanged
SeeAlso: #0810,#0812,#0816

Bitfields for CardBus Socket Control Register:
Bit(s)	Description	(Table 0816)
 2-0	Vpp control
	000 power off
	001 12.0 Volts
	010 5.0 Volts
	011 3.3 Volts
	100 reserved (X.X Volts)
	101 reserved (Y.Y Volts)
	110 reserved
	111 reserved
 3	reserved (0)
 6-4	Vcc control (as for Vpp, but 12.0V not supported)
 31-7	reserved (0)
SeeAlso: #0810,#0813,#0815

Bitfields for TI PCI1130 Card Control Register:
Bit(s)	Description	(Table 0817)
 0	interrupt pending
 1	speaker output enabled
 2	reserved
 3	enable status-change interrupt routing (to INTA# for socket A, INTB#
	  for socket B)
 4	function interrupt routed to corresponding PCI interrupt pin
 5	PCI interrupts enabled
 6	ZOOM video mode enabled
 7	Ring Indicator enabled on IRQ15/RI_OUT pin
SeeAlso: #0810,#0818

Bitfields for TI PCI1130 Device Control Register:
Bit(s)	Description	(Table 0818)
 0	reserved (0)
 2-1	interrupt mode enable
	00 no interrupt
	01 ISA mode (direct IRQ routing)
	10 serialized interrupt mode
	11 reserved
 4-3	reserved
 5	3volt Socket Capable force bit
 6	5volt Socket Capable force bit
 7	reserved
SeeAlso: #0810,#0817

Bitfields for PCI Configuration I/O base and limit:
Bit(s)	Description	(Table 0819)
 3-0	(read-only) address decoding type
	0000 16-bit
	0001 32-bit
	other reserved
 7-4	bits 15-12 of I/O address range
SeeAlso: #0798,#0820

Bitfields for PCI Configuration memory base and limit:
Bit(s)	Description	(Table 0820)
 3-0	address decode type
	0000 32-bit address decoder
	0001 64-bit address decoder
	other reserved
 15-4	bits 31-20 of memory address range
SeeAlso: #0798,#0819

Format of PCI Configuration Data for VLSI VL82C591 Host/PCI bridge:
Offset	Size	Description	(Table 0821)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 1004h, device ID 0005h)
 40h	BYTE	bus number
 41h	BYTE	subordinate bus number
 42h	WORD	reserved
 44h  4 DWORDs	reserved
 54h  2 BYTEs	device-specific configuration registers
 56h	WORD	reserved
 58h  2 BYTEs	device-specific configuration registers
 5Ah	WORD	reserved
 5Ch  5 BYTEs	device-specific configuration registers
	...
 FFh	BYTE	device-specific configuration register
SeeAlso: #0798,#0656,#0822

Format of PCI Configuration data for VLSI VL82C593 PCI/ISA bridge:
Offset	Size	Description	(Table 0822)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 1004, device ID 0006h)
 40h  4 DWORDs	reserved
 50h 11 BYTEs	device-specific configuration registers
 5Bh	BYTE	reserved
 5Ch 25 BYTEs	device-specific configuration registers
 75h 138 BYTEs	reserved
 FFh	BYTE	device-specific configuration register
SeeAlso: #0798,#0821

Format of AMD Am53C974A PC-SCSI PCI configuration data:
Offset	Size	Description	(Table 0823)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 1022h, device ID 2020h)
 10h	DWORD	I/O base address (see PORT xxxxh"Am53C974A")
 40h 16 BYTEs	scratch registers
		(used by AMD's PC-SCSI drivers as follows:
		    40h/41h  SCSI configuration register 0 (see #0824,#0825)
		    ...
		    4Eh/4Fh  SCSI configuration register 7)
SeeAlso: #0670

Bitfields for AMD Am53C974A Target Device Configuration Register:
Bit(s)	Description	(Table 0824)
 15-14	reserved
 13	"FSCSI" Fast SCSI drive is present
 12-8	"SPD" synchronous period
 7-4	synchronous offset (0 = asynchronous transfers)
 3-1	SCSI bus status
 0	target device is present and active
	if 0, all other bits must be cleared to zero for target devices
SeeAlso: #0823,#0825

Bitfields for AMD Am53C974A Host Configuration Register:
Bit(s)	Description	(Table 0825)
 15-9	reserved
 8	SCSI bus has been reset
 7	starting BIOS number (bits 6-4) is valid
 6-4	starting BIOS number (000 = BIOS drive 80h, 001 = drive 81h, etc)
 3	this device is a SCSI host
 2	protected-mode driver initialized
 1	real-mode driver initialized
 0	target device present
	=0 indicates that this is a host if bit 3 is set
SeeAlso: #0823,#0824

Format of PCI Configuration data for PC Technology RZ-1000 EIDE controller:
Offset	Size	Description	(Table 0826)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 1042h, device ID 1000h)
 10h	DWORD	base address for controller I/O registers
		(set to 01F1h for primary controller, 0171h for secondary)
 14h	DWORD	base address for controller digital I/O port
		(set to 03F5h for primary, 0375h for secondary)
 40h	DWORD	???
		bits 7-1: ???
		bit 13: read-ahead mode enabled
			(Read-Ahead is buggy on original RZ-1000, and is
			  thus typically disabled by clearing this bit)
		bit 16: ???
 44h	DWORD	???
 48h  8 BYTEs	???
 50h 176 BYTEs	unused???

Format of OpenHCI Host Controller memory-mapped registers:
Offset	Size	Description	(Table 0827)
 00h	DWORD	"HcRevision"		OpenHCI revision (see #0828)
 04h	DWORD	"HcControl"		HC operating modes (see #0829)
 08h	DWORD	"HcCommandStatus"	command/status (see #0830)
 0Ch	DWORD	"HcInterruptStatus"	interrupt status (see #0831)
 10h	DWORD	"HcInterruptEnable"	enable interrupts (see #0832)
 14h	DWORD	"HcInterruptDisable"	disable interrupts (see #0832)
 18h	DWORD	"HcHCCA"		HC Communications Area (see #0833)
 1Ch	DWORD	"HcPeriodCurrentED"	Endpoint Descriptor addr (see #0834)
 20h	DWORD	"HcControlHeadED"	Control Endpoint Descriptor (see #0835)
 24h	DWORD	"HcControlCurrentED"	Control Endpoint Descriptor (see #0835)
 28h	DWORD	"HcBulkHeadED"		Bulk Endpoint Descriptor (see #0836)
 2Ch	DWORD	"HcBulkCurrentED"	Bulk Endpoint Descriptor (see #0836)
 30h	DWORD	"HcDoneHead"		last completed Xfer Descr. (see #0837)
 34h	DWORD	"HcFmInterval"		Frame bit-time interval (see #0838)
 38h	DWORD	"HcFmRemaining"		bit time remaining in Frame (see #0839)
 3Ch	DWORD	"HcFmNumber"		Frame Number (bits 15-0)
 40h	DWORD	"HcPeriodicStart"	earliest time to start periodic list
					(bits 13-0)
 44h	DWORD	"HcLSThreshold"		threshold for Low Speed transaction
					(bits 11-0)
 48h	DWORD	"HcRhDescriptorA"	Root Hub Descriptor A (see #0840)
 4Ch	DWORD	"HcRhDescriptorB"	Root Hub Descriptor B (see #0841)
 50h	DWORD	"HcRhStatus"		Root Hub status (see #0842)
 54h  N DWORDs	"HCRhPortStatus[1-N]"	Root Hub port status N (see #0843)
Note:	OpenHCI reserves a full 4K page of the systems address space for its
	  memory-mapped registers
SeeAlso: #0798,#0802,#F059

Bitfields for OpenHCI "HcRevision" register:
Bit(s)	Description	(Table 0828)
 31-8	reserved
 7-0	BCD OpenHCI specification number (10h = 1.0, 11h = 1.1)
Note:	this register is read-only
SeeAlso: #0827,#0829

Bitfields for OpenHCI "HcControl" register:
Bit(s)	Description	(Table 0829)
 31-11	reserved
 10	RWE	enable Remote Wakeup feature
 9	RWC	controller supports Remote Wakeup signalling
 8	IR	Interrupt Routing
		0 normal host bus interrupt
		1 System Managment Interrupt
 7-6	HCFS	USB Host Controller Functional State
		00 USBReset
		01 USBResume
		10 USBOperational
		11 USBSuspend
 5	BLE	enable Bulk List processing in next frame
 4	CLE	enable Control List processing in next frame
 3	IE	enable Isochronous ED processing
 2	PLE	enable processing of Periodic List in next frame
 1-0	CBSR	Control Bulk Service Ratio
		00  1:1 Control EDs:Bulk EDs served
		01  2:1
		10  3:1
		11  4:1
SeeAlso: #0827,#0828,#0830

Bitfields for OpenHCI "HcCommandStatus" register:
Bit(s)	Description	(Table 0830)
 31-18	reserved
 17-16	SOC	scheduling-overrun count
 15-4	reserved
 3	OCR	ownership change request is pending
 2	BLF	bulk list contains TDs
 1	CLF	control list contains TDs
 0	HCR	host controller software reset
Note:	writing a 1 bit sets the corresponding bit, while a 0 bit leaves the
	  corresponding bit unchanged
SeeAlso: #0827,#0828,#0831

Bitfields for OpenHCI "HcInterruptStatus" register:
Bit(s)	Description	(Table 0831)
 31	reserved (0)
 30	OC	ownership change
 29-7	reserved
 6	RHSC	Root Hub status changed
 5	FNO	frame number overflowed
 4	UE	unrecoverable error
 3	RD	resume detected
 2	SF	start of frame
 1	WDH	writeback done
 0	SO	scheduling overrun
Note:	writing a 1 bit clears the corresponding bit of the register
SeeAlso: #0827,#0828,#0830,#0832

Bitfields for OpenHCI "HcInterruptEnable" and "HcInterruptDisable" registers:
Bit(s)	Description	(Table 0832)
 31	MIE	master interrupt enable
 30	OC	ownership change
 29-7	reserved
 6	RHSC	Root Hub status change
 5	FNO	frame number overflow
 4	UE	unrecoverable error
 3	RD	Resume Detect
 2	SF	start of frame
 1	WDH	HcDoneHead writeback
 0	SO	scheduling overrun
Note:	writing a 1 bit to HcInterruptEnable enables the corresponding
	  interrupt, while writing a 1 bit to HcInterruptDisable disables it;
	  zero bits are ignored.  On reading, both registers return the
	  same value, which reflects the currently enabled interrupts
SeeAlso: #0827

Bitfields for OpenHCI "HcHCCA" register:
Bit(s)	Description	(Table 0833)
 31-8	physical address of Host Controller Communications Area (bits 31-8)
 7-0	reserved (0)
Note:	the required alignment for the HCCA may be determined by writing
	  FFFFFFFFh to this register and determining the number of low-order
	  zero bits
SeeAlso: #0827,#0834,#0835

Bitfields for OpenHCI "HcPeriodCurrentED" register:
Bit(s)	Description	(Table 0834)
 31-4	physical address of current Isochronous/Interrupt Endpoint Descriptor
	  (bits 31-4)
 3-0	reserved (0)
SeeAlso: #0827,#0833,#0835

Bitfields for OpenHCI "HcControlHeadED"/"HcControlCurrentED" register:
Bit(s)	Description	(Table 0835)
 31-4	physical address of first/current Endpoint Descriptor (bits 31-4)
 3-0	reserved (0)
Note:	HcControlCurrentED is set to 0000000h to indicate the end of the
	  Control list
SeeAlso: #0827,#0833,#0834

Bitfields for OpenHCI "HcBulkHeadED"/"HcBulkCurrentED" register:
Bit(s)	Description	(Table 0836)
 31-4	physical address of first/current Endpoint Descriptor in the Bulk
	  list (bits 31-4)
 3-0	reserved (0)
Note:	HcBulkCurrentED is set to 0000000h to indicate the end of the Bulk
	  list
SeeAlso: #0827,#0833,#0835

Bitfields for OpenHCI "HcDoneHead" register:
Bit(s)	Description	(Table 0837)
 31-4	physical address of most-recently completed Transfer Descriptor added
	  to the Done queue (bits 31-4)
 3-0	reserved (0)
SeeAlso: #0827,#0834,#0836

Bitfields for OpenHCI "HcFmInterval" register:
Bit(s)	Description	(Table 0838)
 31	"FIT"	toggled each time a new value is loaded into bits 13-0
 30-16	"FSMPS"	largest data packet in bits
 15-14	reserved
 13-0	"FI"	Frame Interval (between to consecutive SOFs)
SeeAlso: #0827,#0839

Bitfields for OpenHCI "HcFmRemaining" register:
Bit(s)	Description	(Table 0839)
 31	"FRT"	loaded from bit 31 of HcFmInterval whenever FR reaches 0
 30-14	reserved
 13-0	"FR"	FrameRemaining -- bits times left in current frame
SeeAlso: #0827,#0838

Bitfields for OpenHCI "HcRhDescriptorA" register:
Bit(s)	Description	(Table 0840)
 31-24	"POTPGT" power-on to power-good time in 2ms units
 23-13	reserved
 12	"NOCP"	no over-current protection supported
 11	"OCPM"	over-current status reported per-port
 10	"DT"	device type - is root hub compound device?
 9	"NPS"	NoPowerSwitching -- ports are always powered up
 8	"PSM"	power-switching mode -- if set, each port powered individually
 7-0	"NDP"	number of downstream ports
SeeAlso: #0827,#0841,#0842

Bitfields for OpenHCI "HcRhDescriptorB" register:
Bit(s)	Description	(Table 0841)
 31-16	"PPCM"	PortPowerControlMask -- bitmask of ports NOT affected by global
		  power control (bit 16 [port #0] is reserved)
 15-0	"DR"	DeviceRemovable -- bitmap of removable devices
SeeAlso: #0827,#0840,#0842

Bitfields for OpenHCI "HcRhStatus" register:
Bit(s)	Description	(Table 0842)
 31	"CRWE"	Clear Remote Wakeup Enable
		write 1 to disable remote wakeup (writes of 0 ignored)
 30-18	reserved
 17	"OCIC"	OverCurrent Indicator Change
		write 1 to clear
 16   R	"LPSC"	Local Power Status Change
      W		Set Global Power mode (write 1; writes of 0 ignored)
 15	"DRWE"	Device Remote Wakeup Enable
		write 1 to enable (writes of 0 ignored)
		read to get current status
 14-2	reserved
 1	"OCI"	OverCurrent Indicator
 0    R "LPS"	LocalPowerStatus (always 0 for Root Hub)
      W		write 1 to turn off power to all ports/ports with clear
		  PortPowerControlMask bits
SeeAlso: #0827,#0840,#0841,#0843

Bitfields for OpenHCI "HcRhPortStatusN" register:
Bit(s)	Description	(Table 0843)
 31-21	reserved
 20	"PRSC"	Port Reset Status Change (write '1' to clear)
 19	"OCIC"	Port OverCurrent Indiactor Change (write '1' to clear)
 18	"PSSC"	Port Suspend Status Change (write '1' to clear)
 17	"PESC"	Port Enable Status Change (write '1' to clear)
 16	"CSC"	Connect Status Change (write '1' to clear)
 15-10	reserved
 9    R	"LSDA"	Low Speed Device Attached
      W		clear port power by writing '1'
 8    R	"PPS"	Port Power Status
      W		set port power by writing '1'
 7-5	reserved
 4    R	"PRS"	Port Reset Status
      W		set port reset by writing '1'
 3    R	"POCI"	Port OverCurrent Indicator
      W		clear suspend status by writing '1'
 2    R	"PSS"	Port Suspend Status
      W		set port suspend by writing '1'
 1    R "PES"	Port Enable Status
      W		set port enable by writing '1'
 0    R "CCS"	current connect status
      W		clear port enable by writing '1'
SeeAlso: #0827,#0840,#0841,#0842
--------X-1AB10ASF1106-----------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (VIA Technologies devices)
	AX = B10Ah subfn 1106h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #0798)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #0653)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Ah/SF=8086h

Format of AMD-645 Peripheral Bus Controller, function 1 (IDE Control) data:
Offset	Size	Description	(Table 0844)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 1106h [VIA Technologies], device ID 0571h)
 10h	DWORD	primary data/command base address
 14h	DWORD	primary control/status base address
 18h	DWORD	secondary data/command base address
 1Ch	DWORD	secondary control/status base address
 20h	DWORD	bus master control base address (default 0000CC01h)
 40h	BYTE	chip enable
 41h	BYTE	IDE configuration
 42h	BYTE	reserved ("do not program")
 43h	BYTE	FIFO configuration
 44h	BYTE	miscellaneous control 1
 45h	BYTE	miscellaneous control 2
 46h	BYTE	miscellaneous control 3
 47h	BYTE	unused???
 48h	DWORD	drive timing control
 4Ch	BYTE	address setup time
 4Dh	BYTE	reserved ("do not program")
 4Eh	BYTE	secondary non-01F0h port access timing
 4Fh	BYTE	primary non-01F0h port access timing
 50h	DWORD	UltraDMA/33 extended timing control
 54h  4 BYTEs	reserved
 58h	DWORD	"reserved" (appears to be an additional drive timing control)
 5Ch  4 BYTEs	???
 60h	WORD	primary sector size
 62h  6 BYTEs	reserved
 68h	WORD	secondary sector size
 6Ah 150 BYTEs	reserved
!!!amd\21095a.pdf p.129
SeeAlso: #0740,#0845,#0847

Format of AMD-645 Peripheral Bus Controller, function 0 (PCI-ISA bridge) data:
Offset	Size	Description	(Table 0845)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 1106h, device ID 0586h)
 40h	BYTE	ISA bus control
 41h	BYTE	ISA Test Mode
 42h	BYTE	ISA clock control
 43h	BYTE	ROM Decode Control
 44h	BYTE	keyboard controller control
 45h	BYTE	Type F DMA control
 46h	BYTE	Miscellaneous control 1
 47h	BYTE	Miscellaneous control 2
 48h	BYTE	Miscellaneous control 3
 49h	BYTE	reserved
 4Ah	BYTE	IDE interrupt routing
 4Bh	BYTE	reserved
 4Ch	BYTE	DMA/Master memory access control 1
 4Dh	BYTE	DMA/Master memory access control 2
 4Eh	WORD	DMA/Master memory access control 3
 50h	BYTE	reserved ("do not program")
 51h  3	BYTEs	reserved
 54h	BYTE	PIC IRQ Edge/Level selection
 55h	BYTE	PnP Routing for external MIRQ0/1
 56h	BYTE	PnP Routing for PCI INTB/INTA
 57h	BYTE	PnP Routing for PCI INTD/INTC
 58h	BYTE	PnP Routing for external MIRQ2
 59h	BYTE	MIRQ pin configuration
 5Ah	BYTE	XD Power-On Strap Options
 5Bh	BYTE	internal RTC test mode
 5Ch  4 BYTEs	reserved
 60h	WORD	distributed DMA, channel 0 base address/enable
 62h	WORD	distributed DMA, channel 1 base address/enable
 64h	WORD	distributed DMA, channel 2 base address/enable
 66h	WORD	distributed DMA, channel 3 base address/enable
 68h	WORD	reserved
 6Ah	WORD	distributed DMA, channel 5 base address/enable
 6Ch	WORD	distributed DMA, channel 6 base address/enable
 6Eh	WORD	distributed DMA, channel 7 base address/enable
 70h 144 BYTEs	reserved
!!!amd\21095a.pdf p.125
SeeAlso: #0740,#0846,#0844,#0847

Format of AMD-640 System Controller:
Offset	Size	Description	(Table 0846)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 1106h, device ID 0595h)
 0Dh	BYTE	latency timer (bits 7-3)
		00h = 256*8 PCI clocks
		01h = 1*8 PCI clocks
		02h = 2*8 PCI clocks
		other reserved
 40h 16 BYTEs	unused???
 50h	BYTE	cache control 1
!!!amd\21090a.pdf p.107
 51h	BYTE	cache control 2
 52h	BYTE	non-cacheable control
 53h	BYTE	system performance control
 54h	WORD	non-cacheable region 1
 56h	WORD	non-cacheable region 2
 58h	BYTE	DRAM configuration register 1
 59h	BYTE	DRAM configuration register 2
 5Ah  6	BYTEs	end of DRAM banks 0-5
 60h	BYTE	DRAM type
 61h	BYTE	shadow RAM control register 1
 62h	BYTE	shadow RAM control register 2
 63h	BYTE	shadow RAM control register 3
 64h	BYTE	DRAM timing
 65h	BYTE	DRAM control register 1
 66h	BYTE	DRAM control register 2
 67h	BYTE	32-bit DRAM width control register
 68h  2 BYTEs	reserved
 6Ah	BYTE	DRAM refresh counter
 6Bh	BYTE	DRAM refresh control register
 6Ch	BYTE	SDRAM control register
 6Dh	BYTE	DRAM drive strength control register
 6Eh	BYTE	ECC control register
 6Fh	BYTE	ECC status register
 70h	BYTE	PCI buffer control 1
 71h	BYTE	CPU-to-PCI flow control 1
 72h	BYTE	CPU-to-PCI flow control 2 (write-clear)
 73h	BYTE	PCI target control
 74h	BYTE	PCI initiator control
 75h	BYTE	PCI arbitration control 1
 76h	BYTE	PCI arbitration control 2
 77h 137 BYTEs	reserved
Note:	the AMD-640 uses PCI configuration mechanism #1; bus/device/function
	  are always 00h/00h/00h
SeeAlso: #0740,#0845

Format of AMD-645 Peripheral Bus Controller, function 2 (USB Controller) data:
Offset	Size	Description	(Table 0847)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 1106h, device ID 3038h)
 20h	DWORD	base address
 40h	BYTE	miscellaneous control 1
 41h	BYTE	miscellaneous control 2
 42h  2 BYTEs	reserved
 44h  3 BYTEs	reserved ("do not program")
 47h	BYTE	reserved
 48h 24 BYTEs	reserved
 60h	BYTE	USB release number (read-only, 10h)
 61h 95 BYTEs	reserved
 C0h	WORD	USB legacy support (read-only, 2000h)
 C2h 62 BYTEs	reserved
!!!amd\21095a.pdf p.130
SeeAlso: #0740,#0846,#0845,#0844,#0848

Format of AMD-645 Peripheral Bus Controller, function 3 (Power Mgmt) data:
Offset	Size	Description	(Table 0848)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 1106h, device ID 3040h)
 20h	DWORD	base address for I/O registers (see #0849)
 40h	BYTE	pin configuration
 41h	BYTE	genearl configuration
 42h	BYTE	SCI interrupt configuration
 43h	BYTE	reserved
 44h	WORD	primary interrupt channel
 46h	WORD	secondary interrupt channel
 48h  8 BYTEs	unused???
 50h	DWORD	GP timer control
 54h 13	BYTEs	reserved
 61h	BYTE	programming interface read value (value to be returned by
		  configuration register 09h) (write-only)
 62h	BYTE	subclass read value (value to be returned by
		  configuration register 0Ah) (write-only)
 63h	BYTE	base class read value (value to be returned by configuration
		  register 0Bh) (write-only)
 64h 156 BYTEs	reserved
!!!amd\21095a.pdf p.133
SeeAlso: #0740,#0846,#0845,#0844,#0847,#0848

Format of AMD-645 Power Management Control/Status registers:
Offset	Size	Description	(Table 0849)
 00h	WORD	power management status (write-clear)
 02h	WORD	power management enable
 04h	WORD	power management control
 06h  2 BYTEs	unused???
 08h	DWORD	power management timer
 0Ch  4 BYTEs	unused???
 10h
!!!amd\21095a.pdf p.134
Note:	this data structure is actually a range of I/O ports
SeeAlso: #0848
--------X-1AB10ASF8086-----------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (Intel devices)
	AX = B10Ah subfn 8086h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #0798)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #0653)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Ah/SF=1106h,AX=B10Dh

Format of PCI Configuration data for Intel 82375 EISA Bridge:
Offset	Size	Description	(Table 0850)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, device ID 0482h)
		(revision numbers: 03h = 82375EB, 04h = 82375SB)
 40h	BYTE	PCI Control
!!!intel\29047704.pdf pg. 32
 41h	BYTE	PCI Arbiter Control
 42h	BYTE	PCI Arbiter Priority Control
 43h	BYTE	PCI Arbiter Priority Control Extension
 44h	BYTE	MEMCS# Control
 45h	BYTE	MEMCS# Bottom of Hole
 46h	BYTE	MEMCS# Top of Hole
 47h	BYTE	MEMCS# Top of Memory
 48h	WORD	EISA Address Decode Control 1
 4Ah  2 BYTEs	reserved
 4Ch	BYTE	ISA I/O Recovery Time Control
 4Dh  7 BYTEs	reserved
 54h	BYTE	MEMCS# Attribute Register #1
 55h	BYTE	MEMCS# Attribute Register #2
 56h	BYTE	MEMCS# Attribute Register #3
 57h	BYTE	reserved
 58h	BYTE	PCI Decode Control
 59h	BYTE	reserved
 5Ah	BYTE	EISA Address Decode Control 2
 5Bh	BYTE	reserved
 5Ch	BYTE	EISA-to-PCI Memory Region Attributes
 5Dh  3 BYTEs	reserved
 60h  4 DWORDs	EISA-to-PCI Memory Region Address registers 1-4
 70h  4 DWORDs	EISA-to-PCI I/O Region Address registers 1-4
 80h	WORD	BIOS Timer base address
 82h  2 BYTEs	reserved
 84h	BYTE	EISA Latency Timer Control Register
 85h  3 BYTEs	reserved
 88h	DWORD	PCEB Test Control Register ("DO NOT WRITE")
 8Ch 116 BYTEs	reserved
SeeAlso: #0798,#0851

Format of PCI Configuration data for Intel 82434LX/NX Cache/DRAM Controller:
Offset	Size	Description	(Table 0851)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, device ID 04A3h)
		(revision numbers: 01h/03h are 82434LX, 1xh are 82434NX)
		(command register only supports bits 8,6,2,1,0)
 40h 16 BYTEs	unused (hard-wired to 00h)
 44h	BYTE	??? (AMI BIOS writes 00h)
 45h	BYTE	??? (AMI BIOS writes 00h)
 50h	BYTE	Host CPU Selection (see #0852)
 51h	BYTE	deturbo frequency control register
		when deturbo mode is selected (see PORT 0CF9h), the chipset
		  places a hold on the memory bus for a fraction of the
		  time inversely proportional to the value in this register
		  by comparing it against a free-running 8-bit counter counting
		  at 1/8 the CPU clock speed
		  (i.e. C0h = 1/4, 80h = 1/2, 40h = 3/4, 20h = 7/8, etc.)
		  (only bits 7-6 writable, bits 5-0 hardwired to 0)
 52h	BYTE	Secondary Cache Control (see #0853)
 53h	BYTE	Host Read/Write Buffer Control (see #0854)
 54h	BYTE	PCI Read/Write Buffer Control
		bits 7-3: reserved
		bit 2: LBXs connected to TRDY#
		bit 1: enable PCI burst writes
		bit 0: enable PCI-to-memory posted writes
 55h  2 BYTEs	reserved
 57h	BYTE	DRAM Control (see #0855)
 58h	BYTE	DRAM Timing (see also #0901)
		bits 7-2: reserved
		bit 1: (NX only) RAS# Wait State
		bit 0: CAS# Wait State (one extra wait state before CAS#
			  within burst cycle)
 59h  7	BYTEs	Programmable Attribute Map registers 0-6 (see #0902)
 60h  8	BYTEs	DRAM Row Boundary registers 0-7
		(chip revisions numbered < 10h [LX] only support six rows of
		  DRAM)
		each register N indicates the amount of cumulative amount of
		  memory in SIMM banks 0-N, in multiples of 1M; offset 67h
		  (65h on 82434LX's) contains the total amount of memory
		  installed in the system; on the 82434NX, two additional
		  bits are concatenated to each row boundary from the DRAM Row
		  Boundary Extension registers to allow up to 1024M of memory
		  to be specified (though only 512M are supported)
 68h  4 BYTEs	(NX only) DRAM Row Boundary Extension registers
		each nybble is concatenated with the corresponding DRAM Row
		  Boundary register to form a 12-bit boundary value (of which
		  only the low 10 bits are actually used)
 6Ch	DWORD	reserved (hardwired to 00000000h)
 70h	BYTE	Error Command (see #0856)
 71h	BYTE	Error Status (see #0857)
 72h	BYTE	System Management RAM control (see also #0906)
		bits 7-6: reserved
		bit 5:	map SMM-mode memory (64K) into address space when bits
			2-0 = 010 (default 3000h:0000h; can be changed by
			first SMM event)
		bit 4: close SMRAM space (allows data accesses to be forwarded
			to PCI bus while execuding SMM code)
		bit 3: lock SMRAM space (can't be cleared by software)
		bits 2-0: SMRAM memory address (010 = Axxxxh, 011 = Bxxxxh)
 73h  5 BYTEs	reserved
 78h	WORD	Memory Space Gap
		bit 15: enable ISA hole
		bits 14-12: size of ISA hole in MB (less 1); must be power of 2
		bits 11-8: reserved
		bits 7-4: bottom of ISA memory hole in MB
			  (must be multiple of gap size)
		bits 3-0: reserved
 7Ah  2 BYTEs	reserved
 7Ch	DWORD	Frame Buffer Range (see #0858)
 80h 128 BYTEs	reserved
Note:	the 82434NX is part of the Intel Neptune chipset
SeeAlso: #0860,#0879

Bitfields for Intel 82434LX/NX Host CPU Selection:
Bit(s)	Description	(Table 0852)
 7-5	host CPU type
	LX: hardwired to 100 (Pentium)
	NX: "reserved" (101 on RB's system)
 4-3	reserved
 2	enable L1 cache
 1-0	Host Operating Frequency (set according to external bus speed)
	00: reserved
	01: 50 MHz
	10: 60 MHz
	11: 66 MHz
	(LX: bit 1 reserved, only 60/66 MHz supported)
SeeAlso: #0851,#0853

Bitfields for Intel 82434LX/NX Secondary Cache Control:
Bit(s)	Description	(Table 0853)
 7-6	secondary cache size
	00 none
	01 reserved
	10 256K
	11 512K
 5	SRAM type
	0 standard SRAMs
	1 burst SRAMs
 4	secondary cache allocation
	0 cache only CPU reads of memory with CACHE# asserted
	1 cache all CPU reads of cacheable memory
 3	Cache Byte Control
	0 use single write enable and per-byte select lines
	1 use per-byte write enables on the cache
 2	(NX only) SRAM connectivity
	0 disable CCS[1:0]# / CCS1# functionality
	1 enable CCS[1:0]# functionality to de-select async SRAMs, placing them
	  in a low-power standby mode
	1 enable CCS1# functionality for burst SRAMs, indicating the lack of an
	  external address latch
 1	(LX only) Secondary Cache Write Policy
	0 write-through
	1 write-back (NX is always in write-back mode)
 0	Secondary Cache Enable
SeeAlso: #0851,#0854

Bitfields for Intel 82434LX/NX Host Read/Write Buffer Control:
Bit(s)	Description	(Table 0854)
 7-4	reserved
 3	enable read-around-write
 2	reserved
 1	enable CPU-to-PCI posted writes
 0	(LX only) enable CPU-to-memory posted writes
	(NX always posts memory writes)
SeeAlso: #0851,#0853

Bitfields for Intel 82434LX/NX DRAM Control:
Bit(s)	Description	(Table 0855)
 7-6	(NX only) DRAM burst timing
	00  X-4-4-4 read/write (default)
	01  X-4-4-4 read, X-3-3-3 write
	10  reserved
	11  X-3-3-3 read/write
 5	parity error mask
 4	0-Active RAS# mode
 3	SMRAM enable (must be set to enable reg 72h)
 2	Burst-of-Four Refresh
 1	Refresh Type
	=0 RAS#-only
	=1 CAS#-before-RAS#
 0	DRAM Refresh Enable
SeeAlso: #0851

Bitfields for Intel 82434LX/NX Error Command register:
Bit(s)	Description	(Table 0856)
 7	assert SERR# on receiving target abort
 6	assert SERR# on PCI data-write parity error
 5	(NX only) assert SERR# on PCI data-read parity error
 4	(NX only) assert SERR# on PCI address parity error
 3	(NX only) assert PERR# on data parity error
 2	enable L2 cache parity
 1	enable SERR# on DRAM/L2 cache data parity error
 0	assert PEN# on data reads; allow CPU to signal parity error via PCHK#
Notes:	PCI command register bit 6 is master enable for bit 3;
	PCI cmd bits 6 and 8 are the master enable for bits 7-4 and 1
	bits 1-0 = 10 is not permitted
SeeAlso: #0851,#0857

Bitfields for Intel 82434LX/NX Error Status register:
Bit(s)	Description	(Table 0857)
 7	reserved
 6	PCI-write detected parity error
 5	(NX only) PCI-read detected parity error
 4	(NX only) PCI address parity error detected
 3	main memory data parity error
 2	L2 cache data parity error
 1	reserved
 0	Shutdown cycle detected
Note:	clear status bits by writing a 'one' bit to each bit to be cleared
SeeAlso: #0856,#0851

Bitfields for Intel 82434LX/NX Frame Buffer Range register:
Bit(s)	Description	(Table 0858)
 31-20	buffer offset (in 1MB increments; must be multiple of buffer set set
	  by bits 3-0)
 19-14	reserved
 13	enable byte merging
 12	128K VGA-range Attribute Enable
	when set, bits 13,9,7 also apply to VGA memory range (Axxxx-Bxxxx)
 11-10	reserved
 9	no lock requests
 8	reserved
 7	enable transparent bufer writes
 6-4	reserved
 3-0	buffer size in MB (less 1); must be power of 2
Note:	if bits 31-20=0, the frame buffer feature is disabled
SeeAlso: #0851

Format of PCI Configuration data for Intel 82424 Cache Controller:
Offset	Size	Description	(Table 0859)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, device ID 0483h)
 40h	BYTE	bus number
 41h	BYTE	subordinate bus number
 42h	BYTE	disconnect timer
 50h	BYTE	host CPU selection
 51h	BYTE	deturbo frequency control
		when deturbo mode is selected (see PORT 0CF9h), the chipset
		  places a hold on the memory bus for a fraction of the
		  time inversely proportional to the value in this register
		  (i.e. C0h = 1/4, 80h = 1/2, 40h = 3/4, 20h = 7/8, etc.)
 52h	BYTE	secondary cache control
 53h	BYTE	write buffer control
 54h	BYTE	PCI features control
 55h	BYTE	DRAM Operation Mode Select
 56h	BYTE	System Exception Handling
 57h	BYTE	SMM Control Register
 58h	BYTE	reserved
 59h  7	BYTEs	Programmable Attribute Map registers 0-6 (see also #0902)
 60h  4 BYTEs	DRAM Row Boundary registers 0-3
		each register N indicates amount of memory in rows 0-N (each
		  row is 64 bits wide)
		boundary register 3 (offset 63h) contains the total system
		  memory, which may not exceed 128M
 64h  4 BYTEs	unused???
 68h	WORD	Memory Hole-0
 6Ah	WORD	Memory Hole-1
Note:	the above field names are those given by EduWARE's PCI Configuration
	  Manager v1.2
SeeAlso: #0851,#0879,#0892

Format of PCI Configuration data for Intel 82378 and 82379 ISA Bridges:
Offset	Size	Description	(Table 0860)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, device ID 0484h)
		(revision ID:
		    bits 7-4: reserved
		    bits 3-0: revision
			0011 82378ZB A0-step
			1000 82379AB A0-step)
 40h	BYTE	PCI Control (see #0861)
 41h	BYTE	PCI Arbiter Control (see #0862)
 42h	BYTE	PCI Arbiter Priority Control (see #0863)
 43h	BYTE	(82378ZB) PCI Arbiter Priority Control Extension Register
		bit 0: bank 3 fixed priority mode select (see also #0863)
		    =0 REQ2# has higher priority
		    =1 REQ3# has higher priority
 44h	BYTE	MEMCS# Control (see #0864)
 45h	BYTE	MEMCS# Bottom of Hole (address bits 23-16)
 46h	BYTE	MEMCS# Top of Hole (address bits 23-16)
 47h	BYTE	MEMCS# Top of Memory
		(address bits 28-21 == size in 2M increments, less 1)
 48h	BYTE	ISA Address Decoder Control (see #0865)
 49h	BYTE	ISA Address Decoder ROM Block Enable (see #0866)
 4Ah	BYTE	ISA Address Decoder Bottom of Hole (address bits 23-16)
 4Bh	BYTE	ISA Address Decoder Top of Hole (address bits 23-16)
 4Ch	BYTE	ISA Controller Recovery Time (see #0883)
 4Dh	BYTE	ISA Clock Divisor (see #0867)
 4Eh	BYTE	Utility Bus Chip Select Enable A (see #0868)
 4Fh	BYTE	Utility Bus Chip Select Enable B (see #0869)
 50h  4 BYTEs	reserved
 54h	BYTE	MEMCS# Attribute Register #1 (see #0870)
		attributes for 16K blocks from C0000h-CFFFFh
 55h	BYTE	MEMCS# Attribute Register #2 (see #0870)
		attributes for 16K blocks from D0000h-DFFFFh
 56h	BYTE	MEMCS# Attribute Register #3 (see #0870)
		attributes for 16K blocks from E0000h-EFFFFh
 57h	BYTE	(82378) Scatter/Gather Relocation Base Adress (see #0871)
		(82379AB) reserved
 58h  8 BYTEs	reserved
 60h	BYTE	(82378ZB) IRQ0# Route Control (see #0872)
 61h	BYTE	(82378ZB) IRQ1# Route Control (see #0872)
 62h	BYTE	(82378ZB) IRQ2# Route Control (see #0872)
 63h	BYTE	(82378ZB) IRQ3# Route Control (see #0872)
 64h 12 BYTEs	reserved
 70h	BYTE	(82378) reserved
		(82379AB, write-only) PIC/APIC Configuration Control
			  (see #0873)
 71h	BYTE	(82378) reserved
		(82379AB, write-only) APIC Base Address Relocation
		  (see #0874,MEM FEC00000h)
 72h 14 BYTEs	reserved
 80h	WORD	BIOS timer base address (see PORT 0078h)
		bits 15-2 are bits 15-2 of BIOS timer port address
		bit 1: reserved (0)
		bit 0: timer enabled (if disabled, other bits ignored)
 82h 30 BYTEs	unused???
 A0h	BYTE	SMI Control (see #0875)
 A1h	BYTE	reserved
 A2h	WORD	SMI Enable (see #0876)
 A4h	DWORD	System Event Enable (SEE) (see #0877)
 A8h	BYTE	Fast-Off Timer (in minutes)
 A9h	BYTE	reserved
 AAh	WORD	active SMI Requests (see #0878)
 ACh	BYTE	(82378ZB) Clock Throttle STPCLK# Low Timer
		duration of STPCLK# low period in 32 microsecond units
 ADh	BYTE	reserved
 AEh	BYTE	(82378ZB) Clock Throttle STPCLK# High Timer
		duration of STPCLK# high period in 32 microsecond units
 AFh 81 BYTEs	reserved
SeeAlso: #0851,#0911,PORT 040Ah"82378ZB"

Bitfields for Intel 82378/82379 PCI Control:
Bit(s)	Description	(Table 0861)
 7	reserved (0)
 6	DMA Reserved Page Register Aliasing Control
	=0 alias PORT 80h-8Fh to PORT 90h-9Fh
 5	Interrupt Acknowledge Enable
	=0 ignore INTA cycles on the PCI bus, but still allow 8259 register
	  access and poll-mode functions
 4-3	Subtractive Decoding Sample Point
	00 slow sample point
	01 typical
	10 fast sample point
	11 reserved
 2	PCI Posted Write Buffer Enable
 1	ISA Master Line Buffer Configuration
	=0 single-transaction mode
	=1 eight-byte mode for ISA bus master transfers
 0	DMA Line Buffer Configuration
	=0 single-transaction mode
	=1 eight-byte mode
SeeAlso: #0860,#0862

Bitfields for Intel 82378/82379 PCI Arbiter Control:
Bit(s)	Description	(Table 0862)
 7-5	reserveed (0)
 4-3	Master Retry Timer
	00 disabled (retries never masked)
	01 retries unmasked after 16 PCICLKs
	10 retries unmasked after 32 PCICLKs
	11 retries unmasked after 64 PCICLKs
 2	Bus Park
	=1 park CPUREQ# on PCI bus when 82378 detects PCI bus idle
 1	Bus Lock
	=0 resource lock
	=1 Bus lock
 0	Guaranteed Access Time
	=1 ISA bus masters are guaranteed 2.5 microsecond CHRDY time-out
SeeAlso: #0860,#0861

Bitfields for Intel 82378/82379 PCI Arbiter Priority Control:
Bit(s)	Description	(Table 0863)
 7	bank 3 rotate control
 6	bank 2 rotate control
 5	bank 1 rotate control
 4	bank 0 rotate control
 3	bank 2 fixed priority mode select B
 2	bank 2 fixed priority mode select A
 1	bank 1 fixed priority mode select
 0	bank 0 fixed priority mode select
Note:	if both 'rotate' and 'fixed' bits are set for a given bank,
	  that bank will be in rotating-priority mode
SeeAlso: #0860,#0862

Bitfields for Intel 82378/82379 MEMCS# Control Register:
Bit(s)	Description	(Table 0864)
 7-5	reserved (0)
 4	MEMCS# Master Enable
 3	write enable for 0F0000h-0FFFFFh
 2	read enable for 0F0000h-0FFFFFh
 1	write enable for 080000h-09FFFFh
 0	read enable for 080000h-09FFFFh
SeeAlso: #0860

Bitfields for Intel 82378/82379 ISA Address Decoder Control Register:
Bit(s)	Description	(Table 0865)
 7-4	ISA memory cycle forwarding to PCI
	0000-1111 = 1M-16M top of ISA memory; any accesses above programmed
		  limit are forwarded to PCI bus
 3-0	ISA/DMA memory cycle to PCI bus enables
	bit 3: 896K-960K (E000h-EFFFh)
	bit 2: 640K-768K (A000h-BFFFh)
	bit 1: 512K-640K (8000h-9FFFh)
	bit 0: 0K-512K	 (0000h-7FFFh)
SeeAlso: #0860,#0866

Bitfields for Intel 82378/82379 ISA Address Decoder ROM Block Enable:
Bit(s)	Description	(Table 0866)
 7	enable 880K-896K (EC00h-EFFFh)
 6	enable 864K-880K (E800h-EBFFh)
 5	enable 848K-864K (E400h-E7FFh)
 4	enable 832K-848K (E000h-E3FFh)
 3	enable 816K-832K (DC00h-DFFFh)
 2	enabel 800K-816K (D800h-DBFFh)
 1	enable 784K-800K (D400h-D7FFh)
 0	enable 768K-784K (D000h-D3FFh)
Note:	ISA accesses within any enabled ranges are forwarded to the PCI bus
SeeAlso: #0860,#0865

Bitfields for Intel 82378/82379 ISA Clock Divisor Register:
Bit(s)	Description	(Table 0867)
 7	reserved (0)
 6	enable positive decode of upper 64K BIOS at 000F0000h-000FFFFFh,
	  FFEF0000h-FFEFFFFFh, and FFFF0000h-FFFFFFFFh
 5	coprocessor error enable
	=1 FERR# is driven onto IRQ13
 4	IRQ12/Mouse Function Enable
	=0 standard IRQ12
	=1 mouse
 3	RSTDRV enable
	=1 assert RSTDRV until this bit cleared (for use in changing ISA bus
	  speed)
 2-0	PCICLK-to-ISA SYSCLK divisor
	000	4
	001	3
	other	reserved
SeeAlso: #0860,#0865

Bitfields for Intel 82378/82379 Utility Bus Chip Select A Register:
Bit(s)	Description	(Table 0868)
 7	extended BIOS enable (decode accesses to FFF80000h-FFFDFFFFh)
 6	lower BIOS enable (decode accesses to E0000h-EFFFFh,
	  FFEE0000h-FFEEFFFFh, and FFFE0000h-FFFEFFFFh)
 5	(82378ZB) floppy disk primary/secondary address select
	=1 use secondary address range
 4	(82378ZB) IDE Decode enable
 3,2	floppy disk address locations enable
 1	keyboard controller address location enable
	enables I/O addresses 60h,62h,64h,66h (82378ZB) or 60h/64h (82379AB)
 0	RTC address location enabled
	=1 enable decode of I/O ports 70h-77h
SeeAlso: #0860,#0885,#0869

Bitfields for Intel 82378ZB/82379 Utility Bus Chip Select B Register:
Bit(s)	Description	(Table 0869)
 7	configuration RAM decode enable
	=1 permit write accesses to I/O port 0C00h and r/w to ports 08xxh
 6	enable PORT 0092h
 5-4	parallel port enable
	00 LPT1 (ports 03BCh-03BFh)
	01 LPT2 (ports 0378h-037Fh)
	10 LPT3 (ports 0278h-027Fh)
	11 disabled
 3-2	serial port B enable
	00 COM1 (03F8h-03FFh)
	01 COM2 (02F8h-02FFh)
	10 reserved
	11 port B disabled
 1-0	serial port A enable
	00 COM1 (03F8h-03FFh)
	01 COM2 (02F8h-02FFh)
	10 reserved
	11 port A disabled
Note:	if both serial ports are set to the same address, port B is disabled
SeeAlso: #0860,#0868,PORT 0092h

Bitfields for Intel 82378/82379 MEMCS# Attribute Register 1/2/3:
Bit(s)	Description	(Table 0870)
 7	write-enable xC000h-xFFFFh expansion ROM
 6	read-enable xC000h-xFFFFh expansion ROM
 5	write-enable x8000h-xBFFFh expansion ROM
 4	read-enable x8000h-xBFFFh expansion ROM
 3	write-enable x4000h-x7FFFh expansion ROM
 2	read-enable x4000h-x7FFFh expansion ROM
 1	write-enable x0000h-x3FFFh expansion ROM
 0	read-enable x0000h-x3FFFh expansion ROM
Note:	x = C/D/E depending on the attribute register
SeeAlso: #0860

Bitfields for Intel 82378ZB Scatter Gather Relocation Base Address:
Bit(s)	Description	(Table 0871)
 7-0	bits 15-8 of base address for scatter/gather I/O ports
	(default 04h; low 8 bits of address are always 10h-3Fh)
SeeAlso: #0860,#0870,#0872,PORT 040Ah"82378ZB",#P038

Bitfields for Intel 82378/82379 PCI IRQ Route Control Register:
Bit(s)	Description	(Table 0872)
 7	disable IRQ routing
 6-4	reserved (0)
 3-0	ISA IRQ number to which to route the PCI IRQ
Note:	IRQs 0-2, 8, and 13 are reserved
SeeAlso: #0860,#0911

Bitfields for Intel 82379AB PIC/APIC Configuration Control Register:
Bit(s)	Description	(Table 0873)
 7-2	reserved
 1	SMI Routing Control
	=1 SMI via APIC
	=0 SMI via SMI# signal
 0	INT Routing Control
	=1 INT disabled (requires that APIC be enabled)
	=0 INT enabled
SeeAlso: #0860,#0874

Bitfields for Intel 82379AB/82371 APIC Base Address Relocation:
Bit(s)	Description	(Table 0874)
 7	reserved
 6	(82379AB) reserved
 6	(82371) A12 mask
	=1 ignore address bit 12 in APIC address
 5-0	bits 15-10 of APIC memory address (ORed with FEC00000h to form base
	  address)
SeeAlso: #0860,#0911,#0873,MEM FEC00000h

Bitfields for Intel 82378/82379 SMI Control Register:
Bit(s)	Description	(Table 0875)
 7	reserved
 6	(82378) reserved
	(82379) require Stop Grant bus cycle before asserting STPCLK#
 5-4	reserved
 3	Fast-Off Timer freeze
 2	STPCLK# scaling enable
	=1 enable Clock Throttle bytes in PCI configuration space
 1	STPCLK# signal enable
	=1 assert STPCLK# on read from PORT 00B2h
 0	SMI# Gate
	=1 enable SMI# on system management interrupt
Notes:	bit 1 is cleared either with an explicit write of 0 here, or by any
	  write to PORT 00B2h
	bit 0 does not affect the recording of SMI events, so a pending SMI
	  will cause an immediate SMI# when the bit is set
SeeAlso: #0860,#0876,#0877,#0920,PORT 00B2h

Bitfields for Intel 82371/82378/82379 SMI Enable Register:
Bit(s)	Description	(Table 0876)
 15-9	reserved
 8	(82371SB only) Legacy USB SMI enable
 7	APMC Write SMI enable
	=1 generate SMI on write to PORT 00B2h
 6	EXTSMI# SMI enable
 5	Fast-Off Timer SMI enable
 4	IRQ12 (PS/2 mouse) SMI enable
 3	IRQ8 (RTC alarm) SMI enable
 2	IRQ4 (COM1/COM3) SMI enable
 1	IRQ3 (COM2/COM4) SMI enable
 0	IRQ1 (keyboard) SMI enable
SeeAlso: #0860,#0875,#0877,#0911,PORT 00B2h

Bitfields for Intel 82371/82378/82379 System Event Enable Register:
Bit(s)	Description	(Table 0877)
 31	Fast-Off SMI enable (system and break events)
 30	(82379 only) Fast-Off Interrupt Enable (break events only)
 30	(82371 only) INTR enable (break events only)
 29	Fast-Off NMI enable (system and break events)
 28	(82371SB only) Fast-Off APIC enable (break events only)
 27	(82379 only) Fast-Off COM enable (system events only)
 26	(82379 only) Fast-Off LPT enable (system events only)
 25	(82379 only) Fast-Off Drive enable (system events only)
 24	(82379 only) Fast-Off DMA enable (system events only)
 23-16	reserved
 15-3	Fast-Off IRQ (15-3) enable (system and break events)
 2	reserved
 1-0	Fast-Off IRQ (1-0) enable (system and break events)
Note:	any enabled system event restarts the Fast-Off Timer, thus preventing
	  a Fast-Off powerdown; any enabled break event awakens the system from
	  powerdown
SeeAlso: #0860,#0875,#0876,#0878,#0911

Bitfields for Intel 82371/82378/82379 SMI Request Register:
Bit(s)	Description	(Table 0878)
 15-9	reserved
 8	(82371SB only) Legacy USB SMI status
 7	APM SMI Status (write to PORT 00B2h triggered SMI)
 6	EXTSMI# SMI Status (EXTSMI# line triggered SMI)
 5	Fast-Off Timer expired
 4	IRQ12 triggered SMI
 3	IRQ8 triggered SMI
 2	IRQ4 triggered SMI
 1	IRQ3 triggered SMI
 0	IRQ1 triggered SMI
Note:	software must explicitly reset the appropriate bits
SeeAlso: #0860,#0877,#0911

Format of PCI Configuration data for Intel 82425EX PSC:
Offset	Size	Description	(Table 0879)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, device ID 0486h)
 40h	BYTE	PCI control register (see #0880)
 41h  3 BYTEs	???
 44h	BYTE	host device control register (see #0881)
 45h  3 BYTEs	???
 48h	WORD	PCI local-bus IDE control register (see #0882)
 4Ah  2 BYTEs	???
 4Ch	BYTE	ISA I/O recovery timer register (see #0883)
 4Dh	BYTE	part revision register (see #0884)
 4Eh	BYTE	X-bus Chip Select A register (see #0885)
 4Fh	BYTE	X-bus Chip Select B register???
 50h	BYTE	host select register
 51h	BYTE	deturbo frequency control register
		when deturbo mode is selected (see PORT 0CF9h), the chipset
		  places a hold on the memory bus for a fraction of the
		  time inversely proportional to the value in this register
		  (i.e. C0h = 1/4, 80h = 1/2, 40h = 3/4, 20h = 7/8, etc.)
 52h	WORD	secondary (L2) cache control register
 54h  2 BYTEs	???
 56h	WORD	DRAM control register
 58h	BYTE	???
 59h  7 BYTEs	Programmable Attribute Map (PAM) registers 0-6 (see also #0902)
 60h  5 BYTEs	DRAM row boundary registers 0-4
		each register N indicates amount of memory in rows 0-N (each
		  row is 64 bits wide); the fifth row of memory (if
		  implemented) must contain either 8M or 16M, depending on
		  system configuration
		boundary register 4 (offset 64h) contains the total system
		  memory, which may not exceed 128M
 65h	BYTE	???
 66h	BYTE	PIRQ route control register 0
 67h	BYTE	PIRQ route control register 1
 68h	BYTE	DRAM memory hole register
 69h	BYTE	top of memory
 6Ah  6 BYTEs	???
 70h	BYTE	SMRAM control register
 71h 47 BYTEs	unused???
 A0h	BYTE	SMI control register
 A1h	BYTE	???
 A2h	WORD	SMI enable register
 A4h	DWORD	system event enable
 A8h	BYTE	fast off timer register
 A9h	BYTE	???
 AAh	WORD	SMI request register
 ACh	BYTE	clock throttle STPCLK# low timer
 ADh	BYTE	unused???
 AEh	BYTE	clock throttle STPCLK# high timer
 AFh	BYTE	???
 B0h 80 BYTEs	unused???
SeeAlso: #0798,#0859,#0851,#0892,#0911

Bitfields for Intel 82425EX PCI control register:
Bit(s)	Description	(Table 0880)
 0	CPU-to-PCI byte merging
 1	CPU-to-PCI bursting enable
 2	PCI posted-write buffer enable
 4-3	subtractive decode sampling point
	00 slow
	01 typical
	10 fast
	11 reserved
 5	DRAM parity error enable
 6	target abort error enable
 7	reserved
SeeAlso: #0879,#0881,#0882,#0883

Bitfields for Intel 82425EX host device control register:
Bit(s)	Description	(Table 0881)
 0	HRDY# maximum signal sampling point
	0 slow timing
	1 fast timing
 1	HDEV# signal sampling point
	0 slow timing
	1 fast timing
 2	host device present
 7-3	reserved
SeeAlso: #0879,#0880

Bitfields for Intel 82425EX local-bus IDE control register:
Bit(s)	Description	(Table 0882)
 1-0	primary/secondary PCI IDE enable
	00 IDE disabled
	01 primary (ports 01F0h-01F7h,03F6,03F7h)
	10 secondary (ports 0170h-017Fh,0376h,0377h)
	11 reserved
 3-2	fast timing bank drive select 1
	bit 2 = drive 0 enabled
	bit 3 = drive 1 enabled
 5-4	IORDY sample point Enable Drive Select
	bit 4 = drive 0 enabled
	bit 5 = drive 1 enabled
 7-6	reserved
 9-8	IORDY sample point
	00 6 clocks
	01 5 clocks
	10 4 clocks
	11 3 clocks
 12-10	recover time (000 = 8 PCI clocks, 001 = 7, ..., 101 = 3, 110/111 = 3)
 15-13	reserved
SeeAlso: #0879,#0880

Bitfields for Intel chipset ISA I/O recovery timer register:
Bit(s)	Description	(Table 0883)
 1-0	16-bit I/O recovery time
	00 = 4 SYSCLKs
	01-11 = 1-3 SYSCLKs
 2	16-bit I/O recovery enable
 5-3	8-bit I/O recovery time
	000 = 8 SYSCLKs
	001-110 = 1-7 SYSCLKs
 6	8-bit I/O recovery enable
 7	(82425EX/82371) DMA reserved page register aliasing disable
	=0 ports 0090h-009Fh alias ports 0080h-008Fh
	=1 ports 0090h-009Fh forwarded to ISA bus
SeeAlso: #0860,#0879,#0880,#0911

Bitfields for Intel 82425EX part revision register:
Bit(s)	Description	(Table 0884)
 7-5	fabrication house identifier (read-only)
 4	E0000h-EFFFFh ISA-to-main-memory forwarding enabled
 3-0	revision ID (read-only)
SeeAlso: #0879,#0885

Bitfields for Intel 82425EX/82371 X-bus Chip Select A register:
Bit(s)	Description	(Table 0885)
 7	extended BIOS enabled at FFF80000h-FFFDFFFFh
 6	lower (E000h) BIOS enabled
 5	trigger IRQ13 on FERR#
 4	IRQ12 mouse function enabled
 3	reserved (0)
 2	BIOS memory write protect
 1	keyboard controller addresses (60h,62h,64h,66h) enabled
 0	RTC addresses (70h-77h) enabled
SeeAlso: #0879,#0911,#0884

Format of PCI Configuration Data for Intel 82380AB PCI-ISA Bridge:
Offset	Size	Description	(Table 0886)
 00h 64 BYTEs	header (see #0798)
		(vender ID 8086h, device ID 123Ch)
!!!intel\29056301.pdf pg. 9
 40h	BYTE	I/O Recovery Register
 41h	BYTE	reserved
 42h	BYTE	MISA Error Status
 43h 189 BYTEs	reserved
SeeAlso: #0793

Format of PCI Configuration data for Intel 82370FB PCI-PCI Bridge (MPCI2):
Offset	Size	Description	(Table 0887)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, deivce ID 124Bh)
!!!intel\29056701.pdf pg. 13
 40h	BYTE	Connector Control
 41h	BYTE	Connector Event
 42h  2 BYTEs	reserved
 44h	WORD	Serial Bus Interface/Burst Enable
 46h	BYTE	MPCI2 Miscellaneous Status
 47h  5 BYTEs	reserved
 4Ch	WORD	Special Message Encode
 4Eh 178 BYTEs	reserved
SeeAlso: #0793

Format of PCI Configuration Data for Intel 82439HX:
Offset	Size	Description	(Table 0888)
 00h 64 BYTEs	header (see #0798)
		(vender ID 8086h, device ID 1250h)
		(revision ID 00h = A0 stepping)
 40h 16 BYTEs	reserved
 50h	BYTE	PCI Control (see #0894)
 51h	BYTE	reserved
 52h	BYTE	cache control (see #0896)
 53h  3 BYTEs	reserved
 56h	BYTE	DRAM extended control (see #0899)
 57h	BYTE	DRAM control (see #0900)
 58h	BYTE	DRAM timing (see #0901)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #0902)
 60h  8 BYTEs	DRAM Row Boundary registers 0-7
		each register N indicates cumulative amount of memory in rows
		  0-N (each 64 bits wide), in 4M units
 68h	BYTE	DRAM Row Type (see #0903)
		bits 0-7 indicate whether each row 0-7 contains EDO DRAM
		  instead of page-mode DRAM
 69h	BYTE	???
 6Ah  8 BYTEs	reserved
 72h	BYTE	System Management RAM control (see #0906)
 73h 29 BYTEs	reserved
 90h	BYTE	Error Command (see #0909)
 91h	BYTE	Error Status (see #0910) (read-only)
 92h	BYTE	Error Syndrome (read-only)
		latest non-zero ECC error syndrome
 93h 109 BYTEs	reserved
SeeAlso: #0892,#0927

Format of PCI Configuration Data for Intel 82439TX:
Offset	Size	Description	(Table 0889)
 00h 64 BYTEs	header (see #0798)
		(vender ID 8086h, device ID 7100h)
		(revision ID 00h = A0 stepping)
!!!intel\29055901.pdf pg. 23
 40h 15 BYTEs	reserved
 4Fh	BYTE	arbitration control
 50h	BYTE	PCI control
 51h	BYTE	reserved
 52h	BYTE	cache control
 53h	BYTE	extended cache control
 54h	WORD	SDRAM control
 56h	BYTE	DRAM extended control
 57h	BYTE	DRAM control
 58h	BYTE	DRAM timing
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #0902)
 60h  6 BYTEs	DRAM Row Boundary registers 0-5
 66h	BYTE	reserved
 67h	BYTE	DRAM Row Type high
 68h	BYTE	DRAM Row Type low
 69h  2 BYTEs	undefined (read-only)
 6Bh  5 BYTEs	reserved
 70h	BYTE	Multi-Transaction Timer
 71h	BYTE	Extended SMRAM control
 72h	BYTE	System Management RAM control
 73h	BYTE	reserved
 74h	BYTE	undefined (read-only)
 76h  3 BYTEs	reserved
 78h	BYTE	undefined (read-only)
 79h	BYTE	Miscellaneous Control register
 7Ah 131 BYTEs	reserved
 FDh	BYTE	undefined (read-only)
 FEh  2 BYTEs	reserved
SeeAlso: #0793

Format of PCI Configuration Data for Intel 82437MX:
Offset	Size	Description	(Table 0890)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, device ID 1235h)
 40h 16 BYTEs	reserved
 50h	BYTE	PCI Control (see #0895)
 51h	BYTE	reserved
 52h	BYTE	cache control (see #0896)
 53h  4 BYTEs	reserved
 57h	BYTE	DRAM Control (see #0900)
 58h	BYTE	DRAM timing (see #0901)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #0902)
 60h  4 BYTEs	DRAM Row Boundary Registers 0-3
		each register N indicates cumulative amount of memory in rows
		  0-N, in 4M units (each row is 64 bits wide)
 64h  4 BYTEs	reserved
 68h	BYTE	DRAM Row Type (see #0904)
 69h  9 BYTEs	reserved
 72h	BYTE	System Management RAM control (see #0906)
 73h 141 BYTEs	reserved
SeeAlso: #0892,#0891

Format of PCI Configuration Data for Intel 82437FX:
Offset	Size	Description	(Table 0891)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, device ID 122Dh) (see #0793)
 40h 16 BYTEs	reserved
 50h	BYTE	PCI Control (see #0895)
 51h	BYTE	reserved
 52h	BYTE	cache control (see #0896)
 53h  4 BYTEs	reserved
 57h	BYTE	DRAM Control (see #0900)
 58h	BYTE	DRAM timing (see #0901)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #0902)
 60h  5 BYTEs	DRAM Row Boundary Registers 0-4
		each register N indicates cumulative amount of memory in rows
		  0-N, in 4M units (each row is 64 bits wide)
 65h  3 BYTEs	reserved
 68h	BYTE	DRAM Row Type (see #0904)
 69h  9 BYTEs	reserved
 72h	BYTE	System Management RAM control (see #0906)
 73h 141 BYTEs	reserved
SeeAlso: #0890,#0892

Format of PCI Configuration Data for Intel 82437VX:
Offset	Size	Description	(Table 0892)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, device ID 7030h)
		(revision ID 00h = A0 stepping)
 40h 15 BYTEs	reserved
 4Fh	BYTE	arbitration control (see #0893)
 50h	BYTE	PCI Control (see #0894)
 51h	BYTE	reserved
 52h	BYTE	cache control (see #0896)
 53h	BYTE	cache control extensions (see #0897)
 54h	WORD	SDRAM control (see #0898)
 55h	BYTE	reserved
 56h	BYTE	DRAM extended control (see #0899)
 57h	BYTE	DRAM control (see #0900)
 58h	BYTE	DRAM timing (see #0901)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #0902)
 60h  5 BYTEs	DRAM Row Boundary registers 0-4
		each register N indicates amount of memory in rows 0-N in 4M
		  units (each row is 64 bits wide); the fifth row of memory (if
		  implemented) must contain either 8M or 16M, depending on
		  system configuration
		boundary register 4 (offset 64h) contains the total system
		  memory, which may not exceed 128M
 65h  2 BYTEs	reserved
 67h	BYTE	DRAM Row Type (high)
		defines memory type in DRAM row 4 in bits 4,0 (see #0903)
 68h	BYTE	DRAM Row Type (low) (see #0903)
 69h	BYTE	PCI TRDY timer (see #0905)
 6Ah  6 BYTEs	reserved
 70h	BYTE	Multi-Transaction Timer
		number of PCLKs guaranteed to the current agent before the
		  82437 will grant the bus to another PCI agent on request
 71h	BYTE	reserved
 72h	BYTE	System Management RAM control (see #0906)
 73h	BYTE	shared memory buffer control (see #0907)
 74h	BYTE	shared memory buffer start address, in 0.5MB units
		end address is top-of-memory at offset 64h or start of an
		  enabled PCI memory hole when top-of-memory is 16M
 76h  2 BYTEs	reserved
 78h	BYTE	graphics controller latency timers (see #0908)
 79h 135 BYTEs	reserved
SeeAlso: #0793,#0859,#0879,#0888,#0890

Bitfields for Intel 82437VX arbitration control:
Bit(s)	Description	(Table 0893)
 7	extended CPU-to-PIIX PHLDA# signalling enabled
 6-4	reserved
 3	CPU priority enable
	=1 CPU gets PCI bus after two PCI slots
	=0 CPU gets PCI bus after three PCI slots
 2-0	reserved
SeeAlso: #0892,#0894

Bitfields for Intel 82437VX/82439HX PCI Control register:
Bit(s)	Description	(Table 0894)
 7-4	reserved (82437VX)
 7	DRAM ECC/Parity Select (82439HX)
	=1 ECC
	=0 parity
 6	ECC TEST enable (82439HX)
 5	shutdown to port 92h (82439HX)
	=1 send 01h to PORT 0092h on Shutdown special cycle on host bus
 4	dual-processor NA# enable (82439HX)
 3	PCI Concurrency Enable
	=1 CPU can access DRAM/L2 during non-PIIX PCI master cycles
	=0 CPU kept off PCI bus during all PCI bus-master cycles
 2	SERR# Output Type (82439HX only)
	=1 SERR# is actively driven high when negated
	=0 SERR# is PCI-compatible open-drain output
 1	reserved
 0	Global TXC Enable (82439HX only)
	=1 enable new 82439HX features
SeeAlso: #0892,#0888,#0896,#0895

Bitfields for Intel 82437FX/82437MX PCI Control register:
Bit(s)	Description	(Table 0895)
 7-5	CPU inactivity timer (in PCI Clocks less 1)
 4	reserved
 3	enable PCI Peer Concurrency
	=1 CPU can access DRAM/L2 during non-PIIX PCI master cycles
	=0 CPU kept off PCI bus during all PCI bus-master cycles
 2	disable PCI Bursting
 1	disable PCI Streaming
 0	disable Bus Concurrency
SeeAlso: #0890,#0891,#0894

Bitfields for Intel 82437/82439HX cache control register:
Bit(s)	Description	(Table 0896)
 7-6	secondary cache size
	00 none
	01 256K
	10 512K
	11 reserved
 5-4	L2 RAM type
	00 pipelined burst SRAM/DRAM
	01 reserved
	10 asynchronous SRAM (82437FX/MX/VX only)
	11 two banks of pipelined burst cache
 3	NA disable
	=1 never assert NA# pin
 2	reserved (82437FX/82437MX/82437VX)
 2	Extended Cacheability Enable (82439HX)
	=1 cache up to 512M
	=0 cache only first 64M
 1	Secondary Cache Force Miss or Invalidate
	=1 force all memory accesses to bypass L2 cache
 0	First Level Cache Enable
	=1 all memory accesses made non-cacheable by CPU L1 cache
SeeAlso: #0892,#0888,#0894,#0897,#0898,#0890

Bitfields for Intel 82437VX cache control extensions register:
Bit(s)	Description	(Table 0897)
 7-6	reserved
 5	DRAM cache detected (read-only)
 4-0	DRAM cache refresh timer
	number of HCLKs 82437VX remains idle during DRAM cache refresh
SeeAlso: #0892,#0896

Bitfields for Intel 82437VX SDRAM control register:
Bit(s)	Description	(Table 0898)
 15-9	reserved
 8-6	Special SDRAM Mode Select
	000 normal mode (default)
	001 enable NOP command
	010 enable All Banks Precharge command
	011 enable Mode Register Command
	100 enable CBR Cycle
	101 reserved
	11x reserved
 5	reserved
 4	CAS# latency
	=1 latency is 2 for all SDRAM cycles
	=0 latency is 3
 3	RAS# precharge and refresh timing
	=0 slower
	=1 faster
 2-0	reserved
SeeAlso: #0892,#0896

Bitfields for Intel 82437VX/82439HX DRAM extended control register:
Bit(s)	Description	(Table 0899)
 7	reserved
 6	(82437VX) refresh RAS# assertion length (0=4 clocks, 1=5 clocks)
 5	(82437VX) Fast EDO Path Select
 4	Speculative Leadoff Disable
 3	(82439HX) Turn-Around Insertion Enable
	=1 insert one extra clock of turnaround time after asserting MWE#
 2-1	Memory Address Drive Strength
	82437VX:		82439HX:
	    00 reserved		    00 8mA
	    01 10mA (default)	    01 8mA/12mA (MAA/MWE#)
	    10 16mA		    10 12mA/8mA (MAA/MWE#)
	    11 reserved		    11 12mA
 0	(82437VX) DRAM Symmetry Detect Mode
	(used to force some memory address lines to fixed value for detecting
	  DRAM symmetry row-by-row)
 0	(82439HX) 64MBit Mode Enable
	=1 enable support for 64M SIMMs
SeeAlso: #0892,#0888,#0900

Bitfields for Intel 82437/82439HX DRAM control register:
Bit(s)	Description	(Table 0900)
 7-6	DRAM Hole Enable
	00 none
	01 512K-640K
	10 15M-16M (82437FX/MX/VX only)
	11 14M-16M (82437VX only)
 5	reserved
 4	(82437MX only) refresh type during Suspend
	=1 self-refreshing DRAMs in system
	=0 CAS-before-RAS refresh
 3	EDO Detect Mode enable
	(used to detect whether memory is EDO bank-by-bank)
 2-0	DRAM refresh rate
	     FX/VX/HX	MX
	000 disabled	15.6 us
	001 50 MHz	31.2 us
	010 60 MHz	62.4 us
	011 66 MHz	125 us
	100 reserved	250 us
	1xx reserved	reserved
SeeAlso: #0892,#0888,#0899,#0890

Bitfields for Intel 82437FX/82437MX/82437VX/82439HX DRAM timing register:
Bit(s)	Description	(Table 0901)
 7	(82437FX) reserved
 7	(82437MX) MA[11:2] buffer strength
	=0 8mA
	=1 12mA
 7	(82437VX) MA-to-RAS# Delay
	=1 one clock
	=0 two clocks
 7	(82439HX) Turbo Read Leadoff
	=1 bypass first register in DRAM data pipeline, saving one clock
	(may only be set in a cacheless configuration)
 6-5	DRAM Read Burst Timing
	00 x444 (EDO and Standard Page Mode)
	01 x333 (EDO), x444 (SPM)
	10 x222 (EDO), x333 (SPM)
	11 x322 (EDO), x333 (SPM) (82437VX only)
	11 reserved (other)
 4-3	DRAM Write Burst Timing
	00 x444
	01 x333
	10 x222
	11 reserved
 2	RAS-to-CAS Delay
	=1 two clocks
	=0 three clocks
 1-0	DRAM Leadoff Timing
	82437VX Read Leadoff  Write Leadoff  RAS# Precharge
	    00		11	7		3
	    01		10	6		3
	    10		11	7		4
	    11		10	6		4
	82437FX/MX Read Lead  Write Leadoff  RAS# Precharge
	    00		8	6		3
	    01		7	5		3
	    10		8	6		4
	    11		7	5		4
	82437VX Read Leadoff  Write Leadoff  RAS# Precharge
	    00		7	6		3
	    01		6	5		3
	    10		7	6		4
	    11		6	5		4
SeeAlso: #0892,#0900,#0890,#0891

Bitfields for Intel 82434/82437/82439HX Programmable Attribute Map Register:
Bit(s)	Description	(Table 0902)
 7	reserved
 6	cache enable (region 1)
 5	write enable (region 1)
 4	read enable (region 1)
 3	reserved
 2	cache enable (region 0)
 1	write enable (region 0)
 0	read enable (region 0)
Notes:	each programmable attribute map register controls two memory
	  regions at the top of the first megabyte of memory
	for the Intel 82441FX, bits 6 and 2 are reserved, as cacheability is
	  set using the Pentium Pro's MTRR registers (see MSR 000000FEh)
	Intel 82434/82437FX/82437MX/82437VX/82439HX/82441FX PAM
	  registers/regions:
		PAM0 low: reserved [*]
		PAM0 hi:  segment F000-FFFF
		PAM1 low: segment C000-C3FF
		PAM1 hi:  segment C400-C7FF
		PAM2 low: segment C800-CBFF
		PAM2 hi:  segment CC00-CFFF
		PAM3 low: segment D000-D3FF
		PAM3 hi:  segment D400-D7FF
		PAM4 low: segment D800-DBFF
		PAM4 hi:  segment DC00-DFFF
		PAM5 low: segment E000-E3FF
		PAM5 hi:  segment E400-E7FF
		PAM6 low: segment E800-EBFF
		PAM6 hi:  segment EC00-EFFF
	[*] on the 82434 (and possibly other Intel chipsets), the low nybble of
	  PAM0 controls segment 8000-9FFF
SeeAlso: #0851,#0892,#0888,#0927,#0890,#0891

Bitfields for Intel 82437VX DRAM Row Type register:
Bit(s)	Description	(Table 0903)
 7,3	row 3 type
 6,2	row 2 type
 5,1	row 1 type
 4,0	row 0 type
	00 SPM DRAM
	01 EDO DRAM
	10 SDRAM
	11 reserved
SeeAlso: #0892,#0902

Bitfields for Intel 82437FX/82437MX DRAM Row Type register:
Bit(s)	Description	(Table 0904)
 7-4	reserved
 3-0	DRAM Row N is EDO instead of page-mode DRAM
SeeAlso: #0890,#0891

Bitfields for Intel 82437VX PCI TRDY timer:
Bit(s)	Description	(Table 0905)
 7-3	reserved
 2-0	TRDY timeout value
	000 2 PCICLKs
	001 4 PCICLKs
	010 6 PCICLKs
	011 8 PCICLKs
	1xx reserved
SeeAlso: #0892,#0906

Bitfields for Intel 82437/82439HX System Management RAM control register:
Bit(s)	Description	(Table 0906)
 7	reserved
 6	SMM Space Open
	=1 make SMM DRAM visible even when not in SMM if bit 4 =0
 5	SMM Space Closed
	=1 no data references permitted to SMM DRAM even in SMM
 4	SMM Space Locked
	=1 force bits 4 and 6 to become read-only; and clear bit 6
 3	SMRAM Enable
	=1 128K DRAM are accessible for use at A000 while in SMM
 2-0	SMM Space Base Segment
	010 segment A000-BFFF
	100 segment C000-CFFF (82437MX only)
	other reserved
Note:	bits 5 and 6 must never both be set at the same time
SeeAlso: #0892,#0888,#0907,#0890,#0891

Bitfields for Intel 82437VX Shared Memory Buffer control register:
Bit(s)	Description	(Table 0907)
 7-2	reserved
 1	enable shared memory buffer
 0	redirect shared memory buffer access
	=0 treat SMB area as a hole in system DRAM
SeeAlso: #0892,#0906,#0908

Bitfields for Intel 82437VX Graphics Controller Latency Timer:
Bit(s)	Description	(Table 0908)
 7-6	reserved
 5-3	GC latency for PCI reads (in 4 HCLK multiples) (default=100)
 2-0	GC latency for CPU and PCI writes (in 4 HCLK multiples) (default=011)
SeeAlso: #0892,#0907

Bitfields for Intel 82439HX Error Command register:
Bit(s)	Description	(Table 0909)
 7	SERR# duration
	=0 one PCI clock
	=1 until error flags are cleared
 6-3	reserved
 2	force bad parity on multiple-bit uncorrectable error
 1	assert SERR# on multiple-bit uncorrectable error
 0	assert SERR# on single-bit correctable error
SeeAlso: #0888,#0910

Bitfields for Intel 82439HX Error Status register:
Bit(s)	Description	(Table 0910)
 7-5	DRAM row associated with multi-bit error
 4	multi-bit uncorrectable error occurred (write 1 bit to clear)
 3-1	DRAM row associated with single-bit correctable error
 0	single-bit correctable error occurred (write 1 bit to clear)
SeeAlso: #0888,#0909

Format of PCI Configuration for Intel 82371FB/82371SB Function 0 (ISA Bridge):
Offset	Size	Description	(Table 0911)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, device ID 122Eh/7000h)
		(revision ID 00h = 82371SB step A-1)
		(revision ID 01h = 82371SB step B-0)
 40h 12 BYTEs	reserved
 4Ch	BYTE	ISA I/O Controller Recovery Timer (see #0883)
 4Dh	BYTE	reserved
 4Eh	BYTE	X-Bus Chip Select Enable (see #0885)
 4Fh	BYTE	(82371SB) X-Bus Chip Select Enable High
		bit 0: I/O APIC enabled
 4Fh	BYTE	(82371FB) reserved
 50h 16 BYTEs	reserved
 60h  4 BYTEs	PCI IRQ Route Control (see #0872)
 64h  5 BYTEs	reserved
 69h	BYTE	top of memory (see #0914)
 6Ah	WORD	miscellaneous status (see #0915)
 6Ch  4 BYTEs	reserved
 70h	BYTE	motherboard IRQ Route Control 0 (see #0916)
 71h	BYTE	(82371FB) motherboard IRQ Route Control 1 (see #0916)
 72h  4 BYTEs	reserved
 76h  2 BYTEs	motherboard DMA control (see #0917)
 78h	WORD	programmable chip select control (see #0918)
 7Ah  6 BYTEs	reserved
 80h	BYTE	(82371SB) APIC Base Address Relocation (see #0874)
 81h	BYTE	reserved
 82h	BYTE	(82371SB) Deterministic Latency Control (see #0919)
 83h 29 BYTEs	reserved
 A0h	BYTE	SMI Control (see #0920)
 A1h	BYTE	reserved
 A2h	WORD	SMI Enable (see #0876)
 A4h	DWORD	System Event Enable (SEE) (see #0877)
 A8h	BYTE	Fast-Off Timer (in minutes, PCICLKs, or milliseconds)
		value is count less one; timer must be stopped before
		  changing its value
 A9h	BYTE	reserved
 AAh	WORD	SMI Request (see #0878)
 ACh	BYTE	Clock Scale STPCLK# Low Timer
		STPCLK# stays low for 1+1056*(value+1) PCICLKs
 ADh	BYTE	reserved
 AEh	BYTE	Clock Scale STPCLK# High Timer
		STPCLK# stays high for 1+1056*(value+1) PCICLKs
 AFh 81 BYTEs	reserved
SeeAlso: #0912,#0913,#0860,#0879,#0892,#0888

Format of PCI Configuration for Intel 82371FB/82371SB Function 1 (IDE):
Offset	Size	Description	(Table 0912)
 00h 64 BYTEs	header (see #0798)
		(vender ID 8086h, device ID 1230h/7010h)
 20h	DWORD	Bus Master Interface Base Address
		(see PORT xxxxh"Intel 82371SB")
 40h	WORD	IDE timing modes, primary channel (see #0921)
 42h	WORD	IDE timing modes, secondary channel (see #0921)
 44h	BYTE	(82371SB) slave IDE timing register (see #0922)
 45h 187 BYTEs	reserved
SeeAlso: #0911,#0913,PORT xxxxh"Intel 82371SB"

Format of PCI Configuration data for Intel 82371SB Function 2 (USB):
Offset	Size	Description	(Table 0913)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, device ID 7020h)
 20h	DWORD	I/O space base address
		(see PORT xxxxh"Intel 82371SB")
 40h 32 BYTEs	reserved
 60h	BYTE	Serial Bus Specification release number
		00h pre-release 1.0
		10h Release 1.0
 61h  9 BYTEs	reserved
 6Ah	WORD	miscellaneous status (see #0923)
 6Ch 84 BYTEs	reserved
 C0h	WORD	legacy support (see #0924)
 C2h 62 BYTEs	reserved
SeeAlso: #0911,#0912,PORT xxxxh"Intel 82371SB"

Bitfields for Intel 82371FB/82371SB top of memory register:
Bit(s)	Description	(Table 0914)
 7-4	top of ISA memory (in megabytes, less 1; i.e. 0001 = 2M)
 3	ISA/DMA lower BIOS forwarding enable
 2	(82371SB) enable A000/B000 segment forwarding to PCI bus
 1	enable forwarding ISA/DMA 512K-640K region to PCI bus
 0	reserved
SeeAlso: #0911,#0915

Bitfields for Intel 82371FB/82371SB miscellaneous status register:
Bit(s)	Description	(Table 0915)
 15	(82371SB) enable SERR# on delayed transaction
	write 1 to clear this bit
 14-8	reserved
 7	(82371SB) NB Retry Enable
 6	(82371SB) EXTSMI# Mode Enable
	allow special SERR# protocol between PCI bridge and 82371
 5	reserved
 4	(82371SB) enable USB
	disable USB's master enable and I/O decode enable prior to
	 clearing this bit!
 3	reserved
 2	(82371FB) PCI Header Type Bit enable
	=1 report multifunction device in PCI configuration header
 1	(82371FB) internal ISA DMA/external DMA Mode status (read-only)
	=0 normal DMA operation
 0	(82371FB) ISA Clock Divisor status (read-only)
	(82371SB) ISA Clock Divisor (read-write)
	=1 SYSCLK clock divisor is 3
	=0 SYSCLK clock divisor is 4
SeeAlso: #0911,#0914

Bitfields for Intel 82371FB/82371SB motherboard IRQ Route Control:
Bit(s)	Description	(Table 0916)
 7	disable IRQ routing
 6	enable MIRQx/IRQx sharing
 5	(82371SB) enable IRQ0 output
 4	reserved (0)
 3-0	ISA IRQ number to which to route the PCI IRQ
Note:	IRQs 0-2, 8, and 13 are reserved
SeeAlso: #0911,#0914,#0917

Bitfields for Intel 82371FB/82371SB motherboard DMA control:
Bit(s)	Description	(Table 0917)
 7	type F and DMA buffer enable
 6-4	reserved
 3	(82371FB) disable motherboadr DMA channel
 2-0	DMA channel number
	(82371FB) Type F and Motherboard DMA
	(82371SB) Type F DMA
SeeAlso: #0911,#0916

Bitfields for Intel 82371FB/83271SB programmable chip select control register:
Bit(s)	Description	(Table 0918)
 15-2	I/O address which will assert PCS# signal
 1-0	PCS address mask
	00 four bytes
	01 eight contiguous bytes
	10 disabled
	11 sixteen contiguous bytes
SeeAlso: #0911,#0917,#0919

Bitfields for Intel 82371SB Deterministic Latency Control register:
Bit(s)	Description	(Table 0919)
 7-4	reserved
 3	enable SERR# on delayed transaction timeout
 2	enable USB passive release
 1	enable passive release
 0	enable delayed transactions
SeeAlso: #0911,#0918

Bitfields for Intel 82371FB/82371SB SMI Control Register:
Bit(s)	Description	(Table 0920)
 7-5	reserved
 4-3	Fast-Off Timer freeze/granularity selection
	00 one minute granularity (assuming 33 MHz PCICLK)
	01 disabled (frozen)
	10 one PCICLK
	11 one millisecond
 2	STPCLK# scaling enable
	=1 enable Clock Scale bytes in PCI configuration space
 1	STPCLK# signal enable
	=1 assert STPCLK# on read from PORT 00B2h
 0	SMI# Gate
	=1 enable SMI# on system management interrupt
Notes:	bit 1 is cleared either with an explicit write of 0 here, or by any
	  write to PORT 00B2h
	bit 0 does not affect the recording of SMI events, so a pending SMI
	  will cause an immediate SMI# when the bit is set
SeeAlso: #0911,#0875

Bitfields for Intel 82371FB/82371SB IDE timing modes:
Bit(s)	Description	(Table 0921)
 15	IDE decode enable
 14	(82371SB) slave IDE timing register enable (see #0922)
 13-12	IORDY# sample point
	00 five clocks after DIOx# assertion
	01 four clocks
	10 three clocks
	11 two clocks
 11-10	reserved
 9-8	recovery time between IORDY# sample point and DIOx#
	00 four clocks
	01 three clocks
	10 two clocks
	11 one clock
 7	DMA timing enable only, drive 1
 6	prefetch and posting enable, drive 1
 5	IORDY# sample point enable drive select 1
 4	fast timing bank drive select 1
 3	DMA timing enable only, drive 0
 2	prefetch and posting enable, drive 0
 1	IORDY# sample point enable drive select 0
 0	fast timing bank drive select 0
SeeAlso: #0912

Bitfields for Intel 82371SB slave IDE timing register:
Bit(s)	Description	(Table 0922)
 7-6	secondary drive 1 IORDY# sample point
	00 five clocks after DIOx# assertion
	01 four clocks
	10 three clocks
	11 two clocks
 5-4	secondary drive 1 recovery time
	00 four clocks
	01 three clocks
	10 two clocks
	11 one clock
 3-2	primary drive 1 IORDY# sample point
 1-0	primary drive 1 recovery time
SeeAlso: #0921

Bitfields for Intel 82371SB miscellaneous status:
Bit(s)	Description	(Table 0923)
 15-1	reserved
 0	USB clock selection
	=1 48 MHz
	=0 24 MHz
SeeAlso: #0913,#0924

Bitfields for Intel 82371SB legacy support register:
Bit(s)	Description	(Table 0924)
 15	A20GATE pass-through sequence ended
	write 1 to clear this bit
 14	reserved
 13	USB PIRQ enabled
 12	USR IRQ status (read-only)
 11	trap caused by write to PORT 0064h
	write 1 to clear this bit
 10	trap caused by read from PORT 0064h
	write 1 to clear this bit
 9	trap caused by write to PORT 0060h
	write 1 to clear this bit
 8	trap caused by read from PORT 0060h
	write 1 to clear this bit
 7	enable SMI at end of A20GATE Pass-Through
 6	A20GATE pass-through sequence in progress (read-only)
 5	enable A20GATE pass-through sequence
	(write PORT 64h,D1h; write 60h,xxh; read 64h; write 64h,FFh)
 4	enable trap/SMI on USB IRQ
 3	enable trap/SMI on PORT 0064h write
 2	enable trap/SMI on PORT 0064h read
 1	enable trap/SMI on PORT 0060h write
 0	enable trap/SMI on PORT 0060h read
SeeAlso: #0913,#0923

Format of PCI Configuration Data for Intel 82557:
Offset	Size	Description	(Table 0925)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, device ID 1229h) (see #0793)
 10h	DWORD	base address of memory-mapped Control/Status Registers (4K)
		(see #0926)
 14h	DWORD	base address of I/O-mapped Control/Status Registers (32 ports)
 18h	DWORD	base address of Flash memory (1M)
 40h 192 BYTEs	unused
SeeAlso: #0888

Format of Intel 82557 Control/Status Registers:
Offset	Size	Description	(Table 0926)
 00h	WORD	SCB status word
 02h	WORD	SCB command word
 04h	DWORD	SCB general pointer
 08h	DWORD	PORT
 0Ch	WORD	Flash control register
 0Eh	WORD	EEPROM control register
 10h	DWORD	MDI control register
 14h	DWORD	Early RCV Interrupt Rx byte count (RXBC) register
Note:	see 64434604.pdf for additional details
SeeAlso: #0926

Format of PCI Configuration Data for Intel 82441FX:
Offset	Size	Description	(Table 0927)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, device ID 1237h) (see #0793)
 40h 16 BYTEs	reserved
 50h	WORD	PMC Configuration (see #0928)
 52h	BYTE	deturbo counter control
		when deturbo mode is selected (see PORT 0CF9h), the chipset
		  places a hold on the memory bus for a fraction of the
		  time inversely proportional to the value in this register
		  (i.e. C0h = 1/4, 80h = 1/2, 40h = 3/4, 20h = 7/8, etc.)
 53h	BYTE	DBX buffer control (see #0929)
 54h	BYTE	auxiliary control (see #0930)
 55h	WORD	DRAM Row Type (see #0931)
 57h	BYTE	DRAM Control (see #0932)
 58h	BYTE	DRAM Timing (see #0933)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #0902)
 60h  8 BYTEs	DRAM Row Buondary registers 0-7
		each register N indicates cumulative amount of memory in rows
		  0-N (each 64 bits wide), in 8M units
 68h	BYTE	Fixed DRAM Hole Control
 69h  7 BYTEs	reserved
 70h	BYTE	Multi-Transaction Timer
		number of PCLKs guaranteed to the current agent before the
		  82441 will grant the bus to another PCI agent on request
 71h	BYTE	CPU Latency Timer (see #0934)
 72h	BYTE	System Management RAM control (see #0906)
 73h 29 BYTEs	reserved
 90h	BYTE	Error Command (see #0935)
 91h	BYTE	Error Status (see #0936)
 92h	BYTE	reserved
 93h	BYTE	Turbo Reset Control (see #0937)
 94h 108 BYTEs	reserved
SeeAlso: #0888,#0892

Bitfields for Intel 82441FX PMC Configuration Register:
Bit(s)	Description	(Table 0928)
 15	WSC Protocol Enable
 14	Row Select/Extra Copy select (read-only)
	=1 pins on PMC configured as two additional row selects (6/7)
	=0 extra copy of two lowest memory address bits enabled
 13-10	reserved
 9-8	host frequence select
	00 reserved
	01 60 MHz
	10 66 MHz
	11 reserved
 7	reserved
 6	ECC/Parity TEST enable
 5-4	DRAM Data Integrity Mode
	00 no parity/ECC
	01 parity generated and checked
	10 ECC generated and checked, correction disabled
	10 ECC generated and checked, correction enabled
 3	reserved
 2	In-Order Queue size (0=one, 1=four)
 1-0	reserved
SeeAlso: #0927,#0929

Bitfields for Intel 82441FX DBX buffer control register:
Bit(s)	Description	(Table 0929)
 7	enable delayed transactions
 6	enable CPU-to-PCI IDE posting
 5	enable USWC Write Post during I/O Bridge access
 4	disable PCI Delayed Transaction timer
 3	enable CPU-to-PCI Write Post
 2	enable PCI-to-DRAM pipeline
 1	enable PCI Burst Write Combining
 0	enable Read-Around-Write
SeeAlso: #0927,#0928

Bitfields for Intel 82441FX auxiliary control register:
Bit(s)	Description	(Table 0930)
 7	enable RAS precharge
 6-2	reserved
 1	Lower Memory Address Buffer Set A
	=0 8mA
	=1 12mA
 0	reserved
SeeAlso: #0927

Bitfields for Intel 82441FX DRAM Row Type register:
Bit(s)	Description	(Table 0931)
 15-14	row 7 DRAM type
 13-12	row 6 DRAM type
 11-10	row 5 DRAM type
 9-8	row 4 DRAM type
 7-6	row 3 DRAM type
 5-4	row 2 DRAM type
 3-2	row 1 DRAM type
 1-0	row 0 DRAM type
	00 fast page-mode DRAM
	01 EDO DRAM
	10 BEDO DRAM
	11 empty row
SeeAlso: #0927,#0932

Bitfields for Intel 82441FX DRAM Control register:
Bit(s)	Description	(Table 0932)
 7	reserved
 6	enable DRAM Refresh Queue
 5	enable DRAM EDO Auto-Detect Mode
 4	DRAM Refresh Type
	=0 CAS before RAS
	=1 RAS only
 3	reserved
 2-0	DRAM refresh rate
	000 disabled
	001 normal (as set by PMCCFG register)
	01x reserved
	1xx reserved
	111 fast refresh (every 32 host clocks)
SeeAlso: #0927,#0931,#0933

Bitfields for Intel 82441FX DRAM Timing register:
Bit(s)	Description	(Table 0933)
 7	reserved
 6	enable WCBR Mode
 5-4	DRAM Read Burst Timing
		BEDO	EDO	FPM
	00	x333	x444	x444
	01	x222	x333	x444
	10	x222	x222	x333
	11	res.	res.	res.
 3-2	DRAM Write Burst Timing
		(B)EDO	FPM
	00	x444	x444
	01	x333	x444
	10	x333	x333
	11	x222	x333
 1	RAS-to-CAS delay
	=1 one clock
	=0 zero clocks
 0	insert one MA Wait State
SeeAlso: #0927,#0932

Bitfields for Intel 82441FX CPU Latency Timer register:
Bit(s)	Description	(Table 0934)
 7-5	reserved
 4-0	snoop stall count value
SeeAlso: #0927

Bitfields for Intel 82441FX Error Command register:
Bit(s)	Description	(Table 0935)
 7-5	reserved
 4	enable SERR# on receiving Target Abort
 3	enable SERR# on PCI Parity Error (PERR#)
 2	reserved
 1	enable SERR# on receiving multiple-bit ECC/Parity error
 0	enable SERR# on receiving single-bit ECC error
SeeAlso: #0927,#0936

Bitfields for Intel 82441FX Error Status register:
Bit(s)	Description	(Table 0936)
 7-5	DRAM row causing first multi-bit error (read-only)
 4	multiple-bit uncorrectable error detected
	write 1 to this bit to clear it
 3-1	DRAM row causing first single-bit error (read-only)
 0	single-bit correctable ECC error detected
	write 1 to this bit to clear it
SeeAlso: #0927,#0935

Bitfields for Intel 82441FX Turbo Reset Control register:
Bit(s)	Description	(Table 0937)
 7-4	reserved
 3	enable BIST on hard reset
 2	reset CPU
 1	reset mode
	0 soft reset
	1 hard reset
 0	deturbo mode
SeeAlso: #0927,PORT 0CF9h

Format of PCI Configuration data for Intel 82454KX/GX:
Offset	Size	Description	(Table 0938)
 00h 64 BYTEs	header (see #0798)
		(vendor ID 8086h, device ID 84C4h)
!!!intel\29052301.pdf pg. 40
 40h	DWORD	top of system memory
 44h  4 BYTEs	reserved
 48h	BYTE	PCI decode mode
 49h	BYTE	bridge device number
 4Ah	BYTE	PCI bus number
 4Bh	BYTE	PCI subordinate bus number
 4Ch	BYTE	PB configuration
 4Dh  4 BYTEs	reserved
 51h	BYTE	deturbo counter control
 52h	BYTE	reserved
 53h	BYTE	CPU read/write control
 54h	WORD	PCI read/write control
 56h	BYTE	reserved
 57h	BYTE	SMM Enable
 58h	BYTE	video buffer area enable
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #0902)
 60h 16 BYTEs	reserved
 70h	BYTE	Error Command
 71h	BYTE	Error Status
 72h  6 BYTEs	reserved
 78h	WORD	memory gap range
 7Ah	WORD	memory gap upper address
 7Ch	DWORD	PCI frame buffer
 80h  8 BYTEs	reserved
 88h	DWORD	high memory gap start address
 8Ch	DWORD	high memory gap end address
 90h  8 BYTEs	reserved
 98h	DWORD	(GX only) I/O Space Range #1
 9Ch	BYTE	PCI reset
 9Dh  3 BYTEs	reserved
 A0h	DWORD	(GX only) I/O Space Range #2
 A4h	DWORD	I/O APIC range
 A8h  8 BYTEs	reserved
 B0h	WORD	configuration values driven on reset
 B2h  2 BYTEs	reserved
 B4h	WORD	captured system configuration values (read-only)
 B6h  2 BYTEs	reserved
 B8h	DWORD	SMM range
 BCh	BYTE	high BIOS register
 BDh  3 BYTEs	reserved
 C0h	DWORD	PB Extended Error Reporting Command
 C4h	DWORD	PB Extended Error Reporting Status
 C8h	DWORD	PB Retry Timers
 CCh 52 BYTEs	reserved
SeeAlso: #0798
--------X-1AB10B-----------------------------
INT 1A - PCI BIOS v2.0c+ - WRITE CONFIGURATION BYTE
	AX = B10Bh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
	CL = byte to write
Return: CF clear if successful
	CF set on error
	AH = status (00h,87h) (see #0653)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B108h,AX=B10Ch,AX=B10Dh,AX=B18Bh,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10C-----------------------------
INT 1A - PCI BIOS v2.0c+ - WRITE CONFIGURATION WORD
	AX = B10Ch
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 2 less than 0100h)
	CX = word to write
Return: CF clear if successful
	CF set on error
	AH = status (00h,87h) (see #0653)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B109h,AX=B10Bh,AX=B10Dh,AX=B18Ch,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10D-----------------------------
INT 1A - PCI BIOS v2.0c+ - WRITE CONFIGURATION DWORD
	AX = B10Dh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 4 less than 0100h)
	ECX = dword to write
Return: CF clear if successful
	CF set on error
	AH = status (00h,87h) (see #0653)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Bh,AX=B10Ch,AX=B18Dh,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10EBX0000-----------------------
INT 1A - PCI BIOS v2.1+ - GET IRQ ROUTING INFORMATION
	AX = B10Eh
	BX = 0000h
	DS = segment/selector for PCI BIOS data
	    (real mode: F000h; 16-bit PM: physical 000F0000h; 32-bit PM: as
	    specified by BIOS32 services directory)
	ES:(E)DI -> IRQ routing table header (see #0955 at AX=B406h)
Return: CF clear if successful
	    AH = 00h
	    BX = bit map of IRQ channels permanently dedicated to PCI
	    WORD ES:[DI] = size of returned data
	CF set on error
	    AH = error code (59h) (see #0939)
	    WORD ES:[DI] = required size of buffer
SeeAlso: AX=B10Fh,AX=B406h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10F-----------------------------
INT 1A - PCI BIOS v2.1+ - SET PCI IRQ
	AX = B10Fh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	CH = number of IRQ to connect
	CL = number of interrupt pin (0Ah=INTA# to 0Dh=INTD#) to reprogram
	DS = segment/selector for PCI BIOS data
	    (real mode: F000h; 16-bit PM: physical 000F0000h; 32-bit PM: as
	    specified by BIOS32 services directory)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (59h) (see #0939)
Note:	assumes that the calling application has determined the IRQ routing
	  topology (see AX=B10Eh), has ensured that the selected IRQ will not
	  cause a conflict, and will update the interrupt line configuration
	  register on all devices which currently use the IRQ line
SeeAlso: AX=B10Eh
--------X-1AB181-----------------------------
INT 1A - PCI BIOS v2.0c+ - INSTALLATION CHECK (32-bit)
	AX = B181h
Return: as for AX=B101h
SeeAlso: AX=B101h
--------X-1AB182-----------------------------
INT 1A - PCI BIOS v2.0c+ - FIND PCI DEVICE (32-bit)
	AX = B182h
	CX = device ID (see #0659,#0665,#0666,#0793,#0795)
	DX = vendor ID (see #0656 at AX=B102h)
	SI = device index (0-n)
Return: as for AX=B102h
SeeAlso: AX=B102h
--------X-1AB183-----------------------------
INT 1A - PCI BIOS v2.0c+ - FIND PCI CLASS CODE (32-bit)
	AX = B183h
	ECX = class code (bits 23-0)
	SI = device index (0-n)
Return: as for AX=B103h
SeeAlso: AX=B103h
--------X-1AB186-----------------------------
INT 1A - PCI BIOS v2.0c+ - PCI BUS-SPECIFIC OPERATIONS (32-bit)
	AX = B186h
	BH = bus number
	EDX = Special Cycle data
Return: as for AX=B106h
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B106h
--------X-1AB188-----------------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION BYTE (32-bit)
	AX = B188h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
Return: as for AX=B108h
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B108h,AX=B189h,AX=B18Ah
--------X-1AB189-----------------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION WORD (32-bit)
	AX = B189h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
Return: as for AX=B109h
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B109h,AX=B188h,AX=B18Ah
--------X-1AB18A-----------------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (32-bit)
	AX = B18Ah
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
Return: as for AX=B10Ah
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B188h,AX=B189h
--------X-1AB18B-----------------------------
INT 1A - PCI BIOS v2.0c+ - WRITE CONFIGURATION BYTE (32-bit)
	AX = B18Bh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
	CL = byte to write
Return: as for AX=B10Bh
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Bh,AX=B18Ch,AX=B18Dh
--------X-1AB18C-----------------------------
INT 1A - PCI BIOS v2.0c+ - WRITE CONFIGURATION WORD (32-bit)
	AX = B18Ch
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 2 less than 0100h)
	CX = word to write
Return: as for AX=B10Ch
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ch,AX=B18Bh,AX=B18Dh
--------X-1AB18D-----------------------------
INT 1A - PCI BIOS v2.0c+ - WRITE CONFIGURATION DWORD (32-bit)
	AX = B18Dh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 4 less than 0100h)
	ECX = dword to write
Return: as for AX=B10Dh
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Dh,AX=B18Bh,AX=B18Ch
--------X-1AB18EBX0000-----------------------
INT 1A - PCI BIOS v2.1+ - GET IRQ ROUTING INFORMATION (32-bit)
	AX = B18Eh
	BX = 0000h
	DS = segment/selector for PCI BIOS data
	    (real mode: F000h; 16-bit PM: physical 000F0000h; 32-bit PM: as
	    specified by BIOS32 services directory)
	ES:(E)DI -> IRQ routing table header (see #0955 at AX=B406h)
Return: CF clear if successful
	    AH = 00h
	    BX = bit map of IRQ channels permanently dedicated to PCI
	    WORD ES:[DI] = size of returned data
	CF set on error
	    AH = error code (59h) (see #0939)
	    WORD ES:[DI] = required size of buffer
SeeAlso: AX=B10Fh,AX=B406h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB18F-----------------------------
INT 1A - PCI BIOS v2.1+ - SET PCI IRQ (32-bit)
	AX = B18Fh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	CH = number of IRQ to connect
	CL = number of interrupt pin (0Ah=INTA# to 0Dh=INTD#) to reprogram
	DS = segment/selector for PCI BIOS data
	    (real mode: F000h; 16-bit PM: physical 000F0000h; 32-bit PM: as
	    specified by BIOS32 services directory)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (59h) (see #0939)
Note:	assumes that the calling application has determined the IRQ routing
	  topology (see AX=B10Eh), has ensured that the selected IRQ will not
	  cause a conflict, and will update the interrupt line configuration
	  register on all devices which currently use the IRQ line
SeeAlso: AX=B10Eh
--------X-1AB2-------------------------------
INT 1A - Reserved For PCI
	AH = B2h
--------X-1AB3-------------------------------
INT 1A - Reserved For PCI
	AH = B3h
--------X-1AB400-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - INSTALLATION CHECK
	AX = B400h
Return: CF clear if installed
	AX = 0000h if installed
	    BH = ACFG major version (02h)
	    BL = ACFG minor version (08h)
	    CX = ??? (0002h)
	    EDX = 47464341h ('GFCA', which is byte-swapped 'ACFG')
	    SI = ??? (001Fh)
SeeAlso: AX=B401h,AX=B402h,AX=B403h,AX=B404h,AX=B405h,AX=B406h,AX=B407h
SeeAlso: @xxxxh:xxxxh"Plug-and-Play"

(Table 0939)
Values for Intel Plug-and-Play AUTO-CONFIGURATION error codes:
 0000h	successful
 0001h	specified action could not be completed
 0051h	???
 0055h	unable to read/write configuration table from/to nonvolatile storage
 0056h	not a valid configuration table or wrong table version
 0059h	buffer too small
 0081h	unsupported function
 FFFFh	???
SeeAlso: #F055
--------X-1AB401-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET DEFAULT CONFIG TABLE
	AX = B401h
Return: CF clear if successful
	    AX = 0000h
	    BX = maximum size of configuration table in bytes
	    CX = required configuration buffer size
		(includes scratch space used by ACFG code)
	    EDI = linear/physical address of ESCD table (see #0940)
	CF set on error
	    AX = error code (see #0939)
SeeAlso: AX=B400h,AX=B402h,@xxxxh:xxxxh"Plug-and-Play"

Format of Intel Plug-and-Play Extended System Configuration Data table:
Offset	Size	Description	(Table 0940)
 00h	WORD	total length of this table
 02h  4 BYTEs	signature "ACFG"
 06h	BYTE	minor version number
 07h	BYTE	major version number (currently 02h)
 08h	BYTE	number of boards listed in the configuration data
 09h  3 BYTEs	reserved (00h)
 0Ch	var	board data
	WORD	checksum
Notes:	this table contains information about the standard devices in the
	  system, such as serial ports, parallel ports, etc.  For each device,
	  it includes at least the I/O port address (03F8h,02F8h,0378h,etc).
	the sum of all words in the table, including the checksum field (with
	  implied zero padding if the length is odd), must equal 0000h
SeeAlso: #0941

Format of Extended System Configuration Data Board Header:
Offset	Size	Description	(Table 0941)
 00h	WORD	length of this header in bytes
 02h	BYTE	slot number
		00h motherboard
		01h-0Fh ISA/EISA
		10h-40h	PCI
 03h	BYTE	reserved (00h)
SeeAlso: #0940,#0942

Format of Extended System Configuration Data Freeform Board Header:
Offset	Size	Description	(Table 0942)
 00h  4 BYTEs	signature "ACFG"
 04h	BYTE	minor version number
 05h	BYTE	major version number (currently 02h)
 06h	BYTE	board type
		01h ISA
		02h EISA
		04h PCI
		08h PCMCIA
		10h PnPISA
		20h MCA
 07h	BYTE	reserved (00h)
 08h	WORD	disabled functions (bit N set = function N disabled)
 0Ah	WORD	configuration error functions
 0Ch	WORD	reconfigurable functions (bit N set = function N reconfig'able)
 0Eh  2 BYTEs	reserved (00h)
SeeAlso: #0945,#0946

Format of Extended System Configuration Data Freeform PCI Device Data:
Offset	Size	Description	(Table 0943)
 00h	BYTE	PCI bus number
 01h	BYTE	PCI device and function number
 02h	WORD	PCI device identifier
 04h	WORD	PCI vendor ID (see #0656 at INT 1A/AX=B102h)
 06h  2 BYTEs	reserved (00h)
SeeAlso: #0943,#0946

Format of Extended System Configuration Data Freeform PnP ISA Board ID:
Offset	Size	Description	(Table 0944)
 00h	DWORD	vendor ID (EISA device identifier)
 04h	DWORD	serial number
SeeAlso: #0944,#0945

Format of Extended System Configuration Data PnP ISA ECD Extension Function:
Offset	Size	Description	(Table 0945)
 00h	WORD	001Eh (length of this structure)
 02h	BYTE	01h (selection size)
 03h	BYTE	00h (selection data)
 04h	BYTE	C0h (function information byte) (see #0948)
 05h	BYTE	18h (size of following free-format data)
 06h 16 BYTEs	freeform board header (see #0942)
 16h  8 BYTEs	Plug-and-Play board ID (see #0944)
Note:	ECD = Extended Configuration Data; this structure must be the last
	  "function" for a particular ISA Plug-and-Play board
SeeAlso: #0946

Format of Extended System Configuration Data PCI ECD Extension Function:
Offset	Size	Description	(Table 0946)
 00h	WORD	length of this structure (at least 001Eh, up to 0056h)
 02h	BYTE	01h (selection size)
 03h	BYTE	00h (selection data)
 04h	BYTE	C0h (function information byte) (see #0948)
 05h	BYTE	size of following free-format data (at least 18h, max 50h)
 06h 16 BYTEs	freeform board header (see #0942)
 16h 8N BYTEs	PCI board ID (see #0943) for one to eight boards
Notes:	ECD = Extended Configuration Data; this structure must be the last
	  "function" for a particular PCI board
	AMI BIOS v1.00.05.AX1 sets the length field to 001Ch for entries with
	  a single board ID, apparently treating the field as the length of
	  the remainder of the structure instead of the full structure's length
SeeAlso: #0945

Bitfields for EISA ID and Slot Information:
Bit(s)	Description	(Table 0947)
 3-0	selector among duplicate configuration file names (0000 if no dups)
 5-4	slot type
	00 expansion slot
	01 embedded
	10 virtual slot
	11 reserved
 6	ID is readable
 7	duplicate IDs present
 8	board can be disabled
 9	IOCHKERR supported
 10	board or entries locked
 13-11	reserved
 14	board does not have or need configuration file
 15	configuration not complete
SeeAlso: #0948

Bitfields for EISA Function Information:
Bit(s)	Description	(Table 0948)
 0	subtype data
 1	memory information (see #0949)
 2	IRQ information (see #0951)
 3	DMA information (see #0952)
 4	port range information (see #0953)
 5	port initialization data (see #0954)
 6	free form data
 7	function disabled
SeeAlso: #0945,#0946,#0947

Format of EISA Memory Information:
Offset	Size	Description	(Table 0949)
 00h	WORD	memory information flags (see #0950)
 02h  3 BYTEs	high 24 bits of memory start address (LSB first)
 05h	WORD	memory size in K (0000h = 65536K)
SeeAlso: #0948

Bitfields for EISA Memory Information Flags:
Bit(s)	Description	(Table 0950)
 0	writable (RAM rather than ROM)
 1	cached
 2	write-back cache rather than write-through
 4-3	memory type
	00 system
	01 expantion
	10 virtual
	11 other
 5	shared
 6	reserved (0)
 7	more entries follow
 9-8	memory width
	00 byte
	01 word
	10 dword
	11 reserved
 11-10	decoded address lines
	00 = 20
	01 = 24
	10 = 32
	11 reserved
 15-12	reserved (0)
SeeAlso: #0949

Bitfields for EISA IRQ Information:
Bit(s)	Description	(Table 0951)
 3-0	IRQ number
 4	reserved (0)
 5	IRQ triggering (0 = edge, 1 = level)
 6	IRQ is shareable
 7	more entries follow
 15-8	reserved (0)
SeeAlso: #0948

Bitfields for EISA DMA Information:
Bit(s)	Description	(Table 0952)
 2-0	DMA channel number
 5-3	reserved (0)
 6	shareable
 7	more entries follow
 9-8	reserved
 11-10	DMA transfer size
	00 byte
	01 word
	10 dword
	11 word, but count in bytes
 13-12	DMA timing
	00 ISA-compatible
	01 EISA type "A"
	10 EISA type "B"
	11 EISA type "C"/"F" (burst)
 15-14	reserved (0)
SeeAlso: #0948

Format of EISA Port Range Information:
Offset	Size	Description	(Table 0953)
 00h	BYTE	port description
		bits 4-0: number of sequential ports
		bit 5 reserved (0)
		bit 6: shareable
		bit 7: more entries follow
 01h	WORD	I/O port address
SeeAlso: #0948,#0954

Format of EISA Port Initialization Data:
Offset	Size	Description	(Table 0954)
 00h	BYTE	flags
		bits 1-0: port size
			00 byte
			01 word
			10 dword
			11 reserved
		bit 2: masked write
		bits 6-3 reserved (0)
		bit 7: more entries follow
 01h	???
SeeAlso: #0948,#0953
--------X-1AB402-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - COPY AND VERIFY CONFIG TABLE
	AX = B402h
	DS:SI -> configuration table (see #0940)
	ES:DI -> buffer for copy of configuration table
Return: CF clear if successful
	    AX = 0000h
	CF set on error
	    AX = error code (0055h,0056h) (see #0939)
Note:	the buffer pointed at by ES:DI must be at least as large as the
	  maximum configuration table size reported by AX=B401h
SeeAlso: AX=B400h,AX=B401h,AX=B403h
--------X-1AB403-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - STORE ESCD TABLE IN NVRAM
	AX = B403h
	DS:SI -> configuration table (see #0940)
Return: CF clear if successful
	    AX = 0000h
	CF set on error
	    AX = error code (0055h) (see #0939)
Note:	sets the configuration table's checksum field, then copies the table
	  into nonvolatile storage (i.e. FlashROM)
SeeAlso: AX=B400h,AX=B402h
--------X-1AB404-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET AVAILABLE IRQs???
	AX = B404h
	BX = bitmap of IRQs being used???
Return: CF clear if successful
	    AX = 0000h
	    BX = available for ISA??? (not(BXin) & A127h)
	    CX = available for on-board I/O??? (not(BXin) & 40D8h)
	    DX = available for PCI??? (either not(BXin) & 0E00h or 0000h)
	CF set on error
	    AX = error code (0051h) (see #0939)
Note:	the various vector types have also been called "shareable",
	  "unshareable", and "avoidable"
SeeAlso: AX=B400h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB405-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET ???
	AX = B405h
Return: AX = ??? (0008h)
SeeAlso: AX=B400h
--------X-1AB406-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET PCI IRQ ROUTING TABLE
	AX = B406h
	ES:DI -> IRQ routing table header (see #0955)
Return: CF clear if successful
	    AX = 0000h
	    WORD ES:[DI] = size of returned data
	CF set on error
	    AX = error code (0059h) (see #0939)
	    WORD ES:[DI] = required size of buffer
SeeAlso: AX=B400h,AX=B404h,AX=B10Eh,INT 2F/AX=1684h/BX=304Ch

Format of Intel Plug-and-Play AUTO-CONFIGURATION PCI IRQ routing header:
Offset	Size	Description	(Table 0955)
 00h	WORD	length of IRQ routing table buffer
 02h	DWORD	-> IRQ routing table array buffer (see #0956)

Format of Intel Plug-and-Play ACFG PCI IRQ routing table entry [array]:
Offset	Size	Description	(Table 0956)
 00h	BYTE	PCI bus number
 01h	BYTE	PCI device number (bits 7-3)
 02h	BYTE	link value for INTA#
		(if non-zero, wire-ORed together with any other PCI interrupts
		  with same link value)
 03h	WORD	IRQ connectivity bit map for INTA#
		(standard AT IRQs to which PCI interrupt can be routed)
 05h	BYTE	link value for INTB#
 06h	WORD	IRQ connectivity bit map for INTB#
 08h	BYTE	link value for INTC#
 09h	WORD	IRQ connectivity bit map for INTC#
 0Bh	BYTE	link value for INTD#
 0Ch	WORD	IRQ connectivity bit map for INTD#
 0Eh	BYTE	(PCI BIOS v2.1+) device slot number (00h = motherboard)
 0Fh	BYTE	reserved
Note:	each item in the routing table corresponds to a motherboard PCI
	  device or PCI slot
SeeAlso: #0955,#M086
--------X-1AB407-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - ???
	AX = B407h
	EDX = length of ???
	EDI = physical address of ???
Return: CF clear if successful
	    AX = 0000h
	    EDX = ???
	    EDI = ???
	CF set on error
	    AX = error code (FFFFh) (see #0939)
Notes:	returns error if EDI < 000C0000h or EDI+EDX > 00100000h
	seems to force EDI and EDX to align to 16K boundaries
SeeAlso: AX=B400h
--------X-1AB4-------------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - 32-BIT API
	AH = B4h
	AL = function (80h-87h)
	further details not yet available
Note:	these functions are 32-bit versions of functions 00h-07h
--------c-1AC0-------------------------------
INT 1A U - Disk Spool II v2.07+ - ALTERNATE INSTALLATION CHECK
	AH = C0h
Return: (see AH=A0h)
Notes:	this call is identical to AH=A0h
	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=ABh,AH=D0h
--------U-1ACCCCBXCCCC-----------------------
INT 1A U - DATEFIX - INSTALLATION CHECK
	AX = CCCCh
	BX = CCCCh
	CX = 0000h
Return: CX = CCCCh if installed
	    ES:BX -> original interrupt handler
Program: DATEFIX is a public-domain TSR to correct the date on AT&T 6300
	  machines, where the realtime clock's calendar wraps after 1991
SeeAlso: AH=FEh,AH=FFh"AT&T"
--------c-1AD0-------------------------------
INT 1A U - Disk Spool II v2.07+ - FUNCTION CALLS
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
	    0Ah ??? (called by Disk Spool's INT 21 handler)
	    0Bh disable the spooler
	    0Ch start despooler after last successfully printed document
	    0Dh start despooler at the exact point where it last left off
	    0Eh pop up the menu
	    0Fh ???
	    11h start new spool file??? (called by Disk Spool's INT 21 handler
			when a program terminates)
	    14h ???
	    15h delete despool file and reset ???
	    16h ??? (writes something to unknown file)
	    17h ??? (writes something to despool file, then reads something
			else and ???)
	    18h ??? (reads something from despool file, and then ???)
	    19h ??? (creates/truncates spool file)
	    20h clear file pointed to by the despooler
	    21h ??? (writes something to unknown file)
	    22h ??? (writes something to spool file if spooler/despooler using
			same file)
	    23h ??? (opens/creates unknown file, then ???)
	    30h ???
	    31h ???
	    32h beep
	    33h append CRLF to spool file???
	    34h ???
	    35h ???
	    36h ???
	    37h append CRLF to spool file and start a new spool file???
	    38h ???
	    40h ??? (v4.05)
	    41h ??? (v4.05)
	    51h ??? (called by Disk Spool's INT 21 handler)
	    52h ??? (called by Disk Spool's INT 21 handler)
	    57h ???
	    5Ah ??? (v4.05)
	    5Bh ??? (v4.05)
	    5Ch ??? (v4.05)
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=ADh
--------c-1AE0-------------------------------
INT 1A - Disk Spool II v4.0x - ENABLE/DISABLE
	AH = E0h
	AL = subfunction
	    01h enable spooler
	    02h disable spooler
	    03h enable despooler
	    04h disable despooler
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
	    F0h printer port not managed by Disk Spool II
	    FFH failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=E1h,AX=E301h,AX=E401h
--------c-1AE1-------------------------------
INT 1A - Disk Spool II v4.0x - GET STATUS
	AH = E1h
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
		CL = despooler state (00h disabled, 41h enabled)
		CH = spooler state (00h disabled, 41h enabled)
		DL = despooler activity (00h standing by, 41h printing)
		ES:BX -> ASCIZ name of current spool file (or next if AutoSpool
			or AutoDespool enabled)
		ES:SI -> ASCIZ name of current despool file
		ES:DI -> 3-byte file extension used by Disk Spool II
	    F0h printer port not managed by Disk Spool II
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=E0h,AH=E2h
--------U-1AE11B-----------------------------
INT 1A - TheGrab v4.60 - ???
	AX = E11Bh
	???
Return: ??? (may destroy all registers)
SeeAlso: AX=E11Dh
--------U-1AE11D-----------------------------
INT 1A - TheGrab v4.60 - INSTALLATION CHECK
	AX = E11Dh
Return: ES:DI -> signature block (see #0957) if installed
	    CX = length of signature block (000Fh)
Program: TheGrab is a resident ANSI screen grabber bundled with TheDraw
SeeAlso: AX=E11Bh

Format of TheGrab signature block:
Offset	Size	Description	(Table 0957)
 00h	BYTE	08h
 01h  8 BYTEs	ASCIZ "THEGRAB"
 09h  6 BYTEs	??? (zeros)
--------c-1AE2-------------------------------
INT 1A - Disk Spool II v4.0x - GET SPOOL FILES
	AH = E2h
	AL = which
	    01h first
	    02h next (can only call after "first")
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
		ES:BX -> ASCIZ filename
	    F0h no (more) spool files
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E0h,AH=E1h
--------c-1AE301-----------------------------
INT 1A - Disk Spool II v4.0x - GET SPOOL FILE STATUS
	AX = E301h
	ES:BX -> ASCIZ filename (max 32 chars)
Return: AH = status
	    00h successful
		ES:SI -> spool file status record (see #0958)
	    F0h not a spool file
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E0h,AX=E302h,AX=E401h

Format of Disk Spool II spool file status record:
Offset	Size	Description	(Table 0958)
 00h	BYTE	hour of creation or last update
 01h	BYTE	minute of creation or last update
 02h	BYTE	year-1980 of creation or last update
 03h	BYTE	month of creation or last update
 04h	BYTE	day of creation or last update
 05h	BYTE	total number of copies to print
 06h	BYTE	number of copies already printed
 07h	BYTE	printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
 08h	BYTE	save status (00h delete after printing, 01h save)
 09h	BYTE	file status
		01h done printing, but being saved
		02h on hold
		03h queued for printing
		04h being spooled
		05h being despooled (i.e. printed)
 0Ah 16 BYTEs	ASCIZ description
 1Ah  2 WORDs	file size in bytes (high,low)
 1Eh  2 WORDs	bytes left to print (high,low)
--------c-1AE302-----------------------------
INT 1A - Disk Spool II v4.0x - UPDATE SPOOL FILE
	AX = E302h
	ES:BX -> ASCIZ filename (max 32 chars)
	ES:SI -> spool file status record (see #0958)
Return: AH = status
	    00h successful
	    F0h not a spool file
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E0h,AX=E301h,AX=E401h
--------c-1AE401-----------------------------
INT 1A - Disk Spool II v4.0x - SPOOL EXISTING FILE
	AX = E401h
	ES:BX -> ASCIZ filename (max 32 chars)
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E1h,AX=E302h,AX=E402h
--------c-1AE402-----------------------------
INT 1A U - Disk Spool II v4.0x - SPOOL EXISTING FILE???
	AX = E402h
	ES:BX -> ASCIZ filename (max 32 chars)
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E1h,AX=E302h,AX=E401h
--------c-1AE5-------------------------------
INT 1A U - Emulaser ELSPL.COM - ???
	AH = E5h
	???
Return: ???
Program: ELSPL.COM is a licensed version of Disk Spool II which is distributed
	  as part of Vertisoft's Emulaser PostScript emulator
SeeAlso: AH=A0h,INT 17/AH=03h
--------c-1AEE-------------------------------
INT 1A U - Disk Spool II v4.05 - ???
	AH = EEh
	AL = printer port???
	???
Return: ???
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E1h
--------U-1AF7-------------------------------
INT 1A - RighTime v1.1 - TEMPORARILY DISABLE
	AH = F7h
Program: RighTime is a TSR by G.T. Becker which continuously adjusts the
	  system time to correct for clock drift
Note:	any AH value from F0h-F7h or F9h-FEh will perform this function in
	  version 1.1, but F7h is the function called by transient portion
SeeAlso: AH=F8h,AH=FFh"RighTime"
--------U-1AF8-------------------------------
INT 1A - RighTime v1.1 - ENABLE
	AH = F8h
Program: RighTime is a TSR by G.T. Becker which continuously adjusts the
	  system time to correct for clock drift
Note:	RighTime is TeSseRact-compatible (see INT 2F/AX=5453h) and modifies its
	  TeSseRact program identifier based on its current state: "RighTime"
	  when enabled, "RighTim"F7h when disabled.
SeeAlso: AH=F7h,AH=FFh"RighTime"
--------b-1AFE-------------------------------
INT 1A - AT&T 6300 - READ TIME AND DATE
	AH = FEh
Return: BX = day count (0 = Jan 1, 1984)
	CH = hour
	CL = minute
	DH = second
	DL = hundredths
SeeAlso: AX=CCCCh/BX=CCCCh,AH=FFh"AT&T",INT 21/AH=2Ah,INT 21/AH=2Ch
--------b-1AFF-------------------------------
INT 1A - AT&T 6300 - SET TIME AND DATE
	AH = FFh
	BX = day count (0 = Jan 1, 1984)
	CH = hour
	CL = minute
	DH = second
	DL = hundredths
Return: ???
SeeAlso: AX=CCCCh/BX=CCCCh,AH=FEh,INT 21/AH=2Bh"DATE",INT 21/AH=2Dh
--------U-1AFF-------------------------------
INT 1A - RighTime v1.1 - PERMANENTLY DISABLE
	AH = FFh
Program: RighTime is a TSR by G.T. Becker which continuously adjusts the
	  system time to correct for clock drift
Note:	upon being permanently disabled, RighTime closes the file handle
	  referencing its executable (which is updated with time correction
	  information every two minutes while RighTime is enabled).
--------s-1AFF00-----------------------------
INT 1A - SND - INSTALLATION CHECK???
	AX = FF00h
Return: AL = version??? (02h)
	AH = busy flag (00h if not in a SND call, 01h if SND currently active)
Note:	the SND API is also supported by IC (Internal Commands) v2.0, a
	  shareware TSR by Geoff Friesen which extends COMMAND.COM's internal
	  command set
SeeAlso: AX=FF01h,AX=FF02h,AX=FF04h,AX=FF05h
--------s-1AFF01-----------------------------
INT 1A - SND - PAUSE
	AX = FF01h
	DX = number of clock ticks to delay
Return: AH = status
	    00h successful
	    01h SND busy
Notes:	if successful, execution returns to the caller after the delay expires;
	  if SND is busy, execution returns immediately
	the IC v2.0 implementation of this API makes no special allowance for
	  time rollover at midnight, which can cause the delay to be over one
	  hour if this function is called just before the BIOS time count
	  rolls over and the delay extends into the next day
SeeAlso: AX=FF00h,INT 15/AH=86h,INT 62/AX=0096h,INT 7F/AH=E8h,INT 80/BX=0009h
SeeAlso: INT E0/CL=BDh
--------s-1AFF02-----------------------------
INT 1A - SND - START SOUND
	AX = FF02h
	DX = frequency in Hertz (14h-FFFFh)
Return: AH = status
	    00h successful
	    01h SND busy
SeeAlso: AX=FF00h,AX=FF01h,AX=FF03h
--------s-1AFF03-----------------------------
INT 1A - SND - STOP SOUND
	AX = FF03h
Return: AH = status
	    00h successful
	    01h busy
Note:	turns off any sound currently being emitted by the PC's speaker unless
	  SND is currently busy processing an API call (this includes
	  background music).  Use AX=FF05h to stop the sound even if an API
	  call is in progress.
SeeAlso: AX=FF00h,AX=FF02h,AX=FF05h
--------s-1AFF04-----------------------------
INT 1A - SND - PLAY MUSIC STRING IN BACKGROUND
	AX = FF04h
	DS:DX -> ASCIZ music string
Return: AH = status
	    00h successful (music begins playing in background)
	    01h busy
Note:	the music string accepted by SND is not the same as that accepted by
	  BASIC and other programs which process music strings
SeeAlso: AX=FF00h,AX=FF05h,INT 80/BX=0006h
--------s-1AFF05-----------------------------
INT 1A - SND - UNCONDITIONALLY STOP SOUND
	AX = FF05h
Return: AH = 00h (successful)
Note:	this function is the same as AX=FF03h, but will stop the sound even if
	  SND is currently busy, such as playing background music
SeeAlso: AX=FF00h,AX=FF03h,INT 80/BX=0007h
--------B-1B---------------------------------
INT 1B C - KEYBOARD - CONTROL-BREAK HANDLER
Desc:	this interrupt is automatically called when INT 09 determines that
	  Control-Break has been pressed
Note:	normally points to a short routine in DOS which sets the Ctrl-C flag,
	  thus invoking INT 23h the next time DOS checks for Ctrl-C.
SeeAlso: INT 23,MEM 0040h:0071h
--------B-1C---------------------------------
INT 1C - TIME - SYSTEM TIMER TICK
Desc:	this interrupt is automatically called on each clock tick by the INT 08
	  handler
Notes:	this is the preferred interrupt to chain when a program needs to be
	  invoked regularly
	not available on NEC 9800-series PCs
SeeAlso: INT 08,INT E2"PC Cluster"
--------B-1D---------------------------------
INT 1D - SYSTEM DATA - VIDEO PARAMETER TABLES
Note:	the default parameter table (see #0959) is located at F000h:F0A4h for
	  100% compatible BIOSes
SeeAlso: INT 10/AH=00h

Format of video parameters:
Offset	Size	Description	(Table 0959)
 00h 16 BYTEs	6845 register values for modes 00h and 01h
 10h 16 BYTEs	6845 register values for modes 02h and 03h
 20h 16 BYTEs	6845 register values for modes 04h and 05h
 30h 16 BYTEs	6845 register values for modes 06h and 07h
 40h	WORD	bytes in video buffer for modes 00h and 01h (0800h)
 42h	WORD	bytes in video buffer for modes 02h and 03h (1000h)
 44h	WORD	bytes in video buffer for modes 04h and 05h (4000h)
 46h	WORD	bytes in video buffer for mode 06h (4000h)
 48h  8 BYTEs	columns on screen for each of modes 00h through 07h
 50h  8 BYTEs	CRT controller mode bytes for each of modes 00h through 07h
Note:	QEMM v7.5 Stealth appears to copy only the first 40h bytes of this
	  table into always-accessible memory
--------B-1E---------------------------------
INT 1E - SYSTEM DATA - DISKETTE PARAMETERS
Notes:	the default parameter table (see #0960) is located at F000h:EFC7h for
	  100% compatible BIOSes
	if the table is changed, INT 13/AH=00h should be called to ensure that
	  the floppy-disk controller is appropriately reprogrammed
SeeAlso: INT 13/AH=0Fh,INT 41"HARD DISK 0",INT 4D/AH=0Ah

Format of diskette parameter table:
Offset	Size	Description	(Table 0960)
 00h	BYTE	first specify byte
		bits 7-4: step rate (Fh=2ms,Eh=4ms,Dh=6ms,etc.)
		bits 3-0: head unload time (0Fh = 240 ms)
 01h	BYTE	second specify byte
		bits 7-1: head load time (01h = 4 ms)
		bit    0: non-DMA mode (always 0)
 02h	BYTE	delay until motor turned off (in clock ticks)
 03h	BYTE	bytes per sector (00h = 128, 01h = 256, 02h = 512, 03h = 1024)
 04h	BYTE	sectors per track
 05h	BYTE	length of gap between sectors (2Ah for 5.25", 1Bh for 3.5")
 06h	BYTE	data length (ignored if bytes-per-sector field nonzero)
 07h	BYTE	gap length when formatting (50h for 5.25", 6Ch for 3.5")
 08h	BYTE	format filler byte (default F6h)
 09h	BYTE	head settle time in milliseconds
 0Ah	BYTE	motor start time in 1/8 seconds
---IBM SurePath BIOS---
 0Bh	BYTE	maximum track number
 0Ch	BYTE	data transfer rate
 0Dh	BYTE	drive type in CMOS
SeeAlso: #2897 at INT 4D/AH=09h
--------B-1F---------------------------------
INT 1F - SYSTEM DATA - 8x8 GRAPHICS FONT
Desc:	this vector points at 1024 bytes of graphics data, 8 bytes for each
	  character 80h-FFh
Note:	graphics data for characters 00h-7Fh stored at F000h:FA6Eh in 100%
	  compatible BIOSes
SeeAlso: INT 10/AX=5000h,INT 43
--------b-1F12-------------------------------
INT 1F U - C&T "SuperState" BIOS - POWER OFF
	AH = 12h
Return: none
Note:	POWER OFF
--------b-1F17-------------------------------
INT 1F U - C&T "SuperState" BIOS - EXECUTE FAR PROC ROUTINE ON SuperState
	AH = 17h
	ES:DI -> far procedure
Return: all registers except AH,ES,DI
Note:	You can change the BIOS area (F000h:0000h - F000h:FFFFh) only through
	  this function
--------b-1F19-------------------------------
INT 1F U - C&T "SuperState" BIOS - ENABLE AUTO WAKEUP AND SET TIME AND DATE
	AH = 19h
	AL = hour in BCD
	BH = minutes in BCD
	BL = seconds in BCD
	CH = year century in BCD (must be 19h)
	CL = year low in BCD
	DH = month in BCD
	DL = date in BCD
Return: CF clear
--------b-1F1C-------------------------------
INT 1F U - C&T "SuperState" BIOS - SET SUSPEND TIMEOUT
	AH = 1Ch
	BX = sec until suspend starts
Return: None
--------b-1F1D-------------------------------
INT 1F U - C&T "SuperState" BIOS - SET SLEEP TIMEOUT
	AH = 1Dh
	BX = sec until sleep starts
Return: None
--------J-1F90-------------------------------
INT 1F - NEC PC-9801 - COPY EXTENDED MEMORY
	AH = 90h
	ES:BX -> global descriptor table (see #0425 at INT 15/AH=87h)
	CX = number of bytes to copy
	SI = 0000h
	DI = 0000h
Return: CF clear if successful
	CF set on error
	???
SeeAlso: INT 15/AH=87h
--------b-1FF5--BLFA-------------------------
INT 1F U - C&T "SuperState" BIOS - REQUEST PASSWORD INPUT
	AH = F5h
	BL = FAh
Return: none
Note:	this function will not return until the correct password is entered
SeeAlso: AH=F5h/BL=FDh,AH=F5h/BL=FEh
--------b-1FF5--BLFD-------------------------
INT 1F U - C&T "SuperState" BIOS - ENCRYPT PASSWORD
	AH = F5h
	BL = FDh
	CX:SI = input string
	DX:DI = encrypted string
	BH = length of input string
Return: CF set on error
SeeAlso: AH=F5h/BL=FAh,AH=F5h/BL=FEh
--------b-1FF5--BLFE-------------------------
INT 1F U - C&T "SuperState" BIOS - SET PASSWORD
	AH = F5h
	BL = FEh
	CX:SI -> input string
	BH = length of input string (if BH = 00h, clear password)
Return: CF set on error
Note:	the input string must be encrypted by INT 1Fh/AH=F5h/BL=FDh
SeeAlso: AH=F5h/BL=FDh,AH=F5h/BL=FFh
--------b-1FF5--BLFF-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ENCRYPTED PASSWORD
	AH = F5h
	BL = FFh
	DX:DI = string buffer
Return: CF set on error
	CF clear if successful
	    BH = length of input string (if BH = 00h, password is not valid)
	    DX:DI -> encrypted password string
SeeAlso: AH=F5h/BL=FDh,AH=F5h/BL=FEh
--------b-1FFB-------------------------------
INT 1F U - C&T "SuperState" BIOS - GET/SET CPU SPEED
	AH = FBh
	BL = function
	    00h get CPU speed
		Return: AL = current CPU speed (00h = fast, 01h = slow)
	    01h set CPU speed
		AL = new CPU speed (00h = fast, 01h = slow)
SeeAlso: AH=FCh/BL=00h
--------b-1FFC--BL00-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ALARM STATUS
	AH = FCh
	BL = 00h
Return: AL = current alarm state (00h = disabled, 01h = enabled)
SeeAlso: AH=FCh/BL=01h,AH=FCh/BL=02h
--------b-1FFC--BL01-------------------------
INT 1F U - C&T "SuperState" BIOS - SET ALARM STATUS
	AH = FCh
	BL = 01h
	AL = new alarm state (00h = disabled, 01h = enabled)
SeeAlso: AH=FCh/BL=00h,AH=FCh/BL=03h
--------b-1FFC--BL02-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ALARM TIME
	AH = FCh
	BL = 02h
Return: CH = hour by BCD
	CL = min by BCD
	DH = sec by BCD
SeeAlso: AH=FCh/BL=00h,AH=FCh/BL=03h,AH=FCh/BL=04h
--------b-1FFC--BL03-------------------------
INT 1F U - C&T "SuperState" BIOS - SET ALARM TIME
	AH = FCh
	BL = 03h
	CH = hour by BCD
	CL = min by BCD
	DH = sec by BCD
Return: CF set on error (incorrect time format or Alarm is not enable)
SeeAlso: AH=FCh/BL=01h,AH=FCh/BL=02h,AH=FCh/BL=05h
--------b-1FFC--BL04-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ALARM DATE
	AH = FCh
	BL = 04h
Return: CH = year century by BCD
	CL = year low by BCD
	DH = month by BCD
	DL = date by BCD
SeeAlso: AH=FCh/BL=02h,AH=FCh/BL=05h
--------b-1FFC--BL05-------------------------
INT 1F U - C&T "SuperState" BIOS - SET ALARM DATE
	AH = FCh
	BL = 05h
	CH = year century by BCD
	CL = year low by BCD
	DH = month by BCD
	DL = date by BCD
Return: CF set on error (incorrect date format or Alarm is not enable)
SeeAlso: AH=FCh/BL=03h,AH=FCh/BL=04h
--------b-1FFD--BL00-------------------------
INT 1F U - C&T "SuperState" BIOS - GET AUTO WAKE UP STATUS
	AH = FDh
	BL = 00h
Return: AL = current wake-up state (00h = disabled, 01h = enabled)
SeeAlso: AH=FDh/BL=01h,AH=FDh/BL=02h
--------b-1FFD--BL01-------------------------
INT 1F U - C&T "SuperState" BIOS - SET AUTO WAKE UP STATUS
	AH = FDh
	BL = 01h
	AL = new wake-up state (00h = disabled, 01h = enabled)
SeeAlso: AH=FDh/BL=00h,AH=FDh/BL=03h
--------b-1FFD--BL02-------------------------
INT 1F U - C&T "SuperState" BIOS - GET AUTO WAKE UP TIME
	AH = FDh
	BL = 02h
Return: CH = hour by BCD
	CL = min by BCD
	DH = sec by BCD
SeeAlso: AH=FDh/BL=00h,AH=FDh/BL=03h
--------b-1FFD--BL03-------------------------
INT 1F U - C&T "SuperState" BIOS - SET AUTO WAKE UP TIME
       AH = FDh
       BL = 03h
       CH = hour by BCD
       CL = min by BCD
       DH = sec by BCD
Return: CF set on error (incorrect Time format or Auto Wake up is not enable)
SeeAlso: AH=FDh/BL=01h,AH=FDh/BL=02h
--------b-1FFD--BL04-------------------------
INT 1F U - C&T "SuperState" BIOS - GET AUTO WAKE UP DATE
	AH = FDh
	BL = 04h
Return: CH = year century in BCD
	CL = year low in BCD
	DH = month in BCD
	DL = date in BCD
SeeAlso: AH=FDh/BL=02h,AH=FDh/BL=05h
--------b-1FFD--BL05-------------------------
INT 1F U - C&T "SuperState" BIOS - SET AUTO WAKE UP DATE
	AH = FDh
	BL = 05h
	CH = year century in BCD
	CL = year low in BCD
	DH = month in BCD
	DL = date in BCD
Return: CF set on error (incorrect date format or Auto Wake up is not enable)
SeeAlso: AH=FDh/BL=03h"C&T",AH=FDh/BL=04h"C&T"
--------O-20---------------------------------
INT 20 - Minix - SEND/RECEIVE MESSAGE
	AX = process ID of other process
	BX -> message
	CX = operation (1 send, 2 receive, 3 send&receive)
Program: Minix is a Version 7 Unix-compatible operating system by Andrew
	  Tanenbaum
Note:	the message contains the system call number (numbered as in V7
	  Unix(tm)) and the call parameters
--------D-20---------------------------------
INT 20 - DOS 1+ - TERMINATE PROGRAM
	CS = PSP segment
Return: never
Notes:	(see INT 21/AH=00h)
	this function sets the program's return code (ERRORLEVEL) to 00h
SeeAlso: INT 21/AH=00h,INT 21/AH=4Ch
--------G-20---------------------------------
INT 20 - COMTROL HOSTESS i/ISA DEBUGGER - INVOKE FIRMWARE DEBUGGER
	???
Return: ???
SeeAlso: INT 21"COMTROL"
--------W-20----Vx0001-----------------------
INT 20 P - Microsoft Windows - VMM - VxD SERVICES
	VxD = 0001h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0961)
Values for VMM (VxD ID 0001h) service number:
 0000h	get version
 0001h	get current VM handle
 0002h	test current VM handle
 0003h	get system VM handle
 0004h	test system VM handle
 0005h	validate VM handle
 0006h	get VMM reenter count
 0007h	begin reentrant execution
 0008h	end reentrant execution
 0009h	install V86 breakpoint
 000Ah	remove V86 breakpoint
 000Bh	allocate V86 callback
 000Ch	allocation PM callback
 000Dh	call when VM returns
 000Eh	schedule global event
 000Fh	schedule VM event
 0010h	call global event
 0011h	call VM event
 0012h	cancel global event
 0013h	cancel VM event
 0014h	call priority VM event
 0015h	cancel priority VM event
 0016h	get NMI handler address
 0017h	set NMI handler address
 0018h	hook NMI event
 0019h	call when VM interrupts enabled
 001Ah	enable VM interrupts
 001Bh	disable VM interrupts
 001Ch	map flat
 001Dh	map linear to VM address
 001Eh	adjust execution priority
 001Fh	begin critical section
 0020h	end critical section
 0021h	end critical section and suspend
 0022h	claim critical section
 0023h	release critical section
 0024h	call when not critical
 0025h	create semaphore
 0026h	destroy semaphore
 0027h	wait on semaphore
 0028h	signal semaphore
 0029h	get critical section status
 002Ah	call when task switched
 002Bh	suspend VM
 002Ch	resume VM
 002Dh	no-fail resume VM
 002Eh	nuke VM
 002Fh	crash current VM
 0030h	get execution focus
 0031h	set execution focus
 0032h	get time slice priority
 0033h	set time slice priority
 0034h	get time slice granularity
 0035h	set time slice granularity
 0036h	get time slice information
 0037h	adjust execution time
 0038h	release time slice
 0039h	wake up VM
 003Ah	call when idle
 003Bh	get next VM handle
 003Ch	set global timeout
 003Dh	set VM timeout
 003Eh	cancel timeout
 003Fh	get system time
	Return: EAX = time in milliseconds that Windows has been running
 0040h	get VM execution time
 0041h	hook V86 interrupt chain
 0042h	get V86 interrupt vector
 0043h	set V86 interrupt vector
 0044h	get PM interrupt vector
 0045h	set PM interrupt vector
 0046h	simulate interrupt
 0047h	simulate IRET
 0048h	simulate far call
 0049h	simulate far jump
 004Ah	simulate far RET
 004Bh	simulate far RET N
 004Ch	build interrupt stack frame
 004Dh	simulate push
 004Eh	simulate pop
 004Fh	_HeapAllocate
 0050h	_HeapReAllocate
 0051h	_HeapFree
 0052h	_HeapGetSize
 0053h	_PageAllocate
 0054h	_PageReAllocate
 0055h	_PageFree
 0056h	_PageLock
 0057h	_PageUnLock
 0058h	_PageGetSizeAddr
 0059h	_PageGetAllocInfo
 005Ah	_GetFreePageCount
 005Bh	_GetSysPageCount
 005Ch	_GetVMPgCount
 005Dh	_MapIntoV86
 005Eh	_PhysIntoV86
 005Fh	_TestGlobalV86Mem
 0060h	_ModifyPageBits
 0061h	copy page table
 0062h	map linear into V86
 0063h	linear page lock
 0064h	linear page unlock
 0065h	_SetResetV86Pageabl
 0066h	_GetV86PageableArray
 0067h	_PageCheckLinRange
 0068h	page out dirty pages
 0069h	discard pages
 006Ah	_GetNulPageHandle
 006Bh	get first V86 page
 006Ch	map physical address to linear address
 006Dh	_GetAppFlatDSAlias
 006Eh	_SelectorMapFlat
 006Fh	_GetDemandPageInfo
 0070h	_GetSetPageOutCount
 0071h	hook V86 page
 0072h	assign device V86 pages
 0073h	deassign device V86 pages
 0074h	get array of V86 pages for device
 0075h	_SetNULPageAddr
 0076h	allocate GDT selector
 0077h	free GDT selector
 0078h	allocate LDT selector
 0079h	free LDT selector
 007Ah	_BuildDescriptorDWORDs
 007Bh	get descriptor
 007Ch	set descriptor
 007Dh	toggle HMA
 007Eh	get fault hook addresses
 007Fh	hook V86 fault
 0080h	hook PM fault
 0081h	hook VMM fault
 0082h	begin nested V86 execution
 0083h	begin nested execution
 0084h	execute V86-mode interrupt
 0085h	resume execution
 0086h	end nested execution
 0087h	allocate PM application callback area
 0088h	get current PM application callback area
 0089h	set V86 execution mode
 008Ah	set PM execution mode
 008Bh	begin using locked PM stack
 008Ch	end using locked PM stack
 008Dh	save client state
 008Eh	restore client state
 008Fh	execute VxD interrupt
	STACK:	WORD	interrupt number
		other registers as required by interrupt call
	Return:	registers as returned by interrupt call
 0090h	hook device service
	EAX = service ID (high word = VxD ID, low = service number)
	ESI -> new handler
 0091h	hook device V86 API
 0092h	hook device PM API
 0093h	system control (see also #2344)
 0094h	simulate I/O
 0095h	install multiple I/O handlers
 0096h	install I/O handler
	DX = I/O port address
	ESI -> handler to call when I/O access attempted???
 0097h	enable global trapping
	DX = I/O port address
 0098h	enable local trapping
	DX = I/O port address
 0099h	disable global trapping
	DX = I/O port address
 009Ah	disable local trapping
	DX = I/O port address
 009Bh	create list
 009Ch	destroy list
 009Dh	allocate list
 009Eh	attach list
 009Fh	attach list tail
 00A0h	insert into list
 00A1h	remove from list
 00A2h	deallocate list
 00A3h	get first item in list
 00A4h	get next item in list
 00A5h	remove first item in list
 00A6h	add instance item
 00A7h	allocate device callback area
 00A8h	allocate global V86 data area
 00A9h	allocate temporary V86 data area
 00AAh	free temporary V86 data area
 00ABh	get decimal integer from profile
 00ACh	convert decimal string to integer
 00ADh	get fixed-point number from profile
 00AEh	convert fixed-point string
 00AFh	get hex integer from profile
 00B0h	convert hex string to integer
 00B1h	get boolean value from profile
 00B2h	convert boolean string
 00B3h	get string from profile
 00B4h	get next string from profile
 00B5h	get environment string
 00B6h	get exec path
 00B7h	get configuration directory
 00B8h	open file
 00B9h	get PSP segment
 00BAh	get DOS vectors
 00BBh	get machine information
 00BCh	get/set HMA information
 00BDh	set system exit code
 00BEh	fatal error handler
 00BFh	fatal memory error
 00C0h	update system clock
 00C1h	test if debugger installed
 00C2h	output debugger string
 00C3h	output debugger character
 00C4h	input debugger character
 00C5h	debugger convert hex to binary
 00C6h	debugger convert hex to decimal
 00C7h	debugger test if valid handle
 00C8h	validate client pointer
 00C9h	test reentry
 00CAh	queue debugger string
 00CBh	log procedure call
 00CCh	debugger test current VM
 00CDh	get PM interrupt type
 00CEh	set PM interrupt type
 00CFh	get last updated system time
 00D0h	get last updated VM execution time
 00D1h	test if double-byte character-set lead byte
 00D2h	_AddFreePhysPage
 00D3h	_PageResetHandlePAddr
 00D4h	_SetLastV86Page
 00D5h	_GetLastV86Page
 00D6h	_MapFreePhysReg
 00D7h	_UnmapFreePhysReg
 00D8h	_XchgFreePhysReg
 00D9h	_SetFreePhysRegCalBk
 00DAh	get next arena (MCB)
 00DBh	get name of ugly TSR
 00DCh	get debug options
 00DDh	set physical HMA alias
 00DEh	_GetGlblRng0V86IntBase
 00DFh	add global V86 data area
 00E0h	get/set detailed VM error
 00E1h	Is_Debug_Chr
 00E2h	clear monochrome screen
 00E3h	output character to mono screen
 00E4h	output string to mono screen
 00E5h	set current position on mono screen
 00E6h	get current position on mono screen
 00E7h	get character from mono screen
 00E8h	locate byte in ROM
 00E9h	hook invalid page fault
 00EAh	unhook invalid page fault
 00EBh	set delete on exit file
 00ECh	close VM
 00EDh	"Enable_Touch_1st_Meg"
 00EEh	"Disable_Touch_1st_Meg"
 00EFh	install exception handler
 00F0h	remove exception handler
 00F1h	"Get_Crit_Status_No_Block"
 00F2h	"_Schedule_VM_RTI_Event"
 00F3h	"_Trace_Out_Service"
 00F4h	"_Debug_Out_Service"
 00F5h	"_Debug_Flags_Service"
 00F6h	VMM add import module name
 00F7h	VMM Add DDB
 00F8h	VMM Remove DDB
 00F9h	get thread time slice priority
 00FAh	set thread time slice priority
 00FBh	schedule thread event
 00FCh	cancel thread event
 00FDh	set thread timeout
 00FEh	set asynchronous timeout
 00FFh	"_AllocatreThreadDataSlot"
 0100h	"_FreeThreadDataSlot"
 0101h	create Mutex
 0102h	destroy Mutex
 0103h	get Mutex owner
 0104h	call when thread switched
 0105h	create thread
 0106h	start thread
 0107h	terminate thread
 0108h	get current thread handle
 0109h	test current thread handle
 010Ah	"Get_Sys_Thread_Handle"
 010Bh	"Test_Sys_Thread_Handle"
 010Ch	"Validate_Thread_Handle"
 010Dh	"Get_Initial_Thread_Handle"
 010Eh	"Test_Initial_Thread_Handle"
 010Fh	"Debug_Test_Valid_Thread_Handle"
 0110h	"Debug_Test_Cur_Thread"
 0111h	"VMM_GetSystemInitState"
 0112h	"Cancel_Call_When_Thread_Switched"
 0113h	"Get_Next_Thread_Handle"
 0114h	"Adjust_Thread_Exec_Priority"
 0115h	"_Deallocate_Device_CB_Area"
 0116h	"Remove_IO_Handler"
 0117h	"Remove_Mult_IO_Handlers"
 0118h	unhook V86 interrupt chain
 0119h	unhook V86 fault handler
 011Ah	unhook PM fault handler
 011Bh	unhook VMM fault handler
 011Ch	unhook device service
 011Dh	"_PageReserve"
 011Eh	"_PageCommit"
 011Fh	"_PageDecommit"
 0120h	"_PagerRegister"
 0121h	"_PagerQuery"
 0122h	"_PagerDeregister"
 0123h	"_ContextCreate"
 0124h	"_ContextDestroy"
 0125h	"_PageAttach"
 0126h	"_PageFlush"
 0127h	"_SignalID"
 0128h	"_PageCommitPhys"
 0129h	"_Register_Win32_Services"
 012Ah	"Cancel_Call_When_Not_Critical"
 012Bh	"Cancel_Call_When_Idle"
 012Ch	"Cancel_Call_When_Task_Switched"
 012Dh	"_Debug_Printf_Service"
 012Eh	enter Mutex
 012Fh	leave Mutex
 0130h	simulate VM I/O
 0131h	"Signal_Semaphore_No_Switch"
 0132h	"_MMSwitchContext"
 0133h	"_MMModifyPermissions"
 0134h	"_MMQuery"
 0135h	"_EnterMustComplete"
 0136h	"_LeaveMustComplete"
 0137h	"_ResumeExecMustComplete"
 0138h	get thread termination status
 0139h	"_GetInstanceInfo"
 013Ah	"_ExecIntMustComplete"
 013Bh	"_ExecVxDIntMustComplete"
 013Ch	begin V86 serialization
 013Dh	unhook V86 page
 013Eh	"VMM_GetVxDLocationList"
 013Fh	"VMM_GetDDBList" get start of VxD chain
	(see also #2344 at INT 2F/AX=1684h/BX=0017h)
 0140h	unhook NMI event
 0141h	"Get_Instanced_V86_Int_Vector"
 0142h	get or set real DOS PSP
 0143h	call priority thread event
 0144h	"Get_System_Time_Address"
 0145h	"Get_Crit_Status_Thread"
 0146h	"Get_DDB"
 0147h	"Directed_Sys_Control"
 0148h	"_RegOpenKey"
 0149h	"_RegCloseKey"
 014Ah	"_RegCreateKey"
 014Bh	"_RegDeleteKey"
 014Ch	"_RegEnumKey"
 014Dh	"_RegQueryValue"
 014Eh	"_RegSetValue"
 014Fh	"_RegDeleteValue"
 0150h	"_RegEnumValue"
 0151h	"_RegQueryValueEx"
 0152h	"_RegSetValueEx"
 0153h	"_CallRing3"
 0154h	"Exec_PM_Int"
 0155h	"_RegFlushKey"
 0156h	"_PageCommitContig"
 0157h	"_GetCurrentContext"
 0158h	"_LocalizeSprintf"
 0159h	"_LocalizeStackSprintf"
 015Ah	"Call_Restricted_Event"
 015Bh	"Cancel_Restricted_Event"
 015Ch	"Register_PEF_Provider"
 015Dh	"_GetPhysPageInfo"
 015Eh	"_RegQueryInfoKey"
 015Fh	"MemArb_Reserve_Pages"
 0160h	"Time_Slice_Sys_VM_Idle"
 0161h	"Time_Slice_Sleep"
 0162h	"Boost_With_Decay"
 0163h	"Set_Inversion_Pri"
 0164h	"Reset_Inversion_Pri"
 0165h	"Release_Inversion_Pri"
 0166h	"Get_Thread_Win32_Pri"
 0167h	"Set_Thread_Win32_Pri"
 0168h	"Set_Thread_Static_Boost"
 0169h	"Set_VM_Static_Boost"
 016Ah	"Release_Inversion_Pri_ID"
 016Bh	"Attach_Thread_To_Group"
 016Ch	"Detach_Thread_From_Group"
 016Dh	"Set_Group_Static_Boost"
 016Eh	"_GetRegistryPath"
 016Fh	"_GetRegistryKey"
 0170h	"_CleanupNestedExec"
 0171h	"_RegRemapPreDefKey"
 0172h	"End_V86_Serialization"
 0173h	"_Assert_Range"
 0174h	"_Sprintf"
 0175h	"_PageChangePager"
 0176h	"_RegCreateDynKey"
 0177h	"RegQMulti"
 0178h	"Boost_Thread_With_VM"
 0179h	"Get_Boot_Flags"
 017Ah	"Set_Boot_Flags"
 017Bh	"_lstrcpyn"
 017Ch	"_lstrlen"
 017Dh	"_lmemcpy"
 017Eh	"_GetVxDName"
 017Fh	"Force_Mutexes_Free"
 0180h	"Restore_Forced_Mutexes"
 0181h	"_AddReclaimableItem"
 0182h	"_SetReclaimableItem"
 0183h	"_EnumReclaimableItem"
 0184h	"Time_Slice_Wake_Sys_VM"
 0185h	"VMM_Replace_Global_Environment"
 0186h	"Begin_Non_Serial_Nest_V86_Exec"
 0187h	"Get_Nest_Exec_Status"
 0188h	"Open_Boot_Log"
 0189h	"Write_Boot_Log"
 018Ah	"Close_Boot_Log"
 018Bh	"EnableDisable_Boot_Log"
 018Ch	"_Call_On_My_Stack"
 018Dh	"Get_Inst_V86_Int_Vec_Base"
 018Eh	"_lstrcmpi"
 018Fh	"_strupr"
 0190h	"Log_Fault_Call_Out"
 0191h	"_AtEventTime"
 0191h	...last service for Windows95 SP1
 811Ch	unhook device service??? (called by KEYREMAP.VXD)
	EAX = service ID (high word = VxD ID, low = service number)
	ESI -> handler
SeeAlso: #0962,#0963,INT 2F/AX=1684h/BX=0001h
--------W-20----Vx0002-----------------------
INT 20 P - Microsoft Windows - DEBUG - VxD SERVICES
	VxD = 0002h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0962,#1032

(Table 0962)
Values for DEBUG (VxD ID 0002h) service number:
 0000h	get version
 0001h	"DEBUG_Fault"
 0002h	"DEBUG_CheckFault"
 0003h	"_DEBUG_LoadSyms"
SeeAlso: #0961,#0963
--------W-20----Vx0003-----------------------
INT 20 P - Microsoft Windows - VPICD - VxD SERVICES
	VxD = 0003h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0963,#1032

(Table 0963)
Values for VPICD (VxD ID 0003h) service number:
 0000h	get version
 0001h	virtualize IRQ
 0002h	set interrupt request
 0003h	clear interrupt request
 0004h	physical EOI
 0005h	get complete status
 0006h	get status
 0007h	test physical request
 0008h	physically mask
 0009h	physically unmask
 000Ah	set automatic masking
 000Bh	get IRQ complete status
 000Ch	convert handle to IRQ
 000Dh	convert IRQ to interrupt
 000Eh	convert interrupt to IRQ
 000Fh	call on hardware interrupt
 0010h	force default owner
 0011h	force default behavior
 0012h	"VPICD_Auto_Mask_At_Inst_Swap"
 0013h	"VPICD_Begin_Inst_Page_Swap"
 0014h	"VPICD_End_Inst_Page_Swap"
 0015h	"VPICD_Virtual_EOI"
 0016h	"VPICD_Get_Virtualization_Count"
 0017h	"VPICD_Post_Sys_Critical_Init"
 0018h	"VPICD_VM_SlavePIC_Mask_Change"
SeeAlso: #0961,#0964,INT 2F/AX=1684h/BX=0003h
--------W-20----Vx0004-----------------------
INT 20 P - Microsoft Windows - VDMAD - VxD SERVICES
	VxD = 0004h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0964)
Values for VDMAD (VxD ID 0004h) service number:
 0000h	get version
 0001h	virtualize channel
 0002h	get region information
 0003h	set region information
 0004h	get virtual state
 0005h	set virtual state
 0006h	set physical state
 0007h	mask channel
 0008h	unmask channel
 0009h	lock DMA region
 000Ah	unlock DMA region
 000Bh	scatter lock
 000Ch	scatter unlock
 000Dh	reserve buffer space
 000Eh	request buffer
 000Fh	release buffer
 0010h	copy to buffer
 0011h	copy from buffer
 0012h	default handler
 0013h	disable translation
 0014h	enable translation
 0015h	get EISA address mode
 0016h	set EISA address mode
 0017h	unlock DMA region (ND)
 0018h	"VDMAD_Phys_Mask_Channel"
 0019h	"VDMAD_Phys_Unmask_Channel"
 001Ah	"VDMAD_Unvirtualize_Channel"
 001Bh	"VDMAD_Set_IO_Address"
 001Ch	"VDMAD_Get_Phys_Count"
 001Dh	"VDMAD_Get_Phys_Status"
 001Eh	"VDMAD_Get_Max_Phys_Page"
 001Fh	"VDMAD_Set_Channel_Callbacks"
 0020h	"VDMAD_Get_Virt_Count"
 0021h	"VDMAD_Set_Virt_Count"
 0021h	...last service for Windows95 SP1
SeeAlso: #0963,#2333,#2370 at INT 2F/AX=1684h/BX=0444h
--------W-20----Vx0005-----------------------
INT 20 P - Microsoft Windows - VTD - VxD SERVICES
	VxD = 0005h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0965)
Values for VTD (VxD ID 0005h) service number:
 0000h	get version
 0001h	update system clock
 0002h	get interrupt period
 0003h	begin minimum interrupt period
 0004h	end minimum interrupt period
 0005h	disable trapping
 0006h	enable trapping
 0007h	get real time
	Return: EDX:EAX = time in 840ns units since Windows was started
 0008h	"VTD_Get_Date_And_Time"
 0009h	"VTD_Adjust_VM_Count"
 000Ah	"VTD_Delay"
SeeAlso: #2333 at INT 2F/AX=1684h/BX=0005h
--------W-20----Vx0006-----------------------
INT 20 P - Microsoft Windows - V86MMGR - VxD SERVICES
	VxD = 0006h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0966)
Values for V86MMGR (VxD ID 0006h) service number:
 00h	get version
 01h	allocate V86 pages
 02h	set EMS and XMS limits
 03h	get EMS and XMS limits
 04h	set mapping information
 05h	get mapping information
 06h	Xlat API
 07h	load client pointer
 08h	allocate buffer
 09h	free buffer
 0Ah	get Xlat buffer state
 0Bh	set Xlat buffer state
 0Ch	get VM flat selector
 0Dh	map pages
 0Eh	free page map region
 0Fh	_LocalGlobalReg
 10h	get page status
 11h	set local A20
 12h	reset base pages
 13h	set available mapped pages
 14h	"V86MMGR_NoUMBInitCalls"
 15h	"V86MMGR_Get_EMS_XMS_Avail"
 16h	"V86MMGR_Toggle_HMA"
	EAX = ???
 17h	"V86MMGR_Dev_Init"
 18h	"V86MMGR_Alloc_UM_Page"
SeeAlso: #2333,#0967,INT 2F/AX=1684h"DEVICE API"
--------W-20----Vx0007-----------------------
INT 20 P - Microsoft Windows - PageSwap - VxD SERVICES
	VxD = 0007h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0967)
Values for PageSwap (VxD ID 0007h) service number:
 00h	get version
 01h	test create
 02h	create swap file
 03h	destroy swap file
 04h	in
 05h	out
 06h	test if I/O valid
 07h	"Read_Or_Write"
 08h	"Grow_File"
 09h	"Init_File"
SeeAlso: #0966,#0968,#0969,#2335
--------W-20----Vx0009-----------------------
INT 20 P - Microsoft Windows - REBOOT - VxD SERVICES
	VxD = 0009h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0968)
Values for REBOOT (VxD ID 0009h) service number:
 00h	get REBOOT version???
 01h	???
 02h	???
 03h	...last service for Windows95 SP1
SeeAlso: #0967,#0969,#2329
--------W-20----Vx000A-----------------------
INT 20 P - Microsoft Windows - VDD - VxD SERVICES
	VxD = 000Ah
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0969)
Values for VDD (VxD ID 000Ah) service number:
 00h	get version
 01h	PIF state
 02h	get GrabRtn
 03h	hide cursor
 04h	set VM type
 05h	get ModTime
 06h	set HCurTrk
 07h	message clear screen
 08h	message foreground color
 09h	message background color
 0Ah	message output text
 0Bh	message set cursor position
 0Ch	query access
 0Dh	"VDD_Check_Update_Soon"
 0Eh	"VDD_Get_Mini_Dispatch_Table"
 0Fh	"VDD_Register_Virtual_Port"
	DX = base I/O port number
	CL = number of contiguous ports???
 10h	"VDD_Get_VM_Info"
 11h	"VDD_Get_Special_VM_IDs"
	Return: ESI = ???
		EDI = ???
 12h	"VDD_Register_Extra_Screen_Selector"
 13h	"VDD_Takeover_VGA_Port"
	DX = VGA I/O port number (03C2h, etc.)
	ECX -> routine to call on I/O access
	Return: ECX -> previous handler (to be jumped to at end of new handler)
 14h	???
 15h	???
 16h	...last service for Windows95 SP1
SeeAlso: #0968,#0970,#2335
--------W-20----Vx000B-----------------------
INT 20 P - Microsoft Windows - VSD - VxD SERVICES
	VxD = 000Bh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0970)
Values for VSD (VxD ID 000Bh) service number:
 00h	get version
 01h	bell
 02h	sound on
 03h	"VSD_TakeSoundPort"
SeeAlso: #0969,#0971
--------W-20----Vx000C-----------------------
INT 20 P - Microsoft Windows - VMD / VMOUSE - VxD SERVICES
	VxD = 000Ch
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0971)
Values for VMD / VMOUSE (VxD ID 000Ch) service number:
 0000h	get version
 0001h	set mouse type
 0002h	get mouse owner
 0003h	"VMOUSE_Post_Pointer_Message"
 0004h	"VMOUSE_Set_Cursor_Proc"
 0005h	"VMOUSE_Call_Cursor_Proc"
 0006h	"VMOUSE_Set_Mouse_Data~Get_Mouse_Data"
 0007h	"VMOUSE_Manipulate_Pointer_Message"
 0008h	"VMOUSE_Set_Middle_Button"
 0009h	"VMD_Set_Middle_Button"
 000Ah	"VMD_Enable_Disable_Mouse_Events"
 000Bh	"VMD_Post_Absolute_Pointer_Message"
	...last service for Windows95 SP1
SeeAlso: #0970,#0972,INT 2F/AX=1684h/BX=000Ch
--------W-20----Vx000D-----------------------
INT 20 P - Microsoft Windows - VKD - VxD SERVICES
	VxD = 000Dh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0972)
Values for VKD (VxD ID 000Dh) service number:
 0000h	get version
 0001h	define hotkey
 0002h	remove hotkey
 0003h	locally enable hotkey
 0004h	locally disable hotkey
 0005h	reflect hotkey
 0006h	cancel hotkey state
 0007h	force keys
 0008h	get keyboard owner
 0009h	define paste mode
 000Ah	start pasting
 000Bh	cancel paste
 000Ch	get message key
 000Dh	peek message key
 000Eh	flush message key queue
 000Fh	"VKD_Enable_Keyboard"
 0010h	"VKD_Disable_Keyboard"
 0011h	"VKD_Get_Shift_State"
 0012h	"VKD_Filter_Keyboard_Input"
 0013h	"VKD_Put_Byte"
 0014h	"VKD_Set_Shift_State"
	...last service for Windows95 SP1
SeeAlso: #0971,#0973
--------W-20----Vx000E-----------------------
INT 20 P - Microsoft Windows - VCD - VxD SERVICES
	VxD = 000Eh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0973)
Values for VCD (VxD ID 000Eh) service number:
 0000h	get version
 0001h	set port global
 0002h	get focus
 0003h	virtualize port
 0004h	"VCD_Acquire_Port"
 0005h	"VCD_Free_Port"
 0006h	"VCD_Acquire_Port_Windows_Style"
 0007h	"VCD_Free_Port_Windows_Style"
 0008h	"VCD_Steal_Port_Windows_Style"
 0009h	"VCD_Find_COM_Index"
 000Ah	"VCD_Set_Port_Global_Special"
 000Bh	"VCD_Virtualize_Port_Dynamic"
 000Ch	"VCD_Unvirtualize_Port_Dynamic"
	...last service for Windows95 SP1
SeeAlso: #0972,#0974
--------W-20----Vx0010-----------------------
INT 20 P - Microsoft Windows - BlockDev / IOS - VxD SERVICES
	VxD = 0010h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0974)
Values for BlockDev/IOS (VxD ID 0010h) service number:
 0000h	get version
 0001h	register device
 0002h	find INT 13 drive
 0003h	get device list
 0004h	send command
 0005h	command complete
 0006h	synchronous command
 0007h	"IOS_Register"
 0008h	"IOS_Requestor_Service"
 0009h	"IOS_Exclusive_Access"
 000Ah	"IOS_Send_Next_Command"
 000Bh	"IOS_Set_Async_Time_Out"
 000Ch	"IOS_Signal_Semaphore_No_Switch"
 000Dh	"IOSIdleStatus"
 000Eh	"IOSMapIORSToI24"
 000Fh	"IOSMapIORSToI21"
 0010h	"PrintLog"
SeeAlso: #0973,#0975
--------W-20----Vx0011-----------------------
INT 20 P - Microsoft Windows - VMCPD - VxD SERVICES
	VxD = 0011h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0975)
Values for VMCPD (VxD ID 0011h) service number:
 0000h	"VMCPD_Get_Version"
 0001h	"VMCPD_Get_Virt_State"
 0002h	"VMCPD_Set_Virt_State"
 0003h	"VMCPD_Get_CR0_State"
 0004h	"VMCPD_Set_CR0_State"
 0005h	"VMCPD_Get_Thread_State"
 0006h	"VMCPD_Set_Thread_State"
 0007h	"_VMCPD_Get_FP_Instruction_Size"
 0008h	"VMCPD_Set_Thread_Precision"
SeeAlso: #0974,#0976,#2329
--------W-20----Vx0012-----------------------
INT 20 P - Microsoft Windows - EBIOS - VxD SERVICES
	VxD = 0012h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0976)
Values for EBIOS (VxD ID 0012h) service number:
 00h	get EBIOS version
 01h	get unused memory
SeeAlso: #0975,#0977
--------W-20----Vx0014-----------------------
INT 20 P - Microsoft Windows - VNETBIOS - VxD SERVICES
	VxD = 0014h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0977)
Values for VNETBIOS (VxD ID 0014h) service number:
 00h	get version
 01h	register
 02h	submit
 03h	enum
 04h	deregister
 05h	register2
 06h	map
 07h	enum2
SeeAlso: #0976,#0978
--------W-20----Vx0015-----------------------
INT 20 P - Microsoft Windows - DOSMGR - VxD SERVICES
	VxD = 0015h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0978)
Values for DOSMGR (VxD ID 0015h) service number:
 0000h	get version
 0001h	set exec VM data
 0002h	coyp VM drive state
 0003h	execute VM
 0004h	get InDOS pointer
 0005h	add device
 0006h	remove device
 0007h	instance device
 0008h	get DOS critical status
 0009h	enable InDOS polling
 000Ah	backfill allowed
 000Bh	"LocalGlobalReg"
 000Ch	"Init_UMB_Area"
 000Dh	"Begin_V86_App"
 000Eh	"End_V86_App"
 000Fh	"Alloc_Local_Sys_VM_Mem"
	EAX = number of paragraphs??? to allocate
 0010h	"DOSMGR_Grow_CDSs"
 0011h	"DOSMGR_Translate_Server_DOS_Call"
 0012h	"DOSMGR_MMGR_PSP_Change_Notifier"
SeeAlso: #0977,#2343 at INT 2F/AX=1684h/BX=0015h
--------W-20----Vx0017-----------------------
INT 20 P - Microsoft Windows - SHELL - VxD SERVICES
	VxD = 0017h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0979)
Values for SHELL (VxD ID 0017h) service number:
 0000h	get version
 0001h	resolve contention
 0002h	event
 0003h	SYSMODAL message
 0004h	message
 0005h	get VM information
 0006h	"_SHELL_PostMessage"
 0007h	"_SHELL_WinExec"
 0008h	"_SHELL_CallDll"
 0009h	"SHELL_OpenClipboard"
 000Ah	"SHELL_SetClipboardData"
 000Bh	"SHELL_GetClipboardData"
 000Ch	"SHELL_CloseClipboard"
 000Dh	"_SHELL_Install_Taskman_Hooks"
 000Eh	"SHELL_Hook_Properties"
 000Fh	"SHELL_Unhook_Properties"
 0010h	"SHELL_OEMKeyScan"
 0011h	"SHELL_Update_User_Activity"
 0012h	"_SHELL_UnhookSystemBroadcast"
 0013h	"_SHELL_LocalAllocEx"
 0014h	"_SHELL_LocalFree"
 0015h	"_SHELL_LoadLibrary"
 0016h	"_SHELL_FreeLibrary"
 0017h	"_SHELL_GetProcAddress"
 0018h	"_SHELL_CallDll"
 0019h	"_SHELL_SuggestSingleMSDOSMode"
 001Ah	"SHELL_CheckHotkeyAllowed"
 001Bh	"_SHELL_GetDOSAppInfo"
SeeAlso: #0978,#0980,#2344 at INT 2F/AX=1684h/BX=0017h
--------W-20----Vx0018-----------------------
INT 20 P - Microsoft Windows - VMPoll - VxD SERVICES
	VxD = 0018h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0980)
Values for VMPoll (VxD ID 0018h) service number:
 00h	get version
 01h	enable/disable
 02h	reset detection
 03h	check idle
SeeAlso: #0965,#2344 at INT 2F/AX=1684h/BX=0017h
--------W-20----Vx001A-----------------------
INT 20 P - Microsoft Windows - DOSNET - VxD SERVICES
	VxD = 001Ah
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0981)
Values for DOSNET (VxD ID 001Ah) service number:
 00h	get version
 01h	send FILESYSCHANGE
 02h	do PSP adjust
SeeAlso: #0980,#0982
--------W-20----Vx001B-----------------------
INT 20 P - Microsoft Windows - VFD - VxD SERVICES
	VxD = 001Bh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0982,#1032

(Table 0982)
Values for VFD (VxD ID 001Bh) service number:
 0000h	get version
SeeAlso: #0981,#0983
--------W-20----Vx001C-----------------------
INT 20 P - Microsoft Windows - LoadHi - VxD SERVICES
	VxD = 001Ch
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0983)
Values for LoadHi (VxD ID 001Ch) service number:
 00h	get version
	Return:	CF clear
		EAX = version (AH = major, AL = minor)
		ESI -> ASCIZ signature "LoadHi"
SeeAlso: #0982,#0984
--------W-20----Vx0020-----------------------
INT 20 P - Microsoft Windows - Int13 - VxD SERVICES
	VxD = 0020h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0984)
Values for Int13 (VxD ID 0020h) service number:
 00h	get version
 01h	device registered
 02h	translate VM interrupt
 03h	hooking BIOS interrupt
 04h	unhooking BIOS interrupt
SeeAlso: #0983,#0985
--------W-20----Vx0021-----------------------
INT 20 P - Microsoft Windows - PAGEFILE - VxD SERVICES
	VxD = 0021h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0985)
Values for PAGEFILE (VxD ID 0021h) service number:
 00h	get version
 01h	init file
 02h	clean up
 03h	grow file
 04h	read or write
 05h	cancel
 06h	test I/O valid
 07h	"Get_Size_Info"
 08h	"Set_Async_Manager"
 09h	"Call_Async_Manager"
SeeAlso: #0984,#2348 at INT 2F/AX=1684h/BX=0021h
--------W-20----Vx0026-----------------------
INT 20 P - Microsoft Windows - VPOWERD - VxD SERVICES
	VxD = 0026h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0986)
Values for VPOWERD (VxD ID 0026h) service number:
 00h	get version
	Return:	CF clear
		EAX = version (AH = major, AL = minor)
 01h	get APM BIOS version
	Return: CF clear
		EAX = APM BIOS version
 02h	get current power management level
	Return: CF clear
		EAX = power management level
 03h	enable/disable power management (see INT 15/AX=5308h)
	Return: EAX = error code (see #2352) or 00000000h if successful
 04h	set power state (see INT 15/AX=5307h)
	???
	Return: EAX = error code (see #2352) or 00000000h if successful
 05h	set system power status
	Return: EAX = error code (see #2352) or 00000000h if successful
 06h	restore APM power-on defaults (see INT 15/AX=5309h)
	Return: EAX = error code (see #2352) or 00000000h if successful
 07h	get power status (see INT 15/AX=530Ah)
	Return: ???
 08h	get APM 1.1 power state (see INT 15/AX=530Ch)
	Return: ???
 09h	invoke OEM APM function
	??? -> bufer containing parameters for INT 15/AX=5380h
	Return: EAX = error code (see #2352) or 00000000h if successful
		buffer updated if successful
 0Ah	register power handler
	???
	Return: EAX = error code (see #2352) or 00000000h if successful
 0Bh	deregister power handler
	???
	Return: EAX = error code (see #2352) or 00000000h if successful
 0Ch	Win32 get system power status
 0Dh	Win32 set system power status
SeeAlso: #0985,#0987,INT 2F/AX=1684h/BX=0026h
--------W-20----Vx0027-----------------------
INT 20 P - Microsoft Windows - VXDLDR - VxD SERVICES
	VxD = 0027h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0987)
Values for VXDLDR (VxD ID 0027h) service number:
 0000h	"VXDLDR_Get_Version"
 0001h	"VXDLDR_LoadDevice"
 0002h	"VXDLDR_UnloadDevice"
 0003h	"VXDLDR_DevInitSucceeded"
 0004h	"VXDLDR_DevInitFailed"
 0005h	"VXDLDR_GetDeviceList"
 0006h	"VXDLDR_UnloadMe"
 0007h	"PELDR_LoadModule"
 0008h	"PELDR_GetModuleHandle"
 0009h	"PELDR_GetModuleUsage"
 000Ah	"PELDR_GetEntryPoint"
 000Bh	"PELDR_GetProcAddress"
 000Ch	"PELDR_AddExportTable"
 000Dh	"PELDR_RemoveExportTable"
 000Eh	"PELDR_FreeModule"
 000Fh	"VXDLDR_Notify"
 0010h	"_PELDR_InitCompleted"
 0011h	"_PELDR_LoadModuleEx"
SeeAlso: #0985,#0988
--------W-20----Vx0028-----------------------
INT 20 P - Microsoft Windows - NDIS - VxD SERVICES
	VxD = 0028h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0988)
Values for NDIS (VxD ID 0028h) service number:
 00h	"NdisGetVersion"
 01h	"NdisAllocateSpinLock"
 02h	"NdisFreeSpinLock"
 03h	"NdisAcquireSpinLock"
 04h	"NdisReleaseSpinLock"
 05h	"NdisOpenConfiguration"
 06h	"NdisReadConfiguration"
 07h	"NdisCloseConfiguration"
 08h	"NdisReadEisaSlotInformation"
 09h	"NdisReadMcaPosInformation"
 0Ah	"NdisAllocateMemory"
 0Bh	"NdisFreeMemory"
 0Ch	"NdisSetTimer"
 0Dh	"NdisCancelTimer"
 0Eh	"NdisStallExecution"
 0Fh	"NdisInitializeInterrupt"
 10h	"NdisRemoveInterrupt"
 11h	"NdisSynchronizeWithInterrupt"
 12h	"NdisOpenFile"
 13h	"NdisMapFile"
 14h	"NdisUnmapFile"
 15h	"NdisCloseFile"
 16h	"NdisAllocatePacketPool"
 17h	"NdisFreePacketPool"
 18h	"NdisAllocatePacket"
 19h	"NdisReinitializePacket"
 1Ah	"NdisFreePacket"
 1Bh	"NdisQueryPacket"
 1Ch	"NdisAllocateBufferPool"
 1Dh	"NdisFreeBufferPool"
 1Eh	"NdisAllocateBuffer"
 1Fh	"NdisCopyBuffer"
 20h	"NdisFreeBuffer"
 21h	"NdisQueryBuffer"
 22h	"NdisGetBufferPhysicalAddress"
 23h	"NdisChainBufferAtFront"
 24h	"NdisChainBufferAtBack"
 25h	"NdisUnchainBufferAtFront"
 26h	"NdisUnchainBufferAtBack"
 27h	"NdisGetNextBuffer"
 28h	"NdisCopyFromPacketToPacket"
 29h	"NdisRegisterProtocol"
 2Ah	"NdisDeregisterProtocol"
 2Bh	"NdisOpenAdapter"
 2Ch	"NdisCloseAdapter"
 2Dh	"NdisSend"
 2Eh	"NdisTransferData"
 2Fh	"NdisReset"
 30h	"NdisRequest"
 31h	"NdisInitializeWrapper"
 32h	"NdisTerminateWrapper"
 33h	"NdisRegisterMac"
 34h	"NdisDeregisterMac"
 35h	"NdisRegisterAdapter"
 36h	"NdisDeregisterAdapter"
 37h	"NdisCompleteOpenAdapter"
 38h	"NdisCompleteCloseAdapter"
 39h	"NdisCompleteSend"
 3Ah	"NdisCompleteTransferData"
 3Bh	"NdisCompleteReset"
 3Ch	"NdisCompleteRequest"
 3Dh	"NdisIndicateReceive"
 3Eh	"NdisIndicateReceiveComplete"
 3Fh	"NdisIndicateStatus"
 40h	"NdisIndicateStatusComplete"
 41h	"NdisCompleteQueryStatistics"
 42h	"NdisEqualString"
 43h	"NdisNetAddressStringToBinary"
 44h	"NdisReadNetworkAddress"
 45h	"NdisWriteErrorLogEntry"
 46h	"C_MapPhysToLinear"
 47h	"C_HeapFree"
 48h	"NdisAllocateSharedMemory"
 49h	"NdisFreeSharedMemory"
 ...
 5Fh	...last service for Windows95 SP1
SeeAlso: #0987,#0989
--------W-20----Vx002A-----------------------
INT 20 P - Microsoft Windows - VWIN32 - VxD SERVICES
	VxD = 002Ah
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0989)
Values for VWIN32 (VxD ID 002Ah) service number:
 0000h	"VWin32_Get_Version"
 0001h	"VWin32_Wake_For_Event"
 0002h	"_VWIN32_QueueUserApc"
 0003h	"_VWIN32_Get_Thread_Context"
 0004h	"_VWIN32_Set_Thread_Context"
 0005h	"_VWIN32_CopyMem"
 0006h	"_VWIN32_BlockForTermination"
 0007h	"_VWIN32_Emulate_Npx"
 0008h	"_VWIN32_CheckDelayedNpxTrap"
 0009h	"VWIN32_EnterCrstR0"
 000Ah	"VWIN32_LeaveCrstR0"
 000Bh	"_VWIN32_FaultPopup"
 000Ch	"VWIN32_GetContextHandle"
 000Dh	"VWIN32_GetCurrentProcessHandle"
 000Eh	"_VWIN32_SetWin32Event"
 000Fh	"_VWIN32_PulseWin32Event"
 0010h	"_VWIN32_ResetWin32Event"
 0011h	"_VWIN32_WaitSingleObject"
 0012h	"_VWIN32_WaitMultipleObjects"
 0013h	"_VWIN32_CreateRing0Thread"
 0014h	"_VWIN32_CloseVxDHandle"
 0015h	"VWIN32_ActiveTimeBiasSet"
 0016h	"VWIN32_GetCurrentDirectory"
 0017h	"VWIN32_BlueScreenPopup"
 0018h	"VWIN32_TerminateApp"
 0019h	"_VWIN32_QueueKernelAPC"
 001Ah	"VWIN32_SysErrorBox"
 001Bh	"_VWIN32_IsClientWin32"
 001Ch	"VWIN32_IFSRIPWhenLev2Taken"
SeeAlso: #0988,#0990
--------W-20----Vx002B-----------------------
INT 20 P - Microsoft Windows - VCOMM - VxD SERVICES
	VxD = 002Bh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0990)
Values for VCOMM (VxD ID 002Bh) service number:
 0000h	"VCOMM_Get_Version"
 0001h	"_VCOMM_Register_Port_Driver"
 0002h	"_VCOMM_Acquire_Port"
 0003h	"_VCOMM_Release_Port"
 0004h	"_VCOMM_OpenComm"
 0005h	"_VCOMM_SetCommState"
 0006h	"_VCOMM_GetCommState"
 0007h	"_VCOMM_SetupComm"
 0008h	"_VCOMM_TransmitCommChar"
 0009h	"_VCOMM_CloseComm"
 000Ah	"_VCOMM_GetCommQueueStatus"
 000Bh	"_VCOMM_ClearCommError"
 000Ch	"_VCOMM_GetModemStatus"
 000Dh	"_VCOMM_GetCommProperties"
 000Eh	"_VCOMM_EscapeCommFunction"
 000Fh	"_VCOMM_PurgeComm"
 0010h	"_VCOMM_SetCommEventMask"
 0011h	"_VCOMM_GetCommEventMask"
 0012h	"_VCOMM_WriteComm"
 0013h	"_VCOMM_ReadComm"
 0014h	"_VCOMM_EnableCommNotification"
 0015h	"_VCOMM_GetLastError"
 0016h	"_VCOMM_Steal_Port"
 0017h	"_VCOMM_SetReadCallBack"
 0018h	"_VCOMM_SetWriteCallBack"
 0019h	"_VCOMM_GetSetCommTimeouts"
 001Ah	"_VCOMM_SetWriteRequest"
 001Bh	"_VCOMM_SetReadRequest"
 001Ch	"_VCOMM_Dequeue_Request"
 001Dh	"_VCOMM_Dequeue_Request"
 001Eh	"_VCOMM_Enumerate_DevNodes"
 001Fh	"VCOMM_Map_Win32DCB_To_Ring0"
 0020h	"VCOMM_Map_Ring0DCB_To_Win32"
 0021h	"_VCOMM_Get_Contention_Handler"
 0022h	"_VCOMM_Map_Name_To_Resource"
SeeAlso: #0989,#0991
--------W-20----Vx002C-----------------------
INT 20 P - Microsoft Windows - SPOOLER - VxD SERVICES
	VxD = 002Ch
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0991)
Values for SPOOLER (VxD ID 002Ch) service number:
 0000h	get version???
 0001h	???
 0010h	...last service for Windows95 SP1
SeeAlso: #0990,#0992
--------W-20----Vx0032-----------------------
INT 20 P - Microsoft Windows - VSERVER - VxD SERVICES
	VxD = 0032h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0992)
Values for VSERVER (VxD ID 0032h) service number:
 00h	get VSERVER version
	Return: CF clear
		EAX = version (AH = major, AL = minor)
		EBX = ??? (00000000h)
 01h	allocate ???
	AX = ???
	ESI = ???
	Return: CF clear if successful
		CF set on error (table full)
 02h	NOP???
	Return: EBX = 00000000h
 03h	???
	Return: ZF clear
SeeAlso: #0991,#0993,INT 2F/AX=1684h/BX=0032h
--------W-20----Vx0033-----------------------
INT 20 P - Microsoft Windows - CONFIGMG - VxD SERVICES
	VxD = 0033h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0993)
Values for CONFIGMG (VxD ID 0033h) service number:
 0000h	"_CONFIGMG_Get_Version"
 0001h	"_CONFIGMG_Initialize"
 0002h	"_CONFIGMG_Locate_DevNode"
 0003h	"_CONFIGMG_Get_Parent"
 0004h	"_CONFIGMG_Get_Child"
 0005h	"_CONFIGMG_Get_Sibling"
 0006h	"_CONFIGMG_Get_Device_ID_Size"
 0007h	"_CONFIGMG_Get_Device_ID"
 0008h	"_CONFIGMG_Get_Depth"
 0009h	"_CONFIGMG_Get_Private_DWord"
 000Ah	"_CONFIGMG_Set_Private_DWord"
 000Bh	"_CONFIGMG_Create_DevNode"
 000Ch	"_CONFIGMG_Query_Remove_SubTree"
 000Dh	"_CONFIGMG_Remove_SubTree"
 000Eh	"_CONFIGMG_Register_Device_Driver"
 000Fh	"_CONFIGMG_Register_Enumerator"
 0010h	"_CONFIGMG_Register_Arbitrator"
 0011h	"_CONFIGMG_Deregister_Arbitrator"
 0012h	"_CONFIGMG_Query_Arbitrator_Free_Size"
 0013h	"_CONFIGMG_Query_Arbitrator_Free_Data"
 0014h	"_CONFIGMG_Sort_NodeList"
 0015h	"_CONFIGMG_Yield"
 0016h	"_CONFIGMG_Lock"
 0017h	"_CONFIGMG_Unlock"
 0018h	"_CONFIGMG_Add_Empty_Log_Conf"
 0019h	"_CONFIGMG_Free_Log_Conf"
 001Ah	"_CONFIGMG_Get_First_Log_Conf"
 001Bh	"_CONFIGMG_Get_Next_Log_Conf"
 001Ch	"_CONFIGMG_Add_Res_Des"
 001Dh	"_CONFIGMG_Modify_Res_Des"
 001Eh	"_CONFIGMG_Free_Res_Des"
 001Fh	"_CONFIGMG_Get_Next_Res_Des"
 0020h	"_CONFIGMG_Get_Performance_Info"
 0021h	"_CONFIGMG_Get_Res_Des_Data_Size"
 0022h	"_CONFIGMG_Get_Res_Des_Data"
 0023h	"_CONFIGMG_Process_Events_Now"
 0024h	"_CONFIGMG_Create_Range_List"
 0025h	"_CONFIGMG_Add_Range"
 0026h	"_CONFIGMG_Delete_Range"
 0027h	"_CONFIGMG_Test_Range_Available"
 0028h	"_CONFIGMG_Dup_Range_List"
 0029h	"_CONFIGMG_Free_Range_List"
 002Ah	"_CONFIGMG_Invert_Range_List"
 002Bh	"_CONFIGMG_Intersect_Range_List"
 002Ch	"_CONFIGMG_First_Range"
 002Dh	"_CONFIGMG_Next_Range"
 002Eh	"_CONFIGMG_Dump_Range_List"
 002Fh	"_CONFIGMG_Load_DLVxDs"
 0030h	"_CONFIGMG_Get_DDBs"
 0031h	"_CONFIGMG_Get_CRC_CheckSum"
 0032h	"_CONFIGMG_Register_DevLoader"
 0033h	"_CONFIGMG_Reenumerate_DevNode"
 0034h	"_CONFIGMG_Setup_DevNode"
 0035h	"_CONFIGMG_Reset_Children_Marks"
 0036h	"_CONFIGMG_Get_DevNode_Status"
 0037h	"_CONFIGMG_Remove_Unmarked_Children"
 0038h	"_CONFIGMG_ISAPNP_To_CM"
 0039h	"_CONFIGMG_CallBack_Device_Driver"
 003Ah	"_CONFIGMG_CallBack_Enumerator"
 003Bh	"_CONFIGMG_Get_Alloc_Log_Conf"
 003Ch	"_CONFIGMG_Get_DevNode_Key_Size"
 003Dh	"_CONFIGMG_Get_DevNode_Key"
 003Eh	"_CONFIGMG_Read_Registry_Value"
 003Fh	"_CONFIGMG_Write_Registry_Value"
 0040h	"_CONFIGMG_Disable_DevNode"
 0041h	"_CONFIGMG_Enable_DevNode"
 0042h	"_CONFIGMG_Move_DevNode"
 0043h	"_CONFIGMG_Set_Bus_Info"
 0044h	"_CONFIGMG_Get_Bus_Info"
 0045h	"_CONFIGMG_Set_HW_Prof"
 0046h	"_CONFIGMG_Recompute_HW_Prof"
 0047h	"_CONFIGMG_Query_Change_HW_Prof"
 0048h	"_CONFIGMG_Get_Device_Driver_Private_DWord"
 0049h	"_CONFIGMG_Set_Device_Driver_Private_DWord"
 004Ah	"_CONFIGMG_Get_HW_Prof_Flags"
 004Bh	"_CONFIGMG_Set_HW_Prof_Flags"
 004Ch	"_CONFIGMG_Read_Registry_Log_Confs"
 004Dh	"_CONFIGMG_Run_Detection"
 004Eh	"_CONFIGMG_Call_At_Appy_Time"
 004Fh	"_CONFIGMG_Fail_Change_HW_Prof"
 0050h	"_CONFIGMG_Set_Private_Problem"
 0051h	"_CONFIGMG_Debug_DevNode"
 0052h	"_CONFIGMG_Get_Hardware_Profile_Info"
 0053h	"_CONFIGMG_Register_Enumerator_Function"
 0054h	"_CONFIGMG_Call_Enumerator_Function"
 0055h	"_CONFIGMG_Add_ID"
 0056h	"_CONFIGMG_Find_Range"
 0057h	"_CONFIGMG_Get_Global_State"
 0058h	"_CONFIGMG_Broadcast_Device_Change_Message"
 0059h	"_CONFIGMG_Call_DevNode_Handler"
 005Ah	"_CONFIGMG_Remove_Reinsert_All"
Note:	the VxD services appear to be identical to the PM/V86 APIs on
	  INT 2F/AX=1684h
SeeAlso: #0992,#0995,INT 2F/AX=1684h/BX=0033h
--------W-20----Vx0034-----------------------
INT 20 P - Microsoft Windows - DWCFGMG.SYS - VxD SERVICES
	VxD = 0034h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0994)
Values for DWCFGMG.SYS (VxD ID 0034h) service number:
 00h	"CM_GetVersion" get supported DDI version
	Return: EAX = 00000000h if not installed
		else
		    AH = major version number
		    AL = minor version number
		    EBX = number of devices controlled by DWCFGMG.SYS
 01h	"CM_GetConfig" get device configuration
	EBX = device index
	EDI -> buffer for configuration information (see #2362)
	Return: EAX = status (0000h successful, 0001h index out of range)
 02h	"CM_LockConfig" lock device configuration
	EDI -> configuration information (see #2362)
	Return: EAX = status
		    0000h successful
		    0001h resource conflict
		    0002h invalid request
 03h	"CM_UnlockConfig" unlock device configuration
	EDI -> configuration information (see #2362)
	Return: EAX = status (0000h successful, 0001h invalid request)
 04h	"CME_QueryResources"
 05h	"CME_AllocResources"
 06h	"CME_DeallocResources"
SeeAlso: INT 2F/AX=1684h/BX=0034h
--------W-20----Vx0036-----------------------
INT 20 P - Microsoft Windows - VFBACKUP - VxD SERVICES
	VxD = 0036h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0995)
Values for VFBACKUP (VxD ID 0036h) service number:
 0000h	get version
	Return: CF clear
		EAX = version (AH = major, AL = minor)
 0001h	"VFBACKUP_Lock_NEC"
 0002h	"VFBACKUP_UnLock_NEC"
 0003h	"VFBACKUP_Register_NEC"
 0004h	"VFBACKUP_Register_VFD"
 0005h	"VFBACKUP_Lock_All_Ports"
SeeAlso: #0993,#0996
--------W-20----Vx0037-----------------------
INT 20 P - Microsoft Windows - VMINI / ENABLE - VxD SERVICES
	VxD = 0037h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0996)
Values for VMINI / ENABLE (VxD ID 0037h) service number:
 0000h	get version
	Return: CF clear
		EAX = version (AH = major, AL = minor)
 0001h	"VMINI_Update"
	??? (performs VMMCall 1800Eh, then falls through to service 04h)
	Return: EAX = system time???
 0002h	"VMINI_Status"
	get current ???
	Return: EAX = ???
 0003h	"VMINI_DisplayError" (schedules a global event via VMMCall 1800Eh)
	Return: ???
 0004h	"VMINI_SetTimeStamp" (performs VMMCall 100CFh)
	Return: EAX = system time
 0005h	"VMINI_Siren" (call ??? priority event)
	Return: nothing
 0006h	"VMINI_RegisterAccess" (set ??? / get ???)
	EDI -> buffer containing data to copy into VxD and space for results
	Return: EDI buffer updated
 0007h	"VMINI_GetData"
	EBX = ??? flags (bits 2,15,17,18 checked)
	EDI -> ???
	???
	Return: ???
 0008h	"VMINI_ShutDownItem" (schedules a global event via VMMCall 1800Eh)
	Return: ???
 0009h	"VMINI_RegisterSK" (get ??? data)
	EDI -> buffer for data (see #0997)
	Return:	EDI buffer updated if large enough
SeeAlso: #0995,#0998,#2364 at INT 2F/AX=1684h/BX=0037h

Format of ENABLE.VXD ??? data:
Offset	Size	Description	(Table 0997)
 00h	DWORD	(ret) length of data, including this word
		(call) length of buffer
 04h	DWORD	-> 24-byte (or larger) buffer
 08h	DWORD	-> 20-byte buffer
 0Ch	DWORD	-> 260-byte buffer
 10h	DWORD	-> 260-byte buffer
SeeAlso: #0996
--------W-20----Vx0038-----------------------
INT 20 P - Microsoft Windows - VCOND - VxD SERVICES
	VxD = 0038h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 0998)
Values for VCOND (VxD ID 0038h) service number:
 0000h	get VCOND version
	Return: CF clear
		EAX = version (AH = major, AL = minor)
 0001h	"VCOND_Launch_ConApp_Inherited"
SeeAlso: #0999,#0996,#1000

(Table 0999)
Values for Windows95 VCOND (Vxd ID 0038h) Win32 service number:
 00h	get VCOND version
	Return: EAX = version (AH = major, AL = minor)
 ...
 34h	...last Win32 service for Windows95 SP1
SeeAlso: #0998
--------W-20----Vx003D-----------------------
INT 20 P - Microsoft Windows - BIOS - VxD SERVICES
	VxD = 003Dh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1000)
Values for BIOS (VxD ID 003Dh) service number:
 00h	get version???
 01h	???
 02h	???
 03h	???
SeeAlso: #0998,#1001
--------W-20----Vx003E-----------------------
INT 20 P - Microsoft Windows - WSOCK - VxD SERVICES
	VxD = 003Eh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1001)
Values for WSOCK (VxD ID 003Eh) service number:
 00h	get WSOCK version
	Return: CF clear
		AH = major version
		AL = minor version
		EAX high word = 0000h
 01h	???
	EAX = ??? or 00000000h
	Return: CF clear if successful
		    EAX = 00000000h
		CF set on error
		    EAX = ???
 02h	???
	EAX = ??? or 00000000h
	Return: ???
 03h	???
 04h	...last service for Windows95 SP1
SeeAlso: #1000,#1002
--------W-20----Vx0040-----------------------
INT 20 P - Microsoft Windows - IFSMgr - VxD SERVICES
	VxD = 0040h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1002)
Values for IFSMGR (VxD ID 0040h) service number:
 00h	get version
 01h	"RegisterMount"
 02h	"RegisterNet"
 03h	"RegisterMailSlot"
 04h	"Attach"
 05h	"Detach"
 06h	"Get_NetTime"
 07h	"Get_DOSTime"
 08h	"SetupConnection"
 09h	"DerefConnection"
 0Ah	"ServerDOSCall"
 0Bh	"CompleteAsync"
 0Ch	"RegisterHeap"
 0Dh	"GetHeap"
 0Eh	"RetHeap"
 0Fh	"CheckHeap"
 10h	"CheckHeapItem"
 11h	"FillHeapSpare"
 12h	"Block"
 13h	"Wakeup"
 14h	"Yield"
 15h	"SchedEvent"
 16h	"QueueEvent"
 17h	"KillEvent"
 18h	"FreeIOReg"
 19h	"MakeMailSlot"
 1Ah	"DeleteMailSlot"
 1Bh	"WriteMailSlot"
 1Ch	"PopUp"
 1Dh	"printf"
 1Eh	"AssertFailed"
 1Fh	"LogEntry"
 20h	"DebugMenu"
 21h	"DebugVars"
 22h	"GetDebugString"
 23h	"GetDebugHexNum"
 24h	"NetFunction"
 25h	"DoDelAllUses"
 26h	"SetErrString"
 27h	"GetErrString"
 28h	"SetReqHook"
 29h	"SetPathHook"
 2Ah	"UseAdd"
 2Bh	"UseDel"
 2Ch	"InitUseAdd"
 2Dh	"ChangeDir"
 2Eh	"DelAllUses"
 2Fh	"CDROM_Attach"
 30h	"CDROM_Detach"
 31h	"Win32DupHandle"
 32h	"Ring0_FileIO"
 33h	"Toggle_Extended_File_Handle"
 34h	"IFSMgr_GetDrive_Info"
 35h	"IFSMgr_Ring0GetDriveInfo"
 36h	"IFSMgr_BlockNoEvents"
 37h	"IFSMgr_NetToDosTime"
 38h	"IFSMgr_DosToNetTime"
 39h	"IFSMgr_DosToWin32Time"
 3Ah	"IFSMgr_Win32ToDosTime"
 3Bh	"IFSMgr_NetToWin32Time"
 3Ch	"IFSMgr_Win32ToNetTime"
 3Dh	"IFSMgr_MetaMatch"
 3Eh	"IFSMgr_TransMatch"
 3Fh	"IFSMgr_CallProvider"
 40h	"UniToBCS"
 41h	"UniToBCSPath"
 42h	"BCSToUni"
 43h	"UniToUpper"
 44h	"UniCharToOEM"
 45h	"CreateBasis"
 46h	"MatchBasisName"
 47h	"AppendBasisTail"
 48h	"FcbToShort"
 49h	"ShortToFcb"
 4Ah	"IFSMgr_ParsePath"
 4Bh	"Query_PhysLock"
 4Ch	"_VolFlush"
 4Dh	"NotifyVolumeArrival"
 4Eh	"NotifyVolumeRemoval"
 4Fh	"QueryVolumeRemoval"
 50h	"IFSMgr_FSDUnmountCFSD"
 51h	"IFSMgr_GetConversionTablePtrs"
 52h	"IFSMgr_CheckAccessConflict"
 53h	"IFSMgr_LockFile"
 54h	"IFSMgr_UnlockFile"
 55h	"IFSMgr_RemoveLocks"
 56h	"IFSMgr_CheckLocks"
 57h	"IFSMgr_CountLocks"
 58h	"IFSMgr_ReassignLockFileInst"
 59h	"IFSMgr_UnassignLockList"
 5Ah	"IFSMgr_MountChildVolume"
 5Bh	"IFSMgr_UnmountChildVolume"
 5Ch	"IFSMgr_SwapDrives"
 5Dh	"IFSMgr_FSDMapFHtoIOREQ"
 5Eh	"IFSMgr_FSDParsePath"
 5Fh	"IFSMgr_FSDAttachSFT"
 60h	"IFSMgr_GetTimeZoneBias"
 61h	"IFSMgr_PNPEvent"
 62h	"IFSMgr_RegisterCFSD"
 63h	"IFSMgr_Win32MapExtendedHandleToSFT"
 64h	"IFSMgr_DbgSetFileHandleLimit"
 65h	"IFSMgr_Win32MapSFTToExtendedHandle"
 66h	"IFSMgr_FSDGetCurrentDrive"
 67h	"IFSMgr_InstallFileSystemApiHook"
 68h	"IFSMgr_RemoveFileSystemApiHook"
 69h	"IFSMgr_RunScheduledEvents"
 6Ah	"IFSMgr_CheckDelResource"
 6Bh	"IFSMgr_Win32GetVMCurdir"
 6Ch	"IFSMgr_SetupFailedConnection"
 6Dh	"_GetMappedErr"
 6Eh	"ShortToLossyFcb"
 6Fh	"IFSMgr_GetLockState"
 70h	"BcsToBcs"
 71h	"IFSMgr_SetLoopback"
 72h	"IFSMgr_ClearLoopback"
 73h	"IFSMgr_ParseOneElement"
 74h	"BcsToBcsUpper"
SeeAlso: #1001,#1003
--------W-20----Vx0041-----------------------
INT 20 P - Microsoft Windows - VCDFSD - VxD SERVICES
	VxD = 0041h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1003)
Values for VCDFSD (VxD ID 0041h) service number:
 00h	get VCDFSD version???
 01h	???
 02h	???
 03h	???
SeeAlso: #1002,#1004
--------W-20----Vx0048-----------------------
INT 20 P - Microsoft Windows - PERF - VxD SERVICES
	VxD = 0048h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1004)
Values for PERF (VxD ID 0048h) service number:
 00h	get version
	Return: CF clear
		EAX = version (AH = major, AL = minor)
 01h	"PERF_Server_Register"
	(creates/sets a registry key for the server)
 02h	"PERF_Server_Deregister"
	end performance monitoring (deletes registry key for server)
 03h	"PERF_Server_Add_Stat"
	start performance monitoring (creates/sets a registry key)
 04h	"PERF_Server_Remove_Stat"
	end performance monitoring (deletes registry key)
SeeAlso: #1003,#1005
--------W-20----Vx011F-----------------------
INT 20 P - Microsoft Windows - VFLATD - VxD SERVICES
	VxD = 011Fh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1005)
Values for VFLATD (VxD ID 011Fh) service number:
 00h	get VFLATD version???
 01h	???
SeeAlso: #1004,#1006
--------W-20----Vx0449-----------------------
INT 20 P - Microsoft Windows - vjoyd - VxD SERVICES
	VxD = 0449h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1006)
Values for vjoyd (VxD ID 0449h) service number:
 00h	get vjoyd version???
 01h	???
SeeAlso: #1005,#1007
--------W-20----Vx044A-----------------------
INT 20 P - Microsoft Windows - mmdevldr - VxD SERVICES
	VxD = 044Ah
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1007)
Values for mmdevldr (VxD ID 044Ah) service number:
 00h	get mmdevldr version???
 01h	???
 02h	???
 03h	???
 04h	???
 05h	???
SeeAlso: #1006,#1008
--------W-20----Vx0480-----------------------
INT 20 P - Microsoft Windows - VNetSup - VxD SERVICES
	VxD = 0480h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1008)
Values for VNetSup (VxD ID 0480h) service number:
 00h	get VNetSup version???
 01h	???
 02h	???
 03h	???
 04h	???
 05h	???
 06h	???
SeeAlso: #1007,#1009
--------W-20----Vx0481-----------------------
INT 20 P - Microsoft Windows - VREDIR - VxD SERVICES
	VxD = 0481h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1009)
Values for VREDIR (VxD ID 0481h) service number:
 0000h	"VRedir_Get_Version"
 0001h	"VRedir_Register"
 0002h	"VRedir_MakeMailSlot"
 0003h	"VRedir_DeleteMailSlot"
 0004h	"VRedir_ServerEnum"
 0010h	...last service for Windows95 SP1
SeeAlso: #1008,#1010
--------W-20----Vx0483-----------------------
INT 20 P - Microsoft Windows - VSHARE - VxD SERVICES
	VxD = 0483h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1010)
Values for VSHARE (VxD ID 0483h) service number:
 00h	get VSHARE version???
SeeAlso: #1009,#1011
--------W-20----Vx0487-----------------------
INT 20 P - Microsoft Windows - NWLINK - VxD SERVICES
	VxD = 0487h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1011)
Values for NWLINK (VxD ID 0487h) service number:
 00h	get NWLINK version???
 01h	???
 06h	...last service for Windows95 SP1
SeeAlso: #1010,#1012,#2329
--------W-20----Vx0488-----------------------
INT 20 P - Microsoft Windows - VTDI - VxD SERVICES
	VxD = 0488h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1012)
Values for VTDI (VxD ID 0488h) service number:
 00h	get VTDI version???
 01h	???
 0Dh	...last service for Windows95 SP1
SeeAlso: #1011,#1013
--------W-20----Vx0489-----------------------
INT 20 P - Microsoft Windows - VIP - VxD SERVICES
	VxD = 0489h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1013)
Values for VIP (VxD ID 0489h) service number:
 00h	get VIP version???
 01h	???
 08h	...last service for Windows95 SP1
SeeAlso: #1012,#1014
--------W-20----Vx048A-----------------------
INT 20 P - Microsoft Windows - MSTCP - VxD SERVICES
	VxD = 048Ah
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1014)
Values for MSTCP (VxD ID 048Ah) service number:
 00h	get MSTCP version???
SeeAlso: #1013,#1015
--------W-20----Vx048B-----------------------
INT 20 P - Microsoft Windows - VCACHE - VxD SERVICES
	VxD = 048Bh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1015)
Values for VCACHE (VxD ID 048Bh) service number:
 0000h	"VCACHE_Get_Version"
 0001h	"VCACHE_Register"
 0002h	"VCACHE_GetSize"
 0003h	"VCACHE_CheckAvail"
 0004h	"VCACHE_FindBlock"
 0005h	"VCACHE_FreeBlock"
 0006h	"VCACHE_MakeMRU"
 0007h	"VCACHE_Hold"
 0008h	"VCACHE_Unhold"
 0009h	"VCACHE_Enum"
 000Ah	"VCACHE_TestHandle"
 000Bh	"VCACHE_VerifySums"
 000Ch	"VCACHE_RecalcSums"
 000Dh	"VCACHE_TestHold"
 000Eh	"VCACHE_GetStats"
 000Fh	"VCache_Deregister"
 0010h	"VCache_AdjustMinimum"
 0011h	"VCache_SwapBuffers"
 0012h	"VCache_RelinquishPage"
 0013h	"VCache_UseThisPage"
 0014h	"_VCache_CreateLookupCache"
 0015h	"_VCache_CloseLookupCache"
 0016h	"_VCache_DeleteLookupCache"
 0017h	"_VCache_Lookup"
 0018h	"_VCache_UpdateLookup"
SeeAlso: #1014,#1016
--------W-20----Vx048E-----------------------
INT 20 P - Microsoft Windows - NWREDIR - VxD SERVICES
	VxD = 048Eh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1016)
Values for NWREDIR (VxD ID 048Eh) service number:
 00h	get NWREDIR version???
 01h	???
SeeAlso: #1015,#1017
--------W-20----Vx0491-----------------------
INT 20 P - Microsoft Windows - FILESEC - VxD SERVICES
	VxD = 0491h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1017)
Values for FILESEC (VxD ID 0491h) service number:
 00h	get FILESEC version???
 01h	???
 10h	...last service for Windows95 SP1
SeeAlso: #1016,#1018
--------W-20----Vx0492-----------------------
INT 20 P - Microsoft Windows - NWSERVER - VxD SERVICES
	VxD = 0492h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1018)
Values for NWSERVER (VxD ID 0492h) service number:
 00h	get NWSERVER version???
 01h	???
 02h	???
 03h	???
SeeAlso: #1017,#1019
--------W-20----Vx0493-----------------------
INT 20 P - Microsoft Windows - MSSP / NWSP - VxD SERVICES
	VxD = 0493h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1019)
Values for MSSP/NWSP (VxD ID 0493h) service number:
 00h	get NSSP / NWSP version???
 01h	???
 06h	...last service for Windows95 SP1
SeeAlso: #1018,#1020
--------W-20----Vx0494-----------------------
INT 20 P - Microsoft Windows - NSCL - VxD SERVICES
	VxD = 0494h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1020)
Values for NSCL (VxD ID 0494h)	service number:
 00h	get NSCL version???
 01h	???
 02h	???
SeeAlso: #1019,#1021
--------W-20----Vx0495-----------------------
INT 20 P - Microsoft Windows - AFVXD - VxD SERVICES
	VxD = 0495h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1021)
Values for AFVXD (VxD ID 0495h) service number:
 00h	get version
	Return: CF clear
		AX = version (AH = high, AL = low)
 01h	???
	EAX -> ???
	EBX -> ???
	ECX = ???
	Return:	???
 02h	???
	EAX -> ???
	Return: ???
SeeAlso: #1020,#1022
--------W-20----Vx0496-----------------------
INT 20 P - Microsoft Windows - NDIS2SUP - VxD SERVICES
	VxD = 0496h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier (see #2329)
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1022)
Values for NDIS2SUP (VxD ID 0496h) service number:
 00h	get NDIS2SUP version???
 01h	???
SeeAlso: #1021,#1023
--------W-20----Vx0498-----------------------
INT 20 P - Microsoft Windows - Splitter - VxD SERVICES
	VxD = 0498h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier (see #2329)
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1023)
Values for Splitter (VxD ID 0498h) service number:
 00h	get Splitter version
	Return:	CF clear
		EAX = version (00000001h)
 01h	???
 02h	???
 03h	hook/unhook VMM "hook device service" service
	EAX = request (0 = unhook, nonzero = hook)
	Return: if EAX nonzero on entry, Splitter's service 04h replaces VMM
		  service 0090h; otherwise, default handler is restored
 04h	Splitter "hook device service" handler
SeeAlso: #1022,#1024
--------W-20----Vx0499-----------------------
INT 20 P - Microsoft Windows - PPPMAC - VxD SERVICES
	VxD = 0499h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier (see #2329)
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1024)
Values for PPPMAC (VxD ID 0499h) service number:
 00h	???
 09h	...last service for Windows95 SP1
SeeAlso: #1023,#1025,#2329
--------W-20----Vx049A-----------------------
INT 20 P - Microsoft Windows - VDHCP - VxD SERVICES
	VxD = 049Ah
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier (see #2329)
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1025)
Values for VDHCP (VxD ID 049Ah) service number:
 00h	get VDHCP version???
 01h	???
 02h	???
 03h	???
SeeAlso: #1024,#1026
--------W-20----Vx049B-----------------------
INT 20 P - Microsoft Windows - VNBT - VxD SERVICES
	VxD = 049Bh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier (see #2329)
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1026)
Values for VNBT (VxD ID 049Bh) service number:
 00h	get VNBT version???
SeeAlso: #1025,#1027
--------W-20----Vx049D-----------------------
INT 20 P - Microsoft Windows - LOGGER - VxD SERVICES
	VxD = 049Dh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier (see #2329)
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1027)
Values for LOGGER (VxD ID 049Dh) service number:
 00h	get LOGGER version???
 01h	???
 02h	???
 03h	???
 04h	???
SeeAlso: #1026,#1028
--------W-20----Vx097C-----------------------
INT 20 P - Microsoft Windows - PCCARD - VxD SERVICES
	VxD = 097Ch
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier (see #2329)
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#1028,#1032

(Table 1028)
Values for PCCARD (VxD ID 097Ch) service number:
 0000h	"PCCARD_Get_Version"
 0001h	"PCCARD_Card_Services"
SeeAlso: #1027,#1029
--------W-20----Vx3098-----------------------
INT 20 P - QEMM - VstlthD - VxD SERVICES
	VxD = 3098h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1029)
Values for VStlthD (VxD ID 3098h) service number:
 00h	get version
	Return:	CF clear
		EAX = version (AH = major, AL = BCD minor)
 01h	???
 02h	get current ???
	Return: CF clear
		EDX = current value of ???
 03h	???
SeeAlso: #1028,#1030
--------W-20----Vx30F6-----------------------
INT 20 P - Microsoft Windows - WSVV - VxD SERVICES
	VxD = 30F6h
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1030)
Values for WSVV (VxD ID 30F6h) service number:
 00h	get WSVV version???
SeeAlso: #1029,#1031
--------W-20----Vx33FC-----------------------
INT 20 P - Microsoft Windows - APSIENUM - VxD SERVICES
	VxD = 33FCh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1031)
Values for ASPIENUM (VxD ID 33FCh) service number:
 00h	get ASPIENUM version???
 01h	???
 02h	???
 03h	???
SeeAlso: #1030,#1032
--------W-20----Vx357E-----------------------
INT 20 P - Microsoft Windows - DSOUND - VxD SERVICES
	VxD = 357Eh
Note:	the desired VxD and service number are identified by the data
	  immediately following the INT 20 instruction, as in:
		INT	20h
		DW	service number
		DW	VxD identifier
SeeAlso: INT 2F/AX=1684h"DEVICE API",INT 30"Windows",#0961,#1032

(Table 1032)
Values for DSOUND (VxD ID 357Eh) service number:
 00h	get DSOUND version???
 01h	???
 02h	???
SeeAlso: #1031,#2329
--------G-21---------------------------------
INT 21 - COMTROL HOSTESS i/ISA DEBUGGER - GET SEGMENT FOR CONTROL PROGRAM USE
	???
Return: AX = first segment available for control program use
SeeAlso: INT 20"COMTROL",INT 22"COMTROL"
--------D-2100-------------------------------
INT 21 - DOS 1+ - TERMINATE PROGRAM
	AH = 00h
	CS = PSP segment
Notes:	Microsoft recommends using INT 21/AH=4Ch for DOS 2+
	this function sets the program's return code (ERRORLEVEL) to 00h
	execution continues at the address stored in INT 22 after DOS performs
	  whatever cleanup it needs to do (restoring the INT 22,INT 23,INT 24
	  vectors from the PSP assumed to be located at offset 0000h in the
	  segment indicated by the stack copy of CS, etc.)
	if the PSP is its own parent, the process's memory is not freed; if
	  INT 22 additionally points into the terminating program, the
	  process is effectively NOT terminated
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=26h,AH=31h,AH=4Ch,INT 20,INT 22
--------D-2101-------------------------------
INT 21 - DOS 1+ - READ CHARACTER FROM STANDARD INPUT, WITH ECHO
	AH = 01h
Return: AL = character read
Notes:	^C/^Break are checked, and INT 23 executed if read
	^P toggles the DOS-internal echo-to-printer flag
	^Z is not interpreted, thus not causing an EOF if input is redirected
	character is echoed to standard output
	standard input is always the keyboard and standard output the screen
	  under DOS 1.x, but they may be redirected under DOS 2+
SeeAlso: AH=06h,AH=07h,AH=08h,AH=0Ah
--------v-21010F-----------------------------
INT 21 - VIRUS - "Susan" - INSTALLATION CHECK
	AX = 010Fh
Return: AX = 7553h ("Su") if resident
SeeAlso: INT 16/AH=DDh"VIRUS",INT 21/AX=0B56h
--------D-2102-------------------------------
INT 21 - DOS 1+ - WRITE CHARACTER TO STANDARD OUTPUT
	AH = 02h
	DL = character to write
Return: AL = last character output (despite the official docs which state
		nothing is returned) (at least DOS 2.1-7.0)
Notes:	^C/^Break are checked, and INT 23 executed if pressed
	standard output is always the screen under DOS 1.x, but may be
	  redirected under DOS 2+
	the last character output will be the character in DL unless DL=09h
	  on entry, in which case AL=20h as tabs are expanded to blanks
	if standard output is redirected to a file, no error checks (write-
	  protected, full media, etc.) are performed
SeeAlso: AH=06h,AH=09h
--------D-2103-------------------------------
INT 21 - DOS 1+ - READ CHARACTER FROM STDAUX
	AH = 03h
Return: AL = character read
Notes:	keyboard checked for ^C/^Break, and INT 23 executed if detected
	STDAUX is usually the first serial port
SeeAlso: AH=04h,INT 14/AH=02h,INT E0/CL=03h
--------D-2104-------------------------------
INT 21 - DOS 1+ - WRITE CHARACTER TO STDAUX
	AH = 04h
	DL = character to write
Notes:	keyboard checked for ^C/^Break, and INT 23 executed if detected
	STDAUX is usually the first serial port
	if STDAUX is busy, this function will wait until it becomes free
SeeAlso: AH=03h,INT 14/AH=01h,INT E0/CL=04h
--------D-2105-------------------------------
INT 21 - DOS 1+ - WRITE CHARACTER TO PRINTER
	AH = 05h
	DL = character to print
Notes:	keyboard checked for ^C/^Break, and INT 23 executed if detected
	STDPRN is usually the first parallel port, but may be redirected under
	  DOS 2+
	if the printer is busy, this function will wait
SeeAlso: INT 17/AH=00h
--------D-2106-------------------------------
INT 21 - DOS 1+ - DIRECT CONSOLE OUTPUT
	AH = 06h
	DL = character (except FFh)
Return: AL = character output (despite official docs which state nothing is
		returned) (at least DOS 2.1-7.0)
Notes:	does not check ^C/^Break
	writes to standard output, which is always the screen under DOS 1.x,
	  but may be redirected under DOS 2+
SeeAlso: AH=02h,AH=09h
--------D-2106--DLFF-------------------------
INT 21 - DOS 1+ - DIRECT CONSOLE INPUT
	AH = 06h
	DL = FFh
Return: ZF set if no character available
	    AL = 00h
	ZF clear if character available
	    AL = character read
Notes:	^C/^Break are NOT checked
	if the returned character is 00h, the user pressed a key with an
	  extended keycode, which will be returned by the next call of this
	  function
	this function reads from standard input, which is always the keyboard
	  under DOS 1.x, but may be redirected under DOS 2+
	although the return of AL=00h when no characters are available is not
	  documented, some programs rely on this behavior
SeeAlso: AH=0Bh
--------D-2107-------------------------------
INT 21 - DOS 1+ - DIRECT CHARACTER INPUT, WITHOUT ECHO
	AH = 07h
Return: AL = character read from standard input
Notes:	does not check ^C/^Break
	standard input is always the keyboard under DOS 1.x, but may be
	  redirected under DOS 2+
	if the interim console flag is set (see AX=6301h), partially-formed
	  double-byte characters may be returned
SeeAlso: AH=01h,AH=06h,AH=08h,AH=0Ah
--------D-2108-------------------------------
INT 21 - DOS 1+ - CHARACTER INPUT WITHOUT ECHO
	AH = 08h
Return: AL = character read from standard input
Notes:	^C/^Break are checked, and INT 23 executed if detected
	standard input is always the keyboard under DOS 1.x, but may be
	  redirected under DOS 2+
	if the interim console flag is set (see AX=6301h), partially-formed
	  double-byte characters may be returned
SeeAlso: AH=01h,AH=06h,AH=07h,AH=0Ah,AH=64h"DOS 3.2+"
--------D-2109-------------------------------
INT 21 - DOS 1+ - WRITE STRING TO STANDARD OUTPUT
	AH = 09h
	DS:DX -> '$'-terminated string
Return: AL = 24h (the '$' terminating the string, despite official docs which
		state that nothing is returned) (at least DOS 2.1-7.0 and
		NWDOS)
Notes:	^C/^Break are checked, and INT 23 is called if either pressed
	standard output is always the screen under DOS 1.x, but may be
	  redirected under DOS 2+
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
SeeAlso: AH=02h,AH=06h"OUTPUT"
--------D-210A-------------------------------
INT 21 - DOS 1+ - BUFFERED INPUT
	AH = 0Ah
	DS:DX -> buffer (see #1033)
Return: buffer filled with user input
Notes:	^C/^Break are checked, and INT 23 is called if either detected
	reads from standard input, which may be redirected under DOS 2+
	if the maximum buffer size (see #1033) is set to 00h, this call returns
	  immediately without reading any input
SeeAlso: AH=0Ch,INT 2F/AX=4810h

Format of DOS input buffer:
Offset	Size	Description	(Table 1033)
 00h	BYTE	maximum characters buffer can hold
 01h	BYTE	(call) number of chars from last input which may be recalled
		(ret) number of characters actually read, excluding CR
 02h  N BYTEs	actual characters read, including the final carriage return
--------K-210A00-----------------------------
INT 21 - WCED v1.6+ - INSTALLATION CHECK
	AX = 0A00h
	DS:DX -> 6-byte buffer whose first two bytes must be 00h
Return: buffer offset 02h-05h filled with "Wced" if installed
Program: WCED is a free command-line editor and history utility by Stuart
	  Russell
SeeAlso: AH=FFh"CED"
--------D-210B-------------------------------
INT 21 - DOS 1+ - GET STDIN STATUS
	AH = 0Bh
Return: AL = status
	    00h if no character available
	    FFh if character is available
Notes:	^C/^Break are checked, and INT 23 is called if either pressed
	standard input is always the keyboard under DOS 1.x, but may be
	  redirected under DOS 2+
	if the interim console flag is set (see AX=6301h), this function
	  returns AL=FFh if a partially-formed double-byte character is
	  available
SeeAlso: AH=06h"INPUT",AX=4406h
--------v-210B56-----------------------------
INT 21 - VIRUS - "Perfume" - INSTALLATION CHECK
	AX = 0B56h
Return: AX = 4952h if resident
SeeAlso: AX=0D20h,INT 12/AX=4350h/BX=4920h,INT 13/AH=F2h,INT 21/AX=010Fh
--------D-210C-------------------------------
INT 21 - DOS 1+ - FLUSH BUFFER AND READ STANDARD INPUT
	AH = 0Ch
	AL = STDIN input function to execute after flushing buffer
	other registers as appropriate for the input function
Return: as appropriate for the specified input function
Note:	if AL is not one of 01h,06h,07h,08h, or 0Ah, the buffer is flushed but
	  no input is attempted
SeeAlso: AH=01h,AH=06h"INPUT",AH=07h,AH=08h,AH=0Ah
--------D-210D-------------------------------
INT 21 - DOS 1+ - DISK RESET
	AH = 0Dh
Return: (DOS 6 only) CF clear (earlier versions preserve CF)
Notes:	This function writes all modified disk buffers to disk, but does not
	  update the directory information (that is only done when files are
	  closed or a SYNC call is issued)
SeeAlso: AX=5D01h,AX=710Dh,INT 13/AH=00h,INT 2F/AX=1120h
--------v-210D20-----------------------------
INT 21 - VIRUS - "Crazy Imp" - INSTALLATION CHECK
	AX = 0D20h
Return: AX = 1971h if resident
SeeAlso: AX=0B56h,AX=1812h,AX=2C2Ch,AX=710Dh,AH=30h/DX=ABCDh
--------D-210E-------------------------------
INT 21 - DOS 1+ - SELECT DEFAULT DRIVE
	AH = 0Eh
	DL = new default drive (00h = A:, 01h = B:, etc)
Return: AL = number of potentially valid drive letters
Notes:	under Novell NetWare, the return value is always 32, the number of
	  drives that NetWare supports
	under DOS 3.0+, the return value is the greatest of 5, the value of
	  LASTDRIVE= in CONFIG.SYS, and the number of drives actually present
	on a DOS 1.x/2.x single-floppy system, AL returns 2 since the floppy
	  may be accessed as either A: or B:
	otherwise, the return value is the highest drive actually present
	DOS 1.x supports a maximum of 16 drives, 2.x a maximum of 63 drives,
	  and 3+ a maximum of 26 drives
	under Novell DOS 7, this function returns the correct LASTDRIVE value
	  even when the undocumented LASTDRIVE=27..32 directive was used in
	  CONFIG.SYS
SeeAlso: AH=19h,AH=3Bh,AH=DBh
--------v-210E--DLAD-------------------------
INT 21 U - Novell DOS 7 - SDRes v27.03 - INSTALLATION CHECK
	AH = 0Eh
	DL = ADh
Return: AL = BAh if installed
Program: SDRes is the resident portion of the Search&Destroy antiviral by
	  Fifth Generation Systems, as bundled with Novell DOS 7
Note:	SDRes will terminate programs which test for the presence of viruses
	  using interrupt-based installation calls, saying that the program
	  may be infected
SeeAlso: AH=0Eh/DL=AEh,AH=0Eh/DL=AFh,AH=4Ah/BX=00B6h,INT 13/AX=A759h
--------v-210E--DLAE-------------------------
INT 21 U - Novell DOS 7 - SDRes v27.03 - CLEAR ??? FLAG
	AH = 0Eh
	DL = AEh
SeeAlso: AH=0Eh/DL=ADh,AH=0Eh/DL=AFh,INT 13/AX=A759h
--------v-210E--DLAF-------------------------
INT 21 U - Novell DOS 7 - SDRes v27.03 - SET ??? FLAG
	AH = 0Eh
	DL = AFh
SeeAlso: AH=0Eh/DL=ADh,AH=0Eh/DL=AEh,INT 13/AX=A759h
--------D-210F-------------------------------
INT 21 - DOS 1+ - OPEN FILE USING FCB
	AH = 0Fh
	DS:DX -> unopened File Control Block (see #1034,#1035)
Return: AL = status
	    00h successful
	    FFh file not found or access denied
Notes:	(DOS 3.1+) file opened for read/write in compatibility mode
	an unopened FCB has the drive, filename, and extension fields filled
	  in and all other bytes cleared
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
	DR DOS checks password attached with AX=4303h
	(FAT32 drive) this function will only succeed for creating a volume
	  label; FAT32 does not support FCBs for file I/O
BUG:	APPEND for DOS 3.3+ corrupts DX if the file is not found
SeeAlso: AH=10h,AH=16h,AH=3Dh,AX=4303h

Format of File Control Block:
Offset	Size	Description	(Table 1034)
 00h	BYTE	drive number (0 = default, 1 = A, etc)
		FFh is not allowed (signals extended FCB, see #1035)
 01h  8 BYTEs	blank-padded file name
 09h  3 BYTEs	blank-padded file extension
 0Ch	WORD	current block number
 0Eh	WORD	logical record size
 10h	DWORD	file size
 14h	WORD	date of last write (see #1352 at AX=5700h)
 16h	WORD	time of last write (see #1351 at AX=5700h) (DOS 1.1+)
 18h  8 BYTEs	reserved (see #1036,#1037,#1038,#1039,#1040)
 20h	BYTE	record within current block
 21h	DWORD	random access record number (if record size is > 64 bytes, high
		  byte is omitted)
SeeAlso: #1035

Format of Extended File Control Block (XFCB):
Offset	Size	Description	(Table 1035)
 00h	BYTE	FFh signature for extended FCB
 01h  5 BYTEs	reserved
 06h	BYTE	file attribute if extended FCB
 07h 36 BYTEs	standard FCB (all offsets are shifted by seven bytes)
SeeAlso: #0942

Format of FCB reserved field for DOS 1.0:
Offset	Size	Description	(Table 1036)
 16h	WORD	location in directory (if high byte = FFh, low byte is device
		  ID)
 18h	WORD	number of first cluster in file
 1Ah	WORD	current absolute cluster number on disk
 1Ch	WORD	current relative cluster number within file
		(0 = first cluster of file, 1 = second cluster, etc.)
 1Eh	BYTE	dirty flag (00h = not dirty)
 1Fh	BYTE	unused

Format of FCB reserved field for DOS 1.10-1.25:
Offset	Size	Description	(Table 1037)
 18h	BYTE	bit 7: set if logical device
		bit 6: not dirty
		bits 5-0: disk number or logical device ID
 19h	WORD	starting cluster number on disk
 1Bh	WORD	current absolute cluster number on disk
 1Dh	WORD	current relative cluster number within file
 1Fh	BYTE	unused

Format of FCB reserved field for DOS 2.x:
Offset	Size	Description	(Table 1038)
 18h	BYTE	bit 7: set if logical device
		bit 6: set if open???
		bits 5-0: ???
 19h	WORD	starting cluster number on disk
 1Bh	WORD	???
 1Dh	BYTE	???
 1Eh	BYTE	???
 1Fh	BYTE	???

Format of FCB reserved field for DOS 3.x:
Offset	Size	Description	(Table 1039)
 18h	BYTE	number of system file table entry for file
 19h	BYTE	attributes
		bits 7,6: 00 = SHARE.EXE not loaded, disk file
			  01 = SHARE.EXE not loaded, character device
			  10 = SHARE.EXE loaded, remote file
			  11 = SHARE.EXE loaded, local file or device
		bits 5-0: low six bits of device attribute word
---SHARE.EXE loaded, local file---
 1Ah	WORD	starting cluster of file on disk
 1Ch	WORD	(DOS 3.x) offset within SHARE of sharing record
		  (see #1323 at AH=52h)
 1Eh	BYTE	file attribute
 1Fh	BYTE	???
---SHARE.EXE loaded, remote file---
 1Ah	WORD	number of sector containing directory entry (see #1041)
 1Ch	WORD	relative cluster within file of last cluster accessed
 1Eh	BYTE	absolute cluster number of last cluster accessed
 1Fh	BYTE	???
---SHARE.EXE not loaded---
 1Ah	BYTE	(low byte of device attribute word AND 0Ch) OR open mode
 1Bh	WORD	starting cluster of file
 1Dh	WORD	number of sector containing directory entry (see #1041)
 1Fh	BYTE	number of directory entry within sector
Note:	if FCB opened on character device, DWORD at 1Ah is set to the address
	  of the device driver header, then the BYTE at 1Ah is overwritten.
SeeAlso: #1332

Format of FCB reserved field for DOS 5.0:
Offset	Size	Description	(Table 1040)
 18h	BYTE	number of system file table entry for file
 19h	BYTE	attributes
		bits 7,6: 00 = SHARE.EXE not loaded, disk file
			  01 = SHARE.EXE not loaded, character device
			  10 = SHARE.EXE loaded, remote file
			  11 = SHARE.EXE loaded, local file or device
		bits 5-0: low six bits of device attribute word
---SHARE.EXE loaded, local file---
 1Ah	WORD	starting cluster of file on disk
 1Ch	WORD	unique sequence number of sharing record
 1Eh	BYTE	file attributes
 1Fh	BYTE	unused???
---SHARE.EXE loaded, remote file---
 1Ah	WORD	network handle
 1Ch	DWORD	network ID
---SHARE not loaded, local device---
 1Ah	DWORD	pointer to device driver header (see #1332)
 1Eh  2 BYTEs	unused???
---SHARE not loaded, local file---
 1Ah	BYTE	extra info
		bit 7: read-only attribute from SFT
		bit 6: archive attribute from SFT
		bits 5-0: high bits of sector number
 1Bh	WORD	starting cluster of file
 1Dh	WORD	low word of sector number containing directory entry
		(see #1041)
 1Fh	BYTE	number of directory entry within sector
--------D-2110-------------------------------
INT 21 - DOS 1+ - CLOSE FILE USING FCB
	AH = 10h
	DS:DX -> File Control Block (see #1034)
Return: AL = status
	    00h successful
	    FFh failed
Notes:	a successful close forces all disk buffers used by the file to be
	  written and the directory entry to be updated
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=0Fh,AH=16h,AH=3Eh
--------D-2111-------------------------------
INT 21 - DOS 1+ - FIND FIRST MATCHING FILE USING FCB
	AH = 11h
	DS:DX -> unopened FCB (see #1034), may contain '?' wildcards
Return: AL = status
	    00h successful
		[DTA] unopened FCB for first matching file
	    FFh no matching filename, or bad FCB
Notes:	the type of the returned FCB depends on whether the input FCB was a
	  normal or an extended FCB
	the data returned in the DTA (disk transfer area) is actually the
	  drive number (or extended FCB header and drive number) followed by
	  the file's directory entry (see #1041); this format happens to be
	  compatible with an unopened FCB
	for extended FCBs with search attribute 08h, the volume label (if any)
	  will be returned even if the current directory is not the root dir.
	DOS 3.0+ also allows the '*' wildcard
	the search FCB must not be modified if AH=12h will be used to continue
	  searching; DOS 3.3 has set the following parts of the FCB:
		 0Ch	BYTE	???
		 0Dh	WORD	directory entry number of matching file
		 0Fh	WORD	cluster number of current directory
		 11h  4 BYTEs	???
		 15h	BYTE	drive number (1=A:)
	this function is used by many copy protection schemes to obtain the
	  starting cluster of a file
SeeAlso: AH=12h,AH=1Ah,AH=4Eh,INT 2F/AX=111Bh

Format of DOS directory entry:
Offset	Size	Description	(Table 1041)
 00h  8 BYTEs	blank-padded filename
		first character is set to E5h for deleted files (05h for
		  pending delete files under Novell DOS / OpenDOS)
 08h  3 BYTEs	blank-padded file extension
 0Bh	BYTE	attributes
 0Ch 10 BYTEs	(MS-DOS 1.0-6.22) reserved
		(DR DOS) used to store file password / owner (see #3763)
			(see also INT 21/AX=4302h)
		(Novell DOS 7) DELWATCH data (see #3763)
		(MS-DOS 7/Windows95) additional file times (see #1042)
 16h	WORD	time of creation or last update (see #1351 at AX=5700h)
 18h	WORD	date of creation or last update (see #1352 at AX=5700h)
 1Ah	WORD	starting cluster number (see also AX=440Dh/CX=0871h)
 1Ch	DWORD	file size
SeeAlso: #1043,#2315,#2316

Format of MS-DOS 7/Windows95 additional file times:
Offset	Size	Description	(Table 1042)
 00h	BYTE	reserved
 01h	BYTE	10-millisecond units past creation time below
 02h	WORD	file creation time
 04h	WORD	file creation date
 06h	WORD	last-access date
 08h	WORD	(FAT32) high word of starting cluster number
Note:	this data is stored beginning at offset 0Ch in a standard directory
	  entry
SeeAlso: #1041

Format of DR DOS 6/Novell DOS 7 additional file information:
Offset	Size	Description	(Table 3763)
 0Ch	BYTE	reserved (00h)
 0Dh	BYTE	first character of original filename for deleted file
 0Eh	WORD	encrypted file/directory password
 10h	WORD	reserved (00h)
		(Novell DOS 7 DELWATCH) original file time
		    cleared when file is undeleted or purged
 12h	WORD	(DR DOS 6) file owner ID
		(Novell DOS 7 DELWATCH) original file date
		    cleared when file is undeleted or purged
 14h	WORD	single/multiuser file/directory access rights (see AX=4302h)
---deleted files---
 16h	WORD	(Novell DOS 7 DELWATCH) time of deletion
 18h	WORD	(Novell DOS 7 DELWATCH) date of deletion
Note:	offsets are within the full directory entry
SeeAlso: #1041

Format of MS-DOS 7/Windows95 long-filename directory entry:
Offset	Size	Description	(Table 1043)
 00h	BYTE	LFN record sequence and flags
		bits 5-0: sequence number
		bit 6: set if last long-filename record for file
		bit 7: set if file deleted
 01h 10 BYTEs	long filename, first part
 0Bh	BYTE	0Fh (otherwise impossible file attribute, used as signature)
 0Ch	BYTE	reserved??? (00h)
 0Dh	BYTE	checksum for short filename
 0Eh 12 BYTEs	long filename, second part
 1Ah	WORD	first cluster number (always 0000h for LFN records)
 1Ch  4 BYTEs	long filename, third part
Notes:	long-filename entries are always stored in the directory just prior
	  to the short-name entry for a file
	multiple LFN records are used if the long filename does not fit into
	  a single record
	the short-filename checksum byte is computed by adding up the
	  eleven bytes of the short filename, rotating the intermediate
	  sum right one bit before adding the next character
	the long filename is encoded as 16-bit Unicode characters; for most
	  filenames, this appears in the directory as the ASCII character
	  followed by 00h
SeeAlso: #1041,INT 21/AX=5704h,INT 21/AH=71h
--------D-2112-------------------------------
INT 21 - DOS 1+ - FIND NEXT MATCHING FILE USING FCB
	AH = 12h
	DS:DX -> unopened FCB (see #1034)
Return: AL = status
	    00h successful
		Disk Transfer Area filled with unopened FCB
	    FFh no more matching filenames
Note:	(see AH=11h)
	assumes that successful FindFirst executed on search FCB before call
SeeAlso: AH=1Ah,AH=4Fh,INT 2F/AX=111Ch
--------D-2113-------------------------------
INT 21 - DOS 1+ - DELETE FILE USING FCB
	AH = 13h
	DS:DX -> unopened FCB (see #1034), filename filled with template for
		deletion ('?' wildcards allowed)
Return: AL = status
	    00h one or more files successfully deleted
	    FFh no matching files or all were read-only or locked
Notes:	DOS 1.25+ deletes everything in the current directory (including
	  subdirectories) and sets the first byte of the name to 00h (entry
	  never used) instead of E5h if called on an extended FCB with
	  filename '???????????' and bits 0-4 of the attribute set (bits 1 and
	  2 for DOS 1.x).  This may have originally been an optimization to
	  minimize directory searching after a mass deletion (DOS 1.25+ stop
	  the directory search upon encountering a never-used entry), but can
	  corrupt the filesystem under DOS 2+ because subdirectories are
	  removed without deleting the files they contain.
	currently-open files should not be deleted
	MS-DOS allows deletion of read-only files with an extended FCB, whereas
	  Novell NetWare, DR DOS 6, and Novell DOS 7/OpenDOS 7.01 do not
	this function generates a trap "D" under OS/2 v4.x (Warp4) when called
	  on an HPFS partition with a wildcard in the filename; it operates
	  correctly on FAT partitions and when called without wildcards
SeeAlso: AH=41h,INT 2F/AX=1113h
--------D-2114-------------------------------
INT 21 - DOS 1+ - SEQUENTIAL READ FROM FCB FILE
	AH = 14h
	DS:DX -> opened FCB (see #1034)
Return: AL = status
	    00h successful
	    01h end of file (no data)
	    02h segment wrap in DTA
	    03h end of file, partial record read
	Disk Tranfer Area filled with record read from file
Notes:	reads a record of the size specified in the FCB beginning at the
	  current file position, then updates the current block and current
	  record fields in the FCB
	if a partial record was read, it is zero-padded to the full size
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=0Fh,AH=15h,AH=1Ah,AH=3Fh"DOS",INT 2F/AX=1108h
--------D-2115-------------------------------
INT 21 - DOS 1+ - SEQUENTIAL WRITE TO FCB FILE
	AH = 15h
	DS:DX -> opened FCB (see #1034)
	Disk Tranfer Area contains record to be written
Return: AL = status
	    00h successful
	    01h disk full
	    02h segment wrap in DTA
Notes:	writes a record of the size specified in the FCB beginning at the
	  current file position, then updates the current block and current
	  record fields in the FCB
	if less than a full sector is written, the data is placed in a DOS
	  buffer to be written out at a later time
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=0Fh,AH=14h,AH=1Ah,AH=40h,INT 2F/AX=1109h
--------D-2116-------------------------------
INT 21 - DOS 1+ - CREATE OR TRUNCATE FILE USING FCB
	AH = 16h
	DS:DX -> unopened FCB (see #1034), wildcards not allowed
Return: AL = status
	    00h successful
	    FFh directory full or file exists and is read-only or locked
Notes:	if file already exists, it is truncated to zero length
	if an extended FCB is used, the file is given the attribute in the
	  FCB; this is how to create a volume label in the disk's root dir
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
	(FAT32 drive) this function will only succeed for creating a volume
	  label; FAT32 does not support FCBs for file I/O
SeeAlso: AH=0Fh,AH=10h,AH=3Ch
--------D-2117-------------------------------
INT 21 - DOS 1+ - RENAME FILE USING FCB
	AH = 17h
	DS:DX -> modified FCB (see also #1034)
		the old filename ('?' wildcards OK) is in the standard location
		while the new filename ('?' wildcards OK, no drive) is stored
		in the 11 bytes beginning at offset 11h
Return: AL = status
	    00h successfully renamed
	    FFh no matching files,file is read-only, or new name already exists
Notes:	subdirectories may be renamed using an extended FCB with the
	  appropriate attribute, as may volume labels
	DR DOS checks password attached with AX=4303h before permitting rename
SeeAlso: AH=0Fh,AH=13h,AX=4303h,AH=56h,INT 2F/AX=1111h
--------D-2118-------------------------------
INT 21 - DOS 1+ - NULL FUNCTION FOR CP/M COMPATIBILITY
	AH = 18h
Return: AL = 00h
Note:	corresponds to the CP/M BDOS function "get bit map of logged drives",
	  which is meaningless under MS-DOS
SeeAlso: AH=1Dh,AH=1Eh,AH=20h,AX=4459h,INT 60/DI=0513h
--------v-211812------------------------
INT 21 - VIRUS - "Tasha Yar" - INSTALLATION CHECK
	AX = 1812h
Return: AL = 00h if resident
	DX = 4310h if resident
SeeAlso: INT 21/AX=0B56h"VIRUS",INT 21/AX=187Fh,INT 21/AX=2C2Ch"VIRUS"
--------v-21187FBX4453-----------------------
INT 21 - VIRUS - "DS-3783" -INSTALLATION CHECK
	AX = 187Fh
	BX = 4453h
Return: BX = 87A1h if resident
SeeAlso: AX=1812h"VIRUS",AX=18FFh"VIRUS"
--------v-2118FF-----------------------------
INT 21 - VIRUS - "Pathogen:SMEG" - INSTALLATION CHECK
	AX = 18FFh
Return: AX = E701h if resident
SeeAlso: INT 21/AX=1812h"VIRUS",INT 21/AX=2080h"VIRUS"
--------D-2119-------------------------------
INT 21 - DOS 1+ - GET CURRENT DEFAULT DRIVE
	AH = 19h
Return: AL = drive (00h = A:, 01h = B:, etc)
Note:	Novell NetWare uses the fact that DOS 2.x COMMAND.COM issues this call
	  from a particular location every time it starts a command to
	  determine when to issue an automatic EOJ
SeeAlso: AH=0Eh,AH=47h,AH=BBh
--------D-211A-------------------------------
INT 21 - DOS 1+ - SET DISK TRANSFER AREA ADDRESS
	AH = 1Ah
	DS:DX -> Disk Transfer Area (DTA)
Notes:	the DTA is set to PSP:0080h when a program is started
	under the FlashTek X-32 DOS extender, the pointer is in DS:EDX
SeeAlso: AH=11h,AH=12h,AH=2Fh,AH=4Eh,AH=4Fh
--------D-211B-------------------------------
INT 21 - DOS 1+ - GET ALLOCATION INFORMATION FOR DEFAULT DRIVE
	AH = 1Bh
Return: AL = sectors per cluster (allocation unit)
	CX = bytes per sector
	DX = total number of clusters
	DS:BX -> media ID byte (see #1044)
Notes:	under DOS 1.x, DS:BX points at an actual copy of the FAT; later
	  versions return a pointer to a copy of the FAT's ID byte
	this function may not be properly supported on CD-ROMs and other
	  installable file systems (use AX=4402h"CD-ROM" for CD-ROMs
	  instead)
SeeAlso: AH=1Ch,AH=36h

(Table 1044)
Values for media ID byte:
 FFh	floppy, double-sided, 8 sectors per track (320K)
 FEh	floppy, single-sided, 8 sectors per track (160K)
 FDh	floppy, double-sided, 9 sectors per track (360K)
 FCh	floppy, single-sided, 9 sectors per track (180K)
 FAh	HP 200LX D: ROM disk, 16 sectors per track (995K)
	HP 200LX E: (Stacker host drive ???)
 F9h	floppy, double-sided, 15 sectors per track (1.2M)
	floppy, double-sided, 9 sectors per track (720K,3.5")
 F8h	hard disk
 F0h	other media
	(e.g. floppy, double-sized, 18 sectors per track -- 1.44M,3.5")
--------D-211C-------------------------------
INT 21 - DOS 1+ - GET ALLOCATION INFORMATION FOR SPECIFIC DRIVE
	AH = 1Ch
	DL = drive (00h = default, 01h = A:, etc)
Return: AL = sectors per cluster (allocation unit), or FFh if invalid drive
	CX = bytes per sector
	DX = total number of clusters
	DS:BX -> media ID byte (see #1044)
Notes:	under DOS 1.x, DS:BX points at an actual copy of the FAT; later
	  versions return a pointer to a copy of the FAT's ID byte
	on a DBLSPACE drive, the total number of clusters is based on the
	  estimated compression ratio
	this function may not be properly supported on CD-ROMs and other
	  installable file systems (use AX=4402h"CD-ROM" for CD-ROMs
	  instead)
SeeAlso: AH=1Bh,AH=36h
--------D-211D-------------------------------
INT 21 - DOS 1+ - NULL FUNCTION FOR CP/M COMPATIBILITY
	AH = 1Dh
Return: AL = 00h
Note:	corresponds to the CP/M BDOS function "get bit map of read-only
	  drives", which is meaningless under MS-DOS
SeeAlso: AH=18h,AH=1Eh,AH=20h,AX=4459h
--------D-211E-------------------------------
INT 21 - DOS 1+ - NULL FUNCTION FOR CP/M COMPATIBILITY
	AH = 1Eh
Return: AL = 00h
Note:	corresponds to the CP/M BDOS function "set file attributes" which was
	 meaningless under MS-DOS 1.x
SeeAlso: AH=18h,AH=1Dh,AH=20h
--------D-211F-------------------------------
INT 21 - DOS 1+ - GET DRIVE PARAMETER BLOCK FOR DEFAULT DRIVE
	AH = 1Fh
Return: AL = status
	    00h successful
		DS:BX -> Drive Parameter Block (DPB) (see #1045 for DOS 1.x,
			AH=32h for DOS 2+)
	    FFh invalid drive
Note:	this call was undocumented prior to the release of DOS 5.0; however,
	  only the DOS 4.0+ version of the DPB has been documented
SeeAlso: AH=32h,AX=7302h

Format of DOS 1.1 and MS-DOS 1.25 drive parameter block:
Offset	Size	Description	(Table 1045)
 00h	BYTE	sequential device ID
 01h	BYTE	logical drive number (0=A:)
 02h	WORD	bytes per sector
 04h	BYTE	highest sector number within a cluster
 05h	BYTE	shift count to convert clusters into sectors
 06h	WORD	starting sector number of first FAT
 08h	BYTE	number of copies of FAT
 09h	WORD	number of directory entries
 0Bh	WORD	number of first data sector
 0Dh	WORD	highest cluster number (number of data clusters + 1)
 0Fh	BYTE	sectors per FAT
 10h	WORD	starting sector of directory
 12h	WORD	address of allocation table
Note:	the DOS 1.0 table is the same except that the first and last fields
	  are missing; see INT 21/AH=32h for the DOS 2+ version
SeeAlso: #1083,#3766
--------D-2120-------------------------------
INT 21 - DOS 1+ - NULL FUNCTION FOR CP/M COMPATIBILITY
	AH = 20h
Return: AL = 00h
Note:	corresponds to the CP/M BDOS function "get/set default user
	  (sublibrary) number", which is meaningless under MS-DOS
SeeAlso: AH=18h,AH=1Dh,AH=1Eh,AX=4459h
--------v-212080-----------------------------
INT 21 - VIRUS - "New-Year" - INSTALLATION CHECK
	AX = 2080h
Return: AH = 00h if resident (normal DOS return would be AX = 2000h)
SeeAlso: INT 21/AX=18FFh"VIRUS",INT 21/AX=2C2Ch"VIRUS"
--------D-2121-------------------------------
INT 21 - DOS 1+ - READ RANDOM RECORD FROM FCB FILE
	AH = 21h
	DS:DX -> opened FCB (see #1034)
Return: AL = status
	    00h successful
	    01h end of file, no data read
	    02h segment wrap in DTA, no data read
	    03h end of file, partial record read
	Disk Tranfer Area filled with record read from file
Notes:	the record is read from the current file position as specified by the
	  random record and record size fields of the FCB
	the file position is not updated after reading the record
	if a partial record is read, it is zero-padded to the full size
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=14h,AH=22h,AH=27h,AH=3Fh"DOS"
--------D-2122-------------------------------
INT 21 - DOS 1+ - WRITE RANDOM RECORD TO FCB FILE
	AH = 22h
	DS:DX -> opened FCB (see #1034)
	Disk Transfer Area contains record to be written
Return: AL = status
	    00h successful
	    01h disk full
	    02h segment wrap in DTA
Notes:	the record is written to the current file position as specified by the
	  random record and record size fields of the FCB
	the file position is not updated after writing the record
	if the record is located beyond the end of the file, the file is
	  extended but the intervening data remains uninitialized
	if the record only partially fills a disk sector, it is copied to a
	  DOS disk buffer to be written out to disk at a later time
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=15h,AH=21h,AH=28h,AH=40h
--------D-2123-------------------------------
INT 21 - DOS 1+ - GET FILE SIZE FOR FCB
	AH = 23h
	DS:DX -> unopened FCB (see #1034), wildcards not allowed
Return: AL = status
	    00h successful (matching file found)
		FCB random record field filled with size in records, rounded up
		to next full record
	    FFh failed (no matching file found)
Notes:	not supported by MS Windows 3.0 DOSX.EXE DOS extender
	MS-DOS returns nonsense if the FCB record number field is set to a very
	  large positive number, and status FFh if negative; DR DOS returns the
	  correct file size in both cases
BUG:	APPEND for DOS 3.3+ corrupts DX if the file is not found
SeeAlso: AH=42h
--------D-2124-------------------------------
INT 21 - DOS 1+ - SET RANDOM RECORD NUMBER FOR FCB
	AH = 24h
	DS:DX -> opened FCB (see #1034)
Notes:	computes the random record number corresponding to the current record
	  number and record size, then stores the result in the FCB
	normally used when switching from sequential to random access
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=21h,AH=27h,AH=42h
--------D-2125-------------------------------
INT 21 - DOS 1+ - SET INTERRUPT VECTOR
	AH = 25h
	AL = interrupt number
	DS:DX -> new interrupt handler
Notes:	this function is preferred over direct modification of the interrupt
	  vector table
	some DOS extenders place an API on this function, as it is not
	  directly meaningful in protected mode
	under DR DOS 5.0+, this function does not use any of the DOS-internal
	  stacks and may thus be called at any time
	Novell NetWare (except the new DOS Requester) monitors the offset of
	  any INT 24 set, and if equal to the value at startup, substitutes
	  its own handler to allow handling of network errors; this introduces
	  the potential bug that any program whose INT 24 handler offset
	  happens to be the same as COMMAND.COM's will not have its INT 24
	  handler installed
SeeAlso: AX=2501h,AH=35h
--------E-212501-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - RESET DOS EXTENDER DATA STRUCTURES
	AX = 2501h
	SS = application's original SS or DS (FlashTek X-32VM)
Return: CF clear if successful
	CF set on error
	    caller is operating on X-32 stack (FlashTek X-32VM)
Notes:	Phar Lap uses INT 21/AH=25h as the entry point for all 386/DOS-Extender
	  system calls.	 Only available when directly using 386/DOS-Extender or
	  a compatible DOS extender, or when using a product that was created
	  using 386-DOS/Extender or a compatible
	this function is also supported by FlashTek X-32VM
SeeAlso: AH=30h"Phar Lap"
--------E-212502-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET PROTECTED-MODE INTERRUPT VECTOR
	AX = 2502h
	CL = interrupt number
Return: CF clear
	ES:EBX = CS:EIP of protected-mode interrupt handler
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2503h,AX=2504h,INT 31/AX=0204h
--------E-212503-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET REAL-MODE INTERRUPT VECTOR
	AX = 2503h
	CL = interrupt number
Return: CF clear
	EBX = CS:IP of real-mode interrupt handler
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2502h,AX=2504h,AH=35h,INT 31/AX=0200h
--------E-212504-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - SET PROTECTED-MODE INTERRUPT VECTOR
	AX = 2504h
	CL = interrupt number
	DS:EDX = CS:EIP of protected-mode interrupt handler
Return: CF clear
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2502h,AX=2505h,INT 31/AX=0205h
--------E-212505-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - SET REAL-MODE INTERRUPT VECTOR
	AX = 2505h
	CL = interrupt number
	EBX = CS:IP of real-mode interrupt handler
Return: CF clear
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2503h,AX=2504h,INT 31/AX=0201h
--------E-212506-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - SET INT TO ALWAYS GAIN CNTRL IN PR. MODE
	AX = 2506h
	CL = interrupt number
	DS:EDX = CS:EIP of protected-mode interrupt handler
Return: CF clear
Notes:	this function modifies both the real-mode low-memory interrupt
	  vector table and the protected-mode Interrupt Descriptor Table (IDT)
	interrupts occurring in real mode are resignaled in protected mode
	this function is also supported by FlashTek X-32VM
--------E-212507-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - SET REAL- & PROTECTED-MODE INT VECTORS
	AX = 2507h
	CL = interrupt number
	DS:EDX = CS:EIP of protected-mode interrupt handler
	EBX = CS:IP of real-mode interrupt handler
Return: CF clear
Notes:	interrupts are disabled until both vectors have been modified
	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2504h,AX=2505h
--------E-212508-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET SEGMENT LINEAR BASE ADDRESS
	AX = 2508h
	BX = segment selector
Return: CF clear if successful
	    ECX = linear base address of segment
	CF set if invalid segment selector
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2509h
--------E-212509-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - CONVERT LINEAR TO PHYSICAL ADDRESS
	AX = 2509h
	EBX = linear address to convert
Return: CF clear if successful
	    ECX = physical address (carry flag clear)
	CF set if linear address not mapped in page tables
SeeAlso: AX=2508h
--------E-212509-----------------------------
INT 21 P - FlashTek X-32VM - GET SYSTEM SEGMENTS AND SELECTORS
	AX = 2509h
Return: CF clear
	EAX high word = default DS
	AX = alias for 16-bit data segment
	BX = real mode code segment
	EDX high word = selector covering full 4GB address space
	DX = default SS
	ESI high word = PSP selector
	SI = environment selector
--------E-21250A-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - MAP PHYSICAL MEMORY AT END OF SEGMENT
	AX = 250Ah
	ES = segment selector in the Local Descriptor Table (LDT) of segment
	     to modify
	EBX = physical base address of memory to map (multiple of 4K)
	ECX = number of physical 4K pages to map
Return: CF clear if successful
	    EAX = 32-bit offset in segment of mapped memory
	CF set on error
	    EAX = error code
		08h insufficient memory to create page tables
		09h invalid segment selector
SeeAlso: INT 31/AX=0800h
--------E-21250C-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET HARDWARE INTERRUPT VECTORS
	AX = 250Ch
Return: CF clear
	AL = base interrupt vector for IRQ0-IRQ7
	AH = base interrupt vector for IRQ8-IRQ15
	BL = interrupt vector for BIOS print screen function (Phar Lap only)
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: INT 31/AX=0400h,INT 67/AX=DE0Ah
--------E-21250D-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET REAL-MODE LINK INFORMATION
	AX = 250Dh
Return: CF clear
	EAX = CS:IP of real-mode callback procedure (see #1046) that will
		  call through from real mode to a protected-mode routine
	EBX = 32-bit real-mode address of intermode call data buffer
	ECX = size in bytes of intermode call data buffer
	ES:EDX = protected-mode address of intermode call data buffer
Notes:	this function is also supported by FlashTek X-32VM
	X-32VM guarantees the intermode buffer to be at least 4 KB
SeeAlso: AX=250Eh

(Table 1046)
Call Phar Lap real-mode callback with:
	STACK:	DWORD	offset to protected-mode code
		WORD	placeholder for protected-mode CS
		DWORD	pointer to selector structure (see #1047)
			or 0000h:0000h for defaults
		var	parameters for protected-mode procedure
Return: via FAR return

Format of Phar Lap selector structure:
Offset	Size	Description	(Table 1047)
 00h	WORD	protected-mode GS selector
 02h	WORD	protected-mode FS selector
 04h	WORD	protected-mode ES selector
 06h	WORD	protected-mode DS selector
--------E-21250E-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - CALL REAL-MODE PROCEDURE
	AX = 250Eh
	EBX = CS:IP of real-mode procedure to call
	ECX = number of two-byte words to copy from protected-mode stack
	      to real-mode stack
Return: CF clear if successful
	    all segment registers unchanged
	    all general registers contain values set by real-mode procedure
	    all other flags set as they were left by real-mode procedure
	    stack unchanged
	CF set on error
	    EAX = error code
		01h not enough real-mode stack space
Note:	this function is also supported by FlashTek X-32VM; under X-32VM, the
	  call will fail if ECX > 0000003Fh
SeeAlso: AX=250Dh,AX=2510h,AH=E1h"OS/286",INT 31/AX=0301h
--------E-21250F-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - CONVERT PROTECTED-MODE ADDRESS TO MS-DOS
	AX = 250Fh
	ES:EBX = 48-bit protected-mode address to convert
	ECX = 00000000h or length of data in bytes
Return: CF clear if successful (address < 1MB and contiguous)
	    ECX = 32-bit real-mode MS-DOS address
	CF set on error (address >= 1MB or not contiguous)
	    ECX = linear address
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2510h
--------E-212510-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - CALL REAL-MODE PROCEDURE, REGISTERS
	AX = 2510h
	EBX = CS:IP of real-mode procedure to call
	ECX = number of two-byte words to copy to protected-mode stack to
	      real-mode stack
	DS:EDX -> pointer to parameter block (see #1048)
Return: CF clear if successful
	    all segment registers unchanged,
	    EDX unchanged
	    all other general registers contain values set by real-mode proc
	    all other flags are set as they were left by real-mode procedure
	    real-mode register values are returned in the parameter block
	CF set on error
	    EAX = error code
		01h not enough real-mode stack space
Note:	unlike most of the preceding 25xxh functions, this one is not
	  supported by FlashTek X-32VM
SeeAlso: AX=250Eh,AX=250Fh

Format of Phar Lap real-mode call parameter block:
Offset	Size	Description	(Table 1048)
 00h	WORD	real-mode DS value
 02h	WORD	real-mode ES value
 04h	WORD	real-mode FS value
 06h	WORD	real-mode GS value
 08h	DWORD	real-mode EAX value
 0Ch	DWORD	real-mode EBX value
 10h	DWORD	real-mode ECX value
 14h	DWORD	real-mode EDX value
--------E-212511-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - ISSUE REAL-MODE INTERRUPT
	AX = 2511h
	DS:EDX -> parameter block (see #1049)
Return: all segment registers unchanged
	EDX unchanged
	all other registers contain values set by the real-mode int handler
	the flags are set as they were left by the real-mode interrupt handler
	real-mode register values are returned in the parameter block
Note:	this function is also supported by FlashTek X-32VM
SeeAlso: AX=2503h,AX=2505h,AX=250Eh,AH=E3h"OS/286",INT 31/AX=0300h

Format of Phar Lap real-mode interrupt parameter block:
Offset	Size	Description	(Table 1049)
 00h	WORD	interrupt number
 02h	WORD	real-mode DS value
 04h	WORD	real-mode ES value
 06h	WORD	real-mode FS value
 08h	WORD	real-mode GS value
 0Ah	DWORD	real-mode EAX value
 0Eh	DWORD	real-mode EDX value
Note: all other real-mode values set from protected-mode registers
--------E-212512-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - LOAD PROGRAM FOR DEBUGGING
	AX = 2512h
	DS:EDX -> pointer to ASCIZ program name
	ES:EBX -> pointer to parameter block (see #1051)
	ECX = size in bytes of LDT buffer
Return: CF clear if successful
	    EAX = number of segment descriptors in LDT
	CF set on error
	    EAX = error code (see #1050)
SeeAlso: AX=2517h

(Table 1050)
Values for Phar Lap error code:
 02h	file not found or path invalid
 05h	access denied
 08h	insufficient memory
 0Ah	environment invalid
 0Bh	invalid file format
 80h	LDT too small

Format of Phar Lap program load parameter block:
Offset	Size	Description	(Table 1051)
Input:
 00h	DWORD	32-bit offset of environment string
 04h	WORD	segment of environment string
 06h	DWORD	32-bit offset of command-tail string
 0Ah	WORD	segment of command-tail string
 0Ch	DWORD	32-bit offset of LDT buffer (size in ECX)
 10h	WORD	segment of LDT buffer
Output:
 12h	WORD	real-mode paragraph address of PSP (see also AH=26h)
 14h	WORD	real/protected mode flag
		0000h  real mode
		0001h  protected mode
 16h	DWORD	initial EIP value
 1Ah	WORD	initial CS value
 1Ch	DWORD	initial ESP value
 20h	WORD	initial SS value
 22h	WORD	initial DS value
 24h	WORD	initial ES value
 26h	WORD	initial FS value
 28h	WORD	initial GS value
--------E-212513-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - ALIAS SEGMENT DESCRIPTOR
	AX = 2513h
	BX = segment selector of descriptor in GDT or LDT
	CL = access-rights byte for alias descriptor
	CH = use-type bit (USE16 or USE32) for alias descriptor
Return: CF clear if successful
	    AX = segment selector for created alias
	CF set on error
	    EAX = error code
		08h insufficient memory (can't grow LDT)
		09h invalid segment selector in BX
--------E-212514-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - CHANGE SEGMENT ATTRIBUTES
	AX = 2514h
	BX = segment selector of descriptor in GDT or LDT
	CL = new access-rights byte
	CH = new use-type bit (USE16 or USE32)
Return: CF clear if successful
	CF set on error
	    EAX = error code
		09h invalid selector in BX
SeeAlso: AX=2515h,INT 31/AX=0009h
--------E-212515-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET SEGMENT ATTRIBUTES
	AX = 2515h
	BX = segment selector of descriptor in GDT or LDT
Return: CF clear if successful
	    CL = access-rights byte for segment
	    CH = use-type bit (USE16 or USE32)
	ECX<16-31> destroyed
	CF set on error
	    EAX = error code
		09h invalid segment selector in BX
SeeAlso: AX=2514h
--------E-212516-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v2.2+ - FREE ALL MEMORY OWNED BY LDT
	AX = 2516h
Return: CF clear
Note:	this function must be called from Ring 0 or the CS descriptor is freed
--------E-212517-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v2.1c+ - GET INFO ON DOS DATA BUFFER
	AX = 2517h
Return: CF clear
	ES:EBX -> data buffer (protected mode address)
	ECX -> data buffer (real mode address)
	EDX = size of data buffer in bytes
Note:	the data buffer's address changes after calls to AX=2512h and AX=252Ah
SeeAlso: AX=2512h,AX=252Ah,AX=2530h
--------E-212518-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender 2.1c+ - SPECIFY HANDLER FOR MOVED SEGMENTS
	AX = 2518h
	ES:EBX -> function to call when a segment is moved
Return: CF clear
	ES:EBX -> previous handler
--------E-212519-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - GET ADDITIONAL MEMORY ERROR INFO
	AX = 2519h
Return: CF clear
	EAX = error code
	    0000h  no error
	    0001h  out of physical memory
	    0002h  out of swap space (unable to grow swap file)
	    0003h  out of LDT entries and unable to grow LDT
	    0004h  unable to change extended memory allocation mark
	    FFFFFFFFh	paging disabled
Note:	VMM is the Virtual Memory Manager option
--------E-21251A-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - LOCK PAGES IN MEMORY
	AX = 251Ah
	EDX = number of 4k pages to lock
	if BL = 00h
	    ECX = linear address of first page to lock
	if BL = 01h
	    ES:ECX -> pointer to first page to lock
Return: CF clear if successful
	CF set on error
	    EAX = error code
		08h insufficient memory
		09h invalid address range
SeeAlso: AX=251Bh,AX=EB06h,INT 31/AX=0600h
--------E-21251B-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - UNLOCK PAGES
	AX = 251Bh
	EDX = number of pages to unlock
	if BL = 00h
	    ECX = linear address of first page to unlock
	if BL = 01h
	    ES:ECX -> pointer to first page to unlock
Return: CF clear if successful
	CF set on error
	    EAX = error code
		09h invalid address range
SeeAlso: AX=251Ah,AX=EB07h,INT 31/AX=0601h
--------E-21251C-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM v2.1c+ - FREE PHYSICAL MEMORY PAGES
	AX = 251Ch
	BH = preservation flag (00h preserve contents, 01h discard contents)
	EDX = number of pages to free
	BL = address type
	    00h linear address
		ECX = linear address of first page to be freed
	    01h pointer
		ES:ECX -> first page to be freed
Return: CF clear if successful
	CF set on error
	    EAX = error code
		08h memory error, swap space full, no VMM or DPMI
		09h invalid address
--------E-21251D-----------------------------
INT 21 OP - Phar Lap 386/DOS-Extender VMM v2.1c - READ PAGE-TABLE ENTRY
	AX = 251Dh
	BL = address type
	    00h linear address
		ECX = linear address of page table entry to read
	    01h pointer
		ES:ECX -> page table entry to read
Return: CF clear if successful
	    EAX = contents of page table entry
	CF set on error
	    EAX = error code
		09h invalid address or NOPAGE option set
		78h invalid under DPMI
Note:	this function is obsolete; use AX=252Bh/BH=09h instead
SeeAlso: AX=251Eh,AX=252Bh/BH=09h,AX=EB00h,INT 31/AX=0506h
--------E-21251E-----------------------------
INT 21 OP - Phar Lap 386/DOS-Extender VMM v2.1c - WRITE PAGE-TABLE ENTRY
	AX = 251Eh
	BL = address type
	    00h linear address
		ECX = linear address of page table entry to read
	    01h pointer
		ES:ECX -> page table entry to read
	EDX = new value for page table entry
Return: CF clear if successful
	CF set on error
	    EAX = error code
		09h invalid address or NOPAGE option set
		82h not compatible with DPMI
Note:	this call is obsolete; use AX=252Bh/BH=0Ah instead
SeeAlso: AX=251Dh,AX=252Bh/BH=0Ah,INT 31/AX=0507h
--------E-21251F-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - EXHANGE TWO PAGE-TABLE ENTRIES
	AX = 251Fh
	BL = address type
	    00h linear address
		ECX = linear address of first page table entry
		EDX = linear address of second page table entry
	    01h pointer
		ES:ECX -> first page table entry
		ES:EDX -> second page table entry
Return: CF clear if successful
	CF set on error
	    EAX = error code
		09h invalid address or NOPAGE option set
		82h not compatible with DPMI
SeeAlso: AX=251Dh,AX=251Eh
--------E-212520-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - GET MEMORY STATISTICS
	AX = 2520h
	DS:EDX -> pointer to buffer at least 100 bytes in size (see #1052)
	BL = 0 (don't reset VM stats), 1 (reset VM stats)
Return: carry flag clear

Format of Phar Lap VM statistics buffer:
Offset	Size	Description	(Table 1052)
 00h	DWORD	VM status
		0001h VM subsystem is present
		0000h VM not present
 04h	DWORD	"nconvpg" number of conventional memory pages available
 08h	DWORD	"nbimpg" number of Compaq built-in memory pages available
 0Ch	DWORD	"nextpg" total number of extended memory pages
 10h	DWORD	"extlim" extender memory pages limit
 14h	DWORD	"aphyspg" number of physical memory pages allocated to appl
 18h	DWORD	"alockpg" number of locked pages owned by application
 1Ch	DWORD	"sysphyspg" number physical memory pages allocated to system
 20h	DWORD	"nfreepg" number of free physical pages; approx if EMS VCPI
 24h	DWORD	linear address of beginning of application address space
 28h	DWORD	linear address of end of application address space
 2Ch	DWORD	number of seconds since last time VM stats were reset
 30h	DWORD	number of page faults since last time
 34h	DWORD	number of pages written to swap file since last time
 38h	DWORD	number of reclaimed pages (page faults on swapped pages)
 3Ch	DWORD	number of virtual pages allocated to the application
 40h	DWORD	size in pages of swap file
 44h	DWORD	number of system pages allocated with EMS calls
 48h	DWORD	minimum number of conventional memory pages
 4Ch	DWORD	maximum size in pages to which swap file can be increased
 50h	DWORD	"vmflags"
		bit 0 = 1 if page fault in progress
---v4.0+ ---
 54h	DWORD	number of physical pages guaranteed to be free
 58h	DWORD	number of free physical pages currently available
 5Ch	DWORD	size in pages of largest free block of memory (including disk
		  swap space)
 60h	DWORD	reserved
--------E-212521-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - LIMIT PROGRAM'S EXTENDED MEM USAGE
	AX = 2521h
	EBX = max 4k pages of physical extended memory which program may use
Return: CF clear if successful
	   EBX = maximum limit in pages
	   ECX = minimum limit in pages
	CF set on error
	    EAX = error code
		08h insufficient memory or -nopage switch used
SeeAlso: AX=2522h
--------E-212522-----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v2.2+ - SPECIFY ALTERNATE PAGE-FAULT HANDLR
	AX = 2522h
	ES:EBX -> alternate handler for page faults
Return: CF clear
	ES:EBX -> previous page-fault handler
SeeAlso: AX=2523h
--------E-212523-----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v2.2+ - SPECIFY OUT-OF-SWAP-SPACE HANDLER
	AX = 2523h
	???
Return: ???
Note:	this function takes a DWORD pointer and a DWORD pointer to a DWORD
	  pointer as arguments
SeeAlso: AX=2522h
--------E-212524-----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v2.2+ - INSTALL PAGE-REPLACEMENT HANDLERS
	AX = 2524h
	???
Return: ???
Note:	this function takes three DWORD pointers and three DWORD pointers to
	  DWORD pointers as arguments
--------E-212525-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - LIMIT PROGRAM'S CONVENT'L MEM USAGE
	AX = 2525h
	EBX = limit in 4k pages of physical conventional memory which program
	      may use
Return: CF clear if successful
	    EBX = maximum limit in pages
	    ECX = minimum limit in pages
	CF set on error
	    EAX = error code
		08h insufficient memory or -nopage switch used
SeeAlso: AX=2521h
--------E-212526-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET CONFIGURATION INFORMATION
	AX = 2526h
	???
Return: ???
Notes:	details are not yet available
	this function takes a pointer to the configuration buffer (see #1053)
	  and a poitner to a BYTE as arguments

Format of Phar Lap configuration buffer:
Offset	Size	Description	(Table 1053)
 00h	DWORD	flags 1 (see #1054)
 04h	DWORD	flags 2 (unused through v5.0)
 08h	DWORD	flags 3 (unused through v5.0)
 0Ch	DWORD	386|DOS-Extender major version
 10h	DWORD	386|DOS-Extender minor version
 14h	DWORD	first letter of text after minor version number in version str
 18h	DWORD	beta flag (00h normal release, 01h beta release)
 1Ch	DWORD	processor (3 = 386, 4 = 486)
 20h	DWORD	coprocessor (4 = none, 6 = 287, 7 = 387/486)
 24h	DWORD	Weitek coprocessor flag (0 = none, 1 = present)
 28h	DWORD	machine type (0 = IBM PC compatible, 1 = NEC 9800 series)
 2Ch	DWORD	machine class
		IBM: bus type (0=ISA, 1=MCA, 2=XT, 3=EISA)
		NEC: 0=normal mode, 1=high-res mode
 30h	DWORD	VCPI flag (0 = none, 1 = present)
 34h	DWORD	-WEITEK/-1167 switch (0 = AUTO, 1 = ON, 2 = OFF)
 38h	DWORD	-MINREAL setting
 3Ch	DWORD	-MAXREAL setting
 40h	DWORD	-MINIBUF setting
 44h	DWORD	-MAXIBUF setting
 48h	DWORD	size in bytes of DOS call data buffer
 4Ch	DWORD	number of interrupt stacks (-NISTACK)
 50h	DWORD	interrupt stack size (-ISTKSIZE)
 54h	DWORD	-REALBREAK setting
 58h	DWORD	-CALLBUFS
 5Ch	DWORD	-HWIVEC
 60h	DWORD	-PRIVEC
 64h	DWORD	-INTMAP
 68h	DWORD	-PRIMAP
 6Ch	DWORD	VCPI: master 8259 interrupt vector base (IRQ0 mapping)
 70h	DWORD	VCPI: slave 8259 interrupt vector base (IRQ8 mapping)
 74h	DWORD	BIOS print screen interrupt vector (0 if NEC)
 78h	DWORD	-EXTLOW setting
 7Ch	DWORD	-EXTHIGH setting
 80h	DWORD	lowest physical extended-memory address allocatable
 84h	DWORD	highest physical extended-memory address allocatable + 1
 88h	DWORD	special memory's physical base address (00000000h if none)
 8Ch	DWORD	special memory size in bytes (00000000h if none)
 90h	DWORD	-MAXVCPIMEM setting
 94h	DWORD	-VSCAN
 98h	DWORD	-SWAPCHK (0 = OFF, 1 = ON, 2 = FORCE, 3 = MAX)
 9Ch	DWORD	-CODESIZE setting
 A0h	DWORD	minimum swap file size (-MINSWFSIZE)
 A4h	DWORD	maximum swap fiel size (-MAXSWFSIZE)
 A8h	DWORD	page replacement policy (0 = LFU, 1 = NUR)
 ACh	DWORD	number of GDT entries (-NGDTENT)
 B0h	DWORD	number of LDT entries (-NLDTENT)
 B4h	DWORD	program's privilege level (0-3)
---386|DOS-Extender v3.0+ ---
 B8h	DWORD	-LOCKSTACK setting
 BCh	DWORD	-MAXEXTMEM
 C0h	DWORD	-MAXXMSMEM
 C4h	DWORD	-MAXPGMMEM
 C8h	DWORD	-DATATHRESHOLD
 CCh	DWORD	virtual memory manager flag (0 = not present, 1 = present)
 D0h	DWORD	Cyrix coprocessor flag (0 = no Cyrix EMC387, 1 = present)
 D4h	DWORD	-CYRIX setting (0 = AUTO, 1 = ON, 2 = OFF)
 D8h	DWORD	DPMI flag (0 = not present, 1 = present)
 DCh	DWORD	DPMI major version
 E0h	DWORD	DPMI minor version
 E4h	DWORD	DPMI capabilities flags (see #1055)
 E8h	DWORD	VCPI major version
 ECh	DWORD	VCPI minor version
 F0h	WORD	VCPI: IRQ0-7 physical base interrupt vector
 F2h	WORD	VCPI: IRQ8-15 physical base interrupt vector
 F4h	DWORD	XMS flag (0 = none, 1 = present)
 F8h	DWORD	XMS major version
 FCh	DWORD	XMS minor version
100h	WORD	application's CS selector
102h	WORD	application's DS selector
104h	WORD	application's PSP selector
106h	WORD	application's environment selector
108h	WORD	selector mapping entire first megabyte
10Ah	WORD	selector mapping text video memory
10Ch	WORD	selector mapping video memory (text for IBM, graphics for NEC)
10Eh	WORD	selector mapping Weitek address space, 0000h if not present
110h	WORD	selector mapping Cyrix EMC387 address space, 0000h if none
112h	WORD	reserved (0)
114h	DWORD	real-mode FAR entry point to call to switch to protected mode
		  with no saved context
118h	DWORD	size of LDT in bytes
---386|DOS-Extender v5.0+ ---
11Ch	DWORD	Windows flag (0 = not present, 1 = Windows present)
120h	DWORD	Windows major version
124h	DWORD	Windows minor version
128h	DWORD	Windows mode (0 = real/standard, 1 = enhanced)
12Ch	DWORD	OS/2 flag (0 = not present, 1 = OS/2 present)
130h	DWORD	OS/2 major version
134h	DWORD	OS/2 minor version
138h 50 DWORDs	reserved (0)

Bitfields for flags 1:
Bit(s)	Description	(Table 1054)
 0	-NOPAGE specified
 1	-A20 specified
 2	-VDISK specified
 3	-XT specified
 4	-AT specified
 5	-MCA specified
 6	-EISA specified
 7	-NORMRES specified (NEC only)
 8	-HIGHRES specified (NEC only)
 9	set if -SWFGROW1ST, clear if -NOSWFGROW1ST
 10	-NOVM specified
 11	-SAVEREGS specified
 12	unused (clear)
 13	-NOVCPI specified
 14	-NOMUL specified
 15	-NOBMCHK specified
 16	-NOSPCLMEM or -NOBIM
 17	-NOPGEXP specified
 18	-SWAPDEFDISK specified
---v3.0+ ---
 19	-SAVEINTS specified
 20	-NOLOAD specified
 21	-PAGELOG specified
 22	-OPENDENY specified
 23	-ERRATA17 specified
---v4.1+ ---
 24	-NESTDPMI specified
 25	-NONESTDPMI specified
 26	-NODPMI specified
 27	-NOPCDWEITEK specified
---v4.2+ ---
 28	-WININT21 specified

Bitfields for DPMI capabilities flags:
Bit(s)	Description	(Table 1055)
 0	paging supported
 1	physical device mapping
 2	conventional memory mapping
 3	exceptions restartable
--------E-212527-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - EN/DISABLE STATE SAVE ON INTERRUPTS
	AX = 2527h
	EBX = new status (00h disabled, 01h enabled)
Return: CF clear
	EBX = previous state save flag
SeeAlso: AX=2528h
--------E-212528-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - READ REGISTERS AFTER CTRL-C INT
	AX = 2528h
	DS:EBX -> buffer for registers (see #1056)
Return: CF clear if successful
	    DS:EBX buffer filled
	CF set on error
	    EAX = error code
		83h interrupt state save not enabled
		84h no active interrupt
SeeAlso: AX=2527h

Format of Phar Lap buffer for registers:
Offset	Size	Description	(Table 1056)
 00h  8 BYTEs	unused
 08h  4	DWORDs	EAX,EBX,ECX,EDX
 18h  4 DWORDs	ESI,EDI,EBP,ESP
 28h  6 WORDs	CS,DS,SS,ES,FS,GS
 34h	DWORD	EIP
 38h	DWORD	EFLAGS
--------E-212529-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - LOAD FLAT MODEL .EXP or .REX FILE
	AX = 2529h
	???
Return: ES:EBX -> parameter block (see #1057)
	???
Note:	details not available at this time
SeeAlso: AX=252Ah

Format of Phar Lap program load parameter block:
Offset	Size	Description	(Table 1057)
 00h	DWORD	initial EIP
 04h	WORD	initial CS
 06h	DWORD	initial ESP
 0Ah	WORD	initial SS
 0Ch  4 WORDs	initial DS, ES, FS, GS
 14h	DWORD	minimum size in bytes of program segment
 18h	DWORD	bytes of additional memory allocated
 1Ch	DWORD	flags
		bit 0: child linked with -UNPRIVILEGED
		---v6.0+ ---
		bit 1: child is PE file instead of .EXP
		bit 2: loaded file is a DLL
		bits 3-31 reserved
---v6.0+ ---
 20h	DWORD	module handles (PE files only)
 24h  7 DWORDs	reserved (0)
--------E-21252A-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM - NEW LOAD PROGRAM FOR DEBUG
	AX = 252Ah
	DS:EDX -> ASCIZ program name
	ES:EBX -> parameter block (see #1051)
	ECX = size of LDT buffer in bytes
	ESI = bit flags
	    bit 0: allow demand paging rather than loading entire program
	    bit 1: demand page from swap file rather than from .EXP
Return: CF clear if successful
	    EAX = VMM handle or FFFFFFFFh if none
	    ECX = number of descriptors in LDT buffer
	CF set on error
	    EAX = error code
		02h file error
		    EBX = file error code (see #1058)
		    ECX = DOS error code if EBX=1,2,3, or 8
		08h insufficient memory
		    EBX = memory error code (see #1059)
		80h LDT buffer too small
		87h called twice without intervening call to AX=2531h
SeeAlso: AX=2512h,AX=2517h,AX=2529h,AX=2531h

(Table 1058)
Values for Phar Lap file error code:
 01h	DOS open error
 02h	DOS seek error
 03h	DOS read error
 04h	not an .EXP or .REX file
 05h	invalid file format
 06h	-OFFSET is not a multiple of 64K
 07h	-NOPAGE incompatible with -REALBREAK/-OFFSET
 08h	DOS error loading .EXE file

(Table 1059)
Values for Phar Lap memory error code:
 01h	out of physical memory
 02h	out of swap space
 04h	unable to change extended memory allocation
 05h	-MAXPGMMEM exceeded
 06h	insufficient low memory to REALBREAK value
 07h	insufficient low memory for PSP and environment
--------E-21252BBH00-------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender - CREATE UNMAPPED PAGES
	AX = 252Bh
	BH = 00h
	???
Return: ???
--------E-21252BBH01-------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender - CREATE ALLOCATED PAGES
	AX = 252Bh
	BH = 01h
	???
Return: ???
--------E-21252BBH02-------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender - CREATE PHYSICAL DEVICE PAGES
	AX = 252Bh
	BH = 02h
	???
Return: ???
--------E-21252BBH03-------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender - MAP DATA FILE
	AX = 252Bh
	BH = 03h
	???
Return: ???
SeeAlso: AX=252Bh/BH=0Bh
--------E-21252BBH04-------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender - GET PAGE TYPES
	AX = 252Bh
	BH = 04h
	???
Return: ???
Note:	returns one word per page
SeeAlso: #1060

Bitfields for Phar Lap page information:
Bit(s)	Description	(Table 1060)
 7	mapped to read/write data file
 6	mapped to read-only data file
 5	swapped to disk
 4	locked
 3-0	page type
	0 unmapped
	1 allocated
	2 physical device page
--------E-21252B-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - VIRTUAL MEMORY MANAGEMENT - PAGE LOCKING
	AX = 252Bh
	BH = function
	    05h lock pages
	    06h unlock pages
	BL = address type
	    00h linear address
		ECX = linear start address of memory region
	    01h segmented address
		ES:ECX -> start of memory region
	EDX = size of memory region in bytes
Return: CF clear if successful
	CF set on error
Note:	this function is also supported by FlashTek X-32VM; if X-32 is not
	  using virtual memory, this function always succeeds
--------E-21252B-----------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender - FREE PHYSICAL PAGES
	AX = 252Bh
	BH = function (07h,08h)
	???
Return: ???
--------E-21252BBH09-------------------------
INT 21 P - Phar Lap 386/DOS-Extender v4.1 - GET PAGETABLE ENTRY/PAGE TABLE INFO
	AX = 252Bh
	BH = 09h
	BL = subfunction
	    00h get page table entry by linear address
		ECX = linear address for which to get page table entry
	    01h get page table entry by logical address
		ES:ECX = address for which to get page table entry
Return: CF clear if successful
	    EAX = page table entry
	    EBX = additional page table information
	CF set on error
	    EAX = error code
		0009h invalid address
		0082h running under DPMI
SeeAlso: AX=251Dh,AX=252Bh/BH=0Ah
--------E-21252BBH0A-------------------------
INT 21 P - Phar Lap 386/DOS-Extender v4.1 - SET PAGETABLE ENTRY/PAGE TABLE INFO
	AX = 252Bh
	BH = 0Ah
	BL = subfunction
	    00h set page table entry for linear address
		ECX = linear address for which to get page table entry
	    01h set page table entry for logical address
		ES:ECX = address for which to get page table entry
	ESI = page table entry
	EDI = additional page table information
Return: CF clear if successful
	CF set on error
	    EAX = error code
		0009h invalid address
		0082h running under DPMI
SeeAlso: AX=252Bh/BH=09h
--------E-21252BBH0B-------------------------
INT 21 P - Phar Lap 386/DOS-Extender v4.1+ - MAP DATA FILE AT FILE OFFSET
	AX = 252Bh
	BH = 0Bh
	BL = subfunction
	    00h by linear address
		ECX = linear address at which to map data file
	    01h by logical address
		ES:ECX = logical address at which to map data file
	EDX = number of bytes to map
	DS:ESI -> mapping structure (see #1061)
	DS:EDI -> ASCIZ filename
Return: CF clear if successful
	CF set on error
	    EAX = error code
		0002h file error
		    ECX = phase (01h opening file, 02h seeking, 03h reading)
		    EDX = error code returned by DOS
		0009h invalid address
		0081h invalid parameters or 386|VMM not present
		0086h all 386|VMM file handles already in use
SeeAlso: AX=252Bh/BH=03h,AX=252Bh/BH=09h

Format of Phar Lap mapping structure:
Offset	Size	Description	(Table 1061)
 00h	DWORD	starting file offset to be mapped
 04h	DWORD	DOS file access and sharing modes (see #1091 at INT 21/AH=3Dh)
--------E-21252C-----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v3.0 - ADD UNMAPPED PAGES AT END OF SEGMENT
	AX = 252Ch
	BX = segment selector
	ECX = number of 4K pages to add
Return: CF clear if successful
	    EAX = offset in segment of beginning of unmapped pages
	CF set on error
	    EAX = error code
		08h insufficent memory
		09h invalid selector
		82h not supported by current DPMI
--------E-21252D-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM v2.3+ - CLOSE VMM FILE HANDLE
	AX = 252Dh
	EBX = VMM file handle
Return: CF clear if successful
	CF set on error
	    EAX = error code (81h invalid VMM handle)
--------E-21252E-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM v2.3+ - GET/SET VMM PARAMETERS
	AX = 252Eh
	CL = direction (00h get parameters, 01h set parameters)
	DS:EBX -> parameter buffer (see #1062)
Return: CF clear if successful
	CF set on error
	    EAX = error code (81h bad parameter value)

Format of Phar Lap VMM parameter buffer:
Offset	Size	Description	(Table 1062)
 00h	DWORD	flags
		bit 0: page fault logging enabled
		---v5.0+ ---
		bit 1: swap extender to disk during DOS EXEC call
		bit 2: don't zero allocated memory
 04h	DWORD	scan period for page aging, in milliseconds
 08h	DWORD	maximum size (in bytes) to check on each page scan
 0Ch 52 BYTEs	unused
--------E-21252F-----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v3.0 - WRITE RECORD TO VMM PAGE LOG FILE
	AX = 252Fh
	DS:EBX -> data to be written
	CX = size of data in bytes
Return: CF clear if successful
	CF set on error
	    EAX = error code (85h no page log file or not 386/VMM)
--------E-212530-----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v2.3+ - SET SIZE OF BUFFER FOR DOS CALLS
	AX = 2530h
	ECX = size of data buffer in bytes (1024 to 65536)
Return: CF clear if successful
	CF set on error
	    EAX = error code
		08h insufficient low memory
		81h invalid size
SeeAlso: AX=2517h
--------E-212531-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM v3.0 - READ/WRITE LDT DESCRIPTOR
	AX = 2531h
	BX = segment selector
	ECX = direction (00h read, 01h write)
	DS:EDX -> 8-byte buffer for descriptor contents
Return: CF clear if successful
	CF set on error
	    EAX = error code
		81h invalid selector
		82h DPMI running, or not a code or data segment
--------E-212532-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - GET EXCEPTION HANDLER VECTOR
	AX = 2532h
	CL = exception number (00h-0Fh)
Return: CF clear if successful
	    ES:EBX = CS:EIP of current exception handler
	CF set on error (CL > 0Fh)
Notes:	this call is also supported by the FlashTek X-32VM extender
	this function is incompatible with 386|VMM; use AX=2522h instead
SeeAlso: AX=2522h,AX=2533h
--------E-212533-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - SET EXCEPTION HANDLER VECTOR
	AX = 2533h
	CL = exception number (00h-0Fh)
	DS:EDX = CS:EIP of new exception handler
Return: CF clear if successful
	CF set on error (CL > 0Fh)
Notes:	this call is also supported by the FlashTek X-32VM extender
	this function is incompatible with 386|VMM; use AX=2522h instead
SeeAlso: AX=2522h,AX=2532h
--------E-212534-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v3.0+ - GET INTERRUPT FLAG
	AX = 2534h
Return: CF clear
	EAX = interrupt state (00h disabled, 01h enabled)
--------E-212535-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v3.0+ - READ/WRITE SYSTEM REGISTERS
	AX = 2535h
	EBX = direction (00h read registers, 01h write)
	DS:EDX -> system register record (see #1063)
Return: CF clear
Note:	this call is only available under MS Windows if PHARLAP.386 VDD is
	  installed

Format of Phar Lap system register record:
Offset	Size	Description	(Table 1063)
 00h	DWORD	CR0
 04h  4 DWORDs	DR0,DR1,DR2,DR3
 14h  2 DWORDs	reserved
 1Ch  2 DWORDs	DR6,DR7
 24h  3 DWORDs	reserved
--------E-212536----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v3.0+ - MIN/MAX EXTENDED/CONV MEMORY USAGE
	AX = 2536h
	EBX = bit flags
	    bit 0: modifying conventional memory rather than extended memory
	    bit 1: setting maximum memory usage rather than minimum
	ECX = new limit in 4K pages
Return: CF clear if successful
	    EAX = new limit
	CF set on error
	    EAX = error code (08h memory error or -NOPAGE set)
	    EBX = maximum limit in pages
	    ECX = minimum limit in pages
--------E-212537----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v3.0 - ALLOCATE DOS MEMORY ABOVE DOS BUFFER
	AX = 2537h
	BX = number of paragraphs to allocate
Return: CF clear if successful
	    AX = real-mode segment of allocated block
	CF set on error
	    AX = error code
		07h MS-DOS memory chain corrupted
		08h insufficient low memory
	    BX = size in paragraphs of largest free block
SeeAlso: AH=48h
--------E-212538----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v3.0 - READ PROTMODE REGS AFTER SFTWARE INT
	AX = 2538h
	DS:EBX -> buffer for registers (see #1056)
	ECX = register record to retrieve
	    00h first interrupt state
	    01h next interrupt state
		EDX = handle for current interrupt state
Return: CF clear if successful
	    DS:EBX buffer filled
	    EDX = handle of current interrupt state
	    ESI = number of interrupt which occurred
	CF set on error
	    EAX = error code
		81h invalid handle in EDX
		83h register saving not enabled
		84h no more interrupt states
SeeAlso: AX=2527h,AX=2528h
--------E-212539----------------------------
INT 21 P - Phar Lap 386/DOS-Ext VMM v3.0 - GET OFFSET OF .EXP FILE HEADER
	AX = 2539h
	BX = MS-DOS file handle for open file
Return: CF clear if successful
	    EAX = offset of .EXP header in file
	CF set on error
	    EAX = error code (02h file error)
	    EBX = file error code
		02h DOS error seeking
		03h DOS error reading
		04h invalid file type
		05h invalid file format
	    ECX = DOS error code if EBX=02h or 03h
	current file position in file modified
--------E-21253A----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v3.0+ - INSTALL MOD. SEG FAILURE HANDLER
	AX = 253Ah
	ES:EBX -> function to be called when INT 21/AH=4Ah is about to return
		an error
Return: CF clear
	ES:EBX -> previous handler
SeeAlso: AH=4Ah
--------E-21253B----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v3.0+ - JUMP TO REAL MODE CODE, NO CONTEXT
	AX = 253Bh
	DS:EBX -> buffer containing register contents (see #1056)
Return: never returns
SeeAlso: AX=2528h
--------E-21253C-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender VMM v3.0+ - SHRINK 386|VMM SWAP FILE
	AX = 253Ch
Return: CF clear
	EAX = old size of swap file in bytes
	EBX = new size of swap file in bytes
--------E-21253D-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender v4.0+ - READ/WRITE IDT DESCRIPTOR
	AX = 253Dh
	BL = interrupt number
	ECX = direction (0 = read, 1 = write)
	DS:EDX -> 8-byte buffer for descriptor
Return: CF clear if successful
	    DS:EDX filled if reading
	CF set on error
	    EAX = error code (0082h if running under DPMI)
Desc:	access hardware-level IDT rather than the internal 386/DOS-Extender
	  shadow IDT
Notes:	this call will always fail under DPMI because it is not possible to
	  access the IDT
	the descriptor is not checked when writing
	this call can normally be used only by programs running in ring 0
	  because the processor does not allow an interrupt to be vectored to
	  a less privileged ring
--------E-21253F-----------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender v6.0+ - ALLOCATE LDT DESCRIPTOR
	AX = 253Fh
	BX = LDT descriptor to allocate (0000h for any)
	???
Return: ???
--------E-212540-----------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender v6.0+ - FORCE ALIAS OF SEGMENT
	AX = 2540h
	???
Return: ???
--------E-212544-----------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender v6.0+ - FREE DLL
	AX = 2544h
	???
Return: ???
--------E-212545-----------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender v6.0+ - GET/SET PROCEDURE ADDRESS
	AX = 2545h
	ECX = direction (00h get, 01h set)
	???
Return: ???
--------E-212546-----------------------------
INT 21 Pu - Phar Lap 386/DOS-Extender v6.0+ - GET MODULE HANDLE
	AX = 2546h
	???
Return: ???
--------E-2125C0-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - ALLOCATE MS-DOS MEMORY BLOCK
	AX = 25C0h
	BX = number of 16-byte paragraphs of MS-DOS memory requested
Return: CF clear if successful
	    AX = real-mode paragraph address of memory
	CF set on error
	    AX = error code
		07h MS-DOS memory control blocks destroyed
		08h insufficient memory
	    BX = size in paragraphs of largest available memory block
SeeAlso: AX=25C1h,AX=25C2h
--------E-2125C1-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - RELEASE MS-DOS MEMORY BLOCK
	AX = 25C1h
	CX = real-mode paragraph address of memory block to free
Return: CF clear if successful
	    EAX destroyed
	CF set on error
	    AX = error code
		07h MS-DOS memory control blocks destroyed
		09h invalid memory block address in CX
SeeAlso: AX=25C0h,AX=25C2h
--------E-2125C2-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - MODIFY MS-DOS MEMORY BLOCK
	AX = 25C2h
	BX = new requested block size in paragraphs
	CX = real-mode paragraph address of memory block to modify
Return: CF clear if successful
	    EAX destroyed
	CF set on error
	    AX = error code
		07h MS-DOS memory control blocks destroyed
		08h insufficient memory
		09h invalid memory block address in CX
	    BX = size in paragraphs of largest available memory block
SeeAlso: AX=25C0h,AX=25C1h
--------E-2125C3-----------------------------
INT 21 P - Phar Lap 386/DOS-Extender - EXECUTE PROGRAM
	AX = 25C3h
	ES:EBX -> pointer to parameter block (see #1065)
	DS:EDX -> pointer to ASCIZ program filename
Return: CF clear if successful
	    all registers unchanged
	CF set on error
	    EAX = error code (see #1064)

(Table 1064)
Values for Phar Lap error code:
 01h	function code in AL is invalid ???
 02h	file not found or path invalid
 05h	access denied
 08h	insufficient memory to load program
 0Ah	environment invalid
 0Bh	invalid file format

Format of parameter block:
Offset	Size	Description	(Table 1065)
 00h	DWORD	32-bit offset of environment string
 04h	WORD	segment selector of environment string
 06h	DWORD	32-bit offset of command-tail string
 0Ah	WORD	segment selector of command-tail string
--------D-2126-------------------------------
INT 21 - DOS 1+ - CREATE NEW PROGRAM SEGMENT PREFIX
	AH = 26h
	DX = segment at which to create PSP (see #1066)
Return: AL destroyed
Notes:	new PSP is updated with memory size information; INTs 22h, 23h, 24h
	  taken from interrupt vector table; the parent PSP field is set to 0
	(DOS 2+) DOS assumes that the caller's CS is the segment of the PSP to
	  copy
SeeAlso: AH=4Bh,AH=50h,AH=51h,AH=55h,AH=62h,AH=67h

Format of Program Segment Prefix (PSP):
Offset	Size	Description	(Table 1066)
 00h  2 BYTEs	INT 20 instruction for CP/M CALL 0 program termination
		the CDh 20h here is often used as a signature for a valid PSP
 02h	WORD	segment of first byte beyond memory allocated to program
 04h	BYTE	(DOS) unused filler
		(OS/2) count of fake DOS version returns
 05h	BYTE	CP/M CALL 5 service request (FAR CALL to absolute 000C0h)
		BUG: (DOS 2+ DEBUG) PSPs created by DEBUG point at 000BEh
 06h	WORD	CP/M compatibility--size of first segment for .COM files
 08h  2 BYTEs	remainder of FAR JMP at 05h
 0Ah	DWORD	stored INT 22 termination address
 0Eh	DWORD	stored INT 23 control-Break handler address
 12h	DWORD	DOS 1.1+ stored INT 24 critical error handler address
 16h	WORD	segment of parent PSP
 18h 20 BYTEs	DOS 2+ Job File Table, one byte per file handle, FFh = closed
 2Ch	WORD	DOS 2+ segment of environment for process (see #1067)
 2Eh	DWORD	DOS 2+ process's SS:SP on entry to last INT 21 call
 32h	WORD	DOS 3+ number of entries in JFT (default 20)
 34h	DWORD	DOS 3+ pointer to JFT (default PSP:0018h)
 38h	DWORD	DOS 3+ pointer to previous PSP (default FFFFFFFFh in 3.x)
		used by SHARE in DOS 3.3
 3Ch	BYTE	DOS 4+ (DBCS) interim console flag (see AX=6301h)
		Novell DOS 7 DBCS interim flag as set with AX=6301h
		(possibly also used by Far East MS-DOS 3.2-3.3)
 3Dh	BYTE	(APPEND) TrueName flag (see INT 2F/AX=B711h)
 3Eh	BYTE	(Novell NetWare) flag: next byte initialized if CEh
		(OS/2) capabilities flag
 3Fh	BYTE	(Novell NetWare) Novell task number if previous byte is CEh
 40h  2 BYTEs	DOS 5+ version to return on INT 21/AH=30h
 42h	WORD	(MSWindows3) selector of next PSP (PDB) in linked list
		Windows keeps a linked list of Windows programs only
 44h	WORD	(MSWindows3) "PDB_Partition"
 46h	WORD	(MSWindows3) "PDB_NextPDB"
 48h	BYTE	(MSWindows3) bit 0 set if non-Windows application (WINOLDAP)
 49h	BYTE	unused by DOS versions <= 6.00
 4Ch	WORD	(MSWindows3) "PDB_EntryStack"
 4Eh  2 BYTEs	unused by DOS versions <= 6.00
 50h  3 BYTEs	DOS 2+ service request (INT 21/RETF instructions)
 53h  2 BYTEs	unused in DOS versions <= 6.00
 55h  7 BYTEs	unused in DOS versions <= 6.00; can be used to make first FCB
		  into an extended FCB
 5Ch 16 BYTEs	first default FCB, filled in from first commandline argument
		overwrites second FCB if opened
 6Ch 16 BYTEs	second default FCB, filled in from second commandline argument
		  overwrites beginning of commandline if opened
 7Ch  4 BYTEs	unused
 80h 128 BYTEs	commandline / default DTA
		command tail is BYTE for length of tail, N BYTEs for the tail,
		  followed by a BYTE containing 0Dh
Notes:	in DOS v3+, the limit on simultaneously open files may be increased by
	  allocating memory for a new open file table, filling it with FFh,
	  copying the first 20 bytes from the default table, and adjusting the
	  pointer and count at 34h and 32h.  However, DOS will only copy the
	  first 20 file handles into a child PSP (including the one created on
	  EXEC).
	in an OS/2 DOS box, values of D0h-FEh in the open file table indicate
	  device drivers
	network redirectors based on the original MS-Net implementation use
	  values of 80h-FEh in the open file table to indicate remote files;
	  Novell NetWare also uses values from FEh down to 80h or one more than
	  FILES= (whichever is greater) to indicate remote files (except on
	  OS/2, where is uses CFh down to 80h)
	MS-DOS 5.00 incorrectly fills the FCB fields when loading a program
	  high; the first FCB is empty and the second contains the first
	  parameter
	some DOS extenders place protected-mode values in various PSP fields
	  such as the "parent" field, which can confuse PSP walkers.  Always
	  check either for the CDh 20h signature or that the suspected PSP is
	  at the beginning of a memory block which owns itself (the preceding
	  paragraph should be a valid MCB with "owner" the same as the
	  suspected PSP).
	Novell NetWare updates the fields at offsets 3Eh and 3Fh without
	  checking that a legal PSP segment is current; see AH=50h for further
	  discussion
	for 4DOS and Windows95, the command tail may be more than 126
	  characters; in that case, the length byte will be set to 7Fh (with
	  an 0Dh in the	 127th position at offset FFh), and the first 126
	  characters will be stored in the PSP, with the entire command line
	  in the environment variable CMDLINE; under at least some versions
	  of 4DOS, the byte at offset FFh is *not* set to 0Dh, so there is no
	  terminating carriage return in the PSP's command tail.

Format of environment block:
Offset	Size	Description	(Table 1067)
 00h  N BYTEs	first environment variable, ASCIZ string of form "var=value"
      N BYTEs	second environment variable, ASCIZ string
	...
      N BYTEs	last environment variable, ASCIZ string of form "var=value"
	BYTE	00h
---DOS 3.0+ ---
	WORD	number of strings following environment (normally 1)
      N BYTEs	ASCIZ full pathname of program owning this environment
		other strings may follow
--------D-2127-------------------------------
INT 21 - DOS 1+ - RANDOM BLOCK READ FROM FCB FILE
	AH = 27h
	CX = number of records to read
	DS:DX -> opened FCB (see #1034)
Return: AL = status
	    00h successful, all records read
	    01h end of file, no data read
	    02h segment wrap in DTA, no data read
	    03h end of file, partial read
	Disk Transfer Area filled with records read from file
	CX = number of records read (return AL = 00h or 03h)
Notes:	read begins at current file position as specified in FCB; the file
	  position is updated after reading
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=21h,AH=28h,AH=3Fh"DOS"
--------D-2128-------------------------------
INT 21 - DOS 1+ - RANDOM BLOCK WRITE TO FCB FILE
	AH = 28h
	CX = number of records to write
	DS:DX -> opened FCB (see #1034)
	Disk Transfer Area contains records to be written
Return: AL = status
	    00h successful
	    01h disk full or file read-only
	    02h segment wrap in DTA
	CX = number of records written
Notes:	write begins at current file position as specified in FCB; the file
	  position is updated after writing
	if CX = 0000h on entry, no data is written; instead the file size is
	  adjusted to be the same as the file position specified by the random
	  record and record size fields of the FCB
	if the data to be written is less than a disk sector, it is copied into
	  a DOS disk buffer, to be written out to disk at a later time
	not supported by MS Windows 3.0 DOSX.EXE DOS extender
SeeAlso: AH=22h,AH=27h,AH=40h,AH=59h/BX=0000h
--------D-2129-------------------------------
INT 21 - DOS 1+ - PARSE FILENAME INTO FCB
	AH = 29h
	AL = parsing options (see #1068)
	DS:SI -> filename string (both '*' and '?' wildcards OK)
	ES:DI -> buffer for unopened FCB
Return: AL = result code
	    00h successful parse, no wildcards encountered
	    01h successful parse, wildcards present
	    FFh failed (invalid drive specifier)
	DS:SI -> first unparsed character
	ES:DI buffer filled with unopened FCB (see #1034)
Notes:	asterisks expanded to question marks in the FCB
	all processing stops when a filename terminator is encountered
	cannot be used with filespecs which include a path (DOS 2+)
	Novell NetWare monitors the result code since an 'invalid drive' may
	  signal an attempt to reconnect a network drive; if there are no
	  connections to the specified drive, NetWare attempts to build a
	  connection and map the drive to the SYS:LOGIN directory
SeeAlso: AH=0Fh,AH=16h,AH=26h

Bitfields for parsing options:
Bit(s)	Description	(Table 1068)
 0	skip leading separators
 1	use existing drive number in FCB if no drive is specified, instead of
	  setting field to zero
 2	use existing filename in FCB if no base name is specified, instead of
	  filling field with blanks
 3	use existing extension in FCB if no extension is specified, instead of
	  filling field with blanks
 4-7	reserved (0)
--------D-212A-------------------------------
INT 21 - DOS 1+ - GET SYSTEM DATE
	AH = 2Ah
Return: CX = year (1980-2099)
	DH = month
	DL = day
---DOS 1.10+---
	AL = day of week (00h=Sunday)
SeeAlso: AH=2Bh"DOS",AH=2Ch,AH=E7h"Novell",INT 1A/AH=04h,INT 2F/AX=120Dh
--------!---Section--------------------------
