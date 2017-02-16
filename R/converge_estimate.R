#' Get convergence estimate
#'
#' \code{converge.estimate} is used to find the minimum size of text
#' needed to get a stable entropy rate.
#'
#' @param text Character vector. Preferably this should be read with
#'     \code{readdile} to take care of preprocessing. Note
#'     that internally this uses a regular expression for the matching
#'     so in non-ASCII texts it might be unstable. In those cases it
#'     is recommended to \code{normalize} the text beforehand.
#' @param step.size A numeric scalar. Every how many words should an
#'     estimate be computed? Warning: this can increase the
#'     computation time.
#' @param max.length A numeric scalar. How many elements from
#'     \code{text} should be read? Defaults to the length of the text.
#' @param every.word A numeric scalar.
#' @param downsampling.rate A numeric scalar.
#' @param verbose Boolean. Whether or not to display percentage done.
#'
#' @return `converge.estimate` returns an object of `class` `"Converge"`.
#'
#' An object of the class `"Converge"` has the following attributes:
#'
#' convergence: A data frame. 
#' min.criterion: The minimum SD value found.
#' convergence.criterion: A data frame
#'
#' @examples
#' data(deuparl)
#' ce <- converge.estimate(deuparl, step.size = 1000, max.length = 10000, every.word = 10, downsampling.rate = 5, verbose = TRUE)
converge.estimate <- function(text, step.size, max.length = length(text),
                              every.word = 10, downsampling.rate = 5,
                              verbose = TRUE) {
    ce <- new("ConvergeEntropy", text = text, step.size = step.size,
              max.length = max.length, every.word = every.word)
    estimate <- Converge(ce, verbose = verbose)
    ce@convergence <- estimate
    criterion <- ConvergeCriterion(ce, downsampling.rate)
    ce@convergence.criterion <- criterion
    ce@min.criterion <- criterion[which.min(criterion$SD), "Corpus.Size"]
    return(ce)
}

#' Get single convergence estimate
#'
#' \code{get.estimate} is used to return a single entropy rate
#' estimate for a given text.
#'
#' @param text Character vector. Preferably this should be read with
#'     \code{readdile} to take care of preprocessing. Note
#'     that internally this uses a regular expression for the matching
#'     so in non-ASCII texts it might be unstable. In those cases it
#'     is recommended to \code{normalize} the text beforehand.
#' @param max.length A numeric scalar. How many elements from
#'     \code{text} should be read? Defaults to the length of the text.
#'
#' @return A numeric scalar. This is the entropy rate on the given
#'     chunk of text.
#'
#' @examples
#' data(deuparl)
#' est <- get.estimate(deuparl, max.length = 10000)

get.estimate <- function(text, max.length = length(text),
                         every.word = 10) {
    if (is.null(max.length))
        max.length <- length(text)
    return(.GetEntropyRate(.GetSingleEstimate(text, max.length, every.word),
                           max.length, every.word))
}
