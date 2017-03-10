function getctnf(netfile, outfile)
    a = readdlm(netfile, Int)
    m = Dict{Int,Int}()
    g = Graph()
    fout = open(outfile, "w")
    if size(a,2) < 3
        for i=1:size(a,1)
            x=copy(m)
            lpa_addedge!(g, m, a[i,1], a[i,2])
            println(fout, '#', i)
            println(fout, "+\t", a[i,1], '\t', a[i,2])
            commdiff(x, m, fout)
        end
    else
        for i=1:size(a,1)
            x=copy(m)
            println(fout, '#', i)
            if a[i,1] > 0
                lpa_addedge!(g, m, a[i,2], a[i,3])
                println(fout, "+\t", a[i,2], '\t', a[i,3])
            else
                lpa_deleteedge!(g, m, a[i,2], a[i,3])
                println(fout, "-\t", a[i,2], '\t', a[i,3])
            end
            commdiff(x, m, fout)
        end
    end
    close(fout)
    convertfile(outfile, "converted_$(outfile)")
end

function commdiff(m1, m2, fout)
    x = Dict{Int,Set{Int}}()
    y = Dict{Int,Set{Int}}()
    for (k,v) in m1
        if haskey(x,v)
            push!(x[v], k)
        else
            x[v]=Set(k)
        end
    end
    for (k,v) in m2
        if haskey(y,v)
            push!(y[v],k)
        else
            y[v]=Set(k)
        end
    end
    died_comms = setdiff(keys(x),keys(y))
    new_comms = setdiff(keys(y),keys(x))
    con_comms = intersect(keys(x),keys(y))
    for c in died_comms
        for u in x[c]
            println(fout, "-nc\t", u, '\t', c)
        end
        println(fout, "-c\t", c)
    end
    for c in new_comms
        println(fout, "+c\t", c)
        for u in y[c]
            println(fout, "+nc\t", u, '\t', c)
        end
    end
    for c in con_comms
        new_nodes = setdiff(y[c], x[c])
        for u in new_nodes
            println(fout, "+nc\t", u, '\t', c)
        end
        del_nodes = setdiff(x[c],y[c])
        for u in del_nodes
            println(fout, "-nc\t", u, '\t', c)
        end
    end
end

function convertfile(filein, fileout)
    fin = open(filein, "r")
    fout = open(fileout, "w")
    i = 0
    nmap = Dict{Int,Int}()
    for l in eachline(fin)
        items = split(chop(l))
        if items[1]=="+c"
            i+=1
            nmap[parse(Int,items[2])]=i
            println(fout, items[1], '\t', i)
        end
        if items[1]=="+nc" || items[1]=="-nc"
            println(fout, items[1],'\t', items[2],'\t', nmap[parse(Int,items[3])])
        end
        if items[1]=="-c"
            println(fout, items[1],'\t', nmap[parse(Int,items[2])])
        end
        if items[1]=="+" || items[1]=="-" || items[1][1]=='#'
            print(fout, l)
        end
    end
    close(fout)
    close(fin)
end
