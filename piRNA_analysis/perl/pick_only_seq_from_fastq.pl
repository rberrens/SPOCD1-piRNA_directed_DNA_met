#!/usr/bin/perl

while(<>){chomp;
	  $q ++;
	  $a = $q%4;
	      if ($a == 2){
		  print"$_\n";
	      }
      }
