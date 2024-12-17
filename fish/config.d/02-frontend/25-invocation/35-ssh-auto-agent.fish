function ssh-agent-git
  pgrep 'ssh-agent' | xargs kill -9
  set -l ssh_agent_vars "$(ssh-agent -s)"
  set --erase SSH_AGENT_PID
  set --erase SSH_AUTH_SOCK
  set --universal --export SSH_AGENT_PID "$(echo "$ssh_agent_vars" | grep -o -E 'SSH_AGENT_PID=[^;]+;'  | cut -d '=' -f 2  | sed -e 's/;$//')"
  set --universal --export SSH_AUTH_SOCK "$(echo "$ssh_agent_vars" | grep -o -E 'SSH_AUTH_SOCK=[^;]+;'  | cut -d '=' -f 2  | sed -e 's/;$//')" 
  ssh-add "$HOME/.ssh/id_rsa_sign"
  git config --local gpg.format ssh
  git config --local user.signingkey "$(cat $HOME/.ssh/id_rsa_sign.pub)"
end
