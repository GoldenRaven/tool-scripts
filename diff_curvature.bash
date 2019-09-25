#!/bin/bash
dir=`pwd`
cd /home/ligy/program/my-tool-box/first-order_derivative_3point/
make clean
make
cp diff_1st.x $dir
cd /home/ligy/program/my-tool-box/second-order_derivative/
make clean
make
cp diff_2nd.x $dir
cd /home/ligy/program/my-tool-box/curvature/
make clean
make
cp curvature.x $dir
cd $dir
diff=1
diff_diff=1
curvature=1
for file in dos_Vg*
do
    sed '/e-[08,09,10,11,12,13,14]/d' $file > tmp
    sed '$d' tmp > tmpp
    sed '/^0\>\ /d' tmpp > before
    awk '{print NF}' before|head -n 1 > column_num
    cat before |wc -l > row_num
    if [ ${diff} -eq 1 ]
    then
        echo calculating 1st derivative...
        ./diff_1st.x
        mv after ${file}_diff
    fi
    if [ ${diff_diff} -eq 1 ]
    then
        echo calculating 2d derivative...
        ./diff_2nd.x
        mv after ${file}_diff_diff
    fi
    if [ ${curvature} -eq 1 ]
    then
        echo calculating curvature...
        ./curvature.x
        mv after ${file}_curvature
    fi

    exit
done
rm -f tmp tmpp before after column_num row_num
