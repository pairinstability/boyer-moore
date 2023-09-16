open Boyer_moore

let () =
  let result1 = boyer_moore "beef" "deadbeef" in
  assert (result1 = Some 4);
  Printf.printf "Test case 1 passed\n";

  let result2 = boyer_moore "dead" "deadbeef" in
  assert (result2 = Some 0);
  Printf.printf "Test case 2 passed\n";

  let result3 = boyer_moore "" "" in
  assert (result3 = Some 0);
  Printf.printf "Test case 3 passed\n";

  let result4 = boyer_moore "longpattern" "short" in
  assert (result4 = None);
  Printf.printf "Test case 4 passed\n";

  let result5 = boyer_moore "special" "This $pecial pattern has special characters!" in
  assert (result5 = Some 25);
  Printf.printf "Test case 5 passed\n";