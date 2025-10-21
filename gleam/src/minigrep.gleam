//// Minigrep in Gleam

import argv
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

fn to_iter(lst: List(String), i: Int) -> List(#(Int, String)) {
  case lst {
    [] -> []
    [x, ..xs] -> [#(i, x), ..to_iter(xs, i + 1)]
  }
}

fn grep(pattern: String, file: String) -> String {
  file
  |> string.split("\n")
  |> to_iter(0)
  |> list.filter(fn(res) { string.contains(res.1, pattern) })
  |> list.map(fn(res) { int.to_string(res.0) <> ": " <> res.1 })
  |> fn(lines: List(String)) -> String {
    case lines {
      [] -> "No matches found!"
      _ -> string.join(lines, "\n")
    }
  }
}

fn get_args(args: List(String)) -> Result(#(String, String), String) {
  case list.length(args) {
    3 -> {
      let grep_args = args |> list.drop(1)
      let pattern =
        grep_args |> list.first() |> result.unwrap("No pattern given!")
      let filename =
        grep_args |> list.last() |> result.unwrap("No filename given!")
      Ok(#(pattern, filename))
    }
    _ -> Error("Usage: minigrep <pattern> <filename>")
  }
}

pub fn main() {
  let #(pattern, filename) =
    argv.load().arguments
    |> get_args()
    |> result.unwrap(#("Could not get arguments!", ""))
  let file =
    filename
    |> simplifile.read()
    |> result.unwrap("Could not read file!")
  grep(pattern, file)
  |> io.println()
}
