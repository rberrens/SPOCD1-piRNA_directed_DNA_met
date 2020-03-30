#!/usr/bin/perl

while(<>){chomp;
	  @a = split(/\s+/, $_);
	  print ">$a[0]:$a[1]:$a[2]\n$a[0]\n";
}


