#[
  Minigrep in Nim (functional style)
]#

import std/os, std/strutils, std/strformat

type Line = tuple[index: int, line: string]

func get_matches(query: string, lines: seq[string], i: int = 0): seq[Line] =
  if i < lines.len():
    if lines[i].find(query) != -1:
      @[(index: i, line: lines[i])] & get_matches(query, lines, i + 1)
    else:
      get_matches(query, lines, i + 1)
  else:
    @[]

func print_match(match: Line): string =
  let (i, line) = match
  fmt"{i}: {line}"

func print_matches(matches: seq[Line], i: int = 0): seq[string] =
  if i < matches.len():
    print_match(matches[i]) & print_matches(matches, i + 1)
  else:
    @[]

proc grep(query: string, file: File): string =
  if file != nil:
    let lines = file.read_all().split_lines()
    let matches = get_matches(query, lines)
    file.close()
    if matches.len() != 0:
      print_matches(matches).join("\n")
    else:
      "No matches found"
  else:
    "File not found"

let
  query = param_str(1)
  filename = param_str(2)
if filename == "" and query == "":
  echo "Usage: minigrep <query> <filename>"
else:
  echo grep(query, open(filename, fm_read))
