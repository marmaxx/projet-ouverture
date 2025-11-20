type 'a tree =
  | Empty of 'a
  | Node of 'a * 'a tree * 'a tree

let empty = Empty 0

let getValue t =
  match t with
  | Empty a -> a
  | Node (v, _, _) -> v

(* Affichage simple de l'arbre dans le terminal *)
let rec print_tree ?(prefix="") ?(is_left=true) tree =
match tree with
| Empty v ->
    Printf.printf "%s%sEmpty(%d)\n" prefix (if is_left then "├─ " else "└─ ") v
| Node (v, l, r) ->
    Printf.printf "%s%sNode(%d)\n" prefix (if is_left then "├─ " else "└─ ") v;
    let new_prefix = prefix ^ (if is_left then "│  " else "   ") in
    print_tree ~prefix:new_prefix ~is_left:true l;
    print_tree ~prefix:new_prefix ~is_left:false r
