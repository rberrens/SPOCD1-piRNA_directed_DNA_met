#!/usr/bin/perl

if (@ARGV < 2){
        print "2 Input files are not specified.\n";
        exit;
}

my $minus_file  = $ARGV[0];
my $plus_file  = $ARGV[1];

open(IN1, $minus_file);

while(<IN1>){chomp;
	     @a=split(/\s+/);
	     $hairetu{$a[0]}=$a[2];
	     $zenbu{$a[0]}=$_;
}

open(IN2, $plus_file);

while(<IN2>){chomp;
	     @b=split(/\s+/);
	     foreach $key (keys %hairetu){
		 $hiki=($hairetu{$key}-$b[2]);
	#	 {
		     print "$zenbu{$key}\t$_\t$hiki\n";
	#	 }
	     }
} 
