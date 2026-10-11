GRAMMy Manual
=============

Commandline Tools
-----------------

- ``grammy_gdt`` -- to include reference sequences needed by grammy
- ``grammy_rdt`` -- to generate read data needed by grammy
- ``grammy_pre`` -- to parse the alignment results and get the probability matrix needed by grammy
- ``grammy_em`` -- to calculate the estimation (not normalized), the extra bootstrap estimations and the final log likelihood
- ``grammy_post`` -- to normalize the result and get the genome length and relative abundance estimates

grammy_gdt Input
----------------

- ``o_prefix`` -- output prefix, ``o_prefix.gdt`` will be the output filename
- ``taxids`` -- taxids to include, ``taxids: t1,t2,...,tm``, each tid is an INTEGER and must be found in ``grefs/gid_tid.dmp``

grammy_gdt Options
------------------

::

  usage: grammy_gdt [-h] [-d DMP] [-r REF] [-p PER] o_prefix taxids

  optional arguments:
    -h, --help         show this help message and exit
    -d DMP, --dmp DMP  gid to tid dump file, default=grefs/gid_tid.dmp
    -r REF, --ref REF  reference genome dir, default=grefs
    -p PER, --per PER  number of genomes per file, default=20

grammy_gdt Output
-----------------

- ``o_prefix.gdt`` -- genome data file needed by grammy
- ``o_prefix.fna.1, ... o_prefix.fna.n`` -- including reference sequences needed by grammy

grammy_rdt Input
----------------

- ``i_prefix`` -- input dir prefix, a dir where reads files reside
- ``o_prefix`` -- output dir prefix, the output will be ``o_prefix/xxx.rdt``, use ``.`` for current dir

grammy_rdt Options
------------------

::

  usage: grammy_rdt [-h] [-s SUF] [-t TEC] [-c CHG] i_prefix o_prefix

  optional arguments:
    -h, --help         show this help message and exit
    -s SUF, --suf SUF  read files suffix, default=fa.gz
    -t TEC, --tec TEC  sequencing tech, default=sanger
    -c CHG, --chg CHG  name change set 'o1:n1,o2:n2', default=

grammy_rdt Output
-----------------

- ``o_prefix.rdt`` -- the read data file needed by grammy
- ``o_prefix.fasta.gz`` -- the zipped reads fasta file

grammy_pre Input
----------------

- ``read_dat`` -- will use ``read_dat.rdt`` as read data file
- ``gen_dat`` -- will use ``gen_dat.gdt`` as genome data file

grammy_pre Options
------------------

::

  usage: grammy_pre [-h] [-m {tbl,bam}] [-p PAR1] [-q PAR2] read_dat gen_dat

  optional arguments:
    -h, --help            show this help message and exit
    -m {tbl,bam}, --mtd {tbl,bam}
                          method for read assignment, tbl -- tabular blast format
    -p PAR1, --par1 PAR1  first parameter for read assignment method, tbl filename or k
    -q PAR2, --par2 PAR2  second parameter for read assignment method, al,id,ev or bg

grammy_pre Output
-----------------

- ``read_dat.mtx`` -- the probability matrix file needed by grammy

grammy_em Input
---------------

- ``read_prob_file`` -- input read probability matrix file from grammy_pre

grammy_em Options
-----------------

::

  usage: grammy_em [-h] [-b BTP] [-t TOL] [-c {U,L}] [-n MIT] [-i {M,R}] read_prob_file

  optional arguments:
    -h, --help            show this help message and exit
    -b BTP, --btp BTP     bootstrap number, default=10
    -t TOL, --tol TOL     tolerance for stopping, default=10e-6
    -c {U,L}, --mtd {U,L}
                          convergence method, (U)niform, (L)ikelihood, default=U
    -n MIT, --mit MIT     maximum number of iteration, default=1000
    -i {M,R}, --ini {M,R}
                          initialization method, (M)oment, (R)andom, default=M

grammy_em Output
----------------

- ``read_prob_file.est`` -- where the estimation is, not normalized
- ``read_prob_file.btp`` -- where the extra bootstrap estimations are
- ``read_prob_file.lld`` -- where final log likelihood is

grammy_post Input
-----------------

- ``mix_par`` -- untransformed mixing parameter estimates, from grammy_em
- ``gen_dat`` -- ``gen_dat.gdt`` genome data file, from grammy_gdt
- ``btp`` -- bootstrap file, from grammy_em

grammy_post Options
-------------------

::

  usage: grammy_post [-h] mix_par gen_dat btp

  optional arguments:
    -h, --help  show this help message if exit

grammy_post Output
------------------

- ``read_prob_file.avl`` -- average genome length estimates
- ``read_prob_file.gra`` -- genome relative abundance, first line is taxon id, second line is relative abundance, last line is error bound

Have fun!
