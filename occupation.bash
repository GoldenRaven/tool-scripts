dir=`pwd`
cd ~/my-tool-box/sort/
git co 8f8b8fe
make
git co master
cd -
cp /home/ligy/my-tool-box/sort/sort.x .
for file in Vg*
do
	cd $file
	pwd
	Vg=`echo $file |cut -d "_" -f 1 |cut -d g -f 2`
	h=`echo $file |cut -d "_" -f 2 |cut -d h -f 2`
	echo $Vg $h
	for z in 0*
	do
		cd $z
		cat `find .|grep 'occu.dat'` > tmp
		find .|grep 'occu.dat' | cut -d / -f 2 > tmpp
		paste tmpp tmp > tmppp
		mv tmppp disordered
		wc -l disordered > raw_num
		awk '{print NF}' disordered > column_num
		cp /home/ligy/my-tool-box/sort/sort.x .
		./sort.x
		mv ordered ../occu$z
		rm -f tmp tmpp
		cd ..
	done
	paste occu0* > occu
	awk '{print $1,"      ",($2+$6+$10+$14)/4,"   ",($3+$7+$11+$15)/4,"    ",($4+$8+$12+$16)/4}' occu > Occu
	cp Occu ../Occu_Vg${Vg}_h${h}
	cd ..
done
#
for Vg in 0 0.1 0.2 0.3 0.4 0.5
do
	rm -f Occu_Vg${Vg}.dat
	for file in Occu_Vg${Vg}_h*
	#for Vg in 0 0.1 0.2 0.3 0.4 0.5
	do
		h=`echo $file |cut -d "_" -f 3 |cut -d h -f 2`
		sed "s/$/\ $h/" $file > _${file}_ && mv -- _${file}_ $file
	done
	cat Occu_Vg${Vg}_h* >> Occu_Vg${Vg}.dat
	awk '{print $5,"        ",$2,"        ",$3,"        ",$4}' Occu_Vg${Vg}.dat > _Occu_Vg${Vg}.dat_
	mv _Occu_Vg${Vg}.dat_ disordered
	wc -l disordered > raw_num
	awk '{print NF}' disordered > column_num
	./sort.x
	mv ordered Occu_Vg${Vg}.dat
	rm -f disordered Occu_Vg${Vg}_h*
done
##
##
##
for file in h*_Vg*
do
	cd $file
	pwd
	h=`echo $file |cut -d "_" -f 1 |cut -d h -f 2`
	Vg=`echo $file |cut -d "_" -f 2 |cut -d g -f 2`
	echo $Vg $h
	for z in 0*
	do
		cd $z
		cat `find .|grep 'occu.dat'` > tmp
		find .|grep 'occu.dat' | cut -d / -f 2 > tmpp
		paste tmpp tmp > tmppp
		mv tmppp disordered
		wc -l disordered > raw_num
		awk '{print NF}' disordered > column_num
		cp /home/ligy/my-tool-box/sort/sort.x .
		./sort.x
		mv ordered ../occu$z
		rm -f tmp tmpp
		cd ..
	done
	paste occu0* > occu
	awk '{print $1,"      ",($2+$6+$10+$14)/4,"   ",($3+$7+$11+$15)/4,"    ",($4+$8+$12+$16)/4}' occu > Occu
	cp Occu ../Occu_h${h}_Vg${Vg}
	cd ..
done
for h in 0 0.1 0.2 0.3 0.4 0.5
do
	rm -f Occu_h${h}.dat
	for file in Occu_h${h}_Vg*
	do
		Vg=`echo $file |cut -d "_" -f 3 |cut -d g -f 2`
		sed "s/$/\ $Vg/" $file > _${file}_ && mv -- _${file}_ $file
	done
	cat Occu_h${h}_Vg* > Occu_h${h}.dat
	awk '{print $5,"        ",$2,"        ",$3,"        ",$4}' Occu_h${h}.dat > _Occu_h${h}.dat_
	mv _Occu_h${h}.dat_ disordered
	cat disordered | wc -l > raw_num
	head -n 1 disordered |awk '{print NF}' > column_num
	./sort.x
	mv ordered Occu_h${h}.dat
	rm -f disordered Occu_h${h}_Vg*
done
