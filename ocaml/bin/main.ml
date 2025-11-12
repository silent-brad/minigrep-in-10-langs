(*
 * Minigrep in OCaml
 *)

open Printf

let read_lines (file_name : string) : string list =
  In_channel.with_open_text file_name In_channel.input_lines
;;

let contains (line : string) (sub: string) : bool =
  let re = Str.regexp_string sub
  in
    try ignore (Str.search_forward re line 0); true
    with Not_found -> false
;;

let () =
  let argc = Array.length Sys.argv in
  if argc != 3 then
    printf "Usage: minigrep <pattern> <file>\n"
  else
    let pattern = Sys.argv.(1) in
    let filename = Sys.argv.(2) in
    let full_lines = read_lines filename in
    let full_length = List.length full_lines in
    let rec loop lines =
      match lines with
      | [] -> ()
      | line :: lines ->
          if contains line pattern then
            printf "%d: %s\n" (full_length - (List.length lines) - 1) line;
          loop lines
    in
    loop full_lines
;;
