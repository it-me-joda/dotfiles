#!/bin/zsh

git pull

echo "updating configs..."

cp -ruv config ~/.config
cp -u assets/cat.png ~/.config/background.png

cp -u .gitconfig ~/.gitconfig

source ~/.zshrc
source ~/.p10k.zsh

echo "updated configs"
echo "restarting waybar..."
killall waybar
waybar &> /dev/null & disown;
