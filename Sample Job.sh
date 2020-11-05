#!/bin/bash
#PBS -N surface
#PBS -o out.log
#PBS -e err.log
#PBS -l nodes=5:ppn=32
#PBS -j oe
#PBS -q medium
#echo job related information in job output file
echo "PBS JOB id is $PBS_JOBID"
NPROCS=$(wc -l < $PBS_NODEFILE)
echo "NPROCS is $NPROCS"
# go inside job submission dir
cd $PBS_O_WORKDIR
module load compilers/intel/parallel_studio/parallel_studio_xe_2018_update1_cluster_edition
module load codes/intel/gromacs/parallel/double/5.1.4
#create nodes file contating execution nodenames
cat $PBS_NODEFILE > nodes.$PBS_JOBID
NP=`cat $PBS_NODEFILE|wc -l`
mpiexec.hydra -machinefile $PBS_NODEFILE -np ${NP} `which gmx_mpi_d` <
input_command_file.in > surfac.out
