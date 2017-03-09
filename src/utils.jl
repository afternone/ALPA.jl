function graphdiff(g1::Graph, g2::Graph)
    new_edges = Set{Pair{Int,Int}}()
    for u in nodes(g1)
        for v in neighbors(g1,u)
            if u<=v
                push!(new_edges, Pair(u,v))
            end
        end
    end
    for u in nodes(g2)
        for v in neighbors(g2,u)
            if u<=v
                delete!(new_edges, Pair(u,v))
            end
        end
    end
    new_edges
end

function graphdiff(graph1, graph2)
    edges_g1 = readdlm(graph1, Int)
    edges_g2 = readdlm(graph2, Int)
    new_edges = Set{Pair{Int,Int}}()
    for i=1:size(edges_g1, 1)
        u = edges_g1[i,1]
        v = edges_g1[i,2]
        if u>v
            u,v = v,u
        end
        push!(new_edges, Pair(u,v))
    end
    for i=1:size(edges_g2, 1)
        u = edges_g2[i,1]
        v = edges_g2[i,2]
        if u>v
            u,v = v,u
        end
        delete!(new_edges, Pair(u,v))
    end
    new_edges
end

function modularity(g, c)
    labels = unique(c)
    length(labels) == 1 && return 0.0
    m = ne(g)
    e = Dict{Int,Int}()
    a = Dict{Int,Int}()
    for u in nodes(g)
        for v in neighbors(g,u)
            if u<v
                c1 = c[u]
                c2 = c[v]
                if c1 == c2
                    e[c1] = get(e,c1,0) + 2
                end
                a[c1] = get(a,c1,0) + 1
                a[c2] = get(a,c2,0) + 1
            end
        end
    end
    modularity_value = 0.0
    if m > 0
        for i in labels
            if i > 0
                tmp = haskey(a,i) ? a[i]/2/m : 0
                modularity_value += haskey(e,i) ? e[i]/2/m : 0
                modularity_value -= tmp*tmp
            end
        end
    end
    modularity_value
end
