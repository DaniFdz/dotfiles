{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		texliveFull
	];
	programs.zathura = {
		enable = true;
		mappings = {
			"<Right>" = "navigate next";
			"<Left>" = "navigate previous";
			D = "toggle_page_mode";
			F = "toggle_fullscreen";
		};
		options = {
			default-fg = "#4c4f69";
			default-bg = "#eff1f5";
			completion-bg = "#ccd0da";
			completion-fg = "#4c4f69";
			completion-highlight-bg = "#575268";
			completion-highlight-fg = "#4c4f69";
			completion-group-bg = "#ccd0da";
			completion-group-fg = "#1e66f5";
			statusbar-fg = "#4c4f69";
			statusbar-bg = "#ccd0da";
			notification-bg = "#ccd0da";
			notification-fg = "#4c4f69";
			notification-error-bg = "#ccd0da";
			notification-error-fg = "#d20f39";
			notification-warning-bg = "#ccd0da";
			notification-warning-fg = "#fae3b0";
			inputbar-fg = "#4c4f69";
			inputbar-bg = "#ccd0da";
			recolor-lightcolor = "#eff1f5";
			recolor-darkcolor = "#4c4f69";
			index-fg = "#4c4f69";
			index-bg = "#eff1f5";
			index-active-fg = "#4c4f69";
			index-active-bg = "#ccd0da";
			render-loading-bg = "#eff1f5";
			render-loading-fg = "#4c4f69";
			highlight-color = "#575268";
			highlight-fg = "#ea76cb";
			highlight-active-color = "#ea76cb";
		};
	};
}
