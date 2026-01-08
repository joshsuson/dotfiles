#!/bin/bash

set -e

echo "🚀 Starting WSL Ubuntu setup..."

echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing essential packages..."
sudo apt install -y \
    build-essential \
    curl \
    wget \
    git \
    zsh \
    unzip \
    tmux

echo "📦 Installing zsh plugins..."
if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi

echo "📦 Installing nvm..."
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts

echo "📦 Installing zoxide..."
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

echo "📦 Installing starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "📦 Installing eza (modern ls)..."
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

echo "📦 Installing lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -f lazygit lazygit.tar.gz

echo "📦 Installing PHP and Composer..."
sudo apt install -y php php-cli php-mbstring php-xml php-curl php-zip unzip
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo "📦 Installing Neovim and dependencies..."
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim ripgrep fd-find

echo "⚙️  Installing LazyVim..."
if [ ! -d ~/.config/nvim ]; then
    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git
fi

echo "📦 Installing OpenCode..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
npm install -g @opencode/cli

echo "⚙️  Creating .tmux.conf configuration..."
cat > ~/.tmux.conf << 'EOF'
unbind r
bind r source-file ~/.tmux.conf

set -g default-terminal "screen-256color"
set -as terminal-features ",xterm-256color:RGB"

set -g prefix C-Space
bind C-Space send-prefix

set -g mouse on

bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R

set-option -g status-position top

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'vaaleyard/tmux-dotbar'
set -g @plugin 'christoomey/vim-tmux-navigator'

set -g @tmux-dotbar-position top

set -g @tmux-dotbar-bg default
set -g @tmux-dotbar-right true
# 12-hour clock with lowercase am/pm
set -g @tmux-dotbar-status-right "#[bg=default,fg=#565B66] %-I:%M%P #[bg=default,fg=#565B66]"

set-option -g renumber-windows on
set -g base-index 1
set -g pane-base-index 1

# Ensure status bar has no background color (transparent)
set -g status-bg default
set -g status-style bg=default,fg=white

# Ensure panes have no background color
set -g pane-border-style fg=default,bg=default
set -g pane-active-border-style fg=default,bg=default
set -g window-style fg=default,bg=default
set -g window-active-style fg=default,bg=default


# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'  
EOF

echo "⚙️  Installing tmux plugin manager..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "⚙️  Creating .zshrc configuration..."
cat > ~/.zshrc << 'EOF'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"

export EDITOR="nvim"

alias lg="lazygit"
alias ls="eza --icons=always"
alias art="php artisan"

eval "$(starship init zsh)"
export PATH="$HOME/.local/bin:$PATH"
EOF

echo "⚙️  Setting zsh as default shell..."
chsh -s $(which zsh)

echo "✅ Setup complete!"
echo "📝 Please log out and log back in for the shell change to take effect."
echo "🎨 LazyVim installed! Run 'nvim' and plugins will auto-install on first launch."
echo "🖥️  Tmux installed! Press 'prefix + I' (Ctrl-Space + Shift-I) in tmux to install plugins."
