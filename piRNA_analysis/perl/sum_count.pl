#!/usr/bin/perl

while(<>){chomp;
	  @a = split(/\s+/, $_);
	  @b = split(/:/, $a[0]);
	  @c = split(/:/, $a[3]);
	  $sum = $b[-1] + $c[-1];
	  print "$_\t$sum\n";
}
