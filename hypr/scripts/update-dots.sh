#!/bin/bash

CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/dotfiles"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE} Dotfiles Backup Sync Script${NC}"
echo -e "${BLUE}========================================${NC}\n"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo -e "${RED}Error: $DOTFILES_DIR does not exist${NC}"
  exit 1
fi

echo -e "${YELLOW}Syncing from $CONFIG_DIR → $DOTFILES_DIR${NC}\n"

synced_count=0
warning_count=0

for folder in "$DOTFILES_DIR"/*; do
  [ -d "$folder" ] || continue
  folder_name=$(basename "$folder")

  if [ -d "$CONFIG_DIR/$folder_name" ]; then
    echo -e "${GREEN}🔄 Syncing $folder_name...${NC}"
    rsync -av --delete "$CONFIG_DIR/$folder_name/" "$DOTFILES_DIR/$folder_name/"
    synced_count=$((synced_count + 1))
  else
    echo -e "${YELLOW}⚠️ '$folder_name' exists in dotfiles but not in .config${NC}"
    warning_count=$((warning_count + 1))
  fi
  echo ""
done

# Sync individual files
echo -e "${YELLOW}Syncing individual config files...${NC}"

[ -f "$HOME/.tmux.conf" ] && rsync -av "$HOME/.tmux.conf" "$DOTFILES_DIR/tmux.conf" && echo -e "${GREEN}✅ Synced .tmux.conf${NC}" && synced_count=$((synced_count + 1))
[ -f "$HOME/.zshrc" ] && rsync -av "$HOME/.zshrc" "$DOTFILES_DIR/zshrc" && echo -e "${GREEN}✅ Synced .zshrc${NC}" && synced_count=$((synced_count + 1))
[ -f "$HOME/.bashrc" ] && rsync -av "$HOME/.bashrc" "$DOTFILES_DIR/bashrc" && echo -e "${GREEN}✅ Synced .bashrc${NC}" && synced_count=$((synced_count + 1))

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}✅ Sync completed${NC}"
echo -e "🔄 Synced: $synced_count"
echo -e "⚠️  Missing in .config: $warning_count"
echo -e "${BLUE}========================================${NC}"
