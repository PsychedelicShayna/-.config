alias kill-fossils 'pgrep -i fossilize | sudo xargs kill -9'

function fossile-kill-monitor
  set fossils (pgrep -i fossilize) 

  set -f checks 1
  set -f interval 1

  if not test -z $argv[1]
    set -f checks $argv[1]
  end

  if not test -z $argv[2]
    set -f interval $argv[2]
  end

  echo "Checks $checks, interval $interval"

  while true

    for pid in (pgrep -i "fossilize-re")
      if test -d "/proc/$pid" 
        sudo kill -9 $pid
      end
    end

    set checks (math "$checks - 1")

    # Loop breaks here, to avoid sleeping after the last check,
    # or at the start of the first check. Exits immediately.

    if test $checks -le 0
      echo "Checks complete."
      break
    end

    sleep $interval
  end
end



