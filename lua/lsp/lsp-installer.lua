local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

lsp_installer.setup({
	-- Automatically install LSP servers configured by lspconfig
	automatic_installation = true,
})

local opts = {
	on_attach = require("lsp.handlers").on_attach,
	capabilities = require("lsp.handlers").capabilities,
}

local lsp_config_status_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_config_status_ok then
	return
end

lspconfig.bashls.setup(opts)

local clangd_opts = require("lsp.settings.clangd")
lspconfig.clangd.setup(vim.tbl_deep_extend("force", opts, clangd_opts))

lspconfig.cssls.setup(opts)
lspconfig.html.setup(opts)
lspconfig.jedi_language_server.setup(opts)
lspconfig.jsonls.setup(opts)
lspconfig.ltex.setup(opts)
lspconfig.prosemd_lsp.setup(opts)
lspconfig.pylsp.setup(opts)

local solargraph_opts = require('lsp.settings.solargraph')
lspconfig.solargraph.setup(vim.tbl_deep_extend('force', opts, solargraph_opts ))

lspconfig.sqlls.setup(opts)

local sumneko_opts = require("lsp.settings.sumneko_lua")
lspconfig.sumneko_lua.setup(vim.tbl_deep_extend("force", opts, sumneko_opts))

lspconfig.sqlls.setup(opts)
lspconfig.terraformls.setup(opts)
lspconfig.tsserver.setup(opts)
lspconfig.vimls.setup(opts)
