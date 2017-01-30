converge.estimate <- function(text, step.size, max.length, every.word = 10,
                              downsampling.rate = 5, verbose = TRUE) {
    ce <- new("ConvergeEntropy", text=textfile, step.size=step.size,
              max.length=max.length , every.word=every.word)
    estimate <- Converge(ce, verbose = verbose)
    ce@convergence <- estimate
    criterion <- ConvergeCriterion(ce, downsampling.rate)
    ce@convergence.criterion <- criterion
    ce@min.criterion <- criterion[which.min(criterion$SD), "Corpus.Size"]
    ce
}

get.estimate <- function(text, max.length = NULL, every.word = 10) {
    if (is.null(max.length))
        max.length <- length(text)
    return(.GetEntropyRate(.GetSingleEstimate(text, max.length, every.word),
                           max.length, every.word))
}
