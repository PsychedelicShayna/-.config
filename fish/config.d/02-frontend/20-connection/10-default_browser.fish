if command -sq firefox-developer-edition
  set -U BROWSER firefox-developer-edition
else if command -sq firefox
  set -U BROWSER firefox
else if command -sq chromium
  setenv -U BROWSER chromium
else if command -sq w3m
  setenv BROWSER 'alacrity -e \'w3m\''
else if command -sq lynx
  setenv BROWSER 'alacrity -e \'lynx -vikeys \''
else
  echo '[Fish] Missing BROWSER environment variable. No default browser.'
end
