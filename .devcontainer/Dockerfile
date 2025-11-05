# Start from a feature-rich base image
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install zsh and the latest Neovim
RUN sudo apt-get update && sudo apt-get install -y zsh && \
    # Install latest stable Neovim (required for LazyVim)
    sudo apt install neovim && \
    # Clean up
    sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

# Set zsh as the default shell for the 'vscode' user (created by the base image)
# If you use a different base image, you may need to adjust the user
RUN sudo chsh -s /bin/zsh $(whoami)
