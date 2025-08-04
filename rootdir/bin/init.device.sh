#! /vendor/bin/sh

#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

operator_name=$(cat /proc/oppoVersion/operatorName)
pcb_version=$(cat /proc/oppoVersion/pcbVersion)

# Set separate soft property
setprop ro.separate.soft 16061

if [ $operator_name = 8 ]; then # China
    # IMEI SV
    case $pcb_version in
        "3" | "5" | "10" | "11" )
            setprop ro.vendor.radio.imei.sv 22 # A57t
            ;;
        * )
            setprop ro.vendor.radio.imei.sv 32 # A57
            ;;
    esac

    # WiFi NV
    case $pcb_version in
        "10" | "11" )
            setprop ro.vendor.wifi.nv 16061_second
            ;;
        * ) # CN + 112, 113, 114
            setprop ro.vendor.wifi.nv 16061
            ;;
    esac
else # Global
    # IMEI SV
    setprop ro.vendor.radio.imei.sv 36

    # WiFi NV
    case $operator_name in
        "106" )
            setprop ro.vendor.wifi.nv 16361
            ;;
        "102" | "110" | "111" )
            setprop ro.vendor.wifi.nv 16061_second
            ;;
        * ) # 112, 113, 114
            setprop ro.vendor.wifi.nv 16061
            ;;
    esac
fi
