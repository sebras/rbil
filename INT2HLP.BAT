@REM=("
@perl -w %0.bat %1 %2 %3 %4 %5 %6 %7 %8 %9
@end ") if 0 ;
#
# Create a quickhelp file from the PC interrupt list.
# By Diomidis Spinellis <dds@cc.ic.ac.uk>.
#
# You will need the Microsoft helpmake utility, a sort that takes the -f (fold)
# option, around 9 hours of 20MHz 386 CPU time and around 4 MB of disk space.
# Put all the interrupt list distribution files in one directory and run the
# program.
#
# (C) Copyright 1991 Diomidis Spinellis.  All rights reserved.
# Permission to use and distribute this file without modification is given.
#

$labelnum = 0;
# int.byf - Interrupts by Function (Tree Internal Nodes)
&maketop_by_function();
&makecont(0, "Interrupts by Function", "int.byfunc", "int.hlp");
&merge_out('int.byf');
# int.byv - Interrupts by Value (Tree Internal Nodes)
&maketop_by_value();
&makecont(0, "Interrupts by Value", "int.byval", "int.hlp");
&merge_out('int.byv');
# int.bot - Interrupt List Interrupts (Tree Terminal Nodes)
&summary('int.byv', 'sum.byv');
&summary('int.byf', 'sum.byf');
&makebottom();
&unlink_intermediate();
unlink('interrup.lst');	# To make room
# int.idx - Interrupt List Index
&makeindex();
# int.fil - Interrupt List Auxiliary Files
unlink('int.fil');
&incfile('int.mem', 'Memory List', 'memory.lst');
&incfile('int.pri', 'Interrupt Primer', 'interrup.pri');
&incfile('int.ack', 'Distribution, Abbreviations and Acknowledgements', 'interrup.1st');
# int.toc - Interupt List Table of Contents
&maketoc();
exec('helpmake', '/T', '/e', '/W100', '/oint.hlp', '/V', 'int.toc', 'int.byv', 'int.byf', 'int.bot', 'int.idx', 'int.fil');

# Create a contents file.  Level is the recursive level, topic the
# header to use, context the unique identifier for this topic and
# up the identifier of the parent topic.
# Works by scanning the input of the current level line by line and
# identifying topics.  If the topic is unique it is output on a list
# else the topic is output on the list with a pointer to another list
# and the function is called recursively.
sub makecont
{
	local($level, $topic, $context, $up) = @_;
	local($IN, $OUT);
	local($l, $prev, $part, $ref, $tmp);

	$IN = "IN$level";
	$OUT = "OUT$level";
	open($IN, "sort in$level|") || die;
	open($OUT, ">>out$level") || die;

	print "makecont($level, [$topic], [$context], [$up])\n";
	print $OUT ".context $context\n";
	print $OUT ".freeze 3\n";
	print $OUT ".topic $topic\n";
	print $OUT "                                             \\i\021\\p\\aUp\\v${up}\\v\\i\020\\p \\i\021\\p\\aContents\\vint.hlp\\v\\i\020\\p \\i\021\\p\\aIndex\\vint.idx\\v\\i\020\\p \\i\021\\p\\aBack\\v!B\\v\\i\020\\p\n";
	print $OUT "\304" x 75 . "\n\n";
	while (<$IN>) {
		chop;
		print "$level: Read [$_]\n";
		$part = (split(/ \- /))[0];
		if ($part =~ /^`/) {
			$part =~ s/`//;
		} else {
			$part =~ s/`.*//;
		}
		next if ($part eq $prev);
		$ref = (split(/`/))[1];
		print "part = [$part]\n";
		if (&count($part, "in$level") <= 1) {
			if ($ref eq '') {
				print $OUT "\t\\a$part\\v$part\\v\n";
			} else {
				print $OUT "\t\\a$part\\v$ref\\v\n";
			}
		} else {
			$u = &newlabel();
			print $OUT "\t\\a$part\\v$u\\v\n";
			$l = $level + 1;
			&copymatch($part, "in$level", "in$l");
			$tmp = $context;
			&makecont($l, $part, $u, $tmp);
		}
		$prev = $part;
	}
	print $OUT ' ' x 35 . "-\04-\n";
	close($IN);
	close($OUT);
}

