
include("Config2ndOrder.jl")


##############################################################################
                        # True Varaince
##############################################################################

                        # Test : BHHH (Naive Smoothing)

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.NaiveSmoothing()
# --- Sampling
commonVar = true
sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################

                        # Test  : BHHH (Cumulative)

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.CumulativeDecreaseSmoothing{Float64}(; maxIter=5)
# --- Sampling
commonVar = true
sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################

                        # Test  : BHHH (Cumulative)

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.CumulativeDecreaseSmoothing{Float64}(; maxIter=3)
# --- Sampling
commonVar = true
sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################

                        # Test  : BHHH (Cumulative)

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.CumulativeDecreaseSmoothing{Float64}(; maxIter=2)
# --- Sampling
commonVar = true
sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
addTest(test, alltests)
println(sam)


##############################################################################

                        # Test  : BHHH (No smoothing)

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.NoSmoothing()
# --- Sampling
commonVar = true

sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
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
sam = RandomSamplingDynamic(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
addTest(test, alltests)
println(sam)



##############################################################################

                        # Test  : BHHH

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}
# --- Smoothing
smoothing = Geraldine.NoSmoothing()
# --- Sampling
commonVar = true
sam = RandomSamplingDynamic(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# --- definition BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

# --- Adding to tests
test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
addTest(test, alltests)
println(sam)
