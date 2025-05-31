return {
  'nvim-lualine/lualine.nvim',
  requires = {'kyazdani42/nvim-web-devicons'},  -- Optional, for file icons
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto',  -- Automatic theme selection
        section_separators = {'', ''},
        component_separators = {'', ''},
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'},
      },
    }
  end
}
