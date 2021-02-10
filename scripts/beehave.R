#!/usr/bin/env Rscript

require(tidyverse)
require(ggrepel)
require(gridExtra)

args = commandArgs(trailingOnly=T)

input.pgge <- read.delim(args[1])
aln.id <- ggplot(input.pgge, aes(x=as.factor(cons.jump), y=aln.id, label=sample.name)) + 
  geom_violin() + geom_point() + geom_text_repel() + xlab("consensus jump-max")
qsc <- ggplot(input.pgge, aes(x=as.factor(cons.jump), y=qsc, label=sample.name)) + 
  geom_violin() + geom_point() + geom_text_repel() + xlab("consensus jump-max") 
uniq <- ggplot(input.pgge, aes(x=as.factor(cons.jump), y=uniq, label=sample.name)) + 
  geom_violin() + geom_point() + geom_text_repel() + xlab("consensus jump-max")
multi <- ggplot(input.pgge, aes(x=as.factor(cons.jump), y=multi, label=sample.name)) + 
  geom_violin() + geom_point() + geom_text_repel() + xlab("consensus jump-max")
nonaln <- ggplot(input.pgge, aes(x=as.factor(cons.jump), y=nonaln, label=sample.name)) + 
  geom_violin() + geom_point() + geom_text_repel() + xlab("consensus jump-max")
png(args[2], width = 1500, height = 500, pointsize = 25)
g <- grid.arrange(aln.id, qsc, uniq, multi, nonaln, nrow = 1)
dev.off()

