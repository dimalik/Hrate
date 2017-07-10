#' Preprocess character vectors
#'
#' This provides some elementary preprocessing for a read character
#' vector such as lowercasing and bag-of-words normalization. The bow
#' normalization step substitutes each element of the vector with a
#' numeric value (its ID). This can be quite useful in non-ASCII texts
#' or texts containing words with boundary symbols where the regular
#' expression can fail.
#'
#' @param text A character vector. This contains the text as returned
#'     by \code{scan}.
#' @param lower Boolean. Whether or not to lowercase all words.
#' @param bow Boolean. Whether or not to substitute each word with an
#'     ID tag (useful for non-ASCII texts)
#'
#' @return A character vector.
#'
#' @examples
#' txt <- c("This", "is", "a", "Sentence", "containing", "UPPERCASE", "lowercase", "and", "sy.mb'ols")
#' txt.norm <- PreprocessText(txt, lower = TRUE, bow = TRUE)
#' @seealso
#' \code{\link{tolower}}
PreprocessText <- function(text, lower = FALSE, bow = TRUE) {
    if (lower)
        text <- tolower(text)
    if (bow)
        text <- as.character(as.numeric(as.factor(text)))
    return(text)
}

#' Read character vector from file
#'
#' \code{read.file} reads a file word by word and returns a unicode
#' character vector.
#'
#' The \code{read.file} helper function reads a character vector from
#' a file up to \code{max.length} calling \code{\link{PreprocessText}}
#' if nececssary to carry out any preprocessing steps.
#'
#' @param text.file A character vector. The path to the text file
#' @param max.length A numeric. The maximum length of space delimited
#'     units to be read (defaults to the entire file).
#' @param lower Boolean. Whether or not to lowercase all words.
#' @param bow Boolean. Whether or not to substitute each word with an
#'     ID tag (useful for non-ASCII texts)
#' @param ... arguments to be passed to \code{scan}.
#' @examples
#' text <- read.file("mycorpus.txt", max.length = 1000, lower = True, bow = TRUE)
#' @seealso \code{\link{scan}}, \code{\link{PreprocessText}}
read.file <- function(text.file, max.length = -1,
                      lower = FALSE, bow = FALSE, ...) {
   text <- scan(text.file, what = "char", quote = "",
                comment.char = "", encoding = "UTF-8",
                sep = " ", n = max.length, quiet = TRUE, ...)
   return(PreprocessText(text, lower = lower, bow = bow))
}

#' Test whether \code{subvec} is a proper substring of \code{fullvec}.
#'
#' @param subvec A character vector. Its size should be less than or equal to \code{length(fullvec)}.
#' @param fullstr A character vector. The entire string.
#'
#' @return bool. TRUE if subvec \code{\\subset} fullstr, FALSE otherwise.
#' @examples
#' IsSubstring(c("this", "is", "a"), "this is a sentence")  # true
#' IsSubstring(c("tthis", "is", "a"), "this is a sentence") # false
#' @seealso \code{\link{grepl}}
IsSubstring <- function(subvec, fullstr) {
    substr  <- paste0('\\b', paste(subvec, collapse=' '), '\\b')
    return (grepl(pattern = substr, x = fullstr))
}
