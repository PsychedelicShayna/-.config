from subprocess import Popen, STDOUT, PIPE
from typing import IO
from result import Ok, Err, Result
import re



def cpu_temp_sensor() -> Result[dict[str, float], str] | None:
    sensors: Popen[bytes] = Popen(['sensors'], stdout=PIPE, stderr=STDOUT)
        
    if not isinstance(sensors.stdout, IO):
        return None
    
    try:
        output: list[bytes] = sensors.stdout.readlines()
    except UnicodeDecodeError:
        return None
    else:
        if not isinstance(output, list):
            return None
    
    core_regex: re.Pattern = re.compile(r'(Core \d):[^+]*\+(\d\d\d?\.\d)')
    
    def get_matches(line: bytes) -> tuple[str, float] | None:
        matches: re.Match | None = core_regex.search(line)

        if not isinstance(matches, re.Match):
            return None

        groups = matches.groups()

        if not isinstance(groups, tuple) or len(groups) != 2:
            return None

        return (groups[0], float(groups[1]))

    core_temps = filter(None, map(get_matches, output))

    return { core:temp for (core, temp) in core_temps }


    
if __name__ == '__main__':
    print(cpu_temp_sensor())

    

  # set -f temps (echo '(' (sensors | rg -i -e 'Core \d:[^+]*\+(\d\d\d?\.\d)' -o -r '$1' )
  # set -f min_t (echo ("math min '(' ($temps | string join ',') ')')
  # math -s 1 (echo '(' (sensors | rg -i -e 'Core \d:[^+]*\+(\d\d\d?\.\d)' -o -r '$1' | string join ' + ') ') / 6')
