use context essentials2021
include math

fun overlap(doc1 :: List<String>, doc2 :: List<String>) -> Number:
  doc: "Consumes 2 documents, returns their overlap"
  
  unique-words=distinct(doc1 + doc2).sort()
  vec1 = vector(unique-words, doc1)
  vec2 = vector(unique-words, doc2)
  
  sum(dot-product(vec1, vec2)) / 
  num-max(
    num-sqr(num-sqrt(sum(dot-product(vec1, vec1)))), 
    num-sqr(num-sqrt(sum(dot-product(vec2, vec2))))
    )
where: 
  # overlap
  overlap([list: "a", "b"], [list: "c"]) is 0
  overlap([list: "a"], [list: "a"]) is
  1 / num-max(num-sqr(num-sqrt(1)), num-sqr(num-sqrt(1)))
  overlap([list: "a", "b", "c"], [list: "c", "b", "a"]) is-roughly 1

  # dot-product
  dot-product([list: ], [list: ]) is empty
  dot-product([list: 0, 0], [list: 1, 2]) is [list: 0, 0]
  dot-product([list: 1, 0, 2], [list: 1, 1, 3]) is [list: 1, 0, 6]
  
  # vector
  vector([list: "a", "b"], [list: "a"]) is [list: 1,0]
  vector([list: "a", "b"], [list: "b"]) is [list: 0,1]
  vector([list: "a", "b", "c"], [list: "b", "c", "c", "c"]) is [list: 0, 1,3]
  vector([list: "a", "b", "c"], [list: "b"]) is [list: 0, 1, 0]
  vector([list: "a", "b", "c"], [list: "c", "b"]) is [list: 0, 1, 1]

  # counter
  counter([list: "b"], "b") is 1
  counter([list: "a", "b", "b", "b", "b"], "b") is 4
  counter([list: "a", "b", "c"], "b") is 1       
end

fun dot-product(vec1 :: List<Number>, vec2 :: List<Number>) -> List<Number>:
  doc: "Compute the distance between two list of words"
  cases (List) vec1:
    | empty => empty
    | link(f, r) =>
      cases (List) vec2:
        | empty => empty
        | link(ff, rr) =>
          link((f * ff), dot-product(r, rr))
      end
  end
end
  
fun vector(unique-words :: List<String>, main-doc :: List<String>) -> List<Number>:
  doc: "Make a vector for a given doc which is list of strings"
  cases (List) unique-words:  
    | empty => empty
    | link(f, r) => 
      link(counter(main-doc, f), vector(r, main-doc))
  end  
end
  
fun counter(l :: List<String>, s :: String) -> Number:
  doc: "Count the repeated strings"
  cases (List) l:
    | empty => 0
    | link(f, r) =>
      if f == s:
        1 + counter(r, s)
      else:
        counter(r, s)
      end
  end
end 