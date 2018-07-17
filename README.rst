.. |Logo| image:: https://bitbucket.org/charade/grammy/raw/master/doc/images/grammy_logo.png
   :alt: logo.png
   :height: 25px
   :width: 25px

.. |Model| image:: https://bitbucket.org/charade/grammy/raw/master/doc/images/grammy_model.png
   :alt: model.png
   :height: 200px
   :width: 200px

|Logo| GRAMMy: Genome Relative Abundance Mixture Model for Shotgun Metagenomics Analysis
=========================================================================================================

QUICK LINKS
-----------

`Manuals <https://bitbucket.org/charade/grammy/wiki/Manual>`__

`FAQ <https://bitbucket.org/charade/grammy/wiki/FAQ>`__

INTRODUCTION
--------------------------------------------------------

GRAMMy is a computational framework developed for Genome Relative Abundance using Mixture Model theory (GRAMMy) based estimation. Accurate estimation of microbial community composition based on metagenomic sequencing data is fundamental for metagenomics analysis. Prevalent estimation methods are mainly based on directly summarizing alignment results or its variants; often result in biased and/or unstable estimates. We developed the Genome Relative Abundance using Mixture Model theory (GRAMMy) approach estimate genome relative abundance based on shotgun reads. GRAMMy has been demonstrated to give estimates that are accurate and robust across both simulated and real read benchmark datasets.

IMPLEMENTATION
--------------------------------------------------------

|Model|

Figure 1. The GRAMMy model. A schematic diagram of the finite mixture model underlies the GRAMMy framework for shotgun metagenomics.

Software
--------------------------------------------------------

Genome Relative Abundance using Mixture Model thoery (GRAMMy).
Currently the package works for Linux (Ubuntu) platforms.
It might work for Windows with Cygwin and Mac with Xcode and Mac ports (not tested).
It requires the Standard C++ Library with Technical Draft One.

Use of resources:
    C++ build environment
	      e.g. build-essential and libstdc++6 in Ubuntu and Xcode in Mac 
    Python(>=2.7) with developemnt and setuptools
        download @ http://www.python.org/
    Numpy(>=1.0)
        download @ http://www.scipy.org/
    Scipy(>=0.6)
        download @ http://www.scipy.org/
    Biopython(>=1.0)
        download @ http://biopython.org/

Docker (Platform Independent - Preferred)
--------------------------------------------------------

A Dockerfile is provided to build elsa enabled docker image from a standard Ubuntu docker image.
  To build a docker image using 'docker build $GRAMMYPKG', where $GRAMMYPKG is the unzipped path of elsa.
  Or download the Dockerfile directly at:

    https://bitbucket.org/charade/grammy/raw/master/Dockerfile

  Name the built container as your:container; Then mount current data directory to /var/data accessible by docker:

    ::

      sudo docker run -it -v `pwd`:/var/data/ your:container
      sudo docker run cd /var/data/ && grammy_pre ...

Install
--------------------------------------------------------

1. Install Prerequisites

    Please fullfill the prerequisites of C++, Python (with development and setuptools),
    numpy, scipy and biopython as described in README.txt before installing GRAMMy.

2. Linux (Ubuntu)

    Download the latest release of GRAMMy from http://meta.usc.edu/softs/grammy.
    Follow standard python module setup to install:
        $tar -zxvf charade-grammy-release.tar.gz
        $cd charade-grammy-release
        $python setup.py install
        $cd test
        $. test.sh

3. Development

    GRAMMy is open source and the version controled repository is @:
    	https://bitbucket.org/charade/grammy.
    Use mercurial tools (http://mercurial.selenic.com) to download a local copy:
        $hg clone ssh://hg@bitbucket.org/charade/grammy grammy-tip

    Follow standard python module setup to install:
        $cd grammy-tip
        $python setup.py install

Executables
--------------------------------------------------------

  grammy_gdt
  grammy_rdt
  grammy_pre
  gramyy_em
  grammy_post

Usage
--------------------------------------------------------

(i) Above executables will be available from your python scripts directory.
  	Use '-h' to read individual script usage.
(ii) A pre-structured genome and taxon directory is required for grammy_gdt.py;
   	An example is available as the grefs.tgz file.
   	The file can be downloaded from http://meta.usc.edu/softs/grammy/grefs.tgz
(iii) A simple test example is available at 'test/test.sh' and explained with in.

WIKI
--------------------------------------------------------

GRAMMy's https://bitbucket.org/charade/grammy/wiki/ page is an growing resource for manuals, FAQs and other information. This is a MUST read place before you actually using the GRAMMy tool. These documentations are also openly editable. You are more than welcome to contribute to this ongoing documentation.

CONTACTS
--------------------------------------------------------

Questions and comments shall be addressed to fsun@usc.edu and l.c.xia@stanford.edu.

CITATIONS
--------------------------------------------------------

1. Accurate Genome Relative Abundance Estimation Based on Shotgun Metagenomic Reads. LC Xia, JA Cram, T Chen, JA Fuhrman, F Sun. PloS ONE 6 (12), e27992 (https://doi.org/10.1371/journal.pone.0027992) - for grammy software
2. Integrated Metagenomic Data Analysis Demonstrates That A Loss Of Diversity In Oral Microbiota Is Associated With Periodontitis. D Ai, R Huang, J Wen, C Li, J Zhu, LC Xia# (https://doi.org/10.1186/s12864-016-3254-5) - for docker pipeline
