#!/usr/bin/fish
#function brightness --description "Use xrandr to set the brightness to the provided value for all display outputs."
#    set -l value $argv[1]
#    set -l outputs (xrandr --listmonitors | awk 'NR>1 { print($NF) }')
#
#    for output in $outputs
#      xrandr --output $output --brightness $value
#      echo "Set value for $output"
#    end
#end
#
#
