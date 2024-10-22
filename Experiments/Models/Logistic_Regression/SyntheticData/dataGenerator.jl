using Distributions, CSV, DataFrames, ProgressMeter

# const mrgParams = MRG32k3a([12, 3, 45, 67, 8, 9])
# const mrgGumbel = copy(mrgParams)
# next_substream!(mrgGumbel)

"""
    genFibbomod(N::Int)

Generates a vector of dimension `N` where the values are the Fibonnacci suite modulo 100.
"""
function genFibbomod(N::Int)
    if N == 1
        return [0]
    elseif N == 2
        return [0, 1]
    else
        rt = [0, 1]
        for k in 3:N
            push!(rt, (rt[k - 2] + rt[k - 1]) % 100)
        end
        return rt
    end
end

"""
    genLogitInd(N::Int, nchoice::Int)

Generates the observed attributes values for an individual, where `N` is the model parameter size
and `nchoice` is the number of alternatives.
"""
function genLogitInd(N::Int, nchoice::Int)
    params = [quantile.(Normal(), rand(N)) for _ in 1:nchoice]

    beta = genFibbomod(N)
    vals = [beta'*p for p in params] + quantile.(Gumbel(), rand(nchoice))
    sortp = sortperm(-vals)
    paramsasVec = vcat(params[sortp]...)
    return paramsasVec
end

"""
    genLogitPop(N::Int, nchoice::Int, nInd::Int)

Generates a population of size `nInd` with parameter size `N` and `nchoice` is the number of alternatives.

Returns a DataFrame.
"""
function genLogitPop(N::Int, nchoice::Int, nInd::Int)
    df = DataFrame(zeros(0, N*nchoice), :auto)
    # reset_substream!(mrgParams)
    # reset_substream!(mrgGumbel)
    for _ in 1:nInd
        push!(df, genLogitInd(N::Int, nchoice::Int))
    end
    return df
end
