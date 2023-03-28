using Oscar
using Polymake

#The Oscar Way
U= uniform_matroid(3,4)
#The Polymake way
F = tropical.matroid_fan{min}(matroid.uniform_matroid(3,4))
M=Polymake.common.unit_matrix(5)

C=common.dense(F.MAXIMAL_CONES)
F.MAXIMAL_CONES[




cFromFan= tropical.affine_chart(F,1)
visualize(PolyhedralComplex(cFromFan))


Polymake.fan.intersection(cFromFan,M)




pc = PolyhedralComplex{fmpq}(F)

visualize(pc)



nfc= normal_fan(cube(3))

visualize(nfc)


test = PolyhedralFan(Polymake.fan.normal_fan(polytope.simplex(3)))
