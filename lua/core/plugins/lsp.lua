return {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    config = function()
        -- [[ Configure LSP ]]
        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
            nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        end

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local bufnr = args.buf
                on_attach(_, bufnr)
            end,
        })


        -- Enable the following language servers
        local servers = {
            pylsp = {
                filetypes = { 'python' },
                configurationSources = { 'flake8' },
                plugins = {
                    pylint = { enabled = true },
                    flake8 = { maxLineLength = 100 },
                    pyflakes = { enabled = false },
                    pycodestyle = { enabled = false },
                    rope_completion = { enabled = true },
                },
            },
            terraformls = {},
            jdtls = {},
            ts_ls = {},
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        }

        require("mason-lspconfig").setup({
            automatic_enable = true,
            ensure_installed = servers,
        })
    end,

}
