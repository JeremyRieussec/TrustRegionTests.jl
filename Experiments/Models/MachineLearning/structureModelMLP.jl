##############################################################
##  Definition du modele

include("AbstractStructure.jl")

# Using nonlinearities between layers results in a model with higher capacity and helps underfitting
# relu(x)=max(0,x) is a popular function used for this purpose, it replaces all negative values with zeros.
struct Layer1; w; b; f; end
Layer1(i::Int,o::Int,f=relu) = Layer1(param(o,i),param0(o),f)
(l::Layer1)(x) = l.f.(l.w * x .+ l.b)

# Structure general MLP
mutable struct ChainMLP{S} <: AbstractChain{S}
    layers
    size_model

    function ChainMLP{S}(layers...) where S
        dim_model = 0
        for l in layers
            dim_model += size(l.w, 1) * size(l.w, 2)
            dim_model += size(l.b, 1) * size(l.b, 2)
        end
        new{S}(layers, dim_model)
    end
end

#######################################################################
# Fonctions utiles pour le modele
# initialisation des parametres du modele

(c::ChainMLP)(x) = (for l in c.layers; x = l(x); end; x)

(c::ChainMLP)(x,y) = nll(c(x),y)

(c::ChainMLP)(d::MnistData, sample::AbstractVector{Int64} = 1:nInd) = c(d.x[:, sample], d.y[sample])



function instanciate(x::AbstractVector{T}, model::ChainMLP) where T
    i_debut = 1
    for w in Knet.params(model)
        i_fin = i_debut +  size(w, 1)*size(w, 2) - 1
        w[:,:] = reshape(x[i_debut:i_fin], size(w))
        i_debut = i_fin + 1
        #println(value(w))
    end
end

# creation vecteur a partir modele
function create_vector(model::ChainMLP{S}) where S
    result = Array{S}(undef, model.size_model)
    i_debut = 1
    for w in Knet.params(model)
        i_fin = i_debut +  size(w, 1)*size(w, 2) - 1
        result[i_debut:i_fin] = w[:]
        i_debut = i_fin + 1
    end
    return result
end

include("MnistModel.jl")
