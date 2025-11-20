# Arbre de Rémy en OCaml

Ce projet implémente **l’algorithme de Rémy** pour générer aléatoirement des **arbres binaires complets**. Chaque exécution génère un arbre aléatoire à `n` nœuds internes et exporte l’arbre au format **DOT** pour visualisation avec Graphviz.

---
![Arbre de Rémy](https://upload.wikimedia.org/wikipedia/commons/2/25/Remy_sequence_of_decorated_trees.png)  
*Source : Wikipédia — [Algorithme de Rémy](https://fr.wikipedia.org/wiki/Algorithme_de_R%C3%A9my)*

---

## 1️⃣ Prérequis

- OCaml (version recommandée ≥ 4.12)
- Dune : gestionnaire de projet OCaml
- Graphviz : pour générer des PDF ou SVG à partir du fichier `.dot`

### Installer Dune (si non installé)

opam install dune

---

## 2️⃣ Compiler et exécuter

Dans le répertoire du projet contenant le fichier `dune` :

dune exec ./bin/main.exe

### Exemple d’exécution

Entrez un nombre n : 1000
Fichier arbre.dot généré !

- Ici, `n = 1000` génère 1000 nœuds internes et 1001 feuilles, soit 2001 nœuds au total.
- Le fichier `arbre.dot` est créé dans le répertoire courant.

---

## 3️⃣ Visualiser l’arbre avec Graphviz

Comme l’arbre peut être très grand, il est recommandé d’utiliser un format **vectoriel** (PDF ou SVG) plutôt qu’un bitmap.

### Générer un PDF

dot -Tpdf arbre.dot -o arbre.pdf

### Générer un SVG

dot -Tsvg arbre.dot -o arbre.svg

- Ensuite, ouvrez le fichier avec votre lecteur PDF ou navigateur pour visualiser l’arbre.

---

## 4️⃣ Notes sur l’algorithme

- L’algorithme suit l’algorithme classique de Rémy : à chaque étape, il transforme une **feuille aléatoire** en **nœud interne** avec deux nouvelles feuilles.
- Le programme est optimisé pour réutiliser l’espace mémoire : la feuille choisie devient un nœud interne et n’est plus stockée dans la liste des feuilles vivantes.
- Le nombre total de nœuds générés = 2 * n + 1.

---

## 5️⃣ Exemple de visualisation ASCII (petit arbre)

Pour `n = 3` (3 nœuds internes), l’arbre pourrait ressembler à :

        •
       / \
      •   •
     / \  |
    •  •  •

- Chaque `•` représente un nœud interne ou une feuille.
- Pour des grands `n`, utilisez Graphviz pour visualiser correctement.

---

## 6️⃣ Résumé rapide pour l’utilisateur

1. Installer OCaml et Dune.
2. Compiler et exécuter avec `dune exec ./bin/main.exe`.
3. Entrer le nombre de nœuds souhaité (`n`).
4. Le programme crée `arbre.dot`.
5. Visualiser avec Graphviz :
   - PDF : dot -Tpdf arbre.dot -o arbre.pdf
   - SVG : dot -Tsvg arbre.dot -o arbre.svg

---

Astuce : pour des arbres très grands (n > 500), préférez PDF ou SVG pour que l’affichage ne plante pas.
