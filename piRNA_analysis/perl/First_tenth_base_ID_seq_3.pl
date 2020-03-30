#!/usr/bin/perl

while(<>){chomp;
	  @array=split(/\s+/, $_);
	      $first=substr($array[0], 0, 1); 
	      $tenth=substr($array[0], 9, 1);
	      $base_f{$first} += $array[2];
	      $base_t{$tenth} += $array[2];
}

foreach $key (sort{$a<=>$b} keys %base_f){
	print "First\t$key\t$base_f{$key}\n";}
	
foreach $key2 (sort{$a<=>$b} keys %base_t){
	print "Tenth\t$key2\t$base_t{$key2}\n";
	}

