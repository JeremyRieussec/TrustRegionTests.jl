
#####################################################################################
# Optimisation
verbose = false

IterMax = 10000
TMax = 900.0 # 15 minutes
epsilonOptimisation = 10^(-10)

# Sampling init
N0 = 100
NMin = 50
increment = 2;

# subSampling
coeff_bhhh = 0.1
maxBhhh = 2000
subSampling = ConstantCoeffSubSampling(maxBhhh, coeff_bhhh)

#btrCoeffs = Geraldine.BTRDefaults() # avec 4*‖s‖
btrCoeffs = Geraldine.BTRDefaultsCoeff() # avec expension de γ_3 pour iteration tres reussie
