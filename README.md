# Dansk Øvelse

En samling af ting der kan hjælpe man at lære dansk.

Der er ikke noget særligt afhængigheder, undtagen core Ruby.

## `./verb-leg` – øv dine verber

Givet en infinitiv, man skal bøje verbet til nutid, datid, og førnutid former.

Der kan være mere end en korrekt svar, så man skal bare give et korrekt svar.

Svar kan gives i flere former:

 - det hele ord
   (fx "går", "gik", "overskrevet")
 - "-" (der står for infinitiven) plus slutningen
   (fx "-r", "-de", "-t")
 - "..." (der står for den længste del af infinitiven som muligt,
   der tillader stadigvæk en overlapning), så slutningen
   (fx givet "at overskrive", "...skrev" bliver "overskrev";
   givet "at færdiggøre", "...gjort" bliver "færdiggjort")

Svaret "-r, -de, -t" betyder selvfølgelig gruppe 1. Dette svar er så
almindeligt, så der er endnu et andet svar: man kan bare indtast "1".

## `./dump` / `Makefile`

Kan bruges at tjekke, at den list af verber er i orden.  Kør `make clean ; make`.

