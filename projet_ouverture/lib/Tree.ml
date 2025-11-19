type 'a tree =
  | Empty of 'a
  | Node of 'a * 'a tree * 'a tree

let empty = Empty 0

let getValue t =
  match t with
  | Empty a -> a
  | Node (v, _, _) -> v
