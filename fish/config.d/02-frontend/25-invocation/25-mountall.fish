function mountall
  set partitions (sudo fdisk --list | rg -U '.*Device.*\n(^/.+\n)+' | rg '/dev/[a-z0-9]+[1-9]' -o)
  echo "About to mount the following partitions, to /mnt/NAME"
  echo "Confirm that you want to proceed?"
  echo "---------------------------------------------------"
  echo "$partitions"
  echo "---------------------------------------------------"
  echo "Press y to proceed, any other key to abort"
  echo ""

  # Receive user confirmation
  set confirmation "$(read)"

  if test $confirmation != "y"
    echo "Aborting..."
    return
  end

  echo "Proceeding..."

  for partition in $partitions
    set name "$(echo $partition | rg -o '\/dev\/(.+)' -o -r '$1')"
    echo "Mounting $partition to /mnt/$name"
    sudo mkdir -p "/mnt/$name"
    sudo mount "$partition" "/mnt/$name"
  end
end
