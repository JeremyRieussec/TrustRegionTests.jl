#####################################################################################
# Optimisation
verbose = false

IterMax = 10000 # Nombre iterations maximales
TMax = 1800.0 # Temps max en secondes
epsilonOptimisation = 10^(-6) # Precision norme gradient

# Sampling init
N0 = 100
NMin = 50
increment = 2;

# subSampling
coeff_bhhh = 0.25
maxBhhh = 10000
subSampling = ConstantCoeffSubSampling(maxBhhh, coeff_bhhh)

#btrCoeffs = Geraldine.BTRDefaults() # avec 4*‖s‖
btrCoeffs = Geraldine.BTRDefaultsCoeff() # avec expension de γ_3 pour iteration tres reussie
