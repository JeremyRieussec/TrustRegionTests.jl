

################################################################################
                            # Nobs #
################################################################################

function Sofia.Nobs(mo::MnistModel)
    return size(mo.train_data.x, 2)
end

################################################################################
                            # F #
################################################################################

function Sofia.F(x::Vector, mo::MnistModel; sample::AbstractVector{Int64} = 1:Nobs(mo))
        instanciate(x, mo.network)
        return mo.network(mo.train_data, sample)
end

# Normal
function F_normal(x::Vector, mo::MnistModel; sample::AbstractVector{Int64} = 1:Nobs(mo))
        instanciate(x, mo.network)
        return mo.network(mo.train_data, sample)
end

# True Variance
function F_variance(x::Vector, mo::MnistModel; sample::AbstractVector{Int64} = 1:Nobs(mo))
        instanciate(x, mo.network)

        stats_data = Series(Mean(), Variance())
        f_values_cand = []
        for i in sample
            temp = mo.network(mo.train_data.x[:, i], [mo.train_data.y[i]])
            push!(f_values_cand , temp)
           fit!(stats_data, temp)
        end
        f_value, var_f = OnlineStats.value(stats_data)
        return f_value, var_f, f_values_cand
end

################################################################################
                            # Gradient #
################################################################################
function Sofia.grad!(x::Vector{T}, mo::MnistModel, stack::Vector; sample::AbstractVector{Int64} = 1:Nobs(mo)) where T
    instanciate(x, mo.network)
       gradient = T[]
        loss = @diff mo.network(mo.train_data, sample)
        for w in Knet.params(mo.network)
            g = grad(loss,w)
            gradient = append!(gradient, g[:])
        end
        stack[:] = gradient[:]
end

function Sofia.grads(x::Vector{T}, mo::MnistModel; sample::AbstractVector{Int64} = 1:Nobs(mo)) where T
    instanciate(x, mo.network)
    bhhh_storage = Vector{T}[]
    for i in sample
        temp = T[]
        loss = @diff mo.network(mo.train_data.x[:,i], [mo.train_data.y[i]])
        for w in Knet.params(mo.network)
            g = grad(loss,w)
            temp = append!(temp, g[:])
        end
        append!(bhhh_storage, [temp])
    end
    return bhhh_storage
end
