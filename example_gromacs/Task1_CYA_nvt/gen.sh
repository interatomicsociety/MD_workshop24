# GENERATE NVT

gromacs_serial grompp -f nvt.mdp -p topol.top -c CYA_raw.gro -o CYA_nvt -maxwarn 2
