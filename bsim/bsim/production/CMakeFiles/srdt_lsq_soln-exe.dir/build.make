# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.18

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /nfs/acc/libs/Linux_x86_64_intel/extra/cmake-3.18.4_17nov20/bin/cmake

# The command to remove a file.
RM = /nfs/acc/libs/Linux_x86_64_intel/extra/cmake-3.18.4_17nov20/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/bsim

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/bsim/production

# Include any dependencies generated for this target.
include CMakeFiles/srdt_lsq_soln-exe.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/srdt_lsq_soln-exe.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/srdt_lsq_soln-exe.dir/flags.make

CMakeFiles/srdt_lsq_soln-exe.dir/srdt_lsq_soln/srdt_lsq_soln.f90.o: CMakeFiles/srdt_lsq_soln-exe.dir/flags.make
CMakeFiles/srdt_lsq_soln-exe.dir/srdt_lsq_soln/srdt_lsq_soln.f90.o: ../srdt_lsq_soln/srdt_lsq_soln.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/bsim/production/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building Fortran object CMakeFiles/srdt_lsq_soln-exe.dir/srdt_lsq_soln/srdt_lsq_soln.f90.o"
	/home/dcs16/dcs16/bmad_distribution/bmad_dist/production/bin/mpifort $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -Df2cFortran -DCESR_UNIX -DCESR_LINUX -u -traceback -cpp -fno-range-check -fdollar-ok -fbacktrace -Bstatic -ffree-line-length-none -fopenmp -DCESR_PLPLOT -DACC_MPI -I/home/dcs16/dcs16/bmad_distribution/bmad_dist/production/include -pthread -I/home/dcs16/dcs16/bmad_distribution/bmad_dist/production/lib -fPIC -O2  -c /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/bsim/srdt_lsq_soln/srdt_lsq_soln.f90 -o CMakeFiles/srdt_lsq_soln-exe.dir/srdt_lsq_soln/srdt_lsq_soln.f90.o

CMakeFiles/srdt_lsq_soln-exe.dir/srdt_lsq_soln/srdt_lsq_soln.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing Fortran source to CMakeFiles/srdt_lsq_soln-exe.dir/srdt_lsq_soln/srdt_lsq_soln.f90.i"
	/home/dcs16/dcs16/bmad_distribution/bmad_dist/production/bin/mpifort $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -Df2cFortran -DCESR_UNIX -DCESR_LINUX -u -traceback -cpp -fno-range-check -fdollar-ok -fbacktrace -Bstatic -ffree-line-length-none -fopenmp -DCESR_PLPLOT -DACC_MPI -I/home/dcs16/dcs16/bmad_distribution/bmad_dist/production/include -pthread -I/home/dcs16/dcs16/bmad_distribution/bmad_dist/production/lib -fPIC -O2  -E /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/bsim/srdt_lsq_soln/srdt_lsq_soln.f90 > CMakeFiles/srdt_lsq_soln-exe.dir/srdt_lsq_soln/srdt_lsq_soln.f90.i

CMakeFiles/srdt_lsq_soln-exe.dir/srdt_lsq_soln/srdt_lsq_soln.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling Fortran source to assembly CMakeFiles/srdt_lsq_soln-exe.dir/srdt_lsq_soln/srdt_lsq_soln.f90.s"
	/home/dcs16/dcs16/bmad_distribution/bmad_dist/production/bin/mpifort $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -Df2cFortran -DCESR_UNIX -DCESR_LINUX -u -traceback -cpp -fno-range-check -fdollar-ok -fbacktrace -Bstatic -ffree-line-length-none -fopenmp -DCESR_PLPLOT -DACC_MPI -I/home/dcs16/dcs16/bmad_distribution/bmad_dist/production/include -pthread -I/home/dcs16/dcs16/bmad_distribution/bmad_dist/production/lib -fPIC -O2  -S /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/bsim/srdt_lsq_soln/srdt_lsq_soln.f90 -o CMakeFiles/srdt_lsq_soln-exe.dir/srdt_lsq_soln/srdt_lsq_soln.f90.s

# Object files for target srdt_lsq_soln-exe
srdt_lsq_soln__exe_OBJECTS = \
"CMakeFiles/srdt_lsq_soln-exe.dir/srdt_lsq_soln/srdt_lsq_soln.f90.o"

# External object files for target srdt_lsq_soln-exe
srdt_lsq_soln__exe_EXTERNAL_OBJECTS =

/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: CMakeFiles/srdt_lsq_soln-exe.dir/srdt_lsq_soln/srdt_lsq_soln.f90.o
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: CMakeFiles/srdt_lsq_soln-exe.dir/build.make
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/lib/libbsim.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libbmad.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libsim_utils.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libxrlf03.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libxrl.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libforest.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libfgsl.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libgsl.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libgslcblas.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/liblapack95.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libhdf5hl_fortran.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libhdf5_hl.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libhdf5_fortran.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libhdf5.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libfftw3.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: ../../production/lib/libfftw3_omp.a
/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln: CMakeFiles/srdt_lsq_soln-exe.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/bsim/production/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking Fortran executable /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/srdt_lsq_soln-exe.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/srdt_lsq_soln-exe.dir/build: /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/production/bin/srdt_lsq_soln

.PHONY : CMakeFiles/srdt_lsq_soln-exe.dir/build

CMakeFiles/srdt_lsq_soln-exe.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/srdt_lsq_soln-exe.dir/cmake_clean.cmake
.PHONY : CMakeFiles/srdt_lsq_soln-exe.dir/clean

CMakeFiles/srdt_lsq_soln-exe.dir/depend:
	cd /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/bsim/production && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/bsim /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/bsim /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/bsim/production /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/bsim/production /home/dcs16/dcs16/bmad_distribution/bmad_dist_gfortran_mpi_openmp_shared/bsim/production/CMakeFiles/srdt_lsq_soln-exe.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/srdt_lsq_soln-exe.dir/depend

