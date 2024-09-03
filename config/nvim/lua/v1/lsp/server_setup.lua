local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap('td', function()
    require('trouble').toggle('lsp_definitions')
  end, '[G]oto [D]efinition')

  nmap('tI', function()
    require('trouble').toggle('lsp_implementations')
  end, '[G]oto [I]mplementation')

  nmap('tr', function()
    require('trouble').toggle('lsp_references')
  end, '[G]oto [R]eferences')

  nmap('tD', function()
    require('trouble').toggle('lsp_type_definitions')
  end, 'Type [D]efinition')

  nmap('tQ', function()
    require('trouble').toggle('quickfix')
  end, '[T]oggle [Q]uickfix')

  nmap('twq', function()
    require('trouble').toggle('workspace_diagnostics')
  end, 'Open workspace diagnostics list')

  nmap('tq', function()
    require('trouble').toggle('diagnostics')
  end, 'Open document diagnostics list')

  nmap('<leader>q', require('trouble').toggle, '[T]rouble [Q]uit')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  vim.api.nvim_buf_create_user_command(bufnr, 'ToggleFormatOnSave', function(_)
    FormatOnSave = not FormatOnSave
    print('Format On Save: ' .. (FormatOnSave and 'On' or 'Off'))
  end, { desc = 'Toggle Format On Save On/Off' })

  vim.api.nvim_buf_create_user_command(bufnr, 'ListLinters', function(_)
    local linters = require('lint').get_running()
    if #linters == 0 then
      vim.print('󰦕')
      return
    end
    vim.print('󱉶 ' .. table.concat(linters, ', '))
  end, { desc = 'Lists running linters for current buffer' })
end

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
  ensure_installed = {
    'autotools_ls',
    'azure_pipelines_ls',
    'bashls',
    'bicep',
    'clangd',
    'csharp_ls',
    'cssls',
    'css_variables',
    'dockerls',
    -- 'harper_ls',
    'html',
    -- 'hyprls', -- disabled until mason supports it
    'jqls',
    'jsonls',
    'lua_ls',
    'marksman',
    -- 'neocmake',
    -- 'nil_ls', -- nix os (requires nix exec to be installed)
    'omnisharp',
    'pylsp',
    'tailwindcss',
    'taplo',
    'tsserver',
    'volar',
    'yamlls',
  },
})

mason_lspconfig.setup_handlers({
  function(server_name)
    local server_options = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    local server_config_path = 'v1/lsp/server_configurations/' .. server_name

    local require_ok, server_config = pcall(require, server_config_path)

    if require_ok then
      server_options = vim.tbl_deep_extend('force', server_options, server_config)
    end

    -- vim.print(server_name)
    -- if server_name == 'bashls' then
    --   vim.print('=====' .. server_name .. '=====')
    --   vim.print((require_ok and 'true' or 'false') .. ': ' .. server_config_path)
    --   vim.print(server_options)
    --   vim.print('===============================')
    -- end

    require('lspconfig')[server_name].setup(server_options)
  end,
})

require('mason-tool-installer').setup({

  -- a list of all tools you want to ensure are installed upon
  -- start
  ensure_installed = {
    'csharpier',
    'editorconfig-checker',
    'eslint_d',
    'gofumpt',
    'golangci-lint',
    'jsonlint',
    'luacheck',
    'misspell',
    'prettierd',
    'shellcheck',
    'shfmt',
    'sonarlint-language-server',
    'stylelint',
    'stylua',
    'systemdlint',
  },

  -- if set to true this will check each tool for updates. If updates
  -- are available the tool will be updated. This setting does not
  -- affect :MasonToolsUpdate or :MasonToolsInstall.
  -- Default: false
  auto_update = true,

  -- automatically install / update on startup. If set to false nothing
  -- will happen on startup. You can use :MasonToolsInstall or
  -- :MasonToolsUpdate to install tools and check for updates.
  -- Default: true
  run_on_start = true,

  -- set a delay (in ms) before the installation starts. This is only
  -- effective if run_on_start is set to true.
  -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
  -- Default: 0
  start_delay = 3000, -- 3 second delay

  -- Only attempt to install if 'debounce_hours' number of hours has
  -- elapsed since the last time Neovim was started. This stores a
  -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
  -- This is only relevant when you are using 'run_on_start'. It has no
  -- effect when running manually via ':MasonToolsInstall' etc....
  -- Default: nil
  debounce_hours = 5, -- at least 5 hours between attempts to install/update
})

for _, formatter in ipairs(require('conform').list_all_formatters()) do
  local config = require('conform').formatters[formatter.name]
  local config_path = 'v1/lsp/formatter_configurations/' .. formatter.name

  local require_ok, formatter_config = pcall(require, config_path)

  -- if true then
  --   vim.print('=====' .. formatter.name .. '=====')
  --   vim.print(config)
  --   vim.print((require_ok and 'true' or 'false') .. ': ' .. config_path)
  --   vim.print(formatter_config)
  --   vim.print('===============================')
  -- end

  if require_ok then
    if config ~= nil then
      ---@diagnostic disable-next-line: param-type-mismatch
      formatter_config = vim.tbl_deep_extend('force', config, formatter_config)
    end
    require('conform').formatters[formatter.name] = formatter_config
  end
end
