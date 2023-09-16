(* LUT that stores the rightmost position of each character. when a mismatch
 * occurs, the table is used to determine shift *)
 let build_bad_char_table p m =
  let table = Array.make 256 (-1) in
  for i = 0 to m-1 do
    table.(Char.code p.[i]) <- i
  done;
  table

(* LUT that stores shift values for cases where part of the pattern has matched
 * correctly before the mismatch. *)
let build_good_suffix_table m =
  let suffixes = Array.make m 0 in
  let last_prefix_position = ref (m - 1) in

  for i = m - 2 downto 0 do
    if i > !last_prefix_position && suffixes.(i + m - 1 - !last_prefix_position) < i - !last_prefix_position then
      suffixes.(i) <- suffixes.(i + m - 1 - !last_prefix_position)
    else
      last_prefix_position := i;
  done;

  for i = 0 to m - 2 do
    suffixes.(i) <- m - 1 - i + !last_prefix_position;
  done;
  suffixes


(* we need to make some adjustments since the original algorithm
 * is 1-indexed but ocaml is 0-indexed *)
let boyer_moore p t =
  let n = String.length t in
  let m = String.length p in

  if m = 0 then
    (* pattern length is 0 so do nothing *)
    Some 0
  else
    let bad_char_table = build_bad_char_table p m in
    let good_suffix_table = build_good_suffix_table m in

    let rec search i =
      if i <= n - m then
        (* pattern index *)
        let j = ref (m-1) in
        while !j >= 0 && p.[!j] = t.[i + !j] do
          decr j
        done;

        if !j < 0 then
          (* we have a match. return the string index *)
          Some i
        else
          (* haven't found a match yet. shift depending on the max value
           * the two rules *)
          let bad_char_shift = max 1 (!j - bad_char_table.(Char.code t.[i + !j])) in
          let good_suffix_shift = good_suffix_table.(!j) in
          search (i + max bad_char_shift good_suffix_shift)
      else
        (* we've gone through the entire text. no match *)
        None
    in
    search 0