if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Setup custom environment
if test -e ~/Repositories/dotfiles/scripts/fish/shell-init.fish
  source ~/Repositories/dotfiles/scripts/fish/shell-init.fish
end


starship init fish | source
