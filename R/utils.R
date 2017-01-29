StoreInCache <- function(key, value, CacheEnv) {
    ## Store a value in cache.
    ##
    ## Args:
    ##   key (character): The key to later retrieve the value.
    ##   value (object): An arbitrary object to be stored.
    ##   CacheEnv (environment): The environment to store the key into.
    if (is.numeric(key))
        key <- as.character(key)
    assign(key, value, envir = CacheEnv)
}

readFile <- function(textFile, numtotal) scan(textFile,
                                              what="char", quote="", comment.char="",
                                              encoding="UTF-8",
                                              n=numtotal)

IsSubstring <- function(subvec, fullvec) {
    ## Tests whether `subvec` is a proper substring of `fullvec`.
    ##
    ## Args:
    ##   substr: A character vector of size less than `fullvec`.
    ##   fullstr: A character vector.
    ##
    ## Returns:
    ##   bool: `TRUE` is `subvec` is a proper substring of `fullvec`
    ## Transform to regex pattern
    substr  <- paste0('\\b', paste(subvec, collapse=' '), '\\b')
    fullstr <- paste(fullvec, collapse = ' ')
    return (grepl(pattern = substr, x = fullstr))
}

GetFromCache <-function(key, CacheEnv) {
    ## Retrieve value from cache
    ##
    ## Args:
    ##   key (character): The key to retrieve.
    ##   CacheEnv (environment): The environment to retrieve the key from.
    ##
    ## Returns:
    ##   object: An arbitrary object stored in the environment.
    if (is.numeric(key))
        key <- as.character(key)
    return (get(key, envir = CacheEnv, inherits = FALSE))
}

ExistsInCache <- function(key, CacheEnv) {
    ## Check whether key exists in cache.
    ##
    ## Args:
    ##   key (character): The key to retrieve.
    ##   CacheEnv (environment): The environment to retrieve the key from.
    ##
    ## Returns:
    ##   bool: `TRUE` if `key` exists in `CacheEnv` else `FALSE`.
    if (is.numeric(key))
        key <- as.character(key)
    return (exists(key, envir = CacheEnv, inherits = FALSE))
}

GetSingleEstimate <- function(text, max.length, every.word = 100,
                              cache.obj = NULL) {
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
            for (l in 0:(i - 1)) {
                ## use memoized value if available
                if (l %in% GetFromCache(i, cache.obj)) {
                    matches <- matches + 1
                } else {
                    if (IsSubstring(text[i:(i + l)],
                                    text[1:(i - 1)])) {
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
