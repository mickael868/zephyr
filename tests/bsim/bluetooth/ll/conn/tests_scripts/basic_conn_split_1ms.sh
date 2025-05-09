#!/usr/bin/env bash
# Copyright 2024 Nordic Semiconductor ASA
# SPDX-License-Identifier: Apache-2.0

source ${ZEPHYR_BASE}/tests/bsim/sh_common.source

# Basic connection test: a central connects to a peripheral and expects a
# notification, using the split controller (ULL LLL) and 1ms connection
# interval
simulation_id="basic_conn_split_1ms"
verbosity_level=2
EXECUTE_TIMEOUT=120

cd ${BSIM_OUT_PATH}/bin

Execute ./bs_${BOARD_TS}_tests_bsim_bluetooth_ll_conn_prj_split_1ms_conf \
  -v=${verbosity_level} -s=${simulation_id} -d=0 -RealEncryption=1 \
  -testid=peripheral -rs=23

Execute ./bs_${BOARD_TS}_tests_bsim_bluetooth_ll_conn_prj_split_1ms_conf\
  -v=${verbosity_level} -s=${simulation_id} -d=1 -RealEncryption=1 \
  -testid=central -rs=6

Execute ./bs_2G4_phy_v1 -v=${verbosity_level} -s=${simulation_id} \
  -D=2 -sim_length=20e6 $@

wait_for_background_jobs
