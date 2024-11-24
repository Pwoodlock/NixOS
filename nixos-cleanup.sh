#!/bin/bash
sudo nix flake update
sudo nixos-rebuild switch --flake .#
home-manager switch --flake .#$USER

# Let's Clean up NixOS system and Home-Manager redundant packages and Garbage.

# Expire old generations for home-manager
home-manager expire-generations "-30 days"

# Collect garbage
sudo nix-collect-garbage -d

# Optional: Optimize the Nix store
sudo nix store optimise
