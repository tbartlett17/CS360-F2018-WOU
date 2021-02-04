---------------------------------------------------------------------
-- Name: Tyler Bartlett
-- Class:CS360 Fall 2018
-- Class time: 1300-1350
-- Date: 11/11/18
-- Project #: Lab 4
-- Driver Name: NA
-- Program Description: 
--		
--		
-- Test Oracle: NA
--				
-- NOTES:
--		Jacob Mcleod and I worked together
--
-- RESOURCES:
--      CS262 labs: http://www.wou.edu/~morses/classes/cs360/haskell/index.html
--      http://learnyouahaskell.com
--      
---------------------------------------------------------------------

-- Lab 1 Q1 from CS262 is to setup a Haskell installation
--     I installed Haskell

-- Lab 1 Q2 from CS262 is following along with baby's fist functions
-- and type out some of the examples 
    doubleMe x = x + x
    doubleUs x y = doubleMe x + doubleMe y
    doubleSmallNum x = if x > 100
                        then x
                        else doubleMe x
    -- this is equivalent to the above but adds 1 to all numbers
    doubleSmallNum' x = (if x > 100 then x else doubleMe x) + 1 
    mario = "Where are you princess Peach!?"
    
-- Lab 1 Q3 from CS262 is calculate squareroot of
-- 818281336460929553769504384519009121840452831049  
    sqrtBigNum = sqrt 818281336460929553769504384519009121840452831049 
    --returns 9.045890428592033e23

-- Lab 1 Q4 from CS262: What is the ASCII character that comes before uppercase A?
    predA = pred 'A' 
    -- returns @

 -- Lab 1 Q4 from CS262: What is a function that evaluates to True or False, that tells 
 --you whether or not three times a number plus one is even? Try it out on a couple numbers.
    checkEvenness x = if ((x * 3) + 1) `mod` 2 == 0
                then True
                else False
    -- outputs: 1 = true, 2 = false, 3 = true
---------------------------------------------------------------------

-- Lab 2 Q2: What is the product of all the odd numbers one to one hundred?
    prodOddOneToHund = product [x | x <- [1..100], x `mod` 2 == 1] 
    -- returns a very large value

-- Lab 2 Q3: Use list operation functions like head, tail, last, etc. to find the greatest 
-- number in the following list, that is not the first or last number. i.e. if the first 
--and last numbers don't count, then what is the largest number in the "middle" of the list?
-- [99,23,4,2,67,82,49,-40]
    cutHead x = tail x -- returns a list of elements without the head
    cutTail x = init x -- retunrs a list of elements except its last element
    findLargest = maximum (cutHead(cutTail([99,23,4,2,67,82,49,-40])))
    -- returns largest element in a list (82)

-- Lab 2 Q4: Using the list construction operator, :, and the empty list, [], write an expression
-- to construct a list like this: [6,19,41,-3], i.e. don't just write the list, construct it.
    constructList = 6:19:41:(-3):[]

-- Lab 2 Q5: Write Haskell expressions that use list comprehensions to solve the following problems.
    -- 1. What are the first 27 even numbers? Use the even function and be Lazy!
    twentySevenFirstEvens = take 27 [x | x <- [1..100], x `mod` 2 == 0]
    --twentySevenFirstEvens' = take 27 even [1..100]
    -- returns [2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54]

    -- 2. Provide a list of all odd numbers less than 200 that are divisible by 3 and 7.
    oddsDivByThreeNSeven = [x | x <-[1..200], x `mod` 3 == 0 && x `mod` 7 == 0]
    -- returns [21,42,63,84,105,126,147,168,189]

    -- 3. How many odd numbers are there between 100 and 200 and that are divisible by 9?
    hundToTwoHundDiv9 = length [x | x <-[100..200], x `mod` 9 == 0]
    --returns 9

    -- 5. Count how many negative numbers there are in a list of numbers.
    countNegs xs = length [x | x <- xs, x < 0]
    -- [(-1),0,12,(-2),7,(-7),(-100),15] returns 4 

-- Lab 2 Q6: Use zip, Texas ranges and concatenation, to create a list of Hexadecimal mappings
-- like this: [(0,'0'),(1,'1'),(2,'2'),(3,'3'),(4,'4'),(5,'5'),(6,'6'),(7,'7'),(8,'8'),(9,'9'),
-- 	(10,'A'),(11,'B'),(12,'C'),(13,'D'),(14,'E'),(15,'F')]
    hexPairs = zip [0..15] (['0'..'9'] ++ ['A'..'F'])    
    -- returns a list of hex tuples
