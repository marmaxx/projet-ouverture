open TreeRef

(*Module contenant les différentes métriques utiles pour mesurer l'arbre*)
let rec size_internal t =
  match t with
  | Empty -> 0
  | Node (l, r) -> 1 + size_internal !l + size_internal !r

let rec height t =
  match t with
  | Empty -> 0
  | Node (l, r) -> 1 + max (height !l) (height !r)

let width t =
  match t with
  | Empty -> 0
  | Node _ ->
      let q = Queue.create () in
      Queue.push (t,0) q;
      let cur_depth = ref 0 in
      let cur_count = ref 0 in
      let max_w = ref 0 in
      while not (Queue.is_empty q) do
        let (node,d) = Queue.pop q in
        if d = !cur_depth then incr cur_count
        else (
          if !cur_count > !max_w then max_w := !cur_count;
          cur_depth := d;
          cur_count := 1
        );
        match node with
        | Empty -> ()
        | Node (l,r) -> Queue.push (!l,d+1) q; Queue.push (!r,d+1) q
      done;
      if !cur_count > !max_w then max_w := !cur_count;
      !max_w

let left_subtree_size t =
  match t with
  | Empty -> None
  | Node (l, _) -> Some (size_internal !l)

let avg_leaf_depth t =
  let sum = ref 0 in
  let cnt = ref 0 in
  let rec aux depth node =
    match node with
    | Empty -> sum := !sum + depth; incr cnt
    | Node (l,r) -> aux (depth+1) !l; aux (depth+1) !r
  in
  aux 0 t;
  if !cnt = 0 then 0. else (float_of_int !sum) /. (float_of_int !cnt)