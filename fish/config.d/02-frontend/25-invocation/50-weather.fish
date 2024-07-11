function weather
  set area $argv[1]
  curl "wttr.in/$area"
end
