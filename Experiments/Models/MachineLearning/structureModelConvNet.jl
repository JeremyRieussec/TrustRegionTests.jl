
include("AbstractStructure.jl")

########### Define a convolutional layer ################
# w -> matrix of weights kernel
# b -> bias
# f -> activation function
# p -> probability of dropout
struct Conv; w; b; f; p; end

#
(c::Conv)(x) = c.f.(pool(conv4(c.w, dropout(x,c.p)) .+ c.b))

# w1, w2: size kernel
# cx intput channels
# cy output channels -> number of feature maps
Conv(w1::Int,w2::Int,cx::Int,cy::Int,f=relu;pdrop=0) = Conv(param(w1,w2,cx,cy), param0(1,1,cy,1), f, pdrop)

# Redefine dense layer :
struct Dense; w; b; f; p; end
(d::Dense)(x) = d.f.(d.w * mat(dropout(x,d.p)) .+ d.b) # mat reshapes 4-D tensor to 2-D matrix so we can use matmul
Dense(i::Int,o::Int,f=relu;pdrop=0) = Dense(param(o,i), param0(o), f, pdrop)


# Let's define a chain of layers
mutable struct ChainConvNet{S} <: AbstractChain{S}
    layers
    size_model::Int

    function ChainConvNet(layers...)
        dim_model = 0
        for l in layers
            dim_model += size(l.w, 1) * size(l.w, 2)*size(l.w, 3) * size(l.w, 4)
            dim_model += size(l.b, 1) * size(l.b, 2) * size(l.b, 3) * size(l.b, 4)
        end
        new{Float64}(layers, dim_model)
    end

    function ChainConvNet{S}(layers...) where S
        dim_model = 0
        for l in layers
            dim_model += size(l.w, 1) * size(l.w, 2)*size(l.w, 3) * size(l.w, 4)
            dim_model += size(l.b, 1) * size(l.b, 2) * size(l.b, 3) * size(l.b, 4)
        end
        new{S}(layers, dim_model)
    end
end



(c::ChainConvNet)(x) = (for l in c.layers; x = l(x); end; x)

(c::ChainConvNet)(x,y) = nll(c(x),y)

(c::ChainConvNet)(d::MnistData, shu::AbstractVector{Int64} = 1:nInd) = c(d.x[:,:,:,shu], d.y[shu])


#######################################################################
# Fonctions utiles pour Mnist

# initialisation des parametres du modele Conv Net
function instanciate(x::Vector{S}, model::ChainConvNet{S}) where S
    i_debut = 1
    for w in Knet.params(model)
        full_size = 1
        for s in size(w)
            full_size*=s
        end
        i_fin = i_debut +  full_size - 1
        w[:,:, :, :] = reshape(x[i_debut:i_fin], size(w))
        i_debut = i_fin + 1
    end

end

# creation vecteur a partir modele Conv Net
function create_vector(model::ChainConvNet{S}) where S
    result = Vector{S}(zeros(model.size_model))
    i_debut = 1
    for w in Knet.params(model)
        full_size = 1
        for s in size(w)
            full_size*=s
        end
        i_fin = i_debut +  full_size - 1
        result[i_debut:i_fin] = w[:]
        i_debut = i_fin + 1
    end
    return result
end
