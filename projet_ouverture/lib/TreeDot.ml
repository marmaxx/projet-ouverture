open TreeRef
open Printf

let counter = ref 0
let fresh_id () =
  let id = !counter in
  incr counter;
  id

let rec tree_to_dot oc tree =
  match tree with
  | Empty -> 
      let id = fresh_id () in
      fprintf oc "  node%d [label=\"Empty\"];\n" id;
      id
  | Node (l, r) ->
      let id = fresh_id () in
      fprintf oc "  node%d [label=\"Node\"];\n" id;
      let left_id = tree_to_dot oc !l in
      let right_id = tree_to_dot oc !r in
      fprintf oc "  node%d -> node%d;\n" id left_id;
      fprintf oc "  node%d -> node%d;\n" id right_id;
      id

let export_tree_to_dot filename tree =
  counter := 0;
  let oc = open_out filename in
  fprintf oc "digraph Tree {\n";
  fprintf oc "  node [shape=ellipse];\n";
  ignore (tree_to_dot oc tree);
  fprintf oc "}\n";
  close_out oc
