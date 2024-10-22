
# Functions for initialisation structure
import Knet.Train20.param, Knet.Train20.param0,  Knet.Train20.xavier_uniform

import Base.println, Base.write

# Some utilities to make model definitions easier:
param(d...; init=xavier_uniform, atype=array_type)=Knet.Param(atype(init(d...)))
param0(d...; atype=array_type)=param(d...; init=zeros, atype=atype)
xavier_uniform(o,i) = (s = sqrt(2/(i+o)); 2s .* rand(o,i) .- s)


# Abstract structure for chains of Layers
abstract type AbstractChain{S} end
