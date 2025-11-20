open TreeRef

let splitTreeRefABR tree value nb_leaf list_empty =
  let gauche = ref Empty in
  let droit = ref Empty in
  tree := Node(gauche, droit);
  list_empty.(value) <- gauche;      (* remplacer la feuille tirée par gauche *)
  list_empty.(nb_leaf) <- droit       (* ajouter la droite à la fin *)


let rec algoRemyRefABR n nb_leaf list_empty =
  if n = 0 then ()
  else
    let value = Random.int nb_leaf in   (* tirage parmi toutes les feuilles existantes *)
    splitTreeRefABR list_empty.(value) value nb_leaf list_empty;
    algoRemyRefABR (n-1) (nb_leaf+1) list_empty
  