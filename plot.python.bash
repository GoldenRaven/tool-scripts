#!/bin/bash
#generate python script to plot all data files in current dir.

file_name='plot.py'
echo "import matplotlib" > $file_name
echo "# Force matplotlib to not use any Xwindows backend." >> $file_name
echo "matplotlib.use('Agg')" >> $file_name
echo "import numpy as np" >> $file_name
echo "import matplotlib as mpl" >> $file_name
echo "import matplotlib.pyplot as plt" >> $file_name
echo -e  >> $file_name
echo "plt.cla" >> $file_name
echo "plt.rcParams['axes.linewidth'] = '0.8'" >> $file_name
echo -e >> $file_name
echo "from matplotlib import rc" >> $file_name
echo "rc('font',**{'family':'serif','serif':['Times']})" >> $file_name
echo "rc('text', usetex=True)" >> $file_name
echo -e  >> $file_name

i=0
for file in ent/S_*
do
    echo "line$i=np.loadtxt('$file')" >> $file_name
    la="`echo $file |cut -d _ -f 3 |cut -d U -f 2`"
    lb="`echo $file |cut -d _ -f 5 |cut -d U -f 2`"
    echo "l$i=r'$\Gamma_0/U=$la,\delta/U=$lb$'" >> $file_name
    ((i=i+1))
done
num=$i
echo -e  >> $file_name

((j=i+1))
if [ $num -le 3 ]
then
    nrow=1
    ncols=$num
else
    nrows=`echo "$num/3+1"|bc`
    ncols=3
fi
echo "fig = plt.figure(1)" >> $file_name
echo "nrows = $nrows" >> $file_name
echo "ncols = $ncols" >> $file_name
echo -e  >> $file_name
echo "axis_=[1e-5,1,0,2]" >> $file_name
echo -e  >> $file_name
echo "fig, axs = plt.subplots(nrows,ncols,sharex=True,figsize=(32,40))" >> $file_name

for ((i=0;i<num;i++))
do
    if [ ${i} -eq 3 ] || [ ${i} -eq 4 ] || [ ${i} -eq 5 ] || [ ${i} -eq 16 ] || [ ${i} -eq 19 ] #space needed!
    then
        ((j=i+1))
        echo "ax$i = plt.subplot(nrows,ncols,$j)" >> $file_name
	echo "plt.xscale('log')" >> $file_name
        echo "axis_$j=[1e-5,1,0,2]" >> $file_name
        echo "plt.axis(axis_$j)" >> $file_name
        echo "plt.plot(line$i[:,0],line$i[:,1],'k',label=l$i)" >> $file_name
        echo "ax$i.legend(loc='upper right',numpoints=1,frameon=False)" >> $file_name
    else
        ((j=i+1))
        echo "ax$i = plt.subplot(nrows,ncols,$j)" >> $file_name
	echo "plt.xscale('log')" >> $file_name
        echo "plt.axis(axis_)" >> $file_name
        echo "plt.plot(line$i[:,0],line$i[:,1],'k',label=l$i)" >> $file_name
        echo "ax$i.legend(loc='upper right',numpoints=1,frameon=False)" >> $file_name
    fi
    echo -e  >> $file_name
done

fig_name=s.pdf
# echo "fig_name=$fig_name" >> $file_name
echo "plt.savefig('$fig_name', dpi=None, facecolor='w', edgecolor='w', orientation='portrait', format='pdf', bbox_inches='tight')" >> $file_name

python $file_name
exit 0
