#---------------------------------------------------------------------------
# setErrorType.PowerTest.R
# Sets the type of error to be determined
# @param errType The type of error to be determined
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("setErrorType", "PowerTest", 
			appendVarArgs = FALSE, function(this, errType)
{
	checkErrorType.PowerTest(errType = errType);
	this$errorType = errType;
});

#---------------------------------------------------------------------------