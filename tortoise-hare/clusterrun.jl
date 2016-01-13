# Remote processes
addprocs(
  [("evotech1", :auto), ("evotech2", :auto)],
  tunnel=true, dir="/home/glesica", topology=:master_slave)
# Local processes
addprocs(3, topology=:master_slave)

include("tortoise-hare.jl")

println("nworkers = ", nworkers())

jobs = [Job(trial, 15, 0, 1000, 1000, 500, 0.1, 100) for trial = 1:20]
results = pmap(runjob, jobs)

printheader()
for result = results
  printresult(result)
end
