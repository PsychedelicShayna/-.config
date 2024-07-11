

# A set of arguments that tears through files, making "rip" an understatement.

# Rip & Tear - Grep (yes, really)
alias rtg 'rg -u --no-ignore -i --mmap --follow --threads 8 --line-number'
# Big Fucking Grep (I'm not apologizing)


function irtg
  set -f rg_prefix 'rg -u --no-ignore -i --mmap --follow --threads 12 --column --line-number --no-heading --color=never';

  fzf --bind "start:reload:$rg_prefix ''" \
      --bind "change:reload:$rg_prefix {q} || true" \
      --ansi --disabled --height=50% --layout=reverse;
end

##############################################################################
## When you need a big fucking gu- I mean grep. Big fulsome grep.. to fervently 
## facilitate your felicity by flushing out fathomless files on your formidable 
## filesystem, even following into FAT32 so that you don't have to frantically 
## fumble when needing them really fuckig- Let's just say it's fantastic grep.
###############################################################################

function bfg
  rg -u --no-ignore -i --mmap --follow --binary --search-zip --threads 16 --no-heading --color=never $argv
end

function ibfg
  # I found it funny. It's okay, you don't have to.
  if [ -f "$HOME/.config/fish/resources/bfg/bfg.ogg" ]
    mpv "$HOME/.config/fish/resources/bfg/bfg.ogg" --really-quiet &; disown
  end

  set -f rg_prefix 'rg -u --no-ignore -i --mmap --follow --binary --search-zip --threads 12 --no-heading --color=never'

  fzf --bind "start:reload:$rg_prefix ''" \
      --bind "change:reload:$rg_prefix {q} || true" \
      --ansi --disabled --height=50% --layout=reverse;
end



# Some shell fun. I was bored.
# Because why not? Have a sense of humor.
#
# Assumes you have: 
#   rg, sd (not sed, look it up on cargo), auto-cpufreq,
#   systemd (who'd have guessed), and coretempf (my own tool)
#
#   Also assumes the presence of these files:
#
# - /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
# - /etc/auto-cpufreq.conf
#
# - Optionally 
# - $HOME/.config/fish/resources/bfg/bfg.ogg            (: 
#

function bfg4000
  set -g freqfile '/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq'
  set -g acfpath '/etc/auto-cpufreq.conf'

  if [ ! -f "$freqfile" ]
    echo "Cannot find frequency file: $freqfile"
    return
  end

  if [ ! -f "$acfpath" ]
    echo "Cannot find auto-cpufreq config file: $acfpath"
    return
  end

  function get_configured_min
    if [ -f "$acfpath" ]
      echo "$(sudo cat $acfpath | rg '^(scaling_min_freq =) (\d*)$' -o -r '$2') KHz"
    else
      echo "Cannot find auto-cpufreq config file: $acfpath"
      return
    end
  end

  function get_configured_max
    if [ -f "$acfpath" ]
      echo "$(sudo cat $acfpath | rg '^(scaling_max_freq =) (\d*)$' -o -r '$2') KHz"
    else
      echo "Cannot find auto-cpufreq config file: $acfpath"
      return
    end
  end

  function check_core_temperature
    clear

    echo "+-------------------------+"
    echo "| ! Pre-Fire Monitoring ! |"
    echo "+---+---------------------+"
    echo "| C |  Configured Freuqency: " (get_configured_min) " - " (get_configured_max)
    echo "| F |  Current Frequency: $(cat $freqfile) KHz"
    echo "| T | " (coretempf -ug y -s "Temperature at $(cat $freqfile)KHz Averaging: " -av -s)
    echo "| T | " (coretempf -ug y -s 'Coldest Core ' -tm -s ' | Peaking ' -tx)
  end


  echo "Confirm that you understand what you're doing."
  echo "This will clock your CPU at 4.0GHz, and fire off a BFG"
  echo ""
  echo "This might get pretty hot depending on the search depth."
  echo ""
  echo "Safety monitoring will be performed before and after the search."
  echo "You're on your own during the search."
  echo ""
  set -f confirmation (read -P "Proceed? [y/N] ")

  set -f original_minfreq (sudo cat $acfpath | rg '^(scaling_min_freq =) (\d*)$' -o -r '$2')
  set -f original_maxfreq (sudo cat $acfpath | rg '^(scaling_max_freq =) (\d*)$' -o -r '$2')

  sudo echo "$original_minfreq" > '/tmp/bfg4000-original_minfreq'
  sudo echo "$original_maxfreq" > '/tmp/bfg4000-original_maxfreq'

  if [ ! -f '/tmp/bfg4000-original_minfreq' ]
    echo 'Failed to save original min frequency to /tmp/bfg4000-original_minfreq'
    echo 'Aborting'
    return
  end

  if [ ! -f '/tmp/bfg4000-original_maxfreq' ]
    echo 'Failed to save original max frequency to /tmp/bfg4000-original_maxfreq'
    echo 'Aborting'
    return
  end

  echo ""
  echo "Saved original min/max frequencies: $original_minfreq KHz / $original_maxfreq KHz"
  echo "Files located in /tmp/ as bfg4000-original_minfreq and bfg4000-original_maxfreq"
  echo ""
  echo "Turning up the heat.."

  sudo sd '^(scaling_max_freq =) (\d*)$' '$1 4000000' "$acfpath"
  sleep 1
  sudo systemctl restart auto-cpufreq.service
  sleep 2
  sudo systemctl restart auto-cpufreq.service

  echo ""
  echo "Configured Frequency: $(get_configured_min) - $(get_configured_max) KHz"
  sleep 2
  echo ""
  echo "      Querying Service State..."
  echo "----------------------------------------"
  sudo systemctl status auto-cpufreq.service --no-pager -l
  echo "----------------------------------------"
  echo ""
  echo "Monitoring core temperature and clock frequency for 10 seconds.."
  sleep 3

  echo "$(check_core_temperature)"
  sleep 3
  echo "$(check_core_temperature)"
  sleep 3
  echo "$(check_core_temperature)"
  sleep 1
  echo ""
  echo "Final Check"
  echo "$(check_core_temperature)"
  echo ""
  echo "Starting BFG-4000 @ $(date)"
  echo ""
  echo "Output will be tee'd to /tmp/bfg4000-tee"
  echo ""
  sleep 2
  echo "Firing.."
  sleep 1
  clear

  if [ -f "$HOME/.config/fish/resources/bfg/bfg.ogg" ]
    mpv "$HOME/.config/fish/resources/bfg/bfg.ogg" --really-quiet &;
  end

  sudo rg -u --no-ignore -i --mmap --follow --threads 12 --column --line-number --no-heading --color=never $argv | tee /tmp/bfg4000-results

  echo ""
  echo "BFG-4000 Finished @ $(date)"
  echo "Restoring original clocks.."
  sudo sd '^(scaling_max_freq =) (\d*)$' "\$1 $original_maxfreq" "$acfpath"
  sleep 1
  sudo systemctl restart auto-cpufreq.service
  sleep 2
  sudo systemctl restart auto-cpufreq.service
  sleep 1
  echo ""
  echo "Cores currently at $(cat $freqfile) KHz"
  coretempf -ug y -s 'Cores Averaging: ' -av
  coretempf -ug y -s 'Coldest Core: ' -tm -s ' | Peaking ' -tx
  echo ""
  sleep 2
  echo ""
  echo "      Querying Service State..."
  echo "----------------------------------------"
  sudo systemctl status auto-cpufreq.service --no-pager -l
  echo "----------------------------------------"
  
  echo ""
  echo "BFG-4000 Fired Successfully @ $(date)"
  echo "Shutting down..."
end

