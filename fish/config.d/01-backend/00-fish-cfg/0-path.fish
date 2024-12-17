if test -f "/etc/path"
  for line in (/bin/cat "/etc/path")
    if test -d $line
      set -gx PATH $PATH $line
    else
      echo "Fish: not adding '$line' from /etc/path to PATH becuse it doesn't exist."
    end
  end
else
  echo "Fish: cannot find /etc/path"
end

if test -f "$HOME/.path"
  for line in (/bin/cat "$HOME/.path")
    if test -d $line
      set -gx PATH $line $PATH 
    else
      echo "Fish: not adding '$line' from $HOME/.path to PATH becuse it doesn't exist."
    end
  end
else
  echo "Fish: cannot find $HOME/.path"
end
