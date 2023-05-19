vim.api.nvim_create_autocmd('LspTokenUpdate', {
	buffer = 0,
	callback = function(event)
		local bufnr = event.buf
		local token = event.data.token
		if token.type == 'operator' and token.modifiers.attribute
			and vim.api.nvim_buf_get_text(bufnr, token.line, token.start_col, token.line, token.end_col, {})[1] == ':'
		then
			vim.lsp.semantic_tokens.highlight_token(token, bufnr, event.data.client_id, '@punctuation.delimiter')
		end
	end,
	group = vim.api.nvim_create_augroup('highlite-lsp', {clear = false})
})
