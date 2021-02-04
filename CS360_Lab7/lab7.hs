module Lab7
(
    length'
) where 

-- Imports and function definitions follow..
import Data.Char
-- Lab 7 Q1: Trace out the execution of each expression, as was done in class, and show how
-- they are different.foldl (*) 6 [5,3,8] and foldr (*) 6 [5,3,8]

-- foldl (*) 6 [5,3,8]          foldr (*) 6 [5,3,8]
-- (((6 * 5) * 3) * 8)          (5 * (3 * (8 * 6)))
-- ((30 * 3) * 8)               (5 * (3 * 48))
-- (90 * 8)                     (5 * 144)
-- 720                          720

-- Lab 7 Q2: Write your own version of "length :: [a] -> Int" using a fold.
-- Export this function from your module.
length' :: [a] -> Int
length' xs = foldr (\_ n -> 1 + n) 0 xs

-- Lab 7 Q3: Write two functions, one that uses a left fold and one that uses a right fold, to imitate the behavior of this map
-- map intToDigit [5,2,8,3,4] == "52834"
convertIntToStringLeft :: [Int] -> [Char]
convertIntToStringLeft xs = foldl "" (intToDigit xs)
    
    --convertIntToStringRight :: [Int] -> [Char]


-- Lab 7 Q4: 


-- Lab 7 Q5: 

