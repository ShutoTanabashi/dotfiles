--[[ 
statusline settings
]]

local M = {}

local highlight = {
	StatusLineGit = "%#DiagnosticSignHint#",
	StatusLineLSP = "%#DiagnosticSignError#",
	StatusLineMod = "%#ToDo#",
}

-- Git information
local function get_githead(bufnr)
	local gh = vim.b[bufnr].gitsigns_head
	if gh ~= nil then
		return " " .. gh
	else
		return ""
	end
end
local function get_gitstatus(bufnr)
	local gs = vim.b[bufnr].gitsigns_status
	if gs ~= nil then
		return " " .. gs .. " "
	else
		return ""
	end
end
local function git_statusline(bufnr)
	return get_githead(bufnr) .. get_gitstatus(bufnr)
end

-- LSP diagnostics
local lsp_icon = {
	Error = "  ",
	Warn = "  ",
	Info = " 󰭤 ",
	Hint = " 󰛩 ",
}
local function lsp_diag(bufnr)
	local stl_lsp = {}
	for diag, icon in pairs(lsp_icon) do
		local cnt = vim.tbl_count(vim.diagnostic.get(bufnr, { severity = diag }))
		if cnt ~= 0 then
			stl_lsp[diag] = icon .. cnt .. " "
		else
			stl_lsp[diag] = ""
		end
	end
	return stl_lsp["Error"] .. stl_lsp["Warn"] .. stl_lsp["Info"] .. stl_lsp["Hint"]
end

function M.statusline()
	local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)
	local stl = {
		"%f %y%r%=%(%l,%c%) ",
		highlight.StatusLineGit,
		git_statusline(bufnr),
		highlight.StatusLineLSP,
		lsp_diag(bufnr),
		highlight.StatusLineMod,
		"%{&modified?' Modified ':''}",
	}
	return table.concat(stl)
end

return M
