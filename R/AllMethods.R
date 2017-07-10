## 1. Generic Functions
## 1a. Overrides

setMethod("show",
         signature(object = "StabilizeEntropy"),
         function(object) {
             if (!length(object@min.criterion))
                 warning("StabilizeEntropy object has not stabilized.")
             cat("StabilizeEntropy object with parameters: \n")
             cat(" step.size: ", object@step.size , "\n")
             cat("max.length: ", object@max.length, "\n")
             cat("every.word: ", object@every.word, "\n")
         }
         )

setMethod("summary",
          signature(object = "StabilizeEntropy"),
          function(object) {
              if (!length(object@min.criterion))
                  stop("StabilizeEntropy object has not stabilized.")
              cat("StabilizeEntropy object with parameters: \n")
              cat(" step.size: ", object@step.size , "\n")
              cat("max.length: ", object@max.length, "\n")
              cat("every.word: ", object@every.word, "\n")
              cat("-----------------------------------\n")
              cat("Size of the corpus: ", length(object@text), "\n")
              cat("Number of words where SD was minimized: ",
                  object@min.criterion, "\n")
          })
## don't really think this is needed
setGeneric('plot')
setMethod('plot',
          signature(x='StabilizeEntropy', y='missing'),
          definition = function(x, y, ...) {
              plot.stabilization(x, ...)
          })

## 1b. Generic of internal functions
setGeneric(name = "setText",
           def  = function(object, text) {
               standardGeneric("setText")
           })

setGeneric(name = "setStepSize",
           def  = function(object, step.size) {
               standardGeneric("setStepSize")
           })

setGeneric(name = "StabilizeCriterion",
           def  = function(object, method, rate) {
               standardGeneric("StabilizeCriterion")
           })

setGeneric(name = "setMaxLength",
           def  = function(object, max.length) {
               standardGeneric("setMaxLength")
           })

setGeneric(name = "setEveryWord",
           def  = function(object, every.word) {
               standardGeneric("setEveryWord")
           })

setGeneric(name = "Stabilize",
           def  = function(object, verbose, random) {
               standardGeneric("Stabilize")
           })

setGeneric(name = "get.stabilization",
           def  = function(object) {
               standardGeneric("get.stabilization")
           })

setGeneric(name = "get.criterion",
           def  = function(object) {
               standardGeneric("get.criterion")
           })

## 2. Init method

setMethod(f          = "initialize",
          signature  = "StabilizeEntropy",
          definition = function(.Object, ..., text, step.size, max.length,
                                every.word) {
              .Object@text       <- text
              .Object@step.size  <- step.size
              .Object@max.length <- max.length
              .Object@every.word <- every.word
              .Object@cache.obj  <- new.env(TRUE, emptyenv())
              if (length(.Object@text) < .Object@max.length) {
                  warning(paste("The size of the text is smaller than the",
                                "maximum length. Setting max.length to the",
                                "size of the text"))
                  .Object@max.length <- length(.Object@text)
              }
              if (validObject(.Object))
                  return(.Object)
          })

## 3. Custom methods

setMethod(f          = "setText",
          signature  = "StabilizeEntropy",
          definition = function(object, text) {
              object@text <- text
              if (validObject(object))
                  return(object)
          })
setMethod(f          = "setStepSize",
          signature  = "StabilizeEntropy",
          definition = function(object, step.size) {
              object@step.size <- step.size
              if (validObject(object))
                  return(object)
          })

setMethod(f          = "setMaxLength",
          signature  = "StabilizeEntropy",
          definition = function(object, max.length) {
              object@max.length <- max.length
              if (validObject(object))
                  return(object)
          })

setMethod(f          = "setEveryWord",
          signature  = "StabilizeEntropy",
          definition = function(object, every.word) {
              object@every.word <- every.word
              if (validObject(object))
                  return(object)
          })

setMethod(f          = "Stabilize",
          signature  = "StabilizeEntropy",
          definition = function(object, verbose) {
              return(.Stabilize(text = object@text, step.size = object@step.size,
                               cache.obj = object@cache.obj, every.word = object@every.word,
                               max.length = object@max.length, verbose = verbose))
          })

setMethod(f          = "StabilizeCriterion",
          signature  = "StabilizeEntropy",
          definition = function(object, method, rate) {
              return(.StabilizeCriterion(object@stabilization, method, rate))
          })

setMethod(f          = "get.stabilization",
          signature  = "StabilizeEntropy",
          definition = function(object) {
              return(object@stabilization)
          })

setMethod(f          = "get.criterion",
          signature  = "StabilizeEntropy",
          definition = function(object) {
              return(object@stabilization.criterion)
          })
