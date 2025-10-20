-- Minigrep in Lua

local function is_subsequence_of(query, line)
	local i = 0
	while i < #query do
		if string.sub(line, i, (i + 1)) ~= string.sub(query, i, (i + 1)) then
			return false
		end
		i = i + 1
	end
	return true
end

local function get_matches(query, lines)
	local matches = {}
	local i = 0
	for line in lines do
		if is_subsequence_of(query, line) then
			table.insert(matches, { i, line })
		end
		i = i + 1
	end
	return matches
end

local function print_match(match)
	local i, line = unpack(match)
	print(i .. ": " .. line)
end

local function print_matches(matches)
	for _, match_elem in ipairs(matches) do
		print_match(match_elem)
	end
end

local function grep(query, filename)
	local file = io.open(filename, "r")
	if not file then
		print("File not found")
	else
		local lines = file:lines()
		local matches = get_matches(query, lines)
		file:close()
		if #matches ~= 0 then
			print_matches(matches)
		else
			print("No matches found")
		end
	end
end

local function minigrep(query, filename)
	if query ~= nil or filename ~= nil then
		return grep(query, filename)
	else
		return print("Usage: minigrep <query> <filename>")
	end
end

local args = { ... }
minigrep(args[1], args[2])
