open TreeRef

let splitTreeRefABRIter tree value nb_leaf list_empty =
  let gauche = ref Empty in
  let droit = ref Empty in
  tree := Node(gauche, droit);
  list_empty.(value) <- gauche;
  list_empty.(nb_leaf) <- droit 


let rec algoRefABRIter n nb_leaf list_empty =
  if n = 0 then ()
  else
    let value = Random.int nb_leaf in
    splitTreeRefABRIter list_empty.(value) value nb_leaf list_empty;
    algoRefABRIter (n-1) (nb_leaf+1) list_empty
  