###!/bin/bash

echo "#run grammy on one specified dataset"
echo "#usage:"
echo "#  run_grammy.sh \${fasta_dir} \${data_prefix} \${reference}"
echo "#example:"
echo "#  run_grammy.sh . test" 
echo "#require a dataset structure:"
echo "#  \${reference}.fna.1                   #indexed microbial reference file"
echo "#  \${fasta}/\${data_prefix}_1.fasta     #qc-ed read_1 fasta file"
echo "#  \${fasta}/\${data_prefix}_2.fasta     #qc-ed read_2 fasta file"

fasta_dir=$1
data_prefix=$2
reference=$3


cmd="time grammy_rdt ${path} ${path} -s fasta"
echo $cmd

#for x in `cat ${path}/dataname.txt`; do 

fasta=${x%.bam}
data=${path}/QC/${fasta}

#time bwa mem -p -a -S -t 6 reference.fna.1 ${fasta}.fasta > ${fasta}.sam

cmd="time bwa mem -a -S -t 6 reference.fna.1 ${data}/${fasta}_1.fasta ${data}/${fasta}_2.fasta | samtools view -bS  | samtools sort ${fasta}.bam > ${fasta}.sorted.bam.1"
echo $cmd

cmd="time samtools index ${fasta}.sorted.bam.1"
echo $cmd

cmd="time grammy_pre ${fasta} reference -q 24,24,33 -m bam -p ${fasta}.sorted.bam"
echo $cmd

time grammy_em -b=0 ${fasta}.bam.mtx

time grammy_post ${fasta}.bam.est reference ${fasta}.bam.btp

echo "finished"
date

done
#path=`pwd`
#fasta="7dadfb04-1d05-43fe-80b9-f767e22d02f5_crc"
#/usr/bin/time -v -o ${y}.log GRAMMy ${path} ${y}
#date
#GRAMMy ${path} ${fasta} 
