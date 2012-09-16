rm(list=ls(all=TRUE))
source("D:/Nihar Shah/My Documents/Course Work/Ph D/Spring 06/Math 552/Project/PowerStudyClass.R")
P = PowerTest(sSize=c(1000, 1000), sMean=c(0, 0.1), sSigma=c(1, 1), errType="II", N=1000)
reps = 1000;
pKW = rep(0, reps);
pAnova = rep(0, reps);

for (i in 1:reps)
{
	if(i%%50 == 0)
	{
		cat(gettextf("i = %i\n", i))
	}
	P$setSampleParams(sSize=c(1000, 1000, 1000), sMean=c((1/i), (1/i)^2, (1/i)^3), sSigma=c(1, 1, 1))
	P$runTest()
	pKW[i] = mean(P$empKWPw <= P$alpha)
	pAnova[i] = mean(P$empAnovaPw <= P$alpha)
}