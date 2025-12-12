{ pkgs, lib, ... }:
{
  # nvf is used to configure nvim
  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        theme = {
          enable = true;
          name = lib.mkForce "rose-pine";
          style = lib.mkForce "main";
        };
        
        lsp = {
          enable = true;
          trouble.enable = true;
        };

        languages = {
          enableTreesitter = true;

          # enables specific languages
          nix.enable = true;
          ts.enable = true;
          go.enable = true;
          bash.enable = true;
          python.enable = true;
          clang.enable = true;
          markdown.enable = true;
          typst.enable = true;
        };
        autocomplete.blink-cmp.enable = true;
        diagnostics.nvim-lint.enable = true;
        formatter.conform-nvim.enable = true;
        debugger.nvim-dap.enable = true;
        autopairs.nvim-autopairs.enable = true;

        utility = {
          oil-nvim = {
            enable = true;
            setupOpts = {
              win_options.signcolumn = "yes:2";
              float = {
                padding = 5;
                max_width = 0;
                max_height = 0;
                border = "rounded";
                win_options = {
                  winblend = 0;
                  signcolumn = "yes:2";
                };
              };
              view_options = {
                show_hidden = true;
              };
            };
          };

          snacks-nvim = {
            enable = true;
            setupOpts = {
              bufdelete.enabled = true;
              indent.enabled = true;
              scroll.enabled = true;
              statuscolumn.enabled = true;
              words.enabled = true;
              terminal.enabled = true;
            };
          };

          motion.flash-nvim.enable = true;
          images.img-clip.enable = true;
          sleuth.enable = true;
        };

        telescope.enable = true;
        clipboard.providers.wl-copy.enable = true;

        # visuals 
        statusline.lualine.enable = true;
        tabline.nvimBufferline = {
          enable = true;
          setupOpts.options = {
            separator_style = "slant";
            always_show_bufferline = false;
          };
        };
        visuals.indent-blankline.enable = true;
        git.gitsigns.enable = true;
        notes.todo-comments.enable = true;

        binds.whichKey.enable = true;

        extraPlugins = {
          cord = {
            package = pkgs.vimPlugins.cord-nvim;
            setup = "require('cord').setup {}";
          };
          oil-git = {
            package = pkgs.vimPlugins.oil-git-status-nvim;
            setup = "require('oil-git-status').setup {}";
            after = [ "oil" ];
          };
        };
      };
    };
  };
}
