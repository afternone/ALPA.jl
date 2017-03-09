module ALPA
using StatsBase

export addnode!, delnode!, addedge!, deledge!, ne,
    lpa_addnode!, lpa_deletenode!, lpa_addedge!, lpa_deleteedge!, loadgml, savegml, modularity, graphdiff, Graph, NeighComm, NodeStatus
# package code goes here
include("wgraph.jl")
include("wevolve.jl")
include("graphio.jl")
include("utils.jl")
# package code goes here
N = 10000
c = NeighComm(collect(1:N), fill(-1,N), 1)
ns = NodeStatus(collect(1:N), fill(false,N), 1)
random_order = Array(Int,N)
#m = zeros(Int,N)
a = IntSet()

lpa_deletenode!(g, m, u) = lpa_deletenode!(g, m, c, u, a, random_order, ns)

lpa_addedge!(g,m,u,v) = lpa_addedge!(g,m,c,u,v,a,random_order,ns)

lpa_deleteedge!(g,m,u,v) = lpa_deleteedge!(g,m,c,u,v,a,random_order,ns)
end # module
