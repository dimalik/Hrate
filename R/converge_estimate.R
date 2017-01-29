convergeEstimate <- function(text, step.size, max.length, every.word,
                             downsampling.rate) {
    ce <- new("ConvergeEntropy", text=textfile, step.size=step.size,
              max.length=max.length , every.word=every.word)
    estimate <- Converge(ce)
    ce@convergence <- estimate
    criterion <- ConvergeCriterion(ce, downsampling.rate)
    ce@convergence.criterion <- criterion
    ce@min.criterion <- criterion[which.min(criterion$SD), "Corpus.Size"]
    ce
}
