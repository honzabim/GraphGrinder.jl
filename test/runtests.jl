using Test, GraphGrinder, Flux

@testset matchvertex2edges begin
    x = rand(3,3)
    Δ = Flux.data(Flux.Tracker.gradient(x -> sum(sin.(matchvertex2edges(x, edges(g)))), x)[1])
    nΔ = Flux.Tracker.ngradient(x -> sum(sin.(matchvertex2edges(x, edges(g)))), x)[1]
    @test isapprox(Δ, nΔ, atol = 1e-4)
end