
include("Config1stOrder.jl")

##################### Accumulator ######################
Accum_1st(xstar::Vector = [0.0, 1, 1, 2, 3, 5, 8, 13, 21, 34]) = Accumulator(Value(), Iter(), NGrad(), Times(), DistTo(xstar), Geraldine.Param())


sizeBatch = 100
sam = RandomSampling(;N = sizeBatch, NMax=Nobs(mo))


#####################################################################################
                            # Test Adam

# definition state
state = AdamState(x0, sam)
# Parameters
α_adam = 0.01
β_1 = 0.9
β_2 = 0.999
# Algo definition
algo = AdamConstStep(α_adam, β_1, β_2)
# Creation test
accumulator = Accum_1st(xstar)
test = FirstOrderTest(state, sam, algo, accumulator, sp; verbose = verbose);
# Enregistrement test
addTest(test, alltests);

#####################################################################################
                        #   Test Adam

state = AdamState(x0, sam)

α_adam = 0.0001
β_1 = 0.9
β_2 = 0.999

algo = AdamConstStep(α_adam, β_1, β_2)
# Creation test
accumulator = Accum_1st(xstar)
test = FirstOrderTest(state, sam, algo, accumulator, sp; verbose = verbose);
# Enregistrement test
addTest(test, alltests);

#####################################################################################
                            # Test Adam

state = AdamState(x0, sam)

α_adam = 0.5
β_1 = 0.9
β_2 = 0.999

algo = AdamConstStep(α_adam, β_1, β_2)
# Creation test
accumulator = Accum_1st(xstar)
test = FirstOrderTest(state, sam, algo, accumulator, sp; verbose = verbose);
# Enregistrement test
addTest(test, alltests);

#####################################################################################
                            # Test Adam

state = AdamState(x0, sam)

α_adam = 1.0
β_1 = 0.9
β_2 = 0.999

algo = AdamConstStep(α_adam, β_1, β_2)
# Creation test
accumulator = Accum_1st(xstar)
test = FirstOrderTest(state, sam, algo, accumulator, sp; verbose = verbose);
# Enregistrement test
addTest(test, alltests);

#####################################################################################
#                             # Test SGD
#
# state = SGDState(x0, sam)
#
# α_sgd = 0.01
#
# algo = SGDConstStep(α_sgd)
# # Creation test
# accumulator = Accum_1st(xstar)
# test = FirstOrderTest(state, sam, algo, accumulator, sp; verbose = verbose);
# # Enregistrement test
# addTest(test, alltests);

# #####################################################################################
#                             # Test SGD
#
# state = SGDState(x0, sam)
#
# α_sgd = 0.5
#
# algo = SGDConstStep(α_sgd)
# # Creation test
# accumulator = Accum_1st(xstar)
# test = FirstOrderTest(state, sam, algo, accumulator, sp; verbose = verbose);
# # Enregistrement test
# addTest(test, alltests);
#
#
# #####################################################################################
#                             # Test SGD
#
# state = SGDState(x0, sam)
#
# α_sgd = 1.0
#
# algo = SGDConstStep(α_sgd)
# # Creation test
# accumulator = Accum_1st(xstar)
# test = FirstOrderTest(state, sam, algo, accumulator, sp; verbose = verbose);
# # Enregistrement test
# addTest(test, alltests);
