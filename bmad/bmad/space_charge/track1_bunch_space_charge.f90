!+
! Subroutine track1_gun_space_charge (bunch, ele, err, drift_to_same_s, bunch_track)
!
! Subroutine to track a bunch of particles in the presence of space charge.
! This routine uses time based tracking and so is usable at low energy near a cathode.
!
! Input:
!   bunch           -- bunch_struct: Starting bunch position.
!   ele             -- ele_struct: E_gun element to track through. Must be part of a lattice.
!   drift_to_same_s -- logical, optional: Default is True. If True, drift particles to all have the
!                        same s-position.
!   bunch_track     -- bunch_track_struct, optional: Existing tracks. If bunch_track%n_pt = -1 then
!                        Overwrite any existing track.
!
! Output:
!   bunch       -- bunch_struct: Ending bunch position.
!   err         -- logical: Set true if there is an error. EG: Too many particles lost for a CSR calc.
!   bunch_track -- bunch_track_struct, optional: track information if the tracking method does 
!                        tracking step-by-step. When tracking through multiple elements, the 
!                        trajectory in an element is appended to the existing trajectory. 
!-

subroutine track1_bunch_space_charge (bunch, ele, err, drift_to_same_s, bunch_track)

use space_charge_mod, dummy => track1_bunch_space_charge

implicit none

type (bunch_struct), target :: bunch
type (ele_struct), target :: ele
type (bunch_track_struct), optional :: bunch_track
type (branch_struct), pointer :: branch
type (coord_struct), pointer :: p

integer i, n
logical err, finished, include_image
logical, optional :: drift_to_same_s
real(rp) :: dt_step, dt_next, t_now, t_end, beta, ds, s_save_last

integer, parameter :: fixed_time_step$ = 1, adaptive_step$ = 2 ! Need this in bmad_struct

character(*), parameter :: r_name = 'track1_bunch_space_charge'

! Initialize variables

branch => pointer_to_branch(ele)
dt_step = space_charge_com%dt_track_step  ! Init time step.
dt_next = dt_step
include_image = (ele%space_charge_method == cathode_fft_3d$) ! Include cathode image charge?

! Zero length elements are easy

if (ele%value(l$) == 0) then
  !do i = 1, size(bunch%particle)
  !  p => bunch%particle(i)
  !  call track1(p, ele, ele%branch%param, p)
  !enddo
  if (logic_option(.true., drift_to_same_s)) call drift_to_s(bunch, ele%s, branch)
  err = .false.
  return
endif

! Drift bunch to the same time
if (bunch%t0 == real_garbage$) then
  bunch%t0 = maxval(bunch%particle%t, bunch%particle%state==alive$ .or. bunch%particle%state==pre_born$) 
endif
t_now = bunch%t0
call drift_to_t(bunch, bunch%t0, branch)

! Convert to t-based coordinates
do i = 1, size(bunch%particle) 
  p => bunch%particle(i)
  call convert_particle_coordinates_s_to_t(p, s_body_calc(p, branch%lat%ele(p%ix_ele)), branch%lat%ele(p%ix_ele)%orientation)
enddo

if (present(bunch_track)) then
  call save_a_bunch_step (bunch_track, ele, bunch)
  s_save_last = bunch_track%pt(bunch_track%n_pt)%s
endif

! Estimate when middle of the bunch reaches end of the element
finished = .false.
n = count(bunch%particle(:)%state==alive$)
if (n>0) then
  beta = sum(bunch%particle(:)%beta,bunch%particle(:)%state==alive$)/n
  ds = ele%s - sum(bunch%particle(:)%s,bunch%particle(:)%state==alive$)/n
  finished = ds/beta/c_light < dt_step  ! If the bunch is near the end, finish tracking after one step
  dt_step = min(ds/beta/c_light, dt_step)
endif

! Track
do
  ! Track a step
  if (ele%tracking_method==fixed_step_time_runge_kutta$) then
    call sc_step(bunch, ele, include_image, t_now+dt_step)
  else
    call sc_adaptive_step(bunch, ele, include_image, t_now, dt_step, dt_next)
  end if

  t_now = t_now + dt_step
  dt_step = dt_next

  if (present(bunch_track)) then
    if (bunch_track%pt(bunch_track%n_pt)%s >= s_save_last + bunch_track%ds_save) then
      call save_a_bunch_step (bunch_track, ele, bunch)
      s_save_last = bunch_track%pt(bunch_track%n_pt)%s
    endif
  endif
  
  if (finished) exit

  ! Check if center of the bunch is past end of the element
  n = count(bunch%particle(:)%state==alive$)
  if (n==0) exit
  beta = sum(bunch%particle(:)%beta,bunch%particle(:)%state==alive$)/n
  ds = ele%s - sum(bunch%particle(:)%s,bunch%particle(:)%state==alive$)/n
  if (ds <= 0.1_rp * bmad_com%significant_length) exit
  ! Update time estimate
  finished = (ds/beta/c_light < dt_step)  ! If the bunch is near the end, finish tracking after one step
  dt_step = min(ds/beta/c_light, dt_step)
enddo

! Convert to s-based coordinates
bunch%t0 = minval(bunch%particle%t, bunch%particle%state==alive$)
do i= 1, size(bunch%particle) 
  p => bunch%particle(i)
  call convert_particle_coordinates_t_to_s(p, branch%lat%ele(p%ix_ele))
enddo

! Drift bunch to the end of element
if (logic_option(.true., drift_to_same_s)) call drift_to_s(bunch, ele%s, branch)
err = .false.

end subroutine track1_bunch_space_charge