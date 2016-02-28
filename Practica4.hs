-- comprime 
comprime [] = []
comprime xs = aux 1 xs
    where aux n (x:y:zs) | x == y = aux (n+1) (y:zs) 
                         | otherwise = (x,n): aux 1 (y:zs)
          aux n [x] = [(x,n)]

-- hanoi

hanoi n a b c = display (zipWith (++) (lista n) (hanoi' n a b c))
                where lista n = [(show x)++".-" | x <- [1..(pred (2^n))]]
                      display n = mapM_ (\(a) -> putStrLn $ a) n

hanoi' 0 _ _ _ = []
hanoi' n a b c = (hanoi' (n-1) a c b)++["mueve aro " ++ (show n) ++ " de " ++ (a) ++" a " ++ (c)]++(hanoi' (n-1) b a c)

-- premuta

borraElemento e [] = []
borraElemento e (x:xs) = if (e==x) then xs else x:borraElemento e xs

permuta [] = [[]]
permuta l = [x:xs | x <- l, xs <- permuta (borraElemento x l)]
