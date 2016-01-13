# Remote processes
addprocs(
  [("evotech1", :auto), ("evotech2", :auto)],
  tunnel=true, dir="/home/glesica", topology=:master_slave)

# Local processes
addprocs(3, topology=:master_slave)
