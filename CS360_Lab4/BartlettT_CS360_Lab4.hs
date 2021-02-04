---------------------------------------------------------------------
-- Name: Tyler Bartlett
-- Class:CS360 Fall 2018
-- Class time: 1300-1350
-- Date: 11/20/18
-- Project #: Lab 4
-- Driver Name: NA
-- Program Description: 
--		
-- NOTES:
--		
--
-- RESOURCES:
--      http://learnyouahaskell.com
--      Googling liters to gallons conversion: 0.264172 
--      Googleing CAD to USD conversion rate: $0.75
--      Googled radius of Earth: 6.371 * 10^6 m aka 3959 miles
--      Googled Degrees to Radians: 0.0174533 
--      https://stackoverflow.com/questions/21276844/prime-factors-in-haskell/21277421 (for question 11)
---------------------------------------------------------------------
module Main where 
import System.Environment
import Data.Char
import System.IO

-- Question 1: 
litersToGallons :: Fractional a => a -> a
litersToGallons x = x * 0.264172 -- 1L == 0.264172gal

cadTOusd :: Fractional a => a -> a
cadTOusd x = x * 0.75 -- 1 CAD == 0.75 USD on 11/20/2018 10:38pm

price :: Fractional a => a -> a -> a
price x y = (cadTOusd y) / (litersToGallons x)

-- Input: price 62.3 78.4
-- Output:3.5727489087378723
---------------------------------------------------------------------

-- Question 2:
degreeToRadian :: RealFloat a => a -> a 
degreeToRadian x = (x * pi) / 180

flightDistance :: (RealFloat a) => (a,a) -> (a,a) -> a
flightDistance (x1,y1) (x2,y2) = a * acos(cos(dx1) * cos(dx2) * cos (dy1 - dy2) + (sin(dx1) * sin(dx2)) )
  where 
    a = 3959 -- radius of earth in m
    dx1 = degreeToRadian x1
    dx2 = degreeToRadian x2
    dy1 = degreeToRadian y1
    dy2 = degreeToRadian y2

-- Input: flightDistance (45,122.6) (21, 158)
-- Output: 2603.164458495462
---------------------------------------------------------------------

-- Question 3:
factorial :: (Integral a) => a -> a
factorial n
    | n == 0 = 1
    | n == 1 = 1
    | n >= 1 = foldl (*) 1 [1..n]
    | otherwise = error "you entered a negative value"
 
 -- input: factorial 99
 -- Output: 9332621544394415268169923885626670049071596826438162146859296389521759999
 --     32299156089414639761565182862536979208272237582511852109168640000000000000000000000
 ---------------------------------------------------------------------

 -- Question 4:
isEven :: Int -> Bool
isEven x = if x `mod` 2 == 0 
            then True 
            else False

-- Input: 1; Output: False
-- Input: 2; Output: True
---------------------------------------------------------------------

-- Question 5:
sumCubes1000to2000 :: Int
sumCubes1000to2000 = sum [x | x <- map (^3) [1000..2000], isEven x == False]

-- Input: NA
-- Output: 1874999250000
---------------------------------------------------------------------

-- Question 6:
closedForm :: (RealFloat a) => a -> a
closedForm n = (n * (n+1) * (2*n+1)) / 6

summation :: (RealFloat a) => a -> a
summation 0 = 0
summation n = n^2 + summation (n-1)

sumEQcf :: (RealFloat a) => a -> Bool
sumEQcf n = ((closedForm n) == (summation n))

-- Input: sumEQcf 12
-- Output: True
---------------------------------------------------------------------

-- Question 7:
-- list comprehension
count :: Eq a => [a] -> a -> Int
count xs x = length [n | n <- xs, n == x]

-- Input: count [1,2,3,2,5,1,4] 1
-- Output: 2
-- Input: count "western oregon wolves (wow) win winter wrestling" 'w'
-- Output: 7

-- recursion
count' :: Eq a => [a] -> a -> Int
count' (x:xs) y
    | y == x = 1 + count xs y
    | otherwise = count' xs y

-- Input: count [1,2,3,2,5,1,4] 1
-- Output: 2
-- Input: count "western oregon wolves (wow) win winter wrestling" 'w'
-- Output: 7
---------------------------------------------------------------------

-- Question 8
maxList :: (Ord a) => [a] -> a
maxList [] = error "empty list"
maxList [x] = x
maxList (x:xs) = max x (maxList xs)

-- Input: maxList [(-3), 2, 7, 9, 4, (-9), 1, 3]
-- Output: 9
---------------------------------------------------------------------

-- Question 9
removeSpaces :: String -> String
removeSpaces x = filter (/=' ') x
filterEvens :: [Int] -> [Int]
filterEvens xs = filter even xs
listTimes2 :: [Int] -> [Int]
listTimes2 xs = map (*2) xs
contains55 :: [Int] -> Bool
contains55 xs = any (55==) xs
oddList :: [Int] -> Bool
oddList xs = all odd xs

---------------------------------------------------------------------

-- Question 10
isPrime :: Integer -> Bool
isPrime x
    | x == 1 = True
    | x > 1 = (length [xs | xs <- [2..x-1], x `mod`xs  == 0] == 0)
    | otherwise = False

-- 1000:7919, 1001:7927, 1002:7933, 1003:7937, 1004:7949, 1005:7951, 1006:7963, 1007:7993, 1008:8009,1009:8011, 1010:8017,
-- 1011:8039,1012:8053, 1013:8059, 1014:8069, 1015:8081, 1016:8087, 1017:8089, 1018:8093, 1019:8101, 1020:8111
---------------------------------------------------------------------

-- Question 11

-- I am not sure how to do factoring function. I got this from Stack Overflow.
primeFactors  :: Integer -> [Integer]
primeFactors 1 = []
primeFactors n
  | factors == []  = [n]
  | otherwise = factors ++ primeFactors (n `div` (head factors))
  where factors = take 1 $ filter (\x -> (n `mod` x) == 0) [2 .. n-1]

elimDuplicates :: Eq a => [a] -> [a]
elimDuplicates [] = []
elimDuplicates (x:xs)
    | x `elem` xs = elimDuplicates xs
    | otherwise = x : elimDuplicates xs

factor x = elimDuplicates (primeFactors x)

-- 175561 : [419], 62451532000 : [2,5,11,13,23,47,101]
---------------------------------------------------------------------

-- Question 12
main :: IO ()
main = do
args <- getArgs
print $ factor (read (head args)::Integer)

-- Compiled per lab instructions and ran it. I changed 'PartI' to match my file name
-- Output: [2,7,11,37]
