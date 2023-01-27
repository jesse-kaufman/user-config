# User Configuration

1. Rename this directory to ~/.config/
1. Create symlinks

   ```bash
   ln -sf ~/.config/oh-my-bash/bashrc ~/.bashrc
   ln -sf ~/.config/.phpcs.xml.dist   ~/.phpcs.xml.dist
   ln -sf ~/.config/terminfo          ~/.terminfo
   ln -sf ~/.config/inputrc           ~/.inputrc
   ln -sf ~/.config/htop/htoprc       ~/.htop
   ln -sf ~/.config/git/config        ~/.gitconfig
   ln -sf ~/.config/composer          ~/.composer
   ln -sf ~/.config/.luarc.json       ~/.luarc.json
   ln -sf ~/.config/editorconfig      ~/.editorconfig
   ln -sf ~/.config/shellcheckrc      ~/.shellcheckrc
   ln -sf ~/.config/bin               ~/bin
   ```

1. Install additional software ([see below](#additional-software-installation))
1. Setup NeoVim

_... to be completed_

## Additional Software Installation

### Package Managers

```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# nodejs
brew install nodejs

# composer
brew install composer

# rust (Only required until LSD's next release with color support)
brew install rust
```

---

### Global Composer Dependencies

```bash
composer global install
```

---

### macOS-only Dependencies

```bash
# gnu coreutils
brew install coreutils

# bash-completion
brew install bash-completion
```

---

### Other Apps

```bash
# neovim
brew install neovim --HEAD

# htop
brew install htop

# vint (Use this over the Mason auto-install so we can use HEAD)
brew install vint --HEAD
```

---

#### Setup NeoVim

1. Run NeoVim and run `:PlugInstall`
1. Restart NeoVim and wait for Mason to install dependencies

... to be completed
