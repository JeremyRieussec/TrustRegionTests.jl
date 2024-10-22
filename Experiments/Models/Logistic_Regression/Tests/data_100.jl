
const nalt = 5
const Dim = 100

df = DataFrame(CSV.File("Logit\\L100.csv", limit = 100_000))
const nInd = size(df, 1)

data = Amlet.LinedObs(Array(Array(df)'), nalt)

mo = Amlet.LogitModel(Amlet.LinUti, data, upd = false);
