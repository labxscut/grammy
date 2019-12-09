#!/bin/bash
echo "#usage:"
echo "#  prep_grammy.sh \${reference_db} \${taxid_gid_dump} \${oprefix_tid}"
echo "#example:"
echo "#  prep_grammy.sh grefs tgid.dmp iggdb"
echo "#output:"
echo "#  \${oprefix}.gdt"
echo "#  \${oprefix}.fna.? (bwa indexed)"
echo "#require:"
echo "#  in \${reference_db}/\${taxid}/genomes.fna:"
echo "#  >gi|\${gid}|"
echo "#  CTTTTTTAGTGAAATATTAGTTCATTTTCTTTCAAGAAAGGGAACTATACACTAAACATG"
echo "#and:"
echo "#  in \${taxid_gid_dump}:"
echo "#  66396406685304	663964066"
echo "#and:"
echo "#  in \${oprefix_tid}:"
echo "#  66396406685304,"

if [[ -z $3 ]]; then
  exit
fi

reference_db=$1
taxid_gid_dump=$2
oprefix_tid=$3
oprefix=${oprefix_tid%.tid}

cogs=""
if [[ -e "${oprefix}.fna.1" || -e "${oprefix}.gdt" ]]; then
  echo "#${oprefix}.fna.1 or ${oprefix}.gdt already exists, please remove them"
  exit
fi

for taxid in `cat ${oprefix}.tid | tr ',' '\n'`; do
  cmd="time cat ${reference_db}/${taxid}/genomes.fna >>${oprefix}.fna"
  echo $cmd
done;

cmd="time grammy_gdt ${oprefix} ${oprefix}.tid -d ${taxid_gid_dump}  -r ${reference_db} -p 30000000"
echo "#  use -p 30000000 or larger to make sure only one output fna.1 file"
echo $cmd

cmd="time bwa index -a bwtsw ${oprefix}.fna.1"
echo "#  this could takes a very long time if a large number of references were included"
echo $cmd
