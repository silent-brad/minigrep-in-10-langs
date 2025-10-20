-- Minigrep in Lua

local function get_matches(query, lines)
	local matches = {}
	local i = 0
	for line in lines do
		if string.find(line, query, 1, true) ~= nil then
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
