(* PROGRAMKONSTRUKTION OCH DATASTRUKTURER
   INLÄMNINGSUPPGIFT 2
   Författare: Philip Åkerfeldt
   Datum:
   Inlämning: 1
*)

(* REPRESENTATION CONVENTION: Datatypen representeras av fyra stycken heltalsvärden som står för rektangelns sidor i ordningen (Left,Top, Right, Bottom).
   REPRESENTATION INVARIANT: bottom < top och left < right för alla rektanglar.
*)
datatype rectangle = Rect of int * int * int * int


(* REPRESENTATION CONVENTION: Datatypen representeras som ett tomt quadträd eller som ett quadträd där första värdet är en rektangel  två 
                              rektangellistor och sen fyra subträd som för det nordvästra -, nordöstra -, sydvästra - och sydöstra hörnet på quadträdet.    
   REPRESENTATION INVARIANT: ingen
*)
datatype quadTree = EmptyQuadTree |
Qt of rectangle * rectangle list * rectangle list * quadTree * quadTree * quadTree * quadTree


(* emptyQtree e
TYPE: rectrangle -> quadTree
PRE: none
POST: Ett tomt quadträd med ytan e.
EXAMPLE: emptyQtree (0,3,4,5) = Qt((0,3,4,5), [],[], EmptyQuadTree,EmptyQuadTree,EmptyQuadTree,EmptyQuadTree)
         emptyQtree (5,2,5,1) = Qt((5,2,5,1), [],[],EmptyQuadTree,EmptyQuadTree,EmptyQuadTree,EmptyQuadTree)
*)
fun emptyQtree e = Qt(e, [],[],EmptyQuadTree,EmptyQuadTree,EmptyQuadTree,EmptyQuadTree);

(* insert (q, r)
TYPE: quadTree * rectangle -> quadTree
PRE: Alla punkter av r finns i quadträdet q.
POST: Quadträdet q med rektangeln r insatt på rätt plats i quadträdet.
EXAMPLE:
VARIANT: Depth q
*)


fun insert (Qt(Extent as Rect(eLeft,eTop,eRight, eBottom),H, V, tL,tR, bL, bR), r as Rect(rLeft,rTop,rRight,rBottom))=
    let

        val VA = ((eLeft + eRight) div 2)
        val HA = ((eTop + eBottom) div 2)

    in

        if rLeft <= VA andalso rRight > VA then
            Qt(Extent, H, r::V, tL, tR, bL, bR)
        else if rBottom <= HA andalso rTop > HA then
            Qt(Extent, r::H,V, tL, tR, bL, bR)
        else if rRight < VA andalso rBottom > HA then
            if  tL = EmptyQuadTree then
                Qt(Extent, H, V, insert(emptyQtree (Rect(eLeft, eTop, VA, HA)), r),tR, bL, bR)
            else
                Qt(Extent, H, V, insert(tL, r), tR, bL, bR)
        else if rLeft > VA andalso rBottom > HA then
             if tR = EmptyQuadTree then
                 Qt(Extent, H, V, tL, insert(emptyQtree (Rect(VA , eTop, eRight,HA)), r), bL, bR)
             else
                 Qt(Extent, H, V, tL, insert(tR, r), bL, bR)
        else if rTop < HA andalso rRight < VA then
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
PRE:
POST:  En lista med de rektanglar i l som har punkten (x,y) i sig.
EXAMPLE:
VARIANT: Lenght l
*)
fun query' ([],x,y) = []
  | query' (Rect(l,t,r,b)::rest, x,y)=
    if x >= l andalso x < r andalso y >= b andalso y < t then
        Rect(l,t,r,b):: query'(rest,x,y)
    else
        query'(rest,x,y);


(* query (q, x, y)
TYPE: Quadtree *int*int -> Rectangle list
PRE:
POST: Lista av rektanglarna med koordinaterna x och y från quadträdet q.
EXAMPLE:
VARIANT:
*)
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
     
