{ config, pkgs, lib, ...}:

{
    
    config = lib.mkIf config.mySystem.shell.zsh {
        users.defaultUserShell = pkgs.zsh;
        programs.zsh = {
            enable = true;
            ohMyZsh = {
                enable = true;
            };
        };
    };
}