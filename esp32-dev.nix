{
  description = "ESP32 Development Environment with PlatformIO";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";  # You can later adjust this or make it variable-friendly
    in {
      devShells.${system} = nixpkgs.lib.mkShell {
        buildInputs = [
          nixpkgs.platformio
          nixpkgs.gcc
          nixpkgs.libstdcxx
          nixpkgs.unzip
          esptool
        ];
      };
    };
}
