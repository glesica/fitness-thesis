import NKLandscapes
@everywhere const NK = NKLandscapes

@everywhere immutable Job
  trial::Int64     # Trial number
  n::Int64
  k::Int64
  popsize::Int64   # Population size
  gens::Int64      # Generations
  moran::Int64     # Moran iterations
  mutprob::Float64 # Mutation probability
  checkint::Int64  # Checkpoint interval
end

@everywhere immutable JobCheckpoint
  gen::Int64       # Generation number
  minfit::Float64  # Generation min fit
  maxfit::Float64  # Generation max fit
  meanfit::Float64 # Generation mean fit
end

@everywhere immutable JobResult
  job::Job
  globmin::Float64           # Global min fitness
  globmax::Float64           # Global max fitness
  checks::Vector{JobCheckpoint}
end

@everywhere function runjob(job::Job)
  res::JobResult

  ls = NK.NKLandscape(job.n, job.k)
  pop = rand(NK.Population, ls, job.popsize)

  globmin, globmax = NK.fitrange(ls)

  checks = JobCheckpoint[]

  fits = NK.popfits(pop, ls)
  push!(checks, JobCheckpoint(
    1,
    fits |> minimum,
    fits |> maximum,
    fits |> mean))

  for gen = 2:job.gens
    # Selection
    NK.moransel!(pop, ls, job.moran)

    # Mutation
    NK.bsmutate!(pop, ls, job.mutprob)

    # Checkpoint
    if (gen % job.checkint == 0)
      fits = NK.popfits(pop, ls)
      push!(checks, JobCheckpoint(
        gen,
        fits |> minimum,
        fits |> maximum,
        fits |> mean))
    end
  end

  res = JobResult(
    job,
    globmin,
    globmax,
    checks)

  return res
end

@everywhere function printheader()
  println("trial,gen,n,k,moran,mutprob,popsize,globmin,globmax,minfit,maxfit,meanfit")
end

@everywhere function printresult(result::JobResult)
  for check = result.checks
    println("$(result.job.trial),$(check.gen),$(result.job.n),$(result.job.k),",
      "$(result.job.moran),$(result.job.mutprob),$(result.job.popsize),$(result.globmin),",
      "$(result.globmax),$(check.minfit),$(check.maxfit),$(check.meanfit)")
  end
end
