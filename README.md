# Adaptive Label Propagation Algorithm (ALPA)
## Install
```julia
Pkg.clone("https://github.com/afternone/ALPA.jl.git")
```
## Usage
```julia
julia> using ALPA
julia> m = Dict{Int,Int}() # initialize nodes' membership
julia> g = Graph() # start with an empty graph
julia> lpa_addedge!(g, m, 1, 2) # add edge (1,2) and update partition
julia> lpa_addedge!(g, m, 2, 3)
julia> lpa_addedge!(g, m, 3, 1)
julia> lpa_addedge!(g, m, 1, 4)
julia> lpa_addedge!(g, m, 4, 5)
julia> lpa_addedge!(g, m, 5, 6)
julia> lpa_addedge!(g, m, 6, 4)

julia> m
Dict{Int64,Int64} with 6 entries:
  4 => 5
  2 => 1
  3 => 1
  5 => 5
  6 => 5
  1 => 1

julia> lpa_addedge!(g, m, 2, 5)
julia> m
Dict{Int64,Int64} with 6 entries:
  4 => 1
  2 => 1
  3 => 1
  5 => 1
  6 => 1
  1 => 1

julia> lpa_deleteedge!(g, m, 2, 5)
julia> m
Dict{Int64,Int64} with 6 entries:
  4 => 3
  2 => 2
  3 => 2
  5 => 3
  6 => 3
  1 => 2

```
