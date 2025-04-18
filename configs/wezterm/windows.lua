local term = require("wezterm")

local M = {}

function M.options(config)
	local wsl_domains = term.default_wsl_domains()
	local ssh_domains = term.default_ssh_domains() -- Load SSH Domains from ~/.ssh/config

	local extra_ssh = {
		{
			name = "Master",
			remote_address = "192.168.110.100",
			username = "artifex",
		},
	}

	for _, domain in ipairs(extra_ssh) do
		table.insert(ssh_domains, domain)
	end

	config.ssh_domains = ssh_domains

	-- config.win32_system_backdrop = "Acrylic"
	-- config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" }
	config.default_prog = { "C:\\Users\\Administrator\\scoop\\apps\\git\\current\\bin\\bash.exe -li" }
	-- config.default_gui_startup_args = { "connect", "SSHMUX:192.168.110.182" }

	for _, domain in ipairs(wsl_domains) do
		domain.default_cwd = "~"
	end

	-- Using latest features
	config.prefer_egl = true

	config.launch_menu = {
		{
			label = " WSL cwd",
			args = { "wsl" },
		},
		-- { label = " Bash", args = { "C:/Program Files/Git/bin/bash.exe", "-li" } },
		{ label = " PowerShell", args = { "pwsh" } },
		{ label = " Nushell", args = { "nu" } },
		{ label = " Cmd", args = { "cmd" } },
		{
			label = " NeoVim Config",
			args = { "pwsh", "-NoExit", "-Command", "cd C:/Users/Administrator/AppData/Local/nvim && nvim" },
		},
		{
			label = " Dotfiles",
			args = { "pwsh", "-NoExit", "-Command", "cd C:/Users/Administrator/dotfiles && nvim" },
		},
	}
end

return M
