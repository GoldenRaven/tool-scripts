#!/bin/bash
Nz=4
for file in Vg*
do
	Vg=`echo $file |cut -d "_" -f 1 |cut -d g -f 2`
	h=`echo $file |cut -d "_" -f 2 |cut -d h -f 2`
	cd $file
	rm -f *.dat
	for z in 0*
	do
		cd $z
		for T in 1e-9
		do
			cd $T
			cp freq_dos_unsmeared.dat ../../dos_${T}_${z}.dat
			cd ..
		done
	done
	cd ..
	paste dos_${T}_* > dos
	awk '{print $1,"    ",($2+$6+$10+$14)/4,"    ",($3+$7+$11+$15)/4,"    ",($4+$8+$12+$16)/4}' dos > dos_${T}.dat
	rm -f dos dos_${T}_*.dat
	cd ..
done
