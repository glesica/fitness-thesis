# Local processes
addprocs(CPU_CORES - 1, topology=:master_slave)

# Configuration
const TRIALS_PER_RUN = 1
const N_VALUE = 15
const K_VALUES = [0, 6, 12]
const P_VALUES = [0.1, 0.9]
const POP_SIZE = 1000
const GENS_PER_TRIAL = 1000
const MORAN_ITERS = [200, 800]
const MUT_PROB = 0.1
const CHECK_INTERVAL = 100

