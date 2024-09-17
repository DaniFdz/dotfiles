local opts = {
  relative = 'editor',
  width = 100,
  height = 50,
  col = math.floor((vim.o.columns - 100) / 2),
  row = math.floor((vim.o.lines - 50) / 2),
  style = 'minimal',
  border = 'single'
}

-- the current package name stored as a global variable
local package_name = nil

local function file_exists(filename)
  local file = io.open(filename, "r")
  if file then
    file:close()
    return true
  else
    return false
  end
end

local function read_and_parse_json(filepath)
  local file = io.open(filepath, "r")
  if not file then
    error("Cannot open file: " .. filepath)
  end
  local content = file:read("*a")
  file:close()
  return vim.json.decode(content)
end

local function get_parent_directory(path)
  path = path:gsub("\\", "/")

  if path:sub(-1) == "/" then
    path = path:sub(1, -2)
  end

  local last_slash = path:match(".*/()")

  if last_slash then
    return path:sub(1, last_slash - 1)
  else
    return nil
  end
end

local function run_command_in_terminal(cmd)
  vim.cmd('new')
  vim.cmd('terminal ' .. cmd)
end

local function split_by_newline_including_empty(str)
  local lines = {}
  for line in string.gmatch(str, "([^\n]*)\n?") do
    table.insert(lines, line)
  end
  return lines
end

local function ends_with(str, ending)
  return ending == "" or string.sub(str, - #ending) == ending
end

local function runCommand(command)
  local handle = io.popen(command, 'r')
  local output = handle:read("*a")     
  handle:close()                       
  return output
end

local function parse_json_lines(jsonLines)
  local results = {}
  for _, line in ipairs(jsonLines) do
    if line ~= "" then
      local obj = vim.json.decode(line)
      table.insert(results, obj.name)
    end
  end
  return results
end

local function get_current_package_name()
  local current_file = vim.fn.expand("%:p")
  local parent_directory = get_parent_directory(current_file)
  local package_json = parent_directory .. "/package.json"
  while not file_exists(package_json) do
    parent_directory = get_parent_directory(parent_directory)
    if ends_with(parent_directory, "web-ui") then
      return nil
    end
    if not parent_directory then
      error("Cannot find package.json in the parent directories")
    end
    package_json = parent_directory .. "/package.json"
  end
  local package = read_and_parse_json(package_json)
  return package.name
end

local function get_packages()
  local result = runCommand("yarn workspaces list --json")
  result = split_by_newline_including_empty(result)
  return parse_json_lines(result)
end

local function get_and_install_packages()
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]

  if package_name == nil then
    print("Cannot find package.json in the parent directories")
    return
  end

  vim.api.nvim_win_close(0, true)
  run_command_in_terminal("yarn workspace " .. package_name .. " add " .. line_text)
end

-- added to global scope to be able to call it from the buffer keymap
_G.get_and_install_packages = get_and_install_packages

local function install_dd_package()
  -- Create buffer and window
  package_name = get_current_package_name()
  print("Package name: " .. package_name)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { 'Loading packages...' })
  local win = vim.api.nvim_open_win(buf, true, opts)

  local all_packages = get_packages()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, all_packages)

  -- Scrolling and closing key mappings
  vim.api.nvim_buf_set_keymap(buf, 'n', 'j', '<C-e>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'k', '<C-y>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '', {
    noremap = true,
    callback = function()
      vim.api.nvim_win_close(win, true)
    end
  })

  vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', ':lua _G.get_and_install_packages()<CR>',
    { noremap = true, silent = true })
end

local function insall_dd_global_package()
  local global_package
end

-- User commands
-- --------------------------
vim.api.nvim_create_user_command('InstallDDPackage', function()
  install_dd_package()
end, {})

vim.api.nvim_create_user_command('PrintCurrentPackage', function()
  print('Current package name: ' .. get_current_package_name())
end, {})

vim.api.nvim_create_user_command('CopyPackageName', function()
  local package_name = get_current_package_name()
  if package_name then
    vim.fn.setreg('+', package_name)
    print('Package name copied to the clipboard: ' .. package_name)
  else
    print('Cannot find package.json in the parent directories')
  end
end, {})


vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.unit.*" },

	callback = function(ev)
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<C-t>",
			[[<cmd>TermFileExecToggle yarn\ test:unit\ %file%\ --watch C-t<cr>]],
			{
				desc = "yarn test:unit file",
				noremap = true,
			}
		)
	end,
})
