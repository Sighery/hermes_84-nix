{
  description = "v0.11.0 Hermes with bytecode version 84";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/c0c50dfcb70d48e5b79c4ae9f1aa9d339af860b4";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.default = pkgs.callPackage ./package.nix { };
    };
}
