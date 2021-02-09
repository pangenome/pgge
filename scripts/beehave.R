#!/usr/bin/env Rscript

require(tidyverse)
require(ggrepel)

args = commandArgs(trailingOnly=T)

input.pgge <- read.delim(args[1])
png(args[2], )
ggplot(input.pgge, aes(x=as.factor(cons.jump), y=qsc, label=sample.name)) + 
  geom_violin() + geom_point() + geom_text_repel() + xlab("consensus jump-max"); 
dev.off()