FROM ubuntu:focal

ARG TAGS
ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=dantldev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install necessary packages
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    git \
    build-essential \
    sudo \
    && apt-add-repository -y ppa:ansible/ansible \
    && apt-get update \
    && apt-get install -y ansible \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Set up password for the user
RUN echo "${USERNAME}:password" | chpasswd

# Set the working directory
WORKDIR /home/$USERNAME/ansible

# Copy your ansible files
COPY . .

# Change ownership of the working directory
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME/ansible

# Switch to the non-root user
USER $USERNAME

CMD ["bash"]
