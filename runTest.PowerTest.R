#---------------------------------------------------------------------------
# runTest.PowerTest.R
# Run the Monte Carlo simulation for the specified number of iterations
# @param N The number of iterations for Monte Carlo simulation
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("runTest", "PowerTest", 
			appendVarArgs = FALSE, function(this, N = 100)
{
	generateGroups.PowerTest(this);
	this$empAnovaPw = rep(0, N);
	this$empKWPw = rep(0, N);
	for (i in 1:N)
	{
		X = generateSampleData.PowerTest(this,
				sSize=this$sampleSizes, 
				sMean=this$mu0, sSigma=this$sigma);
		aTest = summary(aov(X ~ this$groups));
		kruskal = kruskal.test(X, this$groups);
		this$empKWPw[i] = kruskal$p.value;
		this$empAnovaPw[i] = aTest[[1]][["Pr(>F)"]][1];
	}
});

#---------------------------------------------------------------------------
