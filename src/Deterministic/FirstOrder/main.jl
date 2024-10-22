# Defining learning rates for First order methods
include("learningRates.jl")

# Generic part of First-order algorithms
include("AbstractPart/main.jl")

# Definition of specific methods, for example, Gradient Descent, Momentum, Accelerated Nesterov Method, Adam
include("Methods/main.jl")