#!/usr/bin/perl

while(<>){chomp;
	      @a = split (/\s+/, $_);
	      print "$a[0]\t$a[1]\t$a[2]\n"
	      }