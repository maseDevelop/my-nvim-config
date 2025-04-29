return {
  'scalameta/nvim-metals',
  dependencies = { 'nvim-lua/plenary.nvim' },
  ft = { 'scala', 'sbt', 'java' },
  config = function()
    local metals_config = require("metals").bare_config()

    metals_config.init_options.statusBarProvider = "on"

    metals_config.settings = {
      showImplicitArguments = true,
      showInferredType = true,
    }

    require("metals").initialize_or_attach(metals_config)
  end,
}
