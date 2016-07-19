#!perl
use warnings;
use utf8;

open ( $INPUT, "<", "TEST.gff3")
	or die "Can't open < TEST.gff3: $!";

open ( $OUTPUT, ">", "output.txt")
	or die "Can't open > output.txt: $!";

open ( $PROBLEM, ">", "problem.txt")
	or die "Can't open > problem.txt: $!";	

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
		} else {
			# Test if the feature was in the region where new sequence was added. (Not sure I should keep using else each time, maybe could use another if?)
			if ( ( 85473 <= $L[3] && $L[3] <= 107422 ) || ( 85473 <= $L[4] && $L[4] <= 107422 ) ){
				print {$PROBLEM} $line;
			}
		}
	}
}

close $INPUT;

close $OUTPUT;

close $PROBLEM;
