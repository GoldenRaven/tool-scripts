#!/bin/bash
job_id=1
U=0.2
Ed_up=-0.186
Ed_down=-0.186
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

Gamma0=0.4
Nz=4
dir=`pwd`

if [ -e batch/Vg ]
then

for file in batch/Vg*_h*_T*
do
    Vg=`echo $file |cut -d '/' -f 2|cut -d "_" -f 1 |cut -d g -f 2`
    h=`echo $file | cut -d '/' -f 2|cut -d "_" -f 2 |cut -d h -f 2`
    temperature=`echo $file |cut -d "_" -f 3 |cut -d T -f 2`
    mkdir Vg${Vg}_h$h
    cd Vg${Vg}_h$h
    dir1=`pwd`
    for z in 0 0.25 0.5 0.75
    do
	#rm -fr $z
	mkdir $z
	cd $z
	dir2=`pwd`
        omega0=$temperature
        # rm -fr $temperature
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
        job_name=$Vg-$h
        qsub -N ${job_name} test.submit
	cd $dir1
    done
    cd $dir
mv $file done/
done
fi

if [ -e batch/h ]
then

for file in batch/h*_Vg*_T*
do
    h=`echo $file | cut -d '/' -f 2|cut -d "_" -f 1 |cut -d h -f 2`
    Vg=`echo $file | cut -d '/' -f 2|cut -d "_" -f 2 |cut -d g -f 2`
    temperature=`echo $file |cut -d "_" -f 3 |cut -d T -f 2`
    echo $h $Vg $temperature
    mkdir h${h}_Vg$Vg
    cd h${h}_Vg$Vg
    dir1=`pwd`
    for z in 0 0.25 0.5 0.75
    do
	#rm -fr $z
	mkdir $z
	cd $z
	dir2=`pwd`
	omega0=$temperature
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
	job_name=$Vg-$h
	qsub -N ${job_name} test.submit
	cd  $dir1
    done
    cd $dir
done
mv $file done
fi
