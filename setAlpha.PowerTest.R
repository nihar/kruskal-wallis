#---------------------------------------------------------------------------
# setAlpha.PowerTest.R
# Set the value of alpha
# @param alpha The significance level for the tests
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("setAlpha", "PowerTest", 
			appendVarArgs = FALSE, function(this, alpha)
{
	if(checkAlpha(alpha))
	{
		this$alpha = alpha;
	}
});

#---------------------------------------------------------------------------
