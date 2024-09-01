{ config, pkgs, inputs, ... }: {
    imports = [
        ./programs/tmux.nix
        ./programs/zsh.nix
        ./programs/nvim.nix
    ];

	home = {
		username = "seyves";
		homeDirectory = "/home/seyves";
		stateVersion = "23.11";
		# using standard nvim config, because doing it through nix is too complex
	};

	fonts.fontconfig.enable = true;
	nixpkgs.config.allowUnfree = true;
	home.packages = [
	    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        pkgs.roboto
        pkgs.inter
        pkgs.kde-rounded-corners
		pkgs.nodejs_20
        pkgs.zsh-powerlevel10k
        pkgs.fzf
		pkgs.nodePackages.pnpm
        pkgs.rsync
        pkgs.sshpass
        pkgs.go
        pkgs.telegram-desktop
        pkgs.slack
        pkgs.google-chrome
        pkgs.postman
        pkgs.cargo
        pkgs.expect
        # lsps
        pkgs.nodePackages.bash-language-server
        pkgs.nodePackages.typescript
        pkgs.nodePackages.typescript-language-server
        pkgs.nodePackages.vscode-langservers-extracted
        pkgs.nodePackages.vue-language-server
        pkgs.tailwindcss-language-server
        pkgs.jsonnet-language-server
        pkgs.lua-language-server
        pkgs.gopls
        pkgs.nil
        # formatters
        pkgs.nodePackages.sql-formatter
        pkgs.prettierd
        pkgs.eslint_d
	];

	programs.alacritty.enable = true;
	programs.alacritty.settings = {
		font = {
			normal = {
				family = "JetBrainsMono Nerd Font"; 
				style = "Regular";
			};
			size = 12;
		};

		window = {
			padding = {
				x = 10;
				y = 8;
			};
		};

		cursor = {
			style = {
				shape = "Block";
				blinking = "Always";
			};
			blink_interval = 500;
		};

		colors.primary = {
			background = "#282828";
			foreground = "#d3c6aa";
		};

		colors.normal = {
			black   = "#475258";
			red     = "#e67e80";
			green   = "#a7c080";
			yellow  = "#dbbc7f";
			blue    = "#7fbbb3";
			magenta = "#d699b6";
			cyan    = "#83c092";
			white   = "#d3c6aa";
		};

		colors.bright = {
			black   = "#475258";
			red     = "#e67e80";
			green   = "#a7c080";
			yellow  = "#dbbc7f";
			blue    = "#7fbbb3";
			magenta = "#d699b6";
			cyan    = "#83c092";
			white   = "#d3c6aa";
		};
	};
}
