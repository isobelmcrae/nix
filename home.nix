{ config, pkgs, ... }:
let
home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.iso = {
    home.username = "iso";
    home.homeDirectory = "/home/iso";

    programs.git = {
      enable = true;
      settings.user = {
        name = "isobelmcrae";
        email = "isobel@isobel.zip";
      };
    };

    programs.neovim.enable = true;
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting	 # disable greeting
        '';
    };

    programs.kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      themeFile = "rose-pine";
    };

    programs.ghostty.enable = true;
    programs.fuzzel.enable = true;
    programs.swaylock.enable = true;
    programs.waybar.enable = true;
    programs.firefox.enable = true;

    programs.fastfetch.enable = true;

    services.dunst.enable = true;
    services.swayidle.enable = true;
    services.polkit-gnome.enable = true;

    home.packages = with pkgs; [
	swww
        hyprshot
        vesktop
        xwayland-satellite
        uv
        lazygit
    ];

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
          pkgs.xdg-desktop-portal-gtk
      ];

      config.common.default = [ "wlr" "gtk" ];
    };


    xdg.configFile."niri/config.kdl".source = ./desktop/niri/config.kdl;
    xdg.configFile."fastfetch/config.jsonc".source = ./desktop/fastfetch/config.jsonc;
    xdg.configFile."waybar/".source = ./desktop/waybar;
    home.stateVersion = "25.11";
    programs.home-manager.enable = true;
  };
}
