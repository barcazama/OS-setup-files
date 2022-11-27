# Section: loading modules and configurations
#neofetch
PROMPT_DIRTRIM=1

# Aliases
## Navigation
alias folder-documents='cd /home/cooper/OneDrive/Documents/'
alias folder-studies='cd /home/cooper/OneDrive/Documents/studies/4.Master'

## Update
alias sudo='sudo '
alias update-script='sudo apt update && sudo apt upgrade && sudo apt autoremove && flatpak update'
alias update-conda='conda update conda && pip install --upgrade pip'

## Compress PDF
compress-high() {
    # compress pdf $2 into $1 using minimizing size
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$1 $2
}
compress-medium() {
# compress pdf $2 into $1 using an average compression (equilibrium between quality and size)
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$1 $2
}
compress-low() {
# compress $2.pdf into $1.pdf minimizing loss (only limited reduction of size)
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/preprint -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$1 $2
}

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 2>/dev/null ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end
