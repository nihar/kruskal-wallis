#---------------------------------------------------------------------------
# generateSampleData.PowerTest.R
# Method that generates sample data for the Monte Carlo simulation
# @param sSize A vector containing the size of each sample
# @param sMean A vector containing the mean of each sample
# @param sSigma A vector containing the standard deviation of each sample
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("generateSampleData", "PowerTest", private = TRUE, 
			appendVarArgs = FALSE, 
			function(this, sSize, sMean, sSigma)
{
	X = rnorm(sSize[1], sMean[1], sSigma[1]);
	for (i in 2:this$numberOfSamples)
	{
		X = c(X, rnorm(sSize[i], sMean[i], sSigma[i]));
	}
	return (X)
});

#---------------------------------------------------------------------------
