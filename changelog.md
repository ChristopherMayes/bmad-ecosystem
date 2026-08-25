# Changelog

Log started 2024-01-01.

Types of entries:
- `Added` for new features.
- `Changed` for changes in existing functionality.
- `Deprecated` for soon-to-be removed features.
- `Removed` for now removed features.
- `Fixed` for any bug fixes.
- `Security` in case of vulnerabilities.

- 2026-08-25 Changed: Lucifer reads and writes openPMD and nothing else. A particle dump
  is `<out_root>-final.beam.h5` and a field dump `<out_root>-final.wf.h5`, and the format
  knobs `beam_formats` and `wavefront_formats` are gone with no alias. A file that is not
  openPMD is refused by name on import, with the conversion command in the message.
  `lucifer/tests/scripts/convert_genesis.py` converts particles and fields between the
  Genesis format and openPMD in either direction, and the validation harness converts the
  Genesis reference dumps once per chain at its boundary, so both codes still start from
  the same state (measured: the field bit-identical, the particles at 3e-16 steady state
  and 8e-15 over 32 slices). The slice partition is now the standard's own
  `particlePatches`, one patch per slice with an empty slice as a patch of no particles,
  so the seven `fel*` root attributes are gone: the patch count is the window, `one4one`
  is what the weights say, and the wavelength, the slice spacing and the beamlet size come
  from the deck. Reading a dump with no `lambda0` is refused rather than defaulted, since a
  wrong wavelength rescales every phase in the run.

- 2026-08-25 Fixed: A particle dump now carries the whole ponderomotive phase. The chart
  splits it into a per-beam reference phase and a per-particle lag, and no dump format has
  anywhere to put the reference, so every reader restarts it at zero. The writer folds the
  reference into the lag it writes, which makes the file's time coordinate
  `-theta/(ks c)` and a restart exact. Without the fold a mid-line restart placed the beam
  at a different phase against the same dumped field, which the windowed-composition check
  measured at 2.1e-2 and now measures at 3.7e-14.

- 2026-08-25 Fixed: `hdf5_write_beam` writes its `particlePatches` records as datasets
  even where every patch holds the same particle count. Bmad's dataset writer collapses an
  all-equal array to a constant-value group, which is a legal openPMD record component and
  not a legal patch list, so a single-patch file, or any file whose patches held equal
  counts, came back with no partition at all. `hdf5_read_beam` names that form rather than
  reading zero particles from it.

- 2026-08-25 Changed: The eleven benchmark tiers are re-recorded. Both codes still start
  from the same state, but the tracker now reads it through a conversion, which costs a
  multiply and a divide: the initial field is bit-identical and the initial particles move
  in their last digits (3e-16 steady state, 8e-15 over 32 slices). Each tier's digits then
  move by that times its own sensitivity, measured here by perturbing the input by 1e-15
  and rerunning: 2.6e4 for the averaged FEL core, and saturating at ~1e-5 for the
  unaveraged mode, whose final-field phase is chaotic and whose recorded digits are
  therefore only reproducible on a bit-identical input. tier1 1.825901e-06 ->
  1.825899e-06, tier1_unavg 6.933979e-02 -> 6.934613e-02, tier2_genesis 1.771895e-05 ->
  1.771890e-05, tier2_bmad 5.001254e-02, td1 8.467690e-07, td2_genesis 2.398226e-06,
  td2_bmad 4.127587e-02, tdsase 2.292906e-06 -> 2.292496e-06, tdsc 2.440477e-04, tdwk
  8.708129e-07, weight_split 3.508953e-13 -> 3.532394e-13, all on the debug tree. The
  production tree lands at the same digits except where the build reaches: tier1_unavg
  6.934017e-02, td2_genesis 2.397983e-06, tdwk 8.708128e-07, weight_split 3.536001e-13.
  Every tolerance is unchanged.

- 2026-08-25 Changed: A Lucifer run's particle dumps are openPMD by default
  (`<out_root>-final.beam.h5`), so a beam with per-particle weights now survives a dump
  and a restart. Genesis `.par.h5` holds one current per slice, and writing a
  nonuniform-weight beam to it is refused by name rather than silently returning a
  uniform beam on read. Both dump kinds now take a LIST of formats instead of an enum,
  `beam_formats` and `wavefront_formats`, so a third code costs a token rather than
  another combination. `wavefront_format = 'both'` is retired with no alias, and
  `beam_file` accepts either format by signature.

