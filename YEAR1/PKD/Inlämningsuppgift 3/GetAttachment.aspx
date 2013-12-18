Totalt 64p (K)

Seriöst försök: +20

Tester: +30

Klarar alla testfall utom två, som testa huruvida compress/decompress kan hantera tomma strängar respektive tomma listor.

Kommentarer/stil: +5

- compress behöver inga bieffekter eftersom ordboken inte syns utanför compress.
- När ni skriver funktionen build definierar ni en anonym funktion i onödan. Uttrycket (fn x => E[x]) i, där E är ett ägodtyckligt context, är samma sak som E[i].
- Eftervillkoret till compress' måste referera till ordbok, förvillkoret måste referera till ordbok och n, och förvillkoret för compress' kommer inte alltid att fortsätta gälla för rekursiva anrop.
- decompress behöver inte heller några bieffekter av samma anledning. Dessutom uppdateras vektorn aldrig på ett sätt som alstras bieffekter: det är funktionell uppdatering som görs på vektorer, till skillnad från imperativ uppdatering som i hashtabeller.
- varianten för decompress kan skrivas "|l|" helt enkelt, fast det är decompress' och inte decompress som behöver en.
- förvillkoret till decompress räcker inte riktigt. Vad händer t ex om vi kör decompress([97,4000])?
- det är väldigt olämpligt att tomma platser i er vektor i decompress innehåller strängen "NONE", eftersom "NONE" också skulle kunna vara ett värde som en riktigt kod mappar till (t ex i komprimeringen av strängen "NOANONBNONENONE"), vilket leder till att ni stoppar fel koder i vektorn. Ta till exempel strängen "NOANONCNONENONEQEN". Om vi komprimerar den och sedan avkomprimerar den borde vi få tillbaka samma sträng, men vi tillbaka "NOANONCNONENONEQEE" istället!
- Eftervillkoret till decompress' beskriver vad som händer och inte vad ni får tillbaka, eftersom ni talar om hur k används under rekursionen istället för hur ursprungsvärdet av k påverkar det värde som slutligen returneras. Dessutom behöver ni få med n och k i eftervillkoret + en hel drös förvillkor.

Analys: +9

Vector.tabulate(n,f) är inte alltid linjär med avseende på n - om f(m) är annat än konstant med avseende på m så blir det krångligare. Motsvarande gäller såklart för map också.

"Alla ovan nämnda funktioner som går i konstant tid" - men ni kom ju fram till att vissa av funktionerna tar mer än konstant tid? o_O

Vad jag kan se stämmer det ändå att ni kan anta att de tar konstant tid i just erat fall, men det bör isåfall motiveras tydligt varför. Särskilt med tanke på hacket där längden på listans första element växer får vissa rekursiva anrop - i och med det borde man väl kunna tänka sig att första elementet innehåller t ex häften av ursprungslistan, så att tiden för era strängkonkateneringar blir linjära? Varför slipper ni undan sånt?

Rekursionen får decompress' stämmer inte riktigt med hur funktionen gör (längden på strängen k, och således kostnaden för strängkonkateneringen, är omvänt proportionell mot n istället för att alltid vara lika med n), men är en ok modell ändå.

Hursomhelst, rekursionen ni ställer upp blir kvadratisk, inte linjär, mot m.

Dispositionen är dessutom lite bakvänd: det ni skrivit i slutsatsen om vad worst case är borde snarare vara utgångspunkten för analysen än resultatet.

