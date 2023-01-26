# User Configuration

1. Rename this directory to ~/.config/
1. Create symlinks

   ```bash
   ln -s ~/.config/terminfo/ ~/.terminfo/
   ln -s ~/.config/inputrc ~/.inputrc
   ln -s ~/.config/htop/htoprc ~/.htop
   ln -s ~/.config/composer/ ~/.composer/
   ln -s
   ```

1. Install additional software ([see below](#additional-software-installation))

*... to be completed*

## Additional Software Installation

### Package Managers

* [Homebrew](https://www.brew.sh/)
* [NPM (nodejs)](https://www.nodejs.org)
* Cargo/Rust [^1]

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install nodejs
brew install rust
```

[^1]: *Only required until LSD's next release with color support*

### Linters/Formatters/Language Servers, Oh My

#### Vint (vimscript)

`brew install vint`

... to be completed
