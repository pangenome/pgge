#!/bin/bash

pggb -i data/yeast/cerevisiae.pan.fa -t 16 -s 50000 -p 90 -n 5 -Y "#" -k 8 -B 10000000 -w 30000 -I 0.7 -o pggb_yeast -W
pgge -g "pggb_yeast/*consensus*.gfa" -f data/yeast/cerevisiae.pan.fa  -t 16 -r ~/git/pgge/scripts/beehave.R  -l 100000 -s 50000 -o pgge_yeast
