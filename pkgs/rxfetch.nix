{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gitUpdater,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "nerdfetch";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "maotseantonio";
    repo = "rxfetch";
    rev = "v${finalAttrs.version}";
    hash = "sha256-h1wZVPxn9wYSaCH+ibzdXXVnh00ha7jZLj3Am2cWSgM=";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/bin
      cp $src/rxfetch $out/bin
  '';

  passthru.updateScript = gitUpdater {
    rev-prefix = "v";
  };

  meta = with lib; {
    description = "custom system fetching tool writing in bash";
    homepage = "https://github.com/maotseantonio/rxfetch";
    maintainers = with maintainers; [ ByteSudoer ];
    license = licenses.mit;
    mainProgram = "rxfetch";
    platforms = platforms.unix;
  };
})
