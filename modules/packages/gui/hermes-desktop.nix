# Hermes Agent desktop client, from the upstream flake.
#
# The package ships its own .desktop entry and icon, so installing it into
# home.packages is enough for it to appear in the application launcher — no
# hand-written xdg.desktopEntries block needed.
#
# The package is passed in through extraSpecialArgs as `hermesDesktop` so this
# module does not need to know the flake input's attribute path.
{ hermesDesktop, ... }:

{
  home.packages = [ hermesDesktop ];
}
