#---------------------------------------------------------------------------
# generateGroups.PowerTest.R
# Generates groups with headings according to the number of treatments
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("generateGroups", "PowerTest", private = TRUE,
			appendVarArgs = FALSE, function(this)
{
	if (this$numberOfSamples < 2)
	{
		throw("Can not have less than 2 treatments for testing");
	}
	label = "Treatment 1";
	cols = this$sampleSizes[1];
	for(i in 2:this$numberOfSamples)
	{
		label = c(label, paste("Treatment ", i));
		cols = c(cols, this$sampleSizes[i]);
	}
	this$groups <- factor(rep(1:this$numberOfSamples, cols), labels=label)
});

#---------------------------------------------------------------------------
