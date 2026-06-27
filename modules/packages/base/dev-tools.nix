{ config, pkgs, pkgs-unstable, ... }:
{
	home.packages = with pkgs; [
		direnv
		pkg-config
		pkgs-unstable.open-webui
	];
}
