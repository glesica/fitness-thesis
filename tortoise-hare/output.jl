# Output functions

function printheader(io)
  println(io, "trial,gen,n,k,p,moran,mutprob,popsize,globmin,globmax,minfit,maxfit,meanfit")
end

function printresult(io, res::JobResult)
  for check = res.checks
    println(io, "$(res.job.trial),",
      "$(check.gen),",
      "$(res.job.nvalue),",
      "$(res.job.kvalue),",
      "$(pvalue(res)),",
      "$(res.job.moran),",
      "$(res.job.mutprob),",
      "$(res.job.popsize),",
      "$(res.globmin),",
      "$(res.globmax),",
      "$(check.minfit),",
      "$(check.maxfit),",
      "$(check.meanfit)")
  end
end

function printresult(io, exc::RemoteException)
  throw(exc)
end

pvalue(res::JobResult{NKJob}) = "NA"
pvalue(res::JobResult{NKpJob}) = res.job.pvalue

