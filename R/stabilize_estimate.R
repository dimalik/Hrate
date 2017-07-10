#' Get stabilization estimate
#'
#' \code{stabilize.estimate} is used to find the minimum size of text
#' needed to get a stable entropy rate.
#'
#' @param text Character vector. Preferably this should be read with
#'     \code{\link{read.file}} to take care of preprocessing. Note
#'     that internally this uses a regular expression for the matching
#'     so in non-ASCII texts it might be unstable. In those cases it
#'     is recommended to \code{\link{normalize}} the text beforehand.
#' @param step.size A numeric scalar. Pre-specifies the step sizes at
#'     which entropy rates are computed. Warning: smaller values
#'     increase the computation time.
#' @param max.length A numeric scalar. How many tokens of the
#'     \code{text} should be read? Defaults to the length of the text.
#' @param every.word A numeric scalar. "every.word=1" specifies that
#'     each word token should be used for estimation. To speed up
#'     processing only every 2nd, 3rd, nth word token could be used.
#'     Hence, every.word can be assigned any integer between 1 and the
#'     step size.
#' @param downsampling.rate A numeric scalar.
#' @param verbose Boolean. Whether or not to display progress.
#' @return \code{stabilize.estimate} returns an object of class \code{\link{Stabilize}}.
#'
#' @examples
#' data(deuparl)
#' ce <- stabilize.estimate(deuparl, step.size = 1000, max.length = 10000, every.word = 10, method = "downsample", rate = 5, verbose = TRUE)
#' @seealso \code{\link{Stabilize}}, \code{\link{StabilizeCriterion}}
stabilize.estimate <- function(text, step.size, max.length = length(text),
                              every.word = 10, method = "downsample", rate = 5,
                              verbose = TRUE) {
    ce <- new("StabilizeEntropy", text = text, step.size = step.size,
              max.length = max.length, every.word = every.word)
    estimate <- Stabilize(ce, verbose = verbose)
    ce@stabilization <- estimate
    criterion <- StabilizeCriterion(ce, method, rate)
    ce@stabilization.criterion <- criterion
    ce@min.criterion <- criterion[which.min(criterion$SD), "Corpus.Size"]
    return(ce)
}

#' Get single stabilization estimate
#'
#' \code{get.estimate} is used to return a single entropy rate
#' estimate for a given text.
#'
#' @param text A character vector. Preferably this should be read with
#'     \code{\link{read.file}} to take care of preprocessing. Note
#'     that internally this uses a regular expression for the matching
#'     so in non-ASCII texts it might be unstable. In those cases it
#'     is recommended to \code{\link{normalize}} the text beforehand.
#' @param max.length A numeric scalar. How many elements from
#'     \code{text} should be read? Defaults to the length of the text.
#' @param every.word A numeric scalar. "every.word=1" specifies that
#'     each word token should be used for estimation. To speed up
#'     processing only every 2nd, 3rd, xth word token could be used.
#'     Hence, every.word can be assigned any integer between 1 and the
#'     step size.
#' @return A numeric scalar. This is the entropy rate on the given
#'     chunk of text.
#' @examples
#' data(deuparl)
#' est <- get.estimate(deuparl, max.length = 10000, every.word = 10)
#' @seealso \code{\link{PreprocessText}}, \code{\link{read.file}}, \code{\link{IsSubstring}}
get.estimate <- function(text, max.length = length(text),
                         every.word = 10) {
    if (is.null(max.length))
        max.length <- length(text)
    return(.GetEntropyRate(.GetSingleEstimate(text, max.length, every.word),
                           max.length, every.word))
}
