.GetEntropyRate <- function(entropies, text.length, every.word) {
    return(sum(entropies) / (text.length %/% every.word))
}

.GetSingleEstimate <- function(text, max.length = length(text),
                               every.word = 10, cache.obj = NULL) {
    ## Get single entropy estimate from the text
    ##
    ## Args:
    ##   text (character): Character vector containing the text to
    ##   calculate the entropy on.
    ##   max.length (numeric): The maximum length of the text to
    ##   consider.
    ##   every.word (numeric): Every how many word should it compute
    ##   (reduces computation time).
    ##   ...: Arguments passed from `converge`. `H.i.vec` stores the
    ##   entropy estimates and `cache.obj` provides a HashMap-like
    ##   environment to save previous results.
    ##
    ## Returns:
    ##   numeric: The entropy estimate over the chunk of text
    ##   considered.
    H.i.vecs <- c()
    if (is.null(cache.obj))
        cache.obj <- new.env(TRUE, emptyenv())

    for (i in seq(every.word, max.length, every.word)) {
        ## keep track of how many subvectors match
        matches <- 0
        ## use memoized value if available
        if (ExistsInCache(i, cache.obj)) {
            matches <- matches + length(GetFromCache(i, cache.obj))
        } else {
            StoreInCache(i, c(), cache.obj)
            ## keep the fullstr in a buffer so that we don't
            ## repeatedly call paste
            txtbuf <- paste(text[1:(i - 1)], collapse = " ")
            for (l in 0:(i - 1)) {
                ## use memoized value if available
                if (l %in% GetFromCache(i, cache.obj)) {
                    matches <- matches + 1
                } else {
                    if (IsSubstring(text[i:(i + l)], txtbuf)) {
                        matches <- matches + 1
                        ## save result for later
                        StoreInCache(i, c(GetFromCache(i, cache.obj), l),
                                     cache.obj)
                    } else {
                        break
                    }
                }
            }
            H.i.vecs <- c(H.i.vecs, log2(i) / (matches + 1))
        }
    }
    return(H.i.vecs)
}


.Converge <- function(text, step.size, cache.obj, every.word,
                      max.length = length(text), verbose = TRUE) {
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
        est <- .GetSingleEstimate(text       = text,
                                  max.length = n,
                                  every.word = every.word,
                                  cache.obj  = cache.obj)
        H.i.vec <- c(H.i.vec, est)                  
        H.est <- .GetEntropyRate(H.i.vec, n, every.word)
        result[[iter]] <- c(n, H.est)
    }
    df <- data.frame(t(sapply(result, c)))
    colnames(df) <- c("Corpus.Size", "Entropy")
    return(df)
}


.ConvergeCriterion <- function(x, method = "downsample", rate = NULL) {
    ## Get SDs of the downsampled entropy estimates
    ##
    ## Args:
    ##   x (data.frame): Character vector containing the text to
    ##   calculate the entropy on.
    ##   downsampling.rate (numeric)
    ##
    ## Returns:
    ##   data.frame: The SDs over different chunks of text
    if (method == "downsample") {
        nGroups <- nrow(x) / rate
        eachGroup <- nrow(x) / nGroups
        x$group <- rep(1:nGroups, each = eachGroup)
        SD <- aggregate(Entropy ~ group, data=x, sd)$Entropy
        corpus.size <- aggregate(Corpus.Size ~ group, data=x, max)$Corpus.Size
    } else {
        first.sample <- min(x$Corpus.Size)
        last.sample <- max(x$Corpus.Size) - rate
        corpus.size <- seq(first.sample, last.sample, first.sample)
        SD <- sapply(corpus.size,
                     function(i) {sd(x[x$Corpus.Size >= i & x$Corpus.Size <= (i+rate), "Entropy"])
                     })
    }
    return(data.frame(Corpus.Size = corpus.size, SD = SD))
}
