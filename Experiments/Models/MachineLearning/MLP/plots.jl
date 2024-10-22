

lines = [:solid, :dot, :dash, :dashdot]
extension = "MLP.html"


indicesVariance = 1:2
indicesNormal = [1,2,5,6,7,8,9]

####################################################################################
p = plot(xlabel="iterations", ylabel="Accuracy on test set (%)", legend=:outertopright)

for i in indicesVariance
   plot!(alltests.all_dataVariance[i].IterAccumulator, alltests.all_accuracy_testVariance[i],
           label = alltests.all_legendVariance[i], line=lines[i%4 + 1])
end

for i in indicesNormal
   plot!(alltests.all_dataNormal[i].IterAccumulator, alltests.all_accuracy_testNormal[i],
       label = alltests.all_legendNormal[i], line=lines[i%4 + 1])
end

fileName = "comparaison_all_methods_iter"
savefig(p, string(fileName, extension))

####################################################################################

p = plot(xlabel="Time (s)", ylabel="Accuracy on test set (%)", legend=:outertopright)

for i in indicesVariance
    plot!(alltests.all_dataVariance[i].Times, alltests.all_accuracy_testVariance[i],
        label = alltests.all_legendVariance[i], line=lines[i%4 + 1])
end

for i in indicesNormal
    plot!(alltests.all_dataNormal[i].Times, alltests.all_accuracy_testNormal[i],
        label = alltests.all_legendNormal[i], line=lines[i%4 + 1])
end

fileName = "comparaison_all_methods_times"
savefig(p, string(fileName, extension))

####################################################################################

indicesVariance = 1:2
indicesNormal = 1:2

p_sample = plot(xlabel="iterations", ylabel="Sample Size", legend=:outertopright)

for i in indicesVariance
    plot!(p_sample, alltests.all_dataVariance[i].IterAccumulator, alltests.all_dataVariance[i].SamplingSizeAccumulator[1],
            label = alltests.all_legendVariance[i], line=lines[i%4 + 1])
end

for i in indicesNormal
    plot!(p_sample, alltests.all_dataNormal[i].IterAccumulator, alltests.all_dataNormal[i].SamplingSizeAccumulator[1],
        label = alltests.all_legendNormal[i], line=lines[i%4 + 1])
end

fileName = "SampleSizes"
savefig(p_sample, string(fileName, extension))

####################################################################################

indicesVariance = 1:2
indicesNormal = 1:2

p_delta = plot(xlabel="iterations", ylabel="Δ", legend=:outertopright)

for i in indicesVariance
    plot!(p_delta, alltests.all_dataVariance[i].IterAccumulator, alltests.all_dataVariance[i].DeltaAccumulator,
            label = alltests.all_legendVariance[i], line=lines[i%4 + 1])
end

for i in indicesNormal
    plot!(p_delta, alltests.all_dataNormal[i].IterAccumulator, alltests.all_dataNormal[i].DeltaAccumulator,
        label = alltests.all_legendNormal[i], line=lines[i%4 + 1])
end

fileName = "Delta_"
savefig(p_delta, string(fileName, extension))

####################################################################################

indicesVariance = 1:2
indicesNormal = 1:2

p_rho = plot(xlabel="iterations", ylabel="ρ", legend=:outertopright)

for i in indicesVariance
    plot!(p_rho, alltests.all_dataVariance[i].IterAccumulator[2:end], alltests.all_dataVariance[i].Field_ρ,
            label = alltests.all_legendVariance[i], line=lines[i%4 + 1])
end

for i in indicesNormal
    plot!(p_rho, alltests.all_dataNormal[i].IterAccumulator[2:end], alltests.all_dataNormal[i].Field_ρ,
        label = alltests.all_legendNormal[i], line=lines[i%4 + 1])
end

fileName = "Rho_iter_"
savefig(p_rho, string(fileName, extension))

####################################################################################

indicesVariance = 1:2
indicesNormal = 1:2

p_mu = plot(xlabel="iterations", ylabel="mu", legend=:outertopright)

for i in indicesVariance
    plot!(p_mu, alltests.all_dataVariance[i].IterAccumulator[2:end], alltests.all_dataVariance[i].Field_mu,
            label = alltests.all_legendVariance[i], line=lines[i%4 + 1])
end

for i in indicesNormal
    plot!(p_mu, alltests.all_dataNormal[i].IterAccumulator[2:end], alltests.all_dataNormal[i].Field_mu,
        label = alltests.all_legendNormal[i], line=lines[i%4 + 1])
end

fileName = "Mu_iter_"
savefig(p_mu, string(fileName, extension))

####################################################################################

indicesVariance = 1:2
indicesNormal = 1:2

p_mu = plot(xlabel="Time (s)", ylabel="mu", legend=:outertopright)

for i in indicesVariance
    plot!(p_mu, alltests.all_dataVariance[i].Times[2:end], alltests.all_dataVariance[i].Field_mu,
            label = alltests.all_legendVariance[i], line=lines[i%4 + 1])
end

for i in indicesNormal
    plot!(p_mu, alltests.all_dataNormal[i].Times[2:end], alltests.all_dataNormal[i].Field_mu,
        label = alltests.all_legendNormal[i], line=lines[i%4 + 1])
end

fileName = "Mu_time_"
savefig(p_mu, string(fileName, extension))

####################################################################################

indicesVariance = 1:2
# indicesNormal = [1]

p_var = plot(xlabel="iterations", ylabel="Variance", legend=:outertopright)

for i in indicesVariance
    index = i%4 + 1
    plot!(p_var, alltests.all_dataVariance[i].IterAccumulator[2:end], alltests.all_dataVariance[i].Field_sigma2,
            label = string(alltests.all_legendVariance[i], "-TV"), line=lines[index])
    plot!(p_var, alltests.all_dataVariance[i].IterAccumulator[2:end], alltests.all_dataVariance[i].Field_sHs,
                    label = string(alltests.all_legendVariance[i], "-sHs"), line=lines[index])
end

fileName = "Varaince_sHs_"
savefig(p_var, string(fileName, extension))


####################################################################################




####################################################################################
