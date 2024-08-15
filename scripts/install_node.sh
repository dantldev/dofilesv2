# installs fnm (Fast Node Manager)
curl -fsSL https://fnm.vercel.app/install | bash

# activate fnm
source ~/.zshrc

# download and install Node.js
fnm use --install-if-missing 20

npm install -g yarn
npm install -g serve
