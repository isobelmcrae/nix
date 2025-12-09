{
  imports = [
    ./hardware-configuration.nix
    ./asahi.nix
    ./apple-silicon-support
  ];

  networking.hostName = "kiwi";
}
