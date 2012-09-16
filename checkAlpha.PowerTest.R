#---------------------------------------------------------------------------
# checkAlpha.PowerTest.R
# Method that checks value of alpha
# @param alpha The value of alpha to be checked
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("checkAlpha", "PowerTest",# private = TRUE, 
			appendVarArgs = FALSE, function(this, alpha)
{
	if(any(alpha <= 0, alpha >= 1))
	{
		throw("Significance level must be between 0 and 1");
	}
	return (TRUE);
});

#---------------------------------------------------------------------------
