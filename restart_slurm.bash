#!/bin/bash
systemctl stop slurmctld
systemctl start slurmctld
systemctl stop slurmd
systemctl start slurmd
