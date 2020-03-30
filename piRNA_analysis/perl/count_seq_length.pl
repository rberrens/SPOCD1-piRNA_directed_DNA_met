#!/usr/bin/perl

while(<>){chomp;
	  @a = split(/\s+/, $_);
	  $length = length($a[0]);	  
	  print "$a[0]\t$length\t$a[1]\n";
}


