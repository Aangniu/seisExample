#OMP_NUM_THREADS=1 mpiexec -np 128 ../build/SeisSol_Release_dhsw_4_damaged-elastic parameters_source_type_50.par
OMP_NUM_THREADS=1 mpiexec -np 128 ../build/SeisSol_Release_dhsw_4_elastic parameters_source_type_50.par
#./SeisSol_Release_dhsw_4_damaged-elastic_str_free_c parameters.par
#../build_nonlinear1/SeisSol_Release_dhsw_4_damaged-elastic parameters.par

# OMP_NUM_THREADS=1 mpiexec --allow-run-as-root --mca btl_vader_single_copy_mechanism none -np 2 bash -c "valgrind ../build_debug/SeisSol_Debug_dhsw_4_damaged-elastic parameters.par &> valgrind_log/log.$OMPI_COMM_WORLD_RANK.txt"
