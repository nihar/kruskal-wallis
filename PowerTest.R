#---------------------------------------------------------------------------
# PowerTest.R
# Creates an object of type PowerTest with default parameters
# @param alpha The significance level for the tests
# @param N The number of iterations for Monte Carlo simulation
# @param sSize A vector containing the size of each sample
# @param sMean A vector containing the mean of each sample
# @param sSigma A vector containing the standard deviation of each sample
# @param errType The type of error to be tested
# @author Nihar Shah
#---------------------------------------------------------------------------

setConstructorS3("PowerTest", function(alpha = 0.05, N = 100, 
				sSize = c(100, 100), 
				sMean = c(0, 0), 
				sSigma = c(1, 1), 
				errType = "I", ...)
{
	checkAlpha.PowerTest(alpha=alpha)
	checkSampleStats.PowerTest(sSize = sSize, 
				sMean = sMean, sSigma = sSigma);
	checkErrorType.PowerTest(errType = errType);
	extend(Object(), "PowerTest",
		alpha = alpha,
		N = N,
		numberOfSamples = length(sSize),
		sampleSizes = sSize,
		mu0 = sMean,
		sigma = sSigma,
		errorType = errType, 
		empAnovaPw = rep(0, N),
		empKWPw = rep(0, N),
		groups = NULL);
});

#---------------------------------------------------------------------------
