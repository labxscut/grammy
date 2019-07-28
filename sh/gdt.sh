#!/bin/bash
main="/usr/test"
cd ${main}
res_dir="./grefs" ## 原始的reference的目录

cogs=""
for file in `ls ${res_dir}`
do
	cogs=${cogs}","${file}
done

cogs=${cogs#,}
echo ${cogs} >see.txt
echo "grammy_gdt reference see.txt -d ./tgid.csv  -r ${res_dir} -p 30000000"
echo "bwa index -a bwtsw reference.fna.1"

