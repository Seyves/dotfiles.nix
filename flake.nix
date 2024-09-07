{
    description = "A very basic flake";

    inputs = {
        zen-browser.url = "github:MarceColl/zen-browser-flake";
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.05";
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @ inputs: 
        let 
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            pkgs-unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
	    inherit (self) outputs;
            system = "x86_64-linux";
        in {
            nixosConfigurations = {
                myNixos = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs outputs; };
                    modules = [
                        ./nixos/configuration.nix
                    ];
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
                    modules = [
                        ./home-manager/home.nix
                    ];
                };
            };
        };
}
