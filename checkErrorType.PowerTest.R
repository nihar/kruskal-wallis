#---------------------------------------------------------------------------
# checkErrorType.PowerTest.R
# Method to check the error type value
# @param errType The value of error type to be checked
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("checkErrorType", "PowerTest", private = TRUE,
			appendVarArgs = FALSE, function(this, errType)
{
	if(!any(errType == "I", errType == "II"))
	{
		throw("Error has to be set to Type I or Type II only");
	}
});	

#---------------------------------------------------------------------------
