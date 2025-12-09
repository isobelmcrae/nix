# asahi-specific configuration options

{ config, lib, pkgs, ... }:

{
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  boot.extraModprobeConfig = ''
    options hid_apple iso_layout=0
  '';
  boot.kernelParams = [ "apple_dcp.show_notch=1" ];

  # firefox crashes on asahi gpus with mesa >=24.3, temporary downgrade
  # https://github.com/nix-community/nixos-apple-silicon/issues/380
  hardware.graphics.package =
    assert pkgs.mesa.version >= "25.3.0";
    (import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/c5ae371f1a6a7fd27823bc500d9390b38c05fa55.tar.gz";
      sha256 = "sha256-4PqRErxfe+2toFJFgcRKZ0UI9NSIOJa+7RXVtBhy4KE=";
    }) { localSystem = pkgs.stdenv.hostPlatform; }).mesa;
}
