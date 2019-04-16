module GraphGrinder

using LightGraphs, MetaGraphs
using MLDataPattern, Flux, Mill

include("graph2bag.jl")
include("matchvertex2edges.jl")
include("message_passing.jl")

export graph2bag, vertices2bag

end # module
