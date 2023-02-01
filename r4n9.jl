using Oscar
using Plots
using DataFrames

Droids=load("r4n9_Matroids")

max_ahk(D)=D[4][2]
bin=max_ahk.(Droids)



n=100
testDroids=Droids[1:n]
x1=collect(1:n)
bar(max_ahk.(testDroids),x1)

function n_Matroids_by_max_ahk(Droids)
    count=zeros(maximum(bin))
    foreach(D->count[max_ahk(D)]+=1,Droids)
    return filter(x->x[2]!==0 ,[enumerate(Int.(count))...])
end


n_Matroids_by_max_ahk(Droids)
