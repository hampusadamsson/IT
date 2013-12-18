Totalt 64p (K)

Seri�st f�rs�k: +20

Tester: +30

Klarar alla testfall utom tv�, som testa huruvida compress/decompress kan hantera tomma str�ngar respektive tomma listor.

Kommentarer/stil: +5

- compress beh�ver inga bieffekter eftersom ordboken inte syns utanf�r compress.
- N�r ni skriver funktionen build definierar ni en anonym funktion i on�dan. Uttrycket (fn x => E[x]) i, d�r E �r ett �godtyckligt context, �r samma sak som E[i].
- Eftervillkoret till compress' m�ste referera till ordbok, f�rvillkoret m�ste referera till ordbok och n, och f�rvillkoret f�r compress' kommer inte alltid att forts�tta g�lla f�r rekursiva anrop.
- decompress beh�ver inte heller n�gra bieffekter av samma anledning. Dessutom uppdateras vektorn aldrig p� ett s�tt som alstras bieffekter: det �r funktionell uppdatering som g�rs p� vektorer, till skillnad fr�n imperativ uppdatering som i hashtabeller.
- varianten f�r decompress kan skrivas "|l|" helt enkelt, fast det �r decompress' och inte decompress som beh�ver en.
- f�rvillkoret till decompress r�cker inte riktigt. Vad h�nder t ex om vi k�r decompress([97,4000])?
- det �r v�ldigt ol�mpligt att tomma platser i er vektor i decompress inneh�ller str�ngen "NONE", eftersom "NONE" ocks� skulle kunna vara ett v�rde som en riktigt kod mappar till (t ex i komprimeringen av str�ngen "NOANONBNONENONE"), vilket leder till att ni stoppar fel koder i vektorn. Ta till exempel str�ngen "NOANONCNONENONEQEN". Om vi komprimerar den och sedan avkomprimerar den borde vi f� tillbaka samma str�ng, men vi tillbaka "NOANONCNONENONEQEE" ist�llet!
- Eftervillkoret till decompress' beskriver vad som h�nder och inte vad ni f�r tillbaka, eftersom ni talar om hur k anv�nds under rekursionen ist�llet f�r hur ursprungsv�rdet av k p�verkar det v�rde som slutligen returneras. Dessutom beh�ver ni f� med n och k i eftervillkoret + en hel dr�s f�rvillkor.

Analys: +9

Vector.tabulate(n,f) �r inte alltid linj�r med avseende p� n - om f(m) �r annat �n konstant med avseende p� m s� blir det kr�ngligare. Motsvarande g�ller s�klart f�r map ocks�.

"Alla ovan n�mnda funktioner som g�r i konstant tid" - men ni kom ju fram till att vissa av funktionerna tar mer �n konstant tid? o_O

Vad jag kan se st�mmer det �nd� att ni kan anta att de tar konstant tid i just erat fall, men det b�r is�fall motiveras tydligt varf�r. S�rskilt med tanke p� hacket d�r l�ngden p� listans f�rsta element v�xer f�r vissa rekursiva anrop - i och med det borde man v�l kunna t�nka sig att f�rsta elementet inneh�ller t ex h�ften av ursprungslistan, s� att tiden f�r era str�ngkonkateneringar blir linj�ra? Varf�r slipper ni undan s�nt?

Rekursionen f�r decompress' st�mmer inte riktigt med hur funktionen g�r (l�ngden p� str�ngen k, och s�ledes kostnaden f�r str�ngkonkateneringen, �r omv�nt proportionell mot n ist�llet f�r att alltid vara lika med n), men �r en ok modell �nd�.

Hursomhelst, rekursionen ni st�ller upp blir kvadratisk, inte linj�r, mot m.

Dispositionen �r dessutom lite bakv�nd: det ni skrivit i slutsatsen om vad worst case �r borde snarare vara utg�ngspunkten f�r analysen �n resultatet.

