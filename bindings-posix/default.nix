{ compiler    ? "ghc822Binary"
, doBenchmark ? false
, doTracing   ? false
, doStrict    ? false
, rev         ? "89c0e5b332f9aa0f6697bf94dd139d1be9956299"
, sha256      ? "fc244db5c3dcfa6643eb04ce8a2827f9b7d6a4554c5297d2f9ecb4d0aaa1f8b5"
, pkgs        ? import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    inherit sha256; }) {
    config.allowUnfree = true;
    config.allowBroken = false;
  }
, returnShellEnv ? pkgs.lib.inNixShell
, mkDerivation ? null
}:

let haskellPackages = pkgs.haskell.packages.${compiler};

in haskellPackages.developPackage {
  root = ./.;

  source-overrides = {
  };

  modifier = drv: pkgs.haskell.lib.overrideCabal drv (attrs: {
    inherit doBenchmark;
  });

  inherit returnShellEnv;
}