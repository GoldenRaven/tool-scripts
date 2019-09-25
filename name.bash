#!/bin/bash
for file in dos_*
do
	U=0.1
	Gamma0_U=`echo $file |cut -d '_' -f 3 |cut -d U -f 2`
	Gamma0=`awk "BEGIN {print $Gamma0_U*$U}"`
	delta_U=`ls $file |cut -d '_' -f 5 |cut -d U -f 2`
	Ed=`awk "BEGIN {print ${delta_U}*$U-$U/2.0}"`
	mv $file cos_U=${U}_Ed=${Ed}_Gamma0=${Gamma0}_T=1e-9.dat
done
for file2 in cos*
do
	rename cos dos $file2
done
