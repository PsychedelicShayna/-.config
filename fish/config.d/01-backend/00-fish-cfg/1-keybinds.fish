

function fish_user_key_bindings
  bind --mode default --user \eu redo # Alt-u to redo, u to undo.
  bind --mode insert --user \eu undo
  bind --mode insert --user \eU redo
  bind --mode insert --user \em __fish_man_page
  bind --mode default --user \em __fish_man_page

  bind --mode insert --user \ek up-or-search
  bind --mode insert --user \ej down-or-search
  bind --mode insert --user \el forward-char
  bind --mode insert --user \eh backward-char

  bind --mode default --user \eK kill-whole-line repaint
  bind --sets-mode default --mode insert --user \eK kill-whole-line repaint

  bind --sets-mode default --mode insert --user \ei repaint

  bind --mode default --user \eh 'prevd; commandline -f repaint'
  bind --mode default --user \el 'nextd; commandline -f repaint'

  bind --mode default --user \cd ls -la
  bind --mode insert --user \ed dirh
  bind --mode default --user \ed dirh

  bind --mode insert --user \eD cdh repaint
  bind --mode default --user \eD cdh repaint

  bind --mode default \r 'commandline -f execute; commandline -f backward-char'


end
