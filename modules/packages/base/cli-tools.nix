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
		mesa-demos
		vulkan-tools
		clinfo
		radeontop
		amdgpu_top
		rocmPackages.rocm-smi
		nvtopPackages.amd
		glmark2
		vkmark
		stress-ng
		pciutils
		usbutils
		lm_sensors
	];
}
