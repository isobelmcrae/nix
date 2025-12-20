# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  flake-inputs,
 ...
}:

{
  imports = [
    flake-inputs.stylix.nixosModules.stylix
  ];

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking
  networking.networkmanager.enable = true;
  services.resolved.enable = true;

  # uv installs python binaries to ~/.local/bin
  environment.localBinInPath = true;
  environment.variables = {
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
  };

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    autoEnable = true;
    enable = true;
    cursor = {
      name = "BreezeX-RoséPine";
      package = pkgs.rose-pine-cursor;
    };
  };
  stylix.cursor.size = 24;

  # more stuff to get uv to work
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glibc
  ];
  programs.nix-ld.enableDynamicLoading = true;

  i18n.defaultLocale = "en_AU.UTF-8";
  time.timeZone = "Australia/Sydney";

  users.users.iso = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
    shell = pkgs.fish;
  };

  programs.niri.enable = true;
  programs.fish.enable = true;
  virtualisation.docker.enable = true;

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  services.mullvad-vpn.enable = true;

  environment.systemPackages = with pkgs; [
    openssl
    vim
    git
    wget
    gcc
    clang
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    atkinson-hyperlegible-next
  ];

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };

  nix.settings.auto-optimise-store = true;

  services.openssh.enable = true;
  system.stateVersion = "25.11";
}
