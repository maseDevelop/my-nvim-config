return {
  "maseDevelop/nvim-easy-md-reader",
  ft = { "markdown" },
  config = function()
    require("easy-md-reader").setup({
      ratio = 0.4,     -- portion of word to bold (0-1)
      min_word_length = 4, -- skip words shorter than this
      viewer = "float", -- "float" or "split"
      float_opts = {
        width = 0.8,   -- percentage of screen
        height = 0.8,
        border = "rounded",
      },
    })
  end,
}
