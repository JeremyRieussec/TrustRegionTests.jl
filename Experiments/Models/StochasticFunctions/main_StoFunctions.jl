include("Exponential_Stochastic.jl")
include("Rosenbrock_Stochastic.jl")
include("Rosenbrock_Generalized_Stochastic.jl")
include("Rosenbrock_Generalized_Stochastic_2.jl")


abstract type StochasticFunction end

mutable struct StoRosenbrockDiff <: StochasticFunction
    f::Function # fonction definie avec Stochastic Generalized Rosenbrock (different minima)
    ξ::Matrix # echantillon population

    dimParameters::Int64 # dimension parameters
    sizePopulation::Int64 # size population

    function StoRosenbrockDiff(ξ_::Matrix)
        return new(undef, ξ_, size(ξ_, 1) + 1, size(ξ_, 2))
    end
end

mutable struct StoRosenbrockSame <: StochasticFunction
    f::Function # fonction definie avec Stochastic Generalized Rosenbrock (different minima)
    ξ::Matrix # echantillon population

    dimParameters::Int64 # dimension parameters
    sizePopulation::Int64 # size population

    function StoRosenbrockSame(ξ_::Matrix)
        return new(undef, ξ_, size(ξ_, 1) + 1, size(ξ_, 2))
    end
end
