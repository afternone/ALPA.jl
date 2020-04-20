# Adaptive Label Propagation Algorithm (ALPA)
## Install
1. Install Julia and open Julia REPL.
2. Input below command to install ALPA package.
```julia
] add https://github.com/afternone/ALPA.jl.git
```
## Usage
### non-interactive mode
1. Prepare a dynamic network file `tiny_dyn_net.txt` with each line represents a graph event as follows:
```
+ 1 # add new node "1"
+ 2 # add new node "2"
+ 1 2 # add a new edge between nodes "1" and "2"
+ 2 3
+ 3 1
+ 1 4
+ 4 5
+ 5 6
+ 6 4
+ 2 5
+ 3 6
- 2 5 # delete the edge between nodes "2" and "5"
- 3 6
- 1 # delete the node "1"
```
2. Change to the `src` directory and open terminal from there, and then using the following command to run ALPA on the dynamic network file.
```
julia main.jl tiny_dyn_net.txt
```
3. In the same directory of `tiny_dyn_net.txt`, you will get the output community file `tiny_dyn_net.comm`.

### interactive mode
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
