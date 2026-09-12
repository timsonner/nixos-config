{
  description = "Tim's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    herdr-nix.url = "github:herdrdev/herdr-nix";
  };

  outputs = { self, nixpkgs, herdr-nix }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit herdr-nix; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
