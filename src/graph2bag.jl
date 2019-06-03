neighbors_bags(g) = ScatteredBags([setdiff(inneighbors(g, i), i) for i in vertices(g)])

graph2bag(verticesnode) = BagNode(verticesnode, [1:nobs(verticesnode)])

function joinve(xv, xe, g)
    @assert size(xe,2) == ne(g)
    
    bags = [Vector{Int}() for i in 1:nv(g)]
    foreach(e -> push!(bags[e.dst], e.src), edges(g))
    o = vcat(matchvertex2edges(xv, edges(g)), xe)
    BagNode(ArrayNode(o), ScatteredBags(bags))
end

function vertices2bag(g, mg, vertex2array)
    vertex_properties = reduce(cat, [ArrayNode(vertex2array(mg, i)) for i in vertices(g)])
    TreeNode((vertex_properties, BagNode(vertex_properties,  neighbors_bags(g))))
end

function vertices2bag(g, mg, vertex2array, edge2array)
    vertex_properties = reduce(hcat, [vertex2array(mg, v) for v in vertices(g)])
    edge_properties = reduce(hcat, [edge2array(mg, e) for e in edges(g)])
    TreeNode(ArrayNode(vertex_properties), joinve(vertex_properties, edge_properties, g))
end

get_vertex_labels(g, mg, get_label) = [get_label(mg, v) for v in vertices(g)]