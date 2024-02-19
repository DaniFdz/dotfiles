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
      ms-python.black-formatter
      eamodio.gitlens
      github.copilot
      github.copilot-chat
      ms-azuretools.vscode-docker
      arrterian.nix-env-selector
      astro-build.astro-vscode
      bradlc.vscode-tailwindcss
      usernamehw.errorlens
      ms-vscode-remote.remote-ssh
      tamasfe.even-better-toml
      dbaeumer.vscode-eslint
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      vadimcn.vscode-lldb
      foxundermoon.shell-format
      gruntfuggly.todo-tree
      serayuzgur.crates
      skellock.just
      # miguelsolorio.min-theme
      # miguelsolorio.fluent-icons
      # miguelsolorio.symbols
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
      "workbench.colorTheme" = "Min Dark";
      "editor.fontSize" = 14;
      "terminal.integrated.fontSize" = 13;
      "window.zoomLevel" = 0;
      "editor.fontFamily" = "FiraCode Nerd Font";
      "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
      "editor.fontLigatures" = true;
      "editor.wordWrap" = "on";
      "workbench.sideBar.location" = "left";
      "workbench.productIconTheme" = "fluent-icons";
      "workbench.iconTheme" = "symbols";
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "vim.useSystemClipboard" = true;
      "symbols.hidesExplorerArrows" = true;
      "editor.formatOnSave" = false;
      "eslint.format.enable" = true;
      "todo-tree.regex.regex" = "(//|#|<!--|;|/\\*|^|^[ \\t]*(-|\\d+.))\\s*($TAGS)|todo!";
      "[typescript]" = {
        # "editor.defaultFormatter" = "vscode.typescript-language-features";
        "editor.defaultFormatter" = "dbaeumer.vscode-eslint";
      };
      "[typescriptreact]" = {
        # "editor.defaultFormatter" = "vscode.typescript-language-features";
        "editor.defaultFormatter" = "dbaeumer.vscode-eslint";
      };
      "[python]" = {
        "editor.defaultFormatter" = "ms-python.black-formatter";
      };
      "[rust]" = {
        "editor.defaultFormatter" = "rust-lang.rust-analyzer";
      };
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
        "<C-n>" = false;
        "<C-p>" = false;
      };
    };
  };
}
