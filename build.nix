let
  rust_overlay = import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz");
  # Pin wasm-bindgen version
  nixpkgs = import (fetchTarball {
    name = "nixos-unstable-2021-11-09";
    url = "https://github.com/nixos/nixpkgs/archive/788119f78101a10b2c58de0690c23572ac348076.tar.gz";
  }){ overlays = [ rust_overlay ]; };
  rust_channel = nixpkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain;
in

with nixpkgs;

pkgs.mkShell {
  nativeBuildInputs = [
    binaryen
    (rust_channel.override { extensions = [ "cargo" "rustc" "rust-std" ];})
    wasm-bindgen-cli
  ];
}
