#! bash
# shellcheck shell=bash

# Upgrade LSD from HEAD
cargo install --git https://github.com/Peltoche/lsd.git --branch master --force



# Upgrade brew casks and fomulae
brew update && brew upgrade;

# Upgrade nvim from HEAD
