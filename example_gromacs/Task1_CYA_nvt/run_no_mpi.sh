#!/bin/bash -l
gromacs_serial mdrun -s CYA_nvt.tpr -ntomp 2 -v
