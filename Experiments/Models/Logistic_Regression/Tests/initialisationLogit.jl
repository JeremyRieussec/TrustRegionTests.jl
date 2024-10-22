
using ForwardDiff, Plots, Statistics, LinearAlgebra, OnlineStats, Distributions, Random, CUDA, CSV, DataFrames

using Sofia, Amlet




##################################################################################

function genFibbomod(N::Int)
    if N == 0
        return zeros(0)
    elseif N == 1
        return [0.0]
    else
        rt = [0.0, 1]
        for k in 3:N
            push!(rt, (rt[k - 2] + rt[k - 1]) % 100)
        end
        return rt
    end
end
