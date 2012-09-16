#---------------------------------------------------------------------------
# displayResults.PowerTest.R
# Displays the results of the Monte Carlo simulation and formats 
# according to the type of error rate being determined.
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("displayResults", "PowerTest", 
			appendVarArgs = FALSE, function(this)
{
	cat(gettextf("------------------------------------------\n"))
	cat(gettextf("Study of Type %s Error Rate\n", this$errorType))
	cat(gettextf("------------------------------------------\n"))
	cat(gettextf("Number of groups: \t%i\n", this$numberOfSamples))
	for (j in 1:this$numberOfSamples)
	{
		cat(gettextf("Group %i Statistics\n", j))
		cat(gettextf("\tSample size: \t%i\n", this$sampleSizes[j]))
		cat(gettextf("\tMean: \t\t%f\n", this$mu0[j]))
		cat(gettextf("\tStd Dev: \t%f\n", this$sigma[j]))
		cat(gettextf("\n"))
	}
	cat(gettextf("Number of replications: \t%i\n", this$N))
	cat(gettextf("Significance level: \t\t%1.3f\n\n", this$alpha))
	if(this$errorType == "I")
	{
		cat(gettextf("Type I Error (Kruskal Wallis): \t%1.4f\n", 
				mean(this$empKWPw < this$alpha)))
		cat(gettextf("Type I Error (ANOVA): \t\t%1.4f\n", 
				mean(this$empAnovaPw < this$alpha)))
	}
	else
	{
		cat(gettextf("Empirical Power (ANOVA): \t\t%1.4f\n", 
				mean(this$empAnovaPw < this$alpha)))
		cat(gettextf("Empirical Power (Kruskal-Wallis): \t%1.4f\n", 
				mean(this$empKWPw < this$alpha)))
	}
	cat(gettextf("------------------------------------------\n"))
});

#---------------------------------------------------------------------------
