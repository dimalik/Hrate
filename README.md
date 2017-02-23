# Hrate

# Introduction

Implements the _increasing window entropy estimator_ (i.e., LZ78) as described in [1] and [2]. Concretely, the algorithm finds the entropy rate of a corpus by calculating the entropy in increasingly larger blocks of text.

# Installation

Install either directly from GitHub

```R
library(devtools)
install_github("dimalik/EntropyEstimator")
```

or from the tarball

```R
install.packages("EntropyEstimator.tar.gz", repos=NULL, type="source")
```

# Usage

```R
library(EntropyEstimator)

## load the provided demo corpus
data(deuparl)

## get the convergence rate the parameters are documented in the help files
## converge.estimate returns and S4 object.
convergence.rate <- converge.estimate(text = deuparl, step.size = 1000, max.length = 30000,
                                      every.word = 10, downsampling.rate = 5)
                                     
## see the convergence rate and the associated SDs
print(convergence.rate@convergence)
print(convergence.rate@convergence.criterion)

## we also expose a get.estimate function to get a single estimate on a text
estimate <- get.estimate(text = deuparl, every.word = 10, max.length = 50000)

## plot the results
plot(convergence.rate)
```

# References

1. Gao, Y.; Kontoyiannis, I.; Bienenstock, E. Estimating the entropy of binary time series: Methodology, some theory and a simulation study. _Entropy_ 2008, 10, 71–99.

2. Bentz, C.; Alikaniotis D. The word entropy of natural languages, _arXiv_ 2016.
