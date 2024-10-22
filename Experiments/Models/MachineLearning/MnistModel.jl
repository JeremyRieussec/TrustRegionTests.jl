
################################################################################
#                Model for Mnist
################################################################################
mutable struct MnistModel{T, S} <: Sofia.AbstractStochasticModel{NotUpdatable}
    network::AbstractChain{T}
    x0::Vector{T}

    train_data::MnistData{T, S}
    test_data::MnistData{T, S}

    constraints::Geraldine.AbstractConstraint

    function MnistModel(network::AbstractChain{T}, x0::Vector{T}, tr_data::MnistData{T, S}, tst_data::MnistData{T, S}) where {T, S}
        return new{T,S}(network, copy(x0), tr_data, tst_data, Geraldine.Unconstraint())
    end

end


################################################################################
#                       Functions on Model
################################################################################

function F_train(x::AbstractVector{T}, model::MnistModel; sample::AbstractVector{Int64} = 1:nInd) where T
        instanciate(x, model.network)
   return model.network(model.train_data, 1:nInd)
end

function F_test(x::AbstractVector{T}, model::MnistModel; sample::AbstractVector{Int64} = 1:nInd_tst) where T
    instanciate(x, model.network)
    return  model.network(model.test_data, 1:nInd_tst)
end

## Calcul des valeurs f_train / f_test on every parameter sets

function compute_ftest(array_parameters::Array{Vector{T}, 1}, model::MnistModel) where T
    f_test = T[]
    for i in 1:length(array_parameters)
        push!(f_test, F_test(array_parameters[i], model))
    end
    return f_test
end

function compute_ftrain(array_parameters::Array{Vector{T}, 1}, model::MnistModel) where T
    f_full_train = T[]
    for i in 1:length(array_parameters)
        push!(f_full_train, F_train(array_parameters[i], model))
    end
    return f_full_train
end

## calcul des accuracy on FULL train set and FULL test set
function compute_acc(model::AbstractChain, x_data, y_data, array_parameters)
    acc = []
    for i in 1:length(array_parameters)
        instanciate(array_parameters[i], model)
        (t, n) = accuracy(model(x_data), y_data; dims=1, average=false)
        push!(acc, t/n*100)
    end
    return acc
end

function computeAccTrain(mo::MnistModel, data_exp)
    acc_train = compute_acc(mo.network, mo.train_data.x , mo.train_data.y, data_exp.ParamAccumulator)
    return acc_train
end

function computeAccTest(mo::MnistModel, data_exp)
    acc_test = compute_acc(mo.network, mo.test_data.x , mo.test_data.y, data_exp.ParamAccumulator)
    return acc_test
end
