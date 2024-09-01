{
    description = "A very basic flake";

    inputs = {
        zen-browser.url = "github:MarceColl/zen-browser-flake";
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
        home-manager.url = "github:nix-community/home-manager/release-24.05";
    };

    outputs = { self, nixpkgs, home-manager, zen-browser } @ inputs: 
        let 
	    inherit (self) outputs;
            system = "x86_64-linux";
        in {
            nixosConfigurations = {
                myNixos = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit system; inherit zen-browser; };
                    modules = [
                        ./nixos/configuration.nix
                    ];
                };
            };
            homeConfigurations = {
                "seyves@nixos" = home-manager.lib.homeManagerConfiguration {
                    pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
                    extraSpecialArgs = {inherit inputs outputs;};
                    modules = [
                        ./home-manager/home.nix
                    ];
                };
            };
            zen-browser = zen-browser;
        };
}
