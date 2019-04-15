module GraphGrinder

using LightGraphs, MetaGraphs
using MLDataPattern, Flux, Mill

include("graph2bag.jl")
include("matchvertex2edges.jl")

export graph2bag

end # module
