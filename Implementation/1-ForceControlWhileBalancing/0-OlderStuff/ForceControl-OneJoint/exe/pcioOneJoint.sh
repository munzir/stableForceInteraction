#!/bin/bash
RLWA_M7_C='rlwa-m7-cmd'
RLWA_M7_S='rlwa-m7-state'
ACH_MODE=666 # better to use group permissions, but not worth it here
CANBUS_RLWA_0=8
ach -o $ACH_MODE -1 -C $RLWA_M7_C       -m 10 -n $((8*7  + 512)) || exit 1
ach -o $ACH_MODE -1 -C $RLWA_M7_S       -m 10 -n $((24*7 + 512)) || exit 1
pciod -d -I pciod-rlwa-m7 -c $RLWA_M7_C -s $RLWA_M7_S -b $CANBUS_RLWA_0 -m 7 
