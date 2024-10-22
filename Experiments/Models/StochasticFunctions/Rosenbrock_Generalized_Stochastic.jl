function Rosenbrock_Generalized_Stochastic(x::Vector, samples::Matrix)
    p = length(x)
    N = size(samples, 2)
    result = 0
    for k=1:N
        ξ = samples[:,k]
        for i=1:p-1
            result += 100*ξ[i]*(x[i+1] - x[i]^2)^2 + (1 - x[i])^2
        end
    end
    return result/N
end

function Rosenbrock_Generalized_Stochastic_Grad(x::Vector, samples::Matrix)
    p = length(x)
    N = size(samples, 2)
    result = zeros(p)

    for k=1:N
        ξ = samples[:,k]
        result[1] += -400*ξ[1]*x[1]*(x[2] - x[1]^2)- 2*(1 - x[1])
        for i=2:p-1
            result[i] += 200*ξ[i-1]*(x[i] - x[i-1]^2) - 400*ξ[i]*x[i]*(x[i+1] - x[i]^2) - 2(1 - x[i])
        end
        result[p] += 200*ξ[p-1]*(x[p] - x[p-1]^2)
    end
    return result/N
end

## Coeff est divisé par deux car il y a de l'overlap dans la boucle de calcul
function Rosenbrock_Generalized_Stochastic_Hessian(x::Vector, samples::Matrix)
    p = length(x)
    N = size(samples, 2)
    result = zeros(p,p)

    for k=1:N
        ξ = samples[:,k]
        result[1,1] += -400*ξ[1]*(x[2] - x[1]^2)+ 800*ξ[1]*x[1]^2 + 2
        coeff = -400*ξ[1]*x[1]
        result[1,2] += coeff/2
        result[2,1] += coeff/2
        for i=2:p-1
            result[i,i] += 200*ξ[i-1] - 400*ξ[i]*(x[i+1] - x[i]^2) + 800*ξ[i]*x[i]^2 + 2
            coeff = -400*ξ[i-1]*x[i-1]
            result[i-1,i] += coeff/2
            result[i, i-1] += coeff/2
            coeff = -400*ξ[i]*x[i]
            result[i+1, i] += coeff/2
            result[i, i+1] += coeff/2
        end
        result[p,p] += 200*ξ[p-1]
        coeff = -400*ξ[p-1]*x[p-1]
        result[p-1, p] += coeff/2
        result[p, p-1] += coeff/2
    end
    return result/N
end


function Hessian_vector_product_RGS(x::Vector, samples::Matrix, v::Vector)
    p = length(x)
    N = size(samples, 2)
    result = zeros(p)

    for k=1:N
        ξ = samples[:,k]
        result[1] += (-400*ξ[1]*(x[2] - x[1]^2)+ 800*ξ[1]*x[1]^2 + 2)*v[1] + (-400*ξ[1]*x[1])*v[2]
        for i=2:p-1
            result[i] += (-400*ξ[i-1]*x[i-1])*v[i-1] + (200*ξ[i-1] - 400*ξ[i]*(x[i+1] - x[i]^2) + 800*ξ[i]*x[i]^2 + 2)*v[i] + (-400*ξ[i]*x[i])*v[i+1]
        end
        result[p] += (-400*ξ[p-1]*x[p-1])*v[p-1] + (200*ξ[p-1])*v[p]
    end
    return result/N
end
