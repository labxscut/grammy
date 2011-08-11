README.txt(v1.0.0)


PACKAGE NAME:
    Genome Relative Abundance using Mixture Model thoery (GRAMMy)
    Currently the package works for Linux (Ubuntu) and Mac (Snow Leopard) platforms.
    It might be work for Windows with Cygwin (not tested).

DEPENDENCY:
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
	http://dl.dropbox.com/u/35182955/Mac_development_environment.html
	http://dl.dropbox.com/u/35182955/Ubuntu_developement_environment.html

FILES:
    LICENSE.txt
    README.txt
    INSTALL.txt
    MANIFEST.in
    setup.py
    grammy/*
    doc/*
    test/*

INSTALL:
    Refer to INSTALL.txt

EXECUTABLES:
    grammy-gdt
    grammy-rdt
    grammy-pre
    grammy-em
    grammy-post

USAGE:
    (i) Above executables will be available from your python scripts directory.
    	Use '-h' to read individual script usage.
    (ii) A pre-structured genome and taxon directory if required for grammy-gdt.py;
    	An example is available as the grefs.tgz file.
    	The file can be downloaded from http://meta.usc.edu/softs/grammy/grefs.tgz
    (iii) A simple test example is available at 'test/test.sh' and explained with in.

DOCUMENTATION:
    (i) developement information of grammy sub modules, e.g. grammy.gemlib model,
    	can be viewed by issuing "pydoc grammy.gemlib" command on command line. 
    (ii) information of how to use this package for analysis data by examples can
    	be found in documentation in "doc" subdirectory. (this is not up2date)


