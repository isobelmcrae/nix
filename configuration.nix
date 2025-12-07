# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./apple-silicon-support
  ];

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # asahi quirks
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  boot.extraModprobeConfig = ''
    options hid_apple iso_layout=0
  '';
  boot.kernelParams = [ "apple_dcp.show_notch=1" ];

  # firefox crashes on asahi gpus with mesa >=25.3, temporary downgrade
  # https://github.com/nix-community/nixos-apple-silicon/issues/380
  hardware.graphics.package =
    assert pkgs.mesa.version >= "25.3.0";
    (import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/c5ae371f1a6a7fd27823bc500d9390b38c05fa55.tar.gz";
      sha256 = "sha256-4PqRErxfe+2toFJFgcRKZ0UI9NSIOJa+7RXVtBhy4KE=";
    }) { localSystem = pkgs.stdenv.hostPlatform; }).mesa;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking
  networking.hostName = "kiwi";
  networking.networkmanager.enable = true;

  # uv installs python binaries to ~/.local/bin
  environment.localBinInPath = true;
  environment.variables = {
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
  };

  # more stuff to get uv to work
  programs.nix-ld.enable = true;

  i18n.defaultLocale = "en_AU.UTF-8";
  time.timeZone = "Australia/Sydney";

  users.users.iso = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.fish;
  };

  programs.niri.enable = true;
  programs.fish.enable = true;

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
  ];

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.openssh.enable = true;
  system.stateVersion = "25.11";
}
