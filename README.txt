README.txt


INTRODUCTION:
    Genome Relative Abundance using Mixture Model thoery (GRAMMy)
    Currently the package works for Linux (Ubuntu) platforms.
    It might work for Windows with Cygwin (not tested).
    More current information of this package is available @
	http://meta.usc.edu/softs/grammy

DEPENDENCIES:
    C++ build environment
	e.g. build-essentials and libstdc++ in Ubuntu and Xcode in Mac 
    Python(>=2.7) with developemnt and setuptools
        download @ http://www.python.org/
    Numpy(>=1.0)
        download @ http://www.scipy.org/
    Scipy(>=0.6)
        download @ http://www.scipy.org/
    Biopython(>=1.0)
        download @ http://biopython.org/
    
    For setting up the dependencies, users may refer to the author's development document @
	http://dl.dropbox.com/u/35182955/Ubuntu_development_environment.html

FILES:
    LICENSE.txt
    README.txt
    MANIFEST.in
    setup.py
    grammy/*

INSTALL:

    [Prerequisites]

    Please fullfill the prerequisites of C++, Python (with development and setuptools),
    numpy, scipy and biopython as described in README.txt before installing GRAMMy.

    [Linux] (Ubuntu)

    Download the latest release of GRAMMy from http://meta.usc.edu/softs/grammy.
    Follow standard python module setup to install:
        $tar -zxvf charade-grammy-release.tar.gz
        $cd charade-grammy-release
        $python setup.py install

    [Development]

    GRAMMy is open source and the version controled repository is @:
    	https://bitbucket.org/charade/grammy.
    Use mercurial tools (http://mercurial.selenic.com) to download a local copy:
        $hg clone ssh://hg@bitbucket.org/charade/grammy grammy-tip

    Follow standard python module setup to install:
        $cd grammy-tip
        $python setup.py install

EXECUTABLES:
    grammy_gdt
    grammy_rdt
    grammy_pre
    grammy_em
    grammy_post

USAGE:
    (i) Above executables will be available from your python scripts directory.
    	Use '-h' to read individual script usage.
    (ii) A pre-structured genome and taxon directory is required for grammy_gdt.py;
    	An example is available as the grefs.tgz file.
    	The file can be downloaded from http://meta.usc.edu/softs/grammy/grefs.tgz
    (iii) A simple test example is available at 'test/test.sh' and explained with in.

