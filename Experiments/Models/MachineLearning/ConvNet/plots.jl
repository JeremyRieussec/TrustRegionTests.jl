
lines = [:solid, :dot, :dash, :dashdot]
extension = "ConvNet.html"

####################################################################################
p = plot(xlabel="iterations", ylabel="Accuracy on test set (%)", legend=:outertopright)

for i in 1:length(alltests.testsVariance)
   plot!(alltests.all_dataVariance[i].IterAccumulator, alltests.all_accuracy_testVariance[i],
           label = alltests.all_legendVariance[i], line=lines[i%4 + 1])
end

for i in 1:length(alltests.testsNormal)
   plot!(alltests.all_dataNormal[i].IterAccumulator, alltests.all_accuracy_testNormal[i],
       label = alltests.all_legendNormal[i], line=lines[i%4 + 1])
end

fileName = "comparaison_all_methods_iter"
savefig(p, string(fileName, extension))
