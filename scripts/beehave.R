#!/usr/bin/env Rscript

require(tidyverse)
require(ggrepel)
require(gridExtra)

args <- commandArgs(trailingOnly = T)

input.pgge <- read.table(args[1], sep = '\t', header = T)

aln.id <- ggplot(input.pgge, aes(x = as.factor(cons.jump), y = aln.id, label = sample.name)) +
  geom_violin() +
  geom_point() +
  geom_text_repel(box.padding = 0.1, max.overlaps = 20) +
  xlab("consensus jump-max") +
  theme(text = element_text(size = 16)) +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.0001))

qsc <- ggplot(input.pgge, aes(x = as.factor(cons.jump), y = qsc, label = sample.name)) +
  geom_violin() +
  geom_point() +
  geom_text_repel(box.padding = 0.1, max.overlaps = 20) +
  xlab("consensus jump-max") +
  theme(text = element_text(size = 16)) +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.0001))

uniq <- ggplot(input.pgge, aes(x = as.factor(cons.jump), y = uniq, label = sample.name)) +
  geom_violin() +
  geom_point() +
  geom_text_repel(box.padding = 0.1, max.overlaps = 20) +
  xlab("consensus jump-max") +
  theme(text = element_text(size = 16)) +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.0001))

multi <- ggplot(input.pgge, aes(x = as.factor(cons.jump), y = multi, label = sample.name)) +
  geom_violin() +
  geom_point() +
  geom_text_repel(box.padding = 0.1, max.overlaps = 20) +
  xlab("consensus jump-max") +
  theme(text = element_text(size = 16)) +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.0001))

nonaln <- ggplot(input.pgge, aes(x = as.factor(cons.jump), y = nonaln, label = sample.name)) +
  geom_violin() +
  geom_point() +
  geom_text_repel(box.padding = 0.1, max.overlaps = 20) +
  xlab("consensus jump-max") +
  theme(text = element_text(size = 16)) +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.0001))

png(args[2], width = 1700, height = 500, pointsize = 25)
g <- grid.arrange(aln.id, qsc, uniq, multi, nonaln, nrow = 1)
dev.off()
