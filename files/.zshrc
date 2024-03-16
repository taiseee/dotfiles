alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
eval "$(rbenv init - zsh)"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
alias -g ...='../..'
alias -g ....='../../..'

# vpn 接続
function vpn() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: vpn <start|stop> <vpn_service_name>"
        return 1
    fi

    if [ "$1" = "start" ]; then
        networksetup -connectpppoeservice "$2"
        echo "success to connect $2."
        return 0
    fi

    if [ "$1" = "stop" ]; then
        networksetup -disconnectpppoeservice "$2"
        echo "success to disconnect $2."
        return 0
    fi

    echo "Invalid action. Use 'start' or 'stop'."

    return 1
}
