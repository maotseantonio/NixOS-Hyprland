{ lib
,buildNimPackage
, fetchFromGitHub
}:

buildNimPackage rec {
  pname = "nitch";
  version = "0.1.6";
  src = fetchFromGitHub {
    owner = "maotseantonio";
    repo = "nitch";
    rev = "v${version}";
    sha256 = "PZpS3rPiPm+IRZpFXR9mUMEyzc5z421FEChAB3r87gc=";
  };
  meta = with lib; {
    description = "Incredibly fast system fetch written in nim";
    homepage = "https://github.com/maotseantonio/nitch";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "nitch";
  };
}
