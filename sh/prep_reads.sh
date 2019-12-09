#!/bin/bash

echo "#usage:"
echo "#  prep_reads.sh \${data_bam}"
echo "#example:"
echo "#  prep_reads.sh bam/88af4276-749a-4928-81e8-2361b2da1324_gdc_realn_rehead.bam"
echo "#output:"
echo "#  \${data_prefix}=(\$(basename \${data_bam})\%.bam)"
echo "#  fastq/\${data_prefix}.bam/\${data_prefix}_1.fasta"
echo "#  fastq/\${data_prefix}.bam/\${data_prefix}_2.fasta"
echo "#require: seqkit and fastp"
echo "#  wget http://app.shenwei.me/data/seqkit/seqkit_linux_amd64.tar.gz && tar -zxvf seqkit_linux_amd64.tar.gz"
echo "#  wget http://opengene.org/fastp/fastp && chmod a+x ./fastp"

data_bam=$1
data_prefix=`basename ${data_bam}`
data_prefix=${data_prefix%.bam}
out_dir="fastq/${data_prefix}.bam"
out_prefix="${out_dir}/${data_prefix}"

if [[ -z $1 ]]; then
  exit
fi
if [[ ! -e ${data_bam} ]]; then
  echo "#${data_bam} does not exist, please make sure"
  exit
fi
if [[ ! -e ${out_dir} ]]; then
  echo "#${out_dir} does not exist, will be created"
  cmd="mkdir -p ${out_dir}"
  echo $cmd
else
  echo "#WARNING: ${out_dir} already exists, it will be overwritten"
fi

########one read of the pair is unmapped
cmd="samtools view -u -f 4 -F 264 ${data_bam} -o ${out_prefix}_unmappedone.bam"
echo $cmd
  
cmd="samtools view ${out_prefix}_unmappedone.bam | cut -f1,10,11 | sed 's/^/@/' | sed 's/\t/\n/' | sed 's/\t/\n+\n/' > ${out_prefix}_unmappedone.fastq"
echo $cmd

########both reads of the pair are unmapped
cmd="samtools view -u -f 12 -F 256 ${data_bam} -o ${out_prefix}_unmappedtwo.bam"
echo $cmd
cmd="samtools view ${out_prefix}_unmappedtwo.bam | cut -f1,10,11 | sed 's/^/@/' | sed 's/\t/\n/' | sed 's/\t/\n+\n/' > ${out_prefix}_unmappedtwo.fastq"
echo $cmd

cmd="awk '0 == ((NR+4) % 8)*((NR+5) % 8)*((NR+6) % 8)*((NR+7) %8)' ${out_prefix}_unmappedtwo.fastq | awk '{ if(NR%4==1) { print \$0 "/1" } else { print \$0 } }' > ${out_prefix}_unmappedtwo_1.fastq"
echo $cmd

cmd="awk '0 == (NR % 8)*((NR+1) % 8)*((NR+2) % 8)*((NR+3) %8)' ${out_prefix}_unmappedtwo.fastq | awk '{ if(NR%4==1) { print \$0 "/2" } else { print \$0 } }' > ${out_prefix}_unmappedtwo_2.fastq"
echo $cmd

### 
### see ./fastp and ./seqkit for other options available
### and manually edit here

#####qc for paired-end
#fastp -q 15 -u 40 -n 10 -l 36 --detect_adapter_for_pe -G -M 0 -i ${result_directory}/${y}/${y}_unmappedtwo_1.fastq -I ${result_directory}/${y}/${y}_unmappedtwo_2.fastq -o ${y}_unmappedtwo_1.fp.fastq -O ${y}_unmappedtwo_2.fp.fastq
cmd="fastp -q 0 -u 100 -n 10 -l 36 -A -G -M 0 -i ${out_prefix}_unmappedtwo_1.fastq -I ${out_prefix}_unmappedtwo_2.fastq -o ${out_prefix}_unmappedtwo_1.fp.fastq -O ${out_prefix}_unmappedtwo_2.fp.fastq"
echo $cmd

#####qc for single-end
fastp -q 0 -u 100 -n 10 -l 36 -A -G -M 0 -i ${result_directory}/${y}/${y}_unmappedone.fastq -o ${y}_unmappedone.fp.fastq
#############fqtofa
###double unmapped
seqkit fq2fa ${y}_unmappedtwo_1.fp.fastq -o ${y}_unmappedtwo_1.fp.fasta
seqkit fq2fa ${y}_unmappedtwo_2.fp.fastq -o ${y}_unmappedtwo_2.fp.fasta

###complement with reverse seq for single-end unmapped data to balance counts, concept similar
seqkit fq2fa ${y}_unmappedone.fp.fastq -o ${y}_unmappedone.fp.fasta 
awk '{ if(NR%2==1) { print $0 "/1" } else { print $0 } }' ${y}_unmappedone.fp.fasta >${y}_unmappedone_1.fp.fasta
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
#mkdir ${main_directory}/fa

cp ${qc}/${y}/${y}.fasta .

#cd ${main_directory}/fa
#cp ${qc}/${y}/${y}_1.fasta .
#cp ${qc}/${y}/${y}_2.fasta .
