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
      environmentVariables = {
        OLLAMA_CONTEXT_LENGTH = "65536";
        OLLAMA_FLASH_ATTENTION = "1";
        OLLAMA_KV_CACHE_TYPE = "q8_0";
      };
    };
  };
}