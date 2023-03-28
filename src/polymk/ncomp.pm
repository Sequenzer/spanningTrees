application "matroid";


$M=new Matroid(BASES=>[[0,1],[0,2],[0,3],[1,2],[1,3]],N_ELEMENTS=>4);

svg($M->LATTICE_OF_FLATS->VISUAL);


$P= $M->POLYTOPE;
help

$fan = tropical::matroid_fan<Min>(matroid::fano_matroid);


application "polytope";
$P1 = cube(2);
$Points = $P1->VERTICES;
$P1new = new Polytope(POINTS=> $Points | new Vector<Rational>(1,1,1,1));
$P1new->VERTICES;
$P1new->VISUAL;

$P2 = cube(2);
$Points2 = $P2->VERTICES;
$P2new = new Polytope(POINTS=> ( new Vector<Rational>(1,1,1,1) | $Points2));
$P2new->VERTICES;
$P2new->VISUAL;

print $P2new->VERTICES->cols;
for my $i (1..$P2new->VERTICES->cols){
    print("hello there","\n")
};

(minkowski_sum($P1new,$P2new))->VISUAL;
$c = new fan::PolyhedralComplex(POINTS=>[[1,1,1,0],[1,1,1,1],[1,1,0,0],[1,1,0,1],[1,0,1,1],[1,0,1,0]],INPUT_POLYTOPES=>[[0,1,2,3],[0,1,4,5]]);
$c->VISUAL;

#Figuring out Perl
@numbers = (1..5);
print "@numbers\n";
#What does it do?
use strict ;
use warnings;

print grep { $_ > 4} @numbers;
print map { $_ * 2 } @numbers;

@names = qw(Horst Peter Günther);
print "@names\n";

reduce { $a + $b } @numbers;

use List::Util qw(sum);
@numbers = (1..5);
print sum(@numbers);


sub greet {
     print "Hello there\n";
};

sub dotwice {
    my ($code) = @_;
    $code->();
    $code->();
};


dotwice(\&greet);

