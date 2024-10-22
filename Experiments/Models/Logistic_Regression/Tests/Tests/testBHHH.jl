
include("Config2ndOrder.jl")


Accum_2nd_tv(xstar::Vector = [0.0, 1, 1, 2, 3, 5, 8, 13, 21, 34]) = Accumulator(Value(), Iter(),
                FieldAccumulator{Float64}(:fcand), Delta(), Times(), SamplingSizeAccumulator(), DistTo(xstar),
                FieldAccumulator{Float64}(:mu), FieldAccumulator{Float64}(:sigma2), FieldAccumulator{Float64}(:sHs) ,
                FieldAccumulator{Float64}(:ρ),  FieldAccumulator{Float64}(:iterCG), IsAcceptedAccumulator(), Param())

Accum_2nd_sHs(xstar::Vector = [0.0, 1, 1, 2, 3, 5, 8, 13, 21, 34]) = Accumulator(Value(), Iter(),
                FieldAccumulator{Float64}(:fcand), Delta(), Times(), SamplingSizeAccumulator(), DistTo(xstar),
                FieldAccumulator{Float64}(:mu),  FieldAccumulator{Float64}(:sHs) ,
                FieldAccumulator{Float64}(:ρ),  FieldAccumulator{Float64}(:iterCG), IsAcceptedAccumulator(), Param())


##############################################################################
TYPE = Float64

##############################################################################
                        # True Varaince
##############################################################################

                    # Test : BHHH (Naive Smoothing)

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.NoSmoothing()
# --- Sampling
commonVar = true
sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                            commonVar = commonVar,
                            smoothing=smoothing,
                            subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
accumulator = Accum_2nd_tv(xstar)
test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################

                        # Test : BHHH (Naive Smoothing)

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.NaiveSmoothing()
# --- Sampling
commonVar = true
sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
accumulator = Accum_2nd_tv(xstar)
test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################

                        # Test  : BHHH (Cumulative)

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.NaiveSmoothing()
# smoothing = Geraldine.CumulativeDecreaseSmoothing{Float64}(; maxIter=5)
# --- Sampling
commonVar = false
sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
accumulator = Accum_2nd_tv(xstar)
test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################

                        # Test  : BHHH (Cumulative)

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.NaiveSmoothing()
# smoothing = Geraldine.CumulativeDecreaseSmoothing{Float64}(; maxIter=3)
# --- Sampling
sam = TrueVarDynamicSAA(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
accumulator = Accum_2nd_tv(xstar)
test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)
println(sam)


##############################################################################
                        # Variance Approximation
##############################################################################

                        # Test  : BHHH

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.NaiveSmoothing()
# --- Sampling
commonVar = true
sam = RandomSamplingDynamic(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
accumulator = Accum_2nd_sHs(xstar)
test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################

                        # Test  : BHHH

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.NaiveSmoothing()
# --- Sampling
commonVar = false
sam = RandomSamplingDynamic(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
accumulator = Accum_2nd_sHs(xstar)
test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################

                        # Test  : BHHH

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.NaiveSmoothing()
# --- Sampling
sam = DynamicSAA(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
accumulator = Accum_2nd_sHs(xstar)
test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)
println(sam)
