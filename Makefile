prebuild:
	./install-age-secret
	nix-shell ./shell/pywal.nix --command "wal -i wallpaper.jpg"

switch-blackbox:
	sudo nixos-rebuild switch --flake .#blackbox

switch-guinea-pig:
	sudo nixos-rebuild switch --flake .#guinea-pig

switch-x260:
	sudo nixos-rebuild switch --flake .#x260

diff:
	nix store diff-closures /run/*-system
