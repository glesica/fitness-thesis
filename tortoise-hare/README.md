# Tortoise and Hare Experiment

Options that must be passed to the `julia` executable to launch a run:

  * `-L configs/<config>` - the type of simulation run to execute. The
    `<config>` file is responsible for setting up whatever processors / machines
    are to be used, and specifying some simulation constants. See the files in
    the `configs` directory for examples.

## Examples

A full run on the EvoTech cluster, this will take a while. Run the commands
from `pardosa`. In this case we use `nohup` so that a dropped SSH connection
won't kill the run. The status output can be found in the file `nohup.out`
after the run is finished.

```
$ nohup julia -L configs/evotech.jl driver.jl &
```

A test run on the local machine only. This is useful for testing changes to the
code before commits. Note that we don't use `nohup` here because we probably
want to see the output as it runs.

```
$ julia -L configs/dev.jl driver.jl
```

## Results

Results will be written to a file named `run-<timestamp>.csv`, where
`<timestamp>` is something that looks like this: `2016-01-17T12:47:23`.

