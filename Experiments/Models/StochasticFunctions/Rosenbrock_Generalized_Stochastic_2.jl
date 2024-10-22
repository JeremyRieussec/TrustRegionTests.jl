
## ----------------------------- Function definition ---------------------
# --- full sample ---
function Rosenbrock_Generalized_Stochastic_2(x::Vector{T}, samples::AbstractArray{S, 2}) where {T, S}
    p = length(x)
    N = size(samples, 2)
    result = 0
    for k=1:N
        ξ = samples[:,k]
        for i=1:p-1
            result += 100*(x[i+1] - (ξ[i]*x[i])^2)^2 + (ξ[i]*x[i] - 1)^2
        end
    end
    return result/N
end


function Rosenbrock_Generalized_Stochastic_2_inds(x::Vector{T}, samples::AbstractArray{S, 2}) where {T, S}
    p = length(x)
    N = size(samples, 2)
    result = zeros(T, N)
    for k=1:N
        ξ = samples[:,k]
        for i=1:p-1
            result[k] += 100*(x[i+1] - (ξ[i]*x[i])^2)^2 + (ξ[i]*x[i] - 1)^2
        end
    end
    return result
end


# --- with sub-sample
function Rosenbrock_Generalized_Stochastic_2(x::Vector, samples::Matrix, indices::Array{Int64, 1})
    p = length(x)
    result = 0
    for k in indices
        ξ = samples[:,k]
        for i=1:p-1
            result += 100*(x[i+1] - (ξ[i]*x[i])^2)^2 + (ξ[i]*x[i] - 1)^2
        end
    end
    return result/length(indices)
end

## ----------------- Gradient definition -------------------

# ---- Full sample
function Rosenbrock_Generalized_Stochastic_Grad_2(x::Vector{T}, samples::AbstractArray{S, 2}) where {T, S}
    p = length(x)
    N = size(samples, 2)
    result = zeros(T, p)

    for k=1:N
        ξ = samples[:,k]
        result[1] += -400*ξ[1]^2*x[1]*(x[2] - (ξ[1]*x[1])^2) + 2*ξ[1]*(ξ[1]*x[1] - 1)
        for i=2:p-1
            result[i] += 200*(x[i] - (ξ[i-1]*x[i-1])^2) - 400*ξ[i]^2*x[i]*(x[i+1] - (ξ[i]*x[i])^2) + 2*ξ[i]*(ξ[i]*x[i] - 1)
        end
        result[p] += 200*(x[p] - (ξ[p-1]*x[p-1])^2)
    end
    return result/N
end

function Rosenbrock_Generalized_Stochastic_Grad_2_inds(x::Vector{T}, samples::AbstractArray{S, 2}) where {T, S, R}
    p = length(x)
    N = size(samples, 2)
    result = zeros(p)
    stack = zeros(R, p, N)
    
    for k=1:N
        ξ = samples[:,k]
        stack[1, k] += -400*ξ[1]^2*x[1]*(x[2] - (ξ[1]*x[1])^2) + 2*ξ[1]*(ξ[1]*x[1] - 1)
        for i=2:p-1
            stack[i, k] += 200*(x[i] - (ξ[i-1]*x[i-1])^2) - 400*ξ[i]^2*x[i]*(x[i+1] - (ξ[i]*x[i])^2) + 2*ξ[i]*(ξ[i]*x[i] - 1)
        end
        stack[p, k] += 200*(x[p] - (ξ[p-1]*x[p-1])^2)
    end
    return stack
end

# --- with sub-sample
function Rosenbrock_Generalized_Stochastic_Grad_2(x::Vector, samples::Matrix, indices::Array{Int64})
    p = length(x)
    result = zeros(p)

    for k in indices
        ξ = samples[:,k]
        result[1] += -400*ξ[1]^2*x[1]*(x[2] - (ξ[1]*x[1])^2) + 2*ξ[1]*(ξ[1]*x[1] - 1)
        for i=2:p-1
            result[i] += 200*(x[i] - (ξ[i-1]*x[i-1])^2) - 400*ξ[i]^2*x[i]*(x[i+1] - (ξ[i]*x[i])^2) + 2*ξ[i]*(ξ[i]*x[i] - 1)
        end
        result[p] += 200*(x[p] - (ξ[p-1]*x[p-1])^2)
    end
    return result/length(indices)
end

## ------------------ Calcul Hessian ------------------------

