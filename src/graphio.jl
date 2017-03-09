using ParserCombinator: Parsers.GML

function _gml_read_one_graph(gs)
    nodes = [x[:id] for x in gs[:node]]
    g = Graph()
    sds = [(Int(x[:source]), Int(x[:target])) for x in gs[:edge]]
    for (s,d) in (sds)
        addedge!(g, s, d)
    end
    return g
end

function loadgml(gname::AbstractString)
    p = GML.parse_dict(readall(gname))
    for gs in p[:graph]
        return _gml_read_one_graph(gs)
    end
    error("Graph $gname not found")
end

function savegml(gname::AbstractString, g, c=Vector{Integer}())
    io = open(gname, "w")
    println(io, "graph")
    println(io, "[")
    println(io, "directed 0")
    i = 0
    nodemap = Dict{Int,Int}()
    for u in keys(g)
        nodemap[u] = i
        println(io,"\tnode")
        println(io,"\t[")
        println(io,"\t\tid $i")
        println(io,"\t\tlabel $u")
        length(c) > 0 && println(io,"\t\tvalue $(c[u])")
        println(io,"\t]")
        i += 1
    end
    for u in keys(g)
        for v in keys(g[u])
            if u < v
                println(io,"\tedge")
                println(io,"\t[")
                println(io,"\t\tsource $(nodemap[u])")
                println(io,"\t\ttarget $(nodemap[v])")
                println(io,"\t]")
            end
        end
    end
    println(io, "]")
    close(io)
    return 1
end
