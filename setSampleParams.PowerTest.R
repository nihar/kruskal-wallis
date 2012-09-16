#---------------------------------------------------------------------------
# setSampleParams.PowerTest.R
# Set the sample parameters and generate new groups
# @param sSize A vector containing the size of each sample
# @param sMean A vector containing the mean of each sample
# @param sSigma A vector containing the standard deviation of each sample
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("setSampleParams", "PowerTest", 
			appendVarArgs = FALSE, 
			function(this, sSize, sMean, sSigma)
{
	checkSampleStats(sSize = sSize, 
			sMean = sMean, sSigma = sSigma);
	this$sampleSizes = sSize;
	this$mu0 = sMean;
	this$sigma = sSigma;
	this$numberOfSamples = length(sSize);
	this$groups = generateGroups.PowerTest();
});

#---------------------------------------------------------------------------