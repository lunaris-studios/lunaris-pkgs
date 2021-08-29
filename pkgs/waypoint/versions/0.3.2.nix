{ name, version, dir
# <nixpkgs>
, callPackage, buildHashiCorpPackage }:

let build = callPackage ../builder.nix { inherit buildHashiCorpPackage; };
in build {
  inherit name version dir;

  sha256 = "1vkh6g0ipcz7pbhw10x456ad12fdj8xx3r0np59j36kymgy7xxqd";
}
