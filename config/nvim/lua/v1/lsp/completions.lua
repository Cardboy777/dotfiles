-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup({})

local lspkind = require('lspkind')

local function forwardTab(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_locally_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end

local function backwardTab(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-k>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
    }),
    ['<C-.'] = cmp.mapping(forwardTab, { 'i', 's' }),
    ['<C-,>'] = cmp.mapping(backwardTab, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'minuet' },
    { name = 'copilot', group_index = 2 },
  },
  formatting = {
    expandable_indicator = true,
    fields = { 'kind', 'abbr', 'menu' },
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 80,
      ellipsis_char = '...',
    }),
  },
})

-- add Copilot symbol to copilot-cmp suggestions
require('lspkind').init({
  symbol_map = {
    Copilot = '',
  },
})
