local function find_file(directory, name_pattern)
  local pfile = io.popen('ls -a "' .. directory .. '"')
  if pfile ~= nil then
    for filename in pfile:lines() do
      if filename:sub(1, #name_pattern) == name_pattern then
        return filename
      end
    end
    pfile:close()
  end
  return ''
end

local function find(list, pattern)
  for filename in list do
    if filename:sub(1, #pattern) == pattern then
      return filename
    end
  end
  return ''
end

local shellcheck_path = require('mason-registry').get_package('shellcheck'):get_install_path() .. '/shellcheck'

local shfmt_install_dir = require('mason-registry').get_package('shfmt'):get_install_path() .. '/'
local shfmt_path = shfmt_install_dir .. find_file(shfmt_install_dir, 'shfmt')

return {
  settings = {
    bashIde = {
      shellcheckPath = shellcheck_path,
      shfmt = {
        path = shfmt_path,
      },
    },
  },
}
