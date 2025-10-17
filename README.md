NOTE: Make sure to change hardware config and set boot to efi in virtual box!!!

NOTE: If running in a vm, make sure 3D acceleration is enabled in the vm settings, otherwise Niri wont work and will just show a black screen!


First, run:

nix-shell -p gh --command "gh auth login"

Then, run:

nix-shell -p git --command "git clone https://github.com/alex-kumpula/pinned-nix-configs.git ~/Documents"

Then, run:

nix-shell -p git --command "sudo nixos-rebuild switch --flake .#your-host-name-here"

Then, run:

nix-shell -p home-manager --command "home-manager switch --flake .#your-home-name-here"