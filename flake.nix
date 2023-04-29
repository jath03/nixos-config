{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix.url = github:Mic92/sops-nix;
    devenv.url = "github:cachix/devenv/v0.5.1";
    hyprland.url = "github:hyperwm/Hyprland";
  };
  
  
  outputs = { self, nixpkgs, sops-nix, devenv, hyprland}:
    let 
        username = "jack";
        # Declare the system
        system = "x86_64-linux";
        # Use a system-specific version of Nixpkgs
        pkgs = import nixpkgs { inherit system; };
    in
    {
        nixosConfigurations.jack-desktop = nixpkgs.lib.nixosSystem {
            system = system;
            modules = [
              hyprland.nixosModules.default
              ./configuration.nix
              {programs.hyprland.enable = true;}
              sops-nix.nixosModules.sops
            ];
        };
    };
}