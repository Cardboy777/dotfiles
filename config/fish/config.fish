if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Setup custom environment
if test -e ~/Scripts/fish/shell-init.fish
  source ~/Scripts/fish/shell-init.fish
end


starship init fish | source
