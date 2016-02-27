borraElemento e [] = []
borraElemento e (x:xs) = if (e==x) then xs
						else x:borraElemento e xs

permuta [] = [[]]
permuta l = [x:xs | x <- l, xs <- permuta (borraElemento x l)]
