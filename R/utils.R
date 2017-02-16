#' Preprocess character vector
#'
#' This provides some elementary preprocessing for a read character
#' vector such as lowercasing and normalization. The normalization
#' step substitutes each element of the vector with a numeric value
#' (its ID). This can be quite useful in non-ASCII texts or texts
#' containing words with boudnary symbols where the regular expression
#' can fail.
#'
#' @param text
#' @param lower This happens before normalization.
#' @param normalize
#'
#' @return A character vector.
#'
#' @examples
#' txt <- c("This", "is", "a", "Sentence", "containing", "UPPERCASE", "lowercase", "and", "sy.mb'ols")
#' txt.norm <- NormalizeText(txt, lower = TRUE, normalize = TRUE)

NormalizeText <- function(text, lower = FALSE, normalize = TRUE) {
    if (lower)
        text <- tolower(text)
    if (normalize)
        text <- as.character(as.numeric(as.factor(text)))
    return(text)
}

read.file <- function(text.file, max.length = length(text.file),
                      lower = FALSE, normalize = FALSE) {
   text <- scan(text.file, what = "char", quote = "",
                comment.char = "", encoding = "UTF-8",
                sep = " ", n = max.length)
   return(NormalizeText(text, lower = lower, normalize = normalize))
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
