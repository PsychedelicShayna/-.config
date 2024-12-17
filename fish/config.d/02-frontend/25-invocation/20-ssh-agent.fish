
function ssh-agent-fish
  set -x ssh_agent_vars "$(ssh-agent -s)"
  set -Ux SSH_AUTH_SOCK "$(echo "$ssh_agent_vars" | grep -o -E 'SSH_AUTH_SOCK=[^;]+;'  | cut -d '=' -f 2  | sed -e 's/;$//')" 
  set -Ux SSH_AGENT_PID "$(echo "$ssh_agent_vars" | grep -o -E 'SSH_AGENT_PID=[^;]+;'  | cut -d '=' -f 2  | sed -e 's/;$//')"
  echo "Setup via: $SSH_AUTH_SOCK"
  echo "Agent PID: $SSH_AGENT_PID"
end

