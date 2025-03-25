{
  lib,
  stdenvNoCC,
  version,
  qt6,
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

  propagatedUserEnvPkgs = with qt6; [
    qt5compat
    qtwayland
    qtquick3d
    qtsvg
  ];

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
