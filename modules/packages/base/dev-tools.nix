{ config, pkgs, pkgs-unstable, ... }:
{
	home.packages = with pkgs; [
		direnv
		pkg-config
		dotnetCorePackages.sdk_10_0
		pkgs-unstable.open-webui
	];
}
