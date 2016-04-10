import NKLandscapes
@everywhere const NK = NKLandscapes

@everywhere abstract Job

@everywhere immutable NKJob <: Job
  trial::Int64       # Trial number
  popsize::Int64     # Population size
  popct::Int64       # Population count
  gens::Int64        # Generations
  moran::Int64       # Moran iterations
  mutprob::Float64   # Mutation probability
  checkint::Int64    # Checkpoint interval
  nvalue::Int64      # N parameter
  kvalue::Int64      # K parameter
end

@everywhere immutable NKpJob <: Job
  trial::Int64       # Trial number
  popsize::Int64     # Population size
  popct::Int64       # Population count
  gens::Int64        # Generations
  moran::Int64       # Moran iterations
  mutprob::Float64   # Mutation probability
  checkint::Int64    # Checkpoint interval
  nvalue::Int64      # N parameter
  kvalue::Int64      # K parameter
  pvalue::Float64    # p parameter
end

@everywhere immutable JobCheckpoint
  gen::Int64       # Generation number
  minfit::Float64  # Generation min fit
  maxfit::Float64  # Generation max fit
  meanfit::Float64 # Generation mean fit
end

@everywhere immutable JobResult{T <: Job}
  job::T
  globmin::Float64           # Global min fitness
  globmax::Float64           # Global max fitness
  checks::Vector{JobCheckpoint}
end

@everywhere function runjob(job::Job)
  println("running: $(job)")

  res::JobResult

  ls = if typeof(job) == NKJob
    NK.NKLandscape(job.nvalue, job.kvalue)
  else
    NK.NKpLandscape(job.nvalue, job.kvalue, job.pvalue)
  end

  pop = if job.popct == 1
    rand(NK.Population, ls, job.popsize)
  else
    rand(NK.MetaPopulation, ls, job.popsize, job.popct)
  end

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

