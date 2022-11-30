#!/usr/bin/env bash

if [ -z "$HOME" ]; then echo "Seems you're \$HOMEless :("; exit 1; fi

DOTCONFIG=$HOME/.config
DOTFILES=$HOME/.dotfiles
DOTFZF=$HOME/.fzf
DOTLOCAL=$HOME/.local/share/dotfiles

GITCLONE="git clone --depth=1"

cd "$HOME" || exit
rm -rf "$DOTFILES"
mkdir "$DOTFILES"
cd "$DOTFILES" || exit

git clone git@github.com:OB3RG/dotfiles.git $DOTFILES

rm -rf \
  "$DOTFZF" \
  "$DOTLOCAL" \
  "$HOME/.bashrc" \
  "$HOME/.gitconfig" \
  "$HOME/.zshrc" \
  "$HOME/.xprofile" \
  "$HOME/.xutils" \
  "$DOTCONFIG/starship.toml" \
  "$DOTCONFIG/nvim" \
  "$DOTCONFIG/bspwm" \
  "$DOTCONFIG/kitty" \
  "$DOTCONFIG/picom" \
  "$DOTCONFIG/polybar" \
  "$DOTCONFIG/sxhkd" \
  "$DOTCONFIG/gtk-3.0"



mkdir -p \
  "$DOTLOCAL" \

ln -s "$DOTFILES/bashrc" "$HOME/.bashrc"
ln -s "$DOTFILES/gitconfig" "$HOME/.gitconfig"
ln -s "$DOTFILES/zshrc" "$HOME/.zshrc"
ln -s "$DOTFILES/xorg/xprofile" "$HOME/.xprofile"
ln -s "$DOTFILES/xorg/xutils" "$HOME/.xutils"
ln -s "$DOTFILES/gitconfig" "$HOME/.gitconfig"
ln -s "$DOTFILES/starship.toml" "$DOTCONFIG/starship.toml"
ln -s "$DOTFILES/nvim" "$DOTCONFIG/nvim"
ln -s "$DOTFILES/bspwm" "$DOTCONFIG/bspwm"
ln -s "$DOTFILES/kitty" "$DOTCONFIG/kitty"
ln -s "$DOTFILES/picom" "$DOTCONFIG/picom"
ln -s "$DOTFILES/polybar" "$DOTCONFIG/polybar"
ln -s "$DOTFILES/sxhkd" "$DOTCONFIG/sxhkd"
ln -s "$DOTFILES/gtk-3.0" "$DOTCONFIG/gtk-3.0"

$GITCLONE https://github.com/junegunn/fzf.git "$DOTFZF"
"$DOTFZF/install" --key-bindings --completion --no-update-rc

ZSHPLUGS=(
  "zsh-completions"
  "zsh-history-substring-search"
  "zsh-syntax-highlighting"
)

for INDEX in ${!ZSHPLUGS[*]}; do
  ZSHPLUG="${ZSHPLUGS[$INDEX]}"
  $GITCLONE "https://github.com/zsh-users/$ZSHPLUG.git" "$DOTLOCAL/$ZSHPLUG"
done

cd "$HOME" || exit
rm -f "${HOME}/.zcompdump*"

echo "ENJOY! :)"

