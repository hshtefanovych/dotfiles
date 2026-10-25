# Linux working environment setup files

### Installation

#### Download or clone this project

Download:
```
1. sudo apt update && sudo apt install -y wget
2. mkdir -p dotfiles
3. wget -qO- https://github.com/hshtefanovych/dotfiles/archive/refs/heads/main.tar.gz \
  | tar -xz -C ~/dotfiles --strip-components=1
4. cd ~/dotfiles
```

Clone:
```
1. sudo apt update && sudo apt install git
2. git clone https://github.com/hshtefanovych/dotfiles.git
3. cd dotfiles/
```

#### Find the script for the system to setup and run it:
```
./install-all-<system>.sh
```

### Testing

If you want to check if the installation script is working fine, you can test it by running a Docker container.
```
1. cd tests/<system you want to test>/
2. ./run-test.sh
```
Docker will build the image, run a container with the immediate and automatic installation twice (first time to run the script itself, second time to see if everything installed), and will stay hang in the container for the user to be able to manually test.

