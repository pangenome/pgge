# pgge

## the pangenome graph evaluator

This pangenome graph evaluation pipeline measures the reconstruction accuracy of a pangenome graph (in the variation graph model).
Its goal is to give guidance in finding the best pangenome graph construction tool for a given input data and task.

It has five phases:

1. _`SplitSamples`_: (*sample preparation*) -- SHORT DESCRIPTION. TODO.

2. _[splitfa]()_: (*split sequences*) -- SHORT DESCRIPTION. TODO.

3. _[GraphAligner](https://github.com/maickrau/GraphAligner)_: (*alignment*) -- SHORT DESCRIPTION. TODO.

4. _[peanut](https://github.com/subwaystation/rs-peanut)_: (*alignment evaluation*) -- SHORT DESCRIPTION. TODO.

5. _[beehave.R]()_: (*plot evaluation results*) -- SHORT DESCRIPTION. TODO.

## general usage

Create our pangenome graph and consensus graphs using _`pggb`_:

```
pggb -i cerevisiae.pan.fa -s 50000 -p 90 -w 30000 -n 5 -t 16 -v -Y "#" -S -k 8 -B 10000000 -I 0.7 -o pggb -W -m -S
```
Evaluate the consensus graphs.
```
time pgge -g "pggb_yeast/*consensus*.gfa" -f cerevisiae.pan.fa  -t 16 -r ~/git/pgge/scripts/beehave.R  -l 100000 -s 50000 -o pgge_yeast
```
Make sure that you include the opening and closing `"` in the command line, else the regex can't be resolved. For a single input GFA, this is not required.

These commands can also be found in `examples/pgge_yeast.sh`.

:warning: _`pgge`_ is summarizing results by sample name. If you have
```
S288C.chrI
S288C.chrII
S288C.chrIII
```
in your given FASTA file, the results will only contain one line of metrics. In this case for `S288C`. This is useful if you have contig seuquences in your FASTA and want to summarize by sample name. _`pgge`_ always splits by `.` and takes the first entry in the resulting split as sample name. 

### output

The output is written to `pgge_yeast/pgge-l100000-s50000.tsv` in a tab-delimited format:
```
cat pgge_yeast/pgge-l100000-s50000.tsv
```
```
sample.name	cons.jump	aln.id	qsc	uniq	multi	nonaln
DBVPG6044	10000:y	0.994218	0.9899744104803494	0.9896451965065503	0.00032921397379912664	0.010025589519650656
DBVPG6044	1000:y	0.994263	0.9903787772925764	0.9900709606986899	0.0003078165938864629	0.00962122270742358
DBVPG6044	100:y	0.994298	0.9912931004366812	0.991070305676856	0.0002227947598253275	0.008706899563318778
DBVPG6044	10:y	0.994735	0.9921786026200874	0.9920539301310044	0.00012467248908296942	0.007821397379912665
DBVPG6765	10000:y	0.992841	0.985657729257642	0.9853784716157206	0.00027925764192139737	0.014342270742358079
DBVPG6765	1000:y	0.992856	0.986948384279476	0.98662	0.00032838427947598254	0.013051615720524018
DBVPG6765	100:y	0.992967	0.9884108733624454	0.9881827510917031	0.00022812227074235807	0.011589126637554585
DBVPG6765	10:y	0.993538	0.9914508733624454	0.9912349781659389	0.00021589519650655023	0.008549126637554584
S288C	10000:y	0.993716	0.9857024255319149	0.9854575319148936	0.0002448936170212766	0.014297574468085106
S288C	1000:y	0.9937	0.9865472765957447	0.9863214042553191	0.0002258723404255319	0.01345272340425532
S288C	100:y	0.993877	0.9889516170212765	0.9888419574468085	0.00010965957446808511	0.011048382978723405
S288C	10:y	0.994363	0.9917501702127659	0.9916815319148936	0.00006863829787234043	0.008249829787234042
SK1	10000:y	0.994397	0.9905497835497835	0.990106406926407	0.00044337662337662337	0.00945021645021645
SK1	1000:y	0.994448	0.9896461038961039	0.9892491341991342	0.00039696969696969696	0.010353896103896103
SK1	100:y	0.994541	0.991494329004329	0.9911982683982684	0.00029606060606060606	0.008505670995670995
SK1	10:y	0.995039	0.9924314285714285	0.9922540692640692	0.00017735930735930737	0.007568571428571429
UWOPS034614	10000:y	0.993025	0.9868850877192983	0.9864196052631579	0.0004654824561403509	0.013114912280701755
UWOPS034614	1000:y	0.993003	0.9853789035087719	0.9849094298245614	0.0004694736842105263	0.01462109649122807
UWOPS034614	100:y	0.993264	0.9895118421052631	0.9892686403508771	0.0002432017543859649	0.010488157894736842
UWOPS034614	10:y	0.993867	0.9913359210526316	0.9912328070175439	0.0001031140350877193	0.00866407894736842
Y12	10000:y	0.994754	0.991111135371179	0.9906802620087336	0.00043087336244541485	0.00888886462882096
Y12	1000:y	0.994754	0.991854192139738	0.9913742794759826	0.0004799126637554585	0.008145807860262009
Y12	100:y	0.99493	0.9901456331877729	0.989918209606987	0.0002274235807860262	0.009854366812227074
Y12	10:y	0.995162	0.9932890829694323	0.9930175109170306	0.0002715720524017467	0.006710917030567686
YPS128	10000:y	0.995636	0.989447903930131	0.9893367248908297	0.00011117903930131005	0.010552096069868996
YPS128	1000:y	0.995584	0.9897622707423581	0.9896544978165939	0.00010777292576419214	0.010237729257641921
YPS128	100:y	0.995773	0.9937249781659389	0.9936575982532752	0.00006737991266375546	0.006275021834061136
YPS128	10:y	0.995965	0.9955779912663756	0.995537248908297	0.00004074235807860262	0.004422008733624454
```

The first number is the `aln.id` derived from the alignment identity GAF field of _`GraphAligner`_. All other metrics can be found in the [metrics section](https://github.com/pangenome/rs-peanut#metrics) of _`peanut`_.

_`pgge`_ also generates a visualization of the results `pgge_yeast/pgge-l100000-s50000.tsv.png`:
![pgge_yeast.sh](examples/pgge-l100000-s50000.tsv.png)

## installation
TODO

## TODOs
- [x] _`pgge`_ should accept a list of GFA files as input (_path/to/files/\*.consensus\*.gfa_) and output the summarized results in one PNG
- [x] Integrate https://github.com/ekg/splitfa as an option to prepare the input FASTA.
- [x] Add the possibility to split the input by sample name. Later re-use that information in the final result. THIS IS THE NEW DEFAULT. 
- [x] Add R script to visualize the result.
- [x] Explain `aln.id`.
- [x] Add option to directly start from GAF file.
- [x] Add output-folder option.
- [ ] Add possibility to input several GAF files. Make sure the user can input a list of samples for the GAFs.
- [ ] The user should be able to select options for GraphAligner.
- [ ] Add a toolchain that compares the query aligments with the exact nodes they aligned to in the graph.
- [ ] Add Dockerfile.
- [ ] Add a CI building the Dockerfile and emitting evaluation metrics for all tools using `HLA-Zoo` data.
- [ ] Add usage examples for _`minigraph`_, _`cactus`_, and _`SibeliaZ`_.
- [ ] Integrate into nf-core/pangenome pipeline.

## authors

Simon Heumos, Erik Garrison, Christian Fischer, Andrea Guarracino