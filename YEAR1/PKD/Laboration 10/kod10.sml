(* checkSubString(s,sub)
   TYPE: string*string->bool
   PRE: (inget)
   POST: true om sub �r en delstr�ng i s, false annars.
   EXAMPLE: checkSubString("En rad.","rad") = true
            checkSubString("En rad.","sida") = false
*)
(* VARIANT: size s *)
fun checkSubString(s,sub) = if size sub > size s then
                              false
                            else if String.substring(s,0,size sub) = sub then
                              true
                            else
                               checkSubString(String.substring(s,1,size s-1),sub);

(*  fgrep (f,s)
 TYPE: string*string -> unit
 PRE: f �r namnet p� en fil som kan l�sas
 POST: De rader i filen f som inneh�ller s. 
 EXAMPLE: fgrep("textfil.txt","rad") = ("En rad med text." "Sista raden.")
*)
  
fun fgrep (f,sub) =
    let
	(* fgrep' is
	   TYPE: inStream -> string list
	   POST: En lista av �terst�ende rader i is *)
	(* VARIANT: �terst�ende rader i is *)
	fun fgrep' is =
	    case inputLine is of
		NONE => (closeIn is)
	      | SOME line => if checkSubString (line,sub) = true then 
				 (print line; fgrep' is) 
			     else fgrep' is
    in
	fgrep' (openIn f)
    end;


(* bubbleSort (
TYPE:
PRE:
POST:
EXAMPLE:

fun bs (x1::x2::rest) = if !x1 < !x2 then bs(x1::bs(x2::rest))
			else bs(x2::bs(x1::rest));
*)



fun bs' (x,y) = let 
val a = Vector.sub(x,y)
val b = Vector.sub(x,y+1)
val c = !(Vector.sub(x,y+1))
in
 if !(Vector.sub(x,y)) < !(Vector.sub(x,y+1)) then 
		    if y = Vector.length x -2 then 
			() 
		    else bs'(x,y+1)
 		else 
			(b := !( a); a := c; bs'(x,0))
end;


fun bs x = bs' (x,0);

val a = Vector.fromList [ref 5,ref 6,ref 3,ref 1];

bs a;

a;