return {
  'mfussenegger/nvim-lint',
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = {
      python = { 'pylint' },
      lua = { 'selene' },
      rust = { 'cargo' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      vue = { 'eslint' },
      sh = { 'shellcheck' },
      go = { 'golangcilint' },
      -- ruby = {'rubocop'},
      -- vim = {'vint'},
      yaml = { 'yamllint' },
      json = { 'jsonlint' },
      html = { 'tidy' },
      css = { 'stylelint' },
      markdown = { 'markdownlint' },
      -- haskell = {'hlint'},
      -- php = {'phpcs'},
      -- java = {'checkstyle'},
      c_sharp = { 'omnisharp' },
      cpp = { 'cppcheck' },
      c = { 'cppcheck' },
      -- objc = {'cppcheck'},
      -- swift = {'swiftlint'},
      -- kotlin = {'ktlint'},
      -- scala = {'scalafmt'},
      -- julia = {'julialint'},
      fish = { 'fish' },
      dockerfile = { 'hadolint' },
      -- nix = {'nix-linter'},
      -- dart = {'dartanalyzer'},
      -- zig = {'zls'},
      -- elixir = {'mix'},
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end
}
