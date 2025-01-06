local M = {}

function M:peek(job)
	local cache = ya.file_cache(job)
	if not cache then
		return
	end

	if not self:preload(job) then
		return
	end

	local t = io.open(tostring(cache), "r")
	if t == nil then return 0 end
	local thumb = Url(t:read())
	t:close()

	ya.image_show(thumb, job.area)
	ya.preview_widgets(job, {})
end

function M:seek() end

function M:preload(job)
	local cache = ya.file_cache(job)
	if not cache or fs.cha(cache) then
		return 1
	end

	local output = Command("allmytoes")
		:args({ "-sxx", tostring(job.file.url) })
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	-- yazi 0.2.5
	local function check_output_v025()
		if output.status:success() then
			return true
		end
		return false
	end

	-- yazi 0.3
	local function check_output_v03()
		if output.status.success then
			return true
		end
		return false
	end

	if pcall(check_output_v03) then
	elseif pcall(check_output_v025) then
	else
		ya.err(
			"Could not obtain thumbnail for " .. tostring(job.file.url)
			.. ". allmytoes output: " .. tostring(output.stderr)
		)
		return 0
	end

	local thumb = string.gsub(tostring(output.stdout), "\n", "")
	return fs.write(cache, thumb) and 1 or 2
end

return M
