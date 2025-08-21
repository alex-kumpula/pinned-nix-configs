NOTE: Make sure to change hardware config and set boot to efi in virtual box!!!


First, run:

nix-shell -p gh --command "gh auth login"

Then, run:

nix-shell -p git --command "git clone https://github.com/alex-kumpula/pinned-nix-configs.git ~/Documents"

Then:

sudo nixos-rebuild switch --flake .#mainHost