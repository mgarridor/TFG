#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.2 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Thu Feb 25 19:43:20 CET 2021
# SW Build 3064766 on Wed Nov 18 09:12:47 MST 2020
#
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim mult_config_2_tb_behav -key {Behavioral:sim_1:Functional:mult_config_2_tb} -tclbatch mult_config_2_tb.tcl -view /home/matiaspc/Escritorio/universidad/tfg/trabajo/trabajo_final/mult_config_2_tb_behav.wcfg -log simulate.log"
xsim mult_config_2_tb_behav -key {Behavioral:sim_1:Functional:mult_config_2_tb} -tclbatch mult_config_2_tb.tcl -view /home/matiaspc/Escritorio/universidad/tfg/trabajo/trabajo_final/mult_config_2_tb_behav.wcfg -log simulate.log

