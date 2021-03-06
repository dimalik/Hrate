% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stabilize_estimate.R
\name{stabilize.estimate}
\alias{stabilize.estimate}
\title{Get stabilization estimate}
\usage{
stabilize.estimate(text, step.size, max.length = length(text),
  every.word = 10, method = "downsample", rate = 5, verbose = TRUE)
}
\arguments{
\item{text}{Character vector. Preferably this should be read with
\code{\link{read.file}} to take care of preprocessing. Note
that internally this uses a regular expression for the matching
so in non-ASCII texts it might be unstable. In those cases it
is recommended to \code{\link{normalize}} the text beforehand.}

\item{step.size}{A numeric scalar. Pre-specifies the step sizes at
which entropy rates are computed. Warning: smaller values
increase the computation time.}

\item{max.length}{A numeric scalar. How many tokens of the
\code{text} should be read? Defaults to the length of the text.}

\item{every.word}{A numeric scalar. "every.word=1" specifies that
each word token should be used for estimation. To speed up
processing only every 2nd, 3rd, nth word token could be used.
Hence, every.word can be assigned any integer between 1 and the
step size.}

\item{verbose}{Boolean. Whether or not to display progress.}

\item{downsampling.rate}{A numeric scalar.}
}
\value{
\code{stabilize.estimate} returns an object of class \code{\link{Stabilize}}.
}
\description{
\code{stabilize.estimate} is used to find the minimum size of text
needed to get a stable entropy rate.
}
\examples{
data(deuparl)
ce <- stabilize.estimate(deuparl, step.size = 1000, max.length = 10000, every.word = 10, method = "downsample", rate = 5, verbose = TRUE)
}
\seealso{
\code{\link{Stabilize}}, \code{\link{StabilizeCriterion}}
}
