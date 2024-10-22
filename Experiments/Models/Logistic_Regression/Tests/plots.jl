
plotlyjs()

lines = [:solid, :dot, :dash, :dashdot]
extension = "Logit.html"

####################################################################################
p = plot(xlabel="iterations", ylabel="Distance to solution", legend=:outertopright)

indicesVariance = 1:4
indicesNormal = 1:1

for i in indicesVariance
    plot!(p, alltests.all_dataVariance[i].IterAccumulator, alltests.all_dataVariance[i].DistTo,
                label = alltests.all_legendVariance[i], line=lines[i%4 + 1])
end


for i in indicesNormal
    plot!(p, alltests.all_dataNormal[i].IterAccumulator, alltests.all_dataNormal[i].DistTo,
                label = alltests.all_legendNormal[i], line=lines[i%4 + 1])
end

fileName = "comparaison_all_methods_distTo"
savefig(p, string(fileName, extension))

####################################################################################

indicesVariance = 1:4
indicesNormal = 1:1

p_sample = plot(xlabel="iterations", ylabel="Sample Size", legend=:outertopright)

for i in indicesVariance
    plot!(p_sample, alltests.all_dataVariance[i].IterAccumulator, alltests.all_dataVariance[i].SamplingSizeAccumulator,
        label = alltests.all_legendVariance[i],  line=lines[i%4 + 1])
end

for i in indicesNormal
    plot!(p_sample, alltests.all_dataNormal[i].IterAccumulator, alltests.all_dataNormal[i].SamplingSizeAccumulator,
                label = alltests.all_legendNormal[i],  line=lines[i%4 + 1])
end

fileName = "comparaison_all_methods_SampleSize"
savefig(p_sample, string(fileName, extension))


####################################################################################

indicesVariance = 1:4
indicesNormal = 1:1

p_delta = plot(xlabel="iterations", ylabel="delta (Δ)", legend=:outertopright)

for i in indicesVariance
    if alltests.all_dataVariance[i].IterAccumulator[end] > 1000
        plot!(p_delta, alltests.all_dataVariance[i].IterAccumulator[1:1000], alltests.all_dataVariance[i].DeltaAccumulator[1:1000],
            label = alltests.all_legendVariance[i],  line=lines[i%4 + 1])
    else
         plot!(p_delta, alltests.all_dataVariance[i].IterAccumulator, alltests.all_dataVariance[i].DeltaAccumulator,
            label = alltests.all_legendVariance[i],  line=lines[i%4 + 1])
    end
end

for i in indicesNormal
    if alltests.all_dataNormal[i].IterAccumulator[end] > 1000
        plot!(p_delta, alltests.all_dataNormal[i].IterAccumulator[1:1000], alltests.all_dataNormal[i].DeltaAccumulator[1:1000],
                label = alltests.all_legendNormal[i],  line=lines[i%4 + 1])
    else
        plot!(p_delta, alltests.all_dataNormal[i].IterAccumulator, alltests.all_dataNormal[i].DeltaAccumulator,
                label = alltests.all_legendNormal[i],  line=lines[i%4 + 1])
    end
end

fileName = "Delta"
savefig(p_delta, string(fileName, extension))


####################################################################################

indicesVariance = 1:4
indicesNormal = 1:1


p_dist = plot(xlabel="", ylabel="Distance to solution")

for i in indicesVariance
    plot!(p_dist, alltests.all_dataVariance[i].IterAccumulator, alltests.all_dataVariance[i].DistTo, label = "")
end

for i in indicesNormal
    plot!(p_dist, alltests.all_dataNormal[i].IterAccumulator, alltests.all_dataNormal[i].DistTo, label = "")
end

p_sample = plot(xlabel="iterations", ylabel="Sample Size")

for i in indicesVariance
    plot!(p_sample, alltests.all_dataVariance[i].IterAccumulator, alltests.all_dataVariance[i].SamplingSizeAccumulator, label = alltests.all_legendVariance[i])
end

for i in indicesNormal
    plot!(p_sample, alltests.all_dataNormal[i].IterAccumulator, alltests.all_dataNormal[i].SamplingSizeAccumulator, label = alltests.all_legendNormal[i])
end

p = plot(p_dist, p_sample, layout=(2,1), legend=:outertopright)

fileName = "SampleSize_DistTo"
savefig(p, string(fileName, extension))

####################################################################################



####################################################################################


####################################################################################
