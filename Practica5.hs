
grafo n l = grafo2 n [] l

grafo2 0 _ _ = []
grafo2 n g [] = []
grafo2 n g ((c,a,b):xs) = if (c=="une") then [True] ++ (grafo2 (pred n) (g++[(a,b)]) xs) else (busca a b g)++(grafo2 n g xs)


busca _ _ [] = []
busca na nb ((a,b):xs)
                    |((na==a)&&(nb==b)) = [True]
                    |(na==a)= busca b nb (xs++[(a,b)])
                    |otherwise = [False]



