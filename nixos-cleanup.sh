#!/bin/bash
# Clean up NixOS system and Home-Manager

# Expire old generations for home-manager
home-manager expire-generations "-30 days"

# Collect garbage
sudo nix-collect-garbage -d

# Optional: Optimize the Nix store
sudo nix store optimise
