open Projet_ouverture.TreeRef
open Projet_ouverture.RemyRefABR
open Projet_ouverture.TreeDot

let () =
  Random.self_init ();

  print_string "Entrez un nombre n : ";
  let n = read_int () in
  let list_empty = Array.init (n+1) (fun _ -> ref Empty) in
  let arbre = list_empty.(0) in
  algoRemyRefABR n 1 list_empty;
  export_tree_to_dot "arbre.dot" !(arbre);
  print_endline "Fichier arbre.dot généré !"

  (* Pour RemyRef :
      print_string "Entrez un nombre n : ";
      let n = read_int () in
      let list_node = Array.init (2 * n+1) (fun _ -> ref Empty) in
      algoRemyRef n 1 list_empty;
      export_tree_to_dot "arbre.dot" !(list_empty.(0));
      print_endline "Fichier arbre.dot généré !"
  *)