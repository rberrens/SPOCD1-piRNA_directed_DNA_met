#!/usr/bin/perl
#USAGE: perl pick_retroclass_family.pl list_LINE_SINE_LTR.txt {sample}_teRNA.sam > {sample}_teRNA_family.txt
#pick TE family and class from list_LINE_SINE_LTR.txt


if (@ARGV < 2){
    print "2 Input file are not specified.\n";
    exit;
}

my $list  = $ARGV[0];
my $retro_hit  = $ARGV[1];

open(INF1, $list) or die("$list open error :$!");

while(<INF1>){chomp;
             @array=split(/\s+/, $_);
             $list{$array[0]} = $_;
             #$sequence{$array[0]} = $array[9];
         }

open(INF2, $retro_hit) or die("$retro_hit open error :$!");

while(<INF2>){chomp;
             @b=split(/\s+/, $_);
             @c=split(/mm10_rmsk_/, $b[2]);
	     foreach $key (keys %list){
		 if($c[1] eq $key){
		     print"@b\t$list{$key}\n";
		 }
	     }
	 }


