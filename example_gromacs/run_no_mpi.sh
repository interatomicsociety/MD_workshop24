#!/bin/bash -l
gromacs_serial mdrun -s some_name.tpr -ntomp 2 -v
