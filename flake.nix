{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Add ags and build of it
    ags.url = "github:Aylur/ags";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      pkgs-unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
      inherit (self) outputs;
    in {
      nixosConfigurations = {
        myNixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs pkgs-unstable; };
          modules =
            [ ./nixos/configuration.nix home-manager.nixosModules.default ];
        };
      };
      homeConfigurations = {
        "seyves@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {
            inherit inputs;
            inherit outputs;
            inherit pkgs-unstable;
          };
          modules = [ ./home-manager/home.nix ];
        };
      };
    };
}
