{ niv ? import ../niv { } }:

with niv;

let
  util = { domain, name }:
    { ... }@args:
    nixpkgs.callPackage (./. + "/${domain}/${name}.nix") (args // { });
in rec {
  # <hashi-corp>
  buildHashiCorpPackage = util {
    domain = "hashi-corp";
    name = "build-hashi-corp-package";
  };

  # <file>
  packageFile = util {
    domain = "file";
    name = "package-file";
  };

  rootFile = util {
    domain = "file";
    name = "root-file";
  };
}
