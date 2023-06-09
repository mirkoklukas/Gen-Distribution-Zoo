# # # # # # # # # # # # # # # # # # # 
#                                   # 
#   This is an auto-generated file  # 
#   based on the jupyter notebook   # 
#
#   >   ``02_Diagonal_Normal.ipynb''
#
#                                   #
# # # # # # # # # # # # # # # # # # #

using Gen

struct DiagonalNormal <: Distribution{Vector{Float64}} end
const diagnormal = DiagonalNormal()

function Gen.random(::DiagonalNormal, mus::AbstractVector{U}, stds::AbstractVector{V}) where {U <: Real, V <: Real}
    return [normal(mu, std) for (mu,std) in zip(mus, stds)]
end

function Gen.random(::DiagonalNormal, mus::AbstractVector{U}, std::V) where {U <: Real, V <: Real}
    return [normal(mu, std) for mu in mus]
end

(::DiagonalNormal)(mus::AbstractVector{U}, stds::AbstractVector{V})  where {U <: Real, V <: Real} = Gen.random(DiagonalNormal(), mus, stds)
(::DiagonalNormal)(mus::AbstractVector{U}, std::V)  where {U <: Real, V <: Real} = Gen.random(DiagonalNormal(), mus, std)


function Gen.logpdf(::DiagonalNormal, xs::AbstractVector{T},
                mus::AbstractVector{U}, stds::AbstractVector{V}) where {T <: Real, U <: Real, V <: Real}
    log_p = 0.0
    for (x, mu, std) in zip(xs, mus, stds)
        log_p += Gen.logpdf(normal, x, mu, std)
    end
    return log_p
end

function Gen.logpdf(::DiagonalNormal, xs::AbstractVector{T},
                mus::AbstractVector{U}, std::V) where {T <: Real, U <: Real, V <: Real}
    log_p = 0.0
    for (x, mu) in zip(xs, mus)
        log_p += Gen.logpdf(normal, x, mu, std)
    end
    return log_p
end


Gen.has_output_grad(::DiagonalNormal) = true
Gen.has_argument_grads(::DiagonalNormal) = (true, true)
