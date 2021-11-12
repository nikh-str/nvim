local M = {}

M.config = function()

  vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
      unstaged = "",
      staged = "S",
      unmerged = "",
      renamed = "➜",
      deleted = "",
      untracked = "U",
      ignored = "◌",
    },
    folder = {
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",
    },
  }
 end

local view = require "nvim-tree.view"

M.toggle_tree = function()
  if view.win_open() then
    require("nvim-tree").close()
    if package.loaded["bufferline.state"] then
      require("bufferline.state").set_offset(0)
    end
  else
    if package.loaded["bufferline.state"] then
      -- require'bufferline.state'.set_offset(31, 'File Explorer')
      require("bufferline.state").set_offset(31, "")
    end
    require("nvim-tree").find_file(true)
  end
end


-- local g = vim.g

-- g.nvim_tree_quit_on_open = 1
-- g.nvim_tree_indent_markers = 1
-- g.nvim_tree_highlight_opened_files = 1

-- g.nvim_tree_icons = {
--   default = '',
--   symlink = '',
--   git = {
--     unstaged = "✗",
--     staged = "✓",
--     unmerged = "",
--     renamed = "➜",
--     untracked = "★",
--     deleted = "",
--     ignored = "◌"
--     },
--   folder = {
--     arrow_open = "",
--     arrow_closed = "",
--     default = "",
--     open = "",
--     empty = "",
--     empty_open = "",
--     symlink = "",
--     symlink_open = "",
--     }
-- }

local tree_cb = require("nvim-tree.config").nvim_tree_callback
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings= {
        list= {
          { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
          { key = "h", cb = tree_cb "close_node" },
          { key = "v", cb = tree_cb "vsplit" },
    }
    }
  },
}
return M
