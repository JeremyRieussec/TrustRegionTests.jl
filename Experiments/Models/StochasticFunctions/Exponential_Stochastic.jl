
function Exponential_Sto(x::Vector{T}, samples::Vector) where T
    N = length(samples)
    result = 0
    for i=1:N
        ξ = samples[i]
        x_temp = ξ*x
        result += exp(-0.5*dot(x_temp, x_temp))
    end
    return -result/N
end

function Exponential_Sto_inds(x::Vector{T}, samples::Vector) where T
    N = length(samples)
    result = T[]
    for i=1:N
        ξ = samples[i]
        x_temp = ξ*x
        append!(result, -exp(-0.5*dot(x_temp, x_temp)))
    end
    return result
end

function Exponential_Sto_Grad(x::Vector, samples::Vector)
    N = length(samples)
    p = length(x)
    result = zeros(p)
    for i=1:N
        ξ = samples[i]
        x_temp = ξ*x
        coeff = ξ^2*exp(-0.5*dot(x_temp, x_temp))

        result += coeff*x
    end
    return result/N
end

function Exponential_Sto_Grads(x::Vector, samples::Vector)
    N = length(samples)
    p = length(x)
    result = zeros(p, N)
    for j=1:N
        ξ = samples[j]
        x_temp = ξ*x
        coeff = ξ^2*exp(-0.5*dot(x_temp, x_temp))

        result[:, j] += coeff*x
    end
    return result
end

function Exponential_Sto_Hessian(x::Vector, samples::Vector)
    N = length(samples)
    p = length(x)
    result = zeros(p,p)
    for i=1:N
        ξ = samples[i]
        x_temp = ξ*x
        coeff = exp(-0.5*dot(x_temp, x_temp))
        for k=1:p
            for j=1:p
                if (k==j)
                    result[k,k] += (1 - (ξ*x[k])^2 )*ξ^2*coeff
                else
                    result[k,j] += -ξ^4*x[k]*x[j]*coeff
                end
            end
        end
    end
    return result/N
end

function Hessian_vector_product_SExp(x::Vector, samples::Vector, v::Vector)
    N = length(samples)
    p = length(x)
    result = zeros(p)
    for i=1:N
        ξ = samples[i]
        x_temp = ξ*x
        coeff = exp(-0.5*dot(x_temp, x_temp))
        for k=1:p
            for j=1:p
                if (k==j)
                    result[k] += (1 - (ξ*x[k])^2 )*ξ^2*coeff*v[k]
                else
                    result[k] += -ξ^4*x[k]*x[j]*coeff*v[j]
                end
            end
        end
    end
    return result/N
end
