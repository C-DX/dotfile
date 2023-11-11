if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias ls "eza"
alias ll "eza -l"

starship init fish | source
zoxide init fish | source