---------------------------------------------------------------------

-- Lab 3 Q1: Write a function that uses list comprehensions to generate a list of lists
-- that works like this:
-- makeList 3 == [[1],[1,2],[1,2,3]]
-- makeList 5 == [[1],[1,2],[1,2,3],[1,2,3,4],[1,2,3,4,5]]
-- makeList (-2) == []
    makeList :: Int -> [[Int]]
    makeList xs = [[1..x] | x <-[1..xs]]
    -- output matched example

-- Lab 3 Q2: URL's are not allowed to contain spaces. Write a Haskell function that takes
-- a string, and replaces any space characters with the special code %20. For example:
-- sanitize "http://wou.edu/my homepage/I love spaces.html" 
-- == "http://wou.edu/my%20homepage/I%20love%20spaces.html"
    sanitize :: String -> String
    sanitize st = [c | c <- st, c <- if ( c== ' ') then "%20" else [c] ]
    -- output matches given example

-- Lab 3 Q4: Choose 5 of the following functions, look up their type signature with :t 
-- in ghci. Write it down. Then look at the your type class hierarchy from the previous
-- question and write down a few concrete types that it will work with.
-- (*), (++), min, length, take, null, head, sqrt, (>), succ, div, or
-- intersperse (do :m Data.List first in ghci to load the needed module)

-- NOTE: Since we do not have to do question 3, i assume all we are doing on Q4 is 
-- just to look up  types for five of the functions listed 
    -- (*) :: Num a => a -> a -> a
    -- maximum :: (Foldable t, Ord a) => t a -> a
    -- null :: Foldable t => t a -> Bool
    -- sqrt :: Floating a => a -> a

---------------------------------------------------------------------

-- Lab 4 Q1: For the following, implement using pattern matching of parameters
    -- a. A function that associates the integers 0 through 3 with "Heart", "Diamond",
    -- "Spade", and "Club", respectively. For any other integer values it is an error.
    getSuit :: Int -> String
    getSuit 0 = "Heart"
    getSuit 1 = "Diamond"
    getSuit 2 = "Spade"
    getSuit 3 = "Club"
    getSuit x = "error: no suite available"
    
    -- b. A function that computes the dot product of two 3D vectors (tuples). 
    -- Follow the Algebraic Definition.
    dotProduct :: (Double,Double,Double) -> (Double,Double,Double) -> Double
    dotProduct (x1, y1, z1) (x2, y2, z2) = x1 * x2 + y1 * y2 + z1 * z2

    -- c. A function that reverses the order of the first three elements in a list. 
    -- If the list has fewer than 3 items then reverse the first two, or if it only has 
    -- one element or is empty, leave it as is. If it has more then 3 elements then reverse 
    -- the first 3 as asked and leave the remainder of the list as it is. 
    reverseFirstThree :: [a] -> [a]
    reverseFirstThree [] = []
    reverseFirstThree (x:y:[]) = (y:x:[])
    reverseFirstThree (x:y:z:[]) = (z:y:x:[])
    --reverseFirstThree (x:y:z:_) = (z:y:x:_)
    -- i cant figure out how to account for lists greater than length 3. i feel like 
    -- the above line should be the answer based off the reading but i cant compile 

-- Lab 4 Q2: For the following, implement using guards
    -- a.  Write a function that will tell you how warm or cold it feels like outside given 
    -- a temperature in Fahrenheit. You can make up the ranges (at least 4) but if you call it 
    -- with a temperature of (-45.3) it should tell you it is "frostbite central!".
    feelsLike :: Double -> String
    feelsLike f -- f for Fahrenheit
        | f >= 80.0 = "Too hot for my tastes."
        | f >= 60.0 = "My comfort zone."
        | f >= 33.0 = "it's pretty chilly"
        | f >= 0.0 = "It's freezing!"
        | f > (-45.3) = "I can't feel my fingers!"
        | otherwise = "Frostbite central!"

    --b. convert to C
    feelsLikeC :: Double -> (Double,String)
    feelsLikeC c -- c for Celcius
        | c >= 80.0 = (((c-32)*5/9), "Text output.")
        | otherwise = (1, "Text output.")


-- Lab 4 Q4: