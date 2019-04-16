struct MessagePassing{A,B,C} <: Mill.AggregationFunction
    instance_model::A
    aggregation::B
    vertex_model::C
    n::Int
end
Flux.@treelike(MessagePassing)
(m::MessagePassing)(x, bags) = message_passing(x, bags, m.instance_model, m.aggregation, m.vertex_model, m.n)
(m::MessagePassing)(ds::BagNode) = ArrayNode(message_passing(ds.data.data, ds.bags, m.instance_model, m.aggregation, m.vertex_model, m.n))
(m::MessagePassing)(x::ArrayNode, bags) = ArrayNode(message_passing(x.data, bags, m.instance_model, m.aggregation, m.vertex_model, m.n))
function message_passing(xx, bags, instance_model, aggregation, vertex_model, n::Int)
    onepass(x, bags) = vertex_model(aggregation(instance_model(x), bags))
    x = onepass(xx, bags)
    for i in 1:n-1 
        x = onepass(x, bags)
    end
    x
end
message_passing(ds::BagNode, instance_model, aggregation, vertex_model, n::Int) = message_passing(ds.data.data, ds.bags, instance_model, aggregation, vertex_model, n)
#test case
bags = ScatteredBags([setdiff(neighbors(g, i), i) for i in vertices(g)])
ds = BagNode(vertex_properties, bags)
k = 4
rounds = 3
instance_model = Dense(k, k, relu)
aggregation = SegmentedMeanMax(k)
vertex_model = Dense(2k, k)
message_passing(ds, instance_model, aggregation, vertex_model, rounds) # put this to test
a = Mill.Aggregation((MessagePassing(instance_model, aggregation, vertex_model, rounds),))
m = BagModel(BagModel(identity, a, identity), SegmentedMeanMax(k), Chain(Dense(2k, k, relu), Dense(k,2))) 
dss = BagNode(ds, [1:nobs(ds)])
m(dss)
m(cat(dss,dss)).data