---------------------------------------------------------------------
-- Name: Tyler Bartlett
-- Class:CS360 Fall 2018
-- Class time: 1300-1350
-- Date: 11/18/18
-- Project #: Lab 4 Intro pt2
-- Driver Name: NA
-- Program Description: 
--		
--		
-- Test Oracle: NA
--				
-- NOTES:
--		Stephan Kemper and I worked together
--
-- RESOURCES:
--      CS262 labs: http://www.wou.edu/~morses/classes/cs360/haskell/index.html
--      http://learnyouahaskell.com
--      
---------------------------------------------------------------------

-- Lab 5 Q1: Implement the greatest common divisor algorithm
    gcdMine :: Integral a => a -> a -> a
    gcdMine x y 
        | y == 0 = x --if y = 0, return x
        | x == 0 = y --if x = 0, return y
        | x < 0 || y < 0 = -1 -- an error value is returned
        | otherwise = gcdMine y remainder
        where remainder = x `rem` y

    gcdCheck x y = (myAnswer, correctAnswer, comment)
      where 
        myAnswer      = gcdMine x y
        correctAnswer = gcd x y
        comment       = if myAnswer == correctAnswer then "Matches" else "Does not Match"
    -- output of gcdCheck 111 259 == (37,37,"Matches")
    -- output of gcdCheck 2945 123042 == (1,1,"Matches"))
    -- output of gcdCheck (2*5*7) (7*23) == (7,7,"Matches")

-- Lab 5 Q2: Write a function to compute Fibonacci numbers
    fibonacci :: Int -> Int
    fibonacci n
        | n == 0 = 0 -- F(0) = 0
        | n == 1 = 1 -- F(1) = 1
        | otherwise = result
        where result = fibonacci (n-1) + fibonacci (n-2)
    -- output of fibonacci 3 = 2
    -- output of [fibonacci n | n <- [0..20]] == 
    --  [0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765]

-- Lab 5 Q3: Write a function that counts how many items are found in a list that match the one given:
    count :: (Eq a, Num b) => a -> [a] -> b
    count _ [] = 0 -- if the list is empty return 0
    count a (x:xs)
        | a == x = 1 + cxs
        | otherwise = cxs
        where cxs = count a xs

    -- output of count 7 [1,7,6,2,7,7,9] == 3
    -- output of count 'w' "western oregon wolves" == 2

-- Lab 5 Q5: Rewrite your answer for Lab 3 question 2 (sanitize) using recursion. 
-- You can't use a list comprehension and you can't use the concat function.
    -- Lab 3 Q2: URL's are not allowed to contain spaces. Write a Haskell function that takes
    -- a string, and replaces any space characters with the special code %20. For example:
    -- sanitize "http://wou.edu/my homepage/I love spaces.html" 
    -- == "http://wou.edu/my%20homepage/I%20love%20spaces.html"
    --sanitize :: String -> String

---------------------------------------------------------------------

-- Lab 6 Q1: answer 5 questions using functions provided
    -- a. Multiply every element of a list by 10
    times10 :: Int -> Int
    times10 x = x * 10

    listTimes10 :: [Int] -> [Int]
    listTimes10 xs = map times10 xs 

    -- d. Subtract 10 from every element in a list.
    listSubtract10 :: [Int] -> [Int]
    listSubtract10 xs = map (subtract 10) xs


    --f. Tell you True or False whether or not a list contains the number 55.
    contains55 :: [Int] -> Bool
    contains55 xs = any (55==) xs

    --g. Tell you True or False whether or not a list contains a value that is divisible by 42
    divBy42 :: [Int] -> Bool
    divBy42 (x:xs) = any (x `div` 42 ==) xs

    -- h. Remove all elements at the beginning of a list of booleans that are not True
    --removeFalse :: [a] -> [a]
    --removeFalse (x:xs) = dropWhile (False) xs
    
    -- e. Remove all spaces from a string
    removeSpaces :: String -> String
    removeSpaces x = filter (/=' ') x

    -- Lab 6 Q2: Choose two functions and rewrite as lambda functions
    -- a. plus x y = x + y
    lamPlus :: Int -> Int -> Int
    lamPlus = (\x -> (\y -> x + y))
    
    --b. (*4)
    lamMultBy4 :: Int -> Int
    lamMultBy4 = (\x -> (x * 4))

-- Lab 6 Q4: Use a Lambda expression and map to take a list of tuples and produce a list of values.
-- The list contains the lengths of two sides of right triangles, a and b. You want to produce a 
-- list that contains the lengths of all three sides, where the third side, c, is found with the
-- Pythagorean theorem.

    pythagList = map (\(a, b) -> (a, b, sqrt (a**2 + b**2)))
    -- output of pythagList [(3,4),(5,16),(9.4,2)] 
    -- = [(3.0,4.0,5.0),(5.0,16.0,16.76305461424021),(9.4,2.0,9.610411021387172)]

---------------------------------------------------------------------


