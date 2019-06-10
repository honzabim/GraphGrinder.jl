module GraphGrinder

using LightGraphs, MetaGraphs
using MLDataPattern, Flux, Mill

include("graph2bag.jl")
include("matchvertex2edges.jl")
include("message_passing.jl")
include("simple_explainer.jl")
include("graphutils.jl")

export graph2bag, vertices2bag, SimpleExplainer, get_vertex_labels, strip_lone_vertices, component_including_vertex

end # module
