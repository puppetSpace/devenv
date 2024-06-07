# install vscode
rpm --import https://packages.microsoft.com/keys/microsoft.asc      
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
dnf install code

# install git
dnf install git

#install zsh
dnf install zsh
echo "zsh" >> ~/.bashrc

#install oh-my-posh
curl -LO --create-dirs --output-dir ~/.devenv  https://raw.githubusercontent.com/puppetSpace/terminalthemes/main/puppet.omp.json
mkdir ~/ohmyposh
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/ohmyposh
echo 'eval "$(oh-my-posh init zsh --config ~/.devenv/puppet.omp.json)' >> ~/.zshrc

#install fonts
font_source='https://github.com/microsoft/cascadia-code/releases/download/v2404.23/CascadiaCode-2404.23.zip' 
font_dest='~/.local/share/fonts/cascadia'
mkdir $font_dest
curl -LO $font_source 
unzip $(basename $font_source) -d $font_dest
fc-cache -f -v

dnf install neovim
dnf install nodejs
#maybe download from github
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/init.vim
cp my-init.lua ~/.config/nvim/my-init.lua
