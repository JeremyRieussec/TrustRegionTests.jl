
##################################################
verbose = false

IterMax = 8000
TMax = 900.0

epsOptimisation = 10^(-10)

sp = Geraldine.StopParam(;NMax = IterMax, TMax = TMax, tol = epsOptimisation);
