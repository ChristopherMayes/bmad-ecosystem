set (LIBNAME bsim)
cmake_minimum_required(VERSION $ENV{ACC_CMAKE_VERSION})
project(ACC)

IF ($ENV{ACC_CONDA_BUILD})
  SET (INC_DIRS
    $ENV{ACC_CONDA_PATH}/include
    $ENV{ACC_CONDA_PATH}/include/xraylib/
  )
ELSE ()
  SET (INC_DIRS
  )
ENDIF ()

set (SRC_DIRS
  code
  code_synrad
  code_synrad3d
  synrad3d/custom
  modules
)

# The FEL step's particle path is transcendental-bound (perf goal 2026-08-21):
# -O3 + the paired-sincos shim together take the per-particle-step cost from 152
# to ~108 ns (neither pays alone). This is a NAMED VALUE CHANGE at the 1-ulp level
# (gfortran's sin/cos intrinsics differ from libm's by 1 ulp on ~2e-6 of arguments,
# and -O3 re-contracts FP): every benchmark tier re-measured and re-recorded.
set_source_files_properties(modules/fel_track_mod.f90 PROPERTIES COMPILE_OPTIONS "-O3")

set (EXE_SPECS
  #cmake_files/cmake.ansga2
  #cmake_files/cmake.aspea2

  cmake_files/cmake.e_cooling
  cmake_files/cmake.long_term_tracking
  cmake_files/cmake.tune_scan
  cmake_files/cmake.dark_current_tracker
  cmake_files/cmake.envelope_ibs
  cmake_files/cmake.frequency_map
  cmake_files/cmake.bbu
  cmake_files/cmake.dynamic_aperture
  cmake_files/cmake.ibs_linac
  cmake_files/cmake.ibs_ring
  cmake_files/cmake.sodom2
  cmake_files/cmake.spin_stroboscope
  cmake_files/cmake.synrad
  cmake_files/cmake.synrad3d
  cmake_files/cmake.synrad_aperture_to_wall
  cmake_files/cmake.tune_plane_res_plot
  cmake_files/cmake.wall_generator
  cmake_files/cmake.wavefront_drift_test
  cmake_files/cmake.fel_track_test
  cmake_files/cmake.fel_smoke_test
  cmake_files/cmake.fel_advance_bench
)

#set (FFLAGS "-qopenmp")
#set (LINK_FLAGS "-qopenmp")

if($ENV{ACC_ENABLE_MPI})
  list(APPEND EXE_SPECS "cmake_files/cmake.moga")
  list(APPEND EXE_SPECS "cmake_files/cmake.aperture_by_tracking")
  list(APPEND EXE_SPECS "cmake_files/cmake.touschek_background")
  list(APPEND EXE_SPECS "cmake_files/cmake.long_term_tracking_mpi")
  list(APPEND EXE_SPECS "cmake_files/cmake.tune_scan_mpi")
endif()

include($ENV{ACC_BUILD_SYSTEM}/Master.cmake)
