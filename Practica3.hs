ordenada [] = True
ordenada [x] = True
ordenada (x:y:xs) = (x<=y) && ordenada (y:xs)
