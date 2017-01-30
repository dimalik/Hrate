ConvergeEntropy <- setClass(
    ## ConvergeEntropy class
    ##
    ## This is mainly a delegating class encapsulating the logic of
    ## the simulations. Concretely, it estimates the _entropy rate_
    ## for different text sizes by repeatedly calling
    ## GetSingleEstimate then uses those estimate to find the
    ## convergence point. It also holds helper printing and plotting
    ## methods.
    ##
    ## Args:
    ##   text (character): A character vector to use as corpus
    ##   step.size (numeric): The size of each chunk of corpus to consider
    ##   max.length (numeric): The total size of the text to consider
    ##   every.word (numeric): Every how many words should it compute
    ##      the entropy rate (reduces computation time)
    "ConvergeEntropy",
    slots = c(
        text                  = "character",
        step.size             = "numeric",
        max.length            = "numeric",
        every.word            = "numeric",
        cache.obj             = "environment",
        convergence           = "data.frame",
        convergence.criterion = "data.frame",
        min.criterion         = "numeric"
    ),

    prototype = list(
        step.size  = 100,
        max.length = 100000,
        every.word = 10
    ),

    validity = function(object) {
        if (!class(object@text) == "character")
            return("You should pass a character vector.")
        if (length(object@text) < object@every.word)
            return(paste("The size of the text does not contain",
                         "enough words to do the steps."))
        if (object@step.size > object@max.length)
            return(paste("The size of the step cannot be larger",
                         "than the total length of the text"))
        return(TRUE)
    })
