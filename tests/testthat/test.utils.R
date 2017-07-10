## Preprocess text

test_that("preprocess text works for lowercasing", {
    expect_equal(PreprocessText("THIS", lower = TRUE, bow = FALSE), "this")
    expect_equal(PreprocessText("this", lower = TRUE, bow = FALSE), "this")
    expect_equal(PreprocessText("ThIs", lower = TRUE, bow = FALSE), "this")
})

## note that factors work alphabetically
test_that("preprocess text works for bow", {
    expect_equal(PreprocessText(c("a", "b"), bow = TRUE), c("1", "2"))
})

test_that("preprocess text works for bow and lowercasing", {
    expect_equal(PreprocessText(c("a", "b", "B"), lower = TRUE, bow = TRUE), c("1", "2", "2"))
})


## read.file

test_that("read.file works properly", {
    expect_equal(read.file("test.sentence"), c("this", "is" , "a", "test", "SENTENCE"))
    expect_equal(read.file("test.sentence", lower = TRUE), c("this", "is" , "a", "test", "sentence"))
    expect_equal(read.file("test.sentence", lower = TRUE, bow = TRUE), c("5", "2" , "1", "4", "3"))
    expect_equal(read.file("test.sentence", max.length = 3), c("this", "is" , "a"))
})


## issubstring

test_that("issubstring works", {
    expect_true(IsSubstring(c("this", "is", "a"), "this is a sentence"))
    expect_false(IsSubstring(c("tthis", "is", "a"), "this is a sentence"))
})
