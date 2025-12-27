{ config, pkgs, pkgs-unstable, ... }:
{
	home.packages = with pkgs; [
		ncdu
		btop
		bmon
		duf
		isd
		s-tui
		vhs
		superfile
	];
}
