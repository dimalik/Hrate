# Hrate

# Introduction

This package implements the _increasing window entropy estimator_
(i.e., LZ78) as described in [1], [2] and [3] to estimate the entropy
rate of a string of symbols. In the example given here, symbols are
words, and the string is a pre-processed text of the German version of
the European Parliament Corpus (EPC) [4]. The package provides two
main functions: stabilize.estimate() and get.estimate(). The first
function calculates the entropy rate for a pre-specified set of token
counts. This helps to establish the number of tokens necessary for
entropy rates to stabilize. The second function gives a single
estimate for a pre-specified number of tokens.

# Installation

Install either directly from GitHub

```R
library(devtools)
install_github("dimalik/Hrate")
```
or from the tarball

```R
install.packages("Hrate.tar.gz", repos=NULL, type="source")
```

# Usage

```R
library(Hrate)

## load the provided demo corpus: 50 K tokens of the German Europarl 
data(deuparl)
## punctuation and numbers are removed and word tokens are set to lower case
deuparl[1:10]

[1] "wiederaufnahme"  "der"             "sitzungsperiode" "ich"             "erkläre"
[6] "die"             "am"              "freitag"         "dem"             "dezember"

## get the stabilization points via stabilize.estimate()
## "step.size" is an argument specifying step sizes (in number of tokens) at which entropy rates are calculated. "max.length" specifies the maximum number of tokens to be included. "every.word=1" specifies that each word token should be used for estimation. To speed up processing only every 2nd, 3rd, xth word token could be used. Hence, every.word can be assigned any integer between 1 and the step size. "rate" gives the downsampling rate to get SDs over a given number of entropy rate estimations (see Section 4.2 in [3]). converge.estimate returns a S4 object. 
stabilization.rate <- stabilize.estimate(text = deuparl, step.size = 1000, max.length = 50000, every.word = 10, method="downsample",rate = 5)
                                     
## output the convergence rate and the associated SDs
print(get.stabilization(stabilization.rate))
print(get.criterion(stabilization.rate))

## we also expose a get.estimate function to get a single estimate on a text. "every.word""
## and "max.length" are the same arguments as for converge.estimate().
estimate <- get.estimate(text = deuparl, every.word = 10, max.length = 50000)

## plot the stabilization results
plot(convergence.rate)
```

# References

1. Gao, Y.; Kontoyiannis, I.; Bienenstock, E. Estimating the entropy of binary time series: Methodology, some theory and a simulation study. _Entropy_ 2008, 10, 71–99.

2. Bentz, C.; Alikaniotis D. The word entropy of natural languages, _arXiv_ 2016.

3. Bentz, C.; Alikaniotis D.; Cysouw, M.; Ferrer-i-Cancho, R. The entropy of words - learnability and expressivity across more than 1000 languages. _Entropy_ 2017.

4. Koehn, P. Europarl: A parallel corpus for statistical machine translation. In Proceedings of the tenth Machine Translation Summit, Phuket, Thailand, 12-16 September 2005; Volume 5, pp. 79–86.
