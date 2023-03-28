
$s=simplex(2);
##Simple 2-dimensional Simplex
$g=$s->GRAPH;

$m=matroid::matroid_from_graph($g);

$gr=$m->AUTOMORPHISM_GROUP;

print $gr->ORDER;
##Should output 6 because the group contains
# { e, r ,r*r, s*r, s*r*r }
# e:= id
# r:= rotation
# s:= spiegelung;


## Michael Variante

$vert=group::automorphism_group(simplex(2)->VERTICES_IN_FACETS);
