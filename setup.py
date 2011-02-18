#!/usr/bin/env python

"""GRAMMY GENOME Relative Abundance based on Mixture Model theorY.

TODO:
"""

import setuptools
from setuptools import setup
from distutils.command import build
from distutils.core import Extension
#from distutils.core import setup
#from setuptools import build, setup, Extension
#import distutils.sysconfig as ds 
import os, sys

doclines=__doc__.splitlines()

if os.path.exists('MANIFEST'): os.remove('MANIFEST')

os.environ['CC'] = 'g++'  #temporary measure to trick distutils use g++, need update to distutils2

#compcore_module = Extension('lsa/_compcore', sources=['lsa/compcore_wrap.cpp', 'lsa/compcore.cpp'] , )
# in above settings, put compcore.cpp, compcore.h, compcore.i file in lsa subdir
# use swig -python -c++ lsa/compcore.i -o compcore_wrap.cpp 
# then use python setup.py build
# _compcore.so shall appear in lsa subdir in build/build-arch dir
# when import module shall use import lsa.xxx

class my_build(build.build):
# different order: build_ext *before* build_py, so that 
# build_py can already use ctypes! 
  sub_commands = [('build_ext', build.build.has_ext_modules),
                  ('build_py', build.build.has_pure_modules),
                  ('build_clib', build.build.has_c_libraries),
                  ('build_scripts', build.build.has_scripts), ]

setup(name="gem",
  version="0.3.0",
  description=doclines[0],
  long_description="\n".join(doclines[2:]),
  author="Li Xia",
  author_email="lxia@usc.edu",
  download_url="somewhere to download",
  url="somewhere to download",
  license="BSD",
  platforms=["Any"],
  packages=['gem'],
  requires=['numpy(>=1.2.1)','scipy(>=0.6.0)','python(>=2.5.1)','swig(>=1.3.36)'],
  provides=['gem'],
  ext_modules = [ Extension( 'gem._gemcore',
                      depends=['gem/gemcore.hpp', 'gem/mmio.h'],
                      language ='c++',
                      libraries = ['stdc++'],  #trick to seduce distutils use g++ instead of gcc
                      sources = ['gem/gemcore.i', 'gem/gemcore.cpp', 'gem/mmio.c'],
                      include_dirs = [ os.environ['HOME']+'/usr/include' ],
                      library_dirs = [ os.environ['HOME']+'/usr/lib' ],
                      swig_opts=['-c++', '-classic', '-verbose']),
                  #Extension( 'gem._kmercore',
                  #    sources = ['gem/kmercore.i', 'gem/kmercore.cpp'],
                  #    depends=['gem/kmercore.hpp', 'gem/mmio.h'],
                  #    include_dirs = [ os.environ['HOME']+'/usr/include' ],
                  #    library_dirs = [ os.environ['HOME']+'/usr/lib' ],
                  #    swig_opts=['-c++', '-classic', '-verbose'])
                ],
  keywords = ('python', 'gem', 'EM', 'Mixture Models'),
  #py_modules = ['gem.gemcore', 'gem.kmercore', 'gem.gemlib', 'gem.gemaux', 'gem.gemutil'],
  py_modules = ['gem.gemcore', 'gem.gemlib', 'gem.gemaux', 'gem.gemmath', 'gem.gemutil'],
  scripts = ['grammy-em.py', 'grammy-pre.py', 'grammy-post.py', 'grammy-gdt.py', 'grammy-rdt.py'],
  cmdclass = {'build': my_build},
  classifiers = [ 'Development Status :: 5 - Production/Stable',
                      'Environment :: Console',
                      'Intended Audience :: Scientists',
                      'License :: OSI Approved :: BSD License',
                      'Operating Systems :: POSIX',
                      'Programming Language :: Python',
                      'Programming Language :: C++',
                      'Topic :: Biological Sciences',
                ],
)
