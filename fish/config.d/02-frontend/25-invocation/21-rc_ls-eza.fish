alias l /usr/bin/ls
alias ll=lsd
alias lstree 'erd --hidden -l -H -I --follow --nlink --layout inverted --dir-order last --ino --group --octal --sort create --time mod --threads 8 --one-file-system --time-format iso --sort mod -y inverted'
alias lse erd

if command -v 'eza' > /dev/null
  alias ls=eza
else if command -v 'exa' > /dev/null
  alias ls=exa
  echo "Consider installing eza a continued fork of exa; exa is no longer maintained."
end


function lsda
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

