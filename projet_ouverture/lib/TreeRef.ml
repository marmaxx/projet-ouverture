type 'a tree =
  | Empty
  | Node of 'a tree ref * 'a tree ref

let empty = Empty

(* Pretty printing d'un arbre binaire avec indentation *)
let rec print_tree_pretty ?(indent="") ?(max_depth=10) depth tree =
  if depth > max_depth then
    Printf.printf "%s...\n" indent
  else
    match tree with
    | Empty -> Printf.printf "%sEmpty\n" indent
    | Node (left, right) ->
        Printf.printf "%sNode\n" indent;
        Printf.printf "%s├─ left: " indent;
        print_tree_pretty ~indent:(indent ^ "│   ") ~max_depth (depth+1) !left;
        Printf.printf "%s└─ right: " indent;
        print_tree_pretty ~indent:(indent ^ "    ") ~max_depth (depth+1) !right
