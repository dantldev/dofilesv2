# Makefile for Docker build and run

# Define the Docker image name
IMAGE_NAME := new-computer-2

# Build rule
build:
	docker build . -t $(IMAGE_NAME)

# Run rule
run:
	docker run --rm -it $(IMAGE_NAME) bash

play:
	ansible-playbook --ask-vault-pass --ask-become-pass local.yml

# Default rule (optional)
.PHONY: all
all: build

# Declare all rules as phony
.PHONY: build run