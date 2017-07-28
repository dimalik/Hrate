## init some golden values
## corpus/max.length/every.word

GERMAN.10000.10 <- 6.843331
GERMAN.10000.100 <- 6.759687
GERMAN.10000.1000 <- 6.37036

GERMAN.20000.10 <- 6.947031
GERMAN.20000.100 <- 7.07181
GERMAN.20000.1000 <- 6.718456

data(deuparl)
message("Some of the tests might take some time...")
test_that("get.estimate works properly", {
    expect_equal(get.estimate(deuparl, max.length = 10000, every.word = 10), GERMAN.10000.10, tolerance=1e-4)
    expect_equal(get.estimate(deuparl, max.length = 10000, every.word = 100), GERMAN.10000.100, tolerance=1e-4)
    expect_equal(get.estimate(deuparl, max.length = 10000, every.word = 1000), GERMAN.10000.1000, tolerance=1e-4)
    expect_equal(get.estimate(deuparl, max.length = 20000, every.word = 10), GERMAN.20000.10, tolerance=1e-4)
    expect_equal(get.estimate(deuparl, max.length = 20000, every.word = 100), GERMAN.20000.100, tolerance=1e-4)
    expect_equal(get.estimate(deuparl, max.length = 20000, every.word = 1000), GERMAN.20000.1000, tolerance=1e-4)    
})


dd <- data.frame(Corpus.Size = c(1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000),
                 Entropy = c(6.27897014441326, 6.41380694727928, 6.32359644277194, 6.59773465512657, 6.63737801766681, 6.74321247576949, 6.6668246644019, 6.72546530332448, 6.79647495155925, 6.84333087495644))

se <- stabilize.estimate(deuparl, max.length = 10000, step.size = 1000, verbose = FALSE)

test_that("stabilize.estimate works fine", {
    expect_is(se, "StabilizeEntropy")
    expect_equal(get.stabilization(se), dd)
})
