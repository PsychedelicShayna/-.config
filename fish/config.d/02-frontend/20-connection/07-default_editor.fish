if command -sq nvim
  set -l options nvim vim helix emacs joe nano ed NO_EDITOR_SET
  
  for editor in $options
    if command -sq "$option"
      set -U EDITOR "$option"
      set -U VISUAL "$option"
      break
    end
  end

  if test "$EDITOR" = 'NO_EDITOR_SET'
    echo '[Fish] Missing EDITOR and VISUAL environment variables. No default editor.'
  end

end

