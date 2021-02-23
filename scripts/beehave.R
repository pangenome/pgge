#!/usr/bin/env Rscript

require(tidyverse)
require(ggrepel)
require(gridExtra)

args <- commandArgs(trailingOnly = T)

input.pgge <- read.table(args[1], sep = '\t', header = T)
output.png <- args[2]

##
#input.pgge <- read.table("/home/heumos/Downloads/yeast/pgge_graph_names/pgge-l100000-s50000.tsv", sep = '\t', header = T)
##
#output.png <- "/home/heumos/Downloads/yeast/pgge-l100000-s50000.png"
##
#graph_names <- read.delim("/home/heumos/Downloads/yeast/graph_names.tsv", header = F)

if (!is.na(args[3])) {
  graph_names <- read.delim(args[3], header = F)
  for (row in 1:dim(input.pgge)[1]) {
    name <- input.pgge$cons.jump[row]
    split <- strsplit(name, "\\.")
    end <- length(split[[1]]) - 2
    sub_split <- split[[1]][3:end]
    final_name <- paste(sub_split, collapse = ".")
    input.pgge$cons.jump[row] <- final_name
  }
  graph_display_names <- graph_names$V2
  names(graph_display_names) <- graph_names$V1
  for (row in 1:dim(input.pgge)[1]) {
    input.pgge$cons.jump[row] <- graph_display_names[input.pgge$cons.jump[row]]
  }
}

aln.id <- ggplot(input.pgge, aes(x = as.factor(cons.jump), y = aln.id, label = sample.name)) +
  geom_violin() +
  geom_point() +
  geom_text_repel(box.padding = 0.1, max.overlaps = 20) +
  xlab("graph name") +
  theme(text = element_text(size = 16)) +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.0001)) +
  scale_x_discrete(guide = guide_axis(angle = 90))

qsc <- ggplot(input.pgge, aes(x = as.factor(cons.jump), y = qsc, label = sample.name)) +
  geom_violin() +
  geom_point() +
  geom_text_repel(box.padding = 0.1, max.overlaps = 20) +
  xlab("graph name") +
  theme(text = element_text(size = 16)) +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.0001)) +
  scale_x_discrete(guide = guide_axis(angle = 90))

uniq <- ggplot(input.pgge, aes(x = as.factor(cons.jump), y = uniq, label = sample.name)) +
  geom_violin() +
  geom_point() +
  geom_text_repel(box.padding = 0.1, max.overlaps = 20) +
  xlab("graph name") +
  theme(text = element_text(size = 16)) +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.0001)) +
  scale_x_discrete(guide = guide_axis(angle = 90))

multi <- ggplot(input.pgge, aes(x = as.factor(cons.jump), y = multi, label = sample.name)) +
  geom_violin() +
  geom_point() +
  geom_text_repel(box.padding = 0.1, max.overlaps = 20) +
  xlab("graph name") +
  theme(text = element_text(size = 16)) +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.0001)) +
  scale_x_discrete(guide = guide_axis(angle = 90))

nonaln <- ggplot(input.pgge, aes(x = as.factor(cons.jump), y = nonaln, label = sample.name)) +
  geom_violin() +
  geom_point() +
  geom_text_repel(box.padding = 0.1, max.overlaps = 20) +
  xlab("graph name") +
  theme(text = element_text(size = 16)) +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.0001))+
  scale_x_discrete(guide = guide_axis(angle = 90))

png(output.png, width = 2000, height = 500, pointsize = 25)
g <- grid.arrange(aln.id, qsc, uniq, multi, nonaln, nrow = 1)
dev.off()
