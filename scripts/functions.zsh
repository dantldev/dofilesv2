mkcd() {
  mkdir -p "$1" && cd "$1"
}

extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

bak() {
  cp "$1" "$1.bak"
}

# Find a file by name in the current directory
ff() {
  find . -type f -iname "*$1*"
}

# Show system information
sysinfo() {
  echo "OS: $(uname -s)"
  echo "Kernel: $(uname -r)"
  echo "Uptime: $(uptime -p)"
  echo "Shell: $SHELL"
  echo "CPU: $(lscpu | grep 'Model name' | cut -f 2 -d ":")"
  echo "Memory: $(free -h | awk '/^Mem:/ {print $2 " total, " $3 " used, " $4 " free"}')"
  echo "Disk: $(df -h / | awk '/\// {print $2 " total, " $3 " used, " $4 " free"}')"
}

# Update the system
update() {
  sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
}

# Weather information for a city
weather() {
  curl "wttr.in/$1"
}

# Show public IP address
myip() {
  curl -s http://ipecho.net/plain; echo
}

# Kill process occupying a specific port
killport() {
  if [ $# -eq 0 ]; then
    echo "Usage: killport <port_number>"
    return 1
  fi

  local port="$1"
  local pid=$(lsof -ti tcp:$port)

  if [ -z "$pid" ]; then
    echo "No process found using port $port"
    return 0
  fi

  echo "Killing process $pid using port $port"
  kill -9 $pid

  if [ $? -eq 0 ]; then
    echo "Successfully killed process on port $port"
  else
    echo "Failed to kill process on port $port"
  fi
}

uuid() {
  python3 -c "import uuid; print(uuid.uuid4())"
}

pyserve() {
  local port="${1:-8000}"
  python3 -m http.server "$port"
}
