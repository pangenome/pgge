#!/bin/bash

pggb -i cerevisiae.pan.fa -s 50000 -p 90 -w 30000 -n 5 -t 16 -v -Y "#" -S -k 8 -B 10000000 -I 0.7 -o pggb -W -m -S

for f in pggb/*.smooth.gfa
do
	pgge -g $f -f cerevisiae.pan.fa -o $f.gaf -t 16 
done

for f in pggb/*.consensus*.gfa
do
    pgge -g $f -f cerevisiae.pan.fa -o $f.gaf -t 16
done

for f in pggb/*.pgge
do
    echo $f | tr "\n" "\t"
    cat $f
done 
