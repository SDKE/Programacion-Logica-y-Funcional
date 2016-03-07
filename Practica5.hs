grafo n xs = grafo' n xs [0..(n-1)]
grafo' _ [] _ =[]
grafo' n ((com,a,b):xs) ds= if(com=="une")then True: (grafo' n xs (une a b ds))
else (conectados a b ds):grafo' n xs ds 

une a b ds=une' (fs a ds) (fs b ds) ds 0

une' a b (x:xs) c= if(c==a) then (b:xs)
 else x:une' a b (xs) (c+1)
 
conectados a b ds = if((fs a ds)==(fs b ds)) then True
 else False

fs i ds=if((arreglo ds i 0)==i) then i
 else fs (arreglo ds i 0) ds
 
arreglo (x:xs) i n=if(i==n) then x
 else arreglo (xs) i (n+1)



