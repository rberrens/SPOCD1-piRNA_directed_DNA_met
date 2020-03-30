#!/usr/bin/perl

while(<>){chomp;
	  @a = split(/\s+/, $_);
	  $count{$a[-2]} += $a[-1];
}

foreach $key (sort{$a<=>$b} keys %count){
	print "$key\t$count{$key}\n";
}
