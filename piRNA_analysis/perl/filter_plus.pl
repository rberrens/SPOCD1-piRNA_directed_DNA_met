#!/usr/bin/perl

while(<>){chomp;
	  @a = split(/\s+/, $_);
	  if($a[1] eq "+"){
	      print "$a[0]\tplus\t$a[3]\n";
	  }
          }
