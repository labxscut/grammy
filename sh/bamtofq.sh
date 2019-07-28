#!/bin/bash
###filter unmappedone & unmappedtwo fastq
main_directory="/usr/test"
data_directory=${main_directory}/bam
mkdir ${main_directory}/fastq
result_directory=${main_directory}/fastq

cd ${main_directory}
ls ${data_directory} > dataname.txt

for x in `cat ${main_directory}/dataname.txt`
do
y=${x%.bam}
mkdir ${result_directory}/${y}
cd ${result_directory}/${y}


########unmapped reads whose mate are mapped and filter fastq
samtools view -u -f 4 -F 264 ${data_directory}/${x} -o ${y}_unmappedone.bam

samtools view ${y}_unmappedone.bam | cut -f1,10,11 | sed 's/^/@/' | sed 's/\t/\n/' | sed 's/\t/\n+\n/' > ${y}_unmappedone.fastq

########both reads of the pair are unmapped
samtools view -u -f 12 -F 256 ${data_directory}/${x} -o ${y}_unmappedtwo.bam
samtools view ${y}_unmappedtwo.bam | cut -f1,10,11 | sed 's/^/@/' | sed 's/\t/\n/' | sed 's/\t/\n+\n/' > ${y}_unmappedtwo.fastq

awk '0 == ((NR+4) % 8)*((NR+5) % 8)*((NR+6) % 8)*((NR+7) %8)' ${y}_unmappedtwo.fastq | awk '{ if(NR%4==1) { print $0 "/1" } else { print $0 } }' > ${y}_unmappedtwo_1.fastq

awk '0 == (NR % 8)*((NR+1) % 8)*((NR+2) % 8)*((NR+3) %8)' ${y}_unmappedtwo.fastq | awk '{ if(NR%4==1) { print $0 "/2" } else { print $0 } }' > ${y}_unmappedtwo_2.fastq

cd ${main_directory}

done
