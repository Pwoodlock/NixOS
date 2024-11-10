{ config, pkgs, ... }:

let
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
  };
in

{
  home.username = "nixos-lenovo";
  home.homeDirectory = "/home/nixos-lenovo";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.05";

  # Packages
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

  # Manage .config/nushell/config.nu using home.file
#  home.file = {
#    ".config/nushell/config.nu".source = ./config.nu;
#  };

  # Environment Variables
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Programs Configuration
  programs = {
    bash = {
      enable = true;
      shellAliases = myAliases;
    };

    zsh = {
      enable = true;
      shellAliases = myAliases;
    };

    git = {
      enable = true;
      userName = "PWoodlock";
      userEmail = "patrick@devsec.ie";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    yazi = { enable = true; };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    nushell = {
      enable = true;
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

  # Services
  services.nextcloud-client = {
    startInBackground = true;
    enable = true;
  };

  # Enable Home Manager
  programs.home-manager.enable = true;

}
