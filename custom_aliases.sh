
# create alias file
# touch ~/.custom_aliases


#Add code block below into ~/.bashrc or ~/.zshrc

if [ -e $HOME/.custom_aliases ]; then
    source $HOME/.custom_aliases
fi
# -----------------custom_aliases file -----------------------------

# alias name='command'
# alias name='command arg1 arg2'
# alias name='/path/to/script'
# alias name='/path/to/script.pl arg1'

# Print my public IP
alias myip='curl ipinfo.io/ip'

alias c='clear'
alias v='code' #visual studio code cli
