# ~/NixOS/modules/home-manager/features/tui/editor-neovim.nix
{
   pkgs,
   configs,
   inputs,
   ...
}:{
   
   # NOTE: Overlays are only necessary if adding plugins manually.
   #
   # nixpkgs = {
   #   overlays = [
   #     (final: prev: {
   #       vimPlugins = prev.vimPlugins // {
   #         own-onedark-nvim = prev.vimUtils.buildVimPlugin {
   #           name = "onedark";
   #           src = inputs.plugin-onedark;
   #         };
   #       };
   #     })
   #   ];
   # };
   
   
   
   myHomeManager.programs.neovim =
   let
      # Helper functions:
      strToLua  = s: "lua << EOF\n${s}\nEOF\n";
      fileToLua = f: "lua << EOF\n${builtins.readFile f}\nEOF\n";
   in
   {
      # TODO: `programs.neovim.runtime.**` stuff if needed.
      enable         = true;
      defaultEditor  = true;
      vimdiffAlias   = true;
      vimAlias       = true;
      viAlias        = true;
      
      extraLuaConfig = ''
         ${builtins.readFile ./config/options.lua}
      '';
      
      plugins = with pkgs.vimPlugins; [
         
         {
            plugin = nvim-lspconfig;
            config = fileToLua ./config/plugin/lsp.lua;
         }
         
         {
            plugin = comment-nvim;
            config = stringToLua "require(\"Comment\").setup()";
         }
         
         {
            plugin = gruvbox-nvim;
            config = "colorscheme gruvbox";
         }
         cmp_luasnip
         cmp-nvim-lsp
         
         {
            plugin = nvim-cmp;
            config = fileToLua ./config/plugin/cmp.lua;
         }
         
         {
            plugin = telescope-nvim;
            config = fileToLua ./config/plugin/telescope.lua;
         }
         telescope-fzf-native-nvim # TODO: Reconsider.
         
         neodev-nvim
         
         luasnip
         friendly-snippets
         
         lualine-nvim
         
         nvim-web-devicons
         
         vim-nix
         
         #coc-clangd (using Treesitter + Mason instead)
         
         {
            plugin = (nvim-treesitter.withPlugins ( p: [
               p.tree-sitter-cpp
               p.tree-sitter-c
               p.tree-sitter-rust
               p.tree-sitter-glsl
               p.tree-sitter-lua
               p.tree-sitter-python
               p.tree-sitter-bash
               p.tree-sitter-json
               p.tree-sitter-vim
               p.tree-sitter-nix
               p.tree-sitter-cmake
            ]));
            config = fileToLua ./config/plugin/treesitter.lua;
        }
         
         # TODO: cmp-tabnine?
         #       ...
      }; # end-of: `myHomeManager.programs.neovim.plugins`
      
      extraPackages = with pkgs; [
         # Clipboard:
         xclip        # X11
         wl-clipboard # Wayland
         
         # LSPs:
         luajitPackages.lua-lsp
         rnix-lsp
         neocmakelsp # alternatively `make-language-server`
         vim-language-server
         
         # TODO: clangd? coc-clang?
         #       missing LSPs...
         #       ...
      ];
      
      # configure = {
      #    customRC = ''
      #      " Your custom NeoVim configuration goes here!
      #    '';
      #    packages.myVimPackage = with pkgs.vimPlugins; {
      #      # Load on launch:
      #      start = [ fugitive ];
      #      
      #      # Manually load by calling `:packadd $plugin-name`:
      #      opt   = [];
      #    };
      # }
      
   }; # end-of: `myHomeManager.programs.neovim`
} # end-of: <module>

