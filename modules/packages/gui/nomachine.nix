# NoMachine is pinned to the currently installed local store output.
# This avoids upstream hash churn and broken downloads.
{ pkgs, ... }:

let
  pinnedNomachineClient = pkgs.runCommandLocal "nomachine-client-pinned-9.5.7" { } ''
    ln -s /nix/store/84cw542i0pfx89qzx72cy08yahkriwfm-nomachine-client-9.5.7 "$out"
  '';
in
{
  home.packages = [
    pinnedNomachineClient
  ];
}
