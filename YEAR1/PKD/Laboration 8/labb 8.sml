(*fun mapl(f,[]) = []
| mapl(f,first::rest) = f first::mapl(f,rest);*)


(* sizeList(l)
TYPE: (string list) -> int list
PRE:
POST: L�ngden av varje str�ng i listan l som en lista.
EXAMPLE: sizeList ["En", "kul", "uppgift"] = [2, 3, 7]
*)
fun sizeList (l:string list) = map size l;  


(* concatish
TYPE:string list -> string
PRE:
POST: str�ngarna i listan l sammansatt till en enda str�ng.
EXAMPLE:
*)

fun concatish l = foldr (fn (x,y) => x^y) "" l;

                 (* PROBLEM 3*)
(*a. (se papper)

b. 
( bowman poole floydHAL
TYPE: ('a*'a ->'a) -> 'a list -> 'a
PRE: listan f�r ej vara tom 
POST:f(a1,...f(an-2,f(a-13,an))...) om floydHAL=[a1,a2,...,n]
( listan floydHALs element enligt operatorn poole integrerade med varandra.)
EXAMPLE: bowman(op *,[2.5,2.0,0.2]) = 1.0
*)

(* smallest (op, l)
TYPE: ('a * 'a -> bool) * 'a list -> 'a
PRE: listan f�r inte vara tom, op definierar en total ordning
POST: Det minsta elementet i listan l beroende, d�r x �r mindre �n y omm op(x,y)=true.
EXAMPLE:
smallest(Int.<, [1,~4,5]) = ~4
smallest(String.<, ["kal", "ada", "sture", "nisse"]) = "ada"
smallest(lessName, [("Bergkvist","Erik"),("Andersson","Arne"),("Bj�rklund","Henrik"),("Eriksson","Lars-Henrik"),("Andersson","Petra"),("Berg","Stina")]) = ("Andersson","Arne")
*)
fun smallest(less,first::rest) = foldr (fn (x,y) => if less(x,y) then
			                    x
			                  else
                                            y
			                     ) first rest;
  
