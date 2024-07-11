# Generates Zoxide's initialization script,
## sources it, and replaces cd to use Zoxide.
zoxide init fish | source

function cd
	__zoxide_z $argv; 
	and ls
end


