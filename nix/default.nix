{
  lib,
  stdenvNoCC,
  libsForQt5,
  version,
}:

stdenvNoCC.mkDerivation {
  pname = "catppuccin-sddm-corners";
  inherit version;

  src = lib.cleanSourceWith {
    filter = name: type: type != "regular" || !lib.hasSuffix ".nix" name;
    src = lib.cleanSource ../.;
  };

  dontConfigure = true;
  dontBuild = true;
  dontWrapQtApps = true;

  propagatedBuildInputs = with libsForQt5.qt5; [
    qtgraphicaleffects
    qtquickcontrols2
    qtsvg
  ];

  postFixup = ''
    mkdir -p $out/nix-support
    echo ${libsForQt5.qt5.qtgraphicaleffects}  >> $out/nix-support/propagated-user-env-packages
    echo ${libsForQt5.qt5.qtquickcontrols2}  >> $out/nix-support/propagated-user-env-packages
    echo ${libsForQt5.qt5.qtsvg}  >> $out/nix-support/propagated-user-env-packages
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/sddm/themes/"
    cp -r catppuccin/ "$out/share/sddm/themes/catppuccin-sddm-corners"

    runHook postInstall
  '';

  meta = {
    description = "Soothing pastel theme for SDDM based on corners theme";
    homepage = "https://github.com/khaneliman/sddm-catppuccin-corners";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ khaneliman ];
    platforms = lib.platforms.linux;
  };
}
