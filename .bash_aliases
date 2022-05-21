# Section: loading modules and configurations
#neofetch
PROMPT_DIRTRIM=1

# Aliases
## Update
alias sudo='sudo '
alias updates_script='sudo apt update && sudo apt upgrade'
alias updates_full_script='sudo apt update && sudo apt upgrade && sudo apt autoremove && conda update conda && pip install --upgrade pip'

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 2>/dev/null ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

