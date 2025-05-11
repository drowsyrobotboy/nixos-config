{ config, pkgs, lib, ... }:

{
    home.stateVersion = "24.11";
    home.packages = [ pkgs.git ];

    # Enable numLock
    xsession.numlock.enable = true;

    # Use full path of git binary so that command not found issue doesn't arise
    home.activation.cloneRepo = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p "$HOME/Projects"
      if [ ! -d "$HOME/Projects/sinma" ]; then
        ${pkgs.git}/bin/git clone https://github.com/drowsyrobotboy/sinma.git "$HOME/Projects/sinma"
      fi
    '';
}
