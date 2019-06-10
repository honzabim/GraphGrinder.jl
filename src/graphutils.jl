function strip_lone_vertices(g)
    neighbors_count = map(x -> length(all_neighbors(g, x)), vertices(g))
    lone_vertex = neighbors_count .== 0
    id_mapping = (1:length(vertices(g)))[.!lone_vertex]
    new_graph, vmap = induced_subgraph(g, id_mapping)
    return new_graph
end

component_including_vertex(g, v::Union{BitArray, Array{Bool, 1}}) = map(i -> component_including_vertex(g, i), findall(v))
component_including_vertex(g, v::Int) = induced_subgraph(g, filter(x -> v in x, weakly_connected_components(g))[1])[1]
