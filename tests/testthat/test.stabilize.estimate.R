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
