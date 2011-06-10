###the script is an test example of grammy with step to step explanation###

#first generate the genome data needed by grammy
#let us give the output name 'test' and supply the taxids we want to include in the 'test' set
grammy-gdt.py test 228908,290400,292414,314225,335992,190192,272557,272844,70601,326442,312309,216895,243274,243090,167879,316279,177439,267377,178306,283942,223926,243232,196600,188937,224325,74547,84588,298386,167539,246200,186497,235909,59919,221109
#now we have test.gdt and test.fna.1 and test.fna.2 three new files
#test.gdt is genome data file needed by grammy
#test.fna.1 and test.fna.2 is genome data

#second we generate the read data needed by grammy
grammy-rdt.py . .
#now we have two additional files
#c0_L100_N1000_S1.rdt is the read data file need by grammy
#c0_L100_N1000_S1.fasta.gz is the zipped reads fasta file

#third we prepare the probablity matrix file will be used by grammy
#c0_L100_N1000_S1.tblat.1 and c0_L100_N1000_S1.tblat.2 are two mapping result files
grammy-pre.py c0_L100_N1000_S1 test
#now we parsed the two result files and get the c0_L100_N1000_S1.mtx file need by grammy

#fourth we carry out the EM esimation
grammy-em.py c0_L100_N1000_S1.mtx
#we have three new files
#c0_L100_N1000_S1.est, where the estimation is, not normalized
#c0_L100_N1000_S1.btp, where the extra bootstrap estimations are
#c0_L100_N1000_S1.lld, final log likelihood

#fifth we normalize the result and get the genome length and relative abundance estimates
grammy-post.py c0_L100_N1000_S1.est test c0_L100_N1000_S1.btp
#c0_L100_N1000_S1.avl, average genome length estimates
#c0_L100_N1000_S1.gra, genome relative abundance, first line is taxon id, second line is relative abundance, last line is error bound
