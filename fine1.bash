#!/bin/bash
#./entropy2.bash
#./find_tk2.bash
cd ~/my-tool-box/sort/
git co 14eea23
make 
cd -
cp ~/my-tool-box/sort/sort.x .
job_id=1
U=0.1
Ed_up=-0.08
Ed_down=-0.08
Lambda=10
alpha=0.69
num_kept=512
smear=1
unsmear=1
dim_imp=4
dim_dot=4
Beta_bar=0.6
Q=0
Q_Sz=0
N_up_N_down=1
occupation=1
N_max=0

Gamma0=0.6
Nz=4
dir=`pwd`

for Vg in 0.5
do
	#for h in 0
	for h in -0.02 -0.04 -0.06 -0.08 -0.1 -0.12 -0.14 -0.16 -0.18 -0.2 -0.22 -0.24 -0.26 -0.28 0 #-0.02 ##0.02 0.04 0.06 0.08 0.1 0.12 0.14 0.16 0.18 0.2 0.22 0.24 0.26 0.28
	do
		awk '{print NR,"        ",$1,"        ",$2,"        ",$2-0.5,"        ",sqrt(($2-0.5)*($2-0.5))}' S_Vg${Vg}_h${h} > disordered
		cat disordered |wc -l > raw_num
		awk '{print NF}' disordered > column_num
		echo 5 > col2order
		./sort.x
		t1=`head -n 1 ordered | tr -s ' ' |cut -d ' ' -f 2`
		d0=`head -n 1 ordered | tr -s ' ' |cut -d " " -f 4`
		dd0=`echo "$d0 100000000"| awk '{ printf "%0.15f\n" ,$1*$2}'|cut -d . -f 1`
		n1=`head -n 1 ordered | tr -s ' ' |cut -d " " -f 1`
		s1=`head -n 1 ordered | tr -s ' ' |cut -d " " -f 3`
		if [ ${dd0} -gt 0 ]
		then
			n2=`expr ${n1} - 1`
			t2=`sed -n "${n2}p" disordered | tr -s ' ' |cut -d " " -f 2`
			s2=`sed -n "${n2}p" disordered | tr -s ' ' |cut -d " " -f 3`
			int1=`echo $s1 |cut -d . -f 2|cut -b 1-4`
			int2=`echo $s2 |cut -d . -f 2|cut -b 1-4`
			d_int1=`echo "sqrt((${int1}-5000)*(${int1}-5000))" |bc`
			d_int2=`echo "sqrt((${int2}-5000)*(${int2}-5000))" |bc`
			if [ ${d_int2} -eq 5000 ]
			then
				echo Warning! point too few.  h=$h  Vg=$Vg
				continue
			fi
			if [ ${d_int1} -lt 10 ]
			then
				#echo $t1 $s1 $int1 $d_int1
				#echo $t2 $s2 $int2 $d_int2 
				continue
			fi
			if [ ${d_int2} -lt 11 ]
			then
				#echo $t1 $s1 $d_int1
				#echo $t2 $s2 $d_int2 
				continue
			fi
		else
			n2=`expr ${n1} + 1`
			t2=`sed -n "${n2}p" disordered | tr -s ' ' |cut -d " " -f 2`
			s2=`sed -n "${n2}p" disordered | tr -s ' ' |cut -d " " -f 3`
			int1=`echo $s1 |cut -d . -f 2|cut -b 1-4`
			int2=`echo $s2 |cut -d . -f 2|cut -b 1-4`
			d_int1=`echo "sqrt((${int1}-5000)*(${int1}-5000))" |bc`
			d_int2=`echo "sqrt((${int2}-5000)*(${int2}-5000))" |bc`
			if [ ${d_int2} == 5000 ]
			then
				echo Warning! point too few.  h=$h  Vg=$Vg
				continue
			fi
			if [ ${d_int2} -lt 10 ]
			then
				#echo $t1 $s1 $int1 $d_int1
				#echo $t2 $s2 $int2 $d_int2 
				continue
			fi
			if [ ${d_int1} -lt 11 ]
			then
				#echo $t1 $s1 $d_int1
				#echo $t2 $s2 $d_int2 
				continue
			fi
		fi
		N=4
		job_R=`qstat|grep \ R\ batch | wc -l`
		job_Q=`qstat|grep \ Q\ batch | wc -l`
		job_num=`echo "${job_R} + ${job_Q}"|bc `
		if [ $job_num -gt 990 ]
		then
			echo Warning! Max job number 990 exceeded.
			echo $h $Vg
			exit
		fi
		#rm -fr h${h}_Vg${Vg}
		mkdir Vg${Vg}_h${h}
		cd Vg${Vg}_h${h}
		dir1=`pwd`
		for z in 0 0.25 0.5 0.75
		do
			#rm -fr $z
			mkdir $z
			cd $z
			#dT=`echo "(${t2}-${t1})/$N" | bc -l`
			dT=`echo "$t2 $t1 $N"| awk '{ printf "%0.15f\n",($1-$2)/$3}'`
			#for temperature in 5.15e-2 3e-2 1e-2 7e-3 5.15e-3 2e-3 9e-4 5.15e-4 2e-4 9e-5 5.15e-5 1e-5 8e-6 5.15e-6 1e-6 8e-7 5.15e-7 1e-7 8e-8 5.15e-8
			#for ((i=1;i<5;i++))
			for ((i=1;i<${N};i++))
			do
				dir2=`pwd`
				#temperature=`echo "0.8 $i 10"| awk '{ printf "%0.15f\n" ,$1^$2*$3}'`
				#temperature=`echo "0.8 $i 0.05"| awk '{ printf "%0.15f\n" ,$1^$2*$3}'`
				temperature=`echo "$t1 $dT $i"| awk '{ printf "%0.15f\n" ,$1+($2*$3)}'`
				#echo $temperature
				omega0=$temperature
				rm -fr $temperature
				mkdir $temperature
				cd $temperature
		
				cp /home/ligy/NRG/fdmnrg.x .
		
				echo $job_id      >  job_id
		
				echo $U           >> input_total
				echo $Ed_up       >> input_total
				echo $Ed_down     >> input_total
				echo $temperature >> input_total
				echo $Lambda      >> input_total
				echo $alpha       >> input_total
				echo $num_kept    >> input_total 
				echo $smear       >> input_total 
				echo $unsmear     >> input_total 
				echo $omega0      >> input_total 
				echo $dim_imp     >> input_total 
				echo $dim_dot     >> input_total 
				echo $Beta_bar    >> input_total 
				echo $Q           >> input_total 
				echo $Q_Sz        >> input_total 
				echo $N_up_N_down >> input_total 
				echo $occupation  >> input_total 
				echo $N_max       >> input_total
		
				echo $temperature >> input_band
				echo $Lambda      >> input_band
				echo $num_kept    >> input_band 
				echo $dim_imp     >> input_band 
				echo $dim_dot     >> input_band 
				echo $Beta_bar    >> input_band 
				echo $Q           >> input_band 
				echo $Q_Sz        >> input_band 
				echo $N_up_N_down >> input_band 
				echo $N_max       >> input_band
		
				cp /home/ligy/NRG/makefreq.cpp .
				cp /home/ligy/NRG/test.submit .
				
				icpc makefreq.cpp -o makefreq.x
				./makefreq.x
		
				cp ~/data_chain_fitting/chain_Lambda${Lambda}_r1_k${Gamma0}_Vg${Vg}_h${h}_z${z}.dat chain_band.dat
				cp ~/data_chain_fitting/chain_Lambda${Lambda}_r1_k${Gamma0}_Vg${Vg}_h${h}_z${z}.dat chain_total.dat
				job_name=$h-$Vg-$z-$i
				qsub -N ${job_name} test.submit
				cd $dir2
			done
			cd $dir1
		done
		cd $dir
		echo $h $Vg
	done
done
rm -f raw_num column_num col2order disordered
job_R=`qstat|grep \ R\ batch | wc -l`
job_Q=`qstat|grep \ Q\ batch | wc -l`
job_num=`echo "${job_R} + ${job_Q}"|bc `
echo total job $job_num
exit 0
