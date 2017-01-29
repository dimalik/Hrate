setMethod("show",
         signature(object = "ConvergeEntropy"),
         function(object) {
             if (!length(object@min.criterion))
                 warning("ConvergeEntropy object has not converged.")
             cat("ConvergeEntropy object with parameters: \n")
             cat(" step.size: ", object@step.size , "\n")
             cat("max.length: ", object@max.length, "\n")
             cat("every.word: ", object@every.word, "\n")
         }
)


setGeneric('plot')
setMethod('plot',
          signature(x='ConvergeEntropy', y='missing'),
          definition = function(x, y, ...) {
              plotConvergence(x, ...)
          })

setMethod(f          = "initialize",
          signature  = "ConvergeEntropy",
          definition = function(.Object, ..., text, step.size, max.length,
                                every.word) {
              .Object@text       <- text
              .Object@step.size  <- step.size
              .Object@max.length <- max.length
              .Object@every.word <- every.word
              .Object@cache.obj  <- new.env(TRUE, emptyenv())
              validObject(.Object)
              return(.Object)
          })

setGeneric(name = "setText",
           def  = function(object, text) {
               standardGeneric("setText")
           })

setMethod(f          = "setText",
          signature  = "ConvergeEntropy",
          definition = function(object, text) {
              object@text <- text
              validObject(object)
              return(object)
          })

setGeneric(name = "setStepSize",
           def  = function(object, step.size) {
               standardGeneric("setStepSize")
           })

setMethod(f          = "setStepSize",
          signature  = "ConvergeEntropy",
          definition = function(object, step.size) {
              object@step.size <- step.size
              validObject(object)
              return(object)
          })

setGeneric(name = "setMaxLength",
           def  = function(object, max.length) {
               standardGeneric("setMaxLength")
           })


setMethod(f          = "setMaxLength",
          signature  = "ConvergeEntropy",
          definition = function(object, max.length) {
              object@max.length <- max.length
              validObject(object)
              return(object)
          })


setGeneric(name = "setEveryWord",
           def  = function(object, every.word) {
               standardGeneric("setEveryWord")
           })

setMethod(f          = "setEveryWord",
          signature  = "ConvergeEntropy",
          definition = function(object, every.word) {
              object@every.word <- every.word
              validObject(object)
              return(object)
          })

setGeneric(name = "Converge",
           def  = function(object) {
               standardGeneric("Converge")
           })

setMethod(f          = "Converge",
          signature  = "ConvergeEntropy",
          definition = function(object) {
              return(.Converge(object@text, object@step.size,
                               object@max.length, object@cache.obj,
                               object@every.word))
          })

setGeneric(name = "ConvergeCriterion",
           def  = function(object, downsampling.rate) {
               standardGeneric("ConvergeCriterion")
           })

setMethod(f          = "ConvergeCriterion",
          signature  = "ConvergeEntropy",
          definition = function(object, downsampling.rate) {
              return(.ConvergeCriterion(object@convergence, downsampling.rate))
          })
