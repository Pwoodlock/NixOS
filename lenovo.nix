{ config, pkgs, ... }:

let
  # Define custom shell aliases for convenience
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
  };
in

{
  # Set basic user and system configuration
  home.username = "nixos-lenovo";
  home.homeDirectory = "/home/nixos-lenovo";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.05";

  # Define packages to be installed in the user environment
  home.packages = [
    pkgs.oh-my-posh
    pkgs.waveterm
    pkgs.microsoft-edge
    pkgs.ungoogled-chromium
    pkgs.lutris
    pkgs.nextcloud-client
    pkgs.nushell
    pkgs.starship
    pkgs.carapace
    pkgs.vscode
  ];

  # Manage dotfiles
  home.file = {
    # Link the Nushell configuration file
    ".config/nushell/config.nu".source = ./config.nu;
  };

  # Set session-wide environment variables (customize if needed)
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Configure shell programs and related settings
  programs = {
    # Bash shell with custom aliases
    bash = {
      enable = true;
      shellAliases = myAliases;
    };

    # Zsh shell with custom aliases
    zsh = {
      enable = true;
      shellAliases = myAliases;
    };

    # Git configuration with user details
    git = {
      enable = true;
      userName = "PWoodlock";
      userEmail = "patrick@devsec.ie";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    # Additional programs and their configurations
    yazi = { enable = true; };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    nushell = {
      enable = true;
      # The `config.nu` is managed via `home.file`, so no need to specify `configFile.source` here
      extraConfig = ''
        let carapace_completer = {|spans|
          carapace $spans.0 nushell $spans | from json
        }
        $env.config = {
          show_banner: false,
          completions: {
            case_sensitive: false
            quick: true
            partial: true
            algorithm: "fuzzy"
            external: {
              enable: true
              max_results: 100
              completer: $carapace_completer
            }
          }
        }
        $env.PATH = ($env.PATH | split row (char esep) | prepend /home/nixos-lenovo/.apps | append /usr/bin/env)
      '';
      shellAliases = {
        vi = "hx";
        vim = "hx";
        nano = "hx";
      };
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };

  # Configure services
  services.nextcloud-client = {
    startInBackground = true;
    enable = true;
  };

  # Enable Home Manager itself as a program
  programs.home-manager.enable = true;
}
