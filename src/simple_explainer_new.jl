mutable struct SimpleExplainer
    model
    vp
    nb
    mask

    function SimpleExplainer(g, mg, vertex2array, frozen_model)
        vp = reduce(hcat, [vertex2array(mg, i) for i in vertices(g)])
        nvp = ArrayNode(Flux.param(vp))
        new(frozen_model, vp, graph2bag(TreeNode((nvp, BagNode(nvp,  neighbors_bags(g))))), Flux.param(ones(Float32, 1, nobs(vp)) .* 3))
    end
end

Flux.@treelike(SimpleExplainer)

function (se::SimpleExplainer)()
    nvp = ArrayNode(se.vp .* σ.(se.mask))
    g = graph2bag(TreeNode((nvp, BagNode(nvp,  se.nb))))
    se.model(g)
end