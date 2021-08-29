{ name, version, parent, sha256, dir
# <nixpkgs> 
, callPackage, buildPackages, stdenv, darwin, gcc8Stdenv }:

let
  build = callPackage ./builder.nix ({
    inherit (darwin.apple_sdk.frameworks) Security Foundation;
  } // stdenv.lib.optionalAttrs stdenv.isAarch64 {
    stdenv = gcc8Stdenv;
    buildPackages = buildPackages // { stdenv = gcc8Stdenv; };
  });
in build { inherit name version parent sha256 dir; }
