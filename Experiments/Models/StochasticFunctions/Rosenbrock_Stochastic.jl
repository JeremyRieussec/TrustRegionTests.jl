
function Rosenbrock_Sto(x::Vector, samples::Vector)
    N = length(samples)
    result = 0
    for i=1:N
        ξ = samples[i]
        result += 100*(x[2] - (ξ*x[1])^2)^2 + (ξ*x[1] - 1)^2
    end
    return result/N
end


function Rosenbrock_Sto_Grad(x::Vector, samples::Vector)
    v1 = 0
    v2 = 0
    N = length(samples)
    for i=1:N
        ξ = samples[i]
        v1 += -400*ξ^2*x[1]*(x[2] - (ξ*x[1])^2) + 2*ξ*(ξ*x[1] - 1)
        v2 += 200*(x[2] - (ξ*x[1])^2)
    end
    return [v1/N ; v2/N]
end

function Rosenbrock_Sto_Hessian(x::Vector, samples::Vector)
    v1 = 0
    v2 = 0
    N = length(samples)
    for i=1:N
        ξ = samples[i]
        v1 += -400*ξ^2*x[1]*(x[2] - (ξ*x[1])^2) + 2*ξ*(ξx[1] - 1)
        v2 += 200*(x[2] - (ξ*x[1])^2)
    end
    return [v1 ; v2]
end
