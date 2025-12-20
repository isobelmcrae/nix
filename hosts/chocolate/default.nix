{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "chocolate";
  boot.kernelPackages = pkgs.linuxPackages_zen;
    
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    open = true;
  };
  
  # packages exclusive to chocolate
  home-manager.users.iso = {
    home.packages = with pkgs; [
      spotify # no arm build :(
    ];
    
    # pc config includes different monitor config
    xdg.configFile."niri/config.kdl".source = ../../desktop/niri/config-chocolate.kdl;
  };
}
