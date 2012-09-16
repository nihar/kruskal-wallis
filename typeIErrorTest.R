P = PowerTest(errType = "I", N = 1000)

P$setSampleParams(sSize = c(10, 10, 10), 
		sMean = c(0, 0, 0), sSigma = c(1, 1, 1))
P$runTest()
P$displayResults()

P$setSampleParams(sSize = c(1000, 1000, 1000), 
		sMean = c(0, 0, 0), sSigma = c(1, 1, 1))
P$runTest()
P$displayResults()

P$setSampleParams(sSize = c(1000, 1000, 1000), 
		sMean = c(0, 0, 0), sSigma = c(2, 2, 2))
P$runTest()
P$displayResults()

P$setSampleParams(sSize = c(1000, 1000, 1000), 
		sMean = c(0, 0, 0), sSigma = c(5, 5, 5))
P$runTest()
P$displayResults()

P$setSampleParams(sSize = c(1000, 1000, 1000), 
		sMean = c(0, 0, 0), sSigma = c(10, 10, 10))
P$runTest()
P$displayResults()

P$setSampleParams(sSize = c(1000, 1000, 1000), 
		sMean = c(0, 0, 0), sSigma = c(100, 100, 100))
P$runTest()
P$displayResults()
