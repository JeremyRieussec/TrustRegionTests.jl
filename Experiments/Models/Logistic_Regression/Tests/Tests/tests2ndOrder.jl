
include("Config2ndOrder.jl")


Accum_2nd_tv(xstar::Vector = [0.0, 1, 1, 2, 3, 5, 8, 13, 21, 34]) = Accumulator(Value(), Iter(),
                FieldAccumulator{Float64}(:fcand), Delta(), Times(), SamplingSizeAccumulator(), DistTo(xstar),
                FieldAccumulator{Float64}(:mu), FieldAccumulator{Float64}(:sigma2), FieldAccumulator{Float64}(:sHs) ,
                FieldAccumulator{Float64}(:ρ), IsAcceptedAccumulator(), Param())

Accum_2nd_sHs(xstar::Vector = [0.0, 1, 1, 2, 3, 5, 8, 13, 21, 34]) = Accumulator(Value(), Iter(),
                FieldAccumulator{Float64}(:fcand), Delta(), Times(), SamplingSizeAccumulator(), DistTo(xstar),
                FieldAccumulator{Float64}(:mu),  FieldAccumulator{Float64}(:sHs) ,
                FieldAccumulator{Float64}(:ρ), IsAcceptedAccumulator(), Param())




##############################################################################
                        # True Variance
##############################################################################
TYPE = Float64

##############################################################################
                                # Test Hessian

accumulator = Accum_2nd_tv(xstar)
# Hessian
Hessian = Geraldine.UncomputedHessian{Float64}
# Smoothing
smoothing = Geraldine.NaiveSmoothing()
# --- Sampling
commonVar = true
sam = TrueVarDynamicSAA(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
#                                                     commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)

mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)

#############################################################################
                                # Test Hessian

accumulator = Accum_2nd_tv(xstar)
# Hessian
Hessian = Geraldine.UncomputedHessian{Float64}
# Smoothing
smoothing = Geraldine.NaiveSmoothing()
# --- Sampling
commonVar = true
sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)

mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)


##############################################################################

                        # Test 1 : BHHH

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.NaiveSmoothing()
# --- Sampling
commonVar = true
sam = TrueVarDynamicSAA(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                                                    # commonVar = commonVar,
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

                        # Test 1 : BHHH

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
                    # Test 2: DiagBHHH

# Hessian
Hessian = Geraldine.DiagBHHHApprox{TYPE}

# smoothing = Geraldine.NoSmoothing()
# smoothing = Geraldine.CumulativeDecreaseSmoothing{Float64}(; maxIter=3)
smoothing = Geraldine.NaiveSmoothing()

commonVar = true
sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)

mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

accumulator = Accum_2nd_tv(xstar)
test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################
                                # Test 3

# Hessian
Hessian = Geraldine.IdentityApprox{TYPE}
# Smoothing
smoothing = Geraldine.NaiveSmoothing()
# Sampling
commonVar = true
sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);
# Tests definition
accumulator = Accum_2nd_tv(xstar)
test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################
                                # Test 4

# Hessian
Hessian = Geraldine.DiagAdamApprox{TYPE}
# Smoothing
smoothing = Geraldine.NaiveSmoothing()
# Sampling
commonVar = true
sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);
# test definition
accumulator = Accum_2nd_tv(xstar)
test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################
                    # Variance Approx (sHs)
##############################################################################

                            # Test 1

# Hessian
Hessian = Geraldine.BHHHScores{TYPE}
# Smoothing
smoothing = Geraldine.NaiveSmoothing()
# Sampling
commonVar = true
sam = RandomSamplingDynamic(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);
# adding test
accumulator = Accum_2nd_sHs(xstar)
test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################

                            # Test 1

# Hessian
Hessian = Geraldine.BHHHScores{TYPE}
# Smoothing
smoothing = Geraldine.NaiveSmoothing()
# Sampling
commonVar = false
sam = RandomSamplingDynamic(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);
# adding test
accumulator = Accum_2nd_sHs(xstar)
test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################
                        # Test BHHH

# Hessian
Hessian = Geraldine.BHHHScores{Float64}

smoothing = Geraldine.NaiveSmoothing()

commonVar = true
sam = DynamicSAA(NMin = NMin, NMax = Nobs(mo), N0=N0, increment=increment,
#                                                     commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)

mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# adding test
accumulator = Accum_2nd_sHs(xstar)
test = SecondOrderTest(mybtr, sam, btrCoeffs, accumulator; verbose = verbose);
addTest(test, alltests)
println(sam)
