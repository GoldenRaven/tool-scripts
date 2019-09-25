#!/bin/bash
dir=`pwd`
cd /home/ligy/program/my-tool-box/sort/
git co 3827
make clean
make
cp sort.x $dir
git co master
cd $dir
#
for file in dos_Vg*
do
    mv $file disordered
    awk '{print NF}' disordered > column_num
    cat disordered |wc -l > raw_num
    echo 1 > col2order
    ./sort.x
    mv ordered $file
done
rm -f disordered ordered col2order raw_num column_num sort.x
