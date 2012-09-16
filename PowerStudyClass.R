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
	checkSampleParams.PowerTest(sSize = sSize, 
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


#---------------------------------------------------------------------------
# checkAlpha.PowerTest.R
# Method that checks value of alpha
# @param alpha The value of alpha to be checked
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("checkAlpha", "PowerTest", private = TRUE,
			appendVarArgs = FALSE, createGeneric = FALSE,
			function(this, alpha)
{
	if(any(alpha <= 0, alpha >= 1))
	{
		throw("Significance level must be between 0 and 1");
	}
	return (TRUE);
});

#---------------------------------------------------------------------------


#---------------------------------------------------------------------------
# checkErrorType.PowerTest.R
# Method to check the error type value
# @param errType The value of error type to be checked
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("checkErrorType", "PowerTest", private = TRUE,
			createGeneric = FALSE, appendVarArgs = FALSE, 
			function(this, errType)
{
	if(!any(errType == "I", errType == "II"))
	{
		throw("Error has to be set to Type I or Type II only");
	}
});	

#---------------------------------------------------------------------------


#---------------------------------------------------------------------------
# checkSampleParams.PowerTest.R
# Check the consistency in sizes of vectors for sample sizes, sample means,
# and sample standard deviations
# @param sSize A vector containing the size of each sample
# @param sMean A vector containing the mean of each sample
# @param sSigma A vector containing the standard deviation of each sample
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("checkSampleParams", "PowerTest", private = TRUE,
			appendVarArgs = FALSE, createGeneric = FALSE,
			function(this, sSize, sMean, sSigma)
{
	if(length(sSize) != length(sMean) &	length(sSize) != length(sSigma))
	{
		throw("Number of samples should be consistent");
	}
});

#---------------------------------------------------------------------------


#---------------------------------------------------------------------------
# displayResults.PowerTest.R
# Displays the results of the Monte Carlo simulation and formats 
# according to the type of error rate being determined.
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("displayResults", "PowerTest", 
			appendVarArgs = FALSE, createGeneric = FALSE,
			function(this)
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


#---------------------------------------------------------------------------
# generateGroups.PowerTest.R
# Generates groups with headings according to the number of treatments
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("generateGroups", "PowerTest", private = TRUE,
			appendVarArgs = FALSE, createGeneric = FALSE,
			function(this)
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


#---------------------------------------------------------------------------
# generateSampleData.PowerTest.R
# Method that generates sample data for the Monte Carlo simulation
# @param sSize A vector containing the size of each sample
# @param sMean A vector containing the mean of each sample
# @param sSigma A vector containing the standard deviation of each sample
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("generateSampleData", "PowerTest", private = TRUE, 
			appendVarArgs = FALSE, createGeneric = FALSE,
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

#---------------------------------------------------------------------------
# runTest.PowerTest.R
# Run the Monte Carlo simulation for the specified number of iterations
# @param N The number of iterations for Monte Carlo simulation
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("runTest", "PowerTest", 
			appendVarArgs = FALSE, createGeneric = FALSE,
			function(this, N = 100)
{
	generateGroups.PowerTest(this);
	this$empAnovaPw = rep(0, N);
	this$empKWPw = rep(0, N);
	for (i in 1:N)
	{
		X = generateSampleData.PowerTest(this,
				sSize=this$sampleSizes, 
				sMean=this$mu0, sSigma=this$sigma);
		aTest = summary(aov(X ~ this$groups));
		kruskal = kruskal.test(X, this$groups);
		this$empKWPw[i] = kruskal$p.value;
		this$empAnovaPw[i] = aTest[[1]][["Pr(>F)"]][1];
	}
});

#---------------------------------------------------------------------------


#---------------------------------------------------------------------------
# setAlpha.PowerTest.R
# Set the value of alpha
# @param alpha The significance level for the tests
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("setAlpha", "PowerTest", 
			appendVarArgs = FALSE, createGeneric = FALSE,
			function(this, alpha)
{
	if(checkAlpha(alpha))
	{
		this$alpha = alpha;
	}
});

#---------------------------------------------------------------------------


#---------------------------------------------------------------------------
# setErrorType.PowerTest.R
# Sets the type of error to be determined
# @param errType The type of error to be determined
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("setErrorType", "PowerTest", 
			appendVarArgs = FALSE, createGeneric = FALSE,
			function(this, errType)
{
	checkErrorType.PowerTest(errType = errType);
	this$errorType = errType;
});

#---------------------------------------------------------------------------


#---------------------------------------------------------------------------
# setSampleParams.PowerTest.R
# Set the sample parameters and generate new groups
# @param sSize A vector containing the size of each sample
# @param sMean A vector containing the mean of each sample
# @param sSigma A vector containing the standard deviation of each sample
# @author Nihar Shah
#---------------------------------------------------------------------------

setMethodS3("setSampleParams", "PowerTest", 
			appendVarArgs = FALSE, createGeneric = FALSE,
			function(this, sSize, sMean, sSigma)
{
	checkSampleParams.PowerTest(this, sSize = sSize, 
			sMean = sMean, sSigma = sSigma);
	this$sampleSizes = sSize;
	this$mu0 = sMean;
	this$sigma = sSigma;
	this$numberOfSamples = length(sSize);
	this$groups = generateGroups.PowerTest(this);
});

#---------------------------------------------------------------------------