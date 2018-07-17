.. |Logo| image:: https://bitbucket.org/charade/grammy/raw/master/doc/images/logo.png
   :alt: logo.png
   :height: 25px
   :width: 25px

.. |Model| image:: https://bitbucket.org/charade/grammy/raw/master/doc/images/model.png
   :alt: model.png
   :height: 200px
   :width: 200px

|Logo| GRAMMy: Genome Relative Abundance using Mixture Models - a Tool for Shotgun Metagenomics Analysis
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

AVAILABILITY
--------------------------------------------------------

# Download and use SunLab virtual box machine with pre-installed GRAMMy at: http://meta.usc.edu/softs/vbox/SunLab.vdi.tgz. Check the md5sum to ensure integrity of the file: http://meta.usc.edu/softs/vbox/SunLab.vdi.tgz.md5.txt. Look into the README.txt file viewable from https://bitbucket.org/charade/grammy for detailed information.
# Download released source code package at: https://bitbucket.org/charade/grammy/get/release.tar.gz and install. Look into the README.txt file within the package (also viewable from https://bitbucket.org/charade/grammy) for detailed installation information and others.
# Development source code access at: https://bitbucket.org/charade/grammy.
The python package is made open source for advanced users to pipeline the analysis or implement other variants.
# An example genome and texon id dump directory can be downloaded here: grefs.tgz.
An test example with step by step explanation can be found in 'test/test.sh' within the package.

WIKI
--------------------------------------------------------

GRAMMy's https://bitbucket.org/charade/grammy/wiki/ page is an growing resource for manuals, FAQs and other information. This is a MUST read place before you actually using the GRAMMy tool. These documentations are also openly editable. You are more than welcome to contribute to this ongoing documentation.

CONTACTS
--------------------------------------------------------

Questions and comments shall be addressed to fsun@usc.edu and l.c.xia@stanford.edu.

CITATIONS
--------------------------------------------------------

1. Accurate Genome Relative Abundance Estimation Based on Shotgun Metagenomic Reads. LC Xia, JA Cram, T Chen, JA Fuhrman, F Sun. PloS ONE 6 (12), e27992 (https://doi.org/10.1371/journal.pone.0027992) - grammy software
2. Integrated Metagenomic Data Analysis Demonstrates That A Loss Of Diversity In Oral Microbiota Is Associated With Periodontitis. D Ai, R Huang, J Wen, C Li, J Zhu, LC Xia# (https://doi.org/10.1186/s12864-016-3254-5) - docker pipeline