# Return number of lines matching string
sub count
{
	local($string, $file) = @_;

	$string =~ s/(\W)/\\$1/g;
	open (CIN, $file) || die;
	$count = 0;
	while (<CIN>) {
		$count++ if (/^$string(( - )|`)/);
	}
	print "count($string) = $count\n";
	close(CIN);
	return $count;
}

# Copy lines that match string from $in to $out removing string
sub copymatch
{
	local($string, $in, $out) = @_;

	$string =~ s/(\W)/\\$1/g;
	open(CIN, $in) || die;
	open(COUT, ">$out") || die;
	while (<CIN>) {
		if (/^$string(( - )|`)/) {
			s/^$string[-\s`]*//;
			print COUT;
		}
	}
	close(CIN);
	close(COUT);
}

# Open the interrupt list and create a file with one line for each
# interrupt.  The line consists of the interrupt description followed
# by a backtick and the interrupt number.
sub maketop_by_function
{
	&unlink_out();
	open(IN, "interrup.lst") || die;
	open(OUT, ">in0") || die;
	while (<IN>) {
		if (/^--------/) {
			chop;
			$int = $_;
			$int =~ s/-+//g;
			if ($last eq $int) {
				$int .= $letter++;
			} else {
				$letter = 'a';
				$last = $int;
			}
		}
		if (/^INT /) {
			chop;
			$line = $_;
			$line =~ s/^INT [^-]*- //;
			$line =~ s/\\/\\\\/g;
			print OUT "$line\`$int\n";
		}
	}
	close(IN);
	close(OUT);
}

# Return a unique new label
sub newlabel
{
	return "\@IL" . $labelnum++;
}

# Unlink all output files
sub unlink_out
{
	for ($i = 0; $i < 10; $i++) {
		unlink("out$i");
	}
}

# Unlink all intermediate files
sub unlink_intermediate
{
	for ($i = 0; $i < 10; $i++) {
		unlink("out$i");
		unlink("in$i");
	}
	unlink('sum.byf');
	unlink('sum.byv');
}

# Merge the output files into int.byf
sub merge_out
{
	local($outname) = @_;

	open(OUT, ">$outname");
	for ($i = 0; $i < 10; $i++) {
		if (open(IN, "out$i")) {
			while (<IN>) {
				print OUT;
			}
			close(IN);
		}
	}
	close(OUT);
	&unlink_out();
}

# Open the interrupt list and create a file with one line for each
# interrupt.  The line consists of the interrupt identifications
# (number and register values) followed by the unique interrupt identifier
sub maketop_by_value
{
	&unlink_out();
	open(IN, "interrup.lst") || die;
	open(OUT, ">in0") || die;
	while (<IN>) {
		if (/^----------[0-9A-F]/) {
			chop;
			$int = $_;
			$int =~ s/-+//g;
			if ($last eq $int) {
				$int .= $letter++;
			} else {
				$letter = 'a';
				$last = $int;
			}
			$_ =~ /^----------(..)(..)(..)(..)(....)/;
			$num = $1;	# Interrupt number
			$ah = $2;	# Register AH
			$al = $3;	# Register AL
			$rn = $4;	# Other register name
			$rv = $5;	# Other register value (8 or 16 bit)
			$rv =~ s/-//g;
			print OUT "INT $num";
			print OUT " - AH = $ah" if ($ah ne '--');
			print OUT " - AL = $al" if ($al ne '--');
			print OUT " - $rn = $rv" if ($rn ne '--');
			print OUT "`$int\n";
		}
	}
	close(IN);
	close(OUT);
}

# Create the bottom nodes of the file
# Each node contains a navigation line for going upwards by value or function
# Try to create seens for the SeeAlso lines
sub makebottom
{
	open(IN, "interrup.lst") || die;
	open(OUT, ">int.bot") || die;
	print OUT ".context int.intro\n";
	print OUT ".freeze 3\n";
	print OUT ".topic Interrupt List\n";
	print OUT "                                             \\i\021\\p\\aUp\\vint.hlp\\v\\i\020\\p \\i\021\\p\\aContents\\vint.hlp\\v\\i\020\\p \\i\021\\p\\aIndex\\vint.idx\\v\\i\020\\p \\i\021\\p\\aBack\\v!B\\v\\i\020\\p\n";
	print OUT "\304" x 75 . "\n\n";
	while (<IN>) {
		chop;
		s/\\/\\\\/g;
		if (/^----------[0-9A-F]/) {
			$int = $_;
			$int =~ s/-+//g;
			if ($last eq $int) {
				$int .= $letter++;
			} else {
				$letter = 'a';
				$last = $int;
			}
			$_ =~ /^----------(..)(..)(..)(..)(....)/;
			$num = $1;	# Interrupt number
		} elsif (/^INT /) {
			$line = $_;
			print "$line\n";
			print OUT ' ' x 35 . "-\04-\n";
			print OUT ".context $int\n";
			print OUT ".freeze 4\n";
			print OUT ".topic $line\n";
			$upf = &parent('sum.byf', $int);
			$upv = &parent('sum.byv', $int);
			print OUT "                         \\i\021\\p\\aUp Function\\v${upf}\\v\\i\020\\p \\i\021\\p\\aUp Value\\v${upv}\\v\\i\020\\p \\i\021\\p\\aContents\\vint.hlp\\v\\i\020\\p \\i\021\\p\\aIndex\\vint.idx\\v\\i\020\\p \\i\021\\p\\aBack\\v!B\\v\\i\020\\p\n";
			print OUT "\304" x 75 . "\n";
			print OUT "\\b$line\\p\n\n";
		} elsif (/^SeeAlso: (.*)$/) {
			print OUT '\bSeeAlso:\p ';
			@back = @list = split(/, */, $1);
			for ($i = 0; $i <= $#list; $i++) {
				$list[$i] =~ s/"[^"]*"//g;
				$list[$i] =~ s/A[HX]//g;
				$list[$i] =~ s/[\/h=]//g;
				if ($list[$i] =~ /^INT (..)/) {
					$num = $1;
					$list[$i] =~ s/^INT //;
				} else {
					$list[$i] =~ s/^/$num/;
				}
				if ($cont = &intcontext($list[$i])) {
					print OUT "\\i\021\\p\\a$back[$i]\\i\020\\p\\v$cont\\v";
				} elsif (&exists($list[$i])) {
					print OUT "\\i\021\\p\\a$back[$i]\\i\020\\p\\v$list[$i]\\v";
				} else {
					print OUT "$back[$i]";
				}
				print OUT ', ' if ($i < $#list);
			}
			print OUT "\n";
		} elsif (/^(\w+:)(.*)$/) {
			print OUT "\\b$1\\p$2\n";
		} else {
			print OUT;
			print OUT "\n";
		}
	}
	print OUT ' ' x 35 . "-\04-\n";
	close(IN);
	close(OUT);
}

# Reding $in create a $out file containing each context and its parent
# context.
sub summary
{
	local($in, $out) = @_;

	open(IN, $in) || die;
	open(OUT, ">$out") || die;
	while (<IN>) {
		chop;
		next if (/\\i\021\\p/);
		if (/^\.context (.*)$/) {
			$context = $1;
		}
		if (/\\v([^I][^\\]+)/) {
			print OUT "$1`$context\n";
		}
	}
}

# Return the parent of node $val in file $in
sub parent
{
	local ($in, $val) = @_;

	open (SUM, $in) || die;
	while (<SUM>) {
		chop;
		if (/^$val`(.*)$/) {
			close(SUM);
			return $1;
		}
	}
	print STDERR "$val has not parent node!\n";
	close(SUM);
	return 'int.hlp';
}

# Return true if a bottom node $val exists as a context
sub exists
{
	local ($val) = @_;

	open (EX, 'sum.byf') || die;
	while (<EX>) {
		chop;
		if (/^$val`/) {
			close(SUM);
			return 1;
		}
	}
	print STDERR "$val does not exist!\n";
	close(SUM);
	return 0;
}

# Given a two digit interrupt number return the correct context
# Works by searching the first 300 lines of int.byv.  Do not change
# its format without checking this function.
sub intcontext
{
	local($int) = @_;

	if ($int !~ /^[0-9][A-F][0-9][A-F]$/) {
		return undef;
	}
	open(INC, 'int.byv') || die;
	$i = 0;
	while (<INC> && $i < 300) {
		if (/\\aINT $int\\v([^\\]+)\\v$/) {
			close(INC);
			return $1;
		}
		$i++;
	}
	close(INC);
	print STDERR "Unable to locate interrupt $int\n";
	return undef;
}

# Make a simple index by concatenating all the int.byf lines and sorting them
# by character.
sub makeindex
{
	open(IN, 'sort -f int.byf|');
	open(OUT, '>int.idx');
	undef $prev;
	while (<IN>) {
		if (/^\t\\a(.)/) {
			$letter = $1;
			$letter =~ tr/[a-z]/[A-Z]/;
			if ($letter ne $prev) {
				print OUT ' ' x 35 . "-\04-\n" if ($prev);
				print OUT ".context \@IL.$letter\n";
				print OUT ".freeze 3\n";
				print OUT ".topic Index $letter\n";
				print OUT "                                             \\i\021\\p\\aUp\\vint.idx\\v\\i\020\\p \\i\021\\p\\aContents\\vint.hlp\\v\\i\020\\p \\i\021\\p\\aIndex\\vint.idx\\v\\i\020\\p \\i\021\\p\\aBack\\v!B\\v\\i\020\\p\n";
				print OUT "\304" x 75 . "\n\n";
				$all .= $letter;
				$prev = $letter;
			}
			print OUT;
		}
	}
	close(IN);
	print OUT ' ' x 35 . "-\04-\n";
	print OUT ".context int.idx\n";
	print OUT ".context h.idx\n";
	print OUT ".freeze 3\n";
	print OUT ".topic Index\n";
	print OUT "                                             \\i\021\\p\\aUp\\vint.hlp\\v\\i\020\\p \\i\021\\p\\aContents\\vint.hlp\\v\\i\020\\p \\i\021\\p\\aIndex\\vint.idx\\v\\i\020\\p \\i\021\\p\\aBack\\v!B\\v\\i\020\\p\n";
	print OUT "\304" x 75 . "\n\n";
	for ($i = 0; $i < length($all); $i++) {
		$l = substr($all, $i, 1);
		print OUT "\\a\t\\i\021\\p$l\\i\020\\p\\v\@IL.$l\\v\n";
	}
	print OUT ' ' x 35 . "-\04-\n";
	close(OUT);
}

# Include a file with given context, topic and filename to the file int.fil
sub incfile
{
	local($context, $topic, $name) = @_;

	open(OUT, '>>int.fil');
	open(IN, "$name") || die;
	print OUT ".context $context\n";
	print OUT ".freeze 3\n";
	print OUT ".topic $topic\n";
	print OUT "                                             \\i\021\\p\\aUp\\vint.hlp\\v\\i\020\\p \\i\021\\p\\aContents\\vint.hlp\\v\\i\020\\p \\i\021\\p\\aIndex\\vint.idx\\v\\i\020\\p \\i\021\\p\\aBack\\v!B\\v\\i\020\\p\n";
	print OUT "\304" x 75 . "\n\n";
	while (<IN>) {
		s/\\/\\\\/g;
		print OUT;
	}
	print OUT ' ' x 35 . "-\04-\n";
	close(OUT);
}

# Create the table of contents file
sub maketoc
{
	open(OUT, '>int.toc') || die;
	print OUT 
".context Interrupt List
.context int.hlp
.context int
.context interrupt list
.context h.contents
.context h.pg1
.context contents
.freeze 3
.topic The Interrupt List
\t\t\t\\bThe PC Interrupt List\\p
\t

\t\\a\\i\021\\pIntroduction\\vint.intro\\v\\i\020\\p

\t\\a\\i\021\\pInterrupts by Value\\vint.byval\\v\\i\020\\p

\t\\a\\i\021\\pInterrupts by Function\\vint.byfunc\\v\\i\020\\p

\t\\a\\i\021\\pMemory List\\vint.mem\\v\\i\020\\p

\t\\a\\i\021\\pInterrupt Primer\\vint.pri\\v\\i\020\\p

\t\\a\\i\021\\pIndex\\vint.idx\\v\\i\020\\p

\t\\a\\i\021\\pDistribution, Abbreviations and Acknowledgements\\vint.ack\\v\\i\020\\p


Compilation Copyright (c) 1989, 1990, 1991 Ralf Brown
Helpmake conversion Copyright (c) 1991 Diomidis Spinellis

                                   -\04-
.context List Categories
Interrupt List
";
	close(OUT);
}
