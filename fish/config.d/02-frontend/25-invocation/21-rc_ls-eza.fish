
if command -v 'eza' > /dev/null
  alias ls=eza

  function lsc
    sh -c "ls $argv"
  end
else if command -v 'exa' > /dev/null
  alias ls=exa

  function lsc
    sh -c "ls $argv"
  end

  echo "Consider installing eza a continued fork of exa; exa is no longer maintained."
end

alias ll=lsd 

function lss
  set -f command "lsd"
  set -f passarg 3

  switch $argv[1]
    case "e"
                        # '--classify' \
                        # '--context' \
                        # '--inode' \
      set -f -a command '--sort' \
                          'extension' \
                        '--oneline' \
                        '--git' \
                        '--group-dirs=first' \
                        '--all' \
                        '--date' \
                          'relative' \
                        '--blocks' \
                          'size,date,permission,user,group,name' \
                        '--permission' \
                          'octal' \



    case "s"
      set -f -a command '--sizesort'

    case "t"
      set -f -a command '--timesort'

    case "p"
      set -f -a command '--permission' \
                        'octal'
    case '*'
      set -f passarg (echo (math "$passarg - 1"))
  end

  switch $argv[2]
    case '*'
      set -f passarg (echo (math "$passarg - 1"))
  end

  set -f -a command "."

  $command $argv[$passarg..]

end

# lsd --blocks name,size,user,permission,group,date --group-directories-first --git --human-readable --timesort --reverse --all --tree --depth 1

# alias ls="ls --color=auto" alias la="ls -a" alias ll="ls -alFh" alias l="ls" alias l.="ls -A | egrep '^\.'"
# alias listdir="ls -d */ > list"

