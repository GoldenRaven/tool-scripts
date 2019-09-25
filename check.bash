#!/bin/bash
for file in tk_h0.dat
do
    h=0
    for Vg in `cat $file |grep -v ".*\..*\..*" |grep -v "^0\ "`
    do
	echo -e
	echo "---" $h $Vg "---"
	cat ../S_h${h}_Vg$Vg
    done
done
for file in tk_h0.[1-5].dat
do
    h=`echo $file |cut -d '_' -f 2 |cut -d "h" -f 2|cut -d "d" -f 1 |cut -c 1-3`
    for Vg in `cat $file |grep -v ".*\..*\..*" |grep -v "^0\ "`
    do
	echo -e
	echo "---" $h $Vg "---"
	cat ../S_h${h}_Vg$Vg
    done
done
echo "----------------------------------------"
for file in tk_Vg0.dat
do
    Vg=0
    for h in `cat $file |grep -v ".*\..*\..*" |grep -v "^0\ "`
    do
	echo -e
	echo "---" $Vg $h "---"
	cat ../S_Vg${Vg}_h$h
    done
done
for file in tk_Vg0.[1-5].dat
do
    Vg=`echo $file |cut -d '_' -f 2 |cut -d "h" -f 2|cut -d "d" -f 1 |cut -c 1-3`
    for h in `cat $file |grep -v ".*\..*\..*" |grep -v "^0\ "`
    do
	echo -e
	echo "---" $Vg $h "---"
	cat ../S_Vg${Vg}_h$h
    done
done