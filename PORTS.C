Ports List, part 3 of 3
Copyright (c) 1989,1990,1991,1992,1993,1994,1995,1996,1997,1998 Ralf Brown
--------X-P100010FF--------------------------
PORT 1000-10FF - available for EISA slot 1
----------P12E812EF--------------------------
PORT 12E8-12EF - 8514/A and compatible (e.g. ATI Graphics Ultra) - VERT TOTAL

12E8w -W  CRT control: vertical total
--------V-P12EE------------------------------
PORT 12EE - ATI Mach32 - CONFIGURATION STATUS 0
SeeAlso: PORT 16EEh"Mach32",PORT 42EEh"Mach32",PORT 52EEh"Mach32"
----------P13901393--------------------------
PORT 1390-1393 - cluster (adapter 3)
----------P13C6------------------------------
PORT 13C6 - Compaq - ???
Note:	this port is read by the Compaq MS-DOS 4.0/5.0 CHARSET utility

13C6  R?  Compaq video status??? (see #P0937)

Bitfields for Compaq video status???:
Bit(s)	Description	(Table P0937)
 7	???
 6	flag
 5-3	???
 2-0	status of display???
--------X-P140014FF--------------------------
PORT 1400-14FF - available for EISA slot 1
----------P16E816EF--------------------------
PORT 16E8-16EF - 8514/A and compatible (e.g. ATI Graphics Ultra) - VERT DISPLYD

16E8w -W  CRT control: vertical displayed
--------V-P16EE------------------------------
PORT 16EE - ATI Mach32 - CONFIGURATION STATUS 1
SeeAlso: PORT 12EEh"Mach32",PORT 42EEh"Mach32",PORT 52EEh"Mach32"
--------X-P180018FF--------------------------
PORT 1800-18FF - available for EISA slot 1
----------P1AE81AEF--------------------------
PORT 1AE8-1AEF - 8514/A and compatible (e.g. ATI Graphics Ultra) - VSYNC START

1AE8w -W  CRT control: vertical sync start
--------X-P1C001CFF--------------------------
PORT 1C00-1CFF - available for EISA slot 1
----------P1C65------------------------------
PORT 1C65 - Compaq Contura Aero
SeeAlso: PORT 2065h

1C65  R?  bit 6: operating on battery power
--------X-P1C801C8F--------------------------
PORT 1C80-1C8F - VESA XGA Video in EISA slot 1

1C80-1C83  RW	EISA Video ID
1C84  RW	EISA Video expansion board control (see #P0938)
1C85  RW	EISA Setup control
1C88  RW	EISA Video Programmable Option Select 0
1C89-1C8F  RW	EISA Video Programmable Option Select 1-7
--------X-P1C801C83--------------------------
PORT 1C80-1C83 - EISA board product ID (board in slot 1)

1C80  R?  bit 7: unused (0)
	  bits 6-2: manufacturer ID, first compressed ASCII char
	  bits 1-0: manufacturer ID, second compressed ASCII char (high)
1C81  R?  bits 7-5: manufacturer ID, second compressed ASCII char (low)
	  bits 4-0: manufacturer ID, third compressed ASCII char
1C82  R?  bits 7-4: first hex digit of product type
	  bits 3-0: second hex digit of product type
1C83  R?  bits 7-4: third hex digit of product type
	  bits 3-0: product revision number (hex digit)
--------X-P1C84------------------------------
PORT 1C84 - EISA CONFIGURATION FLAGS (board in slot 1)

1C84  RW  configuration flags (see #P0938)

Bitfields for EISA Add-in Card configuration flags:
Bit(s)	Description	(Table P0938)
 0	enable
 1	IOCHKERR (read-only) card is generating CHCHK#, causing an NMI
 2	IOCHKRST reset card
 7-3	card-specific
--------X-P1C85------------------------------
PORT 1C85 - EISA SETUP CONTROL (board in slot 1)
--------V-P1C85------------------------------
PORT 1C85 - Compaq Qvision EISA - Virtual Controller ID
--------X-P1C881C8F--------------------------
PORT 1C88-1C8F - EISA PROGRAMMABLE OPTION SELECT (board in slot 1)
--------V-P1EE81EEF--------------------------
PORT 1EE8-1EEF - 8514/A and compatible (e.g. ATI Graphics Ultra) - VSYNC WIDTH

1EE8w -W  CRT control: vertical sync width
--------V-P1EEC------------------------------
PORT 1EEC - Mach64 - ???

1EEC  RW  display power and other controls
	bits 3-2: DPMS power mode
		00 normal
		01 standby
		10 suspend
		11 off
--------X-P200020FF--------------------------
PORT 2000-20FF - available for EISA slot 2
----------P2065------------------------------
PORT 2065 - Compaq Contura Aero
SeeAlso: PORT 1C65h"Compaq",PORT 2465h"Compaq"

2065  -W  ??? (84h seen)
--------V-P2100------------------------------
PORT 2100 - XGA Video Operating Mode Register
Note:	this port is for the first XGA in the system; 2110-2170 are used for
	  the second through eighth XGAs
--------V-P2101------------------------------
PORT 2101 - XGA Video Aperture Control
Note:	this port is for the first XGA in the system; 2111-2171 are used for
	  the second through eighth XGAs
--------V-P21022103--------------------------
PORT 2102-2103 - XGA ???
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P2104------------------------------
PORT 2104 - XGA Video Interrupt Enable
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P2105------------------------------
PORT 2105 - XGA Video Interrupt Status
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P2106------------------------------
PORT 2106 - XGA Video Virtual Memory Control
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P2107------------------------------
PORT 2107 - XGA Video Virtual Memory Interrupt Status
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P2108------------------------------
PORT 2108 - XGA Video Aperture Index
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P2109------------------------------
PORT 2109 - XGA Video Memory Access Mode
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P210A------------------------------
PORT 210A - XGA Video Index for Data
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P210B------------------------------
PORT 210B - XGA Video Data (byte)
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P210C210F--------------------------
PORT 210C-210F - XGA Video Data (word/dword)
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs

210C  RW  byte data
210Cw RW  word data
210Cd RW  dword data
--------V-P2110211F--------------------------
PORT 2110-211F - IBM XGA (eXtended Graphics Adapter  8514/A) (second installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P2120212F--------------------------
PORT 2120-212F - IBM XGA (eXtended Graphics Adapter  8514/A) (third installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P2130213F--------------------------
PORT 2130-213F - IBM XGA (eXtended Graphics Adapter  8514/A) (fourth installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P2140214F--------------------------
PORT 2140-214F - IBM XGA (eXtended Graphics Adapter  8514/A) (fifth installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P2150215F--------------------------
PORT 2150-215F - IBM XGA (eXtended Graphics Adapter  8514/A) (sixth installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P2160216F--------------------------
PORT 2160-216F - IBM XGA (eXtended Graphics Adapter 8514/A) (seventh installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P2170217F--------------------------
PORT 2170-217F - IBM XGA (eXtended Graphics Adapter 8514/A) (eighth installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P217A217B--------------------------
PORT 217A-217B - ET4000/W32 CRTC-B/Sprite
Note:	Alternative addresses may depend on adapter manufacturer,
	  Tseng claims 21xA with x=three address bits, selected by IOD2..0
	  during power up reset.

21xA  RW  ET4000/W32(i) CRTC-B/Sprite index register
	bit7-0: index
21xB  RW  ET4000/W32(i) CRTC-B/Sprite data register (see #P0939)

(Table P0939)
Values for ET4000/W32(i) CRTC-B/Sprite data register index:
 E0h	CRTC-B / Sprite Horizontal Pixel Position, Low
	   bit7-0: horizontal pixel position bit7-0
 E1h	CRTC-B / Sprite Horizontal Pixel Position, High
	   bit7-4: reserved
	   bit3-0: horizontal pixel position bit11-8
 E2h	CRTC-B Width Low / Sprite Horizontal Preset
	   bit7-0: width of CRTC-B bit7-0
	   bit5-0: horizontal preset for sprite
 E3h	CRTC-B Width High / Sprite Horizontal Preset
	   bit7-4: reserved
	   bit3-0: width of CRTC-B bit11-8
 E4h	CRTC-B / Sprite Vertical Pixel Position, Low
	   bit7-0: vertical pixel position bit7-0
 E5h	CRTC-B / Sprite Vertical Pixel Position, High
	   bit7-4: reserved
	   bit3-0: vertical pixel position bit11-8
 E6h	CRTC-B Height Low / Sprite Vertical Preset
	   bit7-0: height of CRTC-B bit7-0
	   bit5-0: vertical preset for sprite
 E7h	CRTC-B Height High / Sprite Vertical Preset
	   bit7-4: reserved
	   bit3-0: height of CRTC-B bit11-8
 E8h	CRTC-B / Sprite Starting Address Low
	   pointer to CRTC-B / sprite image in display memory.
	   (maximum size of sprites 64x64x4=1KB with 4 colors:
	    00b=color-0, 01b=color-255, 10b=transparent, 11b=reserved)
	   bit7-0: startaddress bit7-0
 E9h	CRTC-B / Sprite Starting Address Middle
	   bit7-0: startaddress bit15-8
 EAh	CRTC-B / Sprite Starting Address High
	   bit7-4: reserved
	   bit3-0: startaddress bit19-16
 EBh	CRTC-B / Sprite Row Offset Low
	   bit7-0: offset bit7-0
 ECh	CRTC-B / Sprite Row Offset High
	   bit7-4: revision ID (any ET4000/W32)
		    0000b=W32	     0100b-1111b reserved
		    0001b=W32i
		    0010b=W32p
		    0011b=W32i, new
	   bit3-0: offset bit11-8
 EDh	CRTC-B Pixel Panning
	   bit7-3: reserved
	   bit2-0: CRTC-B pixel panning
 EEh	CRTC-B Color-Depth-Register / Hardware-Zoom
	   bit7-4: reserved (concerning databook ET4000/W32)
	   bit7-6: vertical zoom (undocumented)
		   (original ET4000/W32 ok, doesn't work properly
		    with some ET4000/W32i)
		    00b=zoomx1	   10b=zoomx3
		    01b=zoomx2	   11b=zoomx4
	   bit5-4: horizontal zoom (undocumented)
		   (original ET4000/W32 ok, doesn't work properly
		    with some ET4000/W32i)
		    00b=zoomx1	   10b=zoomx3
		    01b=zoomx2	   11b=zoomx4
	   bit3-0: bit/pixel
		    0000b=1	   0011b=8
		    0001b=2	   0100b=16
		    0010b=4
 EFh	CRTC-B / Sprite Control
	   bit7-2: reserved
	   bit1	 : 1=2nd CRTC-B image overlays main CRTC-A image
		   0=CRTC-B image at pin SP1/0
	   bit0	 : 1=enable CRTC-B
		   0=enable sprite (see F7h)
 F7h	Image Port Control
	   bit7	 : 1=CRTC-B or sprite active
		   0=CRTC-B and sprite not active
	   bit6-0: reserved
----------P22E822EF--------------------------
PORT 22E8-22EF - 8514/A and compatible (e.g. ATI Graphics Ultra) - DISPLAY CTRL

22E8w -W  CRT control: display control
----------P23902393--------------------------
PORT 2390-2393 - cluster (adapter 4)
--------V-P23C023CF--------------------------
PORT 23C0-23CF - Compaq QVision - BitBLT engine
--------X-P240024FF--------------------------
PORT 2400-24FF - available for EISA slot 2
----------P2465------------------------------
PORT 2465 - Compaq Contura Aero
SeeAlso: PORT 1C65h"Compaq",PORT 2065h"Compaq"

2465  R-  current battery power level
		(166 fully-charged, 130 = LowBat1)
----------P27C6------------------------------
PORT 27C6 - Compaq LTE Lite - LCD TIMEOUT

27C6  RW  LCD timeout in minutes
--------X-P280028FF--------------------------
PORT 2800-28FF - available for EISA slot 2
--------V-P28E9------------------------------
PORT 28E9 - 8514/A - WD Escape Functions
--------V-P2C802C8F--------------------------
PORT 2C80-2C8F - VESA XGA Video in EISA slot 2
SeeAlso: PORT 1C80h-1C83h,PORT 1C88h-1C8Fh
--------X-P2C802C83--------------------------
PORT 2C80-2C83 - EISA board product ID (board in slot 2)
SeeAlso: PORT 1C80h-1C83h
--------X-P2C84------------------------------
PORT 2C84 - EISA CONFIGURATION FLAGS (board in slot 2)

2C84  RW  configuration flags (see #P0938)
--------X-P300030FF--------------------------
PORT 3000-30FF - available for EISA slot 3
--------S-P32203227--------------------------
PORT 3220-3227 - serial port 3, description same as 03F8
--------S-P3228322F--------------------------
PORT 3228-322F - serial port 4, description same as 03F8
--------V-P33C033CF--------------------------
PORT 33C0-33CF - Compaq QVision - BitBLT engine
--------X-P340034FF--------------------------
PORT 3400-34FF - available for EISA slot 3
--------d-P35103513--------------------------
PORT 3510-3513 - ESDI primary harddisk controller
Range:	PORT 3510h-3513h (primary) or PORT 3518h-351Bh (secondary)
SeeAlso: PORT 3518h,PORT 01F0h-01F7h

3510w R-  status word
3510w -W  command word
3512  R-  basic status
3512  -W  basic control
3513  R-  interrupt status
3513  -W  attention
--------d-P3518351B--------------------------
PORT 3518-351B - ESDI secondary harddisk controller
Range:	PORT 3510h-3513h (primary) or PORT 3518h-351Bh (secondary)
SeeAlso: PORT 3510h,PORT 01F0h-01F7h

3518w R-  status word
3518w -W  command word
351A  R-  basis status
351A  -W  basic control
351B  R-  interrupt status
351B  -W  attention
--------d-P3540354F--------------------------
PORT 3540-354F - IBM SCSI (Small Computer System Interface) adapter
--------d-P3550355F--------------------------
PORT 3550-355F - IBM SCSI (Small Computer System Interface) adapter
--------d-P3560356F--------------------------
PORT 3560-356F - IBM SCSI (Small Computer System Interface) adapter
--------d-P3570357F--------------------------
PORT 3570-357F - IBM SCSI (Small Computer System Interface) adapter
--------V-P36EE------------------------------
PORT 36EE - ATI Mach8/Mach32 - FIFO OPTION
SeeAlso: PORT 6AEEh,PORT 6EEEh,PORT 72EEh,PORT 76EEh,PORT 7AEEh,PORT 8EEEh

36EE  -W  FIFO option
		bit 0: generate wait states if FIFO >= half full
			(0=only when FIFO full)
		bit 1: force 8-bit host data I/O
--------X-P380038FF--------------------------
PORT 3800-38FF - available for EISA slot 3
--------X-P3C003CFF--------------------------
PORT 3C00-3CFF - available for EISA slot 3
--------V-P3C803C8F--------------------------
PORT 3C80-3C8F - VESA XGA Video in EISA slot 3

3C80-3C83  RW	EISA Video ID
3C84  RW	EISA Video expansion board control
3C85  RW	EISA Setup control
3C88  RW	EISA Video Programmable Option Select 0
3C89-3C8F  RW	EISA Video Programmable Option Select 1-7

SeeAlso: PORT 1C80h-1C8Fh"XGA",PORT 2C80h-2C8Fh"XGA",PORT 7C80h-7C8Fh"XGA"
--------X-P3C803C83--------------------------
PORT 3C80-3C83 - EISA board product ID (board in slot 3)
SeeAlso: PORT 1C80h-1C83h
--------X-P3C84------------------------------
PORT 3C84 - EISA CONFIGURATION FLAGS (board in slot 3)

3C84  RW  configuration flags (see #P0938)
--------X-P400040FF--------------------------
PORT 4000-40FF - available for EISA slot 4
----------P42204227--------------------------
PORT 4220-4227 - serial port, description same as 03F8
----------P4228422F--------------------------
PORT 4228-422F - serial port, description same as 03F8
----------P42E042EF--------------------------
PORT 42E0-42EF - GPIB (General Purpose Interface Bus, IEEE 488 interface)

42E1  RW  GPIB (adapter 2)
--------V-P42E8------------------------------
PORT 42E8 - 8514/A and hardware-compatible video cards
Note:	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set

42E8w R-  Misc. control: Subsystem Status (see #P0940)
42E8w -W  Misc. control: Subsystem Control (see #P0941)

Bitfields for 8514/A Subsystem Status register:
Bit(s)	Description	(Table P0940)
 15-8	(8514/A) reserved
 13	(S3) ???
 12-8	(S3) ???
 7	pixel length (0 = four bits, 1 = eight bits)
 6-4	reserved
 3	FIFO empty (interrupt generated if enabled)
 2	FIFO overflow (interrupt generated if enabled)
 1	Graphics Engine busy (interrupt generated if enabled)
 0	vertical sync (interrupt generated if enabled)
SeeAlso: #P0941

Bitfields for 8514/A Subsystem Control Register:
Bit(s)	Description	(Table P0941)
 15-14	GP_RESET
      W	00 no change
	01 normal operation
	10 reset graphics processor and FIFO
	11 reserved
 13-12	reserved
 11   W	enable interrupt when graphics processor idle
 10   W	enable interrupt on invalid I/O (FIFO overlow)
 9    W	enable interrupt if inside scissors region
 8    W	enable vertical blanking interval interrupt
 6-4 R	monitor ID (8514/A)
 7-4	reserved (S3)
 3	acknowledge idle interrupt (and clear)
 2	acknowledge invalid I/O interrupt (and clear)
 1	acknowledge inside-scissors interrupt (and clear)
 0	acknowledge vertical blanking interrupt (and clear)
SeeAlso: #P0940
--------V-P42EC------------------------------
PORT 42EC - ATI Mach64 - ???
SeeAlso: PORT 42EDh"Mach64"

42EC  RW  ???
	bits 1-0: ???
--------V-P42ED------------------------------
PORT 42ED - ATI Mach64 - ???
SeeAlso: PORT 42ECh"Mach64",PORT 42EFh

42ED  R?  ???
--------V-P42EE42EF--------------------------
PORT 42EE-42EF - ATI Mach32 - MEMORY BOUNDARY REGISTER
SeeAlso: PORT 5EEEh"Mach32"

42EEw RW  memory boundary
	bits 3-0: VGA/8514 boundary in 256K units (VGA only below, 8514 above)
	bit 4: partition enable: VGA and 8514 drawing engines may only write
	      within their respective partitions
	bits 15-5: reserved
--------V-P42EF------------------------------
PORT 42EF - ATI Mach64 - ???
SeeAlso: PORT 42EDh"Mach64"

42EF  R?  ???
--------X-P440044FF--------------------------
PORT 4400-44FF - available for EISA slot 4
----------P4F15------------------------------
PORT 4F15 - Tseng Labs ET6000 - Read EDID through Display Data Channel
--------V-P46E8------------------------------
PORT 46E8 - VGA - VIDEO ADAPTER ENABLE
Note:	IBM uses this port for adapter-card VGAs only, and PORT 03C3h for
	  motherboard VGA only (see 03C3 for details)
SeeAlso: PORT 03C3h,PORT 46E8h"8514/A",#P0721

46E8  rW  Misc. control: enable flags / select ROM page (8514/A) (see #P0942)

Bitfields for VGA miscellaneous control register:
Bit(s)	Description	(Table P0942)
 7-5	unused or vendor-specific
 4	setup for POS registers (MCA)
 3	enable video I/O ports and video buffer
 2-0	unused or vendor-specific
--------V-P46E8------------------------------
PORT 46E8 - 8514/A and compatible (e.g. ATI Graphics Ultra) - ROM PAGE SELECT
Note:	this register is readable on the C&T 82c480 chipset
SeeAlso: PORT 46E8h"VGA"

46E8w -W  ROM page select (see #P0943)

Bitfields for 8514/A ROM page select register:
Bit(s)	Description	(Table P0943)
 2-0	select which 4K page of 32K ROM to map at segment C700h
 3	enable VGA
 4	select VGA setup mode
 15-5	reserved (0)
--------V-P46EE------------------------------
PORT 46EE - ATI Mach32 - ???

46EEw RW  ???
--------V-P46EF------------------------------
PORT 46EF - ATI Mach64 - ???
Note:	the Mach64 BIOS reads the value of this port and multiplies it by 100
SeeAlso: PORT 66ECh"Mach64"
--------X-P480048FF--------------------------
PORT 4800-48FF - available for EISA slot 4
--------V-P4AE84AE9--------------------------
PORT 4AE8-4AE9 - 8514/A and compatible - CRT CONTROL
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: #P0722

4AE8w -W  CRT control: Advanced function control (see also #P0944)
	(02h = VGA mode, 03h = 480-line mode, 07h = 768-line mode)

Bitfields for S3 8514/A-compatible Advanced Function Control register:
Bit(s)	Description	(Table P0944)
 15-7	reserved
 6	(928 only) enable Write Posting
 5	(928+) enable memory-mapped I/O
 4	(928+) enable linear addressing (see also #P0714)
 3	reserved
 2	(911-928) screen size (1 = 800x600 or 1024x768, 0=640x480)
	(Trio32/Trio64) enhanced modes pixel length (0 = 8+ bpp, 1 = 4 bpp)
 1	reserved (1)
 0	enable enhanced functions
Note:	bit 4 is ORed with CR58 bit 4; bit 5 is ORed with CR53 bit 4
--------V-P4AEE------------------------------
PORT 4AEE - ATI Mach32 - ???

4AEEw RW  ???
--------X-P4C004CFF--------------------------
PORT 4C00-4CFF - available for EISA slot 4
--------X-P4C804C83--------------------------
PORT 4C80-4C83	EISA board product ID (board in slot 4)
SeeAlso: PORT 1C80h-1C83h
--------V-P4C804C8F--------------------------
PORT 4C80-4C8F - VESA XGA Video in EISA slot 4 (see 3C80-3C8F)
SeeAlso: PORT 1C80h-1C8Fh,PORT 6C80h-6C8Fh
--------X-P4C84------------------------------
PORT 4C84 - EISA CONFIGURATION FLAGS (board in slot 4)

4C84  RW  configuration flags (see #P0938)
--------X-P500050FF--------------------------
PORT 5000-50FF - available for EISA slot 5
--------S-P52205227--------------------------
PORT 5220-5227 - serial port, description same as 03F8
--------S-P5228522F--------------------------
PORT 5228-522F - serial port, description same as 03F8
--------V-P52E852E9--------------------------
PORT 52E8-52E9 - C&T 82c480 - EXTENDED CONFIGURATION REGISTER 0
Note:	the 82c480 is an 8514/A-compatible video chipset
SeeAlso: PORT 56E8h"C&T",PORT 5AE8h"C&T",PORT 5EE8h"C&T"

52E8w RW  Extended Configuration Register 0
--------V-P52EE52EF--------------------------
PORT 52EE-52EF - ATI Mach32 - SCRATCH REGISTER 0 (USED FOR ROM LOCATION)
Note:	ATI video BIOS sets this port according to the segment address of the
	  BIOS if >= C000h, as ((seg-C000h) shr 7)
SeeAlso: PORT 56EEh"Mach32"

52EEw RW  scratch register 0: Video ROM address
--------X-P540054FF--------------------------
PORT 5400-54FF - available for EISA slot 5
--------V-P56E856E9--------------------------
PORT 56E8-56E9 - C&T 82c480 - EXTENDED CONFIGURATION REGISTER 1
Note:	the 82c480 is an 8514/A-compatible video chipset
SeeAlso: PORT 52E8h"C&T",PORT 5AE8h"C&T",PORT 5EE8h"C&T"

56E8w RW  Extended Configuration Register 1
--------V-P56EE56EF--------------------------
PORT 56EE-56EF - ATI Mach32 - SCRATCH REGISTER 1
SeeAlso: PORT 52EEh"Mach32"

56EEw RW  scratchpad
--------X-P580058FF--------------------------
PORT 5800-58FF - available for EISA slot 5
--------V-P5AE85AE9--------------------------
PORT 5AE8-5AE9 - C&T 82c480 - EXTENDED CONFIGURATION REGISTER 2
Note:	the 82c480 is an 8514/A-compatible video chipset
SeeAlso: PORT 52E8h"C&T",PORT 56E8h"C&T",PORT 5EE8h"C&T"

5AE8w RW  Extended Configuration Register 2
--------V-P5AEE------------------------------
PORT 5AEE - ATI Mach32 - ???

5AEE  RW  ???
--------X-P5C005CFF--------------------------
PORT 5C00-5CFF - available for EISA slot 5
--------V-P5C805C8F--------------------------
PORT 5C80-5C8F - VESA XGA Video in EISA slot 5
SeeAlso: PORT 2C80h-2C8Fh,PORT 4C80h-4C8Fh,PORT 6C80h-6C8Fh

5C80d RW  EISA Video ID
5C84  RW  EISA Video expansion board control
5C85  RW  EISA Setup control
5C88  RW  EISA Video Programmable Option Select 0
5C89  RW  EISA Video Programmable Option Select 1
5C8A  RW  EISA Video Programmable Option Select 2
5C8B  RW  EISA Video Programmable Option Select 3
5C8C  RW  EISA Video Programmable Option Select 4
5C8D  RW  EISA Video Programmable Option Select 5
5C8E  RW  EISA Video Programmable Option Select 6
5C8F  RW  EISA Video Programmable Option Select 7
--------X-P5C805C83--------------------------
PORT 5C80-5C83	EISA board product ID (board in slot 5)
SeeAlso: PORT 1C80h-1C83h
--------X-P5C84------------------------------
PORT 5C84 - EISA CONFIGURATION FLAGS (board in slot 5)

5C84  RW  configuration flags (see #P0938)
--------V-P5EE85EE9--------------------------
PORT 5EE8-5EE9 - C&T 82c480 - EXTENDED CONFIGURATION REGISTER 3
Note:	the 82c480 is an 8514/A-compatible video chipset
SeeAlso: PORT 52E8h"C&T",PORT 56E8h"C&T",PORT 5AE8h"C&T"

5EE8w RW  Extended Configuration Register 3
----------P5EEE------------------------------
PORT 5EEE - ATI Mach32 - MEMORY APERTURE CONFIGURATION REGISTER
SeeAlso: PORT 42EEh"Mach32"

5EEEw RW  Memory Aperture Configuration (see #P0945)

Bitfields for ATI Mach32 Memory Aperture Configuration Register:
Bit(s)	Description	(Table P0945)
 1-0	direct memory interface mapping
	00 disabled
	01 1M aperture (not on PCI)
	10 4M aperture
	11 reserved
 3-2	1M page select (not on PCI)
	00 page 0
	01 page 1
	10 page 2
	11 page 3
 11-8	(ISA) memory aperture location, 0-15 MB
 13-8	(EISA) memory aperture location, 0-63 MB
 14-8	(VLB) memory aperture location, 0-127 MB [*]
 15-4	(PCI) memory aperture location, 0-4095 MB
 13-8	(MCA 16-bit) memory aperture location, 0-63 MB
 14-8	(MCA 32-bit) memory aperture location, 0-127 MB
Note:	[*] if PORT 16EEh bit 3 is set and PORT FAEEh is non-zero, bits 15-4
	  are used to specify an address from 0-4095 MB
--------X-P600060FF--------------------------
PORT 6000-60FF - available for EISA slot 6
----------P62E062EF--------------------------
PORT 62E0-62EF - GPIB (General Purpose Interface Bus, IEEE 488 interface)

62E1  RW  GPIB (adapter 3)
--------V-P63C063CF--------------------------
PORT 63C0-63CF - Compaq QVision - BitBLT engine
--------X-P640064FF--------------------------
PORT 6400-64FF - available for EISA slot 6
--------V-P66EC------------------------------
PORT 66EC - ATI Mach64 - ???
SeeAlso: PORT 6AECh"Mach64"
--------X-P680068FF--------------------------
PORT 6800-68FF - available for EISA slot 6
--------V-P6AEC6AED--------------------------
PORT 6AEC-6AED - ATI Mach64 - ???
SeeAlso: PORT 66ECh"Mach64"
--------V-P6AEE------------------------------
PORT 6AEE - ATI Mach8/Mach32 - MAXIMUM WAIT STATES
SeeAlso: PORT 36EEh,PORT 6EEEh,PORT 76EEh,PORT 7AEEh,PORT 8EEEh

6AEE  RW  maximum wait states (see #P0946)

Bitfields for ATI Mach8/Mach32 wait state configuration:
Bit(s)	Description	(Table P0946)
 10	leave alone ("PASSTHROUGH_OVERRIDE")
 9	enable for 16-bit I/O
 8	0=horizontal degree-mode line draws
--------X-P6C006CFF--------------------------
PORT 6C00-6CFF - available for EISA slot 6
--------X-P6C806C83--------------------------
PORT 6C80-6C83 - EISA board product ID (board in slot 6)
SeeAlso: PORT 1C80h-1C83h
--------V-P6C806C8F--------------------------
PORT 6C80-6C8F - VESA XGA Video in EISA slot 1
SeeAlso: PORT 1C80h-1C8Fh"XGA",PORT 2C80h-2C8Fh"XGA",PORT 5C80h-5C8Fh"XGA"

6C80d RW  EISA Video ID (see PORT 1C80h-1C83h)
6C84  RW  EISA Video expansion board control
6C85  RW  EISA Setup control
6C88  RW  EISA Video Programmable Option Select 0
6C89  RW  EISA Video Programmable Option Select 1
6C8A  RW  EISA Video Programmable Option Select 2
6C8B  RW  EISA Video Programmable Option Select 3
6C8C  RW  EISA Video Programmable Option Select 4
6C8D  RW  EISA Video Programmable Option Select 5
6C8E  RW  EISA Video Programmable Option Select 6
6C8F  RW  EISA Video Programmable Option Select 7
--------X-P6C84------------------------------
PORT 6C84 - EISA CONFIGURATION FLAGS (board in slot 6)

6C84  RW  configuration flags (see #P0938)
--------V-P6EEC------------------------------
PORT 6EEC - ATI Mach64 - ???
SeeAlso: PORT 6AECh"Mach64"
--------V-P6EEE------------------------------
PORT 6EEE - ATI Mach8/Mach32 - ENGINE VIDEO BUFFER OFFSET LOW
SeeAlso: PORT 72EEh

6AEEw -W  low 16 bits of video buffer starting offset
--------X-P700070FF--------------------------
PORT 7000-70FF - available for EISA slot 7
--------V-P72EC------------------------------
PORT 72EC - ATI Mach64 - ???
SeeAlso: PORT 66ECh"Mach64",PORT 72EFh"Mach64"
--------V-P72EE------------------------------
PORT 72EE - ATI Mach8/Mach32 - ENGINE VIDEO BUFFER OFFSET HIGH
SeeAlso: PORT 6EEEh

72EE  -W  high bits of video buffer starting offset
		bits 1-0 for Mach-8
		bits 3-0 for Mach-32
--------V-P72EE------------------------------
PORT 72EE - ATI Mach8/Mach32 - BOUNDS ACCUMULATOR (LEFT)
SeeAlso: PORT 76EEh"BOUNDS",PORT 7AEEh"BOUNDS",PORT 7EEEh"BOUNDS"

72EEw R-  left edge of bounding box for points written via Line Draw register
--------V-P72EF------------------------------
PORT 72EF - ATI Mach64 - ???
SeeAlso: PORT 66ECh"Mach64",PORT 72ECh"Mach64"
--------X-P740074FF--------------------------
PORT 7400-74FF - available for EISA slot 7
--------V-P76EE------------------------------
PORT 76EE - ATI Mach8/Mach32 - ENGINE DISPLAY PITCH
SeeAlso: PORT 6AEEh,PORT 7AEEh

76EE  -W  display pitch
--------V-P76EE------------------------------
PORT 76EE - ATI Mach8/Mach32 - BOUNDS ACCUMULATOR (TOP)
SeeAlso: PORT 72EEh"BOUNDS",PORT 7AEEh"BOUNDS",PORT 7EEEh"BOUNDS"

76EEw R-  top edge of bounding box for points written via Line Draw register
--------X-P780078FF--------------------------
PORT 7800-78FF - available for EISA slot 7
--------V-P7AEE------------------------------
PORT 7AEE - ATI Mach8/Mach32 - EXTENDED GRAPHICS ENGINE CONGIFURATION
SeeAlso: PORT 8EEEh

7AEEw -W  extended graphics engine configuration (see #P0947)

Bitfields for Mach8/Mach32 extended graphics engine configuration:
Bit(s)	Description	(Table P0947)
 15	drawing pixel size to be written next (68800-6 only)
 14	enable 8-bit DAC (Mach-32 only)
 13-12	DAC address inputs RS(3:2) control (Mach-32 only)
 11	display pixel size to be written next (68800-6 only)
 10	24-bit color order (Mach-32 only)
	0 = RGB
	1 = BGR
 9	24-bit color configuration: pixels use 4 bytes instead of three
 8	DAC processes four pixels in parallel (Mach-32 only)
 7-6	16-bits-per-color word format (Mach-32 only)
	00 RGB(5,5,5)
	01 RGB(5,6,5)
	10 RGB(6,5,5)
	11 RGB(6,6,4)
 5-4	number of bits per pixel (Mach-32 only)
	00 four
	01 eight
	10 sixteen
	11 twenty-four
 3	report monitor alias instead of actual monitor
 2-0	alternate monitor ID (alias)
--------V-P7AEE------------------------------
PORT 7AEE - ATI Mach8/Mach32 - BOUNDS ACCUMULATOR (RIGHT)
SeeAlso: PORT 72EEh"BOUNDS",PORT 76EEh"BOUNDS",PORT 7EEEh"BOUNDS"

7AEEw R-  right edge of bounding box for points written via Line Draw register
--------X-P7C007CFF--------------------------
PORT 7C00-7CFF - available for EISA slot 7
--------X-P7C807C83--------------------------
PORT 7C80-7C83 - EISA board product ID (board in slot 7)
SeeAlso: PORT 1C80h-1C83h
--------V-P7C807C8F--------------------------
PORT 7C80-7C8F - VESA XGA Video in EISA slot 7
SeeAlso: PORT 1C80h-1C8Fh,PORT 6C80h-6C8Fh

7C80-7C83  RW	EISA Video ID
7C84  RW	EISA Video expansion board control
7C85  RW	EISA Setup control
7C88  RW	EISA Video Programmable Option Select 0
7C89-7C8F  RW	EISA Video Programmable Option Select 1-7
--------X-P7C84------------------------------
PORT 7C84 - EISA CONFIGURATION FLAGS (board in slot 7)

7C84  RW  configuration flags (see #P0938)
--------V-P7EEE------------------------------
PORT 7EEE - ATI Mach8/Mach32 - BOUNDS ACCUMULATOR (RIGHT)
SeeAlso: PORT 72EEh"BOUNDS",PORT 76EEh"BOUNDS",PORT 7AEEh"BOUNDS"

7EEEw R-  right edge of bounding box for points written via Line Draw register
--------X-P800080FF--------------------------
PORT 8000-80FF - available for EISA slot 8
----------P82E082EF--------------------------
PORT 82E0-82EF - GPIB (General Purpose Interface Bus, IEEE 488 interface)

82E1  RW  GPIB (adapter 4)
--------V-P82E882E9--------------------------
PORT 82E8-82E9 - 8514/A and compatible - CURRENT Y POSITION
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT 86E8h,PORT 82EAh

82E8w -W  drawing control: current Y position
--------V-P82EA82EB--------------------------
PORT 82EA-82EB - S3 Trio64 - CURRENT Y POSITION 2
SeeAlso: PORT 82E8h

82EAw	  drawing control: current Y position 2
--------S-P82F882FF--------------------------
PORT 82F8-82FF - serial port, description same as 03F8
--------V-P83C083CF--------------------------
PORT 83C0-83CF - Compaq QVision - Line Draw Engine
--------V-P83C4------------------------------
PORT 83C4 - Compaq Qvision EISA - Virtual Controller Select
--------V-P83C683C9--------------------------
PORT 83C6-83C9 - Compaq Qvision EISA - DAC color registers
SeeAlso: PORT 03C6h
--------V-P83C683C9--------------------------
PORT 83C6-83C9 - Chips&Technologies 64200 (Wingine) - DAC color registers
SeeAlso: PORT 03C6h

83C6  RW  color palette pixel mask
83C7  R-  color palette state
83C7  -W  color palette read-mode index
83C8  RW  color palette write-mode index
83C9  RW  color palette data (three bytes)
----------P83D09FD3--------------------------
PORT 83D0-9FD3 - Chips&Techs 64310 - 32-BIT EXTENSION REGS - BitBLT
Notes:	All ports are word or dword accessible.
	These registers are also accessible in the upper 2 MB of the 4 MB
	  linear memory frame buffer (address specified in PCI configuration
	  registers).
SeeAlso: PORT 03D6h"Chips",PORT A3D0h"Chips"

83D0d RW  "DR00"  BitBlt offset register (see #P0948)
87D0d RW  "DR01"  BitBlt pattern ROP register (see #P0949)
8BD0d RW  "DR02"  BitBlt background color register (see #P0950)
8FD0d RW  "DR03"  BitBlt foreground color register (see #P0951)
93D0d RW  "DR04"  BitBlt control register (see #P0952)
97D0d RW  "DR05"  BitBlt source register (see #P0953)
9BD0d RW  "DR06"  BitBlt destination register (see #P0954)
9FD0d RW  "DR07"  BitBlt command register (see #P0955)

Bitfields for Chips&Technologies 64310 "DR00" BitBlt offset register:
Bit(s)	Description	(Table P0948)
 31-28	reserved (0)
 27-16	destination offset
 15-12	reserved (0)
 11-0	source offset

Bitfields for Chips&Technologies 64310 "DR01" BitBlt pattern ROP register:
Bit(s)	Description	(Table P0949)
 31-21	reserved (0)
 20-0	pattern pointer (must be pattern size aligned)
Note:	Do not read this register while BitBlt is active.

Bitfields for Chips&Technologies 64310 "DR02" BitBlt background color register:
Bit(s)	Description	(Table P0950)
 31-16	reserved (contents of bits 15-0 on read)
 15-0	background color for opaque mono-color expansions
	(all bits must be used; use same data in bits 15-8 and 7-0 for 8BPP)

Bitfields for Chips&Technologies 64310 "DR03" BitBlt foreground color register:
Bit(s)	Description	(Table P0951)
 31-16	reserved (contents of bits 15-0 on read)
 15-0	foreground color for mono-color expansions/color for solid paint
	  operations
	(all bits must be used; use same data in bits 15-8 and 7-0 for 8BPP)

Bitfields for Chips&Technologies 64310 "DR04" BitBlt control register:
Bit(s)	Description	(Table P0952)
 31-28	reserved (0)
 27-24	buffer status (number of dwords that can be written to the chip)
 23-21	reserved (0)
 20	BitBlt status (read-only)
	0 = idle
	1 = active (do not write BitBlt registers)
 19	0 = bitmap pattern
	1 = solid pattern (brush)
 18-16	pattern starting row
 15-14	BitBlt source (destination always video frame buffer)
	00 = video frame buffer
	01 = system memory
	1x = reserved
 13	background for monochrome pattern and font expansion
	0 = opaque (color in DR02)
	1 = transparent (unchanged)
 12	pattern depth
	0 = color
	1 = monochrome
 11	source depth
	0 = color
	1 = monochrome (font expansion only if bit 9 = 1)
 10	source data
	0 = selected by bit 14
	1 = foreground color reg (DR03)
 9	X direction (use when source and destination areas overlap)
	0 = decrement (right to left)
	1 = increment (left to right)
 8	Y direction (use when source and destination areas overlap)
	0 = decrement (bottom to top)
	1 = increment (top to bottom)
 7-0	raster operation (as defined by Windows)
SeeAlso: #P0953,#P0955

Bitfields for Chips&Technologies 64310 "DR05" BitBlt source register:
Bit(s)	Description	(Table P0953)
 31-21	reserved (0)
 20-0	source block address (must be byte aligned)
Note:	Do not read this register while BitBlt is active.
SeeAlso: #P0952,#P0954

Bitfields for Chips&Technologies 64310 "DR06" BitBlt destination register:
Bit(s)	Description	(Table P0954)
 31-21	reserved (0)
 20-0	destination block address (must be byte aligned)
Note:	Do not read this register while BitBlt is active.
SeeAlso: #P0953,#P0955

Bitfields for Chips&Technologies 64310 "DR07" BitBlt command register:
Bit(s)	Description	(Table P0955)
 31-28	reserved (0)
 27-16	lines per block
 15-12	reserved (0)
 11-0	bytes per line
SeeAlso: #P0953,#P0954
--------S-P83F883FF--------------------------
PORT 83F8-83FF - serial port, description same as 03F8
--------X-P840084FF--------------------------
PORT 8400-84FF - available for EISA slot 8
--------V-P86E886E9--------------------------
PORT 86E8-86E9 - 8514/A and compatible - CURRENT X POSITION
Desc:	define the column at which the first pixel of a line, rectangle, etc.
	  will be drawn; (Trio64) define the column at which the first of two
	  edges for a polygon or trapezoid will begin
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT 82E8h,PORT 8AE8h,86EAh

86E8w -W  drawing control: current X position (bits 11-0)
--------V-P86EA86EB--------------------------
PORT 86EA-86EB - S3 Trio64 - CURRENT X POSITION 2
Desc:	define the column at which the second of two edges for a polygon or
	  trapezoid will begin
SeeAlso: PORT 86E8h

86EAw RW  drawing control: current X position 2 (bits 11-0)
--------X-P880088FF--------------------------
PORT 8800-88FF - available for EISA slot 8
--------V-P8AE88AE9--------------------------
PORT 8AE8-8AE9 - 8514/A and compatible - DESTINATION Y POSITION
Desc:	define the top row of the destination for a BLT, the axial step
	  constant for a line, or the ending row of a line segment in a
	  polyline; (Trio64) define the ending row of the first edge drawn
	  for a polygon or trapezoid
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT 82E8h,PORT 86E8h

8AE8w -W  drawing control: destination Y position / axial step constant
	  (see #P0956)
Note:	this port may be read on S3 chipsets

Bitfields for 8514/A destination Y position / axial step constant register:
Bit(s)	Description	(Table P0956)
 11-0	destination Y position
 13-0	axial step constant for line drawing
 15-14	reserved
--------V-P8AEA8AEB--------------------------
PORT 8AEA-8AEB - S3 Trio64 - DESTINATION Y COORD 2 / AXIAL STEP CONSTANT 2
Desc:	define the row at which the second of two edges for a polygon or
	  trapezoid will end, or the axial step constant for the second of
	  two edges for a Bresenham trapezoid
SeeAlso: PORT 8AE8h

8AEAw RW  drawing control: destination Y position 2 / axial step constant 2
	  (see #P0956)
--------X-P8C008CFF--------------------------
PORT 8C00-8CFF - available for EISA slot 8
--------X-P8C808C83--------------------------
PORT 8C80-8C83 - EISA board product ID (board in slot 8)
SeeAlso: PORT 1C80h-1C83h
--------X-P8C84------------------------------
PORT 8C84 - EISA CONFIGURATION FLAGS (board in slot 8)

8C84  RW  configuration flags (see #P0938)
--------V-P8EE88EE9--------------------------
PORT 8EE8-8EE9 - 8514/A and compatible - DESTINATION X POSITION
Desc:	define the left column of the destination for a BLT, the diagonal step
	  constant for a line, or the ending column of a line segment in a
	  polyline; (Trio64) define the ending column of the first edge drawn
	  for a polygon or trapezoid
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT DAEEh"Mach32",PORT 8EEAh

8EE8w -W  drawing control: destination X position / axial step constant
	  (see #P0956)
--------V-P8EEA8EEB--------------------------
PORT 8EEA-8EEB - S3 Trio64 - DESTINATION X COORD 2 / AXIAL STEP CONSTANT 2
Desc:	define the column at which the second of two edges for a polygon or
	  trapezoid will end, or the axial step constant for the second of
	  two edges for a Bresenham trapezoid
SeeAlso: PORT 8EE8h

8EEAw RW  drawing control: destination X position 2 / diagonal step constant 2
	  (see #P0956)
--------V-P8EEE------------------------------
PORT 8EEE - ATI Mach32 - READ EXTENDED GRAPHICS CONFIGURATION
SeeAlso: PORT 72EEh

8EEE  R-  read extended graphics configuration (see #P0947)
--------X-P900090FF--------------------------
PORT 9000-90FF - available for EISA slot 9
--------V-P92E892E9--------------------------
PORT 92E8-92E9 - 8514/A and compatible - BRESENHAM ERROR TERM
Desc:	specify the initial error term for drawing a line using the Bresenham
	  algorithm
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
	the error term is 2*min(|dx|,|dy|) - max(|dx|,|dy|) - 1 [startX < endX]
	or 2*min(|dx|,|dy|) - max(|dx|,|dy|) [startX >= endX]
SeeAlso: PORT 92EAh

92E8w -W  drawing control: Bresenham error term (bits 13-0)
--------V-P92EA92EB--------------------------
PORT 92EA-92EB - S3 Trio64 - LINE ERROR TERM 2
Desc:	specify the initial error term for the second edge of a Bresenham
	  trapezoid
SeeAlso: PORT 92E8h

92EAw RW  drawing control: Bresenham error term 2 (bits 13-0)
--------X-P940094FF--------------------------
PORT 9400-94FF - available for EISA slot 9
--------V-P96E896E9--------------------------
PORT 96E8-96E9 - 8514/A and compatible - MAJOR AXIS PIXEL COUNT
Desc:	specify the pixel length of the longest axis of a line, or the width
	  of a rectangle, BLT, or image transfer; (Trio64) specify the major
	  axis length of the first edge of a Bresenham trapezoid
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
	the value programmed into this register is one less than the desired
	  width or major-axis length
SeeAlso: PORT 96EAh

96E8w R-  enter WD Enhanced Mode
96E8w -W  drawing control: major axis pixel count (bits 11-0)
--------V-P96EA96EB--------------------------
PORT 96EA-96EB - S3 Trio64 - MAJOR AXIS PIXEL COUNT 2
Desc:	specify the major axis length of the second edge for a Bresenham
	  trapezoid
Note:	the value programmed into this register is one less than the desired
	  width or major-axis length
SeeAlso: PORT 96E8h

96EAw RW  drawing control: major axis pixel count 2 (bits 11-0)
--------X-P980098FF--------------------------
PORT 9800-98FF - available for EISA slot 9
--------V-P9AE89AE9--------------------------
PORT 9AE8-9AE9 - 8514/A and compatible - GRAPHICS PROCESSOR STATUS / COMMAND
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT 9AEAh

9AE8w R-  drawing control: graphic processor status (see #P0957)
9AE8w -W  drawing control: command register (see #P0958)

Bitfields for 8514/A graphic processor status:
Bit(s)	Description	(Table P0957)
 15-10	(8514/A) reserved
 15	(S3 Trio64 only) queue status flags 9
 14-11	(S3 Trio64 only) queue status flags 10-13
 10	(S3 Trio64 only) all FIFO slots are empty
 9	hardware busy
 8	(8514/A) data ready
	(S3 Trio64) reserved
 7	queue status flag 1
 6-0	queue status flags 2-8 (0=empty, 1=filled)
	(each bit represents a position in queue)
Note:	queue status flag N is cleared whenever at least N slots are available
	  in the FIFO; at any given time, the CPU may write only as many values
	  to the FIFO as there are slots available
SeeAlso: #P0958

Bitfields for 8514/A command register :
Bit(s)	Description	(Table P0958)
 15-13	command (see #P0959)
 12	byte sequence (0=high byte first, 1=low byte first)
 11-10	(8514/A) reserved
 11	(S3 Trio) high bit of command (see #P0959)
 10	(S3 Trio) enable 32-bit write access
 9	enable 16-bit write access (16BIT)
 8	0=use 8514/A data, 1=pixel data trans reg (PCDATA) (see PORT E2E8h)
 7	0=draw vector above, 1=draw vector below (INC_Y)
 6	0=x is maj. axis, 1=y is maj. axis (YMAJAXIS)
 5	0=draw vector left, 1=draw vector right (INC_X)
	(bits 7-5 are the drawing direction in 45-degree increments
	  counterclockwise from the X axis when bit 3 is set)
 4	0=move only, 1=draw and move (DRAW)
 3	0=Bresenham line, 1=direct vector (LINETYPE)
 2	0=draw last pixel, 1=don't draw last pixel (LASTPIX)
 1	0=single pixel, 1=4pixel (PLANAR)
 0	0=read data, 1=write data (RD/WR) (must be 1 on S3 Trio)
SeeAlso: #P0957,#P0960

(Table P0959)
Values for 8514/A command:
 000	no operation (used to force synchronization with graphics processor,
	  or to set up short stroke vector drawing without writing any pixels)
 001	draw vector
 010	fast rectangle fill
 011	(8514/A) rectangle fill vertical #1
	(S3 Trio64) polygon fill solid
 100	(8514/A) rectangle fill vertical #2 (4 pixels)
	(S3 Trio64) 4-point trapezoid fill solid
 101	(8514/A) draw vector, 1 pixel/scanline
	(S3 Trio64) Bresenham trapezoid fill solid
 110	copy rectangle
 111	(8514/A) reserved
	(S3 Trio64) patterned BLT
---S3 Trio64---
 1001	polyline / 2-point line
 1011	polygon fill pattern
 1100	4-point trapezoid fill pattern
 1101	Bresenham trapezoid fill pattern
SeeAlso: #P0958
--------V-P9AEA9AEB--------------------------
PORT 9AEA-9AEB - S3 Trio64 - DRAWING COMMAND 2
Desc:	specify the drawing direction for the second edge of a Bresenham
	  trapezoid
SeeAlso: PORT 9AE8h

9AEAw -W  drawing command 2 (see #P0960)

Bitfields for S3 Trio64 Drawing Command 2 register:
Bit(s)	Description	(Table P0960)
 15-8	reserved
 7-5	drawing direction
	 7	0=draw vector above, 1=draw vector below (INC_Y)
	 6	0=x is maj. axis, 1=y is maj. axis (YMAJAXIS)
	 5	0=draw vector left, 1=draw vector right (INC_X)
 4-0	reserved
SeeAlso: #P0958
--------V-P9AEE------------------------------
PORT 9AEE - ATI Mach8/Mach32 - LINEDRAW INDEX REGISTER
SeeAlso: PORT FEEEh

9AEE  -W  linedraw index register (specifies interpretation of PORT FEEEh)
	  (see #P0961)

(Table P0961)
Values for ATI Mach8/Mach32 Linedraw Index Register:
 00h	set current X
 01h	set current Y
 02h	set Line End X
 03h	set Line End Y, draw line, and reset register to 02h
 04h	set current X (perform moves instead of draws)
 05h	set current Y and reset register to 04h
--------X-P9C009CFF--------------------------
PORT 9C00-9CFF - available for EISA slot 9
--------X-P9C809C83--------------------------
PORT 9C80-9C83 - EISA board product ID (board in slot 9)
SeeAlso: PORT 1C80h-1C83h
--------X-P9C84------------------------------
PORT 9C84 - EISA CONFIGURATION FLAGS (board in slot 9)

9C84  RW  configuration flags (see #P0938)
--------V-P9EE89EE9--------------------------
PORT 9EE8-9EE9 - 8514/A and compatible - SHORT STROKE VECTORS
Desc:	specify two short-stroke vectors to be drawn one after the other
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
	bit 12 of the command register (see PORT 9AE8h,#P0958) specifies which
	  vector is drawn first

9EE8w -W  short line vector transfer (see #P0962)

Bitfields for 8514/A short-stroke vector:
Bit(s)	Description	(Table P0962)
 15-13	second vector: drawing direction
 12	second vector: draw/move
 11-0	second vector: length in pixels (less 1)
 7-5	first vector: drawing direction
	000  zero degrees = right
	001  45 degress = up and right
	010  90 degrees = up
	...
	111 315 degrees = down and right
 4	first vector: draw/move (=0 move only, =1 draw and move)
 3-0	first vector: length in pixels (less 1)
--------S-PA220------------------------------
PORT A220 - soundblaster support in AMI Hi-Flex BIOS  ????
----------PA2E0A2EF--------------------------
PORT A2E0-A2EF - GPIB (General Purpose Interface Bus, IEEE 488 interface)

A2E1  RW  GPIB (adapter 5)
--------V-PA2E8A2EB--------------------------
PORT A2E8-A2EB - 8514/A and compatible - BACKGROUND COLOR
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT A6E8h

A2E8w -W  drawing control: background color
A2E8d RW  (S3) drawing control: 32bpp background color
--------V-PA2EEA2EF--------------------------
PORT A2EE-A2EF - ATI Mach8/Mach32 - LINE DRAW OPTIONS
SeeAlso: PORT 8EEEh,PORT CEEEh

A2EEw RW  line drawing options (see #P0963)

Bitfields for ATI Mach8/Mach32 line drawing options:
Bit(s)	Description	(Table P0963)
 10-9	clipping mode
	00 disable clip exception
	01 stroked plain lines
	10 polygon boundary lines
	11 patterned lines
 8	reset all Bounds Accumulator registers
 7-5	OCTANT: direction for BitBlts or lines
 3	direction specification
	0 = Bresenham/Octant
		bit 7: increment Y
		bit 6: Y is major axis instead of X
		bit 5: increment X
	1 = line-length and degrees
		OCTANT field species N*45 degrees
 2	do NOT draw last pixel of a line
 1	polyline draw
----------PA3D0BFD3--------------------------
PORT A3D0-BFD3 - Chips&Techs 64310 - 32-BIT EXTENSION REGS - CURSOR CONTROL
Notes:	All ports are word or dword accessible.
	These registers are also accessible in the upper 2 MB of the 4 MB
	  linear memory frame buffer (address specified in PCI configuration
	  registers).
SeeAlso: PORT 03D6h"Chips",PORT 83D0h"Chips"

A3D0d RW  "DR08"  cursor control register (see #P0964)
A7D0d RW  "DR09"  cursor color register (see #P0965)
ABD0d --  "DR0A"  reserved
AFD0d RW  "DR0B"  cursor position register (see #P0966)
B3D0d RW  "DR0C"  cursor base address (see #P0967)
B7D0d --  "DR0D"  reserved
BBD0d --  "DR0E"  reserved
BFD0d --  "DR0F"  reserved

Bitfields for Chips&Technologies 64310 "DR08" cursor control register:
Bit(s)	Description	(Table P0964)
 31-8	reserved (0)
 7-6	test (must be 0)
 5	upper left corner (ULC) select
	(all x, y positioning is relative to selected ULC)
	0 = active display (BLANK#) (cursor can be positioned in overscan
	  area)
	1 = display enable (cursor cannot be positioned to overscan area)
 4-2	reserved (must be 0)
 1-0	hardware cursor enable
	00 = disable
	01 = 32x32 cursor enable
	10 = 64x64 cursor enable
	11 = illegal/reserved

Bitfields for Chips&Technologies 64310 "DR09" cursor color register:
Bit(s)	Description	(Table P0965)
 31-27	cursor color 1 red
 26-21	cursor color 1 green
 20-16	cursor color 1 blue
 15-11	cursor color 0 red
 10-5	cursor color 0 green
 4-0	cursor color 0 blue
SeeAlso: #P0966,#P0967

Bitfields for Chips&Technologies 64310 "DR0B" cursor position register:
Bit(s)	Description	(Table P0966)
 31	Y sign
 30-27	reserved (0)
 26-16	cursor position Y offset from ULC (DR08 bit 5)
 15	X sign
 14-11	reserved (0) (ignored)
 10-0	cursor position X offset from ULC (DR08 bit 5)
SeeAlso: #P0965,#P0967

Bitfields for Chips&Technologies 64310 "DR0C" cursor base address:
Bit(s)	Description	(Table P0967)
 31-21	reserved (0)
 20-10	base address for cursor data in display memory
	(cursor data must be at 1K boundary in off-screen memory)
 9-0	reserved (0)
SeeAlso: #P0965,#P0966
--------V-PA6E8A6EB--------------------------
PORT A6E8-A6EB - 8514/A and compatible - FOREGROUND COLOR
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT A2E8h,PORT AAE8h,PORT AEE8h

A6E8w -W  drawing control: foreground color
A6E8d RW  (S3) drawing control: foreground color for 32bpp modes
--------V-PAAE8AAEB--------------------------
PORT AAE8-AAEB - 8514/A and compatible - WRITE MASK
Desc:	specify which bit planes are updates when a pixel is written
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT A6E8h,PORT AEE8h

AAE8w -W  drawing control: write mask
AAE8d RW  (S3) drawing control: write mask for 32bpp modes
--------V-PAEE8AEEB--------------------------
PORT AEE8-AEEB - 8514/A and compatible - READ MASK
Desc:	specify which bit planes are used as a data source
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT AAE8h,PORT B2E8h

AEE8w -W  drawing control: read mask
AEE8d RW  (S3) drawing control: read mask for 32bpp modes
--------V-PAFFF------------------------------
PORT AFFF - VIDEO REGISTER

AFFF  RW  plane 0-3 system latch (video register)
--------S-PB220B227--------------------------
PORT B220-B227 - serial port, description same as 03F8
--------S-PB228B22F--------------------------
PORT B228-B22F - serial port, description same as 03F8
--------V-PB2E8B2EB--------------------------
PORT B2E8-B2EB - 8514/A and compatible - COLOR COMPARE
Notes:	supported by ATI Graphics Ultra
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT B6E8h,PORT BAE8h,PORT BEE8h

B2E8w -W  drawing control: color compare
B2E8d RW  (S3) drawing control: color compare for 32bpp modes
--------V-PB2EE------------------------------
PORT B2EE - ATI Mach32 - ???

B2EEw RW  ???
--------V-PB6E8B6E9--------------------------
PORT B6E8-B6E9 - 8514/A and compatible - BACKGROUND MIX
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT BAE8h,PORT BEE8h,PORT B2E8h

B6E8w -W  drawing control: background mix (see #P0968)
Note:	this register may be read on S3 chipsets
--------V-PB6EE------------------------------
PORT B6EE - ATI Mach32 - ???

B6EEw RW  ???
--------V-PBAE8BAE9--------------------------
PORT BAE8-BAE9 - 8514/A and compatible - FOREGROUND MIX
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT B6E8h

BAE8w -W  drawing control: foreground mix (see #P0968)
Note:	this register may be read on S3 chipsets

Bitfields for 8514/A color mix register:
Bit(s)	Description	(Table P0968)
 15-7	reserved
 6-5	color source
	00 background color
	01 foreground color
	10 CPU data
	11 display memory
 4	reserved
 3-0	mix type
	0000 negate current color
	0001 logical zero
	0010 logical one
	0011 leave unchanged
	0100 negate new color
	0101 current XOR new
	0110 negate (current XOR new)
	0111 new color
	1000 (NOT current) OR (NOT new)
	1001 current OR (NOT new)
	1010 (NOT current) OR new
	1011 current OR new
	1100 current AND new
	1101 (NOT current) AND new
	1110 current AND (NOT new)
	1111 (NOT current) AND (NOT new)
--------V-PBAEE------------------------------
PORT BAEE - ATI Mach32 - ???

BAEEw RW  ???
--------V-PBEE8BEE9--------------------------
PORT BEE8-BEE9 - 8514/A and compatible - MULTIFUNCTION CONTROL
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
	writes to the registers accessed via this port are pipelined; a NOP
	  command (see PORT 9AE8h) is required to ensure correct read-back
	  immediately after a write

BEE8w -W  drawing control: multi-function control (see #P0970)
BEE8w R-  (S3) value of register specified by current value of multi-function
	  read select register (index 0Fh bits 3-0) (see #P0970)

(Table P0969)
Values for index into 8514/A multi-function drawing control registers:
 00h RW minor axis pixel count
 01h RW top scissors
 02h RW left scissors
 03h RW bottom scissors
 04h RW right scissors
 05h -W memory control register
 08h -W fixed pattern low
 09h -W fixed pattern high
 0Ah RW data manipulation control
---S3 chipsets---
 0Dh RW (S3 864/964) miscellaneous 2
 0Eh RW (S3 801+) miscellaneous
 0Fh -W (S3 801/805/928) read register select (see #P0971)
SeeAlso: #P0970

Bitfields for 8514/A Multi-Function Control registers:
Bit(s)	Description	(Table P0970)
 15-12	register index (see #P0969)
---register 00h: minor axis pixel count---
 11-0	rectangle height - 1
---register 01h: top scissors---
 11-0	top edge of clipping box
---register 02h: left scissors---
 11-0	left edge of clipping box
---register 03h: bottom scissors---
 11-0	bottom edge of clipping box
---register 04h: right scissors---
 11-0	right edge of clipping box
---register 05h: memory control---
 ???
---register 08h: fixed pattern low---
 11-8	(S3 Trio32/64) reserved
 7-6	mix register
	00 always select Foreground Mix register
	01 reserved
	10 mix register selected by CPU data
	11 mix register selected by display memory value
 5-0	(S3 Trio32/64) reserved
---register 09h: fixed pattern high---
 ???
---register 0Ah: data manipulation control---
 ???
---register 0Dh: miscellaneous 2---
 11-7	reserved
 6-4	source base address
	000 in first meg of display memory
	001 in second meg
	010 in third meg
	011 in fourth meg
 3	reserved
 2-0	destination base address (settings as for bits 6-4)
---register 0Eh: miscellaneous---
 11-10	reserved (0)
 9	select 32-bit command registers; disable byte and word writes to regs
	(see PORT A2E8h,PORT A6E8h,PORT AAE8h,PORT B2E8h)
 8	enable color comparison
 7	don't update bitmap if source color differs from Color Compare register
	  (see PORT B2E8h)
 6	slow Graphics Engine read/modify/write cycle (adds one wait state)
 5	clipping direction
	=0 draw only inside clip rectangle
	=1 draw only outside clip rectangle
 4	select upper 16 bits of 32-bit registers in 32 bpp graphics mode
 3-2	source base address, bits 21-20
 1-0	destination base address, bits 21-20
	Note:	these base addresses are ignored if the corresponding base
		  address in register 0Dh is nonzero
---register 0Fh: multifunction read select---
 11-4	reserved
 3-0	(S3)	read select (see #P0971)
 2-0	(8514/A) read select (see #P0971)

(Table P0971)
Values for S3 multifunction read select register:
 00h	PORT BEE8h register 00h
 01h	PORT BEE8h register 01h
 02h	PORT BEE8h register 02h
 03h	PORT BEE8h register 03h
 04h	PORT BEE8h register 04h
 05h	PORT BEE8h register 0Ah
 06h	PORT BEE8h register 0Eh
 07h	PORT 9AE8h (bits 11-0 only)
---S3 864/964 only---
 08h	PORT 42E8h (bits 11-0 only)
 09h	PORT 46E8h
 0Ah	PORT BEE8h register 0Dh
SeeAlso: #P0969,#P0970
--------X-PC000CFFF--------------------------
PORT C000-CFFF - PCI Configuration Mechanism 2 - CONFIGURATION SPACE
Note:	to access the configuration space, write the target bus number to
	  PORT 0CFAh, then write to the Configuration Space Enable register
	  (PORT 0CF8h), and finally read or write the appropriate I/O
	  port(s) in the range C000h to CFFFh (where Cxrrh accesses location
	  'rr' in physical device 'x's configuration data)
SeeAlso: PORT 0CF8h"Mechanism 2",PORT 0CFAh"Mechanism 2"
SeeAlso: #00857 at INT 1A/AX=B10Ah
--------d-PC100C1FF--------------------------
PORT C100-C1FF - Intel Pentium mboard - PCTech RZ1000 EIDE controller
Desc:	the PCI configuration registers for the EIDE controller are visible
	  on these ports when the PCI configuration space has been opened via
	  ports 0CF8h and 0CFAh
SeeAlso: PORT 03F0h"RZ1000",PORT 0CF8h,#00857 at INT 1A/AX=B10Ah
----------PC200C204--------------------------
PORT C200-C204 - Intel Pentium mboard ("Neptune" chipset)
Desc:	the PCI configuration registers for the motherboard chipset are visible
	  on these ports when the PCI configuration space has been opened via
	  ports 0CF8h and 0CFAh
SeeAlso: #00857 at INT 1A/AX=B10Ah
--------S-PC220C227--------------------------
PORT C220-C227 - serial port, description same as 03F8
--------S-PC228C22F--------------------------
PORT C228-C22F - serial port, description same as 03F8
----------PC244------------------------------
PORT C244 - Intel Pentium mboard ("Neptune" chipset)
----------PC2E0C2EF--------------------------
PORT C2E0-C2EF - GPIB (General Purpose Interface Bus, IEEE 488 interface)

C2E1  RW  GPIB (adapter 6)
--------V-PC2EE------------------------------
PORT C2EE - ATI Mach32 - ???

C2EEw RW  ???
--------V-PC6EE------------------------------
PORT C6EE - ATI Mach32 - SHORT-STROKE VECTOR

C6EEw -W  short-stroke vector
--------V-PCAEE------------------------------
PORT CAEE - ATI Mach32 - ???

CAEEw RW  ???
----------PCEEE------------------------------
PORT CEEE - ATI Mach8/Mach32 - DATAPATH CONFIGURATION
SeeAlso: PORT 8EEEh

CEEEw -W  datapath configuration (see #P0972)

Bitfields for ATI Mach8/Mach32 datapath configuration:
Bit(s)	Description	(Table P0972)
 15-13	foreground color source
	000 background color reg
	001 foreground color reg
	010 pixel transfer reg
	011 VRAM BitBlt source
	101 color pattern shift register
 12	least-significant byte first
 9	data width is 16 bits instead of 8 bits
 8-7	background color source
	00 background color reg
	01 foreground color reg
	10 pixel transfer reg
	11 VRAM BitBlt source
 6-5	monochrome data source
	00 always one
	01 mono pattern register
	10 pixel transfer register
	11 VRAM BitBlt source
 4	enable drawing
 2	read color data instead of monochrome data
 1	enable polygon fill BitBlt
 0	write data to drawing trajectory instead of reading from trajectory
--------S-PD220D227--------------------------
PORT D220-D227 - serial port, description same as 03F8
SeeAlso: PORT 03F8h,PORT D228h
--------S-PD228D22F--------------------------
PORT D228-D22F - serial port, description same as 03F8
SeeAlso: PORT 03F8h,PORT D220h
--------V-PD2EE------------------------------
PORT D2EE - ATI Mach32 - ???

D2EEw RW  ???
--------V-PDAEEDAEF--------------------------
PORT DAEE-DAEF - ATI Mach8/Mach32 - SCISSORS REGION (LEFT)
SeeAlso: PORT 8EE8h,PORT DEEEh"SCISSORS",PORT E2EEh"SCISSORS"
SeeAlso: PORT E6EEh"SCISSORS"

DAEEw -W  left edge of "scissors" drawing area (bits 11-0)
--------V-PDEEEDEEF--------------------------
PORT DEEE-DEEF - ATI Mach8/Mach32 - SCISSORS REGION (TOP)
SeeAlso: PORT DAEEh"SCISSORS",PORT E2EEh"SCISSORS",PORT E6EEh"SCISSORS"

DEEEw -W  top edge of "scissors" drawing area (bits 11-0)
----------PE2E0E2EF--------------------------
PORT E2E0-E2EF - GPIB (General Purpose Interface Bus, IEEE 488 interface)

E2E1  RW  GPIB (adapter 7)
--------V-PE2E8E2E9--------------------------
PORT E2E8-E2E9 - 8514/A and compatible - PIXEL DATA TRANSFER
Desc:	all graphics data to be processed by the Graphics Engine is sent
	  through this port
Notes:	supported by ATI Graphics Ultra
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set

E2E8w -W  drawing control: pixel data transfer
E2EAw rW  drawing control: pixel data transfer (S3 801+) for 32-bit transfers
--------V-PE2EEE2EF--------------------------
PORT E2EE-E2EF - ATI Mach8/Mach32 - SCISSORS REGION (BOTTOM)
SeeAlso: PORT DAEEh"SCISSORS",PORT DEEEh"SCISSORS",PORT E6EEh"SCISSORS"

E2EEw -W  bottom edge of "scissors" drawing area (bits 11-0)
--------V-PE6EEE6EF--------------------------
PORT E6EE-E6EF - ATI Mach8/Mach32 - SCISSORS REGION (RIGHT)
SeeAlso: PORT DAEEh"SCISSORS",PORT DEEEh"SCISSORS",PORT E2EEh"SCISSORS"

E6EEw -W  right edge of "scissors" drawing area (bits 11-0)
--------V-PEAE8EAEB--------------------------
PORT EAE8-EAEB - S3 Trio64 - PATTERN
Desc:	define the position of the top-left corner of an 8x8 pixel pattern
	  stored in off-screen memory which is to be used for patterned fill
	  commands (trapezoid, polygon, etc.)

EAE8w RW  pattern Y coordinate (bits 11-0)
EAEAw RW  pattern X coordinate (bits 11-0)
--------V-PFAEE------------------------------
PORT FAEE - ATI Mach32 - CHIP IDENTIFICATION REGISTER
SeeAlso: PORT 56EEh"Mach32",PORT 5EEEh"Mach32"
--------V-PFEEEFEEF--------------------------
PORT FEEE-FEEF - ATI Mach8/Mach32 - DIRECT LINE DRAW REGISTER
SeeAlso: PORT 9AEEh

FEEEw -W  direct line-draw register
--------d-Pxxxx------------------------------
PORT xxxx - Future Domain TMC-3260 PCI SCSI adapter
Range:	anywhere on 8 byte boundary???
Note:	Future Domain TMC-3260 PCI SCSI adapter is based upon Future Domain
	  TMC-36C70 SCSI controller which is a PCI version of the TMC-18C30
	  ISA SCSI controller
SeeAlso: PORT 0140h-014Fh"Future Domain TMC-16x0"
--------d-Pxxxx------------------------------
PORT xxxx - AMD Am53C974A PC-SCSI II SCSI adapter
Range:	anywhere, on a 128-port boundary
SeeAlso: #00904

+000  R-  current transfer count register (low)
+000  -W  start transfer count register (low)
+004  R-  current transfer count register (middle)
+004  -W  start transfer count register (middle)
+008  RW  SCSI FIFO register
+00C  RW  SCSI command register
+010  R-  SCSI status register
+010  -W  destination ID
+014  R-  interrupt status
+014  -W  SCSI timeout
+018  R-  internal state
+018  -W  synchronous transfer period
+01C  R-  current FIFO/internal state
+01C  -W  synchronous offset
+020  RW  control register 1
+024  -W  clock factor
+028  -W  reserved
+02C  RW  control register 2
+030  RW  control register 3
+034  RW  control register 4
+038  R-  current transfer count register (high) / ID code
+038  -W  start current transfer count (high)
+03C	  reserved
+040  RW  DMA command
+044d RW  DMA starting transfer count (bits 23-0)
+048d RW  DMA starting physical address
+04C  R	  DMA working byte counter
+050d R	  DMA working address counter
+054  R	  DMA status register
+058d RW  DMA starting memory descriptor list address
+05Cd R	  DMA working memory descriptor list counter
+070d Rw  SCSI bus and control (bits 25-24 and 21-0)
Notes:	the SCSI registers are mapped on DWORD boundaries, even though for most
	  only the least-significant byte is used
	see "Am53C974A PCscsi(tm) II Technical Manual, Revision 1.0"
	  (file 19113A.PDF) for further details, as well as (file 19084A.PDF)
--------d-Pxxxx------------------------------
PORT xxxx - Adaptec AHA-2920 PCI SCSI adapter
Range:	anywhere on 8 byte boundary???
Note:	Adaptec AHA-2920 PCI SCSI adapter is based upon Future Domain TMC-36C70
	  SCSI controller which is a PCI version of Future Domain TMC-18C30 ISA
	  SCSI controller
SeeAlso: PORT 0140h-014Fh"Future Domain TMC-16x0"
--------p-Pxxxx------------------------------
PORT xxxx - AMD-645 - Power Management Registers
Range:	on any 256-byte boundary
SeeAlso: #01028

+000w RC  power management status (see #P0973)
+002w RW  power management enable (see #P0974)
+004w RW  power management control (see #P0975)
+006	  unused???
+008d RW  power management timer (24 or 32 bits)
+00C	  unused???
+010d RW  processor power management control (see #P0976)
+014  R-  "P_LVL2" processor level 2 -- reading switches to C2 power state
+015  R-  "P_LVL3" processor level 3 -- reading switches to C3 power state
+016	  unused???
+020w RC  general purpose status (see #P0977)
+022w RW  general purpose SCI enable (see #P0978)
+024w RW  general purpose SMI enable (see #P0979)
+026w RW  power supply control (see #P0980)
+028w RC  global power management status (see #P0981)
+02Aw RW  global power management enable (see #P0982)
+02Cw RW  global power management control (see #P0983)
+02E	  unused???
+02F  RW  SMI command
	writing this port sets the SW_SMI_STS bit (see #P0981,#P0982)
+030d RC  primary activity detection status (see #P0984)
+034d RW  primary activity detection enable (see #P0985)
+038d RW  general purpose timer reload enable (see #P0986)
+03C	  unused???
+040  RW  control of general-purpose I/O direction (see #P0987)
+041	  ???
+042  RW  output value for GPIO port (see #P0988)
+043  RW  ???
+044  RW  input value for GPIO port (see #P0989)
+045  RW  ???
+046w RW  output value for general-purpose output port
+048w RW  input value for general-purpose input port

Bitfields for AMD-645 Power Management Control Status:
Bit(s)	Description	(Table P0973)
 15	wakeup request -- system will transition from suspend to normal working
 14-12	reserved (0)
 11	power button override (set when PWRBTN# asserted for more than 4 sec)
	system will transition into "soft off" power state
 10	RTC alarm occurred
 9	reserved (0)
 8	"PB_STS" power button -- PWRBTN# asserted (but for less than 4 sec)
 7-6	reserved (0)
 5	"GBL_STS" Global Status
	set by hardware when "BIOS_RLS" set; "BIOS_RLS" cleared by hardware
	  when this bit cleared
 4	system bus requested by any bus master
 3-1	reserved (0)
 0	ACPI timer carried into highest bit
Note:	all bits are write-clear: write a 1 bit to acknowledge the
	  status and clear that bit
SeeAlso: #P0974,MEM xxxxh:xxx0h"ACPI"

Bitfields for AMD-645 Power Management Enable register:
Bit(s)	Description	(Table P0974)
 15-11	reserved (0)
 10	enable SCI/SMI on RTC alarm
 9	reserved (0)
 8	enable SCI/SMI when PB_STS set (see #P0973 bit 8)
 7-6	reserved
 5	enable SCI/SMI when GBL_STS set (see #P0973 bit 5)
 4-1	reserved
 0	enable SCI/SMI when ACPI timer carries
SeeAlso: #P0973,#P0975,MEM xxxxh:xxx0h"ACPI"

Bitfields for AMD-645 Power Management Control register:
Bit(s)	Description	(Table P0975)
 15-14	reserved (0)
 13	(write) force transition into sleep state (bits 12-10) when set
	(read) always 0
 12-10	sleep type
	000 "soft off" (suspend-to-disk)
	010 power-on suspend
	0x1 reserved
	1xx reserved
 9-3	reserved
 2	"GLB_RLS" release SCI/SMI lock
	when set, BIOS_STS bit set by hardware; when BIOS_STS cleared,
	  hardware clears this bit
 1	enable transition from suspend to normal working state on bus master
	  request
 0	power management event interrupt type
	0 generate SMI
	1 generate SCI
SeeAlso: #P0973,#P0974

Bitfields for AMD-645 Processor Power Management Control register:
Bit(s)	Description	(Table P0976)
 31-5	reserved (0)
 4	enable clock throttling
	0 = suspend processor on reading P_LVL2 port at offset 14h
	1 = throttle clock by modulating STPCLK# on reading P_LVL2
 3-1	throttling duty cycle (proportion of time STPCLK# is asserted)
	000 reserved
	001 0 - 1/8
	010 1/8 - 2/8
	...
	111 6/8 - 7/8
 0	reserved (0)
SeeAlso: #P0975,#P0976

Bitfields for AMD-645 General Purpose Status register:
Bit(s)	Description	(Table P0977)
 15-10	reserved (0)
 9	"USB_STS"	USB peripheral generated resume event
 8	"RI_STS"	ring detected (RI# asserted)
 7	"EXT7_STS"	EXTSMI7# pin toggled
 6-0	"EXT?_STS"	EXTSMI6# - EXTSMI0# pins toggled
SeeAlso: #P0975,#P0978

Bitfields for AMD-645 General Purpose SCI Enable register:
Bit(s)	Description	(Table P0978)
 15-10	reserved (0)
 9	enable SCI when USB_STS bit becomes set
 8	enable SCI when RI_STS bit becomes set
 7-0	enable SCI when EXT?_STS bit becomes set
SeeAlso: #P0977,#P0979

Bitfields for AMD-645 General Purpose SMI Enable register:
Bit(s)	Description	(Table P0979)
 15-10	reserved (0)
 9	enable SMI when USB_STS bit becomes set
 8	enable SMI when RI_STS bit becomes set
 7-0	enable SMI when EXT?_STS bit becomes set
SeeAlso: #P0977,#P0978,#P0980

Bitfields for AMD-645 Power Supply Control register:
Bit(s)	Description	(Table P0980)
 15-11	reserved (0)
 10	enable setting of RI_STS bit to turn on power
 9	set PB_STS bit to resume from suspend
 8	set RTC_STS bit to resume from suspend on RTC alarm
 7-1	reserved (0)
 0	enable setting of EXT0_STS bit to resume from suspend
SeeAlso: #P0977,#P0981,#P0982

Bitfields for AMD-645 PM Global Status register:
Bit(s)	Description	(Table P0981)
 15-7	reserved (0)
 6	"SW_SMI_STS" SMI_CMD port has been written
 5	"BIOS_STS" set whenever GLB_RLS bit is set; GLB_RLS is cleared when
	  this bit is cleared
 4	legacy USB event occurred
 3	GP1 timer timed out
 2	GP0 timer timed out
 1	secondary event timer timed out
 0	"PACT_STS" an enabled primary system activity has occurred (see #P0985)
Note:	this register is write-clear: writing a 1 to a bit clears that bit
SeeAlso: #P0980

Bitfields for AMD-645 PM Global Enable register:
Bit(s)	Description	(Table P0982)
 15-7	reserved (0)
 6	enable SMI when SMI_CMD port is written
 5	enable SMI when BIOS_STS bit set (see #P0981)
 4	enable SMI on legacy USB events
 3	enable SMI when GP1 timer times out
 2	enable SMI when GP0 timer times out
 1	enable SMI when secondary event timer times out
 0	enable SMI on occurrence of any primary activity
SeeAlso: #P0980,#P0981,#P0983

Bitfields for AMD-645 PM Global Control ("GLB_CTL") register:
Bit(s)	Description	(Table P0983)
 15-9	reserved
 8	SMI is active
 7-5	reserved
 4	SMI lock enabled (write-clear)
	(must be cleared before bit 8 can be cleared and the next SMI allowed)
 3	reserved
 2	type of power button triggering
	0 generate SCI/SMI on PWRBTN# asserted
	1 generate SCI/SMI when PWRBTN# becomes deasserted
	(must be clear to comply with ACPI v0.9, but setting it avoids the
	  situation where holding the power button for four seconds first wakes
	  the system and then puts it into the soft-off state)
 1	"BIOS_RLS" used by legacy software to release the SCI/SMI lock; when
	  set, the GBL_STS bit is set by hardware; when GBL_STS is cleared,
	  this bit is cleared by hardware
 0	enable SMI generation
SeeAlso: #P0980,#P0981,#P0982,MEM xxxxh:xxx0h"ACPI"

Bitfields for AMD-645 PM Primary Activity Detect Status register:
Bit(s)	Description	(Table P0984)
 31-8	reserved (0)
 7	keyboard controller accessed via PORT 0060h
 6	serial port accessed (via PORT 03F8h-03FFh, 02F8h-02FFh, 03E8h-03EFh,
	  or PORT 02E8h-02EFh)
 5	parallel port accessed (via PORT 0278h-027Fh or PORT 0378h-037Fh)
 4	video controller accessed
 3	IDE or Floppy controller accessed
 2	reserved (0)
 1	a primary interrupt occurred (see #01028 [offset 44h])
 0	ISA busmaster or DMA activity occurred
Note:	this register is write-clear: write a 1 to a bit to clear it
SeeAlso: #P0985,#P0983

Bitfields for AMD-645 PM Primary Activity Detect Enable register:
Bit(s)	Description	(Table P0985)
 31-8	reserved (0)
---set PACT_STS (see #P0981) whenever:
 7	keyboard controller is accessed via PORT 0060h
 6	serial port is accessed (via PORT 03F8h-03FFh, 02F8h-02FFh,
	  PORT 03E8h-03EFh, or PORT 02E8h-02EFh)
 5	parallel port is accessed (via PORT 0278h-027Fh or PORT 0378h-037Fh)
 4	video controller is accessed
 3	IDE or Floppy controller is accessed
 2	reserved (0)
 1	a primary interrupt occurrs (see #01028 [offset 44h])
 0	ISA busmaster or DMA activity occurrs
SeeAlso: #P0984,#P0983

Bitfields for AMD-645 GP Timer Reload Enable register:
Bit(s)	Description	(Table P0986)
 31-8	reserved (0)
 7	reload GP1 whenever keyboard controller is accessed
 6	reload GP1 whenever a serial port is accessed
 5	reserved (0)
 4	reload GP1 whenever video controller is accessed
 3	reload GP1 whenever IDE or floppy controller is accessed
 2-1	reserved (0)
 0	reload GP0 whenever a primary activity is detected
SeeAlso: #P0985,#P0984

Bitfields for AMD-645 GPIO Direction Control register:
Bit(s)	Description	(Table P0987)
 7-5	reserved (0)
 4	direction of GPIO4 (0 = input, 1 = output)
	this bit sets Pin136, which is always output if configured as GPO_WE#
 3	direction of GPIO3 (0 = input, 1 = output)
	this bit sets Pin92, which is always an output if configured as GPI_RE#
 2	direction of GPIO2/I2CD1 (0 = input, 1 = output)
 1	direction of GPIO1/I2CD2 (0 = input, 1 = output)
 0	direction of GPIO0 (0 = input, 1 = output)
SeeAlso: #P0985,#P0988

Bitfields for AMD-645 GPIO Port Output Value register:
Bit(s)	Description	(Table P0988)
 7-5	reserved
 4	value for GPIO4 pin (ignored if pin configured as GPO_WE#)
 3	value for GPIO3 pin (ignored if pin configured as GPI_RE#)
 2	value for GPIO2/I2CD1 pin
 1	value for GPIO1/I2CD2 pin
 0	value for GPIO0 pin
Note:	while these bits can be read back, they only indicate the values which
	  are driven onto the pins if configured for output; to read the actual
	  input values, use the "input value" register at offset 44h
	  (see #P0989)
SeeAlso: #P0989

Bitfields for GPIO Port Input Value (EXTSMI_VAL) register:
Bit(s)	Description	(Table P0989)
 7	(if GPIO3 set to input) current EXTSMI7# on XD7 (Pin122)
 6	(if GPIO3 set to input) current EXTSMI6# on XD6 (Pin121)
 5	(if GPIO3 set to input) current EXTSMI5# on XD5 (Pin119)
 4	(if GPIO4 set to input) current EXTSMI4# on XD4 (Pin118)
	(if GPIO4 set to output) current EXTSMI4# on GPIO4 (Pin136)
 3	(if GPIO3 set to input) current EXTSMI3# on XD3 (Pin117)
	(if GPIO3 set to output) current EXTSMI3# on GPIO3 (Pin92)
 2	GPIO2 input value
 1	GPIO1 input value
 0	GPIO0 input value
SeeAlso: #P0988
--------X-Pxxxx------------------------------
PORT xxxx - AMD-645 - USB
SeeAlso: #01025 at INT 1A/AX=B10Ah/SF=1106h
Note:	further details are supposedly in the UHCI v1.1 standard

+000w ?W  USB command
+002w R?  USB status
+004w ?W  USB interrupt enable
+006w ??  frame number
+008d ??  frame list base address
+00C  ??  Start of Frame Modify
+00D	unused???
+010w RW  Port 1 Status/Control
+012w RW  Port 2 Status/Control
----------Pxxxx------------------------------
PORT xxxx - Ensoniq AudioPCI ES1370 - CONTROL REGISTERS
Range:	anywhere on 64 byte boundary

+000d RW  interrupt/chip select control register (see #P0990)
+004d R-  interrupt/chip select status register (see #P0991)
+008  RW  UART data register (MIDI data)
+009  -W  UART control register (see #P0992)
+009  R-  UART status register (see #P0993)
+00A  RW  UART reserved register (see #P0994)
+00Cd RW  memory page register (see #P0995)
+010d -W  CODEC write register (see #P0996)
+020d RW  serial interface control register (see #P0997)
+024d RW  DAC1 channel sample count register (see #P0998)
+028d RW  DAC2 channel sample count register (see #P0998)
+02Cd RW  ADC channel sample count register (see #P0998)
+030d RW  internal memory 1 (see #P0999)
+034d RW  internal memory 2 (see #P1000)
+038d RW  internal memory 3 (see #P1001)
+03Cd RW  internal memory 4 (see #P1002)

Bitfields for Ensoniq ES1370/ES1371 interrupt/chip select control register:
Bit(s)	Description	(Table P0990)
---AudioPCI ES1370---
 31	record buffer transfer disable (ADC stop)
 30	(bit 0 = 0) general purpose output
	(bit 0 = 1) external IRQ output
 29	reserved
 28-16	programmable clock divide ratio (DAC2)
---AudioPCI-97 ES1371---
 31-26	reserved
 25-24	joystick base I/O address
	00 = 200h
	01 = 208h
	10 = 210h
	11 = 218h
 23-20	GPIO pin 3-0 (read-only)
 19-16	GPIO pin 3-0 output
------
 15	MPEG data format
	0 = Sony (lrclk high = left channel; data left justified)
	1 = I2S (lrclk low = left channel; data 1 bit clock delayed)
---AudioPCI ES1370---
 14	CODEC DAC (DAC2) source
	0 = programmable clock generator
	1 = MPEG clocks
 13-12	fixed frequency clock generator frequency (DAC1)
	00 = 5.512 KHz
	01 = 11.025 KHz
	10 = 22.05 KHz
	11 = 44.1 KHz
 11	CODEC DACs synchronous with fixed frequency clock generator
---AudioPCI-97 ES1371---
 14	AC97 warm reset
 13	CCB record transfer disable
 12	power management level change interrupt enable
 11	record channel source
	0 = CODEC ADC
	1 = I2S
------
 10	CCB voice interrupts enable
---AudioPCI ES1370---
 9	record channel source in serial module
	0 = CODEC ADC
	1 = MPEG
 8	general purpose output
---AudioPCI-97 ES1371---
 9-8	current power down level
	00-11 = D0-D3
------
 7	memory bus request enable (disables memory access) (test purposes only)
 6	DAC1 (CODEC FM DAC) playback channel enable
 5	DAC2 (CODEC DAC) playback channel enable
 4	CODEC ADC record channel enable
 3	UART enable
 2	joystick enable
---AudioPCI ES1370---
 1	CODEC interface enable
 0	PCI serr signal disable
---AudioPCI-97 ES1371---
 1	crystal clock input disable
 0	PCI clock input disable
------
Note:	this register is addressable as byte, word and dword

Bitfields for Ensoniq ES1370/ES1371 interrupt/chip select status register:
Bit(s)	Description	(Table P0991)
---AudioPCI ES1370---
 31	DAC1, DAC2, ADC, UART or CCB interrupt occurred
 30-11	reserved
 10	CODEC busy or register write in progress
 9	CODEC busy
 8	CODEC register write in progress
 7	reserved
 6-5	CCB voice code (if bit 4 = 1)
	00 = DAC1
	01 = DAC2
	10 = ADC
	11 = reserved
---AudioPCI-97 ES1371---
 31	DAC1, DAC2, ADC, UART, CCB or power management interrupt occurred
 30-9	reserved
 8	CODEC synchronization error
 7-6	CCB voice code (if bit 4 = 1)
	00 = DAC1
	01 = DAC2
	10 = ADC
	11 = reserved
 5	power level interrupt status
------
 4	CCB interrupt status
 3	UART interrupt status
 2	DAC1 playback channel interrupt status
 1	DAC2 playback channel interrupt status
 0	ADC record channel interrupt status

Bitfields for Ensoniq ES1370/ES1371 UART control register:
Bit(s)	Description	(Table P0992)
 7	UART receiver interrupt enable
 6-5	UART transmitter operation
	01 = Txrdy interrupts enabled
 4-2	reserved
 1-0	UART control
	11 = software reset

Bitfields for Ensoniq ES1370/ES1371 UART status register:
Bit(s)	Description	(Table P0993)
 7	UART receiver interrupt status
 6-3	reserved
 2	UART transmitter interrupt status
 1	UART transmitter ready
 0	UART receiver ready

Bitfields for Ensoniq ES1370/ES1371 UART reserved register:
Bit(s)	Description	(Table P0994)
 7-1	reserved
 0	UART test mode enable (UART clock switched to PCI bus clock)

Bitfields for Ensoniq ES1370/ES1371 memory page register:
Bit(s)	Description	(Table P0995)
 31-4	reserved
 3-0	memory page select (accessed in registers 30h-3Fh)
	0000 = DAC1 sample bytes 15-0 (lower half buffer)
	0001 = DAC1 sample bytes 31-16
	0010 = DAC1 sample bytes 47-32 (upper half buffer)
	0011 = DAC1 sample bytes 63-48
	0100 = DAC2 sample bytes 15-0 (lower half buffer)
	0101 = DAC2 sample bytes 31-16
	0110 = DAC2 sample bytes 47-32 (upper half buffer)
	0111 = DAC2 sample bytes 63-48
	1000 = ADC sample bytes 15-0 (lower half buffer)
	1001 = ADC sample bytes 31-16
	1010 = ADC sample bytes 47-32 (upper half buffer)
	1011 = ADC sample bytes 63-48
	1100 = DAC1/DAC2 frame information
	1101 = ADC frame information
	1110 = UART FIFO
	1111 = UART FIFO
Note:	this register is addressable as byte, word and dword

Bitfields for Ensoniq ES1370/ES1371 CODEC write register:
Bit(s)	Description	(Table P0996)
---AudioPCI ES1370---
 31-16	reserved
 15-8	CODEC register index
---AudioPCI-97 ES1371---
 31-24	reserved
 23	AC97 CODEC read/write
	0 = write
	1 = read
 22-16	AC97 CODEC register index
------
 7-0	CODEC register data
---index 16h---
 1	0 = CODEC power down
------
Note:	(AudioPCI ES1370) this register is addressable as word and dword

Bitfields for Ensoniq ES1370/ES1371 serial interface control register:
Bit(s)	Description	(Table P0997)
 31-22	reserved
 22	(ES1371) DAC test mode enable (selects I2S lrclk input as  source for
	  playback and record channels)
 21-19	sample address counter loop binary offset
 18-16	sample address counter channel start/restart binary offset
 15	ADC channel action when sample count reaches zero
	0 = loop (interrupt set, keep recording)
	1 = stop (inteerupt set, stop recording)
 14	DAC2 channel action when sample count reaches zero
	0 = loop (interrupt set, keep playing)
	1 = stop (inteerupt set, play last sample)
 13	DAC1 channel action when sample count reaches zero (same values as
	  bit 14)
 12	DAC2 channel playback pause
 11	DAC1 channel playback pause
 10	ADC interrupt enable
 9	DAC2 interrupt enable
 8	DAC1 interrupt enable
 7	DAC1 sample counter reload
 6	DAC2 sample counter reload
 5-4	ADC channel data format
	00 = 8-bit mono
	01 = 8-bit stereo
	10 = 16-bit mono
	11 = 16-bit stereo
 3-2	DAC2 channel data format (same values as bits 5-4)
 1-0	DAC1 channel data format (same values as bits 5-4)
Note:	this register is addressable as byte, word and dword

Bitfields for Ensoniq ES1370/ES1371 DAC1/2/ADC channel sample count register:
Bit(s)	Description	(Table P0998)
 31-16	sample counter current value (read-only)
 15-0	sample counter (samples - 1)
Note:	these registers are addressable as word and dword

Bitfields for Ensoniq ES1370/ES1371 internal memory 1:
Bit(s)	Description	(Table P0999)
---register +00Ch bits 3-0 = 0000---
 31-0	DAC1 sample bytes 3-0
---register +00Ch bits 3-0 = 0001---
 31-0	DAC1 sample bytes 19-16
---register +00Ch bits 3-0 = 0010---
 31-0	DAC1 sample bytes 35-32
---register +00Ch bits 3-0 = 0011---
 31-0	DAC1 sample bytes 51-48
---register +00Ch bits 3-0 = 0100---
 31-0	DAC2 sample bytes 3-0
---register +00Ch bits 3-0 = 0101---
 31-0	DAC2 sample bytes 19-16
---register +00Ch bits 3-0 = 0110---
 31-0	DAC2 sample bytes 35-32
---register +00Ch bits 3-0 = 0111---
 31-0	DAC2 sample bytes 51-48
---register +00Ch bits 3-0 = 1000---
 31-0	ADC sample bytes 3-0
---register +00Ch bits 3-0 = 1001---
 31-0	ADC sample bytes 19-16
---register +00Ch bits 3-0 = 1010---
 31-0	ADC sample bytes 35-32
---register +00Ch bits 3-0 = 1011---
 31-0	ADC sample bytes 51-48
---register +00Ch bits 3-0 = 1100---
 31-0	DAC1 sample buffer memory address
---register +00Ch bits 3-0 = 1101---
 31-0	ADC sample buffer memory address
---register +00Ch bits 3-0 = 1110---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
---register +00Ch bits 3-0 = 1111---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
------
SeeAlso: #P1000

Bitfields for Ensoniq ES1370/ES1371 internal memory 2:
Bit(s)	Description	(Table P1000)
---register +00Ch bits 3-0 = 0000---
 31-0	DAC1 sample bytes 7-4
---register +00Ch bits 3-0 = 0001---
 31-0	DAC1 sample bytes 23-20
---register +00Ch bits 3-0 = 0010---
 31-0	DAC1 sample bytes 39-36
---register +00Ch bits 3-0 = 0011---
 31-0	DAC1 sample bytes 55-52
---register +00Ch bits 3-0 = 0100---
 31-0	DAC2 sample bytes 7-4
---register +00Ch bits 3-0 = 0101---
 31-0	DAC2 sample bytes 23-20
---register +00Ch bits 3-0 = 0110---
 31-0	DAC2 sample bytes 39-36
---register +00Ch bits 3-0 = 0111---
 31-0	DAC2 sample bytes 55-52
---register +00Ch bits 3-0 = 1000---
 31-0	ADC sample bytes 7-4
---register +00Ch bits 3-0 = 1001---
 31-0	ADC sample bytes 23-20
---register +00Ch bits 3-0 = 1010---
 31-0	ADC sample bytes 39-36
---register +00Ch bits 3-0 = 1011---
 31-0	ADC sample bytes 55-52
---register +00Ch bits 3-0 = 1100---
 31-16	DAC1 dwords transferred
 15-0	DAC1 dwords in buffer - 1
---register +00Ch bits 3-0 = 1101---
 31-16	ADC dwords transferred
 15-0	ADC dwords in buffer - 1
---register +00Ch bits 3-0 = 1110---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
---register +00Ch bits 3-0 = 1111---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
------
SeeAlso: #P0999,#P1001

Bitfields for Ensoniq ES1370/ES1371 internal memory 3:
Bit(s)	Description	(Table P1001)
---register +00Ch bits 3-0 = 0000---
 31-0	DAC1 sample bytes 11-8
---register +00Ch bits 3-0 = 0001---
 31-0	DAC1 sample bytes 27-24
---register +00Ch bits 3-0 = 0010---
 31-0	DAC1 sample bytes 43-40
---register +00Ch bits 3-0 = 0011---
 31-0	DAC1 sample bytes 59-56
---register +00Ch bits 3-0 = 0100---
 31-0	DAC2 sample bytes 11-8
---register +00Ch bits 3-0 = 0101---
 31-0	DAC2 sample bytes 27-24
---register +00Ch bits 3-0 = 0110---
 31-0	DAC2 sample bytes 43-40
---register +00Ch bits 3-0 = 0111---
 31-0	DAC2 sample bytes 59-56
---register +00Ch bits 3-0 = 1000---
 31-0	ADC sample bytes 11-8
---register +00Ch bits 3-0 = 1001---
 31-0	ADC sample bytes 27-24
---register +00Ch bits 3-0 = 1010---
 31-0	ADC sample bytes 43-40
---register +00Ch bits 3-0 = 1011---
 31-0	ADC sample bytes 59-56
---register +00Ch bits 3-0 = 1100---
 31-0	DAC2 sample buffer memory address
---register +00Ch bits 3-0 = 1101---
 31-0	reserved
---register +00Ch bits 3-0 = 1110---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
---register +00Ch bits 3-0 = 1111---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
------
SeeAlso: #P1000,#P1002

Bitfields for Ensoniq ES1370/ES1371 internal memory 4:
Bit(s)	Description	(Table P1002)
---register +00Ch bits 3-0 = 0000---
 31-0	DAC1 sample bytes 15-12
---register +00Ch bits 3-0 = 0001---
 31-0	DAC1 sample bytes 31-28
---register +00Ch bits 3-0 = 0010---
 31-0	DAC1 sample bytes 47-44
---register +00Ch bits 3-0 = 0011---
 31-0	DAC1 sample bytes 63-60
---register +00Ch bits 3-0 = 0100---
 31-0	DAC2 sample bytes 15-12
---register +00Ch bits 3-0 = 0101---
 31-0	DAC2 sample bytes 31-28
---register +00Ch bits 3-0 = 0110---
 31-0	DAC2 sample bytes 47-44
---register +00Ch bits 3-0 = 0111---
 31-0	DAC2 sample bytes 63-60
---register +00Ch bits 3-0 = 1100---
 31-16	DAC2 dwords transferred
 15-0	DAC2 dwords in buffer - 1
---register +00Ch bits 3-0 = 1101---
 31-0	reserved
---register +00Ch bits 3-0 = 1110---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
---register +00Ch bits 3-0 = 1111---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
------
SeeAlso: #P1001
----------Pxxxx------------------------------
PORT xxxx - Ensoniq AudioPCI-97 ES1371 - CONTROL REGISTERS
Range:	anywhere on 64 byte boundary

+000d RW  interrupt/chip select control register (see #P0990)
+004d R-  interrupt/chip select status register (see #P0991)
+008  RW  UART data register (MIDI data)
+009  -W  UART control register (see #P0992)
+009  R-  UART status register (see #P0993)
+00A  RW  UART reserved register (see #P0994)
+00Cd RW  memory page register (see #P0995)
+010d RW  sample rate converter interface register (see #P1003)
+014d -W  CODEC write register (see #P0996)
+014d R-  CODEC read register (see #P1004)
+018d RW  legacy control/status register (see #P1005)
+020d RW  serial interface control register (see #P0997)
+024d RW  DAC1 channel sample count register (see #P0998)
+028d RW  DAC2 channel sample count register (see #P0998)
+02Cd RW  ADC channel sample count register (see #P0998)
+030d RW  internal memory 1 (see #P0999)
+034d RW  internal memory 2 (see #P1000)
+038d RW  internal memory 3 (see #P1001)
+03Cd RW  internal memory 4 (see #P1002)

Bitfields for Ensoniq AudioPCI-97 ES1371 sample rate converter interface:
Bit(s)	Description	(Table P1003)
 31-25	sample rate converter RAM address
 24	sample rate converter read/write control
 23	sample rate converter busy (read-only)
 22	sample rate converter disable
 21	playback channel 1 accumulator update disable
 20	playback channel 2 accumulator update disable
 19	record channel accumulator update disable
 18-16	reserved
 15-0	sample rate converter RAM data

Bitfields for Ensoniq AudioPCI-97 ES1371 CODEC read register:
Bit(s)	Description	(Table P1004)
 31	AC97 CODEC data ready
 30	AC97 CODEC register access in progress
 29-24	reserved
 23	AC97 CODEC read/write
	0 = write
	1 = read
 22-16	AC97 CODEC register index
 7-0	AC97 CODEC register data

Bitfields for Ensoniq AudioPCI-97 ES1371 legacy control/status register:
Bit(s)	Description	(Table P1005)
 31	joystick timing
	0 = ISA
	1 = fast
 30	host interrupt blocking enable ???
 29	Sound Blaster capture address range
	0 = 220h-22Fh
	1 = 240h-24Fh
 28-27	SoundScape base register capture address range
	00 = 320h-327h
	01 = 330h-337h
	10 = 340h-347h
	11 = 350h-357h
 26-25	CODEC capture address range
	00 = 530h-537h
	01 = reserved
	10 = E80h-E87h
	11 = F40h-F47h
 24	force interrupt
 23	slave DMA controller event capture enable (address range C0h-DFh)
 22	slave interrupt controller event capture enable (address range A0h-A1h)
 21	master DMA controller event capture enable (address range 0h-Fh)
 20	master interrupt controller event capture enable (address range
	  20h-21h)
 19	AdLib register event capture enable (address range 388h-38Bh)
 18	Sound Blaster register event capture enable (address range selected by
	  bit 29)
 17	CODEC event capture enable (address range selected by bits 26-25)
 16	SoundScape base address register event capture enable (address range
	  selected by bits 28-27)
 15-11	reserved
 10-8	captured event (read-only)
	000 = SoundScape base address
	001 = CODEC
	010 = Sound Blaster register
	011 = AdLib register
	100 = master interrupt controller
	101 = master DMA controller
	110 = slave interrupt controller
	111 = slave DMA controller
 7-3	captured event I/O address bits 4-0 (read-only)
 2	captured event read/write (read-only)
	0 = read
	1 = write
 1	reserved
 0	interrupt flag (write to reset)
	0 = interrupt occurred
	0 = interrupt not occurred
Note:	this register is addressable as byte, word and dword
--------d-Pxxxx------------------------------
PORT xxxx - Intel 82371, OPTi "Vendetta" (82C750) - Bus Master IDE Registers

+000  RW  command register, primary channel (see #P1006)
+002  Rw  status register, primary channel (see #P1007)
+004d RW  IDE descriptor table pointer, primary channel (see #P1008)
+008  RW  command register, secondary channel (see #P1006)
+00A  Rw  status register, secondary channel (see #P1007)
+00Cd RW  IDE descriptor table pointer, secondary channel (see #P1008)

Bitfields for Intel 82371 Bus Master IDE command register:
Bit(s)	Description	(Table P1006)
 7-4	reserved
 3	bus master read/write control
	=0 read
	=1 write
 2-1	reserved
 0	start/stop bus master
	=1 start
	=0 stop
SeeAlso: #P1007,#P1008

Bitfields for Bus Master IDE status register:
Bit(s)	Description	(Table P1007)
 7	(Intel) reserved (0)
	(OPTI "Vendetta") both channels operable at same time (read-only)
 6	drive 1 is DMA-capable
 5	drive 0 is DMA_capable
 4-3	reserved
 2	IDE interrupt pending
	write 1 to this bit to clear it
 1	IDE DMA error
	write 1 to this bit to clear it
 0	bus master IDE active (read-only)
SeeAlso: #P1006,#P1008

Bitfields for Bus Master IDE descriptor table pointer register:
Bit(s)	Description	(Table P1008)
 31-2	descriptor table base address bits 31-2
 1-0	reserved (0)
Notes:	(Intel 82371) the descriptor table must not cross a 4K boundary
	(OPTi "Vendetta") the descriptor table must not cross a 64K boundary
SeeAlso: #P1006,#P1007
----------Pxxxx------------------------------
PORT xxxx - Intel 82371SB - USB Host I/O Registers
InstallCheck: see #01194 at INT 1A/AX=B10Ah
SeeAlso: #01194

+000w RW  USB command register (see #P1009)
+002w Rw  USB status (see #P1010)
+004w RW  USB interrupt enable (see #P1011)
+006w RW  Frame Number (see #P1012)
+008d RW  Frame List Base Address
	   (bits 11-0 must be written as zeros)
+00C  RW  Start of Frame Modify (see #P1013)
+010w RW  port 1 status/control (see #P1014)
+012w RW  port 2 status/control (see #P1014)

Bitfields for Intel 82371SB USB command register:
Bit(s)	Description	(Table P1009)
 15-8	reserved
 7	maximum packet size (0=32 bytes, 1=64 bytes)
 6	Host Controller has been configured (set by software)
 5	software debug mode
 4	force global resume
 3	enter global suspend mode
 2	global reset
 1	host controller reset
 0	run/stop schedule (0=stop, 1=run)
SeeAlso: #P1010

Bitfields for Intel 82371SB USB status register:
Bit(s)	Description	(Table P1010)
 15-6	reserved
 5	host controller halted
 4	host controller process error
 3	PCI bus error
 2	resume received
 1	USB error interrupt
 0	USB interrupt
Note:	to clear a bit in this register, write a 1 to it
SeeAlso: #P1009

Bitfields for Intel 82371SB USB interrupt enable register:
Bit(s)	Description	(Table P1011)
 15-4	reserved
 3	enable short packet interrupts
 2	enable Interrupt On Complete
 1	enable Resume
 0	enable Timeout/CRC
SeeAlso: #P1010,#P1012

Bitfields for Intel 82371SB Frame Number register:
Bit(s)	Description	(Table P1012)
 15-11	reserved
 10-0	Frame List Current Index/Frame Number
	incremented at end of each time frame (~1ms)
Note:	only WORD writes are allowed to this register
SeeAlso: #P1009,#P1011

Bitfields for Intel 82371SB Start of Frame Modify register:
Bit(s)	Description	(Table P1013)
 7	reserved
 6-0	SOF timing value (default 64)
Note:	SOF cycle time equals 11936+timing value
SeeAlso: #P1009

Bitfields for Intel 82371SB Port 1/2 status/control register:
Bit(s)	Description	(Table P1014)
 15-13	reserved (0)
 12	suspend port
 11-10	reserved
 9	port in Reset State
 8	low-speed device is attached (read-only)
 7	reserved (1)
 6	resume detected (read-only)
 5-4	line status (read-only)
	bit 4: D+ signal line
	bit 5: D- signal line
 3	port enabled/disabled status has changed
	write 1 to this bit to clear it
 2	port is enabled
 1	connect status has changed
	write 1 to this bit to clear it
 0	current connect status (read-only)
Note:	only WORD writes are permitted to this register
SeeAlso: #P1009
--------!---CREDITS--------------------------
Wim Osterholt		<wim@djo.wtm.tudelft.nl>		Original File
Chuck Proctor		<71534.2302@CompuServe.COM>
Richard W. Watson	<73042.1420@CompuServe.COM>
Matthias Paul		<mpaul@ibh.rwth-aachen.de>
Serguei Shtyliov	<serge.fido@coudert.msk.ru>		Xirlink XL-22x
Serguei Shtyliov	<serge.fido@coudert.msk.ru>		TMC-16x0 SCSI
Serguei Shtyliov	<serge.fido@coudert.msk.ru>		AHA-154x SCSI
								MPU-401 MIDI

Some of the information in this list was extracted from Frank van Gilluwe's
_The_Undocumented_PC_, a must-have book for anyone programming down to the
"bare metal" of a PC.

Some of the information in this list from the shareware version of Dave
Williams' DOSREF, v3.0.

8514/A hardware ports found in FractInt v18.0 source file FR8514A.ASM

Compaq QVision info from the _COMPAQ_QVision_Graphics_System_Technical_
_Reference_Guide_, second edition (October 1993).  Compaq part number
073A/0693.  Much more to come!

AMI keyboard controller PORT 0064h commands from the American Megatrends, Inc.
_Version_KF_and_KH_Keyboard_Controller_BIOS_Reference_, available on the
AMI BBS and american.megatrends.com as KFKHMAN.ZIP.

Various chipset infos from "Het BIOS Boekje" 2nd edition, by Alle Metzlar,
ISBN 90-72260-59-7 (1995).

ATA-3 info from "AT Attachment-3 Interface (ATA-3) Revision 1", dated
April 21, 1995.

Some additional EISA info from _EISA_System_Architecture_ (second edition),
by MindShare, Inc. (Addison-Wesley 1995, ISBN 0-201-40995-X).

AMI BIOS diagnostics codes (port 0080h) from file CHECKPTS on AMI BBS.

Some S3 and additional ATI Mach8/Mach32 info from Richard F. Ferraro's
_Programmer's_Guide_to_the_EGA,_VGA,_and_Super_VGA_Cards_, third edition.

PCnet-ISA info from _Am79C960_PCnet-ISA(tm)_Technical_Manual_, May 1992,
available from www.amd.com as 16850B.PDF; additional details from file
16907B.PDF.

PCnet-SCSI info from _Am79C974 PCnet(tm)-SCSI_Combination_Ethernet_and_SCSI_
_Controller_for_PCI_Systems_, available from www.amd.com as 18681B.PDF.

PCnet-FAST info from _Am79C971 PCnet(tm)-FAST_Single-Chip_Full-Duplex_10/100_
_Mbps_Ethernet_Controller_for_PCI_Local_Bus_, available from www.amd.com as
20550B.PDF.

S.M.A.R.T. information from _Self-Monitoring,_Analysis,_and_Reporting_
_Technology_(S.M.A.R.T.)_(SFF-8035i)_, Revision 2.0, April 1, 1996.
Available as 8035r2_0.PDF from fission.dt.wdc.com/pub/standards/SFF/.

A variety of ports from Frank van Giluwe's _The_Undocumented_PC_, second
edition.

[many more sources listed in BIBLIO.LST]
--------!---Admin----------------------------
Highest Table Number = P1014
--------!---FILELIST-------------------------
Please redistribute all of the files comprising the interrupt list (listed at
the beginning of the list and in INTERRUP.1ST) unmodified as a group, in a
quartet of archives named INTER59A through INTER59D (preferably the original
authenticated PKZIP archives), and the utility and hypertext programs in a trio
of additional archives called INTER59E.ZIP to INTER59G.ZIP.

Copyright (c) 1989,1990,1991,1992,1993,1994,1995,1996,1997,1998 Ralf Brown
--------!---CONTACT_INFO---------------------
Internet: ralf@pobox.com (currently forwards to ralf@telerama.lm.com)
UUCP: {uunet,harvard}!pobox.com!ralf
FIDO: Ralf Brown 1:129/26.1
	or post a message to me in the DR_DEBUG echo (I probably won't see it
	unless you address it to me)
CIS:  >INTERNET:ralf@pobox.com
