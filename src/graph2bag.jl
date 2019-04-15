neighbors_bags(g) = ScatteredBags([setdiff(neighbors(g, i), i) for i in vertices(g)])

function vertices2bag(g, mg, vertex2array)
    vertex_properties = reduce(cat, [ArrayNode(vertex2array(mg, i)) for i in vertices(g)])
    TreeNode(vertex_properties, BagNode(vertex_properties,  neighbors_bags(g)))
end