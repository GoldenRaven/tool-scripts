cd /home/ligy/my-tool-box/sort/
git co 8f8b8fe
make                                   
git co master
cd -                                   
cp /home/ligy/my-tool-box/sort/sort.x .
dir=`pwd`
rm -f tk_Vg*
for file in Vg*
do
	pwd
	Vg=`echo $file |cut -d "_" -f 1 |cut -d g -f 2`
	h=`echo $file |cut -d "_" -f 2 |cut -d h -f 2`
	tk1=`grep "0\.499" S_Vg${Vg}_h${h} |tail -n 1 |cut -d " " -f 1`
	tk2=`grep "0\.500" S_Vg${Vg}_h${h} |head -n 1 |cut -d " " -f 1`
	echo $h "    " $tk1 "    " $tk2 >> tk_Vg${Vg}.dat
done
# for file in tk_Vg0*
# do
# 	echo $file
# 	awk '{print $1,"     ",$2}' $file > disordered
# 	echo 2 > column_num
# 	cat disordered |wc -l > raw_num
# 	./sort.x
# 	mv ordered $file
# done
# rm -f raw_num column_num disordered S_Vg*
#
#for Vg in 0
#do
	#rm -f tk_Vg${Vg}.dat
	#for h in 0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.12 0.14 0.16 0.18 0.2 0.22 0.24 0.26 0.28
	#do
		#tk1=`grep "0\.499" S_Vg${Vg}_h${h} |tail -n 1 |cut -d " " -f 1`
		#tk2=`grep "0\.500" S_Vg${Vg}_h${h} |head -n 1 |cut -d " " -f 1`
		#echo $h "    " $tk1 "    " $tk2 >> tk_Vg${Vg}.dat
	#done
#done
