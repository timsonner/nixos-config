{
  description = "Tim's NixOS configuration";

  nixConfig = {
    extra-substituters = [ "https://herdr.cachix.org" ];
    extra-trusted-public-keys = [
      "herdr.cachix.org-1:3nH7IStRsS0ASfdonA0DCRR2ZrSCeWitZ7Kwew0cR4I="
    ];
  };

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