# ------ with Full sample -------------
# Coeff est divisé par deux car il y a de l'overlap dans la boucle de calcul
function Rosenbrock_Generalized_Stochastic_Hessian_2(x::Vector{T}, samples::AbstractArray{S, 2}) where {T,S}
    p = length(x)
    N = size(samples, 2)
    result = zeros(p,p)

    for k=1:N
        ξ = samples[:,k]
        result[1,1] += -400*ξ[1]^2*(x[2] - (ξ[1]*x[1])^2)+ 800*ξ[1]^4*x[1]^2 + 2*ξ[1]^2
        coeff = -400*ξ[1]^2*x[1]
        result[1,2] += coeff/2
        result[2,1] += coeff/2
        for i=2:p-1
            result[i,i] += 200 - 400*ξ[i]^2*(x[i+1] - (ξ[i]*x[i])^2) + 800*ξ[i]^4*x[i]^2 + 2*ξ[i]^2
            coeff = -400*ξ[i-1]^2*x[i-1]
            result[i-1,i] += coeff/2
            result[i, i-1] += coeff/2
            coeff = -400*ξ[i]^2*x[i]
            result[i+1, i] += coeff/2
            result[i, i+1] += coeff/2
        end
        result[p,p] += 200
        coeff = -400*ξ[p-1]^2*x[p-1]
        result[p-1, p] += coeff/2
        result[p, p-1] += coeff/2
    end
    return result/N
end

# ---------- with sub-sample ---------
function Rosenbrock_Generalized_Stochastic_Hessian_2(x::Vector, samples::Matrix, indices::Array{Int64, 1})
    p = length(x)
    result = zeros(p,p)

    for k in indices
        ξ = samples[:,k]
        result[1,1] += -400*ξ[1]^2*(x[2] - (ξ[1]*x[1])^2)+ 800*ξ[1]^4*x[1]^2 + 2*ξ[1]^2
        coeff = -400*ξ[1]^2*x[1]
        result[1,2] += coeff/2
        result[2,1] += coeff/2
        for i=2:p-1
            result[i,i] += 200 - 400*ξ[i]^2*(x[i+1] - (ξ[i]*x[i])^2) + 800*ξ[i]^4*x[i]^2 + 2*ξ[i]^2
            coeff = -400*ξ[i-1]^2*x[i-1]
            result[i-1,i] += coeff/2
            result[i, i-1] += coeff/2
            coeff = -400*ξ[i]^2*x[i]
            result[i+1, i] += coeff/2
            result[i, i+1] += coeff/2
        end
        result[p,p] += 200
        coeff = -400*ξ[p-1]^2*x[p-1]
        result[p-1, p] += coeff/2
        result[p, p-1] += coeff/2
    end
    return result/length(indices)
end

## ---------------------- Calcul Hessian vecteur -------------

# ---- with full sample
function Hessian_vector_product_RGS(x::Vector{T}, samples::AbstractArray{S, 2}, v::Vector{R}) where {T, S, R}
    p = length(x)
    N = size(samples, 2)
    result = zeros(p)

    for k=1:N
        ξ = samples[:,k]
        result[1] += (-400*ξ[1]^2*(x[2] - (ξ[1]*x[1])^2)+ 800*ξ[1]^4*x[1]^2 + 2*ξ[1]^2)*v[1] + (-400*ξ[1]^2*x[1])*v[2]
        for i=2:p-1
            result[i] += (-400*ξ[i-1]^2*x[i-1])*v[i-1] + (200 - 400*ξ[i]^2*(x[i+1] - (ξ[i]*x[i])^2) + 800*ξ[i]^4*x[i]^2 + 2*ξ[i]^2)*v[i] + (-400*ξ[i]^2*x[i])*v[i+1]
        end
        result[p] += (-400*ξ[p-1]^2*x[p-1])*v[p-1] + (200)*v[p]
    end
    return result/N
end

# --- with sub-sample ----
function Hessian_vector_product_RGS(x::Vector, samples::Matrix, indices::Array{Int64, 1}, v::Vector)
    p = length(x)
    result = zeros(p)

    for k in indices
        ξ = samples[:,k]
        result[1] += (-400*ξ[1]^2*(x[2] - (ξ[1]*x[1])^2)+ 800*ξ[1]^4*x[1]^2 + 2*ξ[1]^2)*v[1] + (-400*ξ[1]^2*x[1])*v[2]
        for i=2:p-1
            result[i] += (-400*ξ[i-1]^2*x[i-1])*v[i-1] + (200 - 400*ξ[i]^2*(x[i+1] - (ξ[i]*x[i])^2) + 800*ξ[i]^4*x[i]^2 + 2*ξ[i]^2)*v[i] + (-400*ξ[i]^2*x[i])*v[i+1]
        end
        result[p] += (-400*ξ[p-1]^2*x[p-1])*v[p-1] + (200)*v[p]
    end
    return result/length(indices)
end
