{
  imports = [
    ./hardware-configuration.nix
    ./asahi.nix
    ./apple-silicon-support
  ];

  networking.hostName = "kiwi";

  home-manager.users.iso = {
    xdg.configFile."niri/config.kdl".source = ../../desktop/niri/config-chocolate.kdl;
  };
}
