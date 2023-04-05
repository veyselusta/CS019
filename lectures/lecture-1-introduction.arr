use context essentials2021
data Insect: 
  | spider(w)
  | centipede(n)
end


i1 = spider(false)
i2 = centipede("Millie")

fun name(i):
  
  cases (Insect) i:
    | spider(web) => "don't know"
    | centipede(n) => n
  end
end

check: 
  name(i1) is "don't know"
  name(i2) is "Millie"
end


fun len(l):
  cases (List) l:
    | empty => 0
    | link(f, r) => 1 + len(r)
  end
end

check:
  len(empty) is 0
  len(link(5, empty)) is 1
end
