open Tree 

let splitTree tree nb =  
  let piece = Random.int 2 in 
  if piece = 0 then Node (nb, tree, Empty (nb + 1))
  else Node (nb, Empty (nb + 1), tree)

let rec createTree tree nb r =
  let value = getValue tree in 
  if value = r then splitTree tree nb
  else 
    match tree with
    | Empty _ -> tree
    | Node (v, g, d) ->
        Node (v, createTree g nb r, createTree d nb r)

let rec algoRemy tree n i =
  if n = 0 then tree 
  else
    let value = Random.int i in
    algoRemy (createTree tree i value) (n - 1) (i+2)
