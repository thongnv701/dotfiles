return {
	"AlexandrosAlexiou/kotlin.nvim",
	ft = { "kotlin" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local shim = vim.fn.exepath("kotlin-lsp")
		if shim ~= "" then
			vim.env.KOTLIN_LSP_DIR = vim.fn.fnamemodify(vim.fn.resolve(shim), ":h")
		end

		require("kotlin").setup({})
	end,
}
