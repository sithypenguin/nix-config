{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.ollama;
  ollamaPackage =
    if config.mySystem.desktop.nvidia then pkgs.ollama-cuda
    else if config.mySystem.desktop.amd then pkgs.ollama-rocm
    else pkgs.ollama;
in
{
  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      package = ollamaPackage;
      port = cfg.port;
      host = lib.mkDefault "127.0.0.1";
      openFirewall = false;
    };
  };
}