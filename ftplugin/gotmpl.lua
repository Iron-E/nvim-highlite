vim.api.nvim_create_autocmd('LspTokenUpdate', {
	buffer = 0,
	callback = vim.schedule_wrap(function(event)
		vim.lsp.semantic_tokens.stop(event.buf, event.data.client_id)
	end),
	group = vim.api.nvim_create_augroup('highlite-lsp', {clear = false})
})
