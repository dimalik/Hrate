#' Preprocess character vector
#'
#' This provides some elementary preprocessing for a read character
#' vector such as lowercasing and bag-of-words normalization. The bow
#' normalization step substitutes each element of the vector with a
#' numeric value (its ID). This can be quite useful in non-ASCII texts
#' or texts containing words with boundary symbols where the regular
#' expression can fail.
#'
#' @param text
#' @param lower Boolean. Whether or not to lowercase all words.
#' @param bow Boolean. Whether or not to substitute each word with an
#'     ID tag (useful for non-ASCII texts)
#'
#' @return A character vector.
#'
#' @examples
#' txt <- c("This", "is", "a", "Sentence", "containing", "UPPERCASE", "lowercase", "and", "sy.mb'ols")
#' txt.norm <- PreprocessText(txt, lower = TRUE, normalize = TRUE)
PreprocessText <- function(text, lower = FALSE, bow = TRUE) {
    if (lower)
        text <- tolower(text)
    if (bow)
        text <- as.character(as.numeric(as.factor(text)))
    return(text)
}

#' Read character vector from file
#'
#' The \code{read.file} helper function reads a character vector from
#' a file up to \code{max.length} calling \code{\link{PreprocessText}}
#' if nececssary to carry out preprocessing steps.
#'
#' @param text.file A character vector. The path to the text file
#' @param max.length A numeric. The maximum length of space delimited
#'     units to be read (defaults to the entire file).
#' @param lower Boolean. Whether or not to lowercase all words.
#' @param bow Boolean. Whether or not to substitute each word with an
#'     ID tag (useful for non-ASCII texts)
read.file <- function(text.file, max.length = length(text.file),
                      lower = FALSE, bow = FALSE) {
   text <- scan(text.file, what = "char", quote = "",
                comment.char = "", encoding = "UTF-8",
                sep = " ", n = max.length)
   return(PreprocessText(text, lower = lower, bow = bow))
}
   
IsSubstring <- function(subvec, fullstr) {
    #' Tests whether `subvec` is a proper substring of `fullvec`.
    #'
    ## Args:
    ##   subvec: A character vector of size less than `fullvec`.
    ##   fullstr: A character vector.
    ##
    ## Returns:
    ##   bool: `TRUE` is `subvec` is a proper substring of `fullstr`
    ## Transform to regex pattern
    substr  <- paste0('\\b', paste(subvec, collapse=' '), '\\b')
    return (grepl(pattern = substr, x = fullstr))
}
