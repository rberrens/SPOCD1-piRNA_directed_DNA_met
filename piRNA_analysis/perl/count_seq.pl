#!/usr/bin/perl

while(<>){chomp;
	  @a = split (/\s+/, $_);
	  $count{$a[0]} += 1;
      }

foreach $key (sort {$a cmp $b} keys %count){
    print"$key\t$count{$key}\n";
}
