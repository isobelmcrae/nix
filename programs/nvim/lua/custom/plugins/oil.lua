return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    win_options = {
      signcolumn = 'yes:2',
    },
    float = {
      padding = 5,
      max_width = 0,
      max_height = 0,
      border = 'rounded',
      win_options = {
        winblend = 0,
        signcolumn = 'yes:2',
      },
    },

    view_options = {
      show_hidden = true,
    },

    keymaps = {
      ['<CR>'] = 'actions.select',
    },

    -- enable extensions
    extensions = { 'oil-git-status' },
  },

  dependencies = {
    { 'echasnovski/mini.icons', opts = {} },
  },
  lazy = false,
}
