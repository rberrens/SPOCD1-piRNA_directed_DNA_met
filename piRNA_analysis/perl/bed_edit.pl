#!/usr/bin/perl

while(<>){chomp;
	  @a=split(/\s+/, $_);
	  $length=$a[2]-$a[1];
	  print "$a[0]\t$a[1]\t$a[2]\t$a[3]\t$length\t$a[5]\n";
      }
