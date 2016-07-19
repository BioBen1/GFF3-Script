#!perl
use warnings;
use utf8;

open ( $INPUT, "<", "TEST.gff3")
	or die "Can't open < TEST.gff3: $!";

open ( $OUTPUT, ">", "output.txt")
	or die "Can't open > output.txt: $!";	

$n = 0;

while ( $line = <$INPUT> ){
	$n++;
	if ($n == 1){
		# Just print header line"
		print { $OUTPUT } "$line";
	} else {
		# Parse the next GFF3 lines as tab separated
		@L = split(/\t/, $line );
		# Should print anything that was before the changes as the same bp location
		if ($L[4] < 85473 ){
			print { $OUTPUT } $line;
		}
	}
}

close $INPUT;

close $OUTPUT;

