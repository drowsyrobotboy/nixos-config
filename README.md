# nixos-config
My NixOS configuration to generate a standard developer VM

# First time instructions

## Installation
- Give atleast 6GB RAM, 30GB Memory, 4 Cores of Processors to the VM. You can adjust this based on host
- Install from NixOS with Gnome
- Make sure you have swap with no hibernate in partitioning while installing
- Make sure you select no desktop during installation. This can be handled later

## First time VM login
- Login using TTY / Serial Console
- Open `/etc/nixos/configuration.nix` using nano as that comes with installation
- Enable `vim` and `ssh`
- `sudo nixos-rebuild switch`
- `reboot`

## Second Login
- Once the VM boots, connect using ssh
- Paste the `flake.nix`, `configurations.nix` and `home.nix` in the VM
- Then run rebuild with flake

# Running rebuild using flake

```bash
sudo nixos-rebuild switch --flake .#robotboy-code
```

# Running cleanup of old generations

```bash
sudo nix-collect-garbage -d
```
