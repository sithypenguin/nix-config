{ config, lib, pkgs, ... }:

{
    config = lib.mkIf config.mySystem.development.nixLd {
        programs.nix-ld = {
            enable = true;
            # Common runtime libraries used by many prebuilt Linux binaries.
            libraries = with pkgs; [
                stdenv.cc.cc
                zlib
                openssl
                icu
                krb5
                libunwind
            ];
        };
    };
}
