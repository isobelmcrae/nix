{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ./programs/firefox.nix
    ./programs/nvim.nix
    ./programs/zed.nix
    ./programs/obsidian.nix
    ./services/dunst.nix
    inputs.nvf.homeManagerModules.default
  ];

  home.username = "iso";
  home.homeDirectory = "/home/iso";

  programs.git = {
    enable = true;
    settings.user = {
      name = "isobelmcrae";
      email = "isobel@isobel.zip";
    };
  };


  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting	 # disable greeting
    '';
  };

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "Rose Pine";
      font-size = 11;
    };
  };

  programs.fuzzel.enable = true;
  programs.swaylock.enable = true;
  programs.waybar.enable = true;

  programs.fastfetch.enable = true;
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  services.swayidle.enable = true;
  services.polkit-gnome.enable = true;
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };

  home.packages = with pkgs; [
    # development
    uv
    lazygit

    # system tools
    wl-clipboard
    brightnessctl
    btop

    # file manager & automounting
    xfce.thunar
    xfce.thunar-volman
    udisks

    # niri/aesthetics
    swww
    gowall
    xwayland-satellite

    # other apps
    vesktop
    keepassxc
    syncthing
    signal-desktop
    unzip
    
    # themes, cursors
    rose-pine-cursor

    apple-cursor
    nh

    typst
    zathura
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];

    config.common.default = [
      "wlr"
      "gtk"
    ];
  };

  # this is not very nix of me but idc
  xdg.configFile."fastfetch/config.jsonc".source = ./desktop/fastfetch/config.jsonc;
  xdg.configFile."waybar/".source = ./desktop/waybar;
  xdg.configFile."vesktop/themes/".source = ./desktop/vesktop/themes;

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
