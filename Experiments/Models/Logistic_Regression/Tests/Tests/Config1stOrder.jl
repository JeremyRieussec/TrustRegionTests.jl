
##################################################
verbose = false

IterMax = 10000
TMax = 300.0

epsOptimisation = 10^(-6)

sp = Geraldine.StopParam(;NMax = IterMax, TMax = TMax, tol = epsOptimisation);
