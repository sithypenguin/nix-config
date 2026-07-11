# Network base tools (wired + diagnostics)
{ config, pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    dnsutils       # Provides `dig`
    nettools       # ifconfig, route, netstat
    tailscale      # Node agent for Tailscale, a mesh VPN built on WireGuard
  ];
}
