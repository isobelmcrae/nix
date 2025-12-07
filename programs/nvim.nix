{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        theme = {
          enable = true;
          name = "rose-pine";
          style = "main";
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
        # autcomplete.blink-cmp.enable = true;
        diagnostics.nvim-lint.enable = true;
        formatter.conform-nvim.enable = true;
        debugger.nvim-dap.enable = true;

        autopairs.nvim-autopairs.enable = true;
        utility.oil-nvim = {
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
        utility.motion.flash-nvim.enable = true;
        utility.snacks-nvim = {
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
        utility.images.img-clip.enable = true;
        utility.sleuth.enable = true;

        telescope.enable = true;
        statusline.lualine.enable = true;
        tabline.nvimBufferline = {
          enable = true;
          setupOpts.options.separator_style = "slant";
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
