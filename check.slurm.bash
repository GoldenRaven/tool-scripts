#!/bin/bash
#使用下面 command 可以知道每一個 command 的 CPU 使用量
squeue -o"%.7i %.9P %.8j %.8u %.2t %.10M %.6D %C"
# 查看slurm集群状态
sinfo
