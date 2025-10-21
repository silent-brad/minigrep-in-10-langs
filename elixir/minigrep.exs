# Minigrep in Elixir
# Run `elixir minigrep.exs <pattern> <file>`

args = System.argv()

if length(args) < 2 do
  IO.puts("Usage: minigrep-elixir <pattern> <file>")
  System.halt(1)
end

pattern = Enum.at(args, 0)
file = Enum.at(args, 1)

if !File.exists?(file) do
  IO.puts("File not found")
  System.halt(1)
end

File.stream!(file)
|> Stream.with_index()
|> Stream.filter(fn {line, _index} -> String.contains?(line, pattern) end)
|> Stream.map(fn {line, index} -> IO.puts("#{index}: #{line}") end)
|> Stream.run()
