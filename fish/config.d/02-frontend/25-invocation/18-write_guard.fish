function lock_write_perms
  set -f current_user $USER
  echo "Running as user: $current_user"

  set -f valid_files

  for file in $argv
    if test -f $file
      set -a valid_files $file
    else
      echo "File '$file' is not a valid file, ignoring it."
    end
  end

  sudo chown root $valid_files
  sudo chgrp $current_user $valid_files
  sudo chmod a=r $valid_files
  sudo chmod o-r $valid_files

  echo "File stripped of write perms."
end

function unlock_edit_relock
  set -f current_user $USER
  echo "Running as user: $current_user"

  set -f valid_files

  for file in $argv
    if test -f "$file"
      set -a valid_files "$file"
    else
      echo "File '$file' is not a valid file."
    end
  end

  set -l command "sudo chmod g+w $valid_files"
  echo "$command" | /bin/bash
  nvim "$file"

  set -l command "
    sudo chown root $valid_files
    sudo chgrp $current_user $valid_files
    sudo chmod a=r $valid_files
    sudo chmod o-r $valid_files
  " 
  echo "$command" | /bin/bash
end

alias 'unedre' unlock_edit_relock
alias 'wlock' lock_write_perms
