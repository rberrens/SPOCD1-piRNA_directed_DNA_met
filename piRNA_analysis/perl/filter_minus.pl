#!/usr/bin/perl

while(<>){chomp;
	  @a = split(/\s+/, $_);
	  @b = split(/:/, $a[0]);
	  $position = $b[1] + $a[3];
	  if($a[1] eq "-"){
	      print "$a[0]\tminus\t$position\n";
	  }
          }
