export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  . "$(codium --locate-shell-integration-path zsh)"
else
  ZSH_THEME="powerlevel10k/powerlevel10k" 
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/.cargo/env
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -r /var/home/quinn/.opam/opam-init/init.zsh ]] || source /var/home/quinn/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
plugins=(git)

alias c="clear"

export NPM_PACKAGES=$HOME/.npm-packages

export PATH=$PATH:$NPM_PACKAGES/bin:$HOME/go/bin
export PATH=$PATH:$HOME/bin

export ANDROID_HOME=~/Android/Sdk
export NDK_HOME=$ANDROID_HOME/ndk/27.1.12297006
export PATH=$NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH
export ANDROID_NDK_ROOT=$NDK_HOME

export CLANG_PATH=$NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/clang
export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=$NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android34-clang

export LIBCLANG_PATH="/var/home/quinn/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-16.0.4-20231113/esp-clang/lib"
export PATH="/var/home/quinn/.rustup/toolchains/esp/xtensa-esp-elf/esp-13.2.0_20230928/xtensa-esp-elf/bin:$PATH"

unset GDK_BACKEND
source /usr/share/nvm/init-nvm.sh

PATH="~/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="~/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="~/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"~/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/quinn/perl5"; export PERL_MM_OPT;
