#! /usr/bin/env perl
# Convert regression output to latex table
# Version 0: Jane Coates 27/10/2015

use strict;
use diagnostics;

my $stat_file = "/local/home/coates/Documents/Analysis/2015_Meteorology_and_Ozone/T_Dep_Indep_Comparisons/Regressions_statistics_Mean_O3_T_NOx.txt";

my $out_file = "table_regression_O3_T_stats.tex";
open my $out, '>:encoding(utf-8)', $out_file or die $!;
print $out "{\\renewcommand{\\arraystretch}{1.2}\n";
print $out "\\begin{tabular}{c|c|c|c|c|c}\n";
print $out "\t\\hline\\hline\n";
print $out "\t\\multirow{3}{*}{\\textbf{Mechanism}} & \\multirow{2}{*}{\\textbf{NOx}} & \\multicolumn{2}{c|}{\\textbf{Temperature Dependent}} & \\multicolumn{2}{c}{\\textbf{Temperature Independent}} \\\\ \n";
print $out "\t & & \\multicolumn{2}{c|}{\\textbf{Isoprene Emissions}} &  \\multicolumn{2}{c}{\\textbf{Isoprene Emissions}} \\\\ \\cline{3-6} \n";
print $out "\t & \\textbf{Condition} & \\textbf{Slope (m\$_{\\text{O3-T}}\$)} & \\textbf{R\$^2\$} & \\textbf{Slope (m\$_{\\text{O3-T}}\$)} & \\textbf{R\$^2\$} \\\\ \n";
print $out "\t\\hline\\hline\n";

open my $in, '<:encoding(utf-8)', $stat_file or die $!;
my @lines = <$in>;
close $in;
my %data;
foreach my $line (@lines) {
    next if ($line =~ /^Mech/);
    chomp $line;
    my ($mechanism, $run, $NOx, $slope, $r2) = split /,/, $line;
    $data{$mechanism}{$NOx}{$run}{"Slope"} = sprintf "%.1f", $slope;
    $data{$mechanism}{$NOx}{$run}{"R2"} = sprintf "%.2f", $r2;
}

foreach my $mechanism (sort keys %data) {
    print $out "\t\\multirow{3}{*}{$mechanism} & Low-NOx & $data{$mechanism}{'Low-NOx'}{'Temperature Dependent'}{'Slope'} & $data{$mechanism}{'Low-NOx'}{'Temperature Dependent'}{'R2'} & $data{$mechanism}{'Low-NOx'}{'Temperature Independent'}{'Slope'} & $data{$mechanism}{'Low-NOx'}{'Temperature Independent'}{'R2'} \\\\ \n";
    print $out "\t & Maximal-O3 & $data{$mechanism}{'Maximal-O3'}{'Temperature Dependent'}{'Slope'} & $data{$mechanism}{'Maximal-O3'}{'Temperature Dependent'}{'R2'} & $data{$mechanism}{'Maximal-O3'}{'Temperature Independent'}{'Slope'} & $data{$mechanism}{'Maximal-O3'}{'Temperature Independent'}{'R2'} \\\\ \n";
    print $out "\t & High-NOx & $data{$mechanism}{'High-NOx'}{'Temperature Dependent'}{'Slope'} & $data{$mechanism}{'High-NOx'}{'Temperature Dependent'}{'R2'} & $data{$mechanism}{'High-NOx'}{'Temperature Independent'}{'Slope'} & $data{$mechanism}{'High-NOx'}{'Temperature Independent'}{'R2'} \\\\ \n";
    print $out "\t\\hline\n";
}

print $out "\t\\hline\\hline\n";
print $out "\\end{tabular}";
print $out "}\n";
close $out;
