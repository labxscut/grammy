#!/bin/bash

res_dir="/usr/test/grefs" ## 原始的reference的目录

cogs=""
for file in `ls ${res_dir}`
do
	cogs=${cogs}","${file}
done

cogs=${cogs#,}
echo ${cogs} > /usr/test/see.txt
echo "grammy_gdt /usr/test/reference /usr/test/see.txt -d /usr/test/tgid.csv  -r ${res_dir} -p 30000000"
echo "bwa index -a bwtsw /usr/test/reference.fna.1"

