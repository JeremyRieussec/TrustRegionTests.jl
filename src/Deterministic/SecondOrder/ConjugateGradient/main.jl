abstract type AbstractConjugateGradient end

include("stopCG.jl")
include("CG.jl")
include("TCG.jl")
include("TCGP.jl")

#include("TCGP.jl")

global solveQuadModel! = TruncatedCG!
function setsolveQuadModel!(f!::Function)
    global solveQuadModel! = f!
end

cg! = TruncatedCG!