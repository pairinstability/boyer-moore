(* boyer-moore string search 
 * https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_string-search_algorithm
 *)

open Boyer_moore

let underline_match t p pos =
  let m = String.length p in
  let underline = String.make m '^' in
  Printf.printf "%s\n" t;
  Printf.printf "%*s%s\n" pos "" underline
;;

let () =
  if Array.length Sys.argv <> 3 then
    Printf.printf "Usage: %s <pattern> <text>\n" Sys.argv.(0)
  else
    let pattern = Sys.argv.(1) in
    let text = Sys.argv.(2) in
    match boyer_moore pattern text with
    | Some position ->
      Printf.printf "Pattern found at position %d\n" position;
      underline_match text pattern position
    | None ->
      Printf.printf "Pattern not found in the text\n"