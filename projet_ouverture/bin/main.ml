open Projet_ouverture.TreeRef
open Projet_ouverture.RemyRef
open Projet_ouverture.TreeDot

let () =
  Random.self_init ();
  let n = 1000 in
  let list_node = Array.make (2 * n + 1) (ref Empty) in
  algoRemyRef n 1 list_node;
  export_tree_to_dot "arbre.dot" !(list_node.(0));
  print_endline "Fichier arbre.dot généré !"
