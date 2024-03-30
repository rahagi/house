prebuild:
	nix-shell ./shell/pywal.nix --command "wal -i wallpaper.jpg"

switch-blackbox:
	sudo nixos-rebuild switch --flake .#blackbox

switch-guinea-pig:
	sudo nixos-rebuild switch --flake .#guinea-pig
