###!/usr/bin/env bash
###################QC
main_directory=`pwd`

mkdir ${main_directory}/QC
qc=${main_directory}/QC
result_directory=${main_directory}/fastq

for x in `cat ${main_directory}/dataname.txt`
do 
y=${x%.bam}
mkdir ${qc}/${y}
cd ${qc}/${y}
#####qc for paired-end
#fastp -q 15 -u 40 -n 10 -l 36 --detect_adapter_for_pe -G -M 0 -i ${result_directory}/${y}/${y}_unmappedtwo_1.fastq -I ${result_directory}/${y}/${y}_unmappedtwo_2.fastq -o ${y}_unmappedtwo_1.fp.fastq -O ${y}_unmappedtwo_2.fp.fastq
fastp -q 0 -u 100 -n 10 -l 36 -A -G -M 0 -i ${result_directory}/${y}/${y}_unmappedtwo_1.fastq -I ${result_directory}/${y}/${y}_unmappedtwo_2.fastq -o ${y}_unmappedtwo_1.fp.fastq -O ${y}_unmappedtwo_2.fp.fastq
#####qc for single-end
fastp -q 0 -u 100 -n 10 -l 36 -A -G -M 0 -i ${result_directory}/${y}/${y}_unmappedone.fastq -o ${y}_unmappedone.fp.fastq
#############fqtofa
seqkit fq2fa ${y}_unmappedtwo_1.fp.fastq -o ${y}_unmappedtwo_1.fp.fasta
seqkit fq2fa ${y}_unmappedtwo_2.fp.fastq -o ${y}_unmappedtwo_2.fp.fasta

seqkit fq2fa ${y}_unmappedone.fp.fastq -o ${y}_unmappedone.fp.fasta 

awk '{ if(NR%2==1) { print $0 "/1" } else { print $0 } }' ${y}_unmappedone.fp.fasta >${y}_unmappedone_1.fp.fasta
###generate reverse seq
seqkit seq ${y}_unmappedone.fp.fasta   -r  -p  > ${y}_unmappedone.fp.fasta.rev
awk '{ if(NR%2==1) { print $0 "/2" } else { print $0 } }' ${y}_unmappedone.fp.fasta.rev >${y}_unmappedone_2.fp.fasta

####merge fasta
cat ${y}_unmappedtwo_1.fp.fasta >> ${y}_1.fasta

cat ${y}_unmappedtwo_2.fp.fasta >> ${y}_2.fasta

cat ${y}_unmappedone_1.fp.fasta >> ${y}_1.fasta

cat ${y}_unmappedone_2.fp.fasta >> ${y}_2.fasta

cat ${y}_1.fasta >> ${y}.fasta
cat ${y}_2.fasta >> ${y}.fasta
###sort 
#seqkit sort -n ${y}.fasta > ${y}.sort.fasta

cd ${main_directory}
mkdir ${main_directory}/fasta

cp ${qc}/${y}/${y}.fasta .

cd ${main_directory}/fasta
cp ${qc}/${y}/${y}_1.fasta .
cp ${qc}/${y}/${y}_2.fasta .

done
