#!perl
use warnings;
use utf8;

# Currently the GFF3 must have no spaces between each line.

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
			print { $OUTPUT } "$line";
		} else {
			# Test if the feature was in the region where new sequence was added. (Not sure I should keep using else each time, maybe could use another if?)
			if ( ( 85473 <= $L[3] && $L[3] <= 107422 ) || ( 85473 <= $L[4] && $L[4] <= 107422 ) ){
				print {$PROBLEM} "$line";
			} else {
				#Anything that was 107423 bp or beyond is fine but needs to have 9907 added to the start[3] and stop[4] for the position to be correct
				if ( $L[3] >= 107423 ){
					$L[3] += 9907;
					$L[4] += 9907;
					#Need to figure out how to print this out as tab separated again, currently only separated by a space
					local $" = "\t";
					#This should set it to print a tab between each element.
					print {$OUTPUT} "@L";
				}
			}
		}
	}
}

close $INPUT;

close $OUTPUT;

close $PROBLEM;
