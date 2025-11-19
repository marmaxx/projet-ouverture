type 'a tree =
  | Empty
  | Node of 'a tree ref * 'a tree ref

let empty = Empty