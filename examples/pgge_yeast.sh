#!/bin/bash

pggb -i cerevisiae.pan.fa -s 50000 -p 90 -w 30000 -n 5 -t 16 -v -Y "#" -S -k 8 -B 10000000 -I 0.7 -o pggb -W -m -S
time pgge -g "pggb_yeast/*consensus*.gfa" -f cerevisiae.pan.fa  -t 16 -r ~/git/pgge/scripts/beehave.R  -l 100000 -s 50000 -o pgge_yeast
