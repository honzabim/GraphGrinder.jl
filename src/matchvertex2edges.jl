matchvertex2edges(x, edges) = x[:, [e.src for e in edges]]
function ∇matchvertex2edges(Δ, x, edges)
    o = similar(x) .= 0
    for (i,e) in enumerate(edges)
        o[:, e.src] .+= Δ[:,i] 
    end
    o
end
matchvertex2edges(x::Flux.Tracker.TrackedMatrix, edges) = Flux.Tracker.track(matchvertex2edges, x, edges)
Flux.Tracker.@grad function matchvertex2edges(x, edges)
    return(matchvertex2edges(Flux.data(x), edges), Δ -> (∇matchvertex2edges(Δ, x, edges), nothing))
end