#! /usr/bin/env perl
# Extract VOC emission data from country file, country name is ARGV, and transform into LaTeX table
# Version 0: Jane Coates 1/9/2015

use strict;
use diagnostics;

my $country = $ARGV[0];
die "No country specified : $!" unless (defined $ARGV[0]);

my $csv_file = "${country}_MCM_Total_NMVOC_Emissions.csv";
open my $in, '<:encoding(utf-8)', $csv_file or die $!;
my (@lines) = <$in>;
close $in;

my $out_file = "${country}_MCM_emissions.tex";
open my $out, '>:encoding(utf-8)', $out_file or die $!;
print $out "\\tiny\n";
print $out "\\begin{longtable}{lllllllllllllll}\n";
print $out "\t\\caption{$country AVOC and BVOC emissions, in molecules~cm\$^{-2}\$~s\$^{-1}\$, mapped to MCMv3.2 species.}\\\\%\n";
print $out "\t\\hline \\hline\n";
foreach my $line (@lines) {
    chomp $line;
    if ($line =~ /^Type/) {
        $line =~ s/\s+$//;
        $line =~ s/\.Emissions//g;
        my @items = split /,/, $line;
         foreach (@items) {
             $_ = "\\textbf{${_}}";
         }
         $line = join ',', @items;
         $line .= "\\\\\n\t\\endhead\n\t\\hline";
         $line =~ s/,/ & /g;
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
        $line =~ s/Hexane\.and\.Higher\.Alkanes/\\hline \\parbox[t]{2mm}{\\multirow{14}{*}{\\rotatebox[origin=c]{90}{Hexane and Higher Alkanes}}}/;
    } elsif ($line =~ /^Higher\.Alkenes/) {
        $line =~ s/Higher\.Alkenes/\\hline \\parbox[t]{2mm}{\\multirow{11}{*}{\\rotatebox[origin=c]{90}{Higher Alkenes}}}/;
    } elsif ($line =~ /^Xylenes/) {
        $line =~ s/Xylenes/\\multirow{3}{*}{Xylenes}/;
    } elsif ($line =~ /^Trimethylbenzenes/) {
        $line =~ s/Trimethylbenzenes/\\hline \\multirow{3}{*}{Trimethylbenzenes}/;
    } elsif ($line =~ /^Other\.Aromatics/) {
        $line =~ s/Other\.Aromatics/\\hline \\parbox[t]{2mm}{\\multirow{11}{*}{\\rotatebox[origin=c]{90}{Other Aromatics}}}/;
    } elsif ($line =~ /^Other\.Aldehydes/) {
        $line =~ s/Other\.Aldehydes/\\parbox[t]{2mm}{\\multirow{9}{*}{\\rotatebox[origin=c]{90}{Other Aldehydes}}}/;
    } elsif ($line =~ /^Alkadienes/) {
        $line =~ s/Alkadienes\.and\.Other\.Alkynes/\\hline Alkadienes and/;
    } elsif ($line =~ /C5H8/) {
        $line =~ s/^/Other Alkynes/;
    } elsif ($line =~ /Organic\.Acids/) {
        $line =~ s/Organic\.Acids/\\hline \\multirow{4}{*}{Organic Acids}/;
    } elsif ($line =~ /Alcohols/) {
        $line =~ s/Alcohols/\\hline \\parbox[t]{2mm}{\\multirow{19}{*}{\\rotatebox[origin=c]{90}{Alcohols}}}/;
    } elsif ($line =~ /Ketones/) {
        $line =~ s/Ketones/\\hline \\parbox[t]{2mm}{\\multirow{10}{*}{\\rotatebox[origin=c]{90}{Ketones}}}/;
    } elsif ($line =~ /Ethers/) {
        $line =~ s/Ethers/\\hline \\parbox[t]{2mm}{\\multirow{10}{*}{\\rotatebox[origin=c]{90}{Ethers}}}/;
    } elsif ($line =~ /Chlorinated\.Hydrocarbons/) {
        $line =~ s/Chlorinated\.Hydrocarbons/\\hline \\parbox[t]{2mm}{\\multirow{12}{*}{\\rotatebox[origin=c]{90}{Chlorinated Hydrocarbons}}}/;
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
    if ($line =~ /CH3OH|C2H5OH|NPROPOL|IPROPOL|CH3OCH3/) {
        $line =~ s/$/*/;
    }
    print $out "\t", $line, "\n";
}
print $out "\t\\hline \\hline\n";
print $out "\t\\label{t:${country}_MCM_emissions}\n";
print $out "\\end{longtable}";
close $out;
