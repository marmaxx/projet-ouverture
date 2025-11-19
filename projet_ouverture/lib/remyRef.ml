open TreeRef

let splitTreeRef tree i list_node =
  let piece = Random.int 2 in
  let enfant = ref Empty in
  if piece = 0 then (
    tree := Node (tree, enfant);
    list_node.(i) <- tree;
    list_node.(i+1) <- enfant
  ) else (
    tree := Node (enfant, tree);
    list_node.(i) <- enfant;
    list_node.(i+1) <- tree
  )


let rec algoRemyRef n i list_node =
  if n = 0 then () 
  else (
    let value = Random.int i in
    splitTreeRef list_node.(value) i list_node;
    algoRemyRef (n - 1) (i+2) list_node
  )