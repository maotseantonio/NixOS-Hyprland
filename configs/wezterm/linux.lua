local term = require("wezterm")

local M = {}

function M.options(config)
	local ssh_domains = term.default_ssh_domains() -- Load SSH Domains from ~/.ssh/config

	local extra_ssh = {
		-- {
		-- 	name = "ArchX",
		-- 	remote_address = "192.168.110.182",
		-- 	username = "artifex",
		-- },
	}

	for _, domain in ipairs(extra_ssh) do
		table.insert(ssh_domains, domain)
	end

	term.unix_domains = {
		{
			name = "unix",
		},
		{
			name = "artifex",
		},
	}

	-- term.default_gui_startup_args = { "connect", "unix" }

	config.prefer_egl = true

	config.ssh_domains = ssh_domains

	-- config.default_prog = { "bash" }
	--
	config.launch_menu = {
		-- {
		-- 	label = " WSL cwd",
		-- 	args = { "wsl" },
		-- },
		-- -- { label = " Bash", args = { "C:/Program Files/Git/bin/bash.exe", "-li" } },
		-- { label = " PowerShell", args = { "pwsh" } },
		-- { label = " Nushell", args = { "nu" } },
		-- { label = " Cmd", args = { "cmd" } },
		-- {
		-- 	label = " NeoVim Config",
		-- 	args = { "cd ~/.dotfiles/nvim/ && nvim" },
		-- },
		-- {
		-- 	label = " Dotfiles",
		-- 	args = { "pwsh", "-NoExit", "-Command", "cd C:/Users/Administrator/dotfiles && nvim" },
		-- },
	}
end

return M
