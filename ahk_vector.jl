using Polymake
using Oscar
using DataFrames

E=[1:6...]
C = [[1, 2, 3],[1, 2, 4],[1, 3, 4],[1, 5, 6],[2, 3, 4],[2, 3, 5, 6],[2, 4, 5, 6],[3, 4, 5, 6]]
M = matroid_from_circuits(C,E)
#Functions to calculate the vector of differencens

function log_distance(v::Vector)
    return [ i==1 || i==length(v) ? x^2 : x^2-v[i-1]*v[i+1] for (i,x) in enumerate(v)]
end

function AHK_vector(M::Matroid)
    v=Int.([coefficients(characteristic_polynomial(M))...])
    return log_distance(v)
end

function reduced_AHK_vector(M::Matroid)
    v=Int.([coefficients(reduced_characteristic_polynomial(M))...])
    return log_distance(v)
end

#Example to follow
Ms = [M,fano_matroid()]

AHK_vector.(Ms)
maximum.(AHK_vector.(Ms))
argmax.(AHK_vector.(Ms))
flats.(Ms)


#Count the amount of flats->specific rank
flat_ranks(Mat)=map(f->rank(Mat,f),flats(Mat))
n_flats_by_rank(Mat)=map(j->count(x->(x==j),flat_ranks(Mat)),1:rank(Mat,matroid_groundset(Mat)))
n_flats_by_rank.(Ms)


min.([1,3],[2,2])

minimum.(AHK_vector.(Ms)) 
reduce(min,AHK_vector.(Ms))
reduce(max,AHK_vector.(Ms))

##Calculate Info
function info(M)
    ahk=AHK_vector(M)
    return [n_flats_by_rank(M),ahk,maximum(ahk)]
end
info(M)

infos(Mats) = (info.(Mats),reduce(min,AHK_vector.(Mats)),reduce(max,AHK_vector.(Mats)))
I=info.(Ms)


function infodf(Mats)
    df=DataFrame(flatsByRank=[],ahk=[],maxOfAhk=[])
    foreach(x->push!(df,x),info.(Mats))
    return df
end

infodf(Ms)


# Get Matroid Datatset from Polydb()
db = Polymake.Polydb.get_db()
collection = db["Matroids.Small"]

#query =  Dict("PAVING" => true,"N_CIRCUITS" => Dict("\$lt" => 10))
#res=Polymake.Polydb.find(collection,  query; opts=Dict("limit"=>10))
#get_Info(res)



cursor=Polymake.Polydb.find(collection, Dict("RANK" => 4,"SIMPLE"=>true,"N_ELEMENTS"=>9); opts=Dict("limit"=>100))
Droids=Matroid.(cursor)

infodf(Droids)

#min at every element


mincoeffs=reduce(min,AHK_vector.(Droids))
maxcoeffs=reduce(max,AHK_vector.(Droids))

min_i=map(i->findfirst(M->mincoeffs[i]==AHK_vector(M)[i],Droids),1:4)
max_i=map(i->findfirst(M->maxcoeffs[i]==AHK_vector(M)[i],Droids),1:4)



minMatroid=Droids[61]
info(minMatroid)

maxMatroid=Droids[87]
info(maxMatroid)



Polymake.Polydb.get_fields(collection)
##Function wrapper
function getMinMaxMatroid(eles=9,r=4,n=100)
    cursor=Polymake.Polydb.find(collection, Dict("RANK" => r,"SIMPLE"=>true,"N_ELEMENTS"=>eles); opts=Dict("limit"=>n))
    Droids=Matroid.(cursor)
    println(length(Droids))
    mincoeffs=reduce(min,AHK_vector.(Droids))
    maxcoeffs=reduce(max,AHK_vector.(Droids))
    println("max/min Coefficients:",maxcoeffs,mincoeffs)


    min_i=map(i->findfirst(M->mincoeffs[i]==AHK_vector(M)[i],Droids),1:r)
    max_i=map(i->findfirst(M->maxcoeffs[i]==AHK_vector(M)[i],Droids),1:r)

    println("Indices of min/max Matroid",min_i,max_i)

    minMatroid=Droids[min_i[1]]
    println("info minMatroid:",info(minMatroid))

    maxMatroid=Droids[max_i[1]]
    println("info maxMatroid:",info(maxMatroid))
    return (maxMatroid,minMatroid)
end


getMinMaxMatroid(9,4,10000)





