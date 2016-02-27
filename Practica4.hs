permuta [] = [[]]
permuta (x:xs) = [zs | ys <- permuta xs, zs <- intercala x ys]

intercala e [] = [[e]]
intercala e (x:xs) = (e:x:xs) : [(x:ys) | ys <- (intercala e xs)]
