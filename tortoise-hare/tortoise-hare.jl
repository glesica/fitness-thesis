using DataFrames

import NKLandscapes
const NK = NKLandscapes

println("trial,gen,n,k,moran,pop,minfit,maxfit,meanfit")

function run(trial, n, k, popsize, gens, moran)
  ls = NK.NKLandscape(n, k)
  pop = rand(NK.Population, ls, popsize)

  fits = NK.popfits(pop, ls)
  meanfit = fits |> mean

  minfit, maxfit = NK.fitrange(ls)
  println("$(trial),$(1),$(n),$(k),$(moran),$(popsize),$(minfit),$(maxfit),$(meanfit)")

  for gen = 2:gens
    # Selection
    #imax = indmax(fits)
    #for i = 1:NK.popsize(pop)
    #  pop[:,i] = pop[:,imax]
    #end
    NK.moransel!(pop, ls, moran)

    # Mutation
    NK.bsmutate!(pop, ls, 0.1)

    # Update
    fits = NK.popfits(pop, ls)

    # Logging
    if (gen % 100 == 0)
      meanfit = fits |> mean
      println("$(trial),$(gen),$(n),$(k),$(moran),$(popsize),$(minfit),$(maxfit),$(meanfit)")
    end
  end
end

for k = [0, 2, 4, 6, 8, 10, 12, 14]
  for moran = [100 * x for x = 1:10]
    for trial = 1:50
      run(trial, 15, k, 1000, 1000, moran)
    end
  end
end

