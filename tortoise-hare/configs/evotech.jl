# Remote processes
addprocs(
  [("evotech1", :auto), ("evotech2", :auto)],
  tunnel=true, dir="/home/glesica", topology=:master_slave)

# Local processes
addprocs(CPU_CORES - 1, topology=:master_slave)

# Configuration
const TRIALS_PER_RUN = 50
const N_VALUE = 15
const K_VALUES = [0, 3, 6, 9, 12]
const P_VALUES = [0.1, 0.3, 0.5, 0.7, 0.9]
const POP_SIZE = 1000
const POP_COUNTS = [1, 5, 10]
const GENS_PER_TRIAL = 1000
const MORAN_ITERS = [200, 400, 800, 1000]
const MUT_PROB = 0.1
const CHECK_INTERVAL = 100
