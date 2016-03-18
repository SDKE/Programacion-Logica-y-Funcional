import Data.Tree

data Arbol a = Nulo | Nodo a (Arbol a) (Arbol a) deriving (Show,Eq)

hoja x = Nodo x Nulo Nulo

t2 = Nodo 17 (Nodo 12 (Nodo 5 Nulo (hoja 8)) (hoja 15))
             (Nodo 115
                   (Nodo 32 (hoja 30) (Nodo 46 Nulo (hoja 57)))
                   (hoja 163))

pict t = putStr (pic "" t)
         where pic ind Nulo = ind ++ "."
               pic ind (Nodo x tl tr) = pic ('\t':ind) tr ++ "\n" ++
                                 ind ++ show x     ++ "\n" ++
                                        pic ('\t':ind) tl ++ "\n"

// Funcion esHoja
esHoja _ Nulo = False
esHoja _ (Nodo r Nulo Nulo) = True
esHoja n (Nodo r hi hd) 
     | (n<r) = (esHoja n hi)
     | (n>r) = (esHoja n hd)
     | otherwise = False

// Funcion eliminaNodo
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

// Funcion distancia
distancia _ _ Nulo = error "No hay nodos"
distancia x y (Nodo r hi hd) = distancia' x y 0 (Nodo r hi hd)

distancia' x y z (Nodo r hi hd) = (distancia1 x (Nodo r hi hd)) + (distancia2 y (Nodo r hi hd)) - (2*(distancia3 z (Nodo r hi hd)))
     where z = ancestro x y (Nodo r hi hd)

distancia1 _ Nulo = error "El nodo no esta"
distancia1 x (Nodo r hi hd) = distanciaAux1 x (Nodo r hi hd) 0

distanciaAux1 x (Nodo r hi hd) c
    | (x<r) = distanciaAux1 x hi (c+1)
    | (x>r) = distanciaAux1 x hd (c+1) 
    | otherwise = c

distancia2 _ Nulo = error "El nodo no esta"
distancia2 y (Nodo r hi hd) = distanciaAux2 y (Nodo r hi hd) 0

distanciaAux2 y (Nodo r hi hd) c
    | (y<r) = distanciaAux2 y hi (c+1)
    | (y>r) = distanciaAux2 y hd (c+1) 
    | otherwise = c

distancia3 _ Nulo = error "El nodo no esta"
distancia3 z (Nodo r hi hd) = distanciaAux3 z (Nodo r hi hd) 0

distanciaAux3 z (Nodo r hi hd) c
     | (z<r) = distanciaAux3 z hi (c+1)
     | (z>r) = distanciaAux3 z hd (c+1)
     | otherwise = c

ancestro _ _ Nulo = error "No hay nodos"
ancestro x y (Nodo r hi hd) 
     | (y<r) = ancestro x y hi
     | (x>r) = ancestro x y hd
     | otherwise = r

// Funcion estaOrdenado
estaOrdenado Nulo = True
estaOrdenado (Nodo r hi hd) = mayorTodos r hi && menorTodos r hd && 
                      estaOrdenado hi && estaOrdenado hd

menorTodos r Nulo = True 
menorTodos r a        = r < minimum (elementos a)
 
mayorTodos r Nulo = True 
mayorTodos r a = r > maximum (elementos a)

elementos Nulo = []
elementos (Nodo r hi hd) = elementos hi ++  r:elementos hd
