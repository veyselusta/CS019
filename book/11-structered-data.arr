use context essentials2021
# 11.2.3 Defining and Creating Conditional Data
data ITunesSong : song(name :: String, singer :: String, year :: Number) end

data TColor: 
  | Red
  | Yellow
  | Green
end

data Animal : 
  | boa(name :: String, length :: Number)
  | armadillo(name :: String, liveness :: Boolean)
end

b1 :: Animal = boa("Ayisha", 10)
b2 :: Animal = boa("Bonito", 2)
a1 :: Animal = armadillo("Glypto", true)

# 11.3.1 Extracting Fields from Structured Data
fun song-age(s :: ITunesSong) -> Number:
  2022 - s.year
where:
  song-age(song("ss", "xx", 2005)) is 17
end

# 11.3.2 Telling Apart Variants of Conditional Data
fun advice(color :: TColor) -> String:
  cases (TColor) color:
    | Red => "Wait Mate"
    | Yellow => "get ready"
    | Green => "go"
  end
where:
  advice(Red) is "Wait Mate"
  advice(Yellow) is "get ready"
end

# 11.3.3 Processing Fields of Variants
fun animal-name(a :: Animal) -> String:
  cases (Animal) a:
    | boa(n, l) => n
    | armadillo(n, l) => n
  end
where: 
  animal-name(b1) is "Ayisha"
  animal-name(b2) is "Bonito"
  animal-name(a1) is "Glypto"
end
