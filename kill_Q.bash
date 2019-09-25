#!/bin/bash
qstat > batch.qstat
#for ((id=417510;id<=417533;id++))
for id in `qstat|grep "Q\ batch"|cut -d " " -f 1|cut -d . -f 1`
do
	#qalter -lwalltime=18:0:0 $id
	qdel $id
done
exit 0
