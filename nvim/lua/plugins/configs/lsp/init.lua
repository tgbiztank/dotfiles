require("nvim-lsp-installer").setup({
	automatic_installation = true,
	ui = {
		check_outdated_servers_on_open = true,
		border = "none",
		icons = {
			server_installed = "◍",
			server_pending = "◍",
			server_uninstalled = "◍",
		},
		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
		},
	},
})
require("plugins.configs.lsp.cmp")
require("plugins.configs.lsp.null-ls")
