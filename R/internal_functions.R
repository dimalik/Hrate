.Converge <- function(text, step.size, max.length, cache.obj, every.word,
                      verbose) {
    ## Get entropy estimates over variable sized chunks of text
    ##
    ## Args:
    ##   text (character): Character vector containing the text to
    ##   calculate the entropy on.
    ##   step.size (numeric): The size of each chunk
    ##   max.length (numeric): The maximum length of the text to
    ##   consider.
    ##   every.word (numeric): Every how many word should it compute
    ##   (reduces computation time).
    ##   cache.obj (environment): provides a HashMap-like
    ##   environment to save previous results.
    ##   verbose (bool): Whether or not to print debugging information
    ##
    ## Returns:
    ##   data.frame: The entropy estimates over different chunks of
    ##   text
    H.i.vec <- c()
    result <- list()
    iter <- 0
    for (n in seq(step.size, max.length, step.size)) {
        iter <- iter + 1
        if (verbose)
            message(sprintf("%.2f%%: Setting size of corpus at %i words",
                            iter / (max.length / step.size) * 100, n))
        est <- GetSingleEstimate(text       = text,
                                 max.length = n,
                                 every.word = every.word,
                                 cache.obj  = cache.obj)
        H.i.vec <- c(H.i.vec, est)                  
        H.est <- sum(H.i.vec) / (round(n / every.word, digits = 0))
        result[[iter]] <- c(n, H.est)
    }
    df <- data.frame(t(sapply(result, c)))
    colnames(df) <- c("Corpus.Size", "Entropy")
    return(df)
}


.ConvergeCriterion <- function(x, downsampling.rate = 2) {
    ## Get SDs of the downsampled entropy estimates
    ##
    ## Args:
    ##   x (data.frame): Character vector containing the text to
    ##   calculate the entropy on.
    ##   downsampling.rate (numeric)
    ##
    ## Returns:
    ##   data.frame: The SDs over different chunks of text
    nGroups <- nrow(x) / downsampling.rate
    eachGroup <- nrow(x) / nGroups
    x$group <- rep(1:nGroups, each = eachGroup)
    SD <- aggregate(Entropy ~ group, data=x, sd)$Entropy
    corpus.size <- aggregate(Corpus.Size ~ group, data=x, max)$Corpus.Size
    return(data.frame(Corpus.Size = corpus.size, SD = SD))
}
