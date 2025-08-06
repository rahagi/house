prebuild:
	./install-age-secret
	nix-shell ./shell/pywal.nix --command "wal -i wallpaper.jpg"

switch-blackbox:
	sudo nixos-rebuild switch --flake .#blackbox --show-trace -L -v

switch-guinea-pig:
	sudo nixos-rebuild switch --flake .#guinea-pig --show-trace -L -v

switch-x260:
	sudo nixos-rebuild switch --flake .#x260 --show-trace -L -v

diff:
	nix store diff-closures /run/*-system
