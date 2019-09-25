# Prova Finale di Reti Logiche - A.A 2018-2019
Scopo del progetto è quello di implementare un componente hardware descritto in VHDL in grado di risolvere un problema che consiste nel determinare l'insieme di punti più vicini a quello dato in esame secondo la definizione di [Manhattan Distance](https://en.wikipedia.org/wiki/Taxicab_geometry).

## Definizione Del Problema
Viene dato uno spazio quadrato di dimensione 256x256 e le posizioni di 8 punti all'interno di questo, chiamati __centroidi__, che saranno quelli di cui calcolare la distanza una volta conosciuta anche la posizione del punto in esame. Considerando ulteriori dettagli relativi alla gestione dei punti ([specifiche complete](https://github.com/Megapiro/Progetto-RETI-2019/blob/master/Specifications/Specifica%20_PFRL.pdf)), l'implementazione del componente è stata realizzata interfacciandosi a una __memoria__ contenente tutte le informazioni relative al problema e utilizzando appositi __segnali__.

## Implementazione
L'[implementazione](https://github.com/Megapiro/Progetto-RETI-2019/blob/master/project_piazza_piro.vhd) del componente consiste principalmete nella realizzazione di una macchina a stati in grado di determinare per ciascuno dei __centroidi__ la distanza dal punto in esame.

La valutazione delle distanze avviene negli stati centrali della macchina che definiscono un ciclo in modo tale che per ciascuno dei punti, in caso la distanza sia minima, venga aggiornata una sola volta la __maschera__ di output che verrà comparata con il risultato corretto in modo da valutare l'esecuzione del componente.

## Test Bench
L'insieme di test utilizzato per la realizzazione del componente è contenuto all'interno del __[test bench](https://github.com/Megapiro/Progetto-RETI-2019/blob/master/test_bench.vhd)__ in cui ciascun caso è individuato da un nome caratteristico; ad esempio, il test fornito dalle specifiche è identificato dal commento: <br /> `-- come da esempio su specifica`. 

L'insieme di test è stato realizzato a partire da quello della specifica andando a identificare i casi che spingono l'esecuzione verso condizioni critiche così da verificare la completa correttezza del sistema, non essendo a disposizione dei test privati utilizzati per la valutazione.

Tra i test sviluppati per sforzare il componente in situazioni particolari, i più significativi vengono chiamati:
  * Maschera di ingresso nulla: 00000000
  * Punti coincidenti in un angolo (256x256)
  * Distanza massima
  * __Reset__ asincrono
  
Infine per poter garantire una maggiore robustezza sono stati utilizzati anche numerosi test randomici in modo tale da cercare di coprire tutti i possibili cammini di esecuzione della macchina a stati.  

## Sviluppatori
[Giorgio Piazza](https://github.com/giorgiopiazza)

[Francesco Piro](https://github.com/Megapiro)
