function novelty --argument length -d "List the last n (100) packages installed"
    if test -z $length
        set length 100
    end

    expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n $length | nl
end

alias nov='novelty'
