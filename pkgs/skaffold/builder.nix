{ lib, buildGoModule, fetchFromGitHub, installShellFiles }:

{ name, version, dir, revision, sha256, vendorSha256 }@args:

buildGoModule rec {
  inherit name version dir revision sha256 vendorSha256;

  pname = name;
  rev = revision;

  src = fetchFromGitHub {
    owner = "GoogleContainerTools";
    repo = name;
    rev = "v${version}";
    sha256 = sha256;
  };

  subPackages = [ "cmd/skaffold" ];

  buildFlagsArray = let t = "github.com/GoogleContainerTools/skaffold/pkg/skaffold";
  in ''
    -ldflags=
      -s -w
      -X ${t}/version.version=v${version}
      -X ${t}/version.gitCommit=${src.rev}
      -X ${t}/version.buildDate=unknown
  '';

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installShellCompletion --cmd skaffold \
      --bash <($out/bin/skaffold completion bash) \
      --zsh <($out/bin/skaffold completion zsh)
  '';

  meta = with lib; {
    homepage = "https://skaffold.dev/";
    changelog =
      "https://github.com/GoogleContainerTools/skaffold/releases/tag/v${version}";
    description = "Easy and Repeatable Kubernetes Development";
    longDescription = ''
      Skaffold is a command line tool that facilitates continuous development for Kubernetes applications.
      You can iterate on your application source code locally then deploy to local or remote Kubernetes clusters.
      Skaffold handles the workflow for building, pushing and deploying your application.
      It also provides building blocks and describe customizations for a CI/CD pipeline.
    '';
    license = licenses.asl20;
    maintainers = with maintainers; [ vdemeester ];
  };
}
