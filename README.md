# pgge

## the pangenome graph evaluator

This pangenome graph evaluation pipeline measures the reconstruction accuracy of a pangenome graph (in the variation graph model).
Its goal is to give guidance in finding the best pangenome graph construction tool for a given input data and task.

It has two phases:

1. _[GraphAligner](https://github.com/maickrau/GraphAligner)_: (*alignment*) -- SHORT DESCRIPTION. TODO.

2. _[peanut](https://github.com/subwaystation/rs-peanut)_: (*alignment evaluation*) -- SHORT DESCRIPTION. TODO.

## general usage

TODO

Create our pangenome graph and consensus graphs using `pggb`:

```
pggb -i cerevisiae.pan.fa -s 50000 -p 90 -w 30000 -n 5 -t 16 -v -Y "#" -S -k 8 -B 10000000 -I 0.7 -o pggb -W -m -S
```
Evaluate the smoothed graph.
```
for f in pggb/*.smooth.gfa
do
	pgge -g $f -f cerevisiae.pan.fa -o $f.gaf -t 16 
done
```
Evaluate the consensus graphs.
```
for f in pggb/*.consensus*.gfa
do
    pgge -g $f -f cerevisiae.pan.fa -o $f.gaf -t 16
done
```
Print results to stdout:
```
for f in pggb/*.pgge
do
    echo $f | tr "\n" "\t"
    cat $f
done 
```

These commands can also be found in `scripts/pggb.sh`.
### output

The output is written to `input.gaf.pgge` in a tab-delimited format:
```
0.994424	0.9929550476154135	0.9970526308543786
```
The first number is the `aid`, the second number is the  [qsm](https://github.com/subwaystation/rs-peanut#query-sequence-match-qsm), and the third number is the [qsamm](https://github.com/subwaystation/rs-peanut#query-sequence-alignment-match-mismatch-qsamm).

## installation
TODO

## TODOs
- [ ] Finish README.
- [ ] Explain `aid`.
- [x] Add option to directly start from GAF file.
- [ ] The user should be able to select options for GraphAligner.
- [ ] Add usage examples for _`minigraph`_, _`cactus`_, and _`SibeliaZ`_.
- [ ] Add Dockerfile.
- [ ] Add a CI building the Dockerfile and emitting evaluation metrics for all tools using `HLA-Zoo` data.
- [ ] Should _`pgge`_ accept several files as input and output the results in one file?
- [ ] Add output-folder option.
- [ ] Integrate into nf-core/pangenome pipeline.