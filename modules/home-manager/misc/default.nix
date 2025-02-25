{lib, ...}: {
  options.wallpaper = lib.mkOption {
    type = lib.types.path;
    default = ./wallpaper/wallpaper.jpg;
    readOnly = true;
    description = "Path to default wallpaper";
  };
}
