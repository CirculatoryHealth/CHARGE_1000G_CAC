# General functions

# Auto installer
install.packages.auto <- function(x) { 
  x <- as.character(substitute(x)) 
  if(isTRUE(x %in% .packages(all.available = TRUE))) { 
    eval(parse(text = sprintf("require(\"%s\")", x)))
  } else { 
    # Update installed packages - this may mean a full upgrade of R, which in turn
    # may not be warrented. 
    #update.install.packages.auto(ask = FALSE) 
    eval(parse(text = sprintf("install.packages(\"%s\", dependencies = TRUE, repos = \"https://cloud.r-project.org/\")", x)))
  }
  if(isTRUE(x %in% .packages(all.available = TRUE))) { 
    eval(parse(text = sprintf("require(\"%s\")", x)))
  } else {
    if (!requireNamespace("BiocManager"))
      install.packages("BiocManager")
    BiocManager::install() # this would entail updating installed packages, which in turned may not be warrented
    
    # Code for older versions of R (<3.5.0)
    # source("http://bioconductor.org/biocLite.R")
    # Update installed packages - this may mean a full upgrade of R, which in turn
    # may not be warrented.
    # biocLite(character(), ask = FALSE) 
    eval(parse(text = sprintf("BiocManager::install(\"%s\")", x)))
    eval(parse(text = sprintf("require(\"%s\")", x)))
  }
}

# RACER singleRegionalAssocPlot

