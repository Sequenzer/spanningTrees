using Polymake
using Oscar
using DataFrames
using Plots
using CSV

E=[1:6...]
C = [[1, 2, 3],[1, 2, 4],[1, 3, 4],[1, 5, 6],[2, 3, 4],[2, 3, 5, 6],[2, 4, 5, 6],[3, 4, 5, 6]]
M = matroid_from_circuits(C,E)
#Functions to calculate the vector of differencens
cyclic_flats(M,2)
flats(M)



function log_distance(v::Vector)
    return [ i==1 || i==length(v) ? x^2 : x^2-v[i-1]*v[i+1] for (i,x) in enumerate(v)]
end

function AHK_vector(M::Matroid)
    v=Int.([coefficients(characteristic_polynomial(M))...])
    return log_distance(v)
end


AHK_vector(M)


#Example to follow
Ms = [M,fano_matroid()]

AHK_vector.(Ms)
maximum.(AHK_vector.(Ms))
argmax.(AHK_vector.(Ms))
flats.(Ms)


function n_flats_by_rank(Mat)
    rk=zeros(rank(Mat)+1)
    foreach(f->rk[rank(Mat,f)+1]+=1,flats(Mat))
    popfirst!(rk)
    return Int.(rk)
end

n_flats_by_rank(fano_matroid())

##Old Version
##cyclicflat_ranks(Mat)=map(f->rank(Mat,f),cyclic_flats(Mat))
##n_cyclicflats_by_rank(Mat)=map(j->count(x->(x==j),cyclicflat_ranks(Mat)),1:rank(Mat,matroid_groundset(Mat)))
##n_cyclicflats_by_rank.(Ms)


##Calculate Info
function info(Mat)
    coeff=Int.(coefficients(characteristic_polynomial(Mat)))
    return (n_connected_components(Mat),n_flats_by_rank(Mat),coeff,log_distance(coeff))
end
info(M)

I=info.(Ms)


function infodf(Mats)
    df=DataFrame(cyclicflatByranks=[],flatsByRank=[],ahk=[],maxOfAhk=[])
    foreach(x->push!(df,x),info.(Mats))
    return df
end

infodf(Ms)


# Get Matroid Datatset from Polydb()
db = Polymake.Polydb.get_db()
collection = db["Matroids.Small"]


cursor=Polymake.Polydb.find(collection, Dict("RANK" => 4,"SIMPLE"=>true,"N_ELEMENTS"=>9))
Droids=Matroid.(cursor)


#i=0
#Droids=[]
#GC.enable_logging(true)
#for M in cursor
#    push!(Droids,info(Matroid(M))) 
#    if i%1000==0
#        println("I am at ",i)
#        GC.gc()
#    end
#    i+=1
#end


#Droids = map(M->info(Matroid(M)),cursor)
#save("r4n9_Matroids",Droids)
#fournine=infodf(Droids)



length(Droids)

#Lax Matroid, Paper: 
#min at every element
#ToDo fix all ranks except one.
#ToDo is the ahk_vector log concave?

#asd=load("r4n9_Matroids")




##This is broken fix it!!! mincoeffs=reduce(min,AHK_vector.(Droids))
#maxcoeffs=reduce.(max,AHK_vector.(Droids))
#
#min_i=map(i->findfirst(M->mincoeffs[i]==AHK_vector(M)[i],Droids),1:3)
#max_i=map(i->findfirst(M->maxcoeffs[i]==AHK_vector(M)[i],Droids),1:4)
#




#ToDo check out regular and binary, sparce paving, to all!!
#Polymake.Polydb.get_fields(collection)
##Function wrapper


#ToDo Sort teh Droids Array by Size of n-th coefficients
#
##Calculate Deltas of the coefficients How fat do they change? what influences this?
#Is this always the same?
#

function getAhkElement(n)
    return f(Mat) = AHK_vector(Mat)[n]
end

f=getAhkElement(1)
f.(Ms)


#asd= plot(sortArr2,seriestype=:scatter,fmt = :svg)

