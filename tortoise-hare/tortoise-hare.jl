import NKLandscapes
const NK = NKLandscapes

function run(n, k, popsize)
  ls = NK.NKLandscape(n, k)
  pop = rand(NK.Population, ls, popsize)
  println("G = ", 1, ", N = ", n, ", K = ", k, ", F = ", NK.popfits(pop, ls) |> mean)
  for gen = 2:1000
    fits = NK.popfits(pop, ls)
    imax = indmax(fits)
    for i = 1:NK.popsize(pop)
      pop[:,i] = pop[:,imax]
    end
    NK.bsmutate!(pop, ls)
  end
  println("G = ", 1000, ", N = ", n, ", K = ", k, ", F = ", NK.popfits(pop, ls) |> mean)
end

run(15, 0, 1000)

