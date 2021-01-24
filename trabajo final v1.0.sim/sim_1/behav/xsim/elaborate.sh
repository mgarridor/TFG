#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Sun Jan 24 20:25:21 CET 2021
# SW Build 3064766 on Wed Nov 18 09:12:47 MST 2020
#
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab -wto 1d7e73df8fab4e408e5bee25fd65c24c --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot funcion_lineal_tb_behav xil_defaultlib.funcion_lineal_tb -log elaborate.log"
xelab -wto 1d7e73df8fab4e408e5bee25fd65c24c --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot funcion_lineal_tb_behav xil_defaultlib.funcion_lineal_tb -log elaborate.log

