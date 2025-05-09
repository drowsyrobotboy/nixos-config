# nixos-config
My NixOS configuration to generate a standard developer VM

Running rebuild using flake

```bash
sudo nixos-rebuild switch --flake .#robotboy-code
```

Running cleanup of old generations

```bash
sudo nix-collect-garbage -d
```
