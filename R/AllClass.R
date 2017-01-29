ConvergeEntropy <- setClass(
    "ConvergeEntropy",
    slots = c(
        text                  = "character",
        step.size             = "numeric",
        max.length            = "numeric",
        every.word            = "numeric",
        H.est                 = "numeric",
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
        if (length(object@text) < object@every.word ||
            length(object@text) < object@max.length)
            stop("The size of the text is too small.")
        return(TRUE)
    })
