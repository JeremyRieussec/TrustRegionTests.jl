


## Si premiere utilisation !!!!
# Mise a jour des packages
# include("..\\..\\miseAjourPackage.jl")

# General initialisation for Mnist
include("..\\initialisation.jl")

# initialisation des packages necessaires for conv Net
include("initialisation.jl")

#### Backend for plots
# gr()
plotlyjs()

# Saving
include("..\\..\\saveConfig.jl")


testConfig = "testConfigurationMLP.json"
io = open(testConfig, "w")

write(
   io,
   "\n#################### Test MNIST : Multilayer Perceptron ############################## \n",
)

####################################################################################
##################### Choix modele #################
####################################################################################
# Choix du modele
TYPE = Float64

##################### definition du modele #################
smallModel = ChainMLP{TYPE}(Layer1(784, 10, identity))

mediumModel = ChainMLP{TYPE}(Layer1(784, 100, relu), Layer1(100, 10, identity))
mediumModelSigm =
   ChainMLP{TYPE}(Layer1(784, 100, sigm), Layer1(100, 10, identity))

mediumModel2 = ChainMLP{TYPE}(
   Layer1(784, 100, relu),
   Layer1(100, 50, relu),
   Layer1(50, 10, identity),
)
mediumModelSigm2 = ChainMLP{TYPE}(
   Layer1(784, 100, sigm),
   Layer1(100, 50, sigm),
   Layer1(50, 10, identity),
)

bigModel = ChainMLP{TYPE}(
   Layer1(784, 500, relu),
   Layer1(500, 100, relu),
   Layer1(100, 10, identity),
)
bigModelSigm = ChainMLP{TYPE}(
   Layer1(784, 500, sigm),
   Layer1(500, 100, sigm),
   Layer1(100, 10, identity),
)


veryBigModel = ChainMLP{TYPE}(
   Layer1(784, 600, relu),
   Layer1(600, 500, relu),
   Layer1(500, 400, relu),
   Layer1(400, 300, relu),
   Layer1(300, 200, relu),
   Layer1(200, 100, relu),
   Layer1(100, 10, identity),
)
veryBigModelSigm = ChainMLP{TYPE}(
   Layer1(784, 600, sigm),
   Layer1(600, 500, sigm),
   Layer1(500, 400, sigm),
   Layer1(400, 300, sigm),
   Layer1(300, 200, sigm),
   Layer1(200, 100, sigm),
   Layer1(100, 10, identity),
);

##########  Choix modele ###############
myModel = mediumModel2

#### sauvegarde ####
setting = full_setting_model(myModel)
println(setting)
write(io, setting)

####################################################################################
############# initialisation ##############
####################################################################################
dist = Normal(5, 20)

random = false

write(io, "\n### Initilisation ### \n")

x0 = create_vector(myModel)

if random
   # ---- Random ----
   write(io, " -- Random : $(dist)\n")
   rand!(dist, x0)
else
   write(io, " -- Xavier uniform \n")
end
####################################################################################
####### definition du modele #######
####################################################################################
mnistModel = MnistModel(myModel, x0, dtrn, dtst)

####################################################################################
# Tests
####################################################################################

alltests = AllTests(mnistModel, mnistModel.x0)
include("..\\Tests\\main.jl")
# include("..\\Tests\\tests1stOrder.jl")

println("###################")
println(alltests)
println("###################")
print("Are the tests fine ?  (y/n)")
while true
   n = readline()
   if (n == "y")
      break
   elseif (n == "n")
      error("Redefine your tests.. See you later!!")
   else
      println("Wrong entry.. press (y or n) and then press enter")
   end
end


# F normal
@eval (
   Sofia.F(
      x::Vector,
      mo::MnistModel;
      sample::AbstractVector{Int64} = 1:Nobs(mo),
   ) = F_normal(x, mo; sample = sample)
)
lancementAllTests(alltests.testsNormal, alltests)

# F variance
@eval (
   Sofia.F(
      x::Vector,
      mo::MnistModel;
      sample::AbstractVector{Int64} = 1:Nobs(mo),
   ) = F_variance(x, mo; sample = sample)
)
lancementAllTests(alltests.testsVariance, alltests)

####################################################################################
# Plots
####################################################################################


try
   include("plots.jl")
catch e
   println("Check your plots.. Something is wrong..")
end

####################################################################################
# Saving infos
####################################################################################

for i = 1:length(alltests.all_settingVariance)
   write(io, alltests.all_settingVariance[i])
end

for i = 1:length(alltests.all_settingNormal)
   write(io, alltests.all_settingNormal[i])
end

####################################################################################
# Closing
####################################################################################
close(io)
