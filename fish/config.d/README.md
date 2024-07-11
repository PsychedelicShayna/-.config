# Fish Configuration Structure 

Abstractly, how can we categorize the different sorts of commands, or rather,
expressions evaluated by a shell?

Ultimately, each expression has a purpose, some intended functionality. How
do we capture the type of function that these expressions have? By that I
don't literally mean a `function()`, but _what function does it have, and
can that be grouped with others of its kind?_

### Binaries
The function of a binary comes from the binary itself. These don't need a folder, as they live self-sufficiently.

## Native Scripts
- Directory: `scripts/native/` 

- Functionality must emerge primarily from the shell's native scripting language; programs written in Fish.

- They may invoke binaries to achieve their goal, so long as the binary can be considered a standard tool serving a widely-applicable purpose that is not relates to the script's ultimate goal. 

  Just as programming languages invoke functions from their standard library. If the binary is doing the work, and the script is just a front-end, then it cannot be reasonably considered a fish program.

  If different environments supporting the same shell have different but equally standard equivalents of a binary, such as `cat` on Linux being `type` on Windows, then it still qualifies as standard, relative to that environment, and is therefore permitted.

  In short: the script cannot orbit a binary, but binaries may orbit the script as generally applicable, __standardized__ tools to progress towards the script's goal.

- Real world example: installers, such as ghcup (for Haskell) or rustup (for Rust), that download, install and configure a whole tool-chain, and can be used to manage existing installations, download new versions, delete old versions, etc. They are agnostic, written in `sh`'s tongue (or `bash` possibly), and work anywhere that `sh` does, which __reasonably__ means `cat`, `wget`, `curl`, etc, will also be present.


### Local Scripts
- Directory: `scripts/local/`

- The same as a Native Script, but exempt from the condition that invoked binaries need to be reasonably considered standard.

Non-standard binaries specific to your local environment, such as `rg`, `tshark`, `proxychains`, `gh`, `nmap`, `strace`, etc, are permitted.

- __However__, the condition that any invoked binaries must be a component of a solution, but not 90% of the solution itself, still applies. Quantifying this is unrealistic, so just ask yourself if what you're writing looks like a front-end orbiting a binary, or an independent piece of logic with binaries orbiting _it_, used as tools to achieve something greater.

If you orbit a binary, that is, rely on a binary in your script, what reasons could you have? 

To enhance the user experience, in a way that relies or builds upon a binary, the binary being the larger core functionality.
This includes: functions that chains the output of multiple binaries and manipulates them along the way, or passes 
default arguments to a binary, or simple aliases that are alternate ways to summon the desired functionality.

This includes creating keybindings for the shell to interact with the binary as well.

It's impossible to categorize the millions of different ways a script can relate to a binary.
It's sufficient to capture the most common patterns:

Providing shell completion for a binary's functionality.
Messing with the way you invoke the binary's functionality.

Connecting something to the binary, or connecting the binary to something;
an environment variable is just text, but you create a connection by defining
it, between the binary and the data.

The PATH variable, connects the directories where the binaries are stored, to the shell.
Or the krypton vault variable, connects the krypton vault to krypton.

Connection means not to introduce a new piece of logic, but to connect existing pieces of logic,
in a way that is natively understood by both pieces (like a USB cable, both ends agree on the protocol,
and the socket is designed to fit such a cable, you did not need to introduce your own logic to
achieve whatever behavior connecting the cable creates).

Environment variables fall under connection, because they're useless alone. They're only ever
useful in the context of some other logic looking for it and reacting to it. You are connecting
a string to that logic by creating the string in the first place.

Unlike completions, which may contain logic of their own, such as conditional completion,
in PowerShell you'd call them advanced functoin parameters.

Launching services, or starting starship, is also connecting. You connect COD to your session, and
same with starship. Connection doubles as integration of external behavior into Fish.


front/completion/
front/invocation/
front/connection/



This has nothing to do with binaries, or creating a script or program,
but rather to adjust Fish itself. It's just adjusting its default options.
Themes, or prompt design, would fall under config/



config/





