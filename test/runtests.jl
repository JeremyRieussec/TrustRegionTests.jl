using Test 
using TrustRegionTests

@testset "Basics " begin
    @test TrustRegionTests.greet() === nothing
end;

### Imprecise tests
# As calculations on floating-point values can be imprecise, you can perform approximate equality checks 
@testset "Imprecision test: " begin
    @test 1 ≈ 0.999999  rtol=1e-5
end;

include("unit-tests/main.jl")

