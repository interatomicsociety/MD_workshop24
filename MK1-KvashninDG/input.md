#variable Temp equal $T #как задать при запуске lmp_mpi -v T 900 -in input.md

####################################################################
## BEFORE STARTING PLEASE CHECK ALL THE KEYWORDS IN LAMMPS MANUAL ##
####################################################################

#----------------------------------------------------------#
# Study of Thermal Stability 
#----------------------------------------------------------#
units           metal
newton          on
dimension       3
boundary        p p p
atom_style    atomic

variable    Temp   equal 2000

read_data coo.c60	# file with atomic structure coordinates

lattice diamond 1.0

#----------------------------------------------------------#
# Potentials
#----------------------------------------------------------#
pair_style airebo 3.0
pair_coeff * * CH.airebo C

mass 1  12.011

pair_modify shift yes
neigh_modify 	every 1 delay 0 check yes

#----------------------------------------------------------#
# Define The Main Variables
#----------------------------------------------------------#
variable x1 equal xlo
variable x2 equal xhi
variable y1 equal ylo
variable y2 equal yhi
variable z1 equal zlo
variable z2 equal zhi
variable xy1 equal xy
variable xz1 equal xz
variable yz1 equal yz
variable  e equal etotal
variable Tsys equal temp
#variable Temp equal $T
#variable P_sys equal pzz

#----------------------------------------------------------#
# Define Thermostats and Temperature
#----------------------------------------------------------#
run_style verlet

#fix mdcalc all npt iso 1.0 1.0 0.1 temp ${Temp} ${Temp} 0.1
fix mdcalc all nvt temp ${Temp} ${Temp} 0.1
#timestep 0.001

#fix mdcalc all nvt temp ${Temp} ${Temp} 0.01 		
velocity all create ${Temp} 826626413 rot yes dist gaussian

#Tdamp = 100*timestep

thermo 10
compute 7 all temp 

#fix    at all ave/time 5 800 500 v_Tsys file timeaveregedtemp.${Temp}

thermo_style custom step temp etotal #v_x1 v_x1 v_y1 v_y2 v_z1 v_z2

#dump 		1 all xyz 50 out.c60.1000.xyz
dump   1 all custom 500 dump.c60.${Temp}.lmp id type x y z
dump_modify	1 append yes element C 

fix extra all print 1 "${Tsys} $e" file data.${Temp}.txt

run 50000

#0.001fs * 50000 = 50 fs
 


