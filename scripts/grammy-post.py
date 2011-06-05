#!/usr/bin/env python

import optparse as op
import numpy as np
import os, sys, platform
from scipy.io import mmio
from scipy import sparse

BLD_DIR="./build/lib.linux-%s-2.6/gem"
sys.path.append( BLD_DIR % platform.machine() )
from grammy import gemaux, gemlib, gemcore, gemmath, gemutil

def main():
  #
  usage_error = "usage: %prog [options] mix_par.est gen_dat.gdt perm.btp"
  parser = op.OptionParser(usage_error)
  #parser.add_option("-e","--estf", dest="est_fn", type="string", help="input estimated mixing parameters file", metavar="FILE")
  #parser.add_option("-g","--gdtf", dest="gdt_fn", type="string", help="input genome data file", metavar="FILE")
  #parser.add_option("-b","--btpf", dest="btp_fn", type="string", help="input bootstrap mixing parameters file", default=None, metavar="FILE")
  (options, args) = parser.parse_args()

  if len(args) != 2:
    #
    parser.error(usage_error)

  gdt = gemaux.Genome_Data()
  gdt.read( args[1] )
  f = np.loadtxt( args[0] )
  bts = np.loadtxt( args[2] )
  l = np.array( [ gdt.taxid_length[tid] for tid in gdt.taxids ], dtype='float' )
  assert len(l) == len(f) - 1
  a = gemmath.inverse_proportion_normalize( f, l ) 
  abd_bsd = gemmath.bootstrap_standard_error( f, l, bts )
  est_avl = gemmath.weighted_average( a, l )

  #output >> .gra
  #output >> .avl
  gra_file = open( os.path.basename(args[0]), 'w' )
  print >>gra_file, '\n'.join( [ '\t'.join( [ str(v) for v in gdt.taxids ] ), '\t'.join( [ "%.4g" % v for v in a ] ), '\t'.join( [ "%.4g" % v for v in abd_bsd ] ) ] )  
  avl_file = open( os.path.basename(args[1]), 'w' )
  print >>avl_file, est_avl

if __name__ == "__main__":
  #
  main()
