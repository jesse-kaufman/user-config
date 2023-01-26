# User Configuration

1. Rename this directory to ~/.config/
1. Create symlinks

    ```bash
    ln -s ~/.config/terminfo/ ~/.terminfo/
    ln -s ~/.config/inputrc ~/.inputrc
    ln -s ~/.config/htop/htoprc ~/.htop
    ln -s ~/.config/composer/ ~/.composer/
    ln -s
    #end```

1. Install additional software
   ...

## Additional Software Installation

### Package Managers

#### Homebrew

[Homebrew](https://www.brew.sh/)

#### Nodejs/NPM

```bash
brew install nodejs
```

#### Cargo/Rust

Only required until LSD's next release with color support

```bash
brew install rust
```

### Linters/Formatters/Language Servers, Oh My

#### Vint (vimscript)

`brew install vint`

... to be completed
