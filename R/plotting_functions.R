plot.stabilization <- function(x) {
    dat <- x@stabilization
    criterion <- x@min.criterion
    
    frame_conv <- ggplot(dat, aes(x = Corpus.Size, y = Entropy)) +
        geom_line(size = 0.5, alpha = 1) +
        xlab("Number of Word Tokens") + ylab("Estimated Entropy (bits/word)") +
        geom_vline(aes(xintercept = criterion), linetype = "longdash",
                   color = "grey") +
        scale_x_continuous(labels = scientific) +
        theme_bw() +
        theme(axis.text.x  = element_text(size = 7),
              axis.title.x = element_text(size = 12),
              axis.title.y = element_text(size = 12))
    frame_conv
}

plot.criterion <- function(x) {
    dat <- x@stabilization.criterion
    frame_sd <- ggplot(dat, aes(x = Corpus.Size, y = SD)) +
        geom_line(size = 0.5, alpha = 1) +
        xlab("Number of Word Tokens") +
        ylab("Standard Deviation of Entropy Estimate") +
        geom_hline(yintercept = 0.05, linetype = "longdash", color = "grey") +
        theme_bw() +
        scale_x_continuous(labels = scientific) +
        theme(axis.text.x  = element_text(size = 7),
              axis.title.x = element_text(size = 12),
              axis.title.y = element_text(size = 12))
    frame_sd
}
