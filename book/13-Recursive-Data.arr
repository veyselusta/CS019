use context essentials2021
# 13 Recursive Data

data NumList: 
  | nl-empty 
  | nl-link(first :: Number, rest :: NumList)
end

recursive-data = 
nl-link(1,
  nl-link(2,
    nl-link(3,
      nl-link(4,
        nl-link(5,
          nl-link(6,
            nl-link(7,
              nl-link(8,
                  nl-empty))))))))


# 13.1 Functions to Process Recursive Data

fun contains-3(nl :: NumList) -> Boolean:
  doc: "Produces true if the list contains 3, false otherwise"
  cases (NumList) nl:
    | nl-empty => false
    | nl-link(first, rest) =>
      if first == 3:
        true
      else:
        contains-3(rest) 
  end
  end
where:
  contains-3(nl-empty) is false
  contains-3(nl-link(3, nl-empty)) is true
  contains-3(nl-link(2, nl-link(3, nl-empty))) is true
  contains-3(nl-link(1, nl-link(2, nl-link(3, nl-link(4, nl-empty))))) is true
  contains-3(nl-link(1, nl-link(2, nl-link(5, nl-link(4, nl-empty))))) is false
end

# 13.2 A Template for Processing Recursive Data

#|
fun num-list-fun(nl :: NumList) -> ???:
  cases (NumList) nl:
    | nl-empty => ...
    | nl-link(first, rest) =>
      ... first ...
      ... num-list-fun(rest) ...
  end
end
|#


# Exercise: Use the design recipe to write a function contains-n that takes
#           a NumList and returns whether that number is in the NumList.

fun contains-n(nl :: NumList, n :: Number) -> Boolean:
  cases (NumList) nl:
    | nl-empty => false
    | nl-link(first, rest) =>
      if n == first:
        true
      else:
        contains-n(rest, n)
      end
  end
where:
  contains-n(nl-empty, 5) is false
  contains-n(nl-link(1, nl-link(2, nl-link(5, nl-empty))), 5) is true
end

# Exercise: Use the design recipe to write a function sum that takes a NumList, 
#           and returns the sum of all the numbers in it. The sum of the empty list is 0.

fun sum(nl :: NumList) -> Number:
  cases (NumList) nl:
    | nl-empty => 0
    | nl-link(first, rest) => first + (sum(rest))
  end
where:
  sum(nl-empty) is 0
  sum(nl-link(3, nl-empty)) is 3
  sum(nl-link(2, nl-link(3, nl-empty))) is 5
  sum(nl-link(1, nl-link(2, nl-link(3, nl-link(4, nl-empty))))) is 10
  sum(nl-link(1, nl-link(2, nl-link(5, nl-link(4, nl-empty))))) is 12
end


# Exercise: Use the design recipe to write a function remove-3 that takes a NumList, 
#           and returns a new NumList with any 3's removed. The remaining elements 
#           should all be in the list in the same order they were in the input.

fun remove-3(nl :: NumList) -> NumList:
  cases (NumList) nl:
    | nl-empty => nl-empty
    | nl-link(first, rest) =>
      if first == 3:
        remove-3(rest)
      else:
        nl-link(first, remove-3(rest))
  end
  end
where:
  remove-3(nl-empty) is nl-empty
  remove-3(nl-link(3, nl-empty)) is nl-empty
  remove-3(nl-link(2, nl-link(3, nl-empty))) is nl-link(2, nl-empty)
  remove-3(nl-link(1, nl-link(2, nl-link(3, nl-link(4, nl-empty))))) is nl-link(1, nl-link(2, nl-link(4, nl-empty)))
  remove-3(nl-link(1, nl-link(2, nl-link(5, nl-empty)))) is nl-link(1, nl-link(2, nl-link(5, nl-empty)))
end

# Exercise: Write a data definition called NumListList that represents a list of NumLists,
#            and use the design recipe to write a function sum-of-lists that takes
#            a NumListList and produces a NumList containing the sums of the sub-lists

type NumListList = List<NumList>

fun sum-of-numlistlist(l :: NumListList) -> NumList<Number>:
  cases (NumListList) l:
    | empty => nl-empty
    | link(first, rest) => nl-link(sum-of-numlist(first), sum-of-numlistlist(rest))
  end
where:
  sum-of-numlistlist(empty) is nl-empty
  sum-of-numlistlist([list: nl-link(1, nl-link(2, nl-empty)), nl-link(5, nl-empty)]) is nl-link(3, nl-link(5, nl-empty))
end
    
# 

fun sum-of-numlist(nl ::  NumList) -> Number:
  cases (NumList) nl:
    | nl-empty => 0
    | nl-link(first, rest) => first + sum-of-numlist(rest)
  end
where:
  sum-of-numlist(nl-empty) is 0
  sum-of-numlist(nl-link(1, nl-link(5, nl-empty))) is 6
end


# My own exercise: Write a function that takes a List and returns
#                  the List of numbers that are greater than 2

fun greater2(l :: List<Number>) -> List<Number>:
  cases (List) l:
    | empty => empty
    | link(first, rest) => 
      if first > 2:
        link(first, greater2(rest))
      else:
        greater2(rest)          
  end
  end
where:
  greater2([list: 1,3,5,1,0]) is [list: 3,5]
  greater2([list: ]) is [list : ]
  greater2([list: 1]) is [list: ]
  greater2([list: 3, 5, 6, 1]) is [list: 3, 5, 6]
end


