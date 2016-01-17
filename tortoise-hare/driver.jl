include("tortoise-hare.jl")

# Configuration

const TRIALS_PER_RUN = 50
const N_VALUE = 15
const K_VALUES = [0, 3, 6, 9, 12]
const P_VALUES = [0.1, 0.3, 0.5, 0.7, 0.9]
const POP_SIZE = 1000
const GENS_PER_TRIAL = 1000
const MORAN_ITERS = [200, 400, 800, 1000]
const MUT_PROB = 0.1
const CHECK_INTERVAL = 100

println(STDERR, "nworkers = ", nworkers())

nkjobs = [NKJob(trial, POP_SIZE, GENS_PER_TRIAL, moran, MUT_PROB,
    CHECK_INTERVAL, N_VALUE, k)
    for trial = 1:TRIALS_PER_RUN, moran = MORAN_ITERS, k = K_VALUES]

nkpjobs = [NKpJob(trial, POP_SIZE, GENS_PER_TRIAL, moran, MUT_PROB,
    CHECK_INTERVAL, N_VALUE, k, p)
    for trial = 1:TRIALS_PER_RUN, moran = MORAN_ITERS, k = K_VALUES, p = P_VALUES]

println(STDERR, "njobs = ", length(nkjobs) + length(nkpjobs))

tic()

nkresults = pmap(runjob, nkjobs)
nkpresults = pmap(runjob, nkpjobs)

elapsed = toq()
println(STDERR, "nseconds = ", elapsed)

printheader()
for result = nkresults
  printresult(result)
end
for result = nkpresults
  printresult(result)
end
