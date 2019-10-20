{ compiler ? "ghc864"

, rev      ? "89c0e5b332f9aa0f6697bf94dd139d1be9956299"
, sha256   ? "1k9ir858npyj000qb9s0s3q4vkvvah3n3kn6j8kzd17gj477xmp5"

, pkgs   ?
    import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
      inherit sha256; }) {
      config.allowUnfree = true;
      config.allowBroken = false;
    }

, returnShellEnv ? pkgs.lib.inNixShell
, mkDerivation   ? null
}:

pkgs.haskellPackages.developPackage {
  root = ./.;

  overrides = self: super: {
  };

  source-overrides = {
  };

  modifier = drv: pkgs.haskell.lib.addBuildDepends drv [
    pkgs.hdf5_1_8
  ];

  inherit returnShellEnv;
}
