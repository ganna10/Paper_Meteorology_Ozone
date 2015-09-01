#! /usr/bin/env perl
# Calculate total NMVOC emissions from each category in Benelux, used in Table
# Verison 0: Jane Coates 1/9/2015

use strict;
use diagnostics;

my $table = "table_NMVOC_emissions.tex";
my %totals;

open my $in, '<:encoding(utf-8)', $table or die $!;
my (@lines) = <$in>;
close $in;

foreach my $line (@lines) {
    next unless ($line =~ /Bel|Net|Lux/);
    my ($country, $snap1, $snap2, $snap34, $snap5, $snap6, $snap71, $snap72, $snap73, $snap74, $snap8, $snap9, $bvoc) = split / & /, $line; 
    $snap1 =~ s/\$(.*?)\$/$1/;
    $snap2 =~ s/\$(.*?)\$/$1/;
    $snap34 =~ s/\$(.*?)\$/$1/;
    $snap5 =~ s/\$(.*?)\$/$1/;
    $snap6 =~ s/\$(.*?)\$/$1/;
    $snap71 =~ s/\$(.*?)\$/$1/;
    $snap72 =~ s/\$(.*?)\$/$1/;
    $snap73 =~ s/\$(.*?)\$/$1/;
    $snap74 =~ s/\$(.*?)\$/$1/;
    $snap8 =~ s/\$(.*?)\$/$1/;
    $snap9 =~ s/\$(.*?)\$/$1/;
    $bvoc =~ s/\$(.*?)\$(.*?)$/$1/;
    $totals{"SNAP1"} += $snap1;
    $totals{"SNAP2"} += $snap2;
    $totals{"SNAP34"} += $snap34;
    $totals{"SNAP5"} += $snap5;
    $totals{"SNAP6"} += $snap6;
    $totals{"SNAP71"} += $snap71;
    $totals{"SNAP72"} += $snap72;
    $totals{"SNAP73"} += $snap73;
    $totals{"SNAP74"} += $snap74;
    $totals{"SNAP8"} += $snap8;
    $totals{"SNAP9"} += $snap9;
    $totals{"BVOC"} += $bvoc;
}

print "Total $_ => $totals{$_}\n" foreach (sort keys %totals);
