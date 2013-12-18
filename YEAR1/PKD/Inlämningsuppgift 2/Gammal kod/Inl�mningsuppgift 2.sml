(* PROGRAMKONSTRUKTION OCH DATASTRUKTURER
   INLÄMNINGSUPPGIFT 2 
   Förtfarttare: Philip Åkerfeldt & Richard Stråhle
   Datum:
   Inlämning: 1
*)


(* REPRESENTATION CONVENTION: 
   REPRESENTATION INVARIANT:
*)
datatype rectangle = Rect of int * int * int * int


(* REPRESENTATION CONVENTION: 
   REPRESENTATION INVARIANT:
*)
datatype quadTree = EmptyQuadTree |
Qt of rectangle * rectangle list * rectangle list *
quadTree * quadTree * quadTree * quadTree


*)

(* emptyQtree e
TYPE:
PRE:
POST: Det tomma quadträdet med ytan e 
EXAMPLE:
*)
Fun emptyQtree(e) = 

(* insert (q, r)
TYPE:
PRE:
POST:
EXAMPLE:
*)

(* query (q, x, y)
TYPE:
PRE:
POST:
EXAMPLE:
*)
