require("coloc")
require("RACER")

aa <- read.csv("./aa.filt", sep = " ")
ea <- read.csv("./ea.filt", sep = " ")
loci <- unique(c(aa$locus, ea$locus))

plot.ld <- FALSE
plot.ld <- TRUE

out <- list()

for (locus in loci) {
#for (locus in    c(loci[1], loci[2])) {
#for (locus in loci[1]) {
    print(locus)
    laa <- aa[aa$locus == locus, ]
    lea <- ea[ea$locus == locus, ]
    ##### COLOC
    m <- merge(laa, lea, by = "rsid", suffixes = c(".aa", ".ea"))
    if (!all(m$a1.aa == m$a1.ea)) error_should_not_happen
    caa <- data.frame(
        pvalues = m$p.aa,
        MAF     = pmin(m$f1.aa, 1 - m$f1.aa),
        beta    = m$beta.aa,
        varbeta = m$se.aa^2,
        type    = "quant",
        N       = m$n.aa
    )
    head(caa)
    cea <- data.frame(
        pvalues = m$p.ea,
        MAF     = pmin(m$f1.ea, 1 - m$f1.ea),
        beta    = m$beta.ea,
        varbeta = m$se.ea^2,
        type    = "quant",
        N       = m$n.ea
    )
    head(cea)
    coloc::check_dataset(caa)
    coloc::check_dataset(cea)
    pp <- coloc.abf(caa, cea)
    out[[locus]] <- pp$summary
    ### RACER
    fn <- sprintf("plot-%s.pdf", locus)
    raa <- RACER::formatRACER(assoc_data = laa, chr_col = "chr",
                              pos_col = "pos", p_col = "p")
    rea <- RACER::formatRACER(assoc_data = lea, chr_col = "chr",
                              pos_col = "pos", p_col = "p")
    if (plot.ld) {
        raa <- RACER::ldRACER(assoc_data = raa, rs_col = "rsid",
                              pops = "AFR", lead_snp = locus)
        rea <- RACER::ldRACER(assoc_data = rea, rs_col = "rsid",
                              pops = "EUR", lead_snp = locus)
    }
    head(raa)
    start <- min(laa$pos, lea$pos)
    end <- max(laa$pos, lea$pos)
    # pdf(fn)
    RACER::mirrorPlotRACER(assoc_data1 = raa, assoc_data2 = rea,
                           chr = laa$chr[1],
                           name1 = "AA", name2 = "EA",
                           label_lead = locus,
                           plotby = "coord", start_plot = start, end_plot = end)
    ggplot2::ggsave(fn)
    # dev.off()
#}
}

df <- do.call(rbind, out)
write.csv(df, file = "pp.csv")
print(df)
