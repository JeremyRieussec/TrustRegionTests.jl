
# Si premiere utilisation !!!!
# Mise a jour des packages
# include("miseAjourPackage.jl")

include("initialisationLogit.jl")

# fonctions sauvegarde
include("..\\saveConfig.jl")

testConfig = "testConfigurationLogit.json"
io = open(testConfig, "w")

include("data_10.jl");
# include("data_100.jl");
# include("data_1000.jl");


# point depart
x0 = zeros(Dim)

# for accumulator
xstar = genFibbomod(length(x0));

write(io, "############################## Logit size $(Dim)  ##################################\n \n")
write(io, " -> Size population = $(nInd)\n")
write(io, " -> Number alternatives = $(nalt)\n")
write(io, " -> x0 = $(x0) \n")
write(io, " -> x optimum = $(xstar)\n")


 alltests = AllTests(mo, x0)
 include("Tests\\main.jl")

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


  # F Normal
  function Sofia.F(x::Vector{T}, mo::Amlet.LogitModel{Amlet.NotUpdatable, D}; sample = 1:nInd, update::Bool = false) where {T, D}
      return Amlet.F_normal(x, mo; sample = sample)
  end

  lancementAllTests(alltests.testsNormal, alltests)


  # F variance
  function Sofia.F(x::Vector{T}, mo::Amlet.LogitModel{Amlet.NotUpdatable, D}; sample = 1:nInd, update::Bool = false) where {T, D}
      return Amlet.F_variance(x, mo; sample = sample)
  end

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
