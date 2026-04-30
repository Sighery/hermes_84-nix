# This seems to be the latest tag targeting Hermes bytecode 84:
# https://github.com/facebook/hermes/blob/v0.11.0/include/hermes/BCGen/HBC/BytecodeVersion.h

{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "hermes";
  version = "v0.11.0";
  name = "hermes";

  src = pkgs.fetchFromGitHub {
    owner = "facebook";
    repo = "hermes";
    rev = "v0.11.0";
    sha256 = "sha256-uEb+Kfx95OTXu5WdqOflGVvAqE08NQHxucwoEiRmTVo=";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    ninja
    python3
  ];

  buildInputs = with pkgs; [
    icu
    readline
    tzdata
  ];

  cmakeFlags = [
    "-DCMAKE_SKIP_BUILD_RPATH=ON"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    ls
    install -m 755 bin/hermes $out/bin
    install -m 755 bin/hermesc $out/bin
    install -m 755 bin/hdb $out/bin
    install -m 755 bin/hbcdump $out/bin
    install -m 755 bin/hvm $out/bin

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    homepage = "https://github.com/facebook/hermes";
    description = "A JavaScript engine optimized for running React Native";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
