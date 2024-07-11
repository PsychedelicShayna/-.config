#!/usr/bin/fish




function acfset-governor --description "Alter the CPU governor in auto-cpufreq's config file" 
    
    if test -z "$governor_file"
      set -f governor_file '/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors'
    end

    if not test -f "$governor_file"
      echo "Cannot find auto-cpufreq config file at: $acfconfig"
      echo "You can specify the config file with the --config option"
      return 1
    end

    set -l governor $argv[1]

    set -f governor_file '/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors'
    set -f governors (cat "$governor_file" | string split ' ')

    set -f acfconfig = '/etc/auto-cpufreq.conf'

    if not test -f $acfconfig
    end

    # Check if governor exists within the available governors
    if test -z $governor 
        echo "Usage: acfset-governor <governor>"
        echo "Available governors:"
        printf "%s\n" $governors
        return 1
    else if not contains $governor $governors
        echo "Governor '$governor' not available"
        echo "Available governors:"
        printf "%s\n" $governors
        return 1
    end


end
















