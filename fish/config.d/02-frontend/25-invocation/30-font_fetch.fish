function font_fetch_nerd
  echo "$(ls /usr/share/fonts/OTF) 
        $(ls /usr/share/fonts/TTF)" \
    | rg 'nerd' -i                  \
    | rg '(^[^-]+)-+' -o -r '$1'    \
    | uniq                          \
    | rg '(^.+)Nerd' -o -r '$1'     \
    | uniq
end
