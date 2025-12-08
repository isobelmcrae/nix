{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./programs/firefox.nix
    ./programs/nvim.nix
    ./programs/zed.nix
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

  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    themeFile = "rose-pine";
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

  services.dunst.enable = true;
  services.swayidle.enable = true;
  services.polkit-gnome.enable = true;

  home.packages = with pkgs; [
    # development
    uv
    lazygit

    # system tools
    wl-clipboard
    brightnessctl
    btop

    # niri/aesthetics
    swww
    gowall
    xwayland-satellite

    # other apps
    vesktop
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];

    config.common.default = [
      "wlr"
      "gtk"
    ];
  };

  # this is not very nix of me but idc
  xdg.configFile."niri/config.kdl".source = ./desktop/niri/config.kdl;
  xdg.configFile."fastfetch/config.jsonc".source = ./desktop/fastfetch/config.jsonc;
  xdg.configFile."waybar/".source = ./desktop/waybar;
  xdg.configFile."vesktop/themes/".source = ./desktop/vesktop/themes;

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
