push!(LOAD_PATH,"../src/")

using Documenter, TrustRegionTests

makedocs(
    sitename = "TrustRegionTests"
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#= deploydocs(
    repo = "github.com/JeremyRieussec/TrustRegionTests.jl.git",
    devbranch = "main",
) =#
