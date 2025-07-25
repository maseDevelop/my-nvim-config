-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
      pickers = {
        live_grep = {
          additional_args = { '--hidden' },
        },
        find_files = {
          hidden = true
        }
      },
    }

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    -- See `:help telescope.builtin`


    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      -- you can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>w/', function()
      require("telescope.builtin").grep_string({ search_dirs = { vim.fn.expand("%:p") } })
    end, { desc = 'Search for [W]ord in current buffer [/]' })

    vim.keymap.set('n', '<leader>ff', require('telescope.builtin').git_files, { desc = 'Search git [F][F]iles' })
    vim.keymap.set('n', '<leader>sf', function()
      require('telescope.builtin').find_files({ hidden = true, no_ignore = true })
    end, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('v', '<leader>sw', function()
      local function get_visual_selection()
        vim.cmd('noau normal! "vy"')
        local text = vim.fn.getreg("v")
        text = text:gsub("\n", ""):gsub("^%s+", ""):gsub("%s+$", "")
        return text
      end

      local selection = get_visual_selection()
      if selection ~= "" then
        require('telescope.builtin').live_grep({ default_text = selection })
      else
        print("No selection to grep")
      end
    end, { desc = '[S]earch current [W]ord in visual mode' })
    vim.keymap.set('n', '<leader>gg', require('telescope.builtin').live_grep, { desc = 'earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]eturn to previous picker values' })
    vim.keymap.set('n', '<leader>sp', require('telescope.builtin').pickers, { desc = '[S]earch previous [P]icker search values' })


    -- Git and telescope collab
    vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = 'Search/View [G]it [C]ommits' })
    vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = 'Search/View [G]it [S]tatus' })
    vim.keymap.set('n', '<leader>gz', require('telescope.builtin').git_stash,
      { desc = 'Search/View [G]it Stash Item[Z]' })
    vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches,
      { desc = 'Search/View [G]it [B]ranches' })
  end
}
