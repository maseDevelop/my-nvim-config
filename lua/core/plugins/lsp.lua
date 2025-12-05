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

        -- Setup capabilities
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Configure Mason-managed servers 
        vim.lsp.config("pylsp", {
            capabilities = capabilities,
            settings = {
                pylsp = {
                    plugins = {
                        -- Disable formatting/linting (handled by Ruff)
                        pylint = { enabled = false },
                        flake8 = { enabled = false },
                        pyflakes = { enabled = false },
                        pycodestyle = { enabled = false },
                        autopep8 = { enabled = false },
                        yapf = { enabled = false },
                        black = { enabled = false },
                        -- Keep LSP language features
                        rope_completion = { enabled = true },
                        jedi_completion = { enabled = true },
                        jedi_hover = { enabled = true },
                        jedi_references = { enabled = true },
                        jedi_signature_help = { enabled = true },
                        jedi_symbols = { enabled = true },
                    },
                },
            },
        })
        vim.lsp.enable("pylsp")

        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        })
        vim.lsp.enable("lua_ls")

        vim.lsp.config("terraformls", {
            capabilities = capabilities,
        })
        vim.lsp.enable("terraformls")

        vim.lsp.config("jdtls", {
            capabilities = capabilities,
        })
        vim.lsp.enable("jdtls")

        vim.lsp.config("ts_ls", {
            capabilities = capabilities,
        })
        vim.lsp.enable("ts_ls")

        -- Configure external (system-provided) servers, which need to be manually enabled
        vim.lsp.config("sourcekit", {
            capabilities = vim.tbl_deep_extend("force", capabilities, {
                workspace = {
                    didChangeWatchedFiles = {
                        dynamicRegistration = true,
                    },
                },
            }),
            cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
        })
        vim.lsp.enable("sourcekit")

    end,
}
