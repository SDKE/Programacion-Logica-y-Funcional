-- funcion comprime 
comprime [] = []
comprime xs = aux 1 xs
    where aux n (x:y:zs) | x == y = aux (n+1) (y:zs) 
                         | otherwise = (x,n): aux 1 (y:zs)
          aux n [x] = [(x,n)]

-- torres de hanoi con instrucciones en string
hanoi 0 a b c = putStr ""
hanoi n a b c = do (hanoi (n-1) a c b)
                   putStrLn ("mueve aro " ++ (show n) ++ " de " ++ (show a) ++" a " ++ (show c))
                   (hanoi (n-1) b a c)
-- premutaciones de una lista
borraElemento e [] = []
borraElemento e (x:xs) = if (e==x) then xs else x:borraElemento e xs

permuta [] = [[]]
permuta l = [x:xs | x <- l, xs <- permuta (borraElemento x l)]
