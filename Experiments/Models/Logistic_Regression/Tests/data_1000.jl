

const nalt = 5
const Dim = 1000

df = DataFrame(CSV.File("Logit\\L1000.csv", limit = 100_000))
const nInd = size(df, 1)

data = Amlet.LinedObs(Array(Array(df)'), nalt)

mo = Amlet.LogitModel(Amlet.LinUti, data, upd = false);
