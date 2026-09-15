#!/usr/bin/env bash

if [[ -n "$1" && "$1" -le 100 && "$1" -gt 11 ]]; then
  target="$1"
else
  target=70
fi

echo "$target" | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct >/dev/null

pct=$(cat /sys/devices/system/cpu/intel_pstate/max_perf_pct)

echo "Limited CPU performance to $pct%"
# notify-send "AI Mode activated!" "Limited CPU percentage at max $pct%"
