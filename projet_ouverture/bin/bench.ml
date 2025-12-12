open Unix
open Printf
open Projet_ouverture.TreeRef
open Projet_ouverture.BenchTree
open Projet_ouverture.RemyRef
open Projet_ouverture.RefABR

(* Module permettant de lancer des benchmarks sur les différentes implémentations d'arbres *)

(* Permet de mesurer le temps et les métriques pour un arbre généré *)
let time_and_metrics gen =
  let t0 = gettimeofday () in
  let tree = gen () in
  let dt = (gettimeofday () -. t0) *. 1000. in (* temps en ms *)
  let h = height tree in
  let w = width tree in
  let sz = size_internal tree in
  let lsz = match left_subtree_size tree with None -> -1 | Some x -> x in
  let ald = avg_leaf_depth tree in
  (dt,h,w,sz,lsz,ald,tree)

(* Écriture entête CSV pour faire des graphiques sus *)
let write_header oc =
  fprintf oc "algo,n,trial,time_ms,height,width,size,left_size,avg_leaf_depth\n"

(* On fait les essais... *)
let run_trials ~oc ~algo_name ~n ~trials ~gen =
  for t = 1 to trials do
    let (time_ms,h,w,sz,lsz,ald,_) = time_and_metrics gen in
    fprintf oc "%s,%d,%d,%.3f,%d,%d,%d,%d,%.3f\n"
      algo_name n t time_ms h w sz lsz ald;
    if t mod 100 = 0 then flush oc
  done;
  flush oc

(* Générateur algo de remy version ref *)
let gen_remy_ref n () =
  let list_node = Array.init (2*n+1) (fun _ -> ref Empty) in
  let root = list_node.(0) in  
  algoRemyRef n 1 list_node;
  !root

(* Générateur algo refABR itératif (1.2) *)
let gen_ref_abr n () =
  let list_empty = Array.init (n+1) (fun _ -> ref Empty) in
  let root = list_empty.(0) in
  algoRefABRIter n 1 list_empty;
  !root

(* Cuisine moi ce délicieux benchmark par pitié *)
let run_benchmark () =
  Random.self_init ();
  let oc = open_out "results.csv" in
  write_header oc;

  let sizes = [1000; 2000; 3000; 4000; 5000; 6000; 7000; 8000] in  (* mettez vos tailles ici les boss *)
  List.iter (fun n ->
    let trials = 10000 in
    printf "Running %d trials for RemyRef n=%d...\n%!" trials n;
    run_trials ~oc ~algo_name:"RemyRef" ~n ~trials ~gen:(fun () -> gen_remy_ref n ());
    printf "Running %d trials for RefABRIter n=%d...\n%!" trials n;
    run_trials ~oc ~algo_name:"RefABRIter" ~n ~trials ~gen:(fun () -> gen_ref_abr n ());
  ) sizes;

  close_out oc;
  print_endline "Benchmark finished. Results written to results.csv"

let () =
  run_benchmark ()