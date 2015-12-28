#! /usr/bin/env perl
# Create LaTeX tables for each country
# Version 0: Jane Coates 28/12/2015

use strict;
use diagnostics;

my $allocation_file = "Benelux_CB05_NMVOC_Allocation.csv";
my %emissions;

open my $in, '<:encoding(utf-8)', $allocation_file or die "Can't open $allocation_file for reading : $!";
my @lines = <$in>;
close $in;

my $out_file = "table_CB05_NMVOC_allocations.tex";
open my $out, '>:encoding(utf-8)', $out_file or die $!;
print $out "\\scriptsize\n";
print $out "\\begin{longtable}{llllllllllllllllll}\n";
print $out "\t\\caption{Allocation of MCMv3.2 species used to represent NMVOC emissions from Benelux allocated to CB05 species.}\\\\\n";
print $out "\t\\hline \\hline\n";
foreach my $line (@lines) {
    chomp $line;
    if ($line =~ /^Type/) {
        $line = "\\multirow{2}{*}{\\textbf{Type}} & \\textbf{MCMv3.2} & \\multirow{2}{*}{\\textbf{PAR}} & \\multirow{2}{*}{\\textbf{OLE}} & \\multirow{2}{*}{\\textbf{TOL}} & \\multirow{2}{*}{\\textbf{XYL}} & \\multirow{2}{*}{\\textbf{FORM}} & \\multirow{2}{*}{\\textbf{ALD2}} & \\multirow{2}{*}{\\textbf{ALDX}} & \\multirow{2}{*}{\\textbf{MEOH}} & \\multirow{2}{*}{\\textbf{ETOH}} & \\multirow{2}{*}{\\textbf{FACD}} & \\multirow{2}{*}{\\textbf{AACD}} & \\multirow{2}{*}{\\textbf{ETH}} & \\multirow{2}{*}{\\textbf{ETHA}} & \\multirow{2}{*}{\\textbf{IOLE}} & \\multirow{2}{*}{\\textbf{ISOP}} & \\multirow{2}{*}{\\textbf{TERP}} \\\\\n";
        $line .= "& \\textbf{Species} & & & & & & & & & & & & & & & & ";
        $line .= "\\\\\n\t\\endhead\n\t\\hline";
        print $out "\t", $line, "\n";
        next;
    }
    $line =~ s/,/ & /g;
    $line =~ s/(\s+)?$/ \\\\/;
    #amendments to specific types
    if ($line =~ /^Butanes/) {
        $line =~ s/Butanes/\\multirow{2}{*}{Butanes}/;
    } elsif ($line =~ /^Pentanes/) {
        $line =~ s/Pentanes/\\hline \\multirow{3}{*}{Pentanes}/;
    } elsif ($line =~ /^Hexane/) {
        $line =~ s/Hexane_and_Higher_Alkanes/\\hline \\parbox[t]{2mm}{\\multirow{14}{*}{\\rotatebox[origin=c]{90}{Hexane and Higher Alkanes}}}/;
    } elsif ($line =~ /^Higher_Alkenes/) {
        $line =~ s/Higher_Alkenes/\\hline \\parbox[t]{2mm}{\\multirow{11}{*}{\\rotatebox[origin=c]{90}{Higher Alkenes}}}/;
    } elsif ($line =~ /^Xylenes/) {
        $line =~ s/Xylenes/\\multirow{3}{*}{Xylenes}/;
    } elsif ($line =~ /^Trimethylbenzenes/) {
        $line =~ s/Trimethylbenzenes/\\hline \\multirow{3}{*}{Trimethylbenzenes}/;
    } elsif ($line =~ /^Other_Aromatics/) {
        $line =~ s/Other_Aromatics/\\hline \\parbox[t]{2mm}{\\multirow{11}{*}{\\rotatebox[origin=c]{90}{Other Aromatics}}}/;
    } elsif ($line =~ /^Other_Aldehydes/) {
        $line =~ s/Other_Aldehydes/\\parbox[t]{2mm}{\\multirow{9}{*}{\\rotatebox[origin=c]{90}{Other Aldehydes}}}/;
    } elsif ($line =~ /^Alkadienes/) {
        $line =~ s/Alkadienes_and_Other_Alkynes/\\hline Alkadienes and/;
    } elsif ($line =~ /C5H8/) {
        $line =~ s/^/Other Alkynes/;
    } elsif ($line =~ /Organic_Acids/) {
        $line =~ s/Organic_Acids/\\hline \\multirow{4}{*}{Organic Acids}/;
    } elsif ($line =~ /Alcohols/) {
        $line =~ s/Alcohols/\\hline \\parbox[t]{2mm}{\\multirow{19}{*}{\\rotatebox[origin=c]{90}{Alcohols}}}/;
    } elsif ($line =~ /Ketones/) {
        $line =~ s/Ketones/\\hline \\parbox[t]{2mm}{\\multirow{10}{*}{\\rotatebox[origin=c]{90}{Ketones}}}/;
    } elsif ($line =~ /Ethers/) {
        $line =~ s/Ethers/\\hline \\parbox[t]{2mm}{\\multirow{10}{*}{\\rotatebox[origin=c]{90}{Ethers}}}/;
    } elsif ($line =~ /Chlorinated_Hydrocarbons/) {
        $line =~ s/Chlorinated_Hydrocarbons/\\hline \\parbox[t]{2mm}{\\multirow{12}{*}{\\rotatebox[origin=c]{90}{Chlorinated Hydrocarbons}}}/;
    } elsif ($line =~ /Esters/) {
        $line =~ s/Esters/\\hline \\parbox[t]{2mm}{\\multirow{6}{*}{\\rotatebox[origin=c]{90}{Esters}}}/;
    } elsif ($line =~ /^Terpenes/) {
        $line =~ s/Terpenes/\\hline \\multirow{3}{*}{Terpenes}/;
    } elsif ($line =~ /^Total/) {
        $line =~ s/Total &/\\hline \\multicolumn{2}{c}{Total}/;
    }
    #hlines between categories
    if ($line =~ /^Propane/) {
        $line =~ s/^/\\hline /;
        $line =~ s/$/ \\hline/;
    } elsif ($line =~ /^Ethene/) {
        $line =~ s/^/\\hline /;
        $line =~ s/$/ \\hline/;
    } elsif ($line =~ /^Ethyne/) {
        $line =~ s/^/\\hline /;
        $line =~ s/$/ \\hline/;
    } elsif ($line =~ /^Toluene/) {
        $line =~ s/^/\\hline /;
        $line =~ s/$/ \\hline/;
    } elsif ($line =~ /^Forma/) {
        $line =~ s/^/\\hline /;
        $line =~ s/$/ \\hline/;
    }
    #remove pagebreaks from certain categories
    if ($line =~ /HEX1ENE|BUT1ENE|MEPROPENE|EBENZ|PBENZ|ETHTOL/) {
        $line =~ s/$/*/;
    }
    print $out "\t", $line, "\n";
}
print $out "\t\\hline \\hline\n";
print $out "\t\\label{t:CB05_NMVOC_allocations}\n";
print $out "\\end{longtable}\n";
close $out;
