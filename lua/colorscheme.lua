-- define your colorscheme here
local colorscheme = 'monokai_pro'
vim.cmd([[
    augroup TransparentColours
    autocmd!
    autocmd ColorScheme * highlight normal ctermbg=NONE guiBG=NONE
    augroup end
]])

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end
