# Remote processes
addprocs(
  [("evotech1", :auto), ("evotech2", :auto)],
  tunnel=true, dir="/home/glesica", topology=:master_slave)

# Local processes
addprocs(CPU_CORES - 1, topology=:master_slave)
