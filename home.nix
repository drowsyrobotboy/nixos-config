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
    # 2x scaling for apps like terminal / alacritty. This needs to be invoked from configuration.nix
    home.file.".Xresources".text = "Xft.dpi: 192\n";

    # Alacritty Font Size
    home.file.".config/alacritty/alacritty.toml".text = ''
        [font]
          size = 14.0
        '';
}
