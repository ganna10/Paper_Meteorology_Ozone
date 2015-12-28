#! /usr/bin/env perl
# Create LaTeX tables for each country
# Version 0: Jane Coates 28/12/2015

use strict;
use diagnostics;

my $file = "Benelux_CB05_Total_NMVOC_Emissions.csv";
my %emissions;

open my $in, '<:encoding(utf-8)', $file or die "Can't open $file for reading : $!";
my @lines = <$in>;
close $in;

my $out_file = "table_CB05_NMVOC_emissions.tex";
open my $out, '>:encoding(utf-8)', $out_file or die $!;

print $out "\\footnotesize\n";
print $out "\\begin{table}\n";
print $out "\\centering\n";
print $out "\t\\caption{Benelux emissions of AVOC and BVOC species in CB05. Emissions are in molecules~cm\$^{-2}\$~s\$^{-1}\$ and determined by multiplying the MCMv3.2 emissions from Tables~\\ref{t:Belgium_MCM_emissions}--\\ref{t:Luxembourg_MCM_emissions} by the allocated number of CB05 species from Table~\\ref{t:CB05_NMVOC_allocations}.}%\n";
print $out "\\begin{tabular}{lllll}\n";
print $out "\t\\hline \\hline\n";
foreach my $line (@lines) {
    chomp $line;
    if ($line =~ /^CB05/) {
        $line = "\\textbf{CB05 Species} & \\textbf{Belgium} & \\textbf{Luxembourg} & \\textbf{Netherlands} & \\textbf{Total} \\\\\n";
        print $out "\t", $line, "\n";
        print $out "\t\\hline\n";
        next;
    }
    $line =~ s/,/ & /g;
    $line =~ s/(\s+)?$/ \\\\/;
    if ($line =~ /Total/) {
        $line =~ s/^/\\hline /;
    }
    print $out "\t", $line, "\n";
}

print $out "\t\\hline \\hline\n";
print $out "\\end{tabular}\n";
print $out "\\label{t:CB05_NMVOC_emissions}\n";
print $out "\\end{table}";
close $out;
