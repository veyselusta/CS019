use context essentials2021
import sets as S
include pick 

# 12.1 Lists as Collective Data
data ITunes: 
| song(name :: String, singer :: String, year :: Number)
end

lver :: ITunes = song("La Vie en Rose", "Édith Piaf", 1945)
so :: ITunes = song("Stressed Out", "twenty one pilots", 2015)
wnkkhs :: ITunes = song("Waqt Ne Kiya Kya Haseen Sitam", "Geeta Dutt", 1959)

song-list :: List<ITunes> = [list: lver, so, wnkkhs]

check:
  song-list.length() is 3
  song-list.first is lver
end

fun oldest-song(sl :: List<ITunes>) -> ITunes:
  cases(List) sl:
    | empty => raise("Error")
    | link(f, r) => 
      cases(List) r:
        | empty => f
        | else =>
          osr = oldest-song(r)
          if osr.year < f.year:
            osr
          else:
            f
          end
      end
  end
where:
  oldest-song([list: lver, so, wnkkhs]) is lver
end

fun oldest-song-age(sl :: List<ITunes>) -> Number:
  song-age(oldest-song(sl))
where:
  oldest-song-age([list: lver, so, wnkkhs]) is 77
end

fun song-age(s :: ITunes) -> Number:
  2022 - s.year
where:
  song-age(lver) is 77
end

# 12.2 Sets as Collective Data

song-set = [S.set: lver, so, wnkkhs]

check:
  song-set2 = [S.set: so, lver, wnkkhs]
  song-set is song-set2
end

check:
  song-set3 = [S.set: lver, so, wnkkhs, so, so, lver, so]
  song-set is song-set3
  song-set3.size() is 3
end

# Run an-elt to see what you get
fun an-elt(s :: S.Set):
  cases (Pick) s.pick():
    | pick-none => raise("empty set")
    | pick-some(e, r) => e
  end
where:
  is-ITunes(an-elt(song-set)) is true
end


# 12.2.2 Computing with Sets

fun my-set-size(shadow s :: S.Set) -> Number:
  cases (Pick) s.pick():
    | pick-none => 0
    | pick-some(e, r) =>
      1 + my-set-size(r)
  end
where: 
  my-set-size(song-set) is 3
end

# The tail recursion version which I made up
fun my-set-sizev2(shadow s :: S.Set, acc :: Number) -> Number:
  cases (Pick) s.pick():
    | pick-none => acc
    | pick-some(e, r) =>
      my-set-sizev2(r, (acc + 1))
  end
where: 
  my-set-sizev2(song-set, 0) is 3
end

# 12.3 Combining Structured and Collective Data

# Structured Data
data Question:
    basic-ques(text :: String, expect :: Any)
end

# Conditional Data
data Questionv2:
  | basic-quesv2(text :: String, expect :: Any)
  | hint-quesv2(text :: String, expect :: Any, hint :: String)
end

# A quiz is a list of List<Question> Collective Data

# We could imagine extending this example to introduce dependencies
# between questions (such as one problem building on the skills of another), 
# multiple choice questions, checkbox questions, and so on.

data Questionv3:
  | basic-quesv3(text :: String, expect :: Answer)
  | hint-quesv3(text :: String, expect :: Answer, hint :: String)
end

data Answer:
  | A
  | B
  | C
  | checkbox(b :: Boolean)
end
