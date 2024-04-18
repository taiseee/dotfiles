alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
eval "$(rbenv init - zsh)"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

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
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export VOLTA_FEATURE_PNPM=1

topdf() {
    local path=$1
    
    # 引数がファイルの場合
    if [[ -f "$path" ]]; then
        local output_file="${path%.*}.pdf"
        convert "$path" -auto-orient "$output_file"
        echo "converted $path to $output_file."
    
    # 引数がディレクトリの場合
    elif [[ -d "$path" ]]; then
        # ディレクトリ内のすべてのサポートされる画像ファイルに対してループ
        for img_file in "$path"/*; do
            # ファイルが画像ファイルかどうかをチェック
            if [[ -f "$img_file" ]]; then
                local mimetype=$(file --mime-type -b "$img_file")
                if [[ "$mimetype" == image/* ]]; then
                    local output_file="${img_file%.*}.pdf"
                    convert "$img_file" -auto-orient "$output_file"
                    echo "converted $img_file to $output_file."
                fi
            fi
        done
    
    else
        echo "Please specify a supported image file or folder."
    fi
}