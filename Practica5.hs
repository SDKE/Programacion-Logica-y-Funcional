grafo 0 _ = []
grafo n l = revisa(head l) ++ (grafo (pred n) (tail l))
            where revisa (c,a,b) = if(c=="une") then [True] else [False]