singlePlotRACER2 <- function (assoc_data, chr, build = "hg19", set = "protein_coding", 
          plotby, gene_plot = NULL, snp_plot = NULL, start_plot = NULL, 
          end_plot = NULL, label_lead = FALSE, 
          grey_colors = FALSE, gene_track_h = 3, gene_name_s = 2.5) 
  {
  if (missing(assoc_data)) {
    stop("Please provide a data set to plot.")
  }
  else if (missing(chr)) {
    stop("Please specify which chromosome you wish to plot.")
  }
  else if (missing(plotby)) {
    stop("Please specify the method by which you wish to plot.")
  }
  else if (plotby == "gene") {
    if (is.null(gene_plot)) {
      stop("Please specify a gene to plot by.")
    }
  }
  else if (plotby == "snp") {
    if (is.null(snp_plot)) {
      stop("Please specify a snp to plot by.")
    }
  }
  else if (plotby == "coord") {
    if (is.null(start_plot) | is.null(end_plot)) {
      stop("Please specify start coordinate for plot.")
    }
  }
  else {
    message("All inputs are go.")
  }
  reqs = c("CHR", "POS", "LOG10P")
  cols = colnames(assoc_data)
  if (sum(reqs %in% cols) == 3) {
  }
  else {
    stop("Association Data Set is missing a required column, please format your data set using formatRACER.R.")
  }
  reqs_2 = c("LD", "LD_BIN")
  if (sum(reqs_2 %in% cols) == 2) {
  }
  else {
    message("Association Data Set is missing LD data, the resulting plot won't have LD information, but you can add it using the ldRACER.R function.")
  }
  `%>%` <- magrittr::`%>%`
  if (build == "hg38") {
    utils::data(hg38)
    chr_in = chr
    colnames(hg38) = c("GENE_ID", "CHR", "TRX_START", "TRX_END", 
                       "LENGTH", "GENE_NAME", "TYPE")
    gene_sub = hg38[hg38$CHR == chr_in, ]
  }
  else if (build == "hg19") {
    utils::data(hg19)
    chr_in = chr
    colnames(hg19) = c("GENE_ID", "CHR", "TRX_START", "TRX_END", 
                       "LENGTH", "GENE_NAME", "TYPE")
    gene_sub = hg19[hg19$CHR == chr_in, ]
  }
  if (set == "protein_coding") {
    gene_sub = gene_sub[gene_sub$TYPE == "protein_coding", 
    ]
  }
  else {
    gene_sub = gene_sub
  }
  if (sum(is.null(plotby)) == 1) {
    stop("Please specify a method by which to plot.")
  }
  if (sum(is.null(plotby)) == 0) {
    message("Plotting by...")
    if ((plotby == "coord") == TRUE) {
      message("coord")
      start = start_plot
      end = end_plot
    }
    else if ((plotby == "gene") == TRUE) {
      message(paste("gene:", gene_plot))
      if (sum(is.null(gene_plot)) == 0) {
        p = subset(gene_sub, gene_sub$GENE_NAME == gene_plot)
        start = min(p$TRX_START) - 5e+05
        end = max(p$TRX_END) + 5e+05
      }
      else {
        message("No gene specified.")
      }
    }
    else if ((plotby == "snp") == TRUE) {
      message(paste("snp", snp_plot))
      q = assoc_data[assoc_data$RS_ID == snp_plot, ]
      w = q$POS
      w = as.numeric(as.character(w))
      start = w - 5e+05
      end = w + 5e+05
    }
  }
  gene_sub = subset(gene_sub, gene_sub$TRX_START > (start - 
                                                      50000))
  gene_sub = subset(gene_sub, gene_sub$TRX_END < (end + 50000))
  gene_sub = gene_sub[, c(3, 4, 6)]
  gene_sub = reshape2::melt(gene_sub, id.vars = "GENE_NAME")
  gene_sub$y_value = as.numeric(as.factor(gene_sub$GENE_NAME))
  plot_lab = subset(gene_sub, gene_sub$variable == "TRX_END")
  message("Reading in association data")
  in.dt <- as.data.frame(assoc_data)
  in.dt$POS = as.numeric(as.character(in.dt$POS))
  in.dt$LOG10P = as.numeric(as.character(in.dt$LOG10P))
  in.dt$CHR = as.numeric(as.character(in.dt$CHR))
  in.dt = dplyr::filter(in.dt, .data$CHR == chr_in)
  in.dt = dplyr::filter(in.dt, .data$POS > start) %>% dplyr::filter(.data$POS < 
                                                                      end)
  if (label_lead == TRUE) {
    lsnp_row = which(in.dt$LABEL == "LEAD")
    label_data = in.dt[lsnp_row, ]
    if (dim(label_data)[1] == 0) {
      lsnp_row = in.dt[in.dt$LOG10P == max(in.dt$LOG10P), 
      ]
      label_data = lsnp_row[1, ]
    }
  }
  message("Generating Plot")
  if ("LD" %in% colnames(in.dt) && "LD_BIN" %in% colnames(in.dt)) {
    c = ggplot2::ggplot(gene_sub, ggplot2::aes_string(x = "value", 
                                                      y = "y_value")) + ggplot2::geom_line(ggplot2::aes_string(group = "GENE_NAME"), 
                                                                                           size = 2) + ggplot2::theme_minimal() + 
      ggplot2::geom_text(data = plot_lab, 
                               ggplot2::aes_string(x = "value", y = "y_value", label = "GENE_NAME"), 
                               hjust = -0.1, vjust = 0.3,
                               size = gene_name_s) + 
      ggplot2::theme(axis.title.y = ggplot2::element_text(color = "transparent", size = 28),
                     axis.text.y = ggplot2::element_blank(), 
                     axis.ticks.y = ggplot2::element_blank(),
                     panel.border = element_blank(), 
                     panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(),
                     axis.line.x = element_line(colour = "#595A5C")) + 
      ggplot2::xlab(paste0("chromosome ", 
                           chr_in, " position")) + ggplot2::coord_cartesian(xlim = c(start, 
                                                                                     end), ylim = c(0, (max(gene_sub$y_value) + 0.25)))
    b = ggplot2::ggplot(in.dt, ggplot2::aes_string(x = "POS", 
                                                   y = "LOG10P", color = "LD_BIN")) + ggplot2::geom_point() + 
      ggplot2::scale_colour_manual(values = c(`1.0-0.8` = "#DB003F", #"red", 
                                              `0.8-0.6` = "#F59D10", #"darkorange1", 
                                              `0.6-0.4` = "#49A01D", #"green1", 
                                              `0.4-0.2` = "#1290D9", #"skyblue1", 
                                              `0.2-0.0` = "#4C81BF", #"navyblue", 
                                              `NA` = "#A2A3A4" # "grey"
                                              ), 
                                   drop = FALSE) + 
                                   labs(color = bquote(LD~r^2)) + 
      ggplot2::theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(), 
                     axis.line.x = element_blank(),
                     axis.line.y = element_line(colour = "#595A5C"),
                     axis.title.x=element_blank(),
                     axis.text.x=element_blank(),
                     axis.ticks.x=element_blank()) +  
      # ggplot2::xlab("Chromosome Position") + 
      # ggplot2::ylab("-log10(p-value)") + 
      ggplot2::ylab(bquote(-log[10]~(p-value))) + 
      ggplot2::coord_cartesian(xlim = c(start, end), ylim = c(min(in.dt$LOG10P), 
                                                              max(in.dt$LOG10P)))
  }
  else {
    c = ggplot2::ggplot(gene_sub, ggplot2::aes_string(x = "value", 
                                                      y = "y_value")) + ggplot2::geom_line(ggplot2::aes_string(group = "GENE_NAME"), 
                                                                                           size = 2) + ggplot2::theme_minimal() + 
      ggplot2::geom_text(data = plot_lab, 
                               ggplot2::aes_string(x = "value", y = "y_value", label = "GENE_NAME"), 
                               hjust = -0.1, vjust = 0.3,
                               size = gene_name_s) + 
      ggplot2::theme(axis.title.y = ggplot2::element_blank(), #ggplot2::element_text(color = "white", size = 28),  
                     axis.text.y = ggplot2::element_blank(), 
                     axis.ticks.y = ggplot2::element_blank(),
                     panel.border = element_blank(), 
                     panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(),
                     axis.line.x = element_line(colour = "#595A5C")) + 
      ggplot2::xlab(paste0("chromosome ", 
                           chr_in, " position")) + ggplot2::coord_cartesian(xlim = c(start, 
                                                                                     end), ylim = c(0, (max(gene_sub$y_value) + 0.25)))
    b = ggplot2::ggplot(in.dt, ggplot2::aes_string(x = "POS", 
                                                   y = "LOG10P")) + ggplot2::geom_point() + ggplot2::theme(panel.border = element_blank(), 
                                                                                                           panel.grid.major = element_blank(),
                                                                                                           panel.grid.minor = element_blank(), 
                                                                                                           axis.line.x = element_blank(),
                                                                                                           axis.line.y = element_line(colour = "#595A5C"),
                                                                                                           axis.title.x=element_blank(),
                                                                                                           axis.text.x=element_blank(),
                                                                                                           axis.ticks.x=element_blank()) + 
      # ggplot2::xlab("Chromosome Position") + 
      # ggplot2::ylab("-log10(p-value)") + 
      ggplot2::ylab(bquote(-log[10]~(p-value))) + 
      ggplot2::coord_cartesian(xlim = c(start, end), ylim = c(min(in.dt$LOG10P), 
                                                              max(in.dt$LOG10P)))
  }
  if (label_lead == TRUE) {
    b = b + geom_point(data = label_data, 
                       aes_string(x = "POS", 
                                  y = "LOG10P"), 
                       color = "#9A3480", #"purple")
                       fill = "#9A3480",
                       size = 4, shape = 23) 
    
    b = b + geom_text(data = label_data, 
                      aes_string(label = "RS_ID"), 
                      color = "black", 
                      size = 4, hjust = 1.25)
  }
  if (grey_colors == TRUE) {
    b = b + geom_point(color = "#A2A3A4", fill = "#A2A3A4")
  }
  
  ggpubr::ggarrange(b, c, heights = c(gene_track_h, 1), nrow = 2, ncol = 1, 
                    common.legend = TRUE, legend = "right")
}

