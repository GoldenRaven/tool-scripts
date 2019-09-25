#rm -fr `find .|grep -v "\<job.bash\>"`

job_id=1
U=0.1
#Ed_up=-0.076
#Ed_down=-0.076
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

Nz=4
dir=`pwd`
Vg=0
h=0

for Gamma0_U in 6 #3 4 5 6 7 8 9
do
	Gamma0=`awk "BEGIN {print $Gamma0_U*$U}"`
	#Gamma0=`echo "${Gamma0_U}*$U"|bc -l`
	for delta_U in -0.29 -0.30
	do
		Ed_up=`awk "BEGIN {print ${delta_U}*$U-$U/2.0}"`
		Ed_down=${Ed_up}
		echo $Gamma0  $Ed_up
		mkdir Gamma0_U${Gamma0_U}_delta_U$delta_U
		cd Gamma0_U${Gamma0_U}_delta_U$delta_U
		dir1=`pwd`
		for z in 0 0.25 0.5 0.75
		do
			#rm -fr $z
			mkdir $z
			cd $z
			#for temperature in 1e-9
			for ((i=0;i<120;i=i+2))
			do
				dir2=`pwd`
				#temperature=`echo "0.7 $i 0.1"| awk '{ printf "%0.15f\n" ,$1^$2*$3}'`
				temperature=`echo "0.8 $i 10"| awk '{ printf "%0.15f\n" ,$1^$2*$3}'`
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
				job_name=s_${delta_U}_${Gamma0_U}-$z
				qsub -N ${job_name} test.submit
				cd ..
			done
			cd ..
		done
		cd ..
	done
	cd ..
done
exit 0
