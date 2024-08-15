FROM ubuntu:latest

# Install basic tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    zsh \
    tmux \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/zsh testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the non-root user
USER testuser
WORKDIR /home/testuser

RUN git clone https://github.com/dantldev/dotfilesv2.git

COPY docker-entrypoint.sh /usr/local/bin/
RUN sudo chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/bin/zsh"]