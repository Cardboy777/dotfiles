FormatOnSave = true

return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform will run multiple formatters sequentially
        python = { 'isort', 'black' },
        -- Use a sub-list to run only the first available formatter
        javascript = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        css = { { 'prettierd', 'prettier' } },
        json = { { 'prettierd', 'prettier' } },
        vue = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
        c_sharp = { 'csharpier' },
        -- c = { 'clang_format' },
        -- cpp = { 'clang_format' },
        go = { 'gofumpt' },
      },
    })

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        if FormatOnSave then
          require('conform').format({ bufnr = args.buf, lsp_fallback = true })
        end
      end,
    })
  end,
}
