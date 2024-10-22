
# Setup display width, load packages, import symbols
ENV["COLUMNS"]=72
using Base.Iterators: flatten
using IterTools: ncycle, takenth
using Statistics: mean
using MLDatasets: MNIST
import CUDA # functional
import Knet # load, save
using AutoGrad, OnlineStats, Random, LinearAlgebra, ForwardDiff
using Knet: Data, conv4, pool, relu, param, param0, minibatch, dropout, mat, nll, @diff, params, grad

TYPE = Float32
array_type=(CUDA.functional() ? KnetArray{TYPE} : Array{TYPE})


### Structure Data
mutable struct MnistDataConvNet{T, S} <: MnistData{T, S}
    x::Array{T,4}
    y::Array{S,1}
    sizeSAA::Int

    function MnistDataConvNet{T, S}(xdata, ydata; sizeSAA::Int=1, shuffled::Bool=false) where {T, S}
        if (shuffled)
            shuffled_indices = randperm(MersenneTwister(1234), size(xdata, 3))
            x = Array{T, 4}(undef, (28, 28, 1, size(xdata, 3)))
            y = Array{S, 1}(undef, size(ydata))
            for (k, j) in enumerate(shuffled_indices)
                x[:, :, 1, k] = xdata[:, :, j]
                y[k] = ydata[j]
            end
            return new{T, S}(x, y, sizeSAA)
        else
            x = Array{T, 4}(undef, (28, 28, 1, size(xdata, 3)))
            y = Array{S, 1}(undef, size(ydata))
            for k=1:size(xdata, 3)
                x[:, :, 1, k] = xdata[:, :, k]
                y[k] = ydata[k]
            end
            return new{T, S}(x, y, sizeSAA)
        end
    end
end


# Load MNIST data
xtrn,ytrn = MNIST.traindata(TYPE); ytrn[ytrn.==0] .= 10
xtst,ytst = MNIST.testdata(TYPE);  ytst[ytst.==0] .= 10

dtrn = MnistDataConvNet{TYPE, Int}(xtrn, ytrn)
dtrn.x[:,:,1,1]
dtst = MnistDataConvNet{TYPE, Int}(xtst, ytst)
dtst.x[:,:,1,1]

const nInd = size(dtrn.x, 4)
const nInd_test = size(dtst.x, 4)
