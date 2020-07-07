#!/bin/bash
#SBATCH -J test1                   # 作业名为 test
#SBATCH -o test1.out               # 屏幕上的输出文件重定向到 test.out
#SBATCH -N 1                      # 作业申请 1 个节点
#SBATCH -w ligy-001
#SBATCH --ntasks-per-node=1       # 单节点启动的进程数为 1
#SBATCH --cpus-per-task=4         # 单任务使用的 CPU 核心数为 4
#SBATCH -t 1:00:00                # 任务运行的最长时间为 1 小时

hostname
sleep 60
# echo 'testing...'
