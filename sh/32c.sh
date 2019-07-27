###!/usr/bin/env bash
echo "begining"
date
path=`pwd`

fasta="88af4276-749a-4928-81e8-2361b2da1324_gdc_realn_rehead"
data=${path}/QC/${fasta}
time grammy_rdt ${path} ${path} -s fasta 
#time bwa mem -p -a -S -t 6 reference.fna.1 ${fasta}.fasta > ${fasta}.sam

time bwa mem -a -S -t 6 reference.fna.1 ${data}/${fasta}_1.fasta ${data}/${fasta}_2.fasta > ${fasta}.sam

time samtools view -bS ${fasta}.sam > ${fasta}.bam

time samtools sort ${fasta}.bam -o ${fasta}.sorted.bam

mv ${fasta}.sorted.bam ${fasta}.sorted.bam.1

time samtools index ${fasta}.sorted.bam.1

time grammy_pre ${fasta} reference -q 24,24,33 -m bam -p ${fasta}.sorted.bam

time grammy_em -b=0 ${fasta}.bam.mtx

time grammy_post ${fasta}.bam.est reference ${fasta}.bam.btp

echo "finished"
date

#path=`pwd`
#fasta="7dadfb04-1d05-43fe-80b9-f767e22d02f5_crc"
#/usr/bin/time -v -o ${y}.log GRAMMy ${path} ${y}
#date
#GRAMMy ${path} ${fasta} 
