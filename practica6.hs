import Data.Tree

data Arbol a = Nulo | Nodo a (Arbol a) (Arbol a) deriving (Show,Eq)

hoja x = Nodo x Nulo Nulo

t0 = Nulo
t1 = Nodo 17 (Nodo 12 (Nodo 5 Nulo (hoja 8)) (hoja 15)) Nulo
t2 = Nodo 17 (Nodo 12 (Nodo 5 Nulo (hoja 8)) (hoja 15))
             (Nodo 115
                   (Nodo 32 (hoja 30) (Nodo 46 Nulo (hoja 57)))
                   (hoja 163))

t3 = Nodo 17 Nulo (Nodo 115
                   (Nodo 32 (hoja 30) (Nodo 46 Nulo (hoja 57)))
                   (hoja 163))

pict t = putStr (pic "" t)
         where pic ind Nulo = ind ++ "."
               pic ind (Nodo x tl tr) = pic ('\t':ind) tr ++ "\n" ++
                                 ind ++ show x     ++ "\n" ++
                                        pic ('\t':ind) tl ++ "\n"

eliminaNodo n Nulo = Nulo 
eliminaNodo n (Nodo r hi Nulo) | (n==r) = hi 
eliminaNodo n (Nodo r Nulo hd) | (n==r) = hd
eliminaNodo n (Nodo r hi hd)
    | n<r  = Nodo r (eliminaNodo n hi) hd 
    | n>r  = Nodo r hi (eliminaNodo n hd)  
    | n==r = Nodo r' (eliminaNodo r' hi) hd
              where r' = menor hi 
 
menor (Nodo r _ Nulo) = r
menor (Nodo _ _ hd)        = menor hd 