- 2026-08-24 Changed: Running Lucifer's validation harness now needs an
  openPMD-beamphysics checkout carrying `beamphysics/wavefront/openpmd.py`
  (`../openPMD-beamphysics` by default), and the harmonics section refuses by name
  without it. The Python side of the wavefront round trip was a patch carried in
  `lucifer/openpmd/`. It has landed upstream, so the patch is removed and the checks
  exercise `Wavefront.from_openpmd` and `write_openpmd` directly. The Fortran reader
  is now also checked against Python-written files.

- 2026-08-23 Changed: Lucifer's terminal output is formatted for humans: a framed configuration
  header, a progress table with SI-prefixed values and fixed numeric columns, and a completion
  block listing the files written with their sizes. The progress row now carries power, energy
  and bunching in every comb mode. Do not parse stdout. Machine-readable output goes to files,
  with the ALL-CAPS refusal texts the one documented exception.

- 2026-08-23 Added: Lucifer writes the distribution-import moments and per-slice current profile
  to `<out_root>.import.txt`, and one row per slice-migration event to
  `<out_root>.migration.txt`. Both data streams previously went to stdout.

- 2026-08-23 Added: Radiation power, energy, on-axis intensity and bunching per slice are now in
  Lucifer's `element_end/` stats group, so a run with `comb_ds_save < 0` (no per-record rows
  kept) still has these quantities at element ends. Bmad's comb semantics are unchanged.

- 2026-08-23 Changed: A 131-slice Lucifer run finishes in 126.9 s instead of 137.7 s, with
  utilization up from 931% to 1048%. The element-end whole-window bunch statistics are now
  assembled from the per-slice moments by the pooled-covariance identity instead of
  concatenating every particle in the time window into one bunch and running the full 6D
  moments and Twiss on it. That removes 110 million single-threaded particle visits, 16.5% of
  the run's wall clock. Agreement with the particle sum measured at 4.0e-12 / 5.0e-11 on two
  physical configurations.

- 2026-08-22 Fixed: `util/searchf.py` (getf/listf/create_searchf_namelist): the
  interface-end regex was `end\s+ interface` (a stray space requiring two whitespace
  characters), so a bare `interface` block made the scanner swallow the rest of the file.
  Every routine after such a block was missing from `searchf.namelist` and invisible to
  getf/listf wherever an index file existed. Directories with tracked index files may want
  to regenerate them with `util/create_searchf_namelist`.

- 2026-08-22 Changed: Lucifer messages appear as routine-tagged, severity-tagged blocks, and the
  old `fel_track_test:` stdout prefixes are gone. The messages go through `out_io` (Bmad's
  standard message system). Data lines that scripts parse (import moments/currents, progress,
  file listings) stay bare and full-precision.

- 2026-08-22 Added: Lucifer, an FEL tracker validated against Genesis 1.3 Version 4, as a
  top-level program directory (`lucifer/`, executable `lucifer`, library `liblucifer`).
  Time-dependent SASE and seeded tracking with slippage on Bmad lattices (wiggler/undulator
  elements), wakes and space charge, distribution import, harmonic fields, an unaveraged
  verification mode, openPMD wavefront I/O, and a validation harness
  (`lucifer/tests/run_fel_benchmark.sh`). Physics manual in `lucifer/doc/fel-physics.tex`.

- 2026-08-10 Fixed: Radiation integrals no longer depend upon how a magnet is sliced. Two bugs in
  the integration were fixed: The non-cached calculation evaluated the integrands 1 mm inside the
  element at the downstream end, and the cached calculation used a set of cache points that did not
  line up with the points where the integrands are evaluated so that the interpolation between cache
  points introduced an error that varied with the slicing.

- 2024-05-06 Fixed Tao `cut` command orbit setting.

- 2024-04-24 Removed: srdt_lsq_soln program since it is not supported and Tao has this functionality.

- 2024-04-24 Fixed: Foil tracking when there is an offset.

- 2024-04-23 Changed: HomeBrew and MacPorts now automatically detected.

- 2024-04-19 Removed: Gprof references in compile scripts.

- 2024-04-19 Changed: Tweak to speed up offset_particle when there are no offsets.

- 2024-04-16 Fixed: `set_ele_attribute` routine will now set err_flag True on error with unknown variable in expression.

