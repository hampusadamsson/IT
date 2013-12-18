(* PROGRAMKONSTRUKTION OCH DATASTRUKTURER
   ASSIGNMENT 2
   F�rfattare: Philip �kerfeldt & Gabriel Jonsson
   Datum: 1 Februari 2013
   Inl�mning: 1
*)

(* REPRESENTATION CONVENTION: Rect(Left,Top,Right,Bottom)
Datatypen representeras av fyra stycken heltalsv�rden som �r koordinaterf�r rektangelns sidor. Rektangeln har Left som x-koordinat f�r v�nstra sidan, Top som y-koordinat f�r den �vre sidan, Right som x-koordinat f�r h�gra sidan och Bottom som y-koordinat f�r den undre sidan.  
   REPRESENTATION INVARIANT: Bottom < Top och Left < Right f�r alla rektanglar.
*)
datatype rectangle = Rect of int * int * int * int

(* REPRESENTATION CONVENTION: Datatypen kan representeras som ett tomt quadtr�d. Ett icketomt quadtr�d har f�ljande struktur Qt(Extent, Horizontal, Vertical, topLeft, topRight, bottomLeft, bottomRight). Extent representeras som Rect(left,top,right,bottom), och definierar ytan som quadtr�det t�cker. Horizontal �r en lista av rektanglar som korsas av den horisontella axeln ((top+bottom) / 2). Vertical �r en lista av alla rektanglar som korsas av den vertikala axeln,((left+right) / 2). 
topLeft �r ett subtr�d till det icke-tomma quadtr�det och representerar kvaranten h�st upp till v�nster. 
topRight �r ett subtr�d till det icke-tomma quadtr�det och representerar kvaranten h�st upp till h�ger.
bottomLeft �r ett subtr�d till det icke-tomma quadtr�det och representerar kvaranten l�ngst ner till v�nster.
bottomRight �r ett subtr�d till det icke-tomma quadtr�det och representerar kvaranten l�ngst ner till h�ger.
   REPRESENTATION INVARIANT: alla rektanglar �r korrekta.
*)
datatype quadTree = EmptyQuadTree |
	            Qt of rectangle * rectangle list * rectangle list * quadTree * quadTree * quadTree * quadTree

(* emptyQtree e
TYPE: rectrangle -> quadTree
PRE: none
POST: Ett tomt quadtr�d med ytan e.
EXAMPLE: emptyQtree (0,3,4,5) = Qt((0,3,4,5), [],[], EmptyQuadTree,EmptyQuadTree,EmptyQuadTree,EmptyQuadTree)
         emptyQtree (5,2,5,1) = Qt((5,2,5,1), [],[],EmptyQuadTree,EmptyQuadTree,EmptyQuadTree,EmptyQuadTree)
*)
(* TIME COMPLEXITY: Alltid Theta(1) *)

fun emptyQtree e = Qt(e, [],[],EmptyQuadTree,EmptyQuadTree,EmptyQuadTree,EmptyQuadTree);

(* insert (q, r)
TYPE: quadTree * rectangle -> quadTree
PRE: Alla punkter av r finns i quadtr�det q.
POST: Quadtr�det q med rektangeln r insatt p� r�tt plats.
EXAMPLE: insert (Qt(Rect(0,5,2,1),[],[],EmptyQuadTree,EmptyQuadTree,EmptyQuadTree,EmptyQuadTree), Rect(1,4,3,2)) = 
                 Qt(Rect (0, 5, 2, 1), [], [Rect (1, 4, 3, 2)], EmptyQuadTree,EmptyQuadTree, EmptyQuadTree, EmptyQuadTree)

         insert (Qt(Rect(0, 70, 60, 0),[],[],EmptyQuadTree, EmptyQuadTree, EmptyQuadTree, EmptyQuadTree), Rect(10,20,25,5)) = 
Qt(Rect (0, 70, 60, 0), [], [], EmptyQuadTree, EmptyQuadTree, Qt(Rect (0, 35, 30, 0), [], [Rect (10, 20, 25, 5)], EmptyQuadTree,EmptyQuadTree, EmptyQuadTree, EmptyQuadTree), EmptyQuadTree)
*)       	 
(* VARIANT: Depth q *)
(* TIME COMPLEXITY: Worst Case: Theta(n), n= djupet p� quadtr�det q *) 

