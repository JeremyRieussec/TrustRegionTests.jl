module TrustRegionTests

    export greet, domath, bar, foo, add_exported
    
    """Greetings!"""
    greet() = print("Hello World of Trust-Region Tests!")

    """
    greet(s::String)
    
    Returns Hello World name `s`.""" 
    greet(s::String) = print("Hello World " * s * " !!")

    """
    domath(x::Real)

    Returns double the number `x` plus `1`.
    """
    domath(x::Real) = 2*x + 1.0

    """A foo function.

    # Arguments
    - `arg::Int`: Function argument.
    """
    function foo(arg::Int)
        return length(x)^2
    end

    """
        bar(x[, y])

    Compute the Bar index between `x` and `y`.

    If `y` is unspecified, compute the Bar index between all pairs of columns of `x`.

    # Examples
    ```julia-repl
    julia> bar([1, 2], [1, 2])
    1
    ```
    """
    function bar(x,y)
        return x + y
    end

    @doc raw"""
    Here's some inline maths: ``\sqrt[n]{1 + x + x^2 + \ldots}``.

    Here's an equation:

    ``\frac{n!}{k!(n - k)!} = \binom{n}{k}``

    This is the binomial coefficient.
    """
    func(x) = 42 # ...

end # module TrustRegionTests
