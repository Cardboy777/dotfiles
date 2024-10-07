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
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        css = { 'prettierd' },
        json = { 'prettierd' },
        vue = { 'prettierd' },
        html = { 'prettierd' },
        c_sharp = { 'csharpier' },
        -- c = { 'clang_format' },
        -- cpp = { 'clang_format' },
        go = { 'gofumpt' },
        markdown = { 'prettierd' },
      },
    })

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        if FormatOnSave then
          require('conform').format({ bufnr = args.buf, lsp_format = 'fallback' })
        end
      end,
    })
  end,
}