fun insert (Qt(Extent as Rect(eLeft,eTop,eRight, eBottom),H, V, tL,tR, bL, bR), r as Rect(rLeft,rTop,rRight,rBottom))=
    let

        val VA = ((eLeft + eRight) div 2)
        val HA = ((eTop + eBottom) div 2)

    in

        if rLeft <= VA andalso rRight > VA then
            Qt(Extent, H, r::V, tL, tR, bL, bR)
        else if rBottom <= HA andalso rTop > HA then
            Qt(Extent, r::H,V, tL, tR, bL, bR)
        else if rRight<= VA andalso rBottom > HA then
             if tL = EmptyQuadTree then
                 Qt(Extent, H, V, insert(emptyQtree (Rect(eLeft, eTop, VA, HA)), r),tR, bL, bR)
             else
                 Qt(Extent, H, V, insert(tL, r), tR, bL, bR)
        else if rLeft > VA andalso rBottom > HA then
            if tR = EmptyQuadTree then
                Qt(Extent, H, V, tL, insert(emptyQtree (Rect(VA , eTop, eRight,HA)), r), bL, bR)
            else
                Qt(Extent, H, V, tL, insert(tR, r), bL, bR)
        else if rTop <= HA andalso rRight <= VA then
            if bL = EmptyQuadTree then
                Qt(Extent, H, V, tL, tR, insert(emptyQtree (Rect(eLeft, HA, VA,eBottom)), r), bR)
            else
                Qt(Extent, H, V, tL, tR, insert(bL, r), bR)
        else if bR = EmptyQuadTree then
                 Qt(Extent, H, V, tL, tR, bL, insert(emptyQtree (Rect(VA, HA,eRight, eBottom)),r))
            else
                 Qt(Extent, H, V, tL, tR, bL, insert(bR, r))

    end;


(* query' (l,x,y)
TYPE: rectangle list*int*int-> rectangle list
PRE: (none)
POST:  En lista med de rektanglar i l som har punkten (x,y) i sig.
EXAMPLE: query' ([Rect (10, 20, 25, 5), Rect(3,30,8,22)],15,10) = [Rect (10, 20, 25, 5)]
*)         
(* VARIANT: Lenght l *)
(* TIME COMPLEXITY: Worst Case: Theta(n), n= listans l�ngd*)

fun query' ([],x,y) = []
  | query' (Rect(l,t,r,b)::rest, x,y)=
    if x >= l andalso x < r andalso y >= b andalso y < t then
        Rect(l,t,r,b):: query'(rest,x,y)
    else
        query'(rest,x,y);


(* query (q, x, y)
TYPE: Quadtree *int*int -> Rectangle list
PRE: 
POST: Lista av rektanglarna med koordinaterna x och y fr�n quadtr�det q.
EXAMPLE: query (Qt(Rect(0, 70, 60, 0),[],[],EmptyQuadTree, EmptyQuadTree, EmptyQuadTree, EmptyQuadTree),15,10) = []

         query (Qt(Rect (0, 70, 60, 0),[],[],EmptyQuadTree, EmptyQuadTree, Qt(Rect (0, 35, 30, 0), [], [Rect (10, 20, 25, 5)], EmptyQuadTree,EmptyQuadTree, EmptyQuadTree, EmptyQuadTree), EmptyQuadTree),15,10)= [Rect (10, 20, 25, 5)]
*)         
(* VARIANT: Depth q *)
(* TIME COMPLEXITY: Worst Case:  *)
fun query (EmptyQuadTree, _,_) = []
  | query (Qt(Rect(eLeft,eTop,eRight,eBottom),H,V,tL,tR,bL,bR),x,y) =

    let

        val VA = ((eLeft + eRight) div 2)
        val HA = ((eTop + eBottom) div 2)

    in
        if x < VA andalso y >= HA then 
             query'(H,x,y)@ query'(V,x,y) @ query(tL,x,y)

        else if x >= VA andalso y >= HA then 
             query'(H,x,y)@ query'(V,x,y) @ query(tR,x,y)

        else if x < VA andalso y < HA then 
             query'(H,x,y)@ query'(V,x,y) @ query(bL,x,y)

        else query'(H,x,y)@ query'(V,x,y) @ query(bR,x,y)
    end;
     
