import Data.Tree
import Test.HUnit

data Arbol a = Nulo | Nodo a (Arbol a) (Arbol a) deriving (Show,Eq)

test1 = TestCase (assertEqual "Checking depthFirstPath ejemploArbol" "acfl"(depthFirstPath 'l' ejemploArbol))
test2 = TestCase (assertEqual "Checking breadthFirstPath ejemploArbol" "acfl"(breadthFirstPath 'l' ejemploArbol))
tests = TestList [TestLabel "test1" test1, TestLabel "test2" test2]


depthFirstPath a Nulo = []
depthFirstPath a (Nodo n Nulo Nulo)
    |(a == n) = [a]
    |otherwise = []
depthFirstPath a (Nodo n izq der)
    |(a == n) = [a]
    |(elem a (depthFirst izq)) = n:(depthFirstPath a izq)
    |(elem a (depthFirst der)) = n:(depthFirstPath a der)
    |otherwise = []

breadthFirstPath a t = breadthFirstPath' a [t]
breadthFirstPath' a [] = []
breadthFirstPath' a (Nulo:xs) = breadthFirstPath' a xs
breadthFirstPath' a ((Nodo n Nulo Nulo):xs)
    |(a==n) = [a]
    |otherwise = breadthFirstPath' a xs
breadthFirstPath' a (Nodo n izq der:xs)
    |(a==n) = [a]
    |(elem a (breadthFirst izq)) = n:breadthFirstPath' a (xs++[izq])
    |(elem a (breadthFirst der)) = n:breadthFirstPath' a (xs++[der])
    |otherwise = []

breadthFirst arbol = bf [arbol]
bf [] = []
bf (Nulo:xs) = bf xs
bf ((Nodo r izq der):xs) = r:bf(xs++[izq,der])

depthFirst Nulo = []
depthFirst (Nodo a Nulo Nulo) = [a]
depthFirst (Nodo a izq der) = [a]++(depthFirst izq)++(depthFirst der)

ejemploArbol = Nodo 'a' (Nodo 'b' 
                                 (Nodo 'd' (Nodo 'h' Nulo Nulo) (Nodo 'i' Nulo Nulo)) 
                                 (Nodo 'e' (Nodo 'j' Nulo Nulo) (Nodo 'k' Nulo Nulo)))
                        (Nodo 'c' 
                                 (Nodo 'f' (Nodo 'l' Nulo Nulo) (Nodo 'm' Nulo Nulo)) 
                                 (Nodo 'g' (Nodo 'n' Nulo Nulo) (Nodo 'o' Nulo Nulo)))