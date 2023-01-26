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

_... to be completed_

## Additional Software Installation

### Package Managers

- [Homebrew](https://www.brew.sh/)
- [NPM (nodejs)](https://www.nodejs.org)
- [Cargo/Rust](https://www.rust-lang.org) [^1]
- [Composer](https://getcomposer.org)

[^1]: _Only required until LSD's next release with color support_

```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# nodejs
brew install nodejs

# rust
brew install rust

# composer
brew install composer
```

### Linters/Formatters/Language Servers

- [Vint (vimscript)](https://github.com/Vimjas/vint) [^2]

[^2]: _Use this over the Mason auto-install so we can use HEAD_

```bash
# vint
brew install vint --HEAD
```

... to be completed

### Global Composer Dependencies

```bash
composer global install
```

### macOS-only Dependencies

```bash
# gnu coreutils
brew install coreutils

#  bash-completion
brew install bash-completion
```

### Other Apps

```bash
# neovim
brew install neovim --HEAD
brew install htop
```

... to be completed
