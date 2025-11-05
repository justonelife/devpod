#!/bin/bash
set -e # Exit immediately if a command fails

echo "Starting post-create setup..."

# --- 1. SET YOUR DOTFILES REPO HERE ---
# !!! IMPORTANT: Change this URL to your dotfiles repository !!!
DOTFILES_REPO_URL="https://github.com/justonelife/dotfiles.git"

# --- 2. Clone Your Dotfiles ---
echo "Cloning dotfiles from $DOTFILES_REPO_URL..."
# We clone into a directory named 'dotfiles' in the home folder
git clone $DOTFILES_REPO_URL $HOME/dotfiles

# --- 3. Run Your Dotfiles Installer ---
# This script assumes you have an install script (e.g., install.sh, setup.sh)
# in your repo that symlinks your configs (like .zshrc, .config/nvim, etc.)
echo "Looking for dotfiles setup script (install.sh or setup.sh)..."

if [ -f "$HOME/dotfiles/install.sh" ]; then
  echo "Running install.sh..."
  bash "$HOME/dotfiles/install.sh"
elif [ -f "$HOME/dotfiles/setup.sh" ]; then
  echo "Running setup.sh..."
  bash "$HOME/dotfiles/setup.sh"
else
  echo "-----------------------------------------------------------------"
  echo "WARNING: No 'install.sh' or 'setup.sh' found in your dotfiles repo."
  echo "You will need to link your configs manually."
  echo "e.g., ln -s $HOME/dotfiles/.config/nvim $HOME/.config/nvim"
  echo "-----------------------------------------------------------------"
fi

# --- 4. Install LazyVim Plugins ---
# This assumes Step 3 correctly linked your Neovim config to $HOME/.config/nvim
echo "Setting up LazyVim (installing plugins)..."

if [ -d "$HOME/.config/nvim" ]; then
  # Run nvim in headless mode to bootstrap plugins
  # This automatically syncs and installs everything defined in your config
  echo "Found nvim config, running LazyVim sync..."
  nvim --headless "+Lazy! sync" +qa
  echo "LazyVim setup complete."
else
  echo "WARNING: $HOME/.config/nvim directory not found."
  echo "Skipping LazyVim setup. Make sure your dotfiles link it correctly."
fi

echo "-------------------------------------"
echo "Post-create setup finished."
echo "Workspace is ready!"
echo "-------------------------------------"
