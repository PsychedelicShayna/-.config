#!/usr/bin/fish


function encaes
  if [ ! -f (which openssl 2>&1) ] 
    echo "Could not find OpenSSL on this system."
    echo "Please install OpenSSL and try again."
    return
  end

  set -f decrypt $argv[1]

  if test "$argv[1]" != "-d" 
    set -f decrypt ""
  end

  if test "$argv[1]" = "-d"
    set -f decrypt "-d"
  end

  set -f in $argv[1]
  set -f out $argv[2]

  set -f usage "Usage: encaes (-d) <input file> <output file>"
  
  if [ -z $in ]
    echo "Please specify an input file."
    echo "$usage"
    return
  end

  if [ -z $out ]
    echo "Please specify an output file."
    echo "$usage"
    return
  end

  set -f command openssl enc -aes-256-cbc

  set argrem $argv[3..]

  if not test -z $argrem[1]
    set -a command $argrem
  end

  set -f pbkdf2_iter 100001

  set -a command -pbkdf2 -iter $pbkdf2_iter -salt -in $in -out $out

  echo "Preparing to encrypt"
  echo "$out <- ( $in [ -aes-256-cbc | -pbkdf2/$pbkdf2_iter | -salt ] ) "
  
  echo ($command)
end
