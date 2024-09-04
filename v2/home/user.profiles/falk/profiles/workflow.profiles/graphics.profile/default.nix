{...}:
{
   # TODO: Ideally I'd want the option to disable specific submodules...
   import = [
      ./blender.submodule.nix             (move into `3d-graphics.profile`?)
      ./krita.submodule.nix
      # TODO: libresprite (FOSS aseprite) (move into `pixel-art.profile`?)
      #       inkscape?                   (move into `vector-graphics.profile`?)
      #       davinci-resolve?            (move into `video-editing.profile`)
   ];
}
