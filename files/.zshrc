alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
eval "$(rbenv init - zsh)"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
