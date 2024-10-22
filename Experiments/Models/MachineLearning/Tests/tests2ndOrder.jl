
include("Config2ndOrder.jl")


##############################################################################
                    # Examples
##############################################################################

# --- Hessian Approx
# Hessian = Geraldine.BHHHScores{TYPE} ---> BHHH classic
# Hessian = Geraldine.DiagBHHHApprox{TYPE} ---> BHHH diag approx
# Hessian = Geraldine.IdentityApprox{TYPE} ---> SGD Trust-region
# Hessian = Geraldine.DiagAdamApprox{TYPE}

# --- Smoothing
# smoothing = Geraldine.NoSmoothing()
# smoothing = Geraldine.CumulativeDecreaseSmoothing{Float64}(; maxIter=3)
# smoothing = Geraldine.NaiveSmoothing()

# --- Sampling

# True variance / Random :
# commonVar = true
# sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
#                                                     commonVar = commonVar,
#                                                     smoothing=smoothing,
#                                                     subSampling=subSampling)
#
#

##############################################################################
                        # True Variance
##############################################################################

                        # Test : BHHH

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}

# --- Smoothing
# smoothing = Geraldine.NoSmoothing()
# smoothing = Geraldine.CumulativeDecreaseSmoothing{Float64}(; maxIter=3)
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

                        # Test : BHHH

# --- Hessian Approx
Hessian = Geraldine.BHHHScores{TYPE}

# --- Smoothing
# smoothing = Geraldine.NoSmoothing()
# smoothing = Geraldine.CumulativeDecreaseSmoothing{Float64}(; maxIter=3)
smoothing = Geraldine.NaiveSmoothing()

# --- Sampling
commonVar = false
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
#
#                         # Test : BHHH
#
# # --- Hessian Approx
# Hessian = Geraldine.BHHHScores{TYPE}
#
# # --- Smoothing
# # smoothing = Geraldine.NoSmoothing()
# # smoothing = Geraldine.CumulativeDecreaseSmoothing{Float64}(; maxIter=3)
# smoothing = Geraldine.NaiveSmoothing()
#
# # --- Sampling
# commonVar = true
# sam = TrueVarDynamicSAA(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
#                                                     smoothing=smoothing,
#                                                     subSampling=subSampling)
# # --- definition BTR
# mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);
#
# # --- Adding to tests
# test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
# addTest(test, alltests)
# println(sam)



##############################################################################

#                         # Test : BHHH
#
# # --- Hessian Approx
# Hessian = Geraldine.BHHHScores{TYPE}
#
# # --- Smoothing
# smoothing = Geraldine.NoSmoothing()
#
# # --- Sampling
# commonVar = true
# sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
#                                                     commonVar = commonVar,
#                                                     smoothing=smoothing,
#                                                     subSampling=subSampling)
# # --- definition BTR
# mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);
#
# # --- Adding to tests
# test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
# addTest(test, alltests)
# println(sam)


##############################################################################
                    # Test 2: DiagBHHH

# Hessian
Hessian = Geraldine.DiagBHHHApprox{TYPE}

smoothing = Geraldine.NaiveSmoothing()

commonVar = true
sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)

mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
addTest(test, alltests)
println(sam)


##############################################################################
                    # Test 2: DiagBHHH

# Hessian
Hessian = Geraldine.DiagBHHHApprox{TYPE}

smoothing = Geraldine.NaiveSmoothing()

commonVar = false
sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)

mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################
                                # Test 3

# # Hessian
# Hessian = Geraldine.IdentityApprox{TYPE}
# # Smoothing
# smoothing = Geraldine.NaiveSmoothing()
# # Sampling
# commonVar = true
# sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
#                                                     commonVar = commonVar,
#                                                     smoothing=smoothing,
#                                                     subSampling=subSampling)
# # BTR
# mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);
# # Tests definition
# test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
# addTest(test, alltests)
# println(sam)

##############################################################################
#                                 # Test 4
#
# # Hessian
# Hessian = Geraldine.DiagAdamApprox{TYPE}
# # Smoothing
# smoothing = Geraldine.NaiveSmoothing()
# # Sampling
# commonVar = true
# sam = RandomSamplingDynamicTrueVariance(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
#                                                     commonVar = commonVar,
#                                                     smoothing=smoothing,
#                                                     subSampling=subSampling)
# # BTR
# mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);
# # test definition
# test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
# addTest(test, alltests)
# println(sam)

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
sam = RandomSamplingDynamic(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);
# adding test
test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
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
sam = RandomSamplingDynamic(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)
# BTR
mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);
# adding test
test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################
                    # Test 2: DiagBHHH

# Hessian
Hessian = Geraldine.DiagBHHHApprox{TYPE}

smoothing = Geraldine.NaiveSmoothing()

commonVar = true
sam = RandomSamplingDynamic(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)

mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
addTest(test, alltests)
println(sam)


##############################################################################
                    # Test 2: DiagBHHH

# Hessian
Hessian = Geraldine.DiagBHHHApprox{TYPE}

smoothing = Geraldine.NaiveSmoothing()

commonVar = false
sam = RandomSamplingDynamic(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
                                                    commonVar = commonVar,
                                                    smoothing=smoothing,
                                                    subSampling=subSampling)

mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);

test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
addTest(test, alltests)
println(sam)

##############################################################################

#                             # Test 1
#
# # Hessian
# Hessian = Geraldine.BHHHScores{TYPE}
# # Smoothing
# smoothing = Geraldine.NoSmoothing()
# # Sampling
# commonVar = true
# sam = RandomSamplingDynamic(NMin = NMin, NMax = Nobs(mnistModel), N0=N0, increment=increment,
#                                                     commonVar = commonVar,
#                                                     smoothing=smoothing,
#                                                     subSampling=subSampling)
# # BTR
# mybtr = BTRStruct(;sam = typeof(sam), Hessian = Hessian, eps = epsilonOptimisation, Nmax = IterMax, TMax = TMax);
# # adding test
# test = SecondOrderTest(mybtr, sam, btrCoeffs; verbose = verbose);
# addTest(test, alltests)
# println(sam)
