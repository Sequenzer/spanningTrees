using Oscar
using Plots
using DataFrames
using DataStructures

Droids=load("r4n9_Matroids.bak");
#Connected Components, independent Sets, char poly coefs, ahk-vector.





max_ahk(D)=D[4][2]
bin=max_ahk.(Droids)

length(Droids[1][4])

n=100
testDroids=Droids[1:n]
x1=collect(1:n)
bar(max_ahk.(testDroids),x1)

function n_Matroids_by_max_ahk(Droids)
    sol = [DefaultDict{Int,Int}(0) for _ in Droids[1][4]]
    foreach(Matroid->foreach(i->sol[i][Matroid[4][i]]+=1,eachindex(Matroid[4])),Droids)
    return sol
end


bins=n_Matroids_by_max_ahk(Droids)
bar(bins[3])

#largest normal distribution = Largest bin = 3820
#second largest distribution = 
enumerate(bins)

#local_max=[]
#for i in 2:length(bins)-1
#    if (bins[i-1][2]< bins[i][2])&& (bins[i+1][2]< bins[i][2])
#        push!(local_max,bins[i])
#    end
#end

#specificly look for droids with max_ahk = 819 and 849

even = filter(x->max_ahk(x)==3709,Droids)
odd  = filter(x->max_ahk(x)==3719,Droids)

evenbins=[]
oddbins=[]
for i in 1:length(bins)
    if i % 2 == 0
        push!(evenbins,bins[i])
    else
        push!(oddbins,bins[i])
    end
end

bar([tup[k] for k in 1:2, tup in evenbins])
