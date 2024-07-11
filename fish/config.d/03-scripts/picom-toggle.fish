function picom-toggle
  if pgrep -x "picom" > /dev/null
    killall picom
  else
    picom -b --config ~/.config/i3/picom.conf
  end
end


function picom-log
  cat ~/.local/log/picom.log
end
