{ niv ? import ./niv { }, talismanpkgs ? import ./packages.nix { } }:

with niv;

nixpkgs.mkShell rec {
  name = "talismanpkgs";
  env = nixpkgs.buildEnv {
    name = name;
    paths = buildInputs;
  };
  buildInputs = [
    # <talismanpkgs>
    talismanpkgs.bazel
    # talismanpkgs.cargo
    talismanpkgs.consul
    # talismanpkgs.clippy
    talismanpkgs.go
    talismanpkgs.golangci-lint
    # talismanpkgs.google-cloud-sdk
    talismanpkgs.helm
    talismanpkgs.jq
    talismanpkgs.k9s
    # talismanpkgs.mirror
    # talismanpkgs.nodejs
    talismanpkgs.nomad
    # talismanpkgs.openjdk
    talismanpkgs.python
    # talismanpkgs.rustc
    talismanpkgs.skaffold
    talismanpkgs.waypoint
  ];
  shellHook = "unset GOPATH";
}
