comprime [] = []
comprime (x:xs) = comprime' x 1 [] xs

comprime' ca cont lista [] = lista ++ [(ca,cont)]
comprime' ca cont lista (x:xs) = if (ca==x) then comprime' ca (succ cont) lista xs else comprime' x 1 (lista ++ [(ca,cont)]) xs

hanoi n a b c = putStr (muestra (zip [1..] (hanoi' n a b c)))

hanoi' 0 _ _ _ = []
hanoi' n a b c = (hanoi' (n-1) a c b)++[(n,a,c)]++(hanoi' (n-1) b a c)

muestra [] = []

muestra ((nu,(aro,ti,tf)):xs) = (show nu) ++ ".- mueve " ++ (show aro) ++ " de " ++ ti ++ " a "++ tf ++ "\n" ++ (muestra xs)

borra _ [] = []
borra e (x:xs) = if(x==e) then xs else x:(borra e xs)

permuta [] = [[]]
permuta  l = [x:resto | x <- l, resto <- permuta(borra x l)]
