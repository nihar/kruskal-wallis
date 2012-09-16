P = PowerTest(errType="II", N=1000)
reps = 100;
pKW = rep(0, reps);
pAnova = rep(0, reps);

for (i in 1:reps)
{
	if(i%%10 == 0)
	{
		cat(gettextf("i = %i\n", i))
	}
	P$setSampleParams(sSize=c(1000, 1000), 
			sMean=c(-(1/i^2), (1/i^2)), 
			sSigma=c(1, 1))
	P$runTest()
	pKW[i] = mean(P$empKWPw <= P$alpha)
	pAnova[i] = mean(P$empAnovaPw <= P$alpha)
}