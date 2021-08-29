{ buildHashiCorpPackage }:

{ name, version, dir, sha256 }@args:

buildHashiCorpPackage rec { inherit name version dir sha256; }
