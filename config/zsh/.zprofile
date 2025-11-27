# export XDG_RUNTIME_DIR="/tmp/run/user/$(id -u)"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/scripts/statusbar:$PATH"
export PATH="$HOME/scripts/desktop:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

export GOPATH="$HOME/src/go"
export GOBIN="$HOME/src/go/bin"
export PATH="$GOBIN:$PATH"

export ANDROID_HOME="$HOME/src/android"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"

export DOTNET_ROOT="$HOME/dotnet"
export PATH="$DOTNET_ROOT:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export GPG_TTY=$(tty)
export EDITOR=nvim
export TERMINAL=foot
export TERM=foot
export OPENER=xdg-open

export PF_INFO="ascii title os kernel wm shell editor palette"

export GTK_USE_PORTAL=0

. "$HOME/.cache/wal/env-color"
. "$HOME/.config/sops-nix/secrets/api-keys.env"
