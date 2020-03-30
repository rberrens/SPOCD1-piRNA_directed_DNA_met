#!/usr/bin/perl

while(<>){chomp;
	  @a = split(/\s+/, $_);
	  $length = length($a[0]);	  
	  print ">$a[0]:$length:$a[1]\n$a[0]\n";
}


