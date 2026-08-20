#!/bin/bash -l
gromacs mdrun -s CYA_nvt.tpr -ntomp 2 -v
