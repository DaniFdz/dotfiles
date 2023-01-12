#!/usr/bin/bash

# Prashant Shrestha
# 2020-06-23

# Getting the data and initializing an array.
BATTERY_INFO=($( acpi | awk -F',' '{ print $0 }'))

# Formatting helpers
CHARGE=""
ICON=""
FORMAT=""

# Format battery icon, depending on the status.
if [[ "${BATTERY_INFO[2]}" == *"Charging"* ]]; then
    CHARGE=$((${BATTERY_INFO[3]//%,}))
    ICON="  " # Plug icon, font awesome.
elif [[ "${BATTERY_INFO[2]}" == *"Unknown"* ]]; then
    CHARGE=$((${BATTERY_INFO[3]//%}))
    ICON="  " # Plug icon, font awesome.

else
    CHARGE=$((${BATTERY_INFO[3]//%,}))
    ICON="  " # Car Battery icon, font awesome
fi

if [[ $CHARGE -lt 10 ]]; then
    # Red-ish
    FORMAT="%{B#282A36}%{F#B33D43}  "
elif [[ $CHARGE -lt 30 ]]; then
    # Orange-ish
    FORMAT="%{B#282A36}%{F#F27F24}  "
elif [[ $CHARGE -lt 60 ]]; then
    # Yellow-ish
    FORMAT="%{B#282A36}%{F#E5C167}  "
elif [[ $CHARGE -lt 100 ]]; then
    # Green-ish
    FORMAT="%{B#282A36}%{F#6FB379}  "
elif [[ $CHARGE -eq 100 ]]; then
    ICON=""
    FORMAT="%{B#282A36}%{F#6FB379}  "
fi

# Format charge & color depending on the status.BATTERY_INFO[3]
FORMAT="$FORMAT$ICON $CHARGE %{B- F-}"

# Final formatted output.
echo $FORMAT
