return {
  -- Add nvim-lspconfig plugin
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      -- Define the highlight groups for LSP document highlight
      vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#3B4252", underline = true })
      vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#3B4252", underline = true })
      vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#434C5E", underline = true })


      -- Define on_attach function for document highlighting
      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentHighlightProvider then
          -- Create an autocmd group for document highlighting
          vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
          vim.api.nvim_clear_autocmds({ group = "lsp_document_highlight", buffer = bufnr })

          -- Highlight on CursorHold
          vim.api.nvim_create_autocmd("CursorHold", {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })

          -- Clear highlights on CursorMoved
          vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end

      lspconfig.intelephense.setup({
        on_attach = on_attach,
        settings = {
          intelephense = {
            files = {
              maxSize = 5000000, -- Increase file size limit if necessary
            },
          },
        },
      })

      lspconfig.lua_ls.setup({
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force',
            client.config.settings.Lua, {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME
                  -- Depending on the usage, you might want to add additional paths here.
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
              }
            })
        end,
        settings = {
          Lua = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
            }

          }
        }
      })

      -- TypeScript/JavaScript LSP setup
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          -- Optionally disable formatting if you use a different formatter (e.g., prettier)
          client.server_capabilities.documentFormattingProvider = false
        end,
      })

      -- local project_library_path = "C:/Users/Clement/AppData/Roaming/npm/@angular/language-server/"
      -- local cmd = { "ngserver", "--stdio", "--tsProbeLocations", project_library_path, "--ngProbeLocations",
      --   project_library_path }


      -- lspconfig.angularls.setup {
      --   cmd = cmd,
      --   on_new_config = function(new_config, new_root_dir)
      --     new_config.cmd = cmd
      --   end,
      -- }

      -- Optional: Customize diagnostic display settings
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        float = { border = "rounded" },
      })
    end,
  },
}
