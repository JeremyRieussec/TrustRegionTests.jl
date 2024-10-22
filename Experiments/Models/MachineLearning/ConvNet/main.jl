

## Si premiere utilisation !!!!
# Mise a jour des packages
include("..\\..\\miseAjourPackage.jl")

# General initialisation for Mnist
include("..\\initialisation.jl")

# initialisation des packages necessaires for conv Net
include("initialisation.jl")

#### Backend for plots
# gr()
plotlyjs()

# Saving
include("..\\..\\saveConfig.jl")


testConfig = "testConfigurationConvNets.json"
io = open(testConfig, "w")

write(io, "\n#################### Test MNIST : Convolutional Network ############################## \n")

####################################################################################
##################### Choix modele #################
####################################################################################
TYPE = Float32

lenet = ChainConvNet{TYPE}(Conv(5,5,1,20),
                Conv(5,5,20,50),
                Dense(800,500,pdrop=0.0),
                Dense(500,10,identity,pdrop=0.0))

myModel = lenet

#### sauvegarde ####
setting = full_setting_model(myModel)
println(setting)
write(io, setting)
####################################################################################
                ############# initialisation ##############
####################################################################################
dist = Normal(5,20)

random = true

write(io , "\n### Initilisation ### \n")

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
mnistModel = MnistModel(myModel, x0 , dtrn, dtst)

####################################################################################
                        # Tests
####################################################################################

 alltests = AllTests(mnistModel, mnistModel.x0)
include("..\\Tests\\main.jl")

 println("###################")
 println(alltests)
 println("###################")

 print("Are the tests fine ?  (y/n)")
 while true
    n = readline()
    if (n=="y")
       break
    elseif (n=="n")
       error("Redefine your tests.. See you later!!")
    else
       println("Wrong entry.. press (y or n) and then press enter")
    end
 end

 # F normal
 @eval (Sofia.F(x::Vector, mo::MnistModel; sample::AbstractVector{Int64} = 1:Nobs(mo)) = F_normal(x, mo; sample=sample))
 lancementAllTests(alltests.testsNormal, alltests)

 # F variance
 @eval (Sofia.F(x::Vector, mo::MnistModel; sample::AbstractVector{Int64} = 1:Nobs(mo)) = F_variance(x, mo; sample=sample))
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
for i in 1:length(alltests.all_settingNormal)
   write(io, alltests.all_settingNormal[i])
end

for i in 1:length(alltests.all_settingVariance)
   write(io, alltests.all_settingVariance[i])
end

####################################################################################
                        # Closing
####################################################################################
close(io)
