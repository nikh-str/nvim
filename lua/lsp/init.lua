local M = {}

vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd("nnoremap <silent> ca :Lspsaga code_action<CR>")
vim.cmd("nnoremap <silent> K :Lspsaga hover_doc<CR>")
vim.cmd("nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>")
vim.cmd("nnoremap <silent> <leader>d <cmd>lua vim.diagnostic.open_float()<CR>")
vim.cmd("nnoremap <silent> <C-p> :Lspsaga diagnostic_jump_prev<CR>")
vim.cmd("nnoremap <silent> <C-n> :Lspsaga diagnostic_jump_next<CR>")
-- scroll down hover doc or scroll in definition preview
vim.cmd("nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
-- scroll up hover doc
vim.cmd("nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")

-- virtual_text = {}

-- virtual_text.show = true

local signs = { Error = " ", Warn = "", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local config = {
	-- disable virtual text
	virtual_text = false,
	-- show signs
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)

-- M.on_attach = function(client, bufnr)
-- 	if client.name == "tsserver" then
-- 		client.resolved_capabilities.document_formatting = false
-- 	end
-- 	lsp_keymaps(bufnr)
-- 	lsp_highlight_document(client)
-- end

-- local function documentHighlight(client, bufnr)
-- 	-- Set autocommands conditional on server_capabilities
-- 	if client.resolved_capabilities.document_highlight then
-- 		vim.api.nvim_exec(
-- 			[[
--       hi LspReferenceRead cterm=bold ctermbg=red guibg=#2E2828
--       hi LspReferenceText cterm=bold ctermbg=red guibg=#353030
--       hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
--       augroup lsp_document_highlight
--         autocmd! * <buffer>
--         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--       augroup END
--     ]],
-- 			false
-- 		)
-- 	end
-- end
-- local lsp_config = {}

-- -- function lsp_config.common_on_attach(client, bufnr)
-- -- 	documentHighlight(client, bufnr)
-- -- end

-- -- -- Use a loop to conveniently both setup defined servers
-- -- -- and map buffer local keybindings when the language server attaches
-- -- -- local servers = {"pyright", "tsserver"}
-- -- -- for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup {on_attach = on_attach} end
-- return lsp_config

return M
