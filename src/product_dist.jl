# # # # # # # # # # # # # # # # # # # 
#                                   # 
#   This is an auto-generated file  # 
#   based on the jupyter notebook   # 
#
#   >   ``03_Product_Distribution.ipynb''
#
#                                   #
# # # # # # # # # # # # # # # # # # #

using Gen
abstract type ProductDistribution{T} <: Distribution{Vector{T}} end

struct HomogeneousProduct{T} <: ProductDistribution{T}
    dist::Distribution{T}
    n::Int
    slicedim::Int  # indicates the dimension specifying
                   # the arguments for each dist
                   # Default is along 1st dimension - differs
                   # from Gen's mixtures.
end
ProductDistribution(dist::Distribution{T}, n::Int, s::Int) where T = HomogeneousProduct{T}(dist, n, s)
ProductDistribution(dist::Distribution{T}, n::Int)         where T = HomogeneousProduct{T}(dist, n, 1)


slicedim(a, d::Int, i::Int) = selectdim(a, d > 0 ? d : ndims(a)+d+1, i)
function Gen.random(Q::HomogeneousProduct, args...)
    p = Q.dist
    n = Q.n
    d = Q.slicedim
    return [p((ndims(a) == 1 ? a[i] : slicedim(a, d, i) for a in args)...) for i=1:n]
end

(Q::HomogeneousProduct)(args...) = Gen.random(Q, args...)


function Gen.logpdf(Q::HomogeneousProduct{T}, xs::Vector{T}, args...) where T
    p = Q.dist
    n = Q.n
    d = Q.slicedim
    return sum([
        Gen.logpdf(p, xs[i], (ndims(a) == 1 ? a[i] : slicedim(a, d, i) for a in args)...) for i=1:n
    ])
end

Gen.has_output_grad(Q::HomogeneousProduct)    = has_output_grad(Q.dist)
Gen.has_argument_grads(Q::HomogeneousProduct) = Tuple([Gen.has_argument_grads(Q.dist) for i=1:Q.n])

struct HeterogeneousProduct{T} <: ProductDistribution{T}
    dists::Vector{D where D <: Distribution{T}}
    n::Int
    slicedim::Int
end
ProductDistribution(ds::Vector{D}, s::Int) where {T, D <: Distribution{T}} = HeterogeneousProduct{T}(ds, length(ds), s)
ProductDistribution(ds::Vector{D})         where {T, D <: Distribution{T}} = HeterogeneousProduct{T}(ds, length(ds), 1)


slicedim(a, d::Int, i::Int) = selectdim(a, d > 0 ? d : ndims(a)+d+1, i)
function Gen.random(Q::HeterogeneousProduct{T}, args...) where T
    n = Q.n
    s = Q.slicedim
    return [Q.dists[i]((ndims(a) == 1 ? a[i] : slicedim(a,s, i) for a in args)...) for i=1:n]
end

(Q::HeterogeneousProduct)(args...) = Gen.random(Q, args...)


function Gen.logpdf(Q::HeterogeneousProduct{T}, xs::Vector{T}, args...) where T
    p = Q.dists
    n = Q.n
    d = Q.slicedim
    return sum([
        Gen.logpdf(p[i], xs[i], (ndims(a) == 1 ? a[i] : slicedim(a, d, i) for a in args)...) for i=1:n
    ])
end

Gen.has_output_grad(Q::HeterogeneousProduct)    = has_output_grad(Q.dist)
Gen.has_argument_grads(Q::HeterogeneousProduct) = Tuple([Gen.has_argument_grads(Q.dist) for i=1:Q.n])
