include("ALPA.jl")

function main(dynetfile, commfile)
    m = Dict{Int,Int}() # initialize nodes' membership
    g = Main.ALPA.Graph() # start with an empty graph
    fin = open(dynetfile, "r")
    fout = open(commfile, "w")
    for line in eachline(fin)
        items = split(line)
        if length(items) == 3
            if items[1] == "+"
                Main.ALPA.lpa_addedge!(g, m, parse.(Int,items[2:3])...)
            end
            if items[1] == "-"
                Main.ALPA.lpa_deleteedge!(g, m, parse.(Int,items[2:3])...)
            end
        end
        if length(items) == 2
            if items[1] == "+"
                Main.ALPA.lpa_addnode!(g, m, parse(Int,items[2]))
            end
            if items[1] == "-"
                Main.ALPA.lpa_deletenode!(g, m, parse(Int,items[2]))
            end
        end
        for node in keys(m)
            print(fout, node, "=>", m[node], " ")
        end
        print(fout, "\n")
    end
    close(fin)
    close(fout)
end

if length(ARGS) == 1
    dynetfile = ARGS[1]
    commfile = splitext(dynetfile)[1]*".comm"
elseif length(ARGS) == 2
    dynetfile = ARGS[1]
    commfile = ARGS[2]
else
    error("ARGS number error")
end
main(dynetfile, commfile)
