open TreeRef

let splitTreeRef tree next_id list_node =
  let piece = Random.bool () in
  let new_leaf = ref Empty in
  let old_tree = !tree in
  let left, right =
    if piece then (ref old_tree, new_leaf) 
    else (new_leaf, ref old_tree)
  in
  tree := Node(left, right);
  list_node.(next_id) <- new_leaf

let rec algoRemyRef n next_id list_node =
  if n = 0 then ()
  else
    let idx = Random.int next_id in
    splitTreeRef list_node.(idx) next_id list_node;
    algoRemyRef (n - 1) (next_id + 1) list_node