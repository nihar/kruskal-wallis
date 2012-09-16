#---------------------------------------------------------------------------
# checkSampleStats.PowerTest.R
# Check the consistency in sizes of vectors for sample sizes, sample means,
# and sample standard deviations
# @param sSize A vector containing the size of each sample
# @param sMean A vector containing the mean of each sample
# @param sSigma A vector containing the standard deviation of each sample
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("checkSampleStats", "PowerTest", private = TRUE,
			appendVarArgs = FALSE, 
			function(this, sSize, sMean, sSigma)
{
	if(any(length(sSize) != length(sMean), 
			length(sSize) != length(sSigma)))
	{
		throw("Number of samples should be consistent");
	}
});

#---------------------------------------------------------------------------
