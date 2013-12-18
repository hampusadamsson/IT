(* PROGRAMKONSTRUKTION OCH DATASTRUKTURER
   INL�MNINGSUPPGIFT 2 
   F�rtfarttare: Philip �kerfeldt & Richard Str�hle
   Datum:
   Inl�mning: 1
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
POST: Det tomma quadtr�det med ytan e 
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
