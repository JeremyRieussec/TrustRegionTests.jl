
include("Config1stOrder.jl")

#####################################################################################
                        # Sampling strategy

sizeBatch = 100
sam = RandomSampling(;N = sizeBatch, NMax=Nobs(mnistModel))

#####################################################################################
                            # Test Adam

state = AdamState(mnistModel.x0, sam)

α_adam = 1.0
β_1 = 0.9
β_2 = 0.999

algo = AdamConstStep(α_adam, β_1, β_2)
# Creation test
test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# Enregistrement test
addTest(test, alltests);
#
# #####################################################################################
#                             # Test Adam
#
# state = AdamState(mnistModel.x0, sam)
#
# α_adam = 0.5
# β_1 = 0.9
# β_2 = 0.999
#
# algo = AdamConstStep(α_adam, β_1, β_2)
# # Creation test
# test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# # Enregistrement test
# addTest(test, alltests);

#####################################################################################
                            # Test Adam

# definition state
state = AdamState(mnistModel.x0, sam)
# Parameters
α_adam = 0.1
β_1 = 0.9
β_2 = 0.999
# Algo definition
algo = AdamConstStep(α_adam, β_1, β_2)
# Creation test
test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# Enregistrement test
addTest(test, alltests);

#####################################################################################
                            # Test Adam

# definition state
state = AdamState(mnistModel.x0, sam)
# Parameters
α_adam = 0.01
β_1 = 0.9
β_2 = 0.999
# Algo definition
algo = AdamConstStep(α_adam, β_1, β_2)
# Creation test
test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# Enregistrement test
addTest(test, alltests);

#####################################################################################
                        #   Test Adam

state = AdamState(mnistModel.x0, sam)

α_adam = 0.001
β_1 = 0.9
β_2 = 0.999

algo = AdamConstStep(α_adam, β_1, β_2)
# Creation test
test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# Enregistrement test
addTest(test, alltests);

#####################################################################################
                        #   Test Adam

state = AdamState(mnistModel.x0, sam)

α_adam = 0.0001
β_1 = 0.9
β_2 = 0.999

algo = AdamConstStep(α_adam, β_1, β_2)
# Creation test
test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# Enregistrement test
addTest(test, alltests);

# #####################################################################################
#                         #   Test Adam
#
# state = AdamState(mnistModel.x0, sam)
#
# α_adam = 0.00001
# β_1 = 0.9
# β_2 = 0.999
#
# algo = AdamConstStep(α_adam, β_1, β_2)
# # Creation test
# test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# # Enregistrement test
# addTest(test, alltests);

#####################################################################################

# # Test SGD
#
# state = SGDState(mnistModel.x0, sam)
#
# α_sgd = 2.0
#
# algo = SGDConstStep(α_sgd)
# # Creation test
# test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# # Enregistrement test
# addTest(test, alltests);
#
# #####################################################################################
#                             # Test SGD
#
# state = SGDState(mnistModel.x0, sam)
#
# α_sgd = 1.0
# algo = SGDConstStep(α_sgd)
# # Creation test
# test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# # Enregistrement test
# addTest(test, alltests);
#
# #####################################################################################
#                             # Test SGD
#
# state = SGDState(mnistModel.x0, sam)
#
# α_sgd = 0.5
#
# algo = SGDConstStep(α_sgd)
# # Creation test
# test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# # Enregistrement test
# addTest(test, alltests);
#
# #####################################################################################
#                             # Test SGD
#
# state = SGDState(mnistModel.x0, sam)
#
# α_sgd = 0.1
#
# algo = SGDConstStep(α_sgd)
# # Creation test
# test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# # Enregistrement test
# addTest(test, alltests);
#
# #####################################################################################
#                             # Test SGD
#
# state = SGDState(mnistModel.x0, sam)
#
# α_sgd = 0.01
#
# algo = SGDConstStep(α_sgd)
# # Creation test
# test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# # Enregistrement test
# addTest(test, alltests);
#
# #####################################################################################
#                             # Test SGD
#
# state = SGDState(mnistModel.x0, sam)
#
# α_sgd = 0.001
#
# algo = SGDConstStep(α_sgd)
# # Creation test
# test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# # Enregistrement test
# addTest(test, alltests);
#
# #####################################################################################
#                             # Test SGD
#
# state = SGDState(mnistModel.x0, sam)
#
# α_sgd = 0.0001
#
# algo = SGDConstStep(α_sgd)
# # Creation test
# test = FirstOrderTest(state, sam, algo, sp; verbose = verbose);
# # Enregistrement test
# addTest(test, alltests);
