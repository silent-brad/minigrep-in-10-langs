#[
  Minigrep in Nim
]#

import std/os, std/strutils, std/strformat

type Line = tuple[index: int, line: string]

proc get_matches(query: string, lines: seq[string]): seq[Line] =
  var
    matches: seq[Line]
    i = 0
  for line in lines:
    if line.find(query) != -1:
      matches.add((index: i, line: line))
    i += 1
  return matches

proc print_match(match: Line) =
  let (i, line) = match
  echo fmt"{i}: {line}"

proc print_matches(matches: seq[Line]) =
  for match in matches:
    print_match(match)

proc grep(query: string, filename: string) =
  let file = open(filename, fmRead)
  if file != nil:
    let lines = file.read_all().split_lines()
    let matches = get_matches(query, lines)
    file.close()
    if matches.len() != 0:
      print_matches(matches)
    else:
      echo "No matches found"
  else:
    echo "File not found"

proc minigrep(query: string, filename: string) =
  if filename == "" and query == "":
    echo "Usage: minigrep <query> <filename>"
  else:
    grep(query, filename)

minigrep(param_str(1), param_str(2))
