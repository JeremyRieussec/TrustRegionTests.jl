struct ConjugateGradient <: AbstractConjugateGradient
    stop::Function
    NMax::Int
    function ConjugateGradient(;stop = stopCGBase, NMax = 100_000)
        return new(stop, NMax)
    end
end

function (cg!::ConjugateGradient)(state::AbstractBTRState; verbose::Bool = false)
    verbose && println("Conjugate gradients ")

    state.iterCG = cg!(state.H, state.g, state.step, verbose = verbose)
end

### ATTENTION a modifier, x n'est pas  utiliser
function (cg!::ConjugateGradient)(H::AbstractMatrix, g::Vector, s::Vector{T}; verbose::Bool = false) where T
    s[:] .= T(0.0)

    normg0 = norm(g)
    n = length(x)

    r =  H*s + g
    p = -r
    k = 0
    Hp = zeros(n)
    alpha = 0.0
    rrold = 0.0
    while ! cg!.stop(norm(g), normg0, k, n, cg!.NMax)
        Hp[:] = H*p
        κ = p'*Hp
        if κ <= 0
            return Inf*ones(n)
        end
        alpha = (r'*r)/(p'*Hp)
        x += alpha*p
        rrold = r'*r
        r += alpha*Hp
        beta = r'*r/rrold
        p[:] .*= beta
        p[:] -= r
        k+=1
    end
end

CG! = ConjugateGradient()
