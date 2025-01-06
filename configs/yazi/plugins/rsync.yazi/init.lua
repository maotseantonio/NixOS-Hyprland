-- function borrowed from chmod.yazi plugin
local selected_or_hovered = ya.sync(function()
	local tab = cx.active
	local paths = {}

	-- count up selected files
	for _, url in pairs(tab.selected) do
		paths[#paths + 1] = tostring(url)
	end

	-- if no files are selected use the hovered file
	-- a tab has folders which have files which have urls
	if #paths == 0 and tab.current.hovered then
		-- lua so we are 1 indexed
		paths[1] = tostring(tab.current.hovered.url)
	end
	return paths
end)

return {
	entry = function(_, args)
		ya.manager_emit("escape", { visual = true })
		local remote_target = #args >= 1 and args[1] or nil

		local files = selected_or_hovered()
		if #files == 0 then
			return ya.notify { title = "Rsync", content = "No files selected", level = "warn", timeout = 3 }
		end

		local default_dest = ""
		if #files == 1 and remote_target ~= "" then
			local base_name = files[1]:match("([^/]+)$")
			default_dest = remote_target .. ":" .. base_name
			ya.err { default_dest = default_dest }
		end

		local dest, ok = ya.input {
			title = "Rsync - [user]@[remote]:<destination>",
			value = default_dest or nil,
			position = { "top-center", y = 3, w = 45 },
		}
		if ok ~= 1 then
			return
		end

		-- local cmd, err = Command("rsync"):args(files):arg(dest):stderr(Command.PIPED):output()
		local cmd, err = Command("rsync")
			:args({ "-ahP", "--no-motd" })
			:args(files)
			:arg(dest)
			:stdout(Command.PIPED)
			:stderr(Command.PIPED)
			:output()
		local stderr = cmd.stderr
		local stdout = cmd.stdout
		local return_code = cmd.status.code
		ya.err {
			stderr = stderr,
			stdout = stdout,
			err = err,
			res = cmd.status.success,
			return_code = return_code,
			default_dest = default_dest,
		}

		if return_code ~= 0 then
			ya.notify {
				title = "Rsync Plugin",
				content = string.format("stderr below, exit code %s\n\n%s", cmd.status.code, stderr),
				level = "error",
				timeout = 10,
			}
		else
			ya.notify {
				title = "Rsync Plugin",
				content = "Rsync Completed!",
				timeout = 3,
			}
		end
	end,
}
