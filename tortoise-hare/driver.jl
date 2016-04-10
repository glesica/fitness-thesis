include("tortoise-hare.jl")
include("output.jl")

println("nworkers = ", nworkers())

nkjobs = [NKJob(trial, POP_SIZE, popct, GENS_PER_TRIAL, moran, MUT_PROB,
    CHECK_INTERVAL, N_VALUE, k)
    for trial = 1:TRIALS_PER_RUN, popct = POP_COUNTS, moran = MORAN_ITERS, k = K_VALUES]

nkpjobs = [NKpJob(trial, POP_SIZE, popct, GENS_PER_TRIAL, moran, MUT_PROB,
    CHECK_INTERVAL, N_VALUE, k, p)
    for trial = 1:TRIALS_PER_RUN, popct = POP_COUNTS, moran = MORAN_ITERS, k = K_VALUES, p = P_VALUES]

println("njobs = ", length(nkjobs) + length(nkpjobs))

tic()

nkresults = pmap(runjob, nkjobs)
nkpresults = pmap(runjob, nkpjobs)

elapsed = toq()
println("nseconds = ", elapsed)

fio = open("run-$(now()).csv", "w")

printheader(fio)
for result = nkresults
  printresult(fio, result)
end
for result = nkpresults
  printresult(fio, result)
end
