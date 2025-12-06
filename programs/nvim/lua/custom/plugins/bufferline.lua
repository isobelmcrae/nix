return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  lazy = false,
  opts = {
    options = {
      always_show_bufferline = false,
      separator_style = 'thin',
      diagnostics = 'nvim_lsp',
      offsets = {
        filetype = 'neo-tree',
        text = 'Neo-tree',
        highlight = 'Directory',
        text_align = 'left',
      },
    },
  },
}
