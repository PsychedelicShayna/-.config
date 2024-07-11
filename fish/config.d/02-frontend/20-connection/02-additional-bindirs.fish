
# Sets GHCUP's install prefix to the user's home folder.
# As long as the install prefix wasn't previously modified.
set -q GHCUP_INSTALL_BASE_PREFIX[1]; 
or set GHCUP_INSTALL_BASE_PREFIX $HOME; 

# Haskell Programs
fish_add_path -aP $HOME/.ghcup/bin/
fish_add_path -aP $HOME/.cabal/bin/

# Ruby Programs
fish_add_path -aP $HOME/.local/share/gem/ruby/3.0.0/bin

# Rust Programs
fish_add_path -aP $HOME/.cargo/bin/
 
# Go Programs
fish_add_path -aP $HOME/go/bin/

