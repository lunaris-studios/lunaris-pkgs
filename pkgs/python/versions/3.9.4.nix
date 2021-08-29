{ name, version, sha256, dir
# <nixpkgs>
, callPackage }:

let {
	passthru = callPackage ../passthru.nix { 
		inherit dir;
	};
	build = callPackage ../builder.nix { };
}
in build { inherit name version sha256 dir; }
