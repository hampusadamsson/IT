local
open HashArray;
in
(* compress l
TYPE: char list -> int list
PRE: 
POST: Returnerar kodade chars i l. 
EXAMPLE: compress' ([#"a",#"b"]) = [97,98] *)
fun compress (input) =
    let
	val ordbok : int hash = hash 4048;
	val limit = 4048
	val n = ref 0;
	(* build n
	 TYPE: int -> unit
	 PRE:
	 POST:
	 SIDE-EFFECT: Uppdaterar hashtabellen ordbok med ASCII koderna från n till 255. *)
	fun build 255 = () | build i = ((fn x => update(ordbok,str(chr x),x)) i; build (i+1));
	(* compress' l
         TYPE: string list -> int list
	 PRE:
	 POST: Returnerar kodade chars i l. 
	 EXAMPLE: compress' ([#"a",#"b"]) = [97,98] *)
	fun compress' (p :: []) = 
	    if sub(ordbok,p) = NONE then
		(*(print("Kompression färdig! Det var 2st tecken som sista element \n");*)
		 (update(ordbok,p,!n);n:= !n+1;valOf(sub(ordbok,String.substring(p,0,size (p)-1)))::valOf(sub(ordbok,String.substring(p,size (p)-1,1)))::[])
	    else
		(*(print("Kompression färdig! 1 tecken som sista element\n");*)(valOf(sub(ordbok,p))::[])
	  | compress' (p::rest) =
	    if sub(ordbok,p) = NONE then
		if !n < limit then
		    ( update(ordbok,p,!n);n:= !n+1;valOf(sub(ordbok,String.substring(p,0,size (p)-1))) :: compress'(String.substring(p,size (p)-1,1)::rest))
		else
		    ( valOf(sub(ordbok,String.substring(p,0,size (p)-1))) :: compress'(String.substring(p,size (p)-1,1)::rest))
	    else
		compress'(p ^ (hd rest):: tl rest)
    in
	(*(print("- Påbörjar kompression, antal tecken " ^ Int.toString(length(input)) ^ ".\n");*)(n:=256;build 0;compress'(map str input))
    end 
end;
(*
fun compress2' ([],completeList) = 
  | compress2' (a::b::charList,pendingList,completeList)
    if sub(ordbok,str a) = NONE then
	(update(ordbok,str a,n);n:= !n+1;compress2'(a::b::charList))
    else
	if sub(ordbok, str a ^ str b) = NONE then
	    (*A finns men inte B, spara A^B, skriv ut A*)
	else
	    (*A^B finns, finns "AB"^charList?*)
;


fun compress2 () =
    let
	val ordbok : int hash = hash 4048;
	val n = ref 0;
	val limit = 4048;

	fun build 255 = () | build i = ((fn x => update(ordbok,str(chr x),x)) i; build (i+1));
    in
	(print("Påbörjar compress \n");n:=256;build 0;compress2'(charlist))
    end;
*)








local
    open Vector;
in    
(* decompress l
TYPE: int list * string vector * int * -> string
PRE : 
POST: Returnerar element ur l efter ziv-level dekompression.
*)
fun decompress (intlist) =
    let
	(* *)
	val vektor = tabulate(4049, (fn x => if x < 256 then str(chr(x)) else "NONE"));
	    (* decompress' l v n
	     TYPE: int list * string vector * int *string -> string
	     PRE : 
	     POST: Uppdaterar v med element ur l genom ziv-level dekompression.
	     *)
	fun decompress' (q :: x :: kodlista, vektor,n,k) =
	    let
		val qet = (sub(vektor,q));
		val exet = (sub(vektor,x));
		val count = if n>=4048 then 4048 else n+1;
	    in
		if exet = "NONE"  then
		    (
		     (*print("x matchar inte sparar" (* " ^ sub(update(vektor,n,qet ^ String.substring(qet,0,1)),n) ^ " "*) ^Int.toString(n)^ "\n");*)
		     decompress'(x::kodlista,update(vektor,count,qet ^ String.substring(qet,0,1)),count,k^qet)
		    )
		else 
		    (
		     (*print("x finns sparar sammansättningen: "(* ^ sub(update(vektor,n,qet^String.substring(exet,0,1)),n) ^ " "*) ^ Int.toString(n) ^ "\n");*)
		     decompress'(x::kodlista,update(vektor,count,qet ^ String.substring(exet,0,1)),count,k^qet)
		    )
	    end
	  | decompress'(q::[],vektor,n,k) =(* (print("Sista tecknet " ^ sub(vektor,q) ^ "\n");*)k^(sub(vektor,q))
    in
	(print("Påbörjar decompress \n");explode(decompress'(intlist,vektor,255,"")))
    end;
end;
(*
fun decompress2 (intlist) =
    let
	(* *)
	open Vector;
	val vektor = tabulate(4049, (fn x => if x < 256 then str(chr(x)) else "NONE"));
	(* decompress' l v n
	     TYPE: int list * string vector * int -> string
	     PRE : 
	     POST: Uppdaterar v med element ur l genom ziv-level dekompression.
	     *)
	fun decompress2' (q :: x :: kodlista, vektor,n,resultat) =
	    let
		val qet = (sub(vektor,q));
		val exet = (sub(vektor,x));
		val count = if n>=4048 then 4048 else n+1;
	    in
		if exet = "NONE"  then
		    (
		      print("x saknas " ^ qet ^" "(* " ^ sub(update(vektor,n,qet ^ String.substring(qet,0,1)),n) ^ " "*) ^Int.toString(n)^ "\n");
		     decompress2'(x::kodlista,update(vektor,n,qet ^ String.substring(qet,0,1)),count,explode(qet) @ [])
		    )
		else 
		    (
		     print("x finns " ^ qet ^" " ^" "(* ^ sub(update(vektor,n,qet^String.substring(exet,0,1)),n) ^ " "*) ^ Int.toString(n) ^ "\n");
		     decompress2'(x::kodlista,update(vektor,n,qet ^ String.substring(exet,0,1)),count,explode(qet) @ [])
		    )

	    end
	  | decompress2'(q::[],vektor,n,resultat) = (print("Sista tecknet " ^ sub(vektor,q) ^ "\n");explode(sub(vektor,q))@resultat)
    in
	(*(print("Påbörjar decompress \n");*) decompress2'(intlist,vektor,255,[])
    end
*)
val listtroll = [#"a",#"a",#"a",#"b",#"b",#"b",#"b",#"b",#"b",#"a",#"a",#"b",#"a",#"a",#"b",#"a"]
