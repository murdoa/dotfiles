{ pkgs, ... }:
let
  inherit (pkgs) lib;
  inherit (pkgs.tmuxPlugins) mkTmuxPlugin;
in
{
  home.packages = [
    pkgs.tmux
  ];

  programs.tmux = {
    enable = true;
    historyLimit = 100000;
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      {
        plugin = mkTmuxPlugin rec {
          pluginName = "catppuccin";
          version = "2.1.3";
          src = fetchFromGitHub {
            owner = "catppuccin";
            repo = "tmux";
            rev = "v${version}";
            hash = "sha256-EHinWa6Zbpumu+ciwcMo6JIIvYFfWWEKH1lwfyZUNTo=";
          };
          postInstall = ''
            sed -i -e 's|''${PLUGIN_DIR}/catppuccin-selected-theme.tmuxtheme|''${TMUX_TMPDIR}/catppuccin-selected-theme.tmuxtheme|g' $target/catppuccin.tmux
          '';
          meta = with lib; {
            homepage = "https://github.com/catppuccin/tmux";
            description = "Soothing pastel theme for Tmux!";
            license = licenses.mit;
            platforms = platforms.unix;
            maintainers = with maintainers; [ jnsgruk ];
          };
        };
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_tabs_enabled on
          set -g @catppuccin_date_time "%H:%M"
        '';
      }
    ];
    extraConfig = ''
      # The section below is greatly influenced by https://hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/
      # remap prefix from 'C-b' to 'C-a'
      # unbind C-b
      # set-option -g prefix C-a
      # bind-key C-a send-prefix

      # split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # bind CTRL+A,R to reload the tmux config
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf
      bind -n C-k clear-history

      # enable mouse control
      set -g mouse on

      # move the status bar to the top
      set-option -g status-position bottom

      # make sure that windows and panes start from 1 not 0
      set -g base-index 1
      setw -g pane-base-index 1
    '';
  };
}
