ordenada [] = True
ordenada [x] = True
ordenada (x:y:xs) = (x<=y) && ordenada (y:xs)

{- mergeSort -}
mergeSort l = if((length l)>1) then mezcla (mergeSort l1) (mergeSort l2) else l
    where (l1, l2) = separa l
  
separa l = (take n l, drop n l)
    where n = (length l) `div` 2 

mezcla [] l = l
mezcla l [] = l
mezcla (x:xs) (y:ys) = if(x<y) then x:(mezcla xs (y:ys)) else y:(mezcla (x:xs) ys)

{- FolsSeLaCome (quickSort) -}

quickSort [] = []
quickSort (x:xs) = quickSort [y | y <- xs, y <= x] ++ [x] ++ quickSort [y | y <- xs, y > x]
