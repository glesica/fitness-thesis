# Configuration

const TRIALS_PER_RUN = 50
const N_VALUE = 15
const K_VALUES = [0, 3, 6, 9, 12]
const POP_SIZE = 1000
const GENS_PER_TRIAL = 1000
const MORAN_ITERS = [200, 400, 800, 1000]
const MUT_PROB = 0.1
const CHECK_INTERVAL = 100

include("tortoise-hare.jl")

println(STDERR, "nworkers = ", nworkers())

jobs = [Job(trial, N_VALUE, k, POP_SIZE, GENS_PER_TRIAL, moran, MUT_PROB, CHECK_INTERVAL)
    for trial = 1:TRIALS_PER_RUN, moran = MORAN_ITERS, k = K_VALUES]

println(STDERR, "njobs = ", length(jobs))

tic()

results = pmap(runjob, jobs)

elapsed = toq()
println(STDERR, "nseconds = ", elapsed)

printheader()
for result = results
  printresult(result)
end
