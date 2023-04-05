use context essentials2021
include lists

#  my-len
fun my-len(l :: List):
  cases(List) l:
    | empty => 0
    | link(f, r) => 1 + my-len(r)
  end
where:
  my-len([list: 1, 2, 3]) is 3
  my-len([list: ]) is 0
end

# my-sum
fun my-sum(l :: List):
  cases(List) l:
    | empty => 0
    | link(f, r) => f + my-sum(r)
  end
where:
  my-sum([list: 2, 5, 7]) is 14
  my-sum([list: ]) is 0
end

# my-str-len
fun my-str-len(l :: List<String>):
  cases(List) l:
    | empty => empty
    | link(f, r) => link(string-length(f), my-str-len(r))
  end
where:
  my-str-len([list: "veysel", "selma"]) is [list: 6, 5]
  my-str-len([list: "", "selma"]) is [list: 0, 5]
  my-str-len([list: ]) is [list: ]
end

# my-pos-nums
fun my-pos-nums(l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      if f > 0:
        link(f, my-pos-nums(r))
      else:
        my-pos-nums(r)
      end
  end
where:
  my-pos-nums([list: 1, -8, 5, -1, 0]) is [list: 1, 5]
  my-pos-nums([list: ]) is [list :]
end

# Suppose num-max were not built int.
fun num-maxv2(x :: Number, y :: Number) -> Number:
  doc: "Determines which value is bigger"
  if x > y:
    x
  else if x == y:
    x
  else:
    y
  end
where:
  num-maxv2(1, 0) is 1
  num-maxv2(2,74) is 74
end

# my-max
fun my-max(l :: List) -> Number:
  cases(List) l:
    | empty => raise("not defined for empty lists")
    | link(f, r) => 
      cases(List) r:
        | empty => f
        | else => num-max(f, my-max(r))
      end
  end
where:
  my-max([list: 10, 11, 5, 21]) is 21
  my-max([list: ]) is raise("not defined for empty lists")
end

# my-alternating
fun my-alternating(l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      cases (List) r: # note: deconstructing r, not l
        | empty =>    # the list has an odd number of elements
          [list: f]
              | link(fr, rr) =>
                # fr = first of rest, rr = rest of rest
                link(f, my-alternating(rr))
      end
  end
end

# my-avg
fun my-avg(l):
  cases(List) l:
    | empty => raise("error")
    | else => my-sum(l) / my-len(l)
  end
where:
  my-avg(empty) is raise("error")
  my-avg([list: 1,5,6]) is 4
end


# my-running-sum
fun my-rs(acc :: Number, l :: List<Number>):
  cases(List) l:
    | empty => empty
    | link(f,r) =>
      new-sum = acc + f
      link(new-sum, my-rs(new-sum, r))
  end
end

fun my-runngin-sum(l):
  my-rs(0, l)
end

#  my-alternating with accumulator
fun my-alt(l :: List<Number>, keep :: Boolean) -> List<Any>:
  cases(List) l:
    | empty => empty
    | link(f, r) =>
      if keep:
        link(f, my-alt(r, false))
      else:
        my-alt(r, true)
      end
  end
where:
  my-alt([list: 1, 2, 3, 4, 5], true) is [list: 1, 3, 5]
end

fun my-alternatingv2(r):
  my-alt(r, true)
end
  
# my-max with accumulator
fun my-maks(l :: List<Number>, acc :: Number) -> Number:
  cases(List) l:
    | empty => acc
    | link(f, r) =>
      if f > acc:
        my-maks(r, f)
      else:
        my-maks(r, acc)
      end
  end
where:
  my-maks([list: 1, 2, 8, 4], 0) is 8
end

fun my-maxv2(l):
  my-maks(l, 0)
end

# uniq: Code
fun uniq-rec(l :: List<Any>) -> List<Any>:
  cases(List) l:
    | empty => empty
    | link(f, r) =>
      if r.member(f):
        uniq-rec(r)
      else:
        link(f, uniq-rec(r))
      end
  end
where:
  uniq-rec([list: 1, 2, 1, 3]) is [list: 2, 1, 3]
end
  
# my-member couln't be done

# uniq: Reducing Computation
fun uniq-rec2(l :: List<Any>) -> List<Any>:
  cases(List) l:
    | empty => empty
    | link(f, r) =>
      ur = uniq-rec(r)
      if r.member(f):
        ur
      else:
        link(f, ur)
      end
  end
where:
  uniq-rec2([list: 1, 2, 1, 3]) is [list: 2, 1, 3]
end
