local
open HashArray;
in
(* compress l
TYPE: char list -> int list
PRE: alla tecken måste vara ACSII.
POST: Returnerar chars kodade i l.
EXAMPLE: compress ([#"a",#"b"]) = [97,98] 
TIME-COMPLEXITY: Worst case Theta (n). *)
fun compress (input) =
    let
	val ordbok : int hash = hash 4048;
	val limit = 4048
	val n = ref 0;
	(* build n
	 TYPE: int -> unit
	 PRE: n <= 255
	 POST: (none)
	 SIDE-EFFECT: Uppdaterar hashtabellen ordbok med ASCII koderna från n till 255. *)
	fun build 255 = () | build i = (update(ordbok,str(chr i),i); build (i+1));
	(* compress' l
         TYPE: string list -> int list
	 PRE: Första strängen i l måste vara ett enskilt ASCII-tecken.
              Alla ASCII-tecken är nycklar i ordbok som mappar till sin teckenkod.
              256 <= n.
	 POST: Returnerar kodade chars i l enligt ziv-lempel algoritmen från starttillståndet i ordbok.
	 SIDE-EFFECTS: Uppdaterar hashtabellen ordbok med ASCII koderna.
	 EXAMPLE: compress' (["a","ab"]) = [97,] *)
	(*VARIANT: |l|.
	 TIME-COMPLEXITY: Worst case Theta (n) *)
	fun compress' ([]) = []
	  | compress' (p :: []) = if sub(ordbok,p) = NONE then
		(update(ordbok,p,!n);n:= !n+1;valOf(sub(ordbok,String.substring(p,0,size (p)-1)))::valOf(sub(ordbok,String.substring(p,size (p)-1,1)))::[])
	    else
		(valOf(sub(ordbok,p))::[])
	  | compress' (p::rest) =
	    if sub(ordbok,p) = NONE then
		if !n < limit then
		    ( update(ordbok,p,!n);n:= !n+1;valOf(sub(ordbok,String.substring(p,0,size (p)-1))) :: compress'(String.substring(p,size (p)-1,1)::rest))
		else
		    ( valOf(sub(ordbok,String.substring(p,0,size (p)-1))) :: compress'(String.substring(p,size (p)-1,1)::rest))
	    else
		compress'(p ^ (hd rest):: tl rest)
    in
	(n:=256;build 0;compress'(map str input))
    end 
end;



local
    open Vector;
in    
(* decompress l
TYPE: int list -> string
PRE : Första heltalet n i l måste 0<= n <= 255. Det n:e elementet i l <= min(255+n,4048).
POST: Returnerar element ur l efter ziv-level dekompression.
EXAMPLE: decompress [97, 97, 98] = [#"a", #"a", #"b"];
TIME-COMPLEXITY: Theta (n)
*)
fun decompress ([]) = []
  | decompress (q::kodlista) =
    let
	(* *)
	val vektor = tabulate(4049,(fn x => if x < 256 then [chr(x)] else []));
	    (* decompress' q l v n k
	     TYPE: int *int list * string vector * int *string -> string
	     PRE : 
	     POST: Returnerar elementen ur l genom ziv-lempel avkomprimering, från ett starttillstånd där det första elemntet q är 
                   den föregående teckenkoden, v är ordboken och n är den första lediga kodpunkten i ordlistan ( om n>= 4049 är ordlistan full).
	     VARIANT: |l|
	     TIME-COMPLEXITY: Theta (n)
	     *)
	fun decompress' (q,x::kodlista, vektor,n,k) =
	    let
		val qet = (sub(vektor,q));
		val exet = (sub(vektor,x));
		val count = if n>=4048 then 4048 else n+1;
	    in
		if exet = []  then
		    (
		    decompress'(x,kodlista,update(vektor,count,qet @ List.take (qet,1)),count,rev(qet)@k)
		    )
		else 
		    (
		     decompress'(x,kodlista,update(vektor,count,qet @ List.take (exet,1)),count,rev(qet)@k)
		    )
	    end
	  | decompress'(q,[],vektor,n,k) = rev(sub(vektor,q))@k
    in
	rev(decompress'(q,kodlista,vektor,255,[]))
    end
end;
