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

#### Homebrew

[Homebrew](https://www.brew.sh/)

#### Nodejs/NPM

`brew install nodejs`

#### Cargo/Rust

*Only required until LSD's next release with color support*
`brew install rust`

### Linters/Formatters/Language Servers, Oh My

#### Vint (vimscript)

`brew install vint`

... to be completed
