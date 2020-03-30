#!/usr/bin/perl

while(<>){chomp;
	  @a = split(/\s+/, $_);
	  if($a[0] >= 0 and $a[0] <= 30){
	      print"$_\n";
	  }
}
