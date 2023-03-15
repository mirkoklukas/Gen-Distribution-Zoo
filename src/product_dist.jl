# # # # # # # # # # # # # # # # # # # 
#                                   # 
#   This is an auto-generated file  # 
#   based on the jupyter notebook   # 
#
#   >   ``02_Product_Distribution.ipynb''
#
#                                   #
# # # # # # # # # # # # # # # # # # #

using Gen

struct ProductDistribution{T} <: Distribution{Vector{T  where T}}
    dist::Distribution{T}
end
function Gen.random(Q::ProductDistribution, args_vec::AbstractVector...)
    p = Q.dist
    return [p(args...) for args in zip(args_vec...)]
end
(Q::ProductDistribution)(args_vec::AbstractVector...) = Gen.random(Q::ProductDistribution, args_vec...)

function Gen.logpdf(Q::ProductDistribution{T}, xs::Vector{T}, args_vec::AbstractVector...) where T
    log_p = 0.0
    p = Q.dist
    # "for loop" implementation seems slower, according to benchmarktools
    # Don't know why really, doesn't seem to be that way in `diagnorm`
    return sum([Gen.logpdf(p, x, args...) for (x, args...) in zip(xs, args_vec...)])
end

Gen.has_output_grad(Q::ProductDistribution)    = has_output_grad(Q.dist)
Gen.has_argument_grads(Q::ProductDistribution) = Gen.has_argument_grads(Q.dist)
