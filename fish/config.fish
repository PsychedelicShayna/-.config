breakpoint

if not status --is-interactive 
  exit 
end

function fish_greeting 
end

function fish_reload_config
	exec fish
	set -l config (status -f)
	echo "Reloading: $config"
end

set -l CONFD "$HOME/.config/fish/config.d"

set -g FISH_SOURCED_FILES

function source_dir
  if test -d $argv[1]  
    set -l files (find "$argv[1]" -type f -iregex '.+\.fish$' | sort)
    
    for file in $files
      if test -f "$file"
        source "$file"
        set -a FISH_SOURCED_FILES "$file"
      end
    end
  else
    echo "(WARNING) Attempted to source invalid directory: $argv[1] does not exist"
  end
end

source_dir $CONFD
