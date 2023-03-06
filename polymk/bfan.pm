application "matroid";

$m=uniform_matroid(2,3);
$l=$m->LATTICE_OF_FLATS;

##Compute all the non trivial Faces
@s = $l->FACES;
print new Set(1..$m->N_ELEMENTS);

foreach my $flat (@{$s[0]}) {
    if ($flat == new Set()||$flat == new Set(0..$m->N_ELEMENTS-1)){
        print "A trivial flat is: ", $flat,"\n";
    } else {
        print "A true flat is: ", $flat, "\n";
    } 
};

print $l->FACES->

@x = (1..12);
shift @x; pop @x;
print @x;



$f=tropical::matroid_fan<Min>($m);
$f->VISUAL;
ref($f);
@mat = $f->PROJECTIVE_VERTICES;
print $mat[0][0]; ##top row
print $mat[0][0][0]; ##top left element
print transpose(@mat)[0][0]; ##left most column

#Alternative
$mat1 = $f->PROJECTIVE_VERTICES;
print $mat1->elem(1,1); ##second row second column

print ref($mat[0][0]);
print $mat[0];
#Define e_0
$e0 = 0;
$F_e0 = new Set(0); 
##Calculate inner Product
$v1=$f->PROJECTIVE_VERTICES->col(1); #Flat number 0
$v2=$f->PROJECTIVE_VERTICES->col(2); #Flat number 1
print $v1 ;

sub innerProduct { 
    my $u_1 = $_[0]; #Should be column number 
    my $u_2 = $_[1]; #Should be column number 
    my $e_0 = $_[2]; #Should be element of ground Set 
    my $E_0 = new Set($e_0); #The selected "pivot" Element 
    my $groundSet = new Set(0..$m->N_ELEMENTS-1); #groundset of the matroid
    my @flatArray = $m->LATTICE_OF_FLATS->FACES; #Array of flats for sroting reasons 
    my $F_1 = $flatArray[0][$u_1]; #Flat corresponding to $u_1
    my $F_2 = $flatArray[0][$u_2]; #Flat corresponding to $u_2
    print "Flat_1 is:", $F_1,"\n";
    print "Flat_2 is:", $F_2,"\n";
    if ($F_1 ->contains($e_0)){
        if ($F_2->contains($e_0)){
            print ($groundSet-($F_1^$F_2),"\n");
            return (($groundSet-($F_1^$F_2))->size);
        } else {
            print ($F_1*($groundSet-$F_2),"\n");
            return -(($F_1*($groundSet-$F_2))->size);
        }
    } else {
        if ($F_2->contains($e_0)){
            print ($F_2*($groundSet-$F_1),"\n");
            return -(($F_2*($groundSet-$F_1))->size);
        } else {
            print $F_1*$F_2,"\n";
            return (($F_1*$F_2)->size);
        }
    }
}


sub zedd_alpha {
    my $u_1 = $_[0];
    my $e_0 = $_[1];
    my @flatArray = $m->LATTICE_OF_FLATS->FACES; #Array of flats for sroting reasons 
    my $F_1 = $flatArray[0][$u_1]; #Flat corresponding to $u_1
    return $F_1->contains($e_0);
}

print zedd_alpha(1,0); #Since 0 is in the first flat {0} this should be 1
print zedd_alpha(4,0); # Since 0 is in the groundset {0,1,2} this should be 1
print zedd_alpha(2,0); #Since 0 is not in the second flat {1} this should be 0


sub zedd_beta {
    my $u_1 = $_[0];
    my $e_0 = $_[1];
    my @flatArray = $m->LATTICE_OF_FLATS->FACES; #Array of flats for sroting reasons 
    my $F_1 = $flatArray[0][$u_1]; #Flat corresponding to $u_1
    return !($F_1->contains($e_0));
}

print zedd_beta(1,0); #Since 0 is in the first flat {0} this should be 0
print zedd_beta(4,0); # Since 0 is in the groundset {0,1,2} this should be 0
print zedd_beta(2,0); #Since 0 is not in the second flat {1} this should be 1

sub w {
    my $sigma = $_[0]; ##The cone your calculating w for
    my $flag = $_[1]; ##The cone coresponding to $sigma
}



print $m->LATTICE_OF_FLATS->FACES;
print innerProduct(1,2,1);
print new Set(1,2) * new Set(2,3);
print ((new Set(1,2) * new Set(2,3))->size) ;


print (new Set(1,2)->contains(1));


$$$$
