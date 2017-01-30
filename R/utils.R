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
