# Network base tools (wired + diagnostics)
{ config, pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    clinfo         # OpenCL device info
    dnsutils       # Provides `dig`
    nettools       # ifconfig, route, netstat
  ];
}
