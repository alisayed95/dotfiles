# dotfiles

My macOS terminal setup, themed with [Catppuccin Mocha](https://catppuccin.com) and managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's inside

| Package | Config for | Highlights |
|---|---|---|
| [`zsh`](zsh/.zshrc) | [Oh My Zsh](https://ohmyz.sh) | Autosuggestions, syntax highlighting, `fzf`, `zoxide` and `colorls` |
| [`starship`](starship/.config/starship.toml) | [Starship](https://starship.rs) | Custom prompt |
| [`kitty`](kitty/.config/kitty/kitty.conf) | [kitty](https://sw.kovidgoyal.net/kitty/) | Hack Nerd Font and Catppuccin Mocha |
| [`tmux`](tmux/.config/tmux/tmux.conf) | [tmux](https://github.com/tmux/tmux) | Rounded status bar, per-program window icons and a colored session list |
| [`nvim`](nvim/.config/nvim/init.lua) | [Neovim](https://neovim.io) | [lazy.nvim](https://github.com/folke/lazy.nvim), LSP, completion, Treesitter, Neo-tree and Yazi |
| [`zed`](zed/.config/zed/settings.json) | [Zed](https://zed.dev) | Settings, keymap and tasks |
| [`karabiner`](karabiner/.config/karabiner/karabiner.json) | [Karabiner-Elements](https://karabiner-elements.pqrs.org) | Caps Lock is Esc when tapped and Control when held |
| [`brew`](brew/Brewfile) | [Homebrew](https://brew.sh) | The tools I install on a new machine |

## Install

> [!WARNING]
> These are my personal settings, and the Brewfile installs everything in it, including tools you may not want. Read through them first and keep what you like.

These steps assume [Homebrew](https://brew.sh) is already installed.

**1. Clone the repo**

```bash
git clone https://github.com/alisayed95/dotfiles.git ~/dotfiles
```

**2. Install the tools**

Review the [Brewfile](brew/Brewfile) first, then run:

```bash
brew bundle --file=~/dotfiles/brew/Brewfile
```

kitty, Zed and Karabiner-Elements aren't in the Brewfile. Install the ones you want separately.

**3. Install the zsh extras**

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
```

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
```

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

```bash
gem install colorls
```

**4. Link the configs**

Stow refuses to overwrite existing files, so move any config you already have out of the way first. Link only the packages you want:

```bash
stow -d ~/dotfiles -t ~ zsh starship kitty nvim zed karabiner
```

Use `--no-folding` for tmux, so plugins install in `~/.config/tmux/plugins` and not inside this repo:

```bash
stow -d ~/dotfiles -t ~ --no-folding tmux
```

**5. Install the tmux plugins**

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

Then start tmux and press `Ctrl-s` followed by `I`.

## tmux keys

The prefix is `Ctrl-s`.

| Keys | Action |
|---|---|
| `prefix` + `r` | Reload the config |
| `prefix` + `s` | Open the session list |
| `prefix` + `h` / `j` / `k` | Move between panes |

## Private settings

`.zshrc` also loads `~/.zshrc.local` if it exists. That file isn't in this repo, so it's the place for tokens and machine-specific settings:

```bash
export MY_TOKEN="..."
```

## Using it

The files in your home folder are symlinks into this repo, so edit them as usual and commit from `~/dotfiles`. To remove a package's links:

```bash
stow -d ~/dotfiles -t ~ -D kitty
```
