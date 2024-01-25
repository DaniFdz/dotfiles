{ config, pkgs, ... }:

{
	programs.vscode = {
		enable = true;
		enableUpdateCheck = false;
		enableExtensionUpdateCheck = false;
		extensions = with pkgs.vscode-extensions; [
			# General
			enkia.tokyo-night
			pkief.material-icon-theme
			vscodevim.vim
			mechatroner.rainbow-csv
			ms-python.python
			eamodio.gitlens
			github.copilot
			github.copilot-chat
			ms-azuretools.vscode-docker
			arrterian.nix-env-selector
			astro-build.astro-vscode
			bradlc.vscode-tailwindcss
		];
		keybindings = [
			{
				"key" = "ctrl+j";
				"command" = "workbench.action.terminal.toggleTerminal";
				"when" = "terminal.active";
			}
			{
				"key" = "ctrl+j";
				"command" = "-workbench.action.togglePanel";
			}
			{
				"key" = "ctrl+oem_3";
				"command" = "-workbench.action.terminal.toggleTerminal";
				"when" = "terminal.active";
			}
			{
				"key" = "ctrl+oem_3";
				"command" = "workbench.action.togglePanel";
			}
		];
		userSettings = {
			"workbench.colorTheme" = "Tokyo Night";
			"editor.fontSize" = 12;
			"terminal.integrated.fontSize" = 11;
			"window.zoomLevel" = -1;
			"editor.fontFamily" = "FiraCode Nerd Font";
			"terminal.integrated.fontFamily" = "FiraCode Nerd Font";
			"editor.fontLigatures" = true;
			"editor.wordWrap" = "on";
			"workbench.sideBar.location" = "left";
			"terminal.integrated.defaultProfile.linux" = "zsh";
			"vim.useSystemClipboard" = true;
			"vim.handleKeys" = {
				"<C-w>" = false;
				"<C-c>" = false;
				"<C-v>" = false;
				"<C-x>" = false;
				"<C-j>" = false;
				"<C-a>" = false;
				"<C-z>" = false;
				"<C-y>" = false;
				"<C-f>" = false;
				"<C-k>" = false;
				"<C-t>" = false;
				"<C-i>" = false;
			};
		};
	};
}
