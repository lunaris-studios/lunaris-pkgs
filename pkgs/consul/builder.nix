{ buildHashiCorpPackage }:

{ name, version, sha256, packageFile }@args:

buildHashiCorpPackage rec { inherit name version sha256; }
