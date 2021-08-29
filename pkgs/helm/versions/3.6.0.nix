{ name, version, sha256, vendorSha256, dir, packageFile
# <nixpkgs>
, callPackage }:

let build = callPackage ../builder.nix { };
in build { inherit name version sha256 vendorSha256 dir packageFile; }
