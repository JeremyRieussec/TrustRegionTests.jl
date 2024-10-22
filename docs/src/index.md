# TrustRegionTests.jl Documentation

```@meta
CurrentModule = TrustRegionTests
```

# Documentation

```@docs
greet
geometricMean(x::Array)
```

# Displaying

## Fonts 
A paragraph containing a **bold** word.

A paragraph containing an *italicized* word.

A paragraph containing a `literal` word.

A paragraph containing some ``\LaTeX`` markup.

---

Here's an equation:

```math
\frac{n!}{k!(n - k)!} = \binom{n}{k}
```

This is the binomial coefficient.

---

To write a system of equations, use the `aligned` environment:

```math
\begin{aligned}
\nabla\cdot\mathbf{E}  &= 4 \pi \rho \\
\nabla\cdot\mathbf{B}  &= 0 \\
\nabla\times\mathbf{E} &= - \frac{1}{c} \frac{\partial\mathbf{B}}{\partial t} \\
\nabla\times\mathbf{B} &= - \frac{1}{c} \left(4 \pi \mathbf{J} + \frac{\partial\mathbf{E}}{\partial t} \right)
\end{aligned}
```

These are Maxwell's equations.


# Warnings
!!! note
    You can use different levels

!!! warning
    to send different messages

!!! danger
    to your reader

!!! tip "Wow!"
    Turns out that admonitions can be pretty useful!
    What will you use them for?


## Tables
| Column One | Column Two | Column Three |
|:---------- | ---------- |:------------:|
| Row `1`    | Column `2` |              |
| *Row* 2    | **Row** 2  | Column ``3`` |


# Model description



