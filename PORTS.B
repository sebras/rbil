Ports List, part 2 of 2
Copyright (c) 1989,1990,1991,1992,1993,1994,1995,1996,1997,1998 Ralf Brown
--------V-P03C003C1--------------------------
PORT 03C0-03C1 - EGA/VGA - ATTRIBUTE CONTROLLER
Range:	PORT 03C0h or PORT 02C0h (alternate EGA)
SeeAlso: PORT 03C2h,PORT 03D0h,#P466

03C0  rW  ATC index/data register
		Every write access to this register will toggle an internal
		  index/data selection flipflop, so that consecutive writes to
		  index & data is possible through this port. To get a defined
		  start condition, each read access to the input status register
		  #1 (3BAh in mono / 3DAh in color) resets the flipflop to load
		  index. If values are changed during the vertical retrace
		  period only no flicker will occur.

		index register (flipflop reset to 'index'): (default 20h)
		  bit7-6: reserved
		  bit5	: 0=CPU access (screen dark),
			  1=video access to registers
		  bit4-0: index in ATC (0..31)

		indexed registers in ATC (flipflop set to 'data'): (see #P410)
03C1  R-  (VGA)	ATC index/data read register

(Table P410)
Values for EGA/VGA indexed registers in ATC:
 00h-0Fh 16 palette registers (see #P411)
 10h	mode control register (see #P412)
 11h	(EGA) overscan color register (see #P413) (default: 00h)
 11h	(VGA) overscan color register (see #P414) (default: 00h)
 12h	color enable register (see #P415)
 13h	horizontal pixel panning register
	bit7-4: reserved
	bit3-0: horizontal pixel panning
 14h	(VGA) color select register (default: 00h)
	bit7-4: reserved
	bit3  : s-color 7
	bit2  : s-color 6
	bit1  : s-color 5 (only with 16 pages   16 regs)
	bit0  : s-color 4 (only with 16 pages   16 regs)
 16h	ET3000, ET4000 only: ATC miscellanenous
	(at least on ET4000 'key' protected)
	This register is also supported by ET3000, but the
	  description is proved for ET4000 only.
	bit7  : bypass the internal palette
		(e.g. for HiColor modes with Sierra RAMDACs)
	bit6  : reserved
	bit5-4: select high resolution / color mode
	bit3-0: reserved
SeeAlso: #P418,#P448

Bitfields for EGA/VGA indexed ATC palette register:
Bit(s)	Description	(Table P411)
 7-6	reserved
 5	secondary red video
 4	secondary green/intensity video
 3	secondary blue/mono video
 2	primary red video
 1	primary green video
 0	primary blue video
SeeAlso: #P410

Bitfields for EGA/VGA ATC mode control register:
Bit(s)	Description	(Table P412)
 7	(VGA) SB/SG select (0=4 pages of 64 regs, 1=16 pages of 16 regs)
 6	(VGA) PELCLK/2 (0=4bit color, 1=8bit color)
 5	(VGA) enable pixel panning (0=all, 1=up to line compare register value)
 4	reserved
 3	background intensity (0=16 colors, 1=blink)
 2	line graphics enable (0=background, 1=line 8=9)
 1	1=mono, 0=color select
 0	1=graphics, 0=text select
SeeAlso: #P410

Bitfields for EGA overscan color register:
Bit(s)	Description	(Table P413)
 7-6	reserved
 5	secondary red (SR)
 4	secondary green (SR) / intensity
 3	secondary blue (SB)
 2	primary red (PR)
 1	primary green (PG)
 0	primary blue (PB)
SeeAlso: #P410,#P414

Bitfields for VGA overscan color register:
Bit(s)	Description	(Table P414)
 7	secondary intensity border color (SI)
 6	secondary red (SR)
 5	secondary green (SG)
 4	secondary blue (SB)
 3	intensity border color (PI)
 2	primary red (PR)
 1	primary green (PG)
 0	primary blue (PB)
SeeAlso: #P410,#P413

Bitfields for EGA/VGA color enable register:
Bit(s)	Description	(Table P415)
 7-6	reserved
 5-4	diagnose / video status select
	EGA:		VGA, ET4000:
	00b = PR/PB	   PR/PB
	01b = SB/PG	   SG/SB
	10b = SR/SG	   PI/PG
	11b = reserved	   SI/SR
 3	enable plane 3
 2	enable plane 2
 1	enable plane 1
 0	enable plane 0
SeeAlso: #P410
----------P03C003C7--------------------------
PORT 03C0-03C7 - Sunshine EW-901, EW-901A, EW-904, EW-904A
Desc:	EPROM writer card for EPROMs up to 27512

03C0-03C3	adresses of the 8255 on the EW-90x
--------V-P03C203CF--------------------------
PORT 03C2-03CF - EGA/VGA - MISCELLANEOUS REGISTERS
Range:	PORT 03C2h or PORT 02C2h (alternate EGA)
SeeAlso: PORT 03C0h,PORT 03C4h,PORT 03C6h,PORT 03D0h

03C2  R-  input status 0 register (see #P416)
03C2  -W  miscellaneous output register (see #P417)
03C3  RW  (VGA)	video subsystem enable (see also PORT 46E8h)
		for IBM, motherboard VGA only
			 bit7-4=0: reserved
			 bit3	 : select video subsystem (address 46E8h)
			 bit2-1	 : reserved
			 bit0	 : select video subsystem (address 03C3h)

Bitfields for EGA/VGA input status 0 register:
Bit(s)	Description	(Table P416)
 7	(VGA) vertical retrace interrupt is pending
	(EGA) =0 vertical retrace in progress
 6-5	(VGA) reserved (0)
 6	(EGA and ET4000) feature control 1 (pin17)
 5	(EGA and ET4000) feature control 0 (pin19)
 4	(VGA) monitor sense signal is asserted
 4	(EGA, Genoa SuperEGA) DIP switch sense
	0=closed, 1=open/switches readable
 3-0	reserved (0)

Bitfields for EGA/VGA miscellaneous output register:
Bit(s)	Description	(Table P417)
---Genoa SuperEGA in all emulation modes---
 7-6: vertical resolution
	00 (EGA) 200 lines
	01 (VGA) 400 lines
	10 (EGA/VGA) 350 lines
	11 (VGA) 480 lines
------
 7	vertical sync polarity (0=positive, 1=negative)
 6	horizontal sync polarity (0=positive, 1=negative)
 5	odd/even pagebit (=1 select second 64K memory page)
 4	EGA: 0=video driver on,
	     1=video driver off (feature connector used)
 3-2	pixelclock
	00 14/25.175 MHz (EGA/VGA)
	01 16/28.322 Mhz (EGA/VGA)
	10 (EGA/VGA) external clock (EGA)
	10 (Genoa SuperEGA) 39Mhz
	11 (EGA/VGA) reserved
	11 (Genoa SuperEGA) 26.824Mhz
	11 (S3 Trio32/Trio64) enable clock programming via sequencer registers
		  12h and 13h
 1	enable CPU RAM access
 0	CRTC port address
	0=3B4h mono
	1=3D4h color
	   (color EGA: enable feature control at 3DAh,status reg 1 at 3D2h)
----------P03C403C5--------------------------
PORT 03C4-03C5 - EGA/VGA - SEQUENCER REGISTERS
Range:	PORT 03C4h or PORT 02C4h (alternate EGA)
SeeAlso: PORT 03C0h,PORT 03C2h,PORT 03C4h"Cirrus",PORT 03C4h"S3"
SeeAlso: PORT 03C4h"Tseng",PORT 03C6h,PORT 03D0h

03C4  -W  EGA	TS index register
		bit7-3 : reserved (VGA only)
		bit2-0 : current TS index
03C4  RW  VGA	sequencer register index (see #P418)
03C5  -W  EGA	TS data register
03C5  RW  VGA	sequencer register data

(Table P418)
Values for EGA/VGA indexed TS (sequencer) registers:
 00h	reset register
	bit7-2 : reserved
	bit1 =0: synchronous reset (EGA/VGA)
	bit0 =0: asynchronous reset (EGA, ET4000)
		 synchronous reset, also (VGA)
 01h	clocking mode register / TS mode (see #P419)
 02h	map mask register (see #P420)
 03h	character map select register / font select (see #P421)
 04h	memory mode register (see #P422)
 07h	(undoc VGA) reset horizontal character counter
	any write to this register holds horizontal character counter at 00h
	  until any other sequencer register is written
Note:	register 07h is documented in the C&T Wingine documentation
SeeAlso: #P423,#P444,#P433

Bitfields for EGA/VGA sequencer clocking mode register:
Bit(s)	Description	(Table P419)
 7-6	reserved
 5	(VGA) =1: screen refresh off
 4	(VGA) shift load (0=4x8, 1=1x32)
 3	internal character clock (0=normal, 1=dotclock/2)
 2	serial shift video load (0=4x8, 1=2x16)
 1	(EGA) CRTC bandwidth (0=4/5, 1=2/5)
 0	dot clocks per character (0=9, 1=8) (ET4000: see 06h)
SeeAlso: #P418

Bitfields for EGA/VGA sequencer map mask register:
Bit(s)	Description	(Table P420)
 7-4	reserved
 4	Genoa SuperEGA only: plane4 ???
 3	write enable display memory plane 3
 2	write enable display memory plane 2
 1	write enable display memory plane 1
 0	write enable display memory plane 0
SeeAlso: #P418

Bitfields for EGA/VGA sequencer character map select register:
Bit(s)	Description	(Table P421)
 7-6	reserved
 5	(VGA) bit3 for second text-font
 4	(VGA) bit3 for first text-font
 3-2	second text-font (attr bit3=1)
 1-0	first text-font (attr bit3=0)
	offset in font memory (4-7: VGA only)
	   0 00b =  0KB
	   0 01b = 16KB
	   0 10b = 32KB
	   0 11b = 48KB
	   1 00b =  8KB
	   1 01b = 24KB
	   1 10b = 40KB
	   1 11b = 56KB
SeeAlso: #P418

Bitfields for EGA/VGA sequencer memory mode register:
Bit(s)	Description	(Table P422)
 7-4	reserved
 3	=1 (VGA) enable chain 4 linear graphics mode
	(when set, low two bits of CPU address select the plane)
 2	addressing mode
	0 odd/even mode (even addresses access planes 0/2, odd planes 1/3)
	1 sequential mode
 1	=1 extended memory (0=64KB, 1=more)
 0	(EGA) 1=textmode, 0=graphics mode
SeeAlso: #P418
----------P03C403C5--------------------------
PORT 03C4-03C5 - Cirrus Logic GRAPHICS - EXTENDED SEQUENCER REGISTERS
SeeAlso: PORT 03C4h"EGA",PORT 03C4h"S3",PORT 03C4h"Tseng"

03C4  RW  sequencer register index (see #P444)
03C5  RW  sequencer register data

(Table P423)
Values for Cirrus CL-GD7556 extended sequencer registers:
 00h-04h same as EGA/VGA (see #P418) 
 06h	"SR6" key register -- enable access to extension registers
	set to xxx1x010 to unlock extended sequencer and CRTC registers
 07h	"SR7" extended sequencer mode (see #P424)
 08h	"SR8" DDC2B control (see #P425)
 09h	"SR9" scratch pad #0
 0Ah	"SRA" scratch pad #1
 0Bh	"SRB" VCLK0 numerator  !!!gd7556hrm.pdf p.239
 0Ch	"SRC" VCLK1 numerator
 0Dh	"SRD" VCLK2 numerator
 0Eh	"SRE" VCLK3 numerator
 0Fh	"SRF" display memory control (see #P426)
 10h	"SR10" hardware cursor/icon coarse horizontal position
 11h	"SR11" hardware cursor/icon coarse vertical position
 12h	"SR12" hardware cursor attributes
 13h	"SR13" hardware cursor pattern address
 14h	"SR14" scratch pad #2
 15h	"SR15" scratch pad #3
 17h	"SR17" BitBLT memory map I/O address
 18h	"SR18" signature generator control
 19h	"SR19" signature generator result (low)
 1Ah	"SR1A" signature generator result (high)
 1Bh	"SR1B" VLK0 denominator/post scaler
 1Ch	"SR1C" VLK1 denominator/post scaler
 1Dh	"SR1D" VLK2 denominator/post scaler
 1Eh	"SR1E" VLK3 denominator/post scaler
 1Fh	"SR1F" MCLK frequency / VCLK source select
 20h	"SR20" miscellaneous control 2
 21h	"SR21" test bus control
 22h	"SR22" hardware configuration read 1
 23h	"SR23" software configuration 1
 24h	"SR24" flat panel type switches enable
 25h	"SR25" FasText(tm) mode control
 26h	"SR26" shader signature (low)
 27h	"SR27" shader signature (high)
 28h	"SR28" scratch pad #4
 29h	"SR29" scratch pad #5
 2Ah	"SR2A" hardware icon #0 control
 2Bh	"SR2B" hardware icon #1 control
 2Ch	"SR2C" hardware icon #2 control / byte-swap enable
 2Dh	"SR2D" hardware icon #3 control / cursor memory access
 2Eh	"SR2E" hardware cursor horizontal position extension
 2Fh	"SR2F" half-frame accel. FIFO threshold for surrounding graphics
 32h	"SR32" half-frame accel. FIFO threshold in video window
 33h	"SR33" spare register
 34h	"SR34" Host CPU cycle stop control
Note:	the scratch pad registers are reserved for use by the VGA BIOS
SeeAlso: #P418,#P433,#P444

Bitfields for Cirrus CL-GD7556 extended sequencer mode register:
Bit(s)	Description	(Table P424)
 7-4	display memory segment
 3-1	CRT Controller character clock divisor
 0	select high-resolution packed-pixel mode
!!!gd7556hrm.pdf p.234
SeeAlso: #P423

Bitfields for Cirrus CL-GD7556 DDC2B Control register:
Bit(s)	Description	(Table P425)
 7	DDCD output status (read-only)
 6-3	reserved
 2	DDCC output status (read-only)
 1	DDCD (I2C SDA) output control
 0	DDCC (I2C SCL) output control
Notes:	bits 1 and 0 are used to drive the I2C bus used for DDC communications;
	  bits 7 and 2 are used to read back the current state of the bus lines
	SR24 bit 7 must be cleared to enable access to the bus
SeeAlso: #P423,#M079,I2C A0h"DDC"

Bitfields for Cirrus CL-GD7556 Display Memory Control register:
Bit(s)	Description	(Table P426)
 7	bank select for display memory
 6	!!!gd7556hrm.pdf p.241
 5	reserved
 4-3	display memory data width
 2	RAS# cycle select for display memory
 1	display memory configuration symmetry
 0	multiple-CAS# / multiple-WE# select for display memory
SeeAlso: #P540
----------P03C403C5--------------------------
PORT 03C4-03C5 - NVIDIA - EXTENDED SEQUENCER REGISTERS
SeeAlso: PORT 03C4h"EGA",PORT 03C4h"S3",PORT 03C4h"Tseng"

03C4  RW  sequencer register index (see #P427)
03C5  RW  sequencer register data

(Table P427)
Values for NVIDIA NV3/RIVA128 extended sequencer registers:
 06h	key register (enable access to extended registers when set to 57h,
	  disable access when set to any other value)
 19h	extended start address and offset
	bits 7-5: offset bits 10-8
	bits 4-0: address bits 20-16
 1Ah	flags (see #P428)
 1Bh	refresh FIFO control (see #P429)
 20h	FIFO watermark (see #P430)
 25h	miscellaneous extension bits (see #P431)
 28h	framebuffer format
 2Dh	extended horizontal bits (see #P432)
 30h	graphics cursor control 0
 31h	graphics cursor control 1
 ???

Bitfields for NVIDIA NV3 flags:
Bit(s)	Description	(Table P428)
 !!!nv3ref.h
SeeAlso: #P427

Bitfields for NVIDIA NV3 refresh FIFO control:
Bit(s)	Description	(Table P429)
 7	underflow warning
 2-0	burst length
	000 eight
	001 32
	010 64
	011 128
	100 256
SeeAlso: #P427,#P430

Bitfields for NVIDIA NV3 FIFO watermark:
Bit(s)	Description	(Table P430)
 7	reset FIFO
 5-0	watermark, in eight-byte units (refresh FIFO will start refilling
	  when occupancy falls below twice this value)
SeeAlso: #P427,#P429

Bitfields for NVIDIA NV3 miscellaneous extension bits:
Bit(s)	Description	(Table P431)
 5	offset bit 11
 4	horizontal blanking end, bit 6
 3	vertical blanking start, bit 10
 2	vertical retrace start, bit 10
 1	vertical display end, bit 10
 0	vertical total, bit 10
SeeAlso: #P427,#P432

Bitfields for NVIDIA NV3 extended horizontal bits:
Bit(s)	Description	(Table P432)
 4	"inter_half_start" bit 8
 3	horizontal retrace start, bit 8
 2	horizontal blanking start, bit 8
 1	display end, bit 8
 0	display total, bit 8
SeeAlso: #P427,#P431
----------P03C403C5--------------------------
PORT 03C4-03C5 - S3 GRAPHICS - EXTENDED SEQUENCER REGISTERS
SeeAlso: PORT 03C4h"EGA",PORT 03C4h"Cirrus",PORT 03C4h"Tseng",PORT 03C4"NVIDIA"

03C4  RW  sequencer register index (see #P433)
03C5  RW  sequencer register data

(Table P433)
Values for S3 extended sequencer registers:
 00h-04h same as EGA/VGA (see #P418) 
 08h	S3 864/964/765 (Trio64V): key register -- enable access to S3 extended
	  registers when set to x6h
---S3 Trio32/Trio64/Trio64V+ ---
 09h	"SR9" MMIO-Only
	bit 7: disable port I/O when memory-mapped I/O is enabled
	bits 6-0: reserved
	bit 1: ??? (set by Stealth64 Video 2001)
 0Ah	"SRA" external bus request control register (see #P434)
 0Bh	"SRB" miscellaneous extended sequencer register (see #P435)
 0Dh	"SRD" VSYNC/HSYNC control (see #P437)
 10h	"SR10" MCLK value (low) (see #P438)
 11h	"SR11" MCLK value (high) (see #P439)
 12h	"SR12" DCLK value (low) (see #P438)
 13h	"SR13" DCLK value (high) (see #P439)
 14h	"SR14" CLKSYN control 1 (see #P440)
 15h	"SR15" CLKSYN control 2 (see #P441)
 16h	"SR16" CLKSYN Test (high) (reserved for testing of clock synth)
 17h	"SR17" CLKSYN Test (low) (reserved for testing of clock synth)
 18h	"SR18" RAMDAC/CLKSYN Control (see #P442)
---S3 Trio64V+ ---
 1Ch	"SR1C" signal select (see #P443)
SeeAlso: #P418,#P423,#P444

Bitfields for S3 Trio32/64/64V+ "SRA" external bus request control register:
Bit(s)	Description	(Table P434)
 7	fast CPU writes
	when set and MCLK is less than 57 MHz, CPU writes take 2 MCLKs instead
	  of 3 MCLKs (for MCLKs of 55-57 MHz, SR15 bit 7 should also be set)
 6	(Trio64) Pin50 function select
	=0 (CR36 bit 2=1) Pin50 outputs a second -OE0 signal
	=1 (CR36 bit 2=1) Pin50 outputs -RAS1
 5	=0 tri-state pixel-data lines (reduces power consumption)
 4-0	maximum 2*MCLKs that secondary memory controllers are granted access to
	  Trio's memory bus
Note:	bit 6 must be set for 4M fast page-mode memory; it has no effect if
	  EDO memory is selected via CR36 bit 2
SeeAlso: #P433

Bitfields for S3 Trio32/64/64V+ "SRB" misc extended sequencer register:
Bit(s)	Description	(Table P435)
 7-4	alternate color mode (for feature connector input) (see #P436)
 3	(Trio32 only) enable packed 24 bpp (mode 12); also requires CR67 bits
		  7-4=0000
 2	reserved
 1	VAFC clocking
	=0 latch pixel data from pass-through feature connector on VCLK
	=1 latch pixel data from VAFC on VCLKI
 0	dot clock select (testing only)
	=0 use internal dot clock
	=1 use VCLKI
SeeAlso: #P433,#P499

(Table P436)
Values for S3 Trio32/Trio64 color mode:
0000	mode 0 = 8-bit, 1 pixel/VCLK
0001	mode 8 = 8-bit, 2 pixels/VCLK
0011	mode 9 = 15-bit, 1 pixel/VCLK
0101	mode 10 = 16-bit, 1 pixel/VCLK
0111	mode 12 = 640x480x24-bit (packed), 1 pixel/3 DCLKs (Trio32 only)
1101	mode 13 = 24-bit, 1 pixel/VCLK
else	reserved
Note:	mode 8 also requires SR18 bit 7=1 and either SR15 bit 4=1 or
	  SR15 bit 6=1
SeeAlso: #P435,#P499

Bitfields for S3 "SRD" Trio32/Trio64 VSYNC/HSYNC control:
Bit(s)	Description	(Table P437)
 7-6	vertical sync control
	00 normal operation
	01 force to 0
	10 force to 1
	11 reserved
 5-0	horizontal sync control (settings as for vsync)
 3-1	reserved
 1	(Trio64V+) feature connector type
	=0 Trio64-compatible
	=1 new LPB type
 0	enable feature connector
Note:	bits 7-4 are used to select the DPMS power mode as follows:
	    0000 On
	    0001 Standby
	    0100 Suspend
	    0101 Off
SeeAlso: #P433

Bitfields for S3 Trio32/Trio64 "SR10"/"SR12" MCLK/DCLK value (low):
Bit(s)	Description	(Table P438)
 7	reserved
 6-5	PLL R value
 4-0	PLL N-divider value
SeeAlso: #P439,#P433

Bitfields for S3 Trio32/Trio64 "SR11"/"SR13" MCLK/DCLK value (high):
Bit(s)	Description	(Table P439)
 7	reserved
 6-0	PLL M-divider value
SeeAlso: #P438,#P433

Bitfields for S3 Trio32/Trio64 "SR14" CLKSYN control 1:
Bit(s)	Description	(Table P440)
 7	select external DCLK (testing only; also requires external strapping)
 6	select external MCLK (testing only)
 5	select Pin146 function
	=0 use as -STRD
	=1 tri-state output; use as input (required to enable bit 6)
 4	clear clock synthesizer counters (testing only)
 3	"M TEST" MCLK test
	=0 test DCLK
	=1 test MCLK
 2	enable clock synthesizer counters (testing only)
 1	power down MCLK PLL (testing only)
 0	power down DCLK PLL (testing only)
SeeAlso: #P441,#P433

Bitfields for S3 Trio32/Trio64 "SR15" CLKSYN control 2:
Bit(s)	Description	(Table P441)
 7	enable fast memory writes (2 MCLKs instead of 3 MCLKs) by bypassing
	  VGA lienar addressing logic (requires SRA bit 7 set)
 6	invert DCLK
 5	load MCLK and DCLK immediately on transition from 1 to 0
 4	divide DCLK by 2
 3	VLCK direction
	=0 Pin148 always outputs internal VCLK
	=1 -EVCLK signal determines VLCK direction
 2	MCLK output (testing only)
	=0 Pin147 acts as STWR strobe
	=1 Pin147 outputs internal MCLK
 1	enable new DCLK frequency load (asynchronous)
 0	enable new MCLK frequency load
Notes:	bits 1 and 5 also require that PORT 03C2h bits 3-2=11
	bit 5 must never be left set; it should only be pulsed to cause the
	  MCLK/DCLK load
	bit 0 should be cleared after loading the new MCLK value to avoid
	  repeated loading
	either bit 4 or 6 must be set for clock-doubled RAMDAC operation
	  (see #P434)
SeeAlso: #P440,#P442,#P433

Bitfields for S3 Trio32/Trio64 "SR18" RAMDAC/CLKSYN control:
Bit(s)	Description	(Table P442)
 7	enable clock-doubled mode (see also #393)
 6	fast LUT write cycle (1 DCLK instead of default 2 DCLKs)
 5	power down RAMDAC (RAMDAC memory is retained even when powered down)
 4	(testing only) place blue data on internal data bus
 3	(testing only) place green data on internal data bus
 2	(testing only) place red data on internal data bus
 1	(testing only) reset RAMDAC test counter
 0	(testing only) enable test counter
SeeAlso: #P441

Bitfields for S3 Trio64V+ "SR1C" signal select:
Bit(s)	Description	(Table P443)
 7-2	reserved
 1-0	signal select
	VL-Bus:
	    00 Pin151 is ENFEAT#, Pin153 is ROMCS# (default)
	    01 Pin151 is GPIOSTR#, Pin153 is ROMCS#
	    10 Pin151 is GOP0, Pin153 is ROMCS#
	    11 Pin151 is GOP0, Pin153 is GOP1
	PCI:
	    00 Pin151 is ENFEAT#, Pin190 is STWR#, Pin153 is ROMEN# (default)
	    01 Pin151 is reserved, Pin190 is STWR#, Pin153 is ROMEN#
	    1x Pin151 is GOP0, Pin190 is GOP1, Pin153 is ROMEN#
SeeAlso: #P073
----------P03C403C5--------------------------
PORT 03C4-03C5 - Tseng Labs GRAPHICS - EXTENDED SEQUENCER REGISTERS
SeeAlso: PORT 03C4h"EGA",PORT 03C4h"Cirrus",PORT 03C4h"S3"

03C4  RW  sequencer register index (see #P444)
03C5  RW  sequencer register data

(Table P444)
Values for Tseng Labs extended sequencer registers:
 00h-04h same as EGA/VGA (see #P418)
 06h	ET3000 only: Zoom control register
 06h	ET4000 only: TS state control (protected by 'key')
	bit7-3 : reserved
	bit2-1 : timing sequencer state bit2-1
		   (bit0 is bit0 TS mode register)
		   00 0b=  9 dots
		   00 1b=  8 dots
		   01 0b= 10	  (10-16 are ET4000 only)
		   01 1b= 11
		   10 0b= 12
		   11 1b= 16
	bit0	: reserved
 07h	ET3000/ET4000 only: TS auxiliary mode (see #P445)
SeeAlso: #P418,#P423,#P433

Bitfields for ET3000/ET4000 sequencer auxiliary mode:
Bit(s)	Description	(Table P445)
 7	compatibility mode (1=VGA, 0=EGA)
 6	select MCLK/2 (with bit0=0)
 5	BIOS ROM address map 2
 4	reserved
 3	BIOS ROM address map 1
 2	reserved (1)
 1	select SCLK input from MCLK
 0	select MCLK/4 (with bit6=1)
 5+3	ROM address
	00 C0000-C3FFF
	01 disabled
	10 C0000-C5FFF, C6800-C7FFF
	11 C0000-C7FFF (default)
Notes:	at least on the ET4000, this register is protected by a 'key'
	this register is also supported by ET3000, but the above description
	  is based on the ET4000
SeeAlso: #P418
--------V-P03C603C9--------------------------
PORT 03C6-03C9 - EGA/VGA/MCGA - DAC REGISTERS
Range:	PORT 03C6h or PORT 02C6h (alternate)
SeeAlso: PORT 03C0h,PORT 03C2h,PORT 03C4h,PORT 03CAh,PORT 03CEh"EGA",PORT 03D0h
SeeAlso: PORT 83C6h"Wingine"

03C6  RW  (VGA, MCGA) PEL mask register (default FFh)
		 VGA:	AND mask for color-register address.
		 MCGA:	Never change from the default FFh.
03C6  RW  HiColor ET4000 (Sierra RAMDACs e.g. SC11486, SC11481, SC11488):
		 Enable HiColor feature: beside other assignments,
		 consequtive read 3C6h 4 times and write magic value 80h to it.
03C7  -W  (VGA,MCGA,CEG-VGA) PEL address register (read mode)
		 Sets DAC in read mode and assign start of color register
		 index (0..255) for following read accesses to 3C9h.
		 Don't write to 3C9h while in read mode. Next access to
		 03C8h will stop pending mode immediatly.
03C7  -W  (CEG-Color VGA w/ Edsun Labs RAMDACs)
		 Enable and set Countinous Edge Graphics Mode:
		 Consecutive writely the following three key sequences in read
		 mode (!) to 3C9h register DEh : 'CEG', 'EDS', 'UNx' (x see
		 below). Current CEG mode can be read from palette register
		 BFh 'blue', write access to that register will disable CEG
		 features.
		 In CEG modes by combining old with new colors and dynamically
		 changing palette values, the effective colors displayable
		 are enhanced dramatically (in EDP modes up to virtually 32bit
		 truecolor) on standard 16/256 color VGA. Also, effective
		 resolution enhancement takes effect by anti-aliasing.
		 Necessary EDP escape sequences should be moved to image
		 border or single colored areas, if possible.

		 REP-mode: if pixel are doubled in current video mode
		 EDP-mode: pseudo-truecolor with Edsun dynamic palette
		 (see #P446,#P447)

		 Palette-color-register single-byte-format (each 3 times):
		  Mode A:		  Mode C:
		   bit7-4: mix code	   bit3	 : 0=color, 1=code
		   bit3-0: color code	   bit2-0: color / mix code
		  Mode B:		  Mode D:
		   bit7-5: mix code	   bit7-0: see mix code table
		   bit4	 : 0=new, 1=old	  Non-CEG modes:
		   bit3-0: color code	   bit7-0: as usual

		 In EDP modes, video-memory-palette-changing escape-sequences:
		  Mode A:     Mode B:	  Mode C:     Mode D:
		   7/escape    7/escape	   7/escape    0BFh
		   red	       red	   red7-4      red
		   green       green	   red3-0      green
		   blue	       blue	   green7-4    blue
		   address     address	   green3-0    address
					   blue7-4
					   blue3-0
					   address
03C7  R-  VGA	DAC state register
		bit7-2 reserved
		bit1-0: 00b write palette cycle (write mode)
			01h reserved
			10b reserved
			11b read palette cycle (read mode)
03C8  RW  (VGA,MCGA) PEL address register (write mode)
		 Sets DAC in write mode and assign start of color register
		 index (0..255) for following write accesses to 3C9h.
		 Don't read from 3C9h while in write mode. Next access to
		 03C8h will stop pending mode immediatly.
03C8  RW  (Genoa SuperEGA) SuperEGA control register (all emulation modes)
		  bit7-2: reserved
		  bit1	: 0=EGA mode, 1=backward compatibility mode
		  bit0	: not used
03C8  R?  (S3 Trio32/64) General Input Port (see #P486)
03C9  RW  (VGA,MCGA) PEL data register
		 Three consequtive reads (in read mode) or writes (in write
		 mode) in the order: red, green, blue. The internal DAC index
		 is incremented each 3rd access.
		  bit7-6: HiColor VGA DACs only: color-value bit7-6
		  bit5-0:			 color-value bit5-0

(Table P446)
Values for EDSUN CEG (Continuous Edge Graphics) modes::
 x:  mode:	 colors:  mix:	pixel depth:  effective colors:
 0 = disabled	   256	   -	     8		    256
 1 = A		    16	  16	     8		   1920
 2 = A+REP	    16	  16	  8 dblscn	   1920
 3 = A+EDP	    15	  16			truecolor
 4 = reserved	     -	   -	     -		     -
 5 = B		    16	   8	     8		    960
 6 = B+REP	    16	   8	  8 dblscn	    960
 7 = B+EDP	    15	   8			truecolor
 8 = reserved	     -	   -	     -		     -
 9 = C		     8	   8	     4		    224
 10 = C+REP	     8	   8	  4 dblscn	    224
 11 = C+EDP	     7	   8			truecolor
 12 = reserved	     -	   -	     -		     -
 13 = D		   223	  32	     8		 792096
 14 = D+REP	   223	  32	  8 dblscn	 792096
 15 = D+EDP	   223	  32			truecolor
SeeAlso: #P447

(Table P447)
Values for EDSUN CEG mixing codes:
 Mode A:	       |  Mode C:
 mix: new:	old:   |   mix: new:   old:   colorcode:
   0 = 32/32	0/32   |    0 =	  -	 -     0
   1 = 30/32	2/32   |    1 =	  -	 -     1
   2 = 28/32	4/32   |    2 =	  -	 -     2
   3 = 26/32	6/32   |    3 =	  -	 -     3
   4 = 24/32	8/32   |    4 =	  -	 -     4
   5 = 22/32   10/32   |    5 =	  -	 -     5
   6 = 20/32   12/32   |    6 =	  -	 -     6
   7 = 18/32   14/32   |    7 =	  -	 -     7/EDP
   8 = 16/32   16/32   |    8 = 30/32	2/32   -
   9 = 14/32   18/32   |    9 = 28/32	4/32   -
  10 = 12/32   20/32   |   10 = 26/32	6/32   -
  11 = 10/32   22/32   |   11 = 24/32	8/32   -
  12 =	8/32   24/32   |   12 = 22/32  10/32   -
  13 =	6/32   26/32   |   13 = 20/32  12/32   -
  14 =	4/32   28/32   |   14 = 18/32  14/32   -
  15 =	2/32   30/32   |   15 = 16/32  16/32   -
---Mode B:	       |  Mode D:
 mix: new:	old:   |   mix:	      new:   old:  description:
   0 = 30/32	2/32   |   00h..BEh =	-      -   normal color
   1 = 26/32	6/32   |   BFh	    =	-      -   EDP
   2 = 22/32   10/32   |   C0h	    = 32/32   0/32
   3 = 18/32   14/32   |   C1h	    = 31/32   1/32
   4 = 14/32   18/32   |   C2h	    = 30/32   2/32
   5 = 10/32   22/32   |   ...	    =  ...    ...
   6 =	6/32   26/32   |   DFh	    =  0/32  32/32
   7 =	2/32   30/32   |   E0h-FFh  =	-      -   normal color
SeeAlso: #P446
--------V-P03CA03CD--------------------------
PORT 03CA-03CD - EGA/VGA/MCGA - GRAPHICS POSITION
Range:	PORT 03C0h or PORT 02C0h (alternate)
SeeAlso: PORT 03C0h,PORT 03C2h,PORT 03C4h,PORT 03C6h,PORT 03CEh"EGA",PORT 03D0h

03CA  -W  EGA	graphics 2 position register
03CA  R-  VGA	feature control register (see PORT 03BAh,PORT 03DAh-W)
03CB  RW  (ET4000/W32) GDC segment select register 2 ('key' protected?)
		The existence of this r/w register 0..255 is often
		 used to decide between ET4000 and ET4000/W32.
		 bit7-6: reserved, but existent
		 bit5-4: bits 5-4 of read segment pointer
		 bit3-2: reserved, but existent
		 bit1-0: bits 5-4 of write segment pointer
03CC  -W  EGA	graphics 1 position register
03CC  R-  VGA	miscellaneous output register (see PORT 03C2h-W,#P417,#P537)
03CD  RW  (ET3000, ET4000, ET4000/W32) GDC segment select ('key' protected)
		The existence of this r/w register is often used as
		detection of ET3000, ET4000 and ET4000/W32 chips.
		 bit7-4: read segment pointer for mapping to A0000h
		 bit3-0: write segment pointer for mapping to A0000h
--------V-P03CE03CF--------------------------
PORT 03CE-03CF - EGA/VGA/MCGA - GRAPHICS CONTROLLER REGISTERS
Range:	PORT 03CEh or PORT 02CEh (alternate EGA)
SeeAlso: PORT 03C0h,PORT 03C2h,PORT 03C4h,PORT 03C6h,PORT 03D0h
SeeAlso: PORT 03CEh"Chips&Technologies"

03CE  -W  EGA	GDC index register
03CE  RW  VGA	graphics address register / GDC index
		      bit7-4: reserved
		      bit3-0: index
03CF  -W  EGA	GDC data register (see #P448)
03CF  RW  VGA	other graphics register (see #P448)

(Table P448)
Values for EGA/VGA indexed registers in GDC:
 00h	set/reset register (default 00h)
	functionality depending on write mode (register 05h) (see #P452)
	bit7-4: reserved
	bit3  : 0=write 00h, 1=write FFh in plane 3
	bit2  : 0=write 00h, 1=write FFh in plane 2
	bit1  : 0=write 00h, 1=write FFh in plane 1
	bit0  : 0=write 00h, 1=write FFh in plane 0
 01h	enable set/reset register (default 00h) (see #P449)
 02h	color compare register (default 00h) (see #P450)
 03h	data rotate register (default 00h) (see #P451)
 04h	read map select register (default 00h)
	bit7-3: reserved
	bit2  : EGA?? & Genoa SuperEGA: map select bit2
	bit1-0: map select (0..3)
 05h	mode register (see #P452)
 06h	miscellaneous register (see #P453)
 07h	color don't care register
	bit7-4: reserved
	bit3=1: color plane 3 don't care (ignore bit3)
	bit2=1: color plane 2 don't care (ignore bit2)
	bit1=1: color plane 1 don't care (ignore bit1)
	bit0=1: color plane 0 don't care (ignore bit0)
 08h	bit mask register (default FFh)
	bit7-0: bitmask for latch/databyte
	      (bit set=change allowed)
---Paradise SuperVGA---
 0Fh	lock register
	The ability to write and reread 00h..07h to this register
	is often used as detection of Paradise chips.
	bit7-0 = 01h lock/hide Paradise specific registers
	       = 05h unlock Paradise specific registers
	bit7-3: reserved
	bit2-0: flipflops, reserved
SeeAlso: #P454

Bitfields for EGA/VGA GDC enable set/reset register:
Bit(s)	Description	(Table P449)
 7-4	reserved (used on Genoa SuperEGA???)
 3	enable set/reset plane 3
 2	enable set/reset plane 2
 1	enable set/reset plane 1
 0	enable set/reset plane 0
 3-0	0=CPU access, 1=set/reset access to plane
SeeAlso: #P448

Bitfields for EGA/VGA GDC color compare register:
Bit(s)	Description	(Table P450)
 7-4	reserved
 3	color compare 3
 2	color compare 2
 1	color compare 1
 0	color compare 0
 3-0	(color number)
SeeAlso: #P448

Bitfields for EGA/VGA data rotate register (GR3):
Bit(s)	Description	(Table P451)
 7-5	reserved
 4-3	logical function select
	00 CPU-data overwrites
	01 CPU-data AND with latch-register
	10 CPU-data OR with latch-register
	11 CPU-data XOR with latch-register
 2-0	rotate count
SeeAlso: #P448

Bitfields for EGA/VGA GDC mode register:
Bit(s)	Description	(Table P452)
 7	reserved
 6	(VGA) 0=standard, 1=enable 256 colors
 5	shift register mode, 0=standard, 1=CGA-graphics
	  (not used on Genoa SuperEGA???)
 4=1	enable odd/even address mode
 3	read mode, 0=mode0, 1=mode1
 2	(EGA) test condition, 0=standard, 1=output tristate
 1-0	write mode
	00 mode0, plane source is CPU or set/reset
	01 mode1, plane source is latch-register
	10 mode2, plane source is CPU as set/reset
	11 (VGA) mode3, CPU as set/reset AND bitmask
SeeAlso: #P448

Bitfields for EGA/VGA GDC miscellaneous register:
Bit(s)	Description	(Table P453)
 7-4	reserved (=0)
 3-2	memory map
	00b = A0000..BFFFF (128KB)
	01b = A0000..AFFFF (64KB)
	10b = B0000..B7FFF (32KB)
	11b = B8000..BFFFF (32KB)
 1	chain odd maps to even, 1=subst addess bit0
 0	0=testmode, 1=graphics mode
SeeAlso: #P448
--------V-P03CE03CF--------------------------
PORT 03CE-03CF - Chips&Technologies - GRAPHICS CONTROLLER EXTENDED REGISTERS
SeeAlso: PORT 03CE"EGA"

03CE  RW  graphics address register / GDC index
03CF  RW  other graphics register (see #P454)

(Table P454)
Values for Cirrus CL-GD7556 extended GDC registers:
 00h-08h same as EGA/VGA (see #P448)
 09h	"GR9" display memory offset 0
 0Ah	"GRA" display memory offset 1
 0Bh	"GRB" graphics controller mode extensions
 0Ch	"GRC" color key compare value / chroma key Y minimum
 0Dh	"GRD" color key compare mask / chroma key Y maximum
 0Eh	"GRE" DPMS control
 10h	"GR10" background color expansion 1
 11h	"GR11" foreground color expansion 1
 13h	"GR13" foreground color expansion 2
 16h	"GR16" scanline counter readback (low)
 17h	"GR17" scanline counter readback (high)
 18h	"GR18" EDO RAM control
 1Ah	"GR1A" scratch pad #6
 1Bh	"GR1B" scratch pad #7
 1Ch	"GR1C" chroma-key U minimum
 1Dh	"GR1D" chroma-key U maximum
 1Eh	"GR1E" chroma-key V minimum
 1Fh	"GR1F" chroma-key V maximum
 20h	"GR20" BitBLT width (low)
 21h	"GR21" BitBLT width (high)
 22h	"GR22" BitBLT height (low)
 23h	"GR23" BitBLT height (high)
 24h	"GR24" BitBLT destination pitch (low)
 25h	"GR25" BitBLT destination pitch (high)
 26h	"GR26" BitBLT source pitch (low)
 27h	"GR27" BitBLT source pitch (high)
 28h	"GR28" BitBLT destination address (low)
 29h	"GR29" BitBLT destination address (middle)
 2Ah	"GR2A" BitBLT destination address (high)
 2Ch	"GR2C" BitBLT source address (low)
 2Dh	"GR2D" BitBLT source address (middle)
 2Eh	"GR2E" BitBLT source address (high)
 2Fh	"GR2F" BitBLT destination write mask
 30h	"GR30" BitBLT mode
 31h	"GR31" BitBLT start/status
 32h	"GR32" BitBLT raster operation
 33h	"GR33" BitBLT mode extensions
!!! (details to be added)
Note:	the scratch pad registers are reserved for use by the VGA BIOS
SeeAlso: #P448
--------V-P03CE03CF--------------------------
PORT 03CE-03CF - Compaq Qvision - Functionality Level

03CE  -W  graphics address register (index for next port) (see #P455)
03CF  RW  other graphics register

(Table P455)
Values for Compaq QVision graphics register index:
 0Ch  RO    controller version
		2Fh Advanced VGA
		37h early QVision 1024
		71h QVision 1280 or later QVision 1024
 0Dh	    extended controller version
 0Eh	    extended controller capabilities
 0Fh	    environment info
 54h	    available memory
 55h	    phase-locked-loop clock
 56h-57h    controller capabilities
--------V-P03D003D3--------------------------
PORT 03D0-03D3 - CGA (Color Graphics Adapter) - MIRRORS OF 03D4/03D5

03D0  -W  same as PORT 03D4h
03D1  RW  same as PORT 03D5h
03D2  -W  same as PORT 03D4h
03D3  RW  same as PORT 03D5h
--------V-P03D403D5--------------------------
PORT 03D4-03D5 - COLOR VIDEO - CRT CONTROL REGISTERS

03D4  rW  CRT (6845) register index   (CGA/MCGA/color EGA/color VGA)
	selects which register (0-11h) is to be accessed through 03D5
	this port is r/w on some VGA, e.g. ET4000
	    bit 7-6 =0: (VGA) reserved
	    bit 5   =0: (VGA) reserved for testage
	    bit 4-0   : selects which register is to be accessed through 03D5
03D5  -W  CRT (6845) data register   (CGA/MCGA/color EGA/color VGA) (see #P456)
	selected by PORT 03D4h. registers 0C-0F may be read
	  (see also PORT 03B5h)
	MCGA, native EGA and VGA use very different defaults from those
	  mentioned for the other adapters; for additional notes and
	  registers 00h-0Fh and EGA/VGA registers 10h-18h and ET4000
	  registers 32h-37h see PORT 03B5h (see #P402)
	registers 10h-11h on CGA, EGA, VGA and 12h-14h on EGA, VGA are
	  conflictive with MCGA (see #P458)

(Table P456)
Values for EGA/VGA+ CRT Controller register index:
 00h-0Fh	same as MDA/CGA (see #P402)
 10h R-	native VGA with bit7=1 in end horizontal blanking (03h) and ET4000:
	       start vertical retrace
 10h -W start vertical retrace
 11h R- native VGA with bit7=1 in end horizontal blanking (03h):
	       end vertical retrace
 11h -W end vertical retrace
	       bit7  : VGA: protection bit
			    =0 enable write access to 00h-07h
			    =1 read only regs 00h-07h with the exception
			       of bit4 in 07h. ET4000: protect 35h also.
	       bit6  : VGA: =0 three, =1 five refreshcycles/line
		       ET4000: reserved
	       bit5=0: (MCGA also) enable vertical interrupt
	       bit4=0: (MCGA also) clear vertical interrupt
		   =1:		   no effect
	       bit3-0: (MCGA also) vertical retrace end
 12h	vertical display end register
 13h	row offset register
	       logical screen line width in
		byte mode : bytes/(line/2)
		word mode : bytes/(line/4)
		dword mode: bytes/(line/8)
 14h	underline location register
	       bit7: reserved (0)
	       bit6: (VGA) 0=word-mode, 1=dword-mode (see 17h, bit6)
	       bit5: (VGA) 0=standard address counter clock
			   1=address counter clock/4 (see 17h, bit3)
	       bit4-0: horizontal underline row scan
 15h	(EGA,VGA) start vertical blanking-1
 16h	(EGA,VGA) end vertical blanking register
	       bit7-5 : EGA: reserved, but used on original EGA???
	       bit4-0 : end vertical blanking
 17h	(EGA,VGA) "CR17" mode control register (see #P405)
 18h	(EGA,VGA) "CR18" line compare register
 19h	Genoa SuperEGA only: double scan control
	       at 3B5h only in MDA, HGC emulation, but at 3D5h even in
	       mono EGA modes.
	       bit7-5 : reserved
	       bit4   : HR/VR width adjust flag for double scan mode
	       bit3-1 : 1=test, 0=normal
	       bit0   : double scan enable
 22h	(VGA) "CR22" CPU Latch Data Register (read-only)
 24h	(VGA) "CR24" Attribute Controller Toggle register (R-O) (see #P457)
 3xh	(VGA)  !!!chips\64200.pdf p.57
Notes:	registers 10h-14h on the MCGA have conflicting uses (see #P458)
	registers 22h,24h, and 3xh exist on the standard IBM VGA but were not
	  documented
SeeAlso: #P504,#P464,#P465

Bitfields for VGA "CR24" Attribute Controller Toggle register:
Bit(s)	Description	(Table P457)
 7-3	current attribute controller index
 2	palette address source
 1	reserved
 0	state of attribute-controller flip-flop (0 = index, 1 = data)
Note:	this register was not documented for the original IBM VGA; this
	   description is from the C&T Wingine documentation
SeeAlso: #P456,#P466

(Table P458)
Values for MCGA (only) CRT Controller register index:
 00h-0Fh	same as MDA/CGA (see #P402)
 10h -W mode control register (defaults 18h, 1Ah, 19h) (see #P459)
 10h R-	mode control status register (see #P460)
 11h -W	interrupt control register (default 30h) (see #P461)
 12h RW	character generator/sync polarity register (see #P462)
 12h R-	display sense register (int. control reg [11h] bit7=1)
	bit 7-2	 : not used
	bit 1-0	 : pins 11 & 12 in monitor cable
		00b = reserved
		01b = analogue monochrom monitor
		10b = analogue color graphics monitor
		11b = no monitor
 13h -W character font pointer register (see #P458)
	only 00h, 10h, 20h, 30h (default 00h) are allowed here
	  for textmode fonts at A0000, A2000, A4000, A6000
 14h -W	number of characters to load during vert. retrace period (default FFh)
Note:	registers 10h-14h can appear at PORT 03D5h only, not at 03B5h
SeeAlso: #P402,#P456,#P504,#P463

Bitfields for MCGA (only) CRT mode control register:
Bit(s)	Description	(Table P459)
 7	suppress hsync/vsync
 6	reserved (0)
 5	reserved
 4	dot clock rate
 3	refresh calculations in 80x25 modes
 2	reserved
 1	videomode 11h active
 0	videomode 13h active
SeeAlso: #P458,#P460

Bitfields for MCGA (only) CRT mode control status register:
Bit(s)	Description	(Table P460)
 7	status bit0 CGA mode control register
 6	reserved
 5	clockrate 640 pixel, =0: clockrate/2 320 pixel
 4	clock rate is 25,175Mhz
 3	currently in textmode
 2	double-scan activated
 1	videomode 11h active
 0	videomode 13h active
SeeAlso: #P458,#P459

Bitfields for MCGA (only) CRT interrupt control register:
Bit(s)	Description	(Table P461)
 7	set output driver to tristate
	=0: for reading of character generator reg (12h)
	=1: for reading of display sense register (12h)
 6   R	intr generated by memory controller
 5	=0 requested intr ok to handle
 4	=0 free interrupt latch register
 3-0	reserved
SeeAlso: #P458

Bitfields for MCGA (only) CRT character generator/sync polarity register:
Bit(s)	Description	(Table P462)
 7	character generator active
 6	=1 load codepage during display
	=0 load codepage during retrace
 5	codepage number (0,1)
 4	512 characters active
 3	reserved (0)
 2	enable hsync/vsync
 1	positive vsync polarity
 0	positive hsync polarity
Note:	default 46h in all modes, except 04h in mode 11h)
SeeAlso: #P458
--------V-P03D403D5--------------------------
PORT 03D4-03D5 - Chips&Technologies VIDEO CHIPS - EXTENDED CRT CONTROL REGISTERS
SeeAlso: PORT 03D4h"COLOR VIDEO",PORT 03D4h"Tseng"

03D4  RW  CRT control register index (see #P463)
03D5  RW  CRT control register value

(Table P463)
Values for Chips&Technologies CRT Controller register index:
 00h-18h same as EGA/VGA (see #P456)
 22h	same as VGA (see #P456)
 24h	same as VGA (see #P456)
---C&T 82C4xx---
 D3h RW "RD3" 82C426: gray-level control 1 !!!chips\82c426.pdf p.16
 D4h RW "RD4" 82C426: gray-level control 2
 D5h RW "RD5" 82C426: general purpose
 D6h RW "RD6" 82C426: sleep
 D7h RW "RD7" 82C426: panel size
 D8h RW "RD8" 82C426: panel configuration
 D9h RW "RD9" AC control   !!!chips\82c425.pdf p.27
 DAh RW "RDA" threshold
 DBh RW "RDB" shift parameter
 DCh RW "RDC" horizontal sync width
 DDh RW "RDD" vertical sync width / blink control
 DEh RW "RDE" timing control
 DFh RW "RDF" function control
SeeAlso: #P402,#P458,#P504,#P464
--------V-P03D403D5--------------------------
PORT 03D4-03D5 - Cirrus Logic VIDEO CHIPS - EXTENDED CRT CONTROL REGISTERS
SeeAlso: PORT 03D4h"COLOR VIDEO",PORT 03D4h"Tseng"

03D4  RW  CRT control register index (see #P464)
03D5  RW  CRT control register value

(Table P464)
Values for Cirrus Logic CRT Controller register index:
 00h-18h same as EGA/VGA (see #P456)
---Cirrus CL-GD7556---
 19h	"CR19" Interlace End
 1Ah	"CR1A" miscellaneous control
 1Bh	"CR1B" extended display control
 1Ch	"CR1C" horizontal total and sync
 1Dh	"CR1D" color key compare type
 22h	same as VGA (see #P456)
 24h	same as VGA (see #P456)
 25h	"CR25" revision
 26h	"CR26" attribute controller index readback
 27h	"CR27" device identification
 30h	"CR30" TV-OUT control
 31h	"CR31" Video Window horizontal upscaling coefficient
 32h	"CR32" Video Window vertical upscaling coefficient
 33h	"CR33" Video Window horizontal start (high)
 34h	"CR34" Video Window horizontal start (low)
 35h	"CR35" Video Window brightness
 36h	"CR36" Video Window vertical position extension
 37h	"CR37" Video Window vertical start
 38h	"CR38" Video Window vertical height
 ...
 42h	"CR42" Video Window FIFO threshold / chroma-key mode
 50h	"CR50" V-Port hardware configuration
 ...
 5Fh	"CR5F" V-Port capture window start address (low)
 80h	"CR80" power management control
 ...
 91h	"CR91" shading map offset
 A0h	"CRA0" CRT horizontal 8-dot character clock
 ...
 BFh	"CRBF" CRT vertical back porch
!!! details to be added
SeeAlso: #P402,#P504,#P465
--------V-P03D403D5--------------------------
PORT 03D4-03D5 - S3 VIDEO CHIPS - EXTENDED CRT CONTROL REGISTERS
SeeAlso: PORT 03D4h"COLOR VIDEO",PORT 03D4h"Tseng"

03D4  RW  CRT control register index (see #P465)
03D5  RW  CRT control register value

(Table P465)
Values for S3, Inc. CRT Controller register index:
 00h-18h same as EGA/VGA (see #P456)
 22h	same as VGA (see #P456)
 24h	"CR24" attribute controller index/data status
 26h R- "CR24" (duplicate of 24h)
 2Dh R- "CR2D" new Chip ID (high) (same as high byte of PCI device ID)
 2Eh R- "CR2E" new chip ID (low) (same as low byte of PCI device ID)
		10h Trio32
		11h Trio64
 2Fh R- "CR2F" S3 7xx/866/x68: chipset revision
		chip ID 8811h is Trio64/64V+; revision 4xh or 5xh is Trio64V+
 30h RW	"CR30" chip ID/revision (see #P467)
 31h RW	"CR31" memory configuration (see #P468)
 32h RW "CR32" backward compatibility 1 (see #P469)
 33h RW "CR33" backward compatibility 2 (see #P470)
 34h RW "CR34" backward compatibility 3 (see #P471)
 35h RW "CR35" CRT register lock (see #P472)
 36h R	"CR36" Reset State read 1 (see #P473)
 37h R	"CR37" Reset State read 2 (see #P474)
 38h RW	"CR38" S3 Register lock 1
	set reg 38h to 48h and reg 39h to A5h to unlock other S3 registers
 39h RW	"CR39" S3 Register lock 2
 3Ah RW "CR3A" S3 Miscellaneous 1 (see #P475)
	bit 4: ???
 3Bh RW "CR3B" Data Transfer Execute position (see #P476)
 3Ch RW "CR3C" Interlace Retrace start position (see also #P478)
 40h RW "CR40" System Configuration (see #P477)
 41h	"CR41" BIOS Flag register (used by S3 BIOS)
 42h RW "CR42" mode control (see #P478)
 43h RW "CR43" extended mode (see #P479)
 45h RW "CR45" hardware graphics cursor mode (see #P480)
 46h RW "CR46" hardware cursor origin X (hi), bits 2-0 only
 47h RW "CR47" hardware cursor origin X (lo)
	testing that register 47h can be read and written once the S3 registers
	  are unlocked is used as an S3 installation check
 48h RW	"CR48" hardware cursor origin Y (hi), bits 2-0 only
	the cursor X/Y position is latched on writing the high byte of Y
 49h RW "CR49" hardware cursor origin Y (lo)
 4Ah RW "CR4A" hardware graphics cursor foreground stack
	read register 45h, then write 2 or 3 color bytes (16/24-bit color)
	  to specify foreground color of hardware cursor
 4Bh RW "CR4B" hardware graphics cursor background stack
	read register 45h, then write 2 or 3 color bytes (16/24-bit color)
	  to specify background color of hardware cursor
 4Ch RW "CR4C" hardware graphics cursor map start address (hi), bits 3-0 only
 4Dh RW "CR4D" hardware graphics cursor map start address (lo)
 4Eh RW "CR4E" hardware cursor pattern start X (bits 5-0 only)
 4Fh RW "CR4F" hardware cursor pattern start Y (bits 5-0 only)
 50h RW "CR50" S3 801+: Extended System Control 1 (see #P481)
 51h RW "CR51" S3 801+: Extended System Control 2 (see #P482)
 52h RW "CR52" S3 801+: Extended BIOS Flag 1
		bits 7-6 are sync polarities (see #P417) for Diamond cards
 53h RW "CR53" S3 801+: Extended Memory Control 1 (see #P483)
 54h RW "CR54" S3 801+: Extended Memory Control 2 (see #P484,#P485)
 55h RW "CR55" S3 801+: Extended Video DAC Control (see #P486)
 56h RW "CR56" S3 801+: External Sync Control 1 (see #P487)
 57h RW "CR57" S3 801+: External Sync Control 2 (see #P488)
 58h RW "CR58" S3 801+: Linear Address Window Control (see #P489)
 59h RW "CR59" S3 801+: Linear Address Window Position (bits 31-24)
 5Ah RW "CR5A" S3 801+: Linear Address Window Position (bits 23-16)
	Notes:	the address is forced to be a multiple of the memory window
		  size (see #P489) by ignoring the lowest bits
		for Trio64 new memory-mapped I/O, the LAW must be on a 64M
		  boundary
 5Bh RW "CR5B" S3 801+: Extended BIOS Flag 2
 5Ch RW "CR5C" S3 801+: General Output Port (see #P490)
 5Dh RW "CR5D" S3 801+: Extended Horizontal Overflow (see #P491)
 5Eh RW "CR5E" S3 801+: Extended Vertical Overflow (see #P492)
 5Fh RW "CR5F" S3 928/964: Bus Grant Termination Position
 60h RW "CR60" S3 864/964: extended memory control 3 (see #P493)
 61h RW "CR61" S3 864/964/Trio: extended memory control 4 (see #P494)
 62h RW "CR62" S3 864/964: extended memory control 5
 63h RW "CR63" S3 864/964: external sync delay adjustment (high) (see #P495)
 64h RW "CR64" S3 864/964: genlocking adjustment
 65h RW "CR65" S3 864/964: extended miscellaneous control (see #P496)
 66h RW "CR66" S3 864/964: extended miscellaneous control 1 (see #P497)
 67h RW "CR67" S3 864/964: extended miscellaneous control 2 (see #P498)
 67h RW "CR67" S3 Trio32/64: extended miscellaneous control 2 (see #P499)
 68h RW "CR68" S3 864/964: configuration 3 (see #P500)
 69h RW "CR69" S3 864/964: extended system control 3 (see #P501)
 6Ah RW "CR6A" S3 864/964: extended system control 4
		(bits 5-0 = offset of 64K bank)
 6Bh RW "CR6B" S3 864/964: extended BIOS flag 3
 6Ch RW "CR6C" S3 864/964: extended BIOS flag 4
 6Dh RW "CR6D" S3 864/964: extended miscellaneous control
 6Dh RW "CR6D" S3 Trio64V+: extended BIOS flag 5 (reserved for BIOS)
 6Eh RW "CR6E" S3 Trio64V+: extended BIOS flag 6 (reserved for BIOS)
 6Fh RW "CR6F" S3 Trio64V+: configuration 4 (see #P503)
SeeAlso: #P402,#P458,#P504,#P464,#P463

Bitfields for S3 "CR24" Attribute Index register:
Bit(s)	Description	(Table P466)
 7	inverse of current state of internal address flip-flop
 6	reserved (0)
 5	video display is enabled (mirror of PORT 03C0h bit 5)
 4-0	current attribute contorller index (from PORT 03C0h)
SeeAlso: #P456,#P457,PORT 03C0h

(Table P467)
Values for S3 chip ID/Revision register "CR30":
 81h	86c911
 82h	86c911A/924
 90h	86c928 (original)
 ...
 A0h	86c801/805 A-step or B-step
 ...
 B0h	86c928 PCI
 C0h	Vision864
 C1h	Vision864P
 D0h	Vision964
 D1h	Vision964P
 Exh	Trio32/64, 86c866, 86c868, 86c968; actual ID and revision stored in
	  PORT 03B5h registers 2Dh, 2Eh, and 2Fh
SeeAlso: #P468

Bitfields for S3 "CR31" memory configuration register:
Bit(s)	Description	(Table P468)
 7	(except 864/964) enable BIOS ROM address space C6800h-C7FFFh
	(Trio64V+) reserved
 6	enable page-mode memory access for text-mode font access
 5-4	display start address, bits 17&16.  See also registers 51h and 69h
 3	video memory above 256K accessible
 2	VGA 16-bit memory bus (clear for 8-bit memory bus)
 1	two-page screen image (enables 2048-pixel wide screen)
 0	enable base-address offset (turn on bank-switched operation)
SeeAlso: #P456,#P467,#P469

Bitfields for S3 "CR32" Backwards Compatibility 1 register:
Bit(s)	Description	(Table P469)
 7	(928,964) tri-state serial output pins SC, SOE0, and SXNR
 6	fix VGA screen page using display start address bits 16&17 (see #P468)
	(Trio64V+) force wrap on 256K boundary even when display start address
	  changed
 5	???
 4	enable hardware interrupts
 3	backward-compatible modes (set for MDA/CGA/EGA/HGC)
 2	force full character clock for horizontal timing (CGA/HGC emulation),
	  rather than 1/2 dot clock rate
 1-0	character clock period
	00 IBM-compatible, 8 or 9 dots
	01 7 dots
	10 9 dits
Note:	on the Trio64V+, bits 7, 5, and 3-0 are reserved
SeeAlso: #P468,#P470,#M076

Bitfields for S3 "CR33" Backwards Compatibility 2 register:
Bit(s)	Description	(Table P470)
 7	override CGA "enable video" at PORT 03D8h bit 3
 6	lock palette/overscan registers
 5	blank signal does not include border area, is same as display enable
 4	disable writes to RamDAC
 3	VCLK is internal DCLK rather than inverted DCLK/2 or external VCLK
 2	reserved (Trio32/64)
 1	disable VDE protection (PORT 03D4h register 11h bit 7 will not act
	  on PORT 03D4h register 7h bits 1 and 6)
 0	reserved (Trio32/64)
Note:	on the Trio64V+, bits 7, 2, and 0 are reserved
SeeAlso: #P456,#P469,#P471

Bitfields for S3 "CR34" Backwards Compatibility 3 register:
Bit(s)	Description	(Table P471)
 7-5	(Trio32/64/64V+) reserved
 7	lock PORT 03C2h bits 2,3
 5	lock SR1 bit 5
 4	enable Start Display FIFO Fetch register (CR3B) (see #398)
 3	(Trio32/64/64V+) reserved
 2	PCI retries not handled during DAC cycles (requires bit 0 clear)
 1	do not handle PCI master aborts during DAC cycles (requires bit 0 clear)
 0	disable PCI master aborts/retries during DAC cycles
SeeAlso: #P470,#P472

Bitfields for S3 "CR35" Register Lock register:
Bit(s)	Description	(Table P472)
 7-6	(Trio32/Trio64) reserved
 5	lock horizontal timing registers
 4	lock vertical timing registers
 3-0	CPU base address (in 64K units), bits 17-14
SeeAlso: #P456,#P471,#P473

Bitfields for S3 "CR36" Configuration 1 register:
Bit(s)	Description	(Table P473)
 7-5	video memory size
	111 less than 1M
	110 one meg
	100 two megs
	010 three megs
	000 four megs
	101 six megs
	011 eight megs
 4	(Trio32/64, VL-Bus only) enable video BIOS accesses
 3-2	(Trio32/64) memory type
	00 reserved
	01 reserved
	10 EDO
	11 fast page mode
 1-0	(Trio32/64) system bus type
	00 reserved
	01 VESA local bus
	10 PCI
	11 reserved
Note:	the default value of this register is latched from external pins at
	  power-up; bits 1-0 are read-only
SeeAlso: #P456,#P472,#P474

Bitfields for S3 "CR37" Configuration 2 register:
Bit(s)	Description	(Table P474)
 7-5	monitor type
 7-5	(Trio64V+) reserved
 4	(VL-Bus) enable RAMDAC write snooping
 3	use internal DCLK/MCLK (clear this bit for testing only)
 2	(VL-Bus) video BIOS ROM size (=0 64K, =1 32K)
 1	test mode select (=0 tri-state all outputs, =1 normal operation)
 1	(Trio64V+) reserved
 0	(VL-Bus) enable Trio chip (if 0, disabled except for video BIOS access)
Notes:	the default value of this register is latched from external pins at
	  power-up
	the description of this register is based on the Trio32/Trio64/Trio64V+
	  documentation and may vary somewhat for other S3 chips
SeeAlso: #P456,#P473

Bitfields for S3 "CR3A" Miscellaneous 1 register:
Bit(s)	Description	(Table P475)
 7	disable PCI burst read cycles
	(must set CR66 bit 7 before setting this bit)
 6	reserved
 5	enable high-speed text font writes (only required for DCLK > 40MHz)
 4	enable >= 8 bpp color enhanced modes
 3	enable top-of-memory access (simultaneous VGA text and enhanced mode)
 2	enable alternate refresh count control (bits 1-0)
	when enabled, bits 1-0 override CR11 bit 6
 1-0	alternate refresh count: number of refresh cycles per scan line
Note:	the description of this register is based on the Trio32/Trio64/Trio64V+
	  documentation and may vary somewhat for other S3 chips
SeeAlso: #P456

Bitfields for S3 "CR3B" Start Display FIFO Register:
Bit(s)	Description	(Table P476)
 7-0	bits 7-0 of time in characters clocks from start of active display
	  until FIFO data fetching restarts after start of horizontal blanking
	  (bit 8 is in CR5D bit 6)
Note:	the value for this register is typically CR0 less 5, and helps ensure
	  adequate time for RAM refresh, etc. taht require control of display
	  memory
SeeAlso: #P456

Bitfields for S3 "CR40" System Configuration register:
Bit(s)	Description	(Table P477)
 7-6	reserved (0)
 5	reserved ("WDL_DELAY") (1)
 4	(VL-Bus) Ready Control
	=0 zero wait-states from -SADS to -SRDY
	=1 minimum one wait state (controlled by CR58 bit 3)
 3-1	reserved (0)
 0	enable enhanced (8514/A superset) register access at PORT x2E8h
SeeAlso: #P456

Bitfields for S3 "CR42" Mode Control register:
Bit(s)	Description	(Table P478)
 7-6	reserved (0)
 5	interlaced video
 4-0	reserved
Note:	bit 5 also enables CR3C
SeeAlso: #P456,#P479

Bitfields for S3 "CR43" Extended Mode register:
Bit(s)	Description	(Table P479)
 7	double horizontal CRT parameters (CRTC registers 00h, etc.)
 6-3	reserved (0)
 3	(Trio64V+) ??? used by BIOS, officially reserved
 2	logical screen width (CR13), bit 8
 1-0	reserved (0)
Note:	bit 2 is disabled unless CR51 bits 5-4=00
SeeAlso: #P456,#P478

Bitfields for S3 "CR45" Hardware Graphics Cursor Mode register:
Bit(s)	Description	(Table P480)
 7-5	reserved (0)
 4	enable Hardware Cursor Right Storage (last 256 bytes of 1K line, or
	  last 512 bytes of 2K line)
 3-1	reserved (0)
 0	enable hardware graphics cursor in Enhanced (8514/A) mode
SeeAlso: #P456

Bitfields for S3 "CR50" Extended System Control 1 register:
Bit(s)	Description	(Table P481)
 7-6	Graphics Engine screen width
	(note: bit 0 below is MSB for the following)
	000 = 1024 (2048 if CR31 bit 1 set)
	001 = 640
	010 = 800 (1600x1200x4 if PORT 4AE8h bit 2 set)
	011 = 1280
	100 = 1152
	101 reserved
	110 = 1600
	111 reserved
 5-4	pixel length for command execution through Graphics Engine (8514/A)
	00 one byte (4 or 8 bits/pixel)
	01 two bytes (16 bpp)
	10 reserved
	11 four bytes (32 bpp)
 3	reserved (0)
 2	enable -BREQ/-BGNT functions (reserved on Trio64V+)
 1	reserved (0)
 0	bit 2 of Graphics Engine screen width (refer to bits 7-6 above)
SeeAlso: #P456,#P483,#P482

Bitfields for S3 "CR51" Extended System Control 2 register:
Bit(s)	Description	(Table P482)
 7-6	reserved (0)
 5-4	logical screen width, bits 9-8
 3-2	CPU base address, bits 19-18
 1-0	display start address, bits 19-18
Notes:	if the upper four bits of the display start address have been set via
	  CR69 bits 3-0, then bits 1-0 and CR31 bits 5-4 are ignored
	if the upper 6 base address bits have been set via CR6A bits 5-0, then
	  bits 3-2 and CR35 bits 3-0 are ignored
SeeAlso: #P456,#P481

Bitfields for S3 "CR53" Extended Memory Control 1 register:
Bit(s)	Description	(Table P483)
 7	reserved
 6	(Trio32/64/64V+) swap nybbles in each byte of video memory read or
	  written
 5	(801/805) memory interleaving
	(928) pixel multiplexing
	(Trio64V+) enable memory-mapped I/O at B8000h-BFFFFh instead of
	  A0000h-AFFFFh (only takes effect if bits 4-3=10)
 4	enable memory-mapped I/O (Trio32, Trio64 and Trio64V+)
 3	enable new memory-mapped I/O (Trio64V+)
 2-1	(Trio64V+) byte swapping for linear addressing
	00 none (default)
	01 swap bytes of word
	10 swap all bytes of doublewords
	11 reserved
	(used for big-endian addressing)
 0	(Trio32/64) enable write per bit
	(Trio64V+) reserved
SeeAlso: #P456,#P484

Bitfields for S3 Trio32/64 "CR54" Extended Memory Control 2 register:
Bit(s)	Description	(Table P484)
 7-3	"M" number of 8-byte memory cycles not dedicated to filling display
	  FIFO (less one)
 2-0	reserved (0)
SeeAlso: #P485,#P456,#P483

Bitfields for S3 Trio64V+ "CR54" Extended Memory Control 2 register:
Bit(s)	Description	(Table P485)
 2,7-3	"M" maximum number of 8-byte memory cycles before LPB/CPU/Graphics
	  Engine must yield the memory bus
 1-0	big-endian byte-swapping (except for linear addressing/image writes)
	00 none (default)
	01 swap bytes within a word
	10 swap all bytes within a doubleword
	11 swap according to bus' byte-enable lines
		BE#[3:0]=0000 swap all bytes
		BE#[3:0]=0011 or 1100 swap bytes within selected word
		else no swapping
SeeAlso: #P456,#P484 

Bitfields for S3 "CR55" Extended RAMDAC Control register:
Bit(s)	Description	(Table P486)
 7	tri-state VCLK output
 6-5	reserved (0)
 4	hardware cursor mode
	=0 MS-Windows
	=1 X11
 3	reserved (0)
 2	enable General Input Port read (at PORT 03C8h)
 1-0	reserved (0)
SeeAlso: #P456

Bitfields for S3 "CR56" External Sync Control 1 register:
Bit(s)	Description	(Table P487)
 7-5	reserved (0)
 4	preset frame select
	=0 start with odd frame after V-counter reset
	=1 start with even frame
 3	reset only vertical counter on falling edge of VSYNC input when
	  genlocking
 2	tri-state VSYNC output
 1	tri-state HSYNC output
 0	enable VSYNC input for genlocking
Note:	bits 4-3 are reserved on the Trio64V+
SeeAlso: #P456,#P488

Bitfields for S3 "CR57" External Sync Control 2 register:
Bit(s)	Description	(Table P488)
 7-0	delay in scan lines from falling edge of VSYNC to reset of V-counter
Note:	this register must NOT be 00h when genlocking is enabled (CR56 bit 0)
SeeAlso: #P456,#P487

Bitfields for S3 "CR58" Linear Addressing Control register:
Bit(s)	Description	(Table P489)
 7	RAS Pre-Charge time adjust
	=0 CR68 bit 3 defines pre-charge time
	=1 decrease pre-charge time by 0.5 MCLKs, increase RAS time by 0.5 MCLKs
 6-5	reserved
 4	enable linear addressing (see also #P601)
 3	(VL-Bus) addresses latched in T1 cycle, instead of delaying one clock
	  until T2 cycle; only in effect when CR40 bit 4 is set
 2	reserved
 1-0	linear address window size
	00 = 64K (not available when new MMIO enabled)
	01 = 1M
	10 = 2M
	11 = 4M (Trio64/64V+, not Trio32)
Note:	this description is based on the Trio32/Trio64 documenation; the
	  bits may vary slightly for other S3 chips
SeeAlso: #P471

Bitfields for S3 "CR5C" General Output Port:
Bit(s)	Description	(Table P490)
 7-0	system-specific
---Diamond---
 0	???
 1	???
---STB Pegasus---
 7	map video memory with bits 31-26 = 011111
SeeAlso: #P456

Bitfields for S3 "CR5D" Extended Horizontal Overflow register:
Bit(s)	Description	(Table P491)
 7	bit 8 of Bus-Grant Terminate Position (CR5F)
	(Trio64V+) reserved
 6	bit 8 of Start FIFO Fetch (CR3B)
 5	extend horizontal sync pulse by 32 DCLKs
 4	bit 8 of Start Horizontal Sync Position (CR4)
 3	extend horizontal blank pulse by 64 DCLKs
 2	bit 8 of Start Horizontal Blank (CR2)
 1	bit 8 of Horizontal Display End (CR1)
 0	bit 8 of Horizontal Total (CR0)
SeeAlso: #P456,#P492

Bitfields for S3 "CR5E" Extended Vertical Overflow register:
Bit(s)	Description	(Table P492)
 7	reserved (0)
 6	line compare position (CR18), bit 10
 5	reserved (0)
 4	vertical retrace start (CR10), bit 10
 3	reserved (0)
 2	start of vertical blank (CR15), bit 10
 1	vertical display end (CR12), bit 10
 0	vertical total (CR6), bit 10
SeeAlso: #P456,#P491

Bitfields for S3 Trio32/64 "CR60" Extended Memory Control 3 register:
Bit(s)	Description	(Table P493)
 7-0	"N" maximum number of 4-byte (1M video memory) or 8-byte (2M/4M) units
	  written to display FIFO in an uninterruptible burst
SeeAlso: #P456,#P494

Bitfields for S3 Trio64V+ "CR61" Extended Memory Control 4 register:
Bit(s)	Description	(Table P494)
 7	reserved
 6-5	byte-swapping for image writes
	00 none (default)
	01 swap bytes within each word
	10 swap all bytes within a doubleword
	11 reserved
 4-0	reserved
SeeAlso: #P456,#P493

Bitfields for S3 Trio32/64 "CR63" External Sync Control 3 register:
Bit(s)	Description	(Table P495)
 7-4	character clock reset delay
 3-0	HSYNC reset adjustment, in character clocks
Notes:	these two values are used to align the external and internally-generated
	  video during genlocking
	this register is not documented for the Trio64V+, and may not exist
SeeAlso: #P456

Bitfields for S3 Trio32/64/64V+ "CR65" Extended Miscellaneous Control register:
Bit(s)	Description	(Table P496)
 7-5	reserved (0)
 4-3	(Trio32/64V+) delay -BLANK by N DCLKs
	a two-DCLK delay is required for color mode 12
 2	video subsystem setup address
	(Trio64V+) reserved
	=0 PORT 46E8h
	=1 PORT 03C3h
 1-0	reserved (0)
SeeAlso: #P456,#P497

Bitfields for S3 Trio32/64/64V+ "CR66" Extended Miscellaneous Control 1 reg:
Bit(s)	Description	(Table P497)
 7	enable PCI bus disconnect on misaligned burst memory accesses
 6	tri-state pixel address bus
---Trio32/64---
 5-0	reserved (0)
---Trio64V+ ---
 5	??? (officially reservd, but set by BIOS)
 4	reserved
 3	generate PCI bus disconnect when trying to write to a full FIFO or read
	  from an empty FIFO
	(bit 7 must also be set to enable this feature)
 2	reserved
 1	software reset graphics engine
 0	enable enhanced functions (this is a mirror of
	  PORT 4AE8h bit 0)
SeeAlso: #P456,#P496,PORT 4AE8h

Bitfields for S3 864/964 "CR67" Extended Miscellaneous Control 2 register:
Bit(s)	Description	(Table P498)
 7-4	color mode???
	(values of 0000/0010/0101/0111 indicate a 16-bit pixel port)
 3-2	???
SeeAlso: #P456,#P471,#P499

Bitfields for S3 Trio32/64/64V+ "CR67" Extended Miscellaneous Control 2 reg:
Bit(s)	Description	(Table P499)
 7-4	color mode (see #P436)
 3-2	(Trio32/Trio64) reserved (0)
 3-2	(Trio64V+) streams mode
	00 disable Streams Processor
	01 overlay secondary stream on VGA-mode background
	10 reserved
	11 full Streams Processor operation
 1	reserved (0)
 0	VCLK phase (=0 VCLK is inverted DCLK; =1 VCLK in phase with DCLK)
Note:	the streams mode should only be changed during vertical sync
	  (PORT 03DAh bit 3)
SeeAlso: #P456,#P498,#P435

Bitfields for S3 Trio32/64/64V+ "CR68" Configuration 3 register:
Bit(s)	Description	(Table P500)
 7	(Trio32/64 VL-Bus) Upper Address Decode
	=0 decode all 32 bits of system address bus
	=1 SAUP input used to decode upper address lines
 7	(Trio64V+) memory data bus size
	=0 32 bits
	=1 64 bits (if >= 2M of memory)
 6-4	monitor information (used by S3 bios)
 3	RAS precharge timing (0 = 3.5 MCLKs, 1 = 2.5 MCLKs)
 2	RAS low timing (0 = 4.5 MCLKs, 1 = 3.5 MCLKs)
 1-0	-CAS and -OE stretch, -WE delay
	00 = 6.5ns stretch, 2 units delay
	01 = 5ns stretch, 1 unit delay
	10 = 3.5ns stretch, no delay
	11 = no stretch, no delay
Note:	the default value of this register is latched from external pins at
	  power-up
SeeAlso: #P456

Bitfields for S3 Trio32/Trio64 "CR69" Extended System Control 3 register:
Bit(s)	Description	(Table P501)
 7-4	reserved (0)
 3-0	display start address, bits 19-16
SeeAlso: #P456,#P502

Bitfields for S3 Trio32/Trio64 "CR6A" Extended System Control 4 register:
Bit(s)	Description	(Table P502)
 7-6	reserved
 5-0	bits 19-14 of CPU base address
Note:	CR31 bit 0 must be set to enable this register
SeeAlso: #P456,#P501

Bitfields for S3 Trio64V+ "CR6F" Configuration 4 register:
Bit(s)	Description	(Table P503)
 7-5	reserved
 4-3	WE# delay (on both rising and falling edges)
	00 three units
	01 two units
	10 one unit
	11 no delay
 2	disable I/O PORT mirror of serial port (MMIO FF20h)
	=0 allow access via either MMIO FF20h or port selected by bit 1
 1	serial port address select (only has effect if bit 2 clear)
	=0 mirror MMIO FF20h at PORT 00E8h
	=1 mirror MMIO FF20h at PORT 00E2h
 0	configure for Trio64-compatible mode instead of LPB mode
 !!! p.19-16
SeeAlso: #P456,MEM A000h:FF00h"S3"
--------V-P03D403D5--------------------------
PORT 03D4-03D5 - Tseng Labs VIDEO CHIPS - EXTENDED CRT CONTROL REGISTERS
SeeAlso: PORT 03D4h"COLOR VIDEO",PORT 03D4h"S3",PORT 03D4h"Cirrus"

03D4  RW  CRT control register index (see #P504)
03D5  RW  CRT control register value

(Table P504)
Values for Tseng Labs ET3000/ET4000 CRT Controller register index:
 00h-18h same as EGA/VGA (see #P456)
---ET3000 only---
 1Bh	x-zoom start register
	The existence of this register is often used to decide between ET3000
	  and ET4000, as the ET4000 does not offer hardware-zoom features.
 1Ch	x-zoom end register
 1Dh	y-zoom start register low
 1Eh	y-zoom end register low
 1Fh	y-zoom start & end high register
 20h	zoom start address register low
 21h	zoom start address register medium
 23h	extended start address (see register 33h)
 24h	compatibility register (see register 34h)
 25h	overflow high register (see registers 35h, 07h)
---ET4000---
 32h	RAS/CAS configuration ('key' protected) (see #P505)
 33h	extended start address
	      This register is often used to decide between ET4000
	      and ET3000, when bit3-0 can be reread after write.
	       bit7-4 : reserved
	       bit3-2 : cursor address bit 17-16
	       bit1-0 : linear start address bits 17-16
 34h	6845 compatibility control register ('key' protected)
	  (see #P506)
 35h	overflow high register (protected by 11h, bit7) (see #P507)
 36h	video system configuration 1 ('key' protected) (see #P508)
 37h	video system configuration 2 ('key' protected) (see #P509)
SeeAlso: #P402,#P464,#P465

Bitfields for ET4000 RAS/CAS configuration register:
Bit(s)	Description	(Table P505)
 7	static column memory
	ET4000/W32i: interleave mode
 6	RAL RAS&CAS column setup time
 5	RCD RAS & CAS time
 4-3	RSP, RAS pre-charge time
 2	CPS, CAS pre-charge time
 1-0	CSW, CAS low pulse width
SeeAlso: #P456,#P506

Bitfields for ET4000 compatibility control register:
Bit(s)	Description	(Table P506)
 7	6845 compatibility enabled
 6	ENBA enable double scan/underline in AT&T mode
 5	ENXL enable translation ROM on writing
 4	ENXR enable translation ROM on reading
 3	ENVS VSE register port address
 2	TRIS tristate ET4000 output pins
 1	CS2 MCLCK clock select 2
 0	EMCK enable translation of CS0 bit
SeeAlso: #P456,#P505,#P507

Bitfields for ET4000 overflow high register:
Bit(s)	Description	(Table P507)
 7	vertical interlace mode
 6	alternate RMW control
 5	external sync reset (gen-lock) the line/chr counter
 4	line compare bit10
 3	vertical sync start bit10
 2	vertical display end bit10
 1	vertical total bit10
 0	vertical blank start bit10
SeeAlso: #P456,#P506,#P508

Bitfields for ET4000 video system configuration 1 register:
Bit(s)	Description	(Table P508)
 7	enable 16bit I/O read/write
 6	enable 16bit display memory read/write
 5	addressing mode (0=IBM, 1=TLI)
 4	0=segment / 1=linear system configuration
 3	font width control (1=up to 16bit, 0=8bit)
 2-0	refresh count per line-1
SeeAlso: #P456,#P507,#P509

Bitfields for ET4000 video system configuration 2 register:
Bit(s)	Description	(Table P509)
 7	DRAM display memory type (1=VRAM, 0=DRAM)
 6	test (1=TLI interal test mode)
 5	priority threshold control (0=more mem BW)
 4	disable block read-ahead
 3	display memory data depth
 2	bus read data latch control
 1-0	display memory data bus width
SeeAlso: #P456,#P508
----------P03D603D7--------------------------
PORT 03D6-03D7 - CGA (Color Graphics Adapter) - MIRRORS OF 03D4/03D5

03D6  -W  same as 03D4
	(under OS/2, reads return 0 if full-screen DOS session,
	  nonzero if windowed DOS session)
03D7  RW  same as 03D5
----------P03D603D7--------------------------
PORT 03D6-03D7 - Chips&Technologies VGA - EXTENSION REGISTERS

03D6  -W  extension register index (see #P510)
03D7  RW  extension register data

(Table P510)
Values for Chips&Technologies extension register index:
 00h	"XR00"	chip version (see #P511)
 01h	"XR01"	configuration (see #P512)
 02h	"XR02"	CPU interface control (see #P513)
 03h	"XR03"	master control (see #P514)
 04h	"XR04"	memory control (see #P515)
 05h	"XR05"	clock control (see #P516)
 06h	"XR06"	color palette control / DRAM interface
 07h	"XR07"	reserved
 08h	"XR08"	general purpose output select B
 09h	"XR09"	general purpose output select A
 0Ah	"XR0A"	cursor address top
 0Bh	"XR0B"	CPU paging (see #P517)
 0Ch	"XR0C"	start address top (see #P518)
 0Dh	"XR0D"	auxiliary offset (see #P519)
 0Eh	"XR0E"	text mode control (see #P520)
 0Fh	"XR0F"	configuration register 2
 10h	"XR10"	single/low map register (see #P521)
 11h	"XR11"	high map register (see #P522)
 14h	"XR14"	emulation mode (see #P523)
 15h	"XR15"	write protect (see #P524)
 16h	"XR16"	trap enable
 17h	"XR17"	trap status
 18h	"XR18"	alternate horizontal display end
 19h	"XR19"	alternate horizontal sync start / half-line
 1Ah	"XR1A"	alternate horizontal sync end (see #P525)
 1Bh	"XR1B"	alternate horizontal total
 1Ch	"XR1C"	alternate horizontal blank start / horizontal panel size
 1Dh	"XR1D"	alternate horizontal blank end (see #P526)
 1Eh	"XR1E"	alternate offset
 1Fh	"XR1F"	virtual EGA switch (see #P527)
 20h	"XR20"	453 Interface ID
 21h	"XR21"	Sliding Hold A
 22h	"XR22"	Sliding Hold B
 23h	"XR23"	SHC / WBM Control
 24h	"XR24"	Flat-Panel Alternate Max Scanline / SHD / WBM Pattern
 25h	"XR25"	Flat-Panel "AltGrHVirtPanelSize" / 453 Pin Definition
 26h	"XR26"	453 Configuration
 27h	"XR27"	reserved
 28h	"XR28"	video interface (see #P528)
 29h	"XR29"	function control
 2Ah	"XR2A"	frame interrupt count
 2Bh	"XR2B"	default video color (to be displayed when screen blanked)
 2Ch	"XR2C"	Flat-Panel VSync (FLM) Delay / force H high
 2Dh	"XR2D"	Flat-Panel HSync (LP) delay / force H low
 2Eh	"XR2E"	Flat-Panel HSync (LP) delay / force V high
 2Fh	"XR2F"	Flat-Panel HSync (LP) width / force V low
 30h	"XR30"	graphics cursor start address (high)
 31h	"XR31"	graphics cursor start address (low)
 32h	"XR32"	graphics cursor end address
 33h	"XR33"	graphics cursor X (high)
 34h	"XR34"	graphics cursor X (low)
 35h	"XR35"	graphics cursor Y (high)
 36h	"XR36"	graphics cursor Y (low)
 37h	"XR37"	graphics cursor mode
 38h	"XR38"	graphics cursor mask
 39h	"XR39"	graphics cursor color 0
 3Ah	"XR3A"	graphics cursor color 1
 3Bh	"XR3B"	reserved
 3Ch	"XR3C"	serial / row count (see #P529)
 3Dh	"XR3D"	multiplexor mode (see #P530)
 41h	"XR41"	virtual EGA switch register (82C453)
 44h	"XR44"	software flag register 1
 45h	"XR45"	software flag register 2 / foreground color
 50h	"XR50"	panel format
 51h	"XR51"	display type
 52h	"XR52"	power-down control / panel size
 53h	"XR53"	line graphics override
 54h	"XR54"	flat-panel interface / alternate miscellaneous output
 55h	"XR55"	horizontal compensation / text 350_A compensation
 56h	"XR56"	horizontal centering / text 350_B compensation
 57h	"XR57"	vertical compensation / text 400 compensation
 58h	"XR58"	vertical centering / graphics 350 compensation
 59h	"XR59"	vertical line insertion / graphics 400 compensation
 5Ah	"XR5A"	vertical line replication / FP vertical display start 400
 5Bh	"XR5B"	flat-panel vertical display end 400 
 5Ch	"XR5C"	weight control clock A
 5Dh	"XR5D"	weight control clock B
 5Eh	"XR5E"	ACDCLK control
 5Fh	"XR5F"	power-down mode refresh
 60h	"XR60"	blink rate control
 61h	"XR61"	SmartMap(tm) control
 62h	"XR62"	SmartMap(tm) shift parameter
 63h	"XR63"	SmartMap(tm) color mapping control
 64h	"XR64"	flat-panel alternate vertical total
 65h	"XR65"	flat-panel alternate overflow
 66h	"XR66"	flat-panel alternate vertical sync start
 67h	"XR67"	flat-panel alternate vertical sync end
 68h	"XR68"	flat-panel vertical panel size / alternate vertical DE end
 69h	"XR69"	flat-panel vertical display start 350
 6Ah	"XR6A"	flat-panel vertical display end 350
 6Bh	"XR6B"	flat-panel vertical overflow 2
 6Ch	"XR6C"	weight control clock C
 6Dh	"XR6D"	FRC control
 6Eh	"XR6E"	polynomial FRC control
 6Fh	"XR6F"	frame buffer control
 70h	"XR70"	setup/disable control (see #P531)
 71h-7Ch	reserved
 7Dh	"XR7D"	flat-panel compensation diagnostic
 7Eh	"XR7E"	CGA/Hercules color selection (see #P532)
 7Fh	"XR7F"	diagnostics (see #P533)
!!! chips\64200.pdf p.28, p.72
Note:	not all C&T chips support all of the above registers; see the tables
	  for the individual registers for a list of supporting chipsets

Bitfields for Chips&Technologies "XR00" chip version:
Bit(s)	Description	(Table P511)
 7-4	chip type
	0000 = 82C451
	0001 = 82C452
	0010 = 82C455
	0011 = 82C453
	0100 = 82C450
	0101 = 82C456
	0110 = 82C457
	0111 = 65520
	1000 = 65530 / 65525
	1001 = 65510 Flat-Panel Controller
	1010 = 64200 Wingine
	1011 = 64300/301 Wingine DGX (if bit 3 clear)
	1011 = 64310 Wingine DGX-PCI (if bit 3 set)
 3-0	chip revision (0000 = first silicon)
Note:	this register is read-only
SeeAlso: #P510,#P512

Bitfields for Chips&Technologies "XR01" configuration:
Bit(s)	Description	(Table P512)
 7-4	configuration bits 7-4 (latched from pins on falling edge of RESET)
 3	memory configuration
	0 video memory pins always drive
	1 video memory pins only driven when XR03 bit 0 is clear (VGA mode)
 2	source of pixel clock
	0 oscillator (CLK0-CLK3 are pixel-clock inputs, which are selected by
	  MSR bits 3-2)
	1 clock chip (CLK0 is pixel clock input, CLK1-CLK3 are CSELx outputs)
 1-0	bus type
	00 PCI
	01 Microchannel
	10 local bus
	11 ISA
Note:	this register is read-only
SeeAlso: #P510,#P511,#P513

Bitfields for Chips&Technologies "XR02" CPU interface register:
Bit(s)	Description	(Table P513)
 7	status of attribute flip-flop (read-only) (0 = index, 1 = data)
 6	palette address decoding
	0 access only at PORT 03C6h-03C9h
	1 also access at PORT 83C6h-83C9h (for RAMDACs with 8 registers)
 5	I/O address decodking
	0 decode all 16 bits of address
	1 only decode low ten bits of address for 3B4h,3B5h,3B8h,3BAh,3BFh,
	  3C0h-3C2h,3C4h,3C5h,3CEh,3CFh,3D4h,3D5h,3D8h-3DAh
 4-3	mapping of Attribute Controller
	00 VGA mapping - write index and data at 03C0h (8-bit only)
	01 16-bit mapping - write index at 03C0h, data at 03C1h
	10 EGA mapping - write index at 03C0h, data at 03C0h or 03C1h (8-bit)
	11 reserved
 2-0	reserved (0)
SeeAlso: #P510,#P512,PORT 83C6h

Bitfields for Chips&Technologies "XR03" Master Control register:
Bit(s)	Description	(Table P514)
 7	XREQ# direction (=0 input, =1 output)
 6	XREQ# divide (=0 DispEnable for all lines, =1 even-numbered lines)
 5	XREQ# mode (=0 DispEnable only, =1 split-buffer VRAM transfer timing)
	(see #P529"XR3C",#P530"XR3D")
 4	alternate VGA address
	=1 map at PORT 02C6h-02C9h instead of 03C6h-03C9h
 3-2	reserved
 1	alternate palette address
	=1 map at PORT 02Bxh or PORT 02Dxh instead of 03Bxh/03Dxh
 0	Wingine/VGA select
	=0 VGA
	=1 Wingine (memory pins are tri-stated)
Note:	a write-only copy of this register may be accessed at PORT 0022h
	  (index E0h) and PORT 0023h; a read-write copy exists in systems with
	  built-in Wingine support
SeeAlso: #P510,#P513,#P515

Bitfields for Chips&Technologies "XR04" Memory Control register:
Bit(s)	Description	(Table P515)
 7-6	reserved (0)
 5	enable CPU memory write buffer
 4-3	reserved (0)
 2	memory wraparound
	=1 enable bit 17 of CRTC address counter
 1	reserved (0)
 0	memory configuration
	=0 8-bit data, two DRAM chips of 256Kx4
	=1 16-bit data, four DRAM chips of 256Kx4
SeeAlso: #P510,#P514

Bitfields for Chips&Technologies "XR05" Clock Control register:
Bit(s)	Description	(Table P516)
 !!!
SeeAlso: #P510

Bitfields for Chips&Technologies "XR0B" CPU Paging register:
Bit(s)	Description	(Table P517)
 7-3	reserved (0)
 2	divide CPU addresses by 4 (chain-4 mode)
 1	use two maps for CPU to access extended video memory (see #P521,#P522)
 0	memory-mapping mode
	=0 VGA-compatible
	=1 extended mapping for 512K video memory
SeeAlso: #P510,#P518

Bitfields for Chips&Technologies "XR0C" Start Address Top register:
Bit(s)	Description	(Table P518)
 7-1	reserved (0)
 0	high-order bit of display start address when 512K display memory used
SeeAlso: #P510,#P517

Bitfields for Chips&Technologies "XR0D" Auxiliary Offset register:
Bit(s)	Description	(Table P519)
 7-2	reserved (0)
 1	LSB of memory offset (CR13) in Chain and Chain-4 modes
 0	LBS of alternate memory offset (XR1E) in Chain/Chain-4 modes
SeeAlso: #P510

Bitfields for Chips&Technologies "XR0E" Text Mode Control register:
Bit(s)	Description	(Table P520)
 7-4	reserved (0)
 3	cursor style (0 = replace, 1 = XOR)
 2	disable cursor blink
 1-0	reserved (0)
SeeAlso: #P510

Bitfields for Chips&Technologies "XR10" Single/Low Map register:
Bit(s)	Description	(Table P521)
 7-0
!!!chips\64200.pdf p.80
SeeAlso: #P510,#P522

Bitfields for Chips&Technologies "XR11" High Map register:
Bit(s)	Description	(Table P522)
 7-0
SeeAlso: #P510,#P521

Bitfields for Chips&Technologies "XR14" Emulation Mode register:
Bit(s)	Description	(Table P523)
 7	enable interrupt output function (=0 tri-state IRQ# line)
 6	enable VSync status bit at PORT 03BAh/03DAh
 5	vertical retrace status
	=0 PORT 03BAh/03DAh bit 3 is vertical retrace (CGA/EGA/VGA)
	=1 PORT 03BAh/03DAh bit 3 is video active (MDA/Herc)
 4	display enable status
	=0 PORT 03BAh/03DAh bit 0 is display enable (CGA/EGA/VGA)
	=1 PORT 03BAh/03DAh bit 0 is HSync (MDA/Herc)
 3-2	(read-only) Hercules configuration register (see PORT 03BFh) readback
 1-0	emulation mode
	00 VGA
	01 CGA
	10 MDA/Hercules
	11 EGA
SeeAlso: #P510

Bitfields for Chips&Technologies "XR15" Write Protect register:
Bit(s)	Description	(Table P524)
 7	write protect AR11 (both bits 7 and 0 must be clear to write AR11)
 6
 5
 4
 3
 2
 1
 0	!!!chips\64200.pdf p.82
SeeAlso: #P510

Bitfields for Chips&Technologies "XR1A" Alternate Horizontal Sync End register:
Bit(s)	Description	(Table P525)
 7
 6-5
 4-0
SeeAlso: #P510,#P526

Bitfields for Chips&Technologies "XR1D" Alternate Horizontal Blank End reg:
Bit(s)	Description	(Table P526)
 7
 6-5
 4-0
SeeAlso: #P510,#P525

Bitfields for Chips&Technologies "XR1F" Virtual EGA Switch register:
Bit(s)	Description	(Table P527)
 7
 6-4	reserved (0)
 3-0	virtual EGA switches
SeeAlso: #P510

Bitfields for Chips&Technologies "XR28" Video Interface register:
Bit(s)	Description	(Table P528)
 7	reserved
 6
 5	interlaced video
 4
 3	reserved (0)
 2	shut off video
 1
 0
SeeAlso: #P510

Bitfields for Chips&Technologies "XR3C" Serial/Row Count register:
Bit(s)	Description	(Table P529)
 7-6	reserved (0)
 5-3	row count (number of transfer cycles)
	000 = 64
	001 = 128
	010 = 256
	011 = 512
	1x0 = 1024
	1x1 = 2048
 2-0	serial count (same as for bits 5-3, but in units of serial clocks)
SeeAlso: #P510,#P530,#P514

Bitfields for Chips&Technologies "XR3D" Multiplexer Mode register:
Bit(s)	Description	(Table P530)
 7-5	reserved
 4
 3
 2-0	multiplexer mode
SeeAlso: #P510,#P529,#P514

Bitfields for Chips&Technologies "XR70" Setup/Disable Control register:
Bit(s)	Description	(Table P531)
 7
 6-0	reserved (0)
SeeAlso: #P510

Bitfields for Chips&Technologies "XR7E" CGA Color Select register:
Bit(s)	Description	(Table P532)
 7-6	reserved
 5
 4
 3-0
Note:	this is a mirror of the register accessed via PORT 03D9h, which is
	  always visible, while PORT 03D9h is only visible in CGA emulation
SeeAlso: #P510,PORT 03D9h

Bitfields for Chips&Technologies "XR7F" Diagnostic register:
Bit(s)	Description	(Table P533)
 7	special test function (should remain cleared)
 6	enable test function in bits 5-2
 5-2	test function
 1	tri-state output pins: !!!
 0	tri-state output pins: !!! chips\64200.pdf p.90
SeeAlso: #P510
----------P03D803DF--------------------------
PORT 03D8-03DF - COLOR VIDEO - CRT MODE AND STATUS REGISTERS

03D8  RW  CGA mode control register  (except PCjr) (see #P534)
	cannot be found on native color EGA, color VGA, but on most clones
03D9  RW  CGA palette register (see #P536)
	(MCGA) CGA border control register
	Cannot be found on native EGA, VGA (without translation ROM) but
	  only most clones. Read access on Genoa SuperEGA is 'reset'???
03DA  R-  CGA status register (see #P535)
	color EGA/VGA: input status 1 register
03DA  -W  color EGA/color VGA feature control register (see #P537)
	(at PORT 03BAh w in mono mode, VGA: 3CAh r)
03DA  -W  HZ309 (MDA/HGC/CGA clone) card from in Heath/Zenith HZ150 PC
	bit7-1=0: unknown, zero is default and known to function
		   properly at least in CGA modes.
	bit 0 = 1 override 3x8h bit3 control register that switches
		   CRT beam off if bit3 is cleared. So screens always
		   stays on.
	bit 0 = 0 3x8h bit3 indicates if CRT beam is on or off.
		   No more info available. Might conflict with EGA/VGA.
03DB  rW  clear light pen latch	(not MCGA)
		  (R/W only with Genoa SuperEGA)
03DC  RW  (not MCGA) preset light pen latch
03DC  -W  (CGA) set light pen latch
03DD  -W  (MCGA)  Extended mode control register
	  (Plantronics & Genoa SuperEGA: Plantronics ColorPlus control,
		      compatible with MCGA???)
	(default is 00h, in mode 13h: 04h)
	bit7 =1: DAC active, cannot be read
	     =0: DAC not active, read allowed
	bit6-3 : reserved
	bit2 =1: videomode 13h with 256 colors active
	bit1	: reserved
	bit0 =0: reserved
03DE  --  (MCGA) reserved
03DE  -W  (AT&T & color ET4000 in AT&T compatibility mode & C&T 82C426)
	  AT&T mode control register (see #P538)
	(register enabled in ET4000, if bit7=1 in CRTC 3D4h/34h.)
03DF  --  (MCGA) reserved
03DF  ?W  CRT/CPU page register	 (PCjr only)

Bitfields for CGA/Hercules mode control register:
Bit(s)	Description	(Table P534)
 7-0	=A0h color ET4000: second part of 'key', see Hercules compatibility
	  register (see PORT 03BFh) for details. For resetting the key, e.g.
	  write 01h to PORT 03BFh and 29h to PORT 03D8h.
 7	(Hercules) page select
	=0 B0000h
	=1 B8000h
 6	color ET4000 only, read-only: report status of bit 1 (enable 2nd page)
	  of hercules compatibility register (see PORT 03BFh)
 5	=1  blink enabled instead of foreground high-int.
 4	=1  640*200 graphics mode (CGA)
 3	=1  video enabled (HZ309, see PORT 03DAh bit 0)
 2	=1  monochrome signal
		(MCGA) in mode 6 and 11h color comes from palette
		  regs 00 (black) and 07 (white), and can be changed there.
 1	=0  text mode
	=1  320*200 graphics mode
 0	text columns (0 = 40*25 text mode, 1 = 80*25 text mode)
SeeAlso: #P535

Bitfields for CGA status register:
Bit(s)	Description	(Table P535)
 7-6	not used
 7	(C&T Wingine) vertical sync in progress (if enabled by XR14)
 5-4	color EGA, color ET4000, C&T: diagnose video display feedback, select
	  from color plane enable
 3	in vertical retrace
	(C&T Wingine) video active (retrace/video selected by XR14)
 2	(CGA,color EGA) light pen switch is off
	(MCGA,color ET4000) reserved (0)
	(VGA) reserved (1)
 1	(CGA,color EGA) positive edge from light pen has set trigger
	(VGA,MCGA,color ET4000) reserved (0)
 0	horizontal retrace in progress
	=0  do not use memory
	=1  memory access without interfering with display
	    (VGA,Genoa SuperEGA) horizontal or vertical retrace
	(C&T Wingine) display enabled (retrace/DE selected by XR14)
SeeAlso: #P534,#P536,#P510

Bitfields for CGA palette register:
Bit(s)	Description	(Table P536)
 7-6	not used
 5	=0 active 320x200x4 color set: red, green brown
	=1 active 320x200x4 color set: cyan, magenta, white
 4	intense colors in graphics, background colors text
 3	intense border in 40*25, intense background in 320*200, intense
	  foreground in 640*200
 2	red border in 40*25, red background in 320*200,	red foreground in
	  640*200
 1	green border in 40*25, green background in 320*200, green foreground
	  in 640*200
 0	blue border in 40*25, blue background in 320*200, blue foreground in
	   640*200
SeeAlso: #P534,#P535

Bitfields for color EGA/VGA feature control register:
Bit(s)	Description	(Table P537)
 7	ET4000 only: enable NMI generation ('key' protected)
 6-4	not used
 3	(VGA) 0 = normal vsync, 1 = vsync OR display enable
 2	reserved (0)
	(C&T Wingine) disable 16-bit operations
 1	(EGA,ET4000,Wingine) FEAT1 control bit1 (pin17 feature connector)
	(VGA) reserved (0)
 0	(EGA,ET4000,Wingine) FEAT0 control bit0 (pin19 feature connector)
	(VGA) reserved (0)
SeeAlso: #P535

Bitfields for AT&T mode control register:
Bit(s)	Description	(Table P538)
 7	reserved
 6	underline color attribute enable
	ET4000: enabled, if bit6=1 in CRTC 3D4h/34h.
 5	reserved
 4	reserved
 3	alternate page select (=1: 2nd 16KB page, with bit0=0)
 2	alternate font select (0=default font block)
 1	reserved
 0	double scan line mode (0=IBM 200, 1=AT&T 400 line graphics)
	(ET4000) enabled, if bit7-6=11b in CRTC 3D4h/34h.
----------P03E003E1--------------------------
PORT 03E0-03E1 - OPTi 82C824 - CardBus Bridge registers
Range:	PORT 03E0h or PORT 03E2h
SeeAlso: PORT 03E2h"CardBus"

03E0  ?W  index for data register
03E1  RW  CardBus registers
--------X-P03E003E1--------------------------
PORT 03E0-03E1 - Cirrus Logic CL-PD6710/6722/6729 - PC-CARD HOST ADAPTER
Notes:	the CL-PD6729 has compatible registers, but the port address
	  is set via the PCI configuration space (two consecutive ports
	  starting at Base Address 0)
	the CL-PD6832 supports a superset of this register set
SeeAlso: PORT 03E0h"CardBus"

03E0  ?W  index for data register (see #P539)
03E1  RW  register data

Bitfields for Cirrus Logic CL-PD6710/6722 index register:
Bit(s)	Description	(Table P539)
 7	device number (when dual CL-PD67xx's are used)
 6	socket number (CL-PD6722 dual-socket adapter only)
 5-0	register index (see #P540)

(Table P540)
Values for Cirrus Logic CL-PD6710/6722 register number:
 00h
 ...
 3Fh
SeeAlso: #P539
----------P03E003E7--------------------------
PORT 03E0-03E7	- LPT port address on the UniRAM card by German magazine c't
Range:	selectable from PORT 0260h, PORT 02E0h, PORT 02E8h, PORT 02F0h,
	  PORT 03E0h, or PORT 03E8h.
SeeAlso: PORT 03E8h"UniRAM"
----------P03E003E7--------------------------
PORT 03E0-03E7 - COM port addresses on UniRAM card by German magazine c't
Range:	selectable from PORT 0238h, PORT 02E8h, PORT 02F8h, PORT 0338h,
	  PORT 03E0h, PORT 03E8h, or PORT 03F8h
SeeAlso: PORT 03E0h"UniRAM"
----------P03E203E3--------------------------
PORT 03E2-03E3 - OPTi 82C824 - CardBus Bridge registers
Range:	PORT 03E0h or PORT 03E2h
SeeAlso: PORT 03E0h"CardBus"

03E2  ?W  index for data register
03E3  RW  CardBus registers
----------P03E803EF--------------------------
PORT 03E8-03EF - serial port, same as 02E8, 02F8 and 03F8 (COM3)
SeeAlso: PORT 03F8h-03FFh
----------P03E803EF--------------------------
PORT 03E8-03EF - COM port addresses on UniRAM card by German magazine c't
Range:	selectable from PORT 0238h, PORT 02E8h, PORT 02F8h, PORT 0338h,
	  PORT 03E0h, PORT 03E8h, or PORT 03F8h
SeeAlso: PORT 03E0h"UniRAM"
----------P03E803EF--------------------------
PORT 03E8-03EF - LPT port address on the UniRAM card by German magazine c't
Range:	selectable from PORT 0260h, PORT 02E0h, PORT 02E8h, PORT 02F0h,
	  PORT 03E0h, or PORT 03E8h.
SeeAlso: PORT 03E8h"UniRAM"
----------P03EB------------------------------
PORT 03EB - GI1904 Scanner Interface Adapter
Range:	PORT 022Bh, PORT 026Bh, PORT 02ABh (default), PORT 02EBh, PORT 032Bh,
	  PORT 036Bh, PORT 03ABh
----------P03EC------------------------------
PORT 03EC - GS-IF Scanner Interface adapter
Range:	PORT 022Ch, PORT 026Ch, PORT 02ACh, PORT 02ECh (default),
	  PORT 032Ch, PORT 036Ch, PORT 03ACh, PORT 03ECh
Note:	many SPI 400dpi/800dpi gray / H/T handy scanner by Marstek, Mustek and
	  others use this interface
----------P03F003F7--------------------------
PORT 03F0-03F7 - FDC 1	(1st Floppy Disk Controller)	second FDC at 0370
Note:	floppy disk controller is usually an 8272, 8272A, NEC765 (or
	  compatible), or an 82072 or 82077AA for perpendicular recording at
	  2.88M
SeeAlso: PORT 0370h-0377h

03F0  R-  diskette controller status A (PS/2) (see #P541)
03F0  R-  diskette controller status A (PS/2 model 30) (see #P542)
03F0  R-  diskette EHD controller board jumper settings (82072AA) (see #P543)
03F1  R-  diskette controller status B (PS/2) (see #P544)
03F1  R-  diskette controller status B (PS/2 model 30) (see #P545)
03F2  -W  diskette controller DOR (Digital Output Register) (see #P546)
03F3  ?W  tape drive register (on the 82077AA)
	bit 7-2	 reserved, tri-state
	bit 1-0	 tape select
		=00  none, drive 0 cannot be a tape drive.
		=01  drive1
		=10  drive2
		=11  drive3
03F4  R-  diskette controller main status register (see #P549)
	Note:	in non-DMA mode, all data transfers occur through
		  PORT 03F5h and the status registers (bit 5 here
		  indicates data read/write rather than than
		  command/status read/write)
03F4  -W  diskette controller data rate select register (see #P550)
03F5  R-  diskette command/data register 0 (ST0) (see #P551)
	status register 1 (ST1) (see #P552)
	status register 2 (ST2) (see #P553)
	status register 3 (ST3) (see #P554)
03F5  -W  diskette command register.  The commands summarized here are
	  mostly multibyte commands. This is for brief recognition only.
	  (see #P557)
03F6  --  reserved on FDC
03F6  rW  FIXED disk controller data register (see #P555)
03F7  RW  harddisk controller (see #P556)
03F7  R-  diskette controller DIR (Digital Input Register, PC/AT mode)
		 bit 7 = 1 diskette change
		 bit 6-0   tri-state on FDC
03F7  R-  diskette controller DIR (Digital Input Register, PS/2 mode)
	  (see #P547)
03F7  R-  diskette controller DIR (Digital Input Register, PS/2 model 30)
	  (see #P548)
03F7  -W  configuration control register (PC/AT, PS/2)
		 bit 7-2       reserved, tri-state
		 bit 1-0 = 00  500 Kb/S mode (MFM)
			 = 01  300 Kb/S mode (MFM)
			 = 10  250 Kb/S mode (MFM)
			 = 11  1   Mb/S mode (MFM) (on 82072/82077AA)
	conflict bit 0	   FIXED DISK drive 0 select
03F7  -W  configuration control register (PS/2 model 30)
		 bit 7-3       reserved, tri-state
		 bit 2	       NOPREC (has no function. set to 0 by hardreset)
		 bit 1-0 = 00  500 Kb/S mode (MFM)
			 = 01  300 Kb/S mode (MFM)
			 = 10  250 Kb/S mode (MFM)
			 = 11  1   Mb/S mode (MFM) (on 82072/82077AA)
	conflict bit 0	   FIXED DISK drive 0 select

Bitfields for diskette controller status A (PS/2):
Bit(s)	Description	(Table P541)
 7	interrupt pending
 6	-DRV2	second drive installed
 5	step
 4	-track 0
 3	head 1 select
 2	-index
 1	-write protect
 0	+direction
SeeAlso: #P542,#P544

Bitfields for diskette controller status A (PS/2 model 30):
Bit(s)	Description	(Table P542)
 7	interrupt pending
 6	DRQ
 5	step F/F
 4	-track 0
 3	head 1 select
 2	+index
 1	+write protect
 0	-direction
SeeAlso: #P541,#P543,#P545

Bitfields for diskette EHD controller board jumper settings:
Bit(s)	Description	(Table P543)
 7-6	drive 3
 5-4	drive 2
 3-2	drive 1
 1-0	drive 0
	 00  1.2Mb
	 01  720Kb
	 10  2.8Mb
	 11  1.4Mb
SeeAlso: #P541

Bitfields for diskette controller status B (PS/2):
Bit(s)	Description	(Table P544)
 7-6	reserved (1)
 5	drive select (0=A:, 1=B:)
 4	write data
 3	read data
 2	write enable
 1	motor enable 1
 0	motor enable 0
SeeAlso: #P541,#P545

Bitfields for diskette controller status B (PS/2 model 30):
Bit(s)	Description	(Table P545)
 7	-DRV2 second drive installed
 6	-DS1
 5	-DS0
 4	write data F/F
 3	read data F/F
 2	write enable F/F
 1	-DS3
 0	-DS2
SeeAlso: #P542,#P544

Bitfields for diskette controller Digital Output Register (DOR):
Bit(s)	Description	(Table P546)
 7-6	reserved on PS/2
 7	drive 3 motor enable
 6	drive 2 motor enable
 5	drive 1 motor enable
 4	drive 0 motor enable
 3	diskette DMA enable (reserved PS/2)
 2	=1  FDC enable	(controller reset)
	=0  hold FDC at reset
 1-0	drive select (0=A 1=B ..)
SeeAlso: #P541,#P549,#P550,#P547

Bitfields for diskette controller Digital Input Register (PS/2 mode):
Bit(s)	Description	(Table P547)
 7	= 1 diskette change
 6-3	= 1
 2	datarate select1
 1	datarate select0
 0	= 0 high density select (500Kb/s, 1Mb/s)
 0	(conflict) FIXED DISK drive 0 select
SeeAlso: #P548,#P546

Bitfields for diskette controller Digital Input Register (PS/2 model 30):
Bit(s)	Description	(Table P548)
 7	= 0 diskette change
 6-4	= 0
 3	-DMA gate (value from DOR register)
 2	NOPREC (value from CCR register)
 1	datarate select1
 0	datarate select0
 0	(conflict) FIXED DISK drive 0 select
SeeAlso: #P547

Bitfields for diskette controller main status register:
Bit(s)	Description	(Table P549)
 7	=1  RQM	 data register is ready
	=0  no access is permitted
 6	=1  transfer is from controller to system
	=0  transfer is from system to controller
 5	non-DMA mode
 4	diskette controller is busy
 3	drive 3 busy (reserved on PS/2)
 2	drive 2 busy (reserved on PS/2)
 1	drive 1 busy (= drive is in seek mode)
 0	drive 0 busy (= drive is in seek mode)
SeeAlso: #P546

Bitfields for diskette controller data rate select register:
Bit(s)	Description	(Table P550)
 7-2	reserved on 8272
 7	software reset (self clearing)	82072/82077AA
 6	power down			82072/82077AA
 5	(8272/82077AA) reserved (0)
	(82072) PLL select bit
 4-2	write precompensation value, 000 default
 1-0	data rate select
	=00  500 Kb/S MFM	250 Kb/S FM
	=01  300 Kb/S MFM	150 Kb/S FM
	=10  250 Kb/S MFM	125 Kb/S FM
	=11  1Mb/S	MFM	illegal	 FM on 8207x
SeeAlso: #P546

Bitfields for diskette command/data register 0 (ST0):
Bit(s)	Description	(Table P551)
 7-6	last command status
	00  command terminated successfully
	01  command terminated abnormally
	10  invalid command
	11  terminated abnormally by change in ready signal
 5	seek completed
 4	equipment check occurred after error
 3	not ready
 2	head number at interrupt
 1-0	unit select (0=A 1=B .. ) (on PS/2: 01=A  10=B)
SeeAlso: #P552,#P553,#P554

Bitfields for diskette status register 1 (ST1):
Bit(s)	Description	(Table P552)
 7	end of cylinder; sector# greater then sectors/track
 6	=0
 5	CRC error in ID or data field
 4	overrun
 3	=0
 2	sector ID not found
 1	write protect detected during write
 0	ID address mark not found
SeeAlso: #P551,#P553,#P554

Bitfields for diskette status register 2 (ST2):
Bit(s)	Description	(Table P553)
 7	=0
 6	deleted Data Address Mark detected
 5	CRC error in data
 4	wrong cylinder detected
 3	scan command equal condition satisfied
 2	scan command failed, sector not found
 1	bad cylinder, ID not found
 0	missing Data Address Mark
SeeAlso: #P551,#P552,#P554

Bitfields for diskette status register 3 (ST3):
Bit(s)	Description	(Table P554)
 7	fault status signal
 6	write protect status
 5	ready status
 4	track zero status
 3	two sided status signal
 2	side select (head select)
 1-0	unit select (0=A 1=B .. )
SeeAlso: #P551,#P552,#P553

Bitfields for fixed disk controller data register:
Bit(s)	Description	(Table P555)
 7-4	reserved
 3	=0  reduce write current
	=1  head select 3 enable
 2	disk reset enable
 1	disk initialization disable
 0	reserved
SeeAlso: #P546,#P556

Bitfields for hard disk controller:
Bit(s)	Description	(Table P556)
 6	FIXED DISK write gate
 5	FIXED DISK head select 3 / reduced write current
 4	FIXED DISK head select 2
 3	FIXED DISK head select 1
 2	FIXED DISK head select 0
 1	FIXED DISK drive 1 select
 0	FIXED DISK drive 0 select
SeeAlso: #P555

(Table P557)
Values for diskette commands:
	MFM = MFM mode selected, opposite of MF mode
	HDS = head select
	DS  = drive select
	MT  = multi track operation
	SK  = skip deleted data address mark
   Command	     # bytes	D7  6	5   4	3   2	1   0
 read track		9	0  MFM	0   0	0   0	1   0
				0   0	0   0	0 HDS DS1 DS0
 specify		3	0   0	0   O	O   O	1   1
 sense drive status	2	0   0	0   0	0   1	0   0
				0   0	0   0	0 HDS DS1 DS0
 write data		9	MT MFM	0   0	0   1	0   1
				0   0	0   0	0 HDS DS1 DS0
 read data		9	MT MFM SK   0	0   1	1   0
				0   0	0   0	0 HDS DS1 DS0
 recalibrate		2	0   0	0   0	0   1	1   1
				0   0	0   0	0   0 DS1 DS0
 sense interrupt status 1	0   0	0   0	1   0	0   0
 write deleted data	9	MT MFM	0   0	1   0	0   1
				0   0	0   0	0 HDS DS1 DS0
 read ID		2	0  MFM	0   0	1   0	1   0
				0   0	0   0	0 HDS DS1 DS0
 read deleted data	9	MT MFM SK   0	1   1	0   0
				0   0	0   0	0 HDS DS1 DS0
 format track		10	0  MFM	0   0	1   1	0   1
				0   0	0   0	0 HDS DS1 DS0
 dumpreg **		1	0   0	0   0	1   1	1   0
 seek			3	0   0	0   0	1   1	1   1
				0   0	0   0	0 HDS DS1 DS0
 version **		1	0   0	0   1	0   0	0   0
 scan equal *		9	MT MFM SK   1	0   0	0   1
				0   0	0   0	0 HDS DS1 DS0
 perpendicular mode **	2	0   0	0   1	0   0	1   0
				0   0	0   0	0   0 WGATE GAP
 configure **		4	0   0	0   1	0   0	1   1
				0   0	0   0	0   0	0   0
 verify			9	MT MFM SK   1	0   1	1   0
				EC  0	0   0	0 HDS DS1 DS0
 scan low or equal *	9	MT MFM SK   1	1   0	0   1
				0   0	0   0	0 HDS DS1 DS0
 scan high or equal *	9	MT MFM SK   1	1   1	0   1
				0   0	0   0	0 HDS DS1 DS0
 relative seek **	3	1  DIR	0   0	1   1	1   1
				0   0	0   0	0 HDS DS1 DS0
BEWARE: not every invalid command is treated as invalid!
 *  Note: the scan commands aren't mentioned for the 82077AA.
 ** Note: EHD controller commands.
----------P03F003F1--------------------------
PORT 03F0-03F1 - PCTech RZ1000 IDE controller
Note:	to unlock access to these ports instead of the standard floppy
	  controller status ports at these two addresses, you must perform
	  two immediately successive 8-bit OUTs of 55h to PORT 03F0h (there
	  is a fairly small time limit between the two accesses, so there
	  should be no other instructions between the two OUTs); after
	  that, values written to PORT 03F0h select the data accessed through
	  PORT 03F1h until an AAh is written to 03F0h
SeeAlso: #0706

03F0  ?W  index port (see #P558)
03F1  RW  data port

(Table P558)
Values for RZ1000 IDE controller registers:
 00h	???
	bit 7:
	bit 1:
	bit 0:
 01h	???
 02h	???
 03h	???
 04h	???
 05h	???
	bit 1:
 AAh	lock control port
----------P03F803FF--------------------------
PORT 03F8-03FF - Serial port (8250,8250A,8251,16450,16550,16550A,etc.) COM1
Range:	PORT 02E8h-02EFh (COM2), PORT 02F8h-02FFh (typical non-PS/2 COM3), and
	  PORT 03E8h-03EFh (typical non-PS/2 COM4)
Note:	chips overview:
	 8250  original PC, specified up to 56Kbd, but mostly runs
	       only 9600Bd, no scratchregister, bug: sometimes shots
	       ints without reasons
	 8250A, 16450, 16C451: ATs, most chips run up to 115KBd,
	       no bug: shots no causeless ints
	 8250B: PC,XT,AT, pseudo bug: shots one causeless int for
		compatibility with 8250, runs up to 56KBd
	 16550, 16550N, 16550V: early PS/2, FIFO bugs
	 16550A,16550AF,16550AFN,16550C,16C551,16C552: PS/2, FIFO ok
	 82510: laptops & industry, multi emulation mode
		(default=16450), special-FIFO.
	 8251: completely different synchronous SIO chip, not compatible!
SeeAlso: INT 14/AH=00h"SERIAL"

03F8  -W  serial port, transmitter holding register (THR), which contains the
	  character to be sent. Bit 0 is sent first.
		bit 7-0	  data bits when DLAB=0 (Divisor Latch Access Bit)
03F8  R-  receiver buffer register (RBR), which contains the received
	  character. Bit 0 is received first
		 bit 7-0   data bits when DLAB=0 (Divisor Latch Access Bit)
03F8  RW  divisor latch low byte (DLL) when DLAB=1 (see #P559)
03F9  RW  divisor latch high byte (DLM) when DLAB=1 (see #P559)
03F9  RW  interrupt enable register (IER) when DLAB=0 (see #P560)
03FA  R-  interrupt identification register (see #P561)
	Information about a pending interrupt is stored here. When the ID
	  register is addressed, thehighest priority interrupt is held, and
	  no other interrupts are acknowledged until the CPU services that
	  interrupt.
03FA  -W  16650 FIFO Control Register (FCR) (see #P562)
03FB  RW  line control register (LCR) (see #P563)
03FC  RW  modem control register (see #P564)
03FD  R-  line status register (LSR) (see #P565)
03FE  R-  modem status register (MSR) (see #P566)
03FF  RW  scratch register (SCR)
	(not used for serial I/O; available to any application using 16450,
	  16550) (not present on original 8250)

(Table P559)
Values for serial port divisor latch registers:
 Some baudrates (using standard 1.8432 Mhz clock):
       baudrate	   divisor	 DLM  DLL
	    50	   2304		  09h 00h
	    75	   1536		  06h 00h
	   110	   1047		  04h 17h
	   134,5    857		  03h 59h
	   150	    768		  03h 00h
	   300	    384		  01h 80h
	   600	    192		  00h C0h
	  1200	     96		  00h 60h
	  1800	     64		  00h 40h
	  2000	     58		  00h 3Ah
	  2400	     48		  00h 30h
	  3600	     32		  00h 20h
	  4800	     24		  00h 18h
	  7200	     16		  00h 10h
	  9600	     12		  00h 0Ch
	 19200	      6		  00h 06h
	 38400	      3		  00h 03h
	 57600	      2		  00h 02h
	115200	      1		  00h 01h
Note:	MIDI baudrate 32250Bd with 4Mhz quarz for c't MIDI interface
	  following c't 01/1991:   '14400'	  00h 08h

Bitfields for serial port interrupt enable register (IER):
Bit(s)	Description	(Table P560)
 7-6	reserved (0)
 5	(82510) "timer"
	(other) reserved (0)
 4	(82510) "transmit machine"
	(other) reserved (0)
 3	modem-status interrupt enable
 2	receiver-line-status interrupt enable
 1	transmitter-holding-register empty interrupt enable
 0	received-data-available interrupt enable
	  (also 16550(A) timeout interrupt)
Note:	16550(A) will interrupt with a timeout if data exists in the FIFO
	  and isn't read within the time it takes to receive four bytes or if
	  no data is received within the time it takes to receive four bytes
SeeAlso: #P561

Bitfields for serial port interrupt identification register (IIR):
Bit(s)	Description	(Table P561)
 7-6	=00  reserved on 8250, 8251, 16450
	=01  if FIFO queues enabled but unusable (16550 only)
	=11  if FIFO queues are enabled (16550A only) (see also #P562)
 6-5	used by 82510 for bank select (00 = default bank0)
 5-4	reserved (0)
 3-1	identify pending interrupt with the highest priority
	110	(16550,82510) timeout interrupt pending
	101	(82510) timer interrupt (see #P560)
	100	(82510) transmit machine (see #P560)
	011	receiver line status interrupt. priority=highest
	010	received data available register interrupt. pr.=second
	001	transmitter holding register empty interrupt. pr.=third
	000	modem status interrupt. priority=fourth
 0	=0 interrupt pending. contents of register can be used as a pointer
	  to the appropriate interrupt service routine
	=1 no interrupt pending
Notes:	interrupt pending flag uses reverse logic, 0=pending, 1=none
	interrupt will occur if any of the line status bits are set
	THRE bit is set when THRE register is emptied into the TSR
SeeAlso: #P560

Bitfields for serial port FIFO control register (FCR):
Bit(s)	Description	(Table P562)
 7-6	received data available interrupt trigger level (16550)
	00  1 byte
	01  4 bytes
	10  8 bytes
	11 14 bytes
 6-5	=00  (used to enable 4 byte Rx/Tx FIFOs on 82510???)
	=10 ???
 5-4	reserved (00)
 3	change RXRDY  TXRDY pins from mode 0 to mode 1
 2	clear XMIT FIFO
 1	clear RCVR FIFO
 0	enable clear XMIT and RCVR FIFO queues
 4-0	(other purpose on 82510???)
Notes:	bit 0 must be set in order to write to other FCR bits
	bit 1 when set	the RCVR FIFO is cleared and this bit is reset
	  the receiver shift register is not cleared
	bit 2 when set	the XMIT FIFO is cleared and this bit is reset
	  the transmit shift register is not cleared
	due to a hardware bug, 16550 FIFOs don't work correctly (this
	  was fixed in the 16550A)
SeeAlso: #P561

Bitfields for serial port Line Control Register (LCR):
Bit(s)	Description	(Table P563)
 7	=1  divisor latch access bit (DLAB)
	=0  receiver buffer, transmitter holding, or interrupt enable register
	  access
 6	set break enable. serial ouput is forced to spacing state and remains
	  there.
 5-3	PM2 PM1 PM0
	 x   x	 0 = no parity
	 0   0	 1 = odd parity
	 0   1	 1 = even parity
	 1   0	 1 = high parity (sticky)
	 1   1	 1 = low parity (sticky)
	 x   x	 1 = software parity
 2	stop bit length (STB/SBL)
	0  one stop bit
	1  2 stop bits with (word length 6, 7, 8)
	   1.5 stop bits with word length 5
 1-0	(WLS1-0, CL1-0)
	00 word length is 5 bits
	01 word length is 6 bits
	10 word length is 7 bits
	11 word length is 8 bits
SeeAlso: #P564,#P565,#P566

Bitfields for serial port Modem Control Register (MCR):
Bit(s)	Description	(Table P564)
 7-6	reserved (0)
 5	(82510 only) state of OUT0 pin
 4	loopback mode for diagnostic testing of serial port
	output of transmitter shift register is looped back to receiver
	  shift register input. In this mode, transmitted data is received
	  immediately so that the CPU can verify the transmit data/receive
	  data serial port paths.
	If OUT2 is disabled, there is no official way to generate an IRQ
	  during loopback mode.
 3	auxiliary user-designated output 2 (OUT2)
	because of external circuity OUT2 must be 1 to master-intr-enableing.
	BUG: Some Toshiba Laptops utilize this bit vice versa, newer Toshiba
	  machines allow assignment of the bit's polarity in system setup.
	82050: This bit is only effective, if the chip is being used with an
	  externally-generated clock.
 2	=1/0  auxiliary user-designated output 1 (OUT1)
	should generally be cleared!!
	Some external hardware, e.g. c't MIDI interface (and compatibles) use
	  this bit to change the 8250 input clock from 1,8432 MHz to 4Mhz
	  (enabling MIDI-conformant baudrates) and switching to
	  MIDI-compatible current loop connectors.
 1	force request-to-send active (RTS)
 0	force data-terminal-ready active (DTR)
SeeAlso: #P563,#P565,#P566

Bitfields for serial port Line Status Register (LSR):
Bit(s)	Description	(Table P565)
 7	=0  reserved
	=1  on some chips produced by UMC
 6	transmitter shift and holding registers empty
 5	transmitter holding register empty (THRE)
	Controller is ready to accept a new character to send.
 4	break interrupt. the received data input is held in the zero bit
	  state longer than the time of start bit + data bits + parity bit +
	  stop bits.
 3	framing error (FE). the stop bit that follows the last parity or data
	  bit is a zero bit
 2	parity error (PE). Character has wrong parity
 1	overrun error (OE). a character was sent to the receiver buffer
	  before the previous character in the buffer could be read. This
	  destroys the previous character.
 0	data ready. a complete incoming character has been received and sent
	  to the receiver buffer register.
SeeAlso: #P563,#P564,#P566

Bitfields for serial port Modem Status Register (MSR):
Bit(s)	Description	(Table P566)
 7	data carrier detect (-DCD)
 6	ring indicator (-RI)
 5	data set ready (-DSR)
 4	clear to send (-CTS)
 3	delta data carrier detect (DDCD)
 2	trailing edge ring indicator (TERI)
 1	delta data set ready (DDSR)
 0	delta clear to send (DCTS)
Notes:	bits 0-3 are reset when the CPU reads the MSR
	bit 4 is the Modem Control Register RTS during loopback test
	bit 5 is the Modem Control Register DTR during loopback test
	bit 6 is the Modem Control Register OUT1 during loopback test
	bit 7 is the Modem Control Register OUT2 during loopback test
SeeAlso: #P563,#P564,#P565
--------!---Note-----------------------------
Note:	Adresses above 03FF generally apply to EISA and PCI machines only !
	EISA port assignments:
	    1000-1FFF	slot 1 EISA
	    2000-2FFF	slot 2 EISA
	    3000-3FFF	slot 3 EISA
	    4000-4FFF	slot 4 EISA
	    5000-5FFF	slot 5 EISA
	    6000-6FFF	slot 6 EISA
	    7000-7FFF	slot 7 EISA
----------P0401040B--------------------------
PORT 0401-040B - EISA DMA Controller
SeeAlso: PORT 0481h-048Bh"EISA",PORT 04D4h-04D6h"EISA"

0401  RW  DMA channel 0 word count byte 2 (high)
0403  RW  DMA channel 1 word count byte 2 (high)
0405  RW  DMA channel 2 word count byte 2 (high)
0407  RW  DMA channel 3 word count byte 2 (high)
040A  -W  extended DMA chaining mode register, channels 0-3 (see #P567)
040A  R-  channel interrupt (IRQ13) status register (see #P568)
040B  -W  DMA extended mode register for channels 0-3 (see #P569)
	(bit settings same as PORT 04D6h)

Bitfields for EISA extended DMA chaining mode register (channels 0-3):
Bit(s)	Description	(Table P567)
 7-5	reserved
 4	=0  generate IRQ13
	=1  generate terminal count
 3	=0  do not start chaining
	=1  programming complete
 2	=0  disable buffer chaining mode (default)
	=1  enable buffer chaining mode
 1-0	DMA channel select
SeeAlso: #P568,#P569,#P576

Bitfields for EISA channel interrupt (IRQ13) status register:
Bit(s)	Description	(Table P568)
 7-5  interrupt on channels 7-5
 4	  reserved
 3-0  interrupt on channels 3-0
SeeAlso: #P567

Bitfields for EISA DMA extended mode register (channels 0-3):
Bit(s)	Description	(Table P569)
 7	=0 enable stop register
 6	=0 terminal count is an output for this channel	(default)
 5-4	DMA cycle timing
	00 ISA-compatible (default)
	01 type A timing mode
	10 type B timing mode
	11 burst DMA mode
 3-2	Address mode
	00 8-bit I/O, count by bytes (default)
	01 16-bit I/O, count by words, address shifted
	10 32-bit I/O, count by bytes
	11 16-bit I/O, count by bytes
 1-0	DMA channel select
SeeAlso: #P567,#P577
----------P040A043F--------------------------
PORT 040A-043F - Intel 82378ZB embedded DMA controller
Range:	relocatable via Relocation Base Address register (see #1002)
SeeAlso: PORT 0401h"EISA",#0991,#1002

040A  R-  scatter/gather interrupt status (see #P570)
040B  -W  DMA1 extended mode
0410  -W  CH0 scatter/gather command (see #P571)
0411  -W  CH1 scatter/gather command
0412  -W  CH2 scatter/gather command
0413  -W  CH3 scatter/gather command
0414  -W  CH4 scatter/gather command
0415  -W  CH5 scatter/gather command
0416  -W  CH6 scatter/gather command
0417  -W  CH7 scatter/gather command (see #P571)
0418  R-  CH0 scatter/gather status (see #P572)
0419  R-  CH1 scatter/gather status
041A  R-  CH2 scatter/gather status
041B  R-  CH3 scatter/gather status
041C  R-  CH4 scatter/gather status
041D  R-  CH5 scatter/gather status
041E  R-  CH6 scatter/gather status
041F  R-  CH7 scatter/gather status (see #P572)
0420d RW  CH0 scatter/gather descriptor table address
0424d RW  CH1 scatter/gather descriptor table address
0428d RW  CH2 scatter/gather descriptor table address
042Cd RW  CH3 scatter/gather descriptor table address
0430d RW  CH4 scatter/gather descriptor table address
0434d RW  CH5 scatter/gather descriptor table address
0438d RW  CH6 scatter/gather descriptor table address
043Cd RW  CH7 scatter/gather descriptor table address

(Table P570)
Call Intel 82378ZB Scatter/Gather Interrupt Status Register with:
 7	channel 7 has interrupt due to S/G transfer
 ...
 0	channel 0 has interrupt due to S/G transfer
SeeAlso: #P571,#P572

Bitfields for Intel 82378ZB Scatter/Gather Command Register:
Bit(s)	Description	(Table P571)
  7	select last-buffer termination type
	=0 assert IRQ13 on completion
	=1 assert EOP on completion
 6	enable bit 7 termination-type selection
 5-2	reserved (0)
 1-0	scatter-gather command
	00 none
	01 start S/G command
	10 stop S/G command
	11 reserved
SeeAlso: #P570,#P572,#1002

Bitfields for Intel 82378ZB Scatter/Gather Status Register:
Bit(s)	Description	(Table P572)
 7	no next link
 6	reserved
 5	issue IRQ13 instead of EOP at end of last buffer
 4	reserved
 3	scatter/gather Base Register status
	=1 buffer link has been loaded
	=0 empty
 2	scatter/gather Current Register status
	=1 buffer link has been loaded
	=0 empty
 1	reserved
 0	scatter/gather is active
SeeAlso: #P571
--------X-P040D040F--------------------------
PORT 040D-040F - EISA - Intel 82357

040D  R-  chip stepping level
040E  RW  test register 1
040F  RW  test register 2
----------P04610462--------------------------
PORT 0461-0462 - EISA NMI CONTROL

0461  RW  Extended NMI status/control register (see #P573)
0462  -W  Software NMI register. writing to this register causes an NMI	if
	  NMIs are enabled
	bit 7 = 1  generates an NMI

Bitfields for EISA extended NMI status control register:
Bit(s)	Description	(Table P573)
 7  R-	NMI pending from fail-safe (watchdog) timer
 6  R-	NMI pending from bus timeout NMI status
 5  R-	NMI pending from I/O port status
 4  R-	busmaster preemption timeout if bit 6 set
 3  RW	bus timeout NMI enable
 2  RW	fail-safe (watchdog) NMI enable
 1  RW	NMI I/O port enable
 0  RW	RSTDRV. bus reset
	=0  NORMAL bus reset operation
	=1  reset bus asserted
--------X-P04640465--------------------------
PORT 0464-0465 - EISA BUS MASTER STATUS

0464w R	  bus master status latch register (slots 1-16)
	identifies the last bus master that had control of the bus (bit N =0 if
	  slot N+1 had control last)
----------P0481048B--------------------------
PORT 0481-048B - EISA DMA page registers
Note:	these registers are also supported on many non-EISA machines, e.g. by
	  most machines using Intel PCI chipsets
SeeAlso: PORT 0401h-040Bh"EISA",PORT 04C6h-04CFh"EISA"

0481  RW  DMA channel 2 address byte 3 (high)
0482  RW  DMA channel 3 address byte 3 (high)
0483  RW  DMA channel 1 address byte 3 (high)
0487  RW  DMA channel 0 address byte 3 (high)
0489  RW  DMA channel 6 address byte 3 (high)
048A  RW  DMA channel 7 address byte 3 (high)
048B  RW  DMA channel 5 address byte 3 (high)
----------P04C604CF--------------------------
PORT 04C6-04CF - EISA DMA count registers
SeeAlso: PORT 0401h-040Bh"EISA",PORT 0481h-048Bh"EISA",PORT 04E0h-04FFh"EISA"

04C6  RW  DMA channel 5 word count byte 2 (high)
04CA  RW  DMA channel 6 word count byte 2 (high)
04CE  RW  DMA channel 7 word count byte 2 (high)
--------X-P04D004D1--------------------------
PORT 04D0-04D1 - EISA IRQ control
Note:	these registers are also supported on many non-EISA machines, e.g. by
	  most machines using Intel PCI chipsets
SeeAlso: PORT 04D4h-040Bh"EISA"

04D0  -W  IRQ 0-7 interrupt edge/level registers (see #P574)
04D1  -W  IRQ 8-15 interrupt edge/level registers (see #P575)

Bitfields for EISA IRQ 0-7 interrupt edge/level register:
Bit(s)	Description	(Table P574)
 7	IRQ 7 is level sensitive
 6	IRQ 6 is level sensitive
 5	IRQ 5 is level sensitive
 4	IRQ 4 is level sensitive
 3	IRQ 3 is level sensitive
 2-0	reserved
SeeAlso: #P575

Bitfields for EISA IRQ 8-15 interrupt edge/level register:
Bit(s)	Description	(Table P575)
 7	IRQ 15 is level sensitive
 6	IRQ 14 is level sensitive
 5	reserved (1)
 4	IRQ 12 is level sensitive
 3	IRQ 11 is level sensitive
 2	IRQ 10 is level sensitive
 1	IRQ 9  is level sensitive
 0	reserved
SeeAlso: #P574
----------P04D404D6--------------------------
PORT 04D4-04D6 - EISA DMA control
Note:	PORT 04D6h is also supported by the Intel 82378ZB System I/O controller
SeeAlso: PORT 0401h-040Bh"EISA",PORT 04D0h-04D1h"EISA"

04D4  R-  DMA chaining status
04D4  -W  extended DMA chaining mode register, channels 4-7 (see #P576)
04D6  -W  DMA extended mode register for channels 4-7 (see #P577)
	bit settings same as PORT 040Bh

Bitfields for EISA extended DMA chaining mode register (channels 4-7):
Bit(s)	Description	(Table P576)
 7-5	reserved (0)
 4	=0  generate IRQ 13
	=1  generate terminal count
 3	=0  do not start chaining
	=1  programming complete
 2	=0  disable buffer chaining mode (default)
	=1  enable buffer chaining mode
 1-0	DMA channel select
SeeAlso: #P567,#P577

Bitfields for EISA DMA extended mode register (channels 4-7):
Bit(s)	Description	(Table P577)
 7	=0  enable stop register
 6	=0  terminal count is an output for this channel (default)
 5-4	DMA cycle timing
	00 ISA-compatible (default)
	01 type A timing mode
	10 type B timing mode
	11 burst DMA mode
 3-2	Address mode
	00 8-bit I/O, count by bytes (default)
	01 16-bit I/O, count by words, address shifted
	10 32-bit I/O, count by bytes
	11 16-bit I/O, count by bytes
 1-0	DMA channel select
SeeAlso: #P569,#P576
----------P04E004FF--------------------------
PORT 04E0-04FF - EISA DMA stop registers
SeeAlso: PORT 0481h-048Bh"EISA"

04E0-04E2  RW	channel 0 stops if DMA transfer reaches specified address
04E4-04E6  RW	channel 1
04E8-04EA  RW	channel 2
04EC-04EE  RW	channel 3
04F4-04F6  RW	channel 5
04F8-04FA  RW	channel 6
04FC-04FE  RW	channel 7
----------P05300533--------------------------
PORT 0530-0533 - Gravis Ultra Sound Daughter Card by Advanced Gravis
Range:	dipswitch selectable from PORT 0530h-0533h, PORT 0604h-0607h,
	  PORT 0E80h-0E83h, and PORT 0F40h-0F43h
SeeAlso: PORT 0530h"Windows Sound System"

0530  RW  address select (see #P578)
0531  RW  data (selected by PORT 0530h)
0532  RW  status
0533  RW  PIO data
----------P05300537--------------------------
PORT 0530-0537 - Windows Sound System (default address)
Range:	dipswitch selectable among PORT 0530h-0537h,PORT 0604h-060Bh,
	  PORT 0E80h-0E87h, and PORT 0F40h-0F47h
Notes:	the Sound Galaxy NX16 sound cards contains a Crystal CS4231, and thus
	  support the CODEC portion of the WSS on ports 0534h-0537h
	  (or 0608h-060Bh, etc.)
	the AMD InterWave chip supports a superset of the WSS CS4231 Codec,
	  though by default it is not placed at any of the addresses used by
	  the WSS

0534  ?W  register select (index) (see #P578)
0535  RW  data register (selected by PORT 0534h)
0536  R?  (CS4231A) status register
0537  RW  (CS4231A) PIO data register

(Table P578)
Values for Windows Sound System CS4231 Codec register number:
 00h	Mixer: ADC volume (left)
 01h	Mixer: ADC volume (right)
 02h	Mixer: Line In volume (right) (see #P579)
 03h	Mixer: Line In volume (left) (see #P579)
 04h	Mixer: FM volume (right) (see #P579)
 05h	Mixer: FM volume (left) (see #P579)
 06h	Mixer: playback DAC volume (left)
 07h	Mixer: playback DAC volume (right)
 08h	playback data format
 09h	configuration register 1
 0Ah	external control
 0Bh	Codec status register 2
 0Ch	mode select
	bit 6: ???
 0Dh	loopback control
	(Sound Galaxy) microphone input enabled by bit 0 ???
 0Eh	playback count (high)
 0Fh	playback count (low)
 10h	configuration register 2
 11h	configuration register 3
 12h	Mixer: CD volume (right) (see #P579)
 13h	Mixer: CD volume (left) (see #P579)
 14h	timer (low)
 15h	timer (high)
 16h	Mixer: microphone input control (left)
 17h	Mixer: microphone input control (right)
 18h	Codec status register 3
 19h	Mixer: output attenuation (left)
 1Ah	mono input/output control
	(Sound Galaxy) SB volume (see #P580)
 1Bh	Mixer: output attenuation (right)
 1Ch	record data format
 1Dh	playback variable frequency
 1Eh	record count (high)
 1Fh	record count (low)
 48h	(Sound Galaxy) ???
Notes:	to enable the microphone input on the Sound Galaxy, ALL of the
	  following registers must be set: 00h set to 80h, 01h set to 80h,
	  07h to 00h, 0Dh to 01h, and 48h to 4Bh
	on the Sound Galaxy NX16, only bits 0-4 of the register number are
	  fully decoded, so most registers above 1Fh are aliases of the
	  first 32 registers

Bitfields for WSS mixer volume:
Bit(s)	Description	(Table P579)
 7	disable input source
 6-5	reserved???
 4-0	volume (00h = highest, 1Fh = lowest)
SeeAlso: #P578,#P580
Note:	the GW2000 GWBVOL.EXE only permits the setting of volume levels
	  08h (reported as 16) to 18h (reported as 0, and sets bit 7 as well)

Bitfields for WSS mixer volume (SoundBlaster):
Bit(s)	Description	(Table P580)
 7	disable input source
 6-4	reserved???
 3-0	volume (00h = highest, 0Fh = lowest)
SeeAlso: #P578,#P579
----------P0601------------------------------
PORT 0601 - Headland HL21, Acer M5105 chipsets - SYSTEM CONTROL

0601  -W  system control (see #P581)
0601  R-  status (see #P582)

Bitfields for Headland HL21/Acer M5105 system control register:
Bit(s)	Description	(Table P581)
 7	=1  power LED on
 6	=1  LCD backlight off
 5	???
 4	???
 3	???
 2	=1  video chips disabled, screen blanked.
 1	???
 0	=1  will lock up your machine!
SeeAlso: #P582

Bitfields for Headland HL21/Acer M5105 status register:
Bit(s)	Description	(Table P582)
 7	=0  if screen enabled always these values
 6	=0
 5	=0
 4	=0
 3	=0
 2	=1  (=0 at low power)
 1	=0  power OK
 0	=0
SeeAlso: #P581
----------P06040607--------------------------
PORT 0604-0607 - Gravis Ultra Sound Daughter Card by Advanced Gravis
Range:	dipswitch selectable from PORT 0530h-0533h, PORT 0604h-0607h,
	  PORT 0E80h-0E83h, and PORT 0F40h-0F43h
----------P0604060B--------------------------
PORT 0604-060B - Windows Sound System
Range:	PORT 0530h-0537h,PORT 0604h-060Bh,PORT 0E80h-0E87h,PORT 0F40h-0F47h
SeeAlso: PORT 0530h"Sound System"
----------P06200627--------------------------
PORT 0620-0627 - PC network (adapter 1)
0628-062F - PC network (adapter 2)
----------P0678067A--------------------------
PORT 0678-067A - Intel 82091AA - ECP-mode PARALLEL PORT
Range:	PORT 0678h or PORT 0378h, depending on the base address of the parallel
	  port (0278h or 0378h)
SeeAlso: PORT 0278h,PORT 0778h,PORT 07BCh

0278  RW  (when ECR bits 7-5=011) ECP Address/RLE FIFO (see #P583)
	(this is the same address normally used for parallel port data)
0678  RW  (when ECR bits 7-5=010) standard parallel port data FIFO (see #P584)
0678  RW  (when ECR bits 7-5=011) ECP data FIFO (see #P585)
0678  RW  (when ECR bits 7-5=110) test FIFO (see #P586)
0678  RW  (when ECR bits 7-5=111) ECP configuration A (see #P587)
0679  RW  (when ECR bits 7-5=111) ECP configuration B (see #P588)
067A  RW  extended control register (ECR) (see #P589)

Bitfields for ECP Address/RLE FIFO:
Bit(s)	Description	(Table P583)
 7	address/RLE-count select
	=0 RLE count
	=1 channel address
 6-0	channel address (bit 7 set)
	RLE count, less 1 (bit 7 clear)
Notes:	when using hardware RLE decompression, the associated data is written
	  to the data FIFO (see #P585) after the count is set here
	an RLE count of 1 (two identical bytes) will cause unnecessary
	  expansions
	the peripheral device performs the interpretation of this byte as
	  address or RLE count; writing to this port simply causes the AUTOFD#
	  line to be asserted to tell the peripheral that the byte is not data
SeeAlso: #P589,#P584

Bitfields for ECP Standard Parallel Port data FIFO:
Bit(s)	Description	(Table P584)
 7-0	standard parallel port data
Notes:	data written or DMAed to this port are buffered in the FIFO and
	  transmitted to the peripheral using a standard ISA-compatible
	  hardware handshake
	PORT 027Ah bit 5 must be clear to enable the forward transfer direction
SeeAlso: #P583,#P584,#P589

Bitfields for ECP data FIFO:
Bit(s)	Description	(Table P585)
 7-0	ECP-mode data
Notes:	data written or DMAed to this port are buffered in the FIFO and
	  transmitted to the peripheral using an ECP hardware handshake;
	  PORT 027Ah bit 5 must be clear to enable the forward transfer
	  direction
	when PORT 027Ah bit 5 is set (reverse transfer), data is read from the
	  peripheral and placed in the FIFO, from which it may be read by
	  reading this port
SeeAlso: #P583,#P589,#P586

Bitfields for ECP test FIFO:
Bit(s)	Description	(Table P586)
 7-0	test FIFO data
Notes:	writes to this port write to the FIFO, reads from this port read from
	  the FIFO, without actually transferring any data out the parallel
	  port; FIFO overruns and underruns are ignored, simply reading/writing
	  over the same slots again and again
	the ECR "full" and "empty" bits always keep track of the current state
	  of the FIFO; the write threshold can be determined by filling the
	  FIFO and then reading a byte at a time until a service interrupt is
	  set in the ECR.  Similarly, the read threshold can be determined by
	  emptying the FIFO, setting the direction bit in PORT 027Ah, and
	  writing a byte at a time until a service interrupt is set.
SeeAlso: #P583,#P589,#P585

Bitfields for ECP configuration A:
Bit(s)	Description	(Table P587)
 7-4	(read-only) implementation identification
	bit 7: ISA-style interrupt
	bit 4: eight-bit implementation
 3-0	reserved
Note:	this register can only be accessed when the Extended Control
	  Register bits 7-5 are set to 111
SeeAlso: #P589,#P588,#P583,#P585,#P586

Bitfields for ECP configuration B:
Bit(s)	Description	(Table P588)
 7	reserved (0)
 6	IRQ status (reflects actual value driven onto either IRQ5 or IRQ7; used
	  to check for interrupt conflicts)
 5-0	reserved (0)
Notes:	this register can only be accessed when the Extended Control
	  Register bits 7-5 are set to 111
	bit 4 of the parallel control port (027Ah/037Ah) must be cleared before
	  bit 6 will show the interrupt status
SeeAlso: #P589,#P587

Bitfields for ECP Extended Control Register (ECR):
Bit(s)	Description	(Table P589)
 7-5	ECP mode
	000 ISA-compatible
	001 PS/2-compatible (bidirectional port)
	010 ISA-compatible FIFO
	011 ECP
	100 reserved
	101 reserved
	110 test
	111 configuration
 4	disable ERROR interrupts
 3	enable DMA
	when bit 3 set and bit 2 clear, an interrupt is generated on the DMA
	  terminal-count condition; this bit must be cleared to reset the TC
	  interrupt
 2	disable FIFO/TerminalCount service interrupts
 1	(read-only) FIFO is full
 0	(read-only) FIFO is empty
Notes:	if the port is currently in modes 000 or 001, it may be switched into
	  any other mode; if it is in a mode other than 000 or 001, it must
	  first be switched into either mode 000 or 001 before selecting a mode
	  other than one of those two
	if currently in an extended forward mode (010-111 and direction bit
	  clear), software should wait for the FIFO to clear before switching
	  back to modes 000 or 001
	if a FIFO overrun or underrun occurs, BOTH bits 1 and 0 are set; to
	  clear the FIFO error condition, switch the port to mode 000 or 001
SeeAlso: #P587,#P588,#P585
----------P06800681--------------------------
PORT 0680-0681 - Microchannel POST Diagnostic (write only)

0680  -W  Microchannel POST Diagnostic
0681  -W  secondary MCA POST diagnostic
----------P06A006A8--------------------------
PORT 06A0-06A8 - non-standard COM port addresses
Range:	selectable from 0280, 0288, 0290, 0298, 06A0, 06A8
Note:	V20-XT by German magazine c't
----------P06A806AF--------------------------
PORT 06A8-06AF - non-standard COM port addresses
Range:	selectable from 0280, 0288, 0290, 0298, 06A0, 06A8
Note:	V20-XT by German magazine c't
----------P06E206E3--------------------------
PORT 06E2-06E3 - data aquisition (adapter 1)
----------P06E8------------------------------
PORT 06E8 - S3 86C928 video controller (ELSA Winner 1000)
----------P06E806EF--------------------------
PORT 06E8-06EF - 8514/A and compatible (e.g. ATI Graphics Ultra) - HORZ DISPLYD
SeeAlso: PORT 02E8h-02EFh,PORT 0AE8h,PORT 96E8h,PORT 9AE8h

06E8w -W  CRT control: horizontal displayed
----------P0746------------------------------
PORT 0746 - Gravis Ultra Sound by Advanced Gravis - BOARD VERSION / MIXER
SeeAlso: PORT 0240h-024Fh,PORT 0340h-034Fh

0746  R-  board version (rev 3.7+)
		FFh	  Pre 3.6 boards, ICS mixer NOT present
		05h	  Rev 3.7 with ICS Mixer. Some R/L: flip problems.
		06h-09h	  Revision 3.7 and above. ICS Mixer present
		0Ah-	  UltraMax. CS4231 present, no ICS mixer
0746  -W  Mixer Control Port
----------P0778077A--------------------------
PORT 0778-077A - Intel 82091AA - ECP-mode PARALLEL PORT
Range:	PORT 0678h or PORT 0378h, depending on the base address of the parallel
	  port (0278h or 0378h)
SeeAlso: PORT 0378h,PORT 0678h,PORT 07BCh

0378  RW  (when ECR bits 7-5=011) ECP Address/RLE FIFO (see #P583)
	(this is the same address normally used for parallel port data)
0778  RW  (when ECR bits 7-5=010) standard parallel port data FIFO (see #P584)
0778  RW  (when ECR bits 7-5=011) ECP data FIFO (see #P585)
0778  RW  (when ECR bits 7-5=110) test FIFO (see #P586)
0778  RW  (when ECR bits 7-5=111) ECP configuration A (see #P587)
0779  RW  (when ECR bits 7-5=111) ECP configuration B (see #P588)
077A  RW  extended control register (ECR) (see #P589)
----------P07900793--------------------------
PORT 0790-0793 - cluster (adapter 1)
----------P07BC07BE--------------------------
PORT 07BC-07BE - Intel 82091AA - ECP-mode PARALLEL PORT
SeeAlso: PORT 03BCh,PORT 0678h,PORT 0778h

03BC  RW  (when ECR bits 7-5=011) ECP Address/RLE FIFO (see #P583)
	(this is the same address normally used for parallel port data)
07BC  RW  (when ECR bits 7-5=010) standard parallel port data FIFO (see #P584)
07BC  RW  (when ECR bits 7-5=011) ECP data FIFO (see #P585)
07BC  RW  (when ECR bits 7-5=110) test FIFO (see #P586)
07BC  RW  (when ECR bits 7-5=111) ECP configuration A (see #P587)
07BD  RW  (when ECR bits 7-5=111) ECP configuration B (see #P588)
07BE  RW  extended control register (ECR) (see #P589)
----------P080008FF--------------------------
PORT 0800-08FF - I/O port access registers for extended CMOS RAM or SRAM
		(256 bytes at a time)
Note:	sometimes plain text can be seen here
--------X-P080008FF--------------------------
PORT 0800-08FF - reserved for EISA system motherboard
----------P0A200A23--------------------------
PORT 0A20-0A23 - Token Ring (adapter 1)
0A24-0A27 - Token Ring (adapter 2)
----------P0A79------------------------------
PORT 0A79 - Plug-and-Play - WRITE DATA PORT
Desc:	all data written to the Plug-and-Play configuration registers is
	  written to this port, including the configuration byte which
	  indicates the I/O port from which data is to be read when reading
	  the configuration registers
SeeAlso: PORT 0279h

0A79  -W  Plug-and-Play data writes
----------P0AE20AE3--------------------------
PORT 0AE2-0AE3 - cluster (adapter 2)
----------P0AE8------------------------------
PORT 0AE8 - S3 86C928 video controller (ELSA Winner 1000)
----------P0AE80AEF--------------------------
PORT 0AE8-0AEF - 8514/A and compatible (e.g. ATI Graphics Ultra) - HSYNC START

0AE8w -W  CRT control: horizontal sync start
----------P0B900B93--------------------------
PORT 0B90-0B93 - cluster (adapter 2)
----------P0C00------------------------------
PORT 0C00 - EISA??? - PAGE REGISTER

0C00  RW  page register to write to SRAM or I/O
--------X-P0C000CFF--------------------------
PORT 0C00-0CFF - reserved for EISA system motherboard
----------P0C7C------------------------------
PORT 0C7C		bit 7-4 (Compaq)
--------X-P0C800C83--------------------------
PORT 0C80-0C83 - EISA system board ID registers

0C80  R-  bit 7: unused (0)
	  bits 6-2: manufacturer ID, first compressed ASCII char
	  bits 1-0: manufacturer ID, second compressed ASCII char (high)
0C81  R-  bits 7-5: manufacturer ID, second compressed ASCII char (low)
	  bits 4-0: manufacturer ID, third compressed ASCII char
0C82  R-  reserved for manufacturer's use
0C83  R-  bits 7-3: reserved for manufacturer's use
	  bits 2-0: EISA bus version
--------X-P0CF80CFF--------------------------
PORT 0CF8-0CFF - PCI Configuration Mechanism 1 - Configuration Registers
SeeAlso: PORT 0CF8h"Mechanism 2"

0CF8d -W  configuration address port (see #P590)
0CFCd RW  configuration data port (when PORT 0CF8h bit 31 is set)

Bitfields for PCI configuration address port:
Bit(s)	Description	(Table P590)
 1-0	reserved (00)
 7-2	configuration register number (see #0850)
 10-8	function
 15-11	device number
 23-16	bus number
 30-24	reserved (0)
 31	enable configuration space mapping
Note:	configuration registers are considered DWORDs, so the number in bits
	  7-2 is the configuration space address shifted right two bits
SeeAlso: #P591
--------X-P0CF80CFA--------------------------
PORT 0CF8-0CFA - PCI Configuration Mechanism 2 - Configuration Registers
Notes:	this configuration mechanism is deprecated as of PCI version 2.1;
	  only mechanism 1 should be used for new systems
	to access the configuration space, write the target bus number to
	  the Forward Register, then write to the Configuration Space
	  Enable register, and finally read or write the appropriate I/O
	  port(s) in the range C000h to CFFFh (where Cxrrh accesses location
	  'rr' in physical device 'x's configuration data)
	the Intel "Saturn" and "Neptune" chipsets use configuration mechanism 2
SeeAlso: PORT 0CF8h"Mechanism 1",PORT C000h"PCI Configuration",PORT 0CFBh

0CF8  RW  Configuration Space Enable (CSE) (see #P591)
0CFA  RW  Forward Register (selects target bus number)

Bitfields for PCI Configuration Space Enable:
Bit(s)	Description	(Table P591)
 0	Special Cycle Enable (SCE)
 3-1	target function number (PCI logical device within physical device)
 7-4	key (non-zero to allow configuration)
SeeAlso: #P590
----------P0CF9------------------------------
PORT 0CF9 - Intel chipsets - TURBO/RESET CONTROL REGISTER
Notes:	this port can only be accessed via 8-bit IN or OUT instructions by
	  the CPU
	supported by the Intel "Saturn" and "Neptune" (82434NX) chipsets,
	  the Intel 82454KX/GX (450GX chipset), Intel 82420EX chipset, etc.
SeeAlso: PORT C051h,#0982,#1106

0CF9  RW  reboot system, optionally selecting de-turbo mode (see #P592)

Bitfields for Intel 82420EX turbo/reset control register:
Bit(s)	Description	(Table P592)
 7-4	reserved (0)
 3	(450KX/GX only) enable CPU BIST on reset
 2	reset CPU
 1	reset mode
	0 soft reset
	1 hard reset
 0	deturbo mode
Note:	when resetting the CPU, two writes are required: the first sets the
	  state of bit 1 while keeping bit 2 cleared, and the second sets
	  bit 2; the reset occurs on bit 2's transition from 0 to 1.
SeeAlso: PORT C051h
----------P0CFB------------------------------
PORT 0CFB - Intel 82434NX (Neptune) - PCI MECHANISM CONTROL REGISTER
Note:	not present on the 82434LX (Mercury), which supports only mechanism #2
SeeAlso: PORT 0CF8h

0CFB  RW  specify which PCI access mechanism is to be enabled

Bitfields for Intel 82434NX PCI mechanism control register:
Bit(s)	Description	(Table P593)
 7-1	reserved
 0	PCI Configuration Access Mechanism Select
	=0 use PCI configuration access mechanism #2 (0CF8/0CFA) (default)
	=1 use PCI configuration access mechanism #1 (0CF8/0CFC)
--------s-P0E800E83--------------------------
PORT 0E80-0E83 - Gravis Ultra Sound Daughter Card by Advanced Gravis
Range:	dipswitch selectable from PORT 0530h-0533h, PORT 0604h-0607h,
	  PORT 0E80h-0E83h, and PORT 0F40h-0F43h
--------s-P0E800E87--------------------------
PORT 0E80-0E87 - Windows Sound System
Range:	PORT 0530h-0537h,PORT 0604h-060Bh,PORT 0E80h-0E87h,PORT 0F40h-0F47h
SeeAlso: PORT 0530h"Sound System"
--------V-P0EE8------------------------------
PORT 0EE8 - S3 86C928 video controller (ELSA Winner 1000)
--------V-P0EE80EEF--------------------------
PORT 0EE8-0EEF - 8514/A and compatible (e.g. ATI Graphics Ultra) - HSYNC WIDTH

0EE8w -W  CRT control: horizontal sync width
--------s-P0F400F43--------------------------
PORT 0F40-0F43 - Gravis Ultra Sound Daughter Card by Advanced Gravis
Range:	dipswitch selectable from PORT 0530h-0533h, PORT 0604h-0607h,
	  PORT 0E80h-0E83h, and PORT 0F40h-0F43h
--------s-P0F400F47--------------------------
PORT 0F40-0F47 - Windows Sound System
Range:	PORT 0530h-0537h,PORT 0604h-060Bh,PORT 0E80h-0E87h,PORT 0F40h-0F47h
SeeAlso: PORT 0530h"Sound System"
--------s-P0F8D------------------------------
PORT 0F8D - OPTi 82C750 (Vendetta) - AUDIO MODULE BASE ADDRESS REGISTER
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

13C6  R?  Compaq video status??? (see #P594)

Bitfields for Compaq video status???:
Bit(s)	Description	(Table P594)
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
1C84  RW	EISA Video expansion board control (see #P595)
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

1C84  RW  configuration flags (see #P595)

Bitfields for EISA Add-in Card configuration flags:
Bit(s)	Description	(Table P595)
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
21xB  RW  ET4000/W32(i) CRTC-B/Sprite data register (see #P596)

(Table P596)
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

2C84  RW  configuration flags (see #P595)
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

3C84  RW  configuration flags (see #P595)
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

42E8w R-  Misc. control: Subsystem Status (see #P597)
42E8w -W  Misc. control: Subsystem Control (see #P598)

Bitfields for 8514/A Subsystem Status register:
Bit(s)	Description	(Table P597)
 15-8	(8514/A) reserved
 13	(S3) ???
 12-8	(S3) ???
 7	pixel length (0 = four bits, 1 = eight bits)
 6-4	reserved
 3	FIFO empty (interrupt generated if enabled)
 2	FIFO overflow (interrupt generated if enabled)
 1	Graphics Engine busy (interrupt generated if enabled)
 0	vertical sync (interrupt generated if enabled)
SeeAlso: #P598

Bitfields for 8514/A Subsystem Control Register:
Bit(s)	Description	(Table P598)
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
SeeAlso: #P597
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
SeeAlso: PORT 03C3h,PORT 46E8h"8514/A",#P496

46E8  rW  Misc. control: enable flags / select ROM page (8514/A) (see #P599)

Bitfields for VGA miscellaneous control register:
Bit(s)	Description	(Table P599)
 7-5	unused or vendor-specific
 4	setup for POS registers (MCA)
 3	enable video I/O ports and video buffer
 2-0	unused or vendor-specific
--------V-P46E8------------------------------
PORT 46E8 - 8514/A and compatible (e.g. ATI Graphics Ultra) - ROM PAGE SELECT
Note:	this register is readable on the C&T 82c480 chipset
SeeAlso: PORT 46E8h"VGA"

46E8w -W  ROM page select (see #P600)

Bitfields for 8514/A ROM page select register:
Bit(s)	Description	(Table P600)
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
SeeAlso: #P497

4AE8w -W  CRT control: Advanced function control (see also #P601)
	(02h = VGA mode, 03h = 480-line mode, 07h = 768-line mode)

Bitfields for S3 8514/A-compatible Advanced Function Control register:
Bit(s)	Description	(Table P601)
 15-7	reserved
 6	(928 only) enable Write Posting
 5	(928+) enable memory-mapped I/O
 4	(928+) enable linear addressing (see also #P489)
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

4C84  RW  configuration flags (see #P595)
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

5C84  RW  configuration flags (see #P595)
--------V-P5EE85EE9--------------------------
PORT 5EE8-5EE9 - C&T 82c480 - EXTENDED CONFIGURATION REGISTER 3
Note:	the 82c480 is an 8514/A-compatible video chipset
SeeAlso: PORT 52E8h"C&T",PORT 56E8h"C&T",PORT 5AE8h"C&T"

5EE8w RW  Extended Configuration Register 3
----------P5EEE------------------------------
PORT 5EEE - ATI Mach32 - MEMORY APERTURE CONFIGURATION REGISTER
SeeAlso: PORT 42EEh"Mach32"

5EEEw RW  Memory Aperture Configuration (see #P602)

Bitfields for ATI Mach32 Memory Aperture Configuration Register:
Bit(s)	Description	(Table P602)
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

6AEE  RW  maximum wait states (see #P603)

Bitfields for ATI Mach8/Mach32 wait state configuration:
Bit(s)	Description	(Table P603)
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

6C84  RW  configuration flags (see #P595)
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

7AEEw -W  extended graphics engine configuration (see #P604)

Bitfields for Mach8/Mach32 extended graphics engine configuration:
Bit(s)	Description	(Table P604)
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

7C84  RW  configuration flags (see #P595)
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
	  (see #P605)
Note:	this port may be read on S3 chipsets

Bitfields for 8514/A destination Y position / axial step constant register:
Bit(s)	Description	(Table P605)
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
	  (see #P605)
--------X-P8C008CFF--------------------------
PORT 8C00-8CFF - available for EISA slot 8
--------X-P8C808C83--------------------------
PORT 8C80-8C83 - EISA board product ID (board in slot 8)
SeeAlso: PORT 1C80h-1C83h
--------X-P8C84------------------------------
PORT 8C84 - EISA CONFIGURATION FLAGS (board in slot 8)

8C84  RW  configuration flags (see #P595)
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
	  (see #P605)
--------V-P8EEA8EEB--------------------------
PORT 8EEA-8EEB - S3 Trio64 - DESTINATION X COORD 2 / AXIAL STEP CONSTANT 2
Desc:	define the column at which the second of two edges for a polygon or
	  trapezoid will end, or the axial step constant for the second of
	  two edges for a Bresenham trapezoid
SeeAlso: PORT 8EE8h

8EEAw RW  drawing control: destination X position 2 / diagonal step constant 2
	  (see #P605)
--------V-P8EEE------------------------------
PORT 8EEE - ATI Mach32 - READ EXTENDED GRAPHICS CONFIGURATION
SeeAlso: PORT 72EEh

8EEE  R-  read extended graphics configuration (see #P604)
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

9AE8w R-  drawing control: graphic processor status (see #P606)
9AE8w -W  drawing control: command register (see #P607)

Bitfields for 8514/A graphic processor status:
Bit(s)	Description	(Table P606)
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
SeeAlso: #P607

Bitfields for 8514/A command register :
Bit(s)	Description	(Table P607)
 15-13	command (see #P608)
 12	byte sequence (0=high byte first, 1=low byte first)
 11-10	(8514/A) reserved
 11	(S3 Trio) high bit of command (see #P608)
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
SeeAlso: #P606,#P609

(Table P608)
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
SeeAlso: #P607
--------V-P9AEA9AEB--------------------------
PORT 9AEA-9AEB - S3 Trio64 - DRAWING COMMAND 2
Desc:	specify the drawing direction for the second edge of a Bresenham
	  trapezoid
SeeAlso: PORT 9AE8h

9AEAw -W  drawing command 2 (see #P609)

Bitfields for S3 Trio64 Drawing Command 2 register:
Bit(s)	Description	(Table P609)
 15-8	reserved
 7-5	drawing direction
	 7	0=draw vector above, 1=draw vector below (INC_Y)
	 6	0=x is maj. axis, 1=y is maj. axis (YMAJAXIS)
	 5	0=draw vector left, 1=draw vector right (INC_X)
 4-0	reserved
SeeAlso: #P607
--------V-P9AEE------------------------------
PORT 9AEE - ATI Mach8/Mach32 - LINEDRAW INDEX REGISTER
SeeAlso: PORT FEEEh

9AEE  -W  linedraw index register (specifies interpretation of PORT FEEEh)
	  (see #P610)

(Table P610)
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

9C84  RW  configuration flags (see #P595)
--------V-P9EE89EE9--------------------------
PORT 9EE8-9EE9 - 8514/A and compatible - SHORT STROKE VECTORS
Desc:	specify two short-stroke vectors to be drawn one after the other
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
	bit 12 of the command register (see PORT 9AE8h,#P607) specifies which
	  vector is drawn first

9EE8w -W  short line vector transfer (see #P611)

Bitfields for 8514/A short-stroke vector:
Bit(s)	Description	(Table P611)
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

A2EEw RW  line drawing options (see #P612)

Bitfields for ATI Mach8/Mach32 line drawing options:
Bit(s)	Description	(Table P612)
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

B6E8w -W  drawing control: background mix (see #P613)
Note:	this register may be read on S3 chipsets
--------V-PB6EE------------------------------
PORT B6EE - ATI Mach32 - ???

B6EEw RW  ???
--------V-PBAE8BAE9--------------------------
PORT BAE8-BAE9 - 8514/A and compatible - FOREGROUND MIX
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT B6E8h

BAE8w -W  drawing control: foreground mix (see #P613)
Note:	this register may be read on S3 chipsets

Bitfields for 8514/A color mix register:
Bit(s)	Description	(Table P613)
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

BEE8w -W  drawing control: multi-function control (see #P615)
BEE8w R-  (S3) value of register specified by current value of multi-function
	  read select register (index 0Fh bits 3-0) (see #P615)

(Table P614)
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
 0Fh -W (S3 801/805/928) read register select (see #P616)
SeeAlso: #P615

Bitfields for 8514/A Multi-Function Control registers:
Bit(s)	Description	(Table P615)
 15-12	register index (see #P614)
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
 3-0	(S3)	read select (see #P616)
 2-0	(8514/A) read select (see #P616)

(Table P616)
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
SeeAlso: #P614,#P615
--------X-PC000CFFF--------------------------
PORT C000-CFFF - PCI Configuration Mechanism 2 - CONFIGURATION SPACE
Note:	to access the configuration space, write the target bus number to
	  PORT 0CFAh, then write to the Configuration Space Enable register
	  (PORT 0CF8h), and finally read or write the appropriate I/O
	  port(s) in the range C000h to CFFFh (where Cxrrh accesses location
	  'rr' in physical device 'x's configuration data)
SeeAlso: PORT 0CF8h"Mechanism 2",PORT 0CFAh"Mechanism 2"
SeeAlso: #0850 at INT 1A/AX=B10Ah
--------d-PC100C1FF--------------------------
PORT C100-C1FF - Intel Pentium mboard - PCTech RZ1000 EIDE controller
Desc:	the PCI configuration registers for the EIDE controller are visible
	  on these ports when the PCI configuration space has been opened via
	  ports 0CF8h and 0CFAh
SeeAlso: PORT 03F0h"RZ1000",PORT 0CF8h,#0850 at INT 1A/AX=B10Ah
----------PC200C204--------------------------
PORT C200-C204 - Intel Pentium mboard ("Neptune" chipset)
Desc:	the PCI configuration registers for the motherboard chipset are visible
	  on these ports when the PCI configuration space has been opened via
	  ports 0CF8h and 0CFAh
SeeAlso: #0850 at INT 1A/AX=B10Ah
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

CEEEw -W  datapath configuration (see #P617)

Bitfields for ATI Mach8/Mach32 datapath configuration:
Bit(s)	Description	(Table P617)
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
SeeAlso: #0897

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
SeeAlso: #0976

+000w RC  power management status (see #P618)
+002w RW  power management enable (see #P619)
+004w RW  power management control (see #P620)
+006	  unused???
+008d RW  power management timer (24 or 32 bits)
+00C	  unused???
+010d RW  processor power management control (see #P621)
+014  R-  "P_LVL2" processor level 2 -- reading switches to C2 power state
+015  R-  "P_LVL3" processor level 3 -- reading switches to C3 power state
+016	  unused???
+020w RC  general purpose status (see #P622)
+022w RW  general purpose SCI enable (see #P623)
+024w RW  general purpose SMI enable (see #P624)
+026w RW  power supply control (see #P625)
+028w RC  global power management status (see #P626)
+02Aw RW  global power management enable (see #P627)
+02Cw RW  global power management control (see #P628)
+02E	  unused???
+02F  RW  SMI command
	writing this port sets the SW_SMI_STS bit (see #P626,#P627)
+030d RC  primary activity detection status (see #P629)
+034d RW  primary activity detection enable (see #P630)
+038d RW  general purpose timer reload enable (see #P631)
+03C	  unused???
+040  RW  control of general-purpose I/O direction (see #P632)
+041	  ???
+042  RW  output value for GPIO port (see #P633)
+043  RW  ???
+044  RW  input value for GPIO port (see #P634)
+045  RW  ???
+046w RW  output value for general-purpose output port
+048w RW  input value for general-purpose input port

Bitfields for AMD-645 Power Management Control Status:
Bit(s)	Description	(Table P618)
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
SeeAlso: #P619,MEM xxxxh:xxx0h"ACPI"

Bitfields for AMD-645 Power Management Enable register:
Bit(s)	Description	(Table P619)
 15-11	reserved (0)
 10	enable SCI/SMI on RTC alarm
 9	reserved (0)
 8	enable SCI/SMI when PB_STS set (see #P618 bit 8)
 7-6	reserved
 5	enable SCI/SMI when GBL_STS set (see #P618 bit 5)
 4-1	reserved
 0	enable SCI/SMI when ACPI timer carries
SeeAlso: #P618,#P620,MEM xxxxh:xxx0h"ACPI"

Bitfields for AMD-645 Power Management Control register:
Bit(s)	Description	(Table P620)
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
SeeAlso: #P618,#P619

Bitfields for AMD-645 Processor Power Management Control register:
Bit(s)	Description	(Table P621)
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
SeeAlso: #P620,#P621

Bitfields for AMD-645 General Purpose Status register:
Bit(s)	Description	(Table P622)
 15-10	reserved (0)
 9	"USB_STS"	USB peripheral generated resume event
 8	"RI_STS"	ring detected (RI# asserted)
 7	"EXT7_STS"	EXTSMI7# pin toggled
 6-0	"EXT?_STS"	EXTSMI6# - EXTSMI0# pins toggled
SeeAlso: #P620,#P623

Bitfields for AMD-645 General Purpose SCI Enable register:
Bit(s)	Description	(Table P623)
 15-10	reserved (0)
 9	enable SCI when USB_STS bit becomes set
 8	enable SCI when RI_STS bit becomes set
 7-0	enable SCI when EXT?_STS bit becomes set
SeeAlso: #P622,#P624

Bitfields for AMD-645 General Purpose SMI Enable register:
Bit(s)	Description	(Table P624)
 15-10	reserved (0)
 9	enable SMI when USB_STS bit becomes set
 8	enable SMI when RI_STS bit becomes set
 7-0	enable SMI when EXT?_STS bit becomes set
SeeAlso: #P622,#P623,#P625

Bitfields for AMD-645 Power Supply Control register:
Bit(s)	Description	(Table P625)
 15-11	reserved (0)
 10	enable setting of RI_STS bit to turn on power
 9	set PB_STS bit to resume from suspend
 8	set RTC_STS bit to resume from suspend on RTC alarm
 7-1	reserved (0)
 0	enable setting of EXT0_STS bit to resume from suspend
SeeAlso: #P622,#P626,#P627

Bitfields for AMD-645 PM Global Status register:
Bit(s)	Description	(Table P626)
 15-7	reserved (0)
 6	"SW_SMI_STS" SMI_CMD port has been written
 5	"BIOS_STS" set whenever GLB_RLS bit is set; GLB_RLS is cleared when
	  this bit is cleared
 4	legacy USB event occurred
 3	GP1 timer timed out
 2	GP0 timer timed out
 1	secondary event timer timed out
 0	"PACT_STS" an enabled primary system activity has occurred (see #P630)
Note:	this register is write-clear: writing a 1 to a bit clears that bit
SeeAlso: #P625

Bitfields for AMD-645 PM Global Enable register:
Bit(s)	Description	(Table P627)
 15-7	reserved (0)
 6	enable SMI when SMI_CMD port is written
 5	enable SMI when BIOS_STS bit set (see #P626)
 4	enable SMI on legacy USB events
 3	enable SMI when GP1 timer times out
 2	enable SMI when GP0 timer times out
 1	enable SMI when secondary event timer times out
 0	enable SMI on occurrence of any primary activity
SeeAlso: #P625,#P626,#P628

Bitfields for AMD-645 PM Global Control ("GLB_CTL") register:
Bit(s)	Description	(Table P628)
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
SeeAlso: #P625,#P626,#P627,MEM xxxxh:xxx0h"ACPI"

Bitfields for AMD-645 PM Primary Activity Detect Status register:
Bit(s)	Description	(Table P629)
 31-8	reserved (0)
 7	keyboard controller accessed via PORT 0060h
 6	serial port accessed (via PORT 03F8h-03FFh, 02F8h-02FFh, 03E8h-03EFh,
	  or PORT 02E8h-02EFh)
 5	parallel port accessed (via PORT 0278h-027Fh or PORT 0378h-037Fh)
 4	video controller accessed
 3	IDE or Floppy controller accessed
 2	reserved (0)
 1	a primary interrupt occurred (see #0976 [offset 44h])
 0	ISA busmaster or DMA activity occurred
Note:	this register is write-clear: write a 1 to a bit to clear it
SeeAlso: #P630,#P628

Bitfields for AMD-645 PM Primary Activity Detect Enable register:
Bit(s)	Description	(Table P630)
 31-8	reserved (0)
---set PACT_STS (see #P626) whenever:
 7	keyboard controller is accessed via PORT 0060h
 6	serial port is accessed (via PORT 03F8h-03FFh, 02F8h-02FFh,
	  PORT 03E8h-03EFh, or PORT 02E8h-02EFh)
 5	parallel port is accessed (via PORT 0278h-027Fh or PORT 0378h-037Fh)
 4	video controller is accessed
 3	IDE or Floppy controller is accessed
 2	reserved (0)
 1	a primary interrupt occurrs (see #0976 [offset 44h])
 0	ISA busmaster or DMA activity occurrs
SeeAlso: #P629,#P628

Bitfields for AMD-645 GP Timer Reload Enable register:
Bit(s)	Description	(Table P631)
 31-8	reserved (0)
 7	reload GP1 whenever keyboard controller is accessed
 6	reload GP1 whenever a serial port is accessed
 5	reserved (0)
 4	reload GP1 whenever video controller is accessed
 3	reload GP1 whenever IDE or floppy controller is accessed
 2-1	reserved (0)
 0	reload GP0 whenever a primary activity is detected
SeeAlso: #P630,#P629

Bitfields for AMD-645 GPIO Direction Control register:
Bit(s)	Description	(Table P632)
 7-5	reserved (0)
 4	direction of GPIO4 (0 = input, 1 = output)
	this bit sets Pin136, which is always output if configured as GPO_WE#
 3	direction of GPIO3 (0 = input, 1 = output)
	this bit sets Pin92, which is always an output if configured as GPI_RE#
 2	direction of GPIO2/I2CD1 (0 = input, 1 = output)
 1	direction of GPIO1/I2CD2 (0 = input, 1 = output)
 0	direction of GPIO0 (0 = input, 1 = output)
SeeAlso: #P630,#P633

Bitfields for AMD-645 GPIO Port Output Value register:
Bit(s)	Description	(Table P633)
 7-5	reserved
 4	value for GPIO4 pin (ignored if pin configured as GPO_WE#)
 3	value for GPIO3 pin (ignored if pin configured as GPI_RE#)
 2	value for GPIO2/I2CD1 pin
 1	value for GPIO1/I2CD2 pin
 0	value for GPIO0 pin
Note:	while these bits can be read back, they only indicate the values which
	  are driven onto the pins if configured for output; to read the actual
	  input values, use the "input value" register at offset 44h
	  (see #P634)
SeeAlso: #P634

Bitfields for GPIO Port Input Value (EXTSMI_VAL) register:
Bit(s)	Description	(Table P634)
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
SeeAlso: #P633
--------X-Pxxxx------------------------------
PORT xxxx - AMD-645 - USB
SeeAlso: #0973 at INT 1A/AX=B10Ah/SF=1106h
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
--------d-Pxxxx------------------------------
PORT xxxx - Intel 82371 - Bus Master IDE Registers

+000  RW  command register, primary channel (see #P635)
+002  Rw  status register, primary channel (see #P636)
+004d RW  IDE descriptor table pointer, primary channel (see #P637)
+008  RW  command register, secondary channel (see #P635)
+00A  Rw  status register, secondary channel (see #P636)
+00Cd RW  IDE descriptor table pointer, secondary channel (see #P637)

Bitfields for Intel 82371 Bus Master IDE command register:
Bit(s)	Description	(Table P635)
 7-4	reserved
 3	bus master read/write control
	=0 read
	=1 write
 2-1	reserved
 0	start/stop bus master
	=1 start
	=0 stop
SeeAlso: #P636,#P637

Bitfields for Intel 82371 Bus Master IDE status register:
Bit(s)	Description	(Table P636)
 7	reserved (0)
 6	drive 1 is DMA-capable
 5	drive 0 is DMA_capable
 4-3	reserved
 2	IDE interrupt pending
	write 1 to this bit to clear it
 1	IDE DMA error
	write 1 to this bit to clear it
 0	bus master IDE active (read-only)
SeeAlso: #P635,#P637

Bitfields for Intel 82371 Bus Master IDE descriptor table pointer register:
Bit(s)	Description	(Table P637)
 31-2	descriptor table base address bits 31-2
 1-0	reserved
Note:	the descriptor table must not cross a 4K boundary
SeeAlso: #P635,#P636
----------Pxxxx------------------------------
PORT xxxx - Intel 82371SB - USB Host I/O Registers
InstallCheck: see #1082 at INT 1A/AX=B10Ah
SeeAlso: #1082

+000w RW  USB command register (see #P638)
+002w Rw  USB status (see #P639)
+004w RW  USB interrupt enable (see #P640)
+006w RW  Frame Number (see #P641)
+008d RW  Frame List Base Address
	   (bits 11-0 must be written as zeros)
+00C  RW  Start of Frame Modify (see #P642)
+010w RW  port 1 status/control (see #P643)
+012w RW  port 2 status/control (see #P643)

Bitfields for Intel 82371SB USB command register:
Bit(s)	Description	(Table P638)
 15-8	reserved
 7	maximum packet size (0=32 bytes, 1=64 bytes)
 6	Host Controller has been configured (set by software)
 5	software debug mode
 4	force global resume
 3	enter global suspend mode
 2	global reset
 1	host controller reset
 0	run/stop schedule (0=stop, 1=run)
SeeAlso: #P639

Bitfields for Intel 82371SB USB status register:
Bit(s)	Description	(Table P639)
 15-6	reserved
 5	host controller halted
 4	host controller process error
 3	PCI bus error
 2	resume received
 1	USB error interrupt
 0	USB interrupt
Note:	to clear a bit in this register, write a 1 to it
SeeAlso: #P638

Bitfields for Intel 82371SB USB interrupt enable register:
Bit(s)	Description	(Table P640)
 15-4	reserved
 3	enable short packet interrupts
 2	enable Interrupt On Complete
 1	enable Resume
 0	enable Timeout/CRC
SeeAlso: #P639,#P641

Bitfields for Intel 82371SB Frame Number register:
Bit(s)	Description	(Table P641)
 15-11	reserved
 10-0	Frame List Current Index/Frame Number
	incremented at end of each time frame (~1ms)
Note:	only WORD writes are allowed to this register
SeeAlso: #P638,#P640

Bitfields for Intel 82371SB Start of Frame Modify register:
Bit(s)	Description	(Table P642)
 7	reserved
 6-0	SOF timing value (default 64)
Note:	SOF cycle time equals 11936+timing value
SeeAlso: #P638

Bitfields for Intel 82371SB Port 1/2 status/control register:
Bit(s)	Description	(Table P643)
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
SeeAlso: #P638
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
Highest Table Number = P643
--------!---FILELIST-------------------------
Please redistribute all of the files comprising the interrupt list (listed at
the beginning of the list and in INTERRUP.1ST) unmodified as a group, in a
quartet of archives named INTER58A through INTER58D (preferably the original
authenticated PKZIP archives), and the utility and hypertext programs in a trio
of additional archives called INTER58E.ZIP to INTER58G.ZIP.

Copyright (c) 1989,1990,1991,1992,1993,1994,1995,1996,1997,1998 Ralf Brown
--------!---CONTACT_INFO---------------------
Internet: ralf@pobox.com (currently forwards to ralf@telerama.lm.com)
UUCP: {uunet,harvard}!pobox.com!ralf
FIDO: Ralf Brown 1:129/26.1
	or post a message to me in the DR_DEBUG echo (I probably won't see it
	unless you address it to me)
CIS:  >INTERNET:ralf@pobox.com
