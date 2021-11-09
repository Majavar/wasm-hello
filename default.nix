let
  pkgs = import <nixpkgs> {};

  # Pin wasm-bindgen version
  pinnedPkgs = import (fetchTarball {
    name = "nixos-unstable-2021-11-09";
    url = "https://github.com/nixos/nixpkgs/archive/788119f78101a10b2c58de0690c23572ac348076.tar.gz";
  }){};

in with pkgs; stdenv.mkDerivation rec {
  name = "wasm-hello";

  # Allow cargo to download crates.
  SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
  GIT_SSL_CAINFO = "/etc/ssl/certs/ca-bundle.crt";

  buildInputs = [
    binaryen
    git
    python3
    jetbrains.idea-community
    rustup
    pinnedPkgs.wasm-bindgen-cli
  ];
}