- 2024-04-16 Added: New Tao global: `global%beam_dead_cutoff`

- 2024-04-16 Fixed: Bug traced to OMP and multipole caching. Problem is that if auto_bookkeeper is
turned off initially, the cache is not use. Track1_bunch_csr turns it on for speed but
then tracking with OMP gives a race condition when the cache gets initialized during tracking.

- 2024-04-16 Fixed: Ramper bookkeeping when rampers control overlays and groups. 
The new bookkeeping is more efficient in terms of computation time.

- 2024-04-15 Added: New Tao command: `show rampers`.

- 2024-04-06 Changed: Foil element attribute drel_thickness_dx changed to dthickness_dx.

- 2024-03-29 Fixed: Corrected sbend changed attribute bookkeeping for k1 and k2. 

- 2024-03-28 Fixed: m56 calc for standing_wave lcavity.

- 2024-03-28 Fixed: Fix setting of lat_sigma_calc_needed logical in Tao.

- 2024-03-28 Fixed: Tao now checks for call file infinite loop.

- 2024-03-28 Fixed: Fix expression eval when there is an evaluation range in Tao.

- 2024-03-27 Added: Added `ltt_com%ltt_tracking_happening_now` in long_term_tracking for use in custom code.

- 2024-03-27 Added: "Bunch0" combined bunch for averages output in long_term_tracking.

- 2024-03-27 Fixed:  Reduced unnecessary output for tune_scan program.

- 2024-03-25 Fixed: Now MPI messages will go through out_io for long_term_tracking.

- 2024-03-25 Fixed: Added negative thickness error checking for foil element.

- 2024-03-23 Added: `SWAVE` parameter to translation between Bmad and MAD8.

- 2024-03-22 Fixed: Test of particle outside of RF bucket ignoring closed orbit z.

- 2024-03-21 Added: `ltt%print_info_messages` parameter for long_term_tracking.

- 2024-03-20 Fixed: Particle z-calc with beam init and multiple bunches. 

- 2024-03-18 Added: output_only_last_turns and output_combined_bunches parameters to long_term_tracking. 

- 2024-03-12 Fixed: long_term_tracking extraction tracking. 

- 2024-03-06 Fixed: Tao confusion with multiple universes with the same lattice and Rf is to be turned off.

- 2024-03-06 Fixed: Fix radiation calc for taylor element with finite length.

- 2024-03-06 Fixed: Tao now checks for call file infinite loop.

- 2024-02-26 Fixed: Correction to `track_a_lcavity` ref time calc.

- 2024-02-25 Fixed: Spin tracking will not respect element is_on = False setting.

- 2024-02-25 Fixed: Now chrom.w_a, etc. datums can be used with open lattice. 

- 2024-02-18 Fixed: Now long_term_tracking with energy ramping will properly init particles.

- 2024-02-16 Fixed: Eigen anal from sigma matrix.

- 2024-02-13 Fixed: Phase trombone tune set.

- 2024-02-12 Fixed: Reinstated phase_trombone in closed geometry lattice.

- 2024-02-13 Fixed: Add mode flip warning in Tao.

- 2024-02-13 Fixed: Phase trombone tune set. 

- 2024-02-12 Fixed: Updated tune_scan program to properly insert phase trombone element. 

- 2024-02-11 Added: `t_center` to `beam_init_struct`. 

- 2024-02-10 Added: Basic control_lord (for feedback elements) parsing is done. (#796)

- 2024-02-09 Added: New dispersion derivative. 

- 2024-02-09 Fixed: Fixed aperture_type set for super_slaves. (#792)

- 2024-02-05 Added: Added energy kick to beambeam tracking. (#766)

- 2024-01-18 Added: Code for pointing at cartesian_map(N)%term components.

- 2024-01-17 Fixed: Expression parsing of ...+d+....

- 2024-01-15 Fixed: Sliced crab_cavity phase calc.

- 2024-01-14 Added: *INDIVIDUAL* mode to the long_term_tracking program for resonant extraction simulations.

- 2024-01-11 Fixed: Linear beambeam spin tracking.

- 2024-01-11 Fixed: Corrected `ltt_init_tracking` logic for when beam init is needed.

- 2024-01-11 Fixed: SAD quad to bmad sad_mult translation.

- 2024-01-11 Added: *foil* lattice element for simulating things like charge stripping, emittance smoothing, etc.
