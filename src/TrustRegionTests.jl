module TrustRegionTests

    using LinearAlgebra, Random, NLPModels, QuadraticModels, Test

    export greet, geometricMean

    """
    greet(s::String)
    
    # Arguments
    - `s::String`: name of person to greet.

    Returns some Greetings.
    
    # Examples
    ```julia-repl
    julia> greet("you")
    "Hello you to the world of Trust-Region Tests!"
    ```
    """ 
    greet(s::String) =  print("Hello " * s *  " to the world of Trust-Region Tests!")

    """
    greet()
    
    Default Greetings!
    """
    greet() = greet("you") 

    @doc raw"""Geometric mean

    geometricMean(x::Array)

    Returns: ``\sqrt[n]{x_1\times x_2 \times \ldots \times x_n}``.
    """
   function  geometricMean(x::Array)
        n = size(x, 1)
        s = 1.0
        for i in 1:n
            s *= x[i]
        end
        return s^(1/n)
   end 

    abstract type AbstractOptimizer end 

    # Deterministic
    # include("Deterministic/main.jl")

end # module TrustRegionTests
