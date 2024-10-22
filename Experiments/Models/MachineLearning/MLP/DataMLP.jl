# Set display width, load packages, import symbols
ENV["COLUMNS"]=72

using Knet: Knet, dir, accuracy, progress, sgd, load143, save, gc, Param, KnetArray, Data, minibatch, nll, relu, training, dropout
using Knet: param, param0, xavier_uniform
using Base.Iterators: flatten
using IterTools: ncycle, takenth
using MLDatasets: MNIST

#import CUDA # functional
#array_type=(CUDA.functional() ? KnetArray{Float64} : Array{Float64})
array_type = Array{Float64}

### Structure Data
mutable struct MnistDataMLP{T, S} <: MnistData{T, S}
    x::Array{T,2}
    y::Array{S,1}
    sizeSAA::Int

    function MnistDataMLP{T, S}(xdata, ydata; sizeSAA::Int=1, shuffled::Bool=false) where {T, S}
        if (shuffled)
            shuffled_indices = randperm(MersenneTwister(1234), size(xdata, 2))
            x = Array{T, 2}(undef, size(xdata))
            y = Array{S, 1}(undef, size(ydata))
            for (k, j) in enumerate(shuffled_indices)
                x[:, k] = xdata[:, j]
                y[k] = ydata[j]
            end
            return new{T, S}(x, y, sizeSAA)
        else
            return new{T, S}(xdata, ydata, sizeSAA)
        end
    end
end

### Data:
# Load MNIST data (par batch de 1 pour pourvoir faire du SAA)
xtrn_,ytrn = MNIST.traindata(Float64);
ytrn[ytrn.==0] .= 10 # pour changer les labels 0 en 10

xtst_,ytst = MNIST.testdata(Float64);
ytst[ytst.==0] .= 10 # pour changer les labels 0 en 10

_height, _width , ntrain_origin = size(xtrn_)
ntest_origin = size(xtst_ , 3)

# on veut reformer le dataset des images en (x_1 | ...| x_n) avec n=60000
#   --> reshape(784,60000) car 28x28 = 784
feature_size = _height*_width
xtrn = reshape(xtrn_ , (feature_size , ntrain_origin))
xtst = reshape(xtst_ , (feature_size , ntest_origin))

# Data finale
dtrn = MnistDataMLP{Float64, Int64}(xtrn, ytrn, shuffled=true)
dtst = MnistDataMLP{Float64, Int64}(xtst, ytst, sizeSAA = length(ytst))

# Definition des nInd
const nInd = size(ytrn, 1)
const nInd_tst = size(ytst, 1)
