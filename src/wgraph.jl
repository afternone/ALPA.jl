Graph = Dict{Int,Dict{Int,Int}}

neighbors(g::Graph, u::Int) = keys(g[u])

nodes(g::Graph) = keys(g)

hasnode(g::Graph, u::Int) = haskey(g, u)

hasedge(g::Graph, u::Int, v::Int) = hasnode(g, u) && haskey(g[u], v)

function ne(g::Graph)
    m = 0
    for u in keys(g)
        m += length(g[u])
    end
    return div(m, 2)
end

function addnode!(g::Graph, u::Int)
    if !haskey(g, u)
        g[u] = valtype(g)()
    end
    nothing
end

function delnode!(g::Graph, u::Int)
    if haskey(g, u)
        for v in keys(g[u])
            deledge!(g, u, v)
        end
        delete!(g, u)
    end
    nothing
end

function addedge!(g::Graph, u::Int, v::Int)
    if !hasedge(g, u, v)
        addnode!(g, u)
        addnode!(g, v)
        cnt = 1
        for i in keys(g[u])
            if haskey(g[v], i)
                cnt += 1
                g[u][i] += 1
                g[i][u] += 1
                g[v][i] += 1
                g[i][v] += 1
            end
        end
        g[u][v] = cnt
        g[v][u] = cnt
    end
    nothing
end

function deledge!(g::Graph, u::Int, v::Int)
    if haskey(g, u) && haskey(g, v)
        delete!(g[u], v)
        delete!(g[v], u)
        for i in keys(g[u])
            if haskey(g[v], i)
                g[u][i] -= 1
                g[i][u] -= 1
                g[v][i] -= 1
                g[i][v] -= 1
            end
        end
    end
    nothing
end
