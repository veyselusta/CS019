use context essentials2021
# 3 5 8 7 1 = 1 3 5 7 8
# 1 3 5 4 2 = 1 2 3 4 5
# 3 3 3 = 3 3 3 
# empty = empty
# 1 0 -1 = -1 0 1
# 1 2 3 = 1 2 3

# you gonna need data definitions from strach like list - data list = | empty | link(f, r)

# templating steps / why it exists / mapping of a plan what you're gonna do

# we have generated code for free without even thinking, it just fell out from that structure of data
# indepented of the problem we are trying to solve

# drive the structure of the program from the structure of the data, this is the central idea of oop
# fun list(l : List<Number>)
#   | empty
#   | link(f, r)
# end

fun insertion-sort(l :: List<Number>) -> List<Number>:
  cases (List<Number>) l:
    | empty => empty
    | link(f, r) => 
      insert(f, insertion-sort(r))
      end 
where:
  sort(empty) is empty
  sort([list: 3, 3, 3]) is [list: 3, 3, 3]
end

# *consumes sorted list so this is our contract

fun insert(n :: Number, l :: List<Number>) -> List<Number>:
  cases (List<Number>) l:
    | empty => link(n, empty)
    | link(f, r) => 
      if n <= f:
        link(n, l)
      else:
        link(f, insert(n, r))
      end
  end
where:
  insert(5, [list: 2, 3, 4]) is [list: 2, 3, 4, 5]
  insert(2, [list: 3, 4, 5]) is [list: 2, 3, 4, 5]
  insert(1, [list: 0, 1, 1, 2]) is [list: 0, 1, 1, 1, 2]
  insert(-1, [list: -2, 0, 3]) is [list: -2, -1, 0, 3]
  insert(3, empty) is [list: 3]
  insert(4, [list: 1, 2, 3]) is [list: 1, 2, 3, 4]
  # insert(2, [link: 5, 4, 3]) is not an example, it's doesn't match our *contract
end
